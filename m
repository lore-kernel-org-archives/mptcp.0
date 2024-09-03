Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAD205E1F
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350711; cv=none; b=BmGWmIdKWO8HbcqgAwWcGjmsDI+q/uV3ICe/mus6bDBcpiIHRrovD1RCphbKHd6TrssRznau2ZL+DtUZOkCM6SkFoTDcrYoNmbHOs1ZsfXFinIOFp6MyQNTRadux6V7tokQzQhUY0htrlUE/oZ3oeQV5U6q14BhSxg4PM/zNfd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350711; c=relaxed/simple;
	bh=2zoj9L0O/GSybtYkl/vHnS8JQ1/n2Tg3DY2FQ0e64yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxZVoJ8MY8bTHrT/oVvERThpgL4CcgnEO7MWby4OcBCpe/XbXDj+3wgE8u58EVsvcHyasNkUVazHod7ITupcuvLgbP9/KML97omwuIO1YmNwVKxLlRYv2WCrkp7eWm4f1OMduONtYNiVF0JeZzb6W0LP4JjXVdtfqgdfYyMnldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWshAXyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWshAXyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFF5C4CEC8;
	Tue,  3 Sep 2024 08:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350711;
	bh=2zoj9L0O/GSybtYkl/vHnS8JQ1/n2Tg3DY2FQ0e64yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWshAXyKNaDWhK268r+s7iWPrwb9D6u7iqnQFOOfwHB/En3MVEsUrs1VyPO4yp3mz
	 /5/rqkDPIZV+JrXPkA+qNz/rQF0Bw9QTPcut2lBGdrfveRoWzl4Rr6VpVIE+zVcvGN
	 juNacpRoq7kG19x+PCxeNQHcAssGqndJNDyMry+eHtei01kNl1e4aneEfPGy0Wx1kn
	 t49aP9Lycd2d5UN5QQFs/81ieiKS/zbfymDyWraTrYvzXlPSlQIFBa9gOvzFhUWzsv
	 HSyBgqMoQ3yAuyEQA45TYNyPA/OV1mvrEXaN0VIVTXU+LVOIp5IxJ29DX62+z8KG6Y
	 xhQdRuMRfJpMw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v7 2/4] selftests/bpf: Add getsockopt to inspect mptcp subflow
Date: Tue,  3 Sep 2024 16:04:58 +0800
Message-ID: <2cd5946354c8cf839684274e9ccc52016fbcf717.1725350462.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725350462.git.tanggeliang@kylinos.cn>
References: <cover.1725350462.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a "cgroup/getsockopt" way to inspect the subflows of a
mptcp socket.

mptcp_for_each_stubflow() and other helpers related to list_dentry are
added into progs/mptcp_bpf.h.

Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list and use
bpf_core_cast to cast a pointer to tcp_sock for readonly. It will allow
to inspect all the fields in a tcp_sock.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 27 ++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 90 +++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 782f36ed027e..92d5deed0214 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -4,9 +4,36 @@
 
 #include <vmlinux.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
 
 #define MPTCP_SUBFLOWS_MAX 8
 
+static inline int list_is_head(const struct list_head *list,
+			       const struct list_head *head)
+{
+	return list == head;
+}
+
+#define list_entry(ptr, type, member)					\
+	container_of(ptr, type, member)
+
+#define list_first_entry(ptr, type, member)				\
+	list_entry((ptr)->next, type, member)
+
+#define list_next_entry(pos, member)					\
+	list_entry((pos)->member.next, typeof(*(pos)), member)
+
+#define list_entry_is_head(pos, head, member)				\
+	list_is_head(&pos->member, (head))
+
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_first_entry(head, typeof(*pos), member);	\
+	     cond_break, !list_entry_is_head(pos, head, member);	\
+	     pos = list_next_entry(pos, member))
+
+#define mptcp_for_each_subflow(__msk, __subflow)			\
+	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index 2e28f4a215b5..1053a795eb43 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -4,6 +4,7 @@
 
 /* vmlinux.h, bpf_helpers.h and other 'define' */
 #include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -57,3 +58,92 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 
 	return 1;
 }
+
+static int _check_getsockopt_subflow_mark(struct bpf_sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+	int i = 0;
+
+	if (sk->protocol != IPPROTO_MPTCP) {
+		bpf_printk("MPTCP Subflow: unexpected protocol %u", sk->protocol);
+		return -1;
+	}
+
+	msk = bpf_core_cast(sk, struct mptcp_sock);
+	if (msk->pm.subflows != 1) {
+		bpf_printk("MPTCP Subflow: expected 1 extra subflows, got %u",
+			   msk->pm.subflows);
+		return -1;
+	}
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+
+		if (ssk->sk_mark != ++i) {
+			bpf_printk("MPTCP Subflow: expected %d mark, got %d",
+				   i, ssk->sk_mark);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int _check_getsockopt_subflow_cc(struct bpf_sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+
+	if (sk->protocol != IPPROTO_MPTCP) {
+		bpf_printk("MPTCP Subflow: unexpected protocol %u", sk->protocol);
+		return -1;
+	}
+
+	msk = bpf_core_cast(sk, struct mptcp_sock);
+	if (msk->pm.subflows != 1) {
+		bpf_printk("MPTCP Subflow: expected 1 extra subflows, got %u",
+			   msk->pm.subflows);
+		return -1;
+	}
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct inet_connection_sock *icsk;
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+		icsk = bpf_core_cast(ssk, struct inet_connection_sock);
+
+		if (ssk->sk_mark == 2 &&
+		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX)) {
+			bpf_printk("MPTCP Subflow: expected %s cc, got %s",
+				   cc, icsk->icsk_ca_ops->name);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+SEC("cgroup/getsockopt")
+int _getsockopt_subflow(struct bpf_sockopt *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+
+	if (!sk) {
+		bpf_printk("MPTCP Subflow: unexpected socket, sk is NULL");
+		ctx->retval = -1;
+		return 1;
+	}
+
+	if (ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
+		ctx->retval = _check_getsockopt_subflow_mark(sk);
+	else if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)
+		ctx->retval = _check_getsockopt_subflow_cc(sk);
+
+	return 1;
+}
-- 
2.43.0


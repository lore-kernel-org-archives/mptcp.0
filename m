Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B686CDBA
	for <mptcp@lists.linux.dev>; Fri, 30 Aug 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000943; cv=none; b=h4crlPuzTAenQqdFlbubWUw+efbNXWjNuBAYedn/vLdTumN61Gc4wwizKoyLbhr+PUkKYLWC9eruARlqaP3hh1US/9Z6bslebKByxWxwhX8P3ancFb1sj8FDAN9NycKQXhsGhGTdX0bYiCBBp2RuTLujXLaWQi3R6m12u3rCb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000943; c=relaxed/simple;
	bh=ohfygqKuUjv01EKnOdYA/2vX33PebEzUPnYPyIZi5qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hE2YD6y1Fgo1o4MBX6JXfPtyPheAuE0EKjc6apWnJhJSGdoyls1HLJU2SX1br20mG3LahFPbbhhKMHMd/DIlLdqSQPl/8x7It67DofAxAMcE/Ar+xjkttyPdrLsvFAdcrdoStE3OFQe04kvBtzt58Mbk8ZpH2m9+hosXBOZDiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO3Wa8MV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO3Wa8MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC47C4CEC6;
	Fri, 30 Aug 2024 06:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000943;
	bh=ohfygqKuUjv01EKnOdYA/2vX33PebEzUPnYPyIZi5qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MO3Wa8MVCzCi+0dRSYg3uAku0KywTiAe2R/an6/1oVLn4AeIMY+LwbjU02M4VJu/j
	 f+rihX3EexwsgKs5ZTVGdjHxlNQlWqYqspW67GUTJQZIkBUsVmC3ljicC8kO9hI9++
	 KbOBGj4TIoEpdBBwLYHpON9Spr78kij4C19kIy4nLn0yBCXAwpnw7FBkxdHM3BJlEe
	 n/gmTfylaYya32ZwW+WWFHe72ec3bFCqCQwnXcV9Z5cZrnaQwDTxPp0Pa2ldTfZLcQ
	 Du8ArEFTvoo8pwddk+iLVKFI1WY592UsQAn9sfExmTOaGflkTemr/sY0h1jaA5mg5r
	 G6/weoLBjz0ww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v6 2/4] selftests/bpf: Add getsockopt to inspect mptcp subflow
Date: Fri, 30 Aug 2024 14:55:31 +0800
Message-ID: <0ce049060df256e7376516e4d94af71264a69da0.1725000687.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725000687.git.tanggeliang@kylinos.cn>
References: <cover.1725000687.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 ++++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 69 +++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 782f36ed027e..d60e3c8f85a1 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -4,9 +4,44 @@
 
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
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_first_entry(head, typeof(*pos), member),	\
+		n = list_next_entry(pos, member);			\
+	     cond_break, !list_entry_is_head(pos, head, member);	\
+	     pos = n, n = list_next_entry(n, member))
+
+#define mptcp_for_each_subflow(__msk, __subflow)			\
+	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
+#define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)		\
+	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index 2e28f4a215b5..18396532f016 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -4,6 +4,7 @@
 
 /* vmlinux.h, bpf_helpers.h and other 'define' */
 #include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -57,3 +58,71 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 
 	return 1;
 }
+
+static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	if (msk->pm.subflows != 1) {
+		bpf_printk("subflows=%u", msk->pm.subflows);
+		ctx->retval = -1;
+	}
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+
+		if (ssk->sk_mark != ++i)
+			ctx->retval = -1;
+	}
+
+	return 1;
+}
+
+static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (msk->pm.subflows != 1) {
+		bpf_printk("subflows=%u", msk->pm.subflows);
+		ctx->retval = -1;
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
+		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX))
+			ctx->retval = -1;
+	}
+
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int _getsockopt_subflow(struct bpf_sockopt *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	struct mptcp_sock *msk;
+
+	if (!sk || sk->protocol != IPPROTO_MPTCP) {
+		ctx->retval = -1;
+		return 1;
+	}
+
+	msk = bpf_core_cast(sk, struct mptcp_sock);
+	if (ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
+		return _check_getsockopt_subflow_mark(msk, ctx);
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)
+		return _check_getsockopt_subflow_cc(msk, ctx);
+
+	return 1;
+}
-- 
2.43.0


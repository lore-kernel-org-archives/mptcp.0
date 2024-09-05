Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65031A291
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503233; cv=none; b=GF2fngMKQOO++KGb29Mcn1HoT1GQUdZL+3dQKpK53IG5NbPbKpHyOoJskIZcSwgtBQfYF48vYyDG3YnFWH8mihB1nP05jb3KdlJHg51Ma/VLIMhO2p0UMEozsEbr9jPIWc422vlZVqftsMENXY9cMk9yEUzLM3Szh1AHZZQnFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503233; c=relaxed/simple;
	bh=kF63BG1kfd4wi0jmp68mCE8dz2DQJPjq1voABtLVq38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/zBX1jko5ul7zs51+uaXNInd6QRn62la14CXDmBdqQCgu9Oh7SOBNk/9hV976it4cKMjQiAcmFOF/y7NDGxG44HwjY7edD0herg0PAtvvfv1IBTgqBuGUeoYnqqJaLl43DjQbkAloWqsft8j1QUagOfDAO3lZH3zFO+9GCjfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFZwcGMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFZwcGMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECBAC4CEC6;
	Thu,  5 Sep 2024 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725503233;
	bh=kF63BG1kfd4wi0jmp68mCE8dz2DQJPjq1voABtLVq38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFZwcGMqYS88Ip1gJFKXGJD9NVxfhcBNfKJYimtMpNSlTbAVScM6X+xaEjZZ2W3KB
	 X4bFTbK3kujV4XTnoK3e20+TIMIOg7tVvL9LZP0ZlDxnV/xwZkQ9plmNfaz1LK2WjC
	 prav5hUIOuJikxgL8vqopZEbnrx+BcpFqilea2VMJE8iaZsVY5rp9qaT9bBdsaNYm7
	 uPJakt8zN0J09c5OaOs3vOGtgGsEHT14iCOrDBsDGWjAxZkCMVPf6KL3zzYxQCH9Sz
	 j3MF5RkWTAt4ii7vMHO3fohRp/oGJE/ceS8hT9Y9SBDYMSCdNob6c3FimYBbnWMnD5
	 2CYaeqKvEnyzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v8 2/4] selftests/bpf: Add getsockopt to inspect mptcp subflow
Date: Thu,  5 Sep 2024 10:26:57 +0800
Message-ID: <44ef8e395feddc3fe83c1ea043c3bc07f98c1042.1725502822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725502822.git.tanggeliang@kylinos.cn>
References: <cover.1725502822.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 27 ++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 69 +++++++++++++++++++
 2 files changed, 96 insertions(+)

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
index 2e28f4a215b5..70302477e326 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -4,10 +4,12 @@
 
 /* vmlinux.h, bpf_helpers.h and other 'define' */
 #include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
 
 char _license[] SEC("license") = "GPL";
 
 char cc[TCP_CA_NAME_MAX] = "reno";
+int pid;
 
 /* Associate a subflow counter to each token */
 struct {
@@ -57,3 +59,70 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 
 	return 1;
 }
+
+static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+
+		if (ssk->sk_mark != ++i) {
+			ctx->retval = -2;
+			break;
+		}
+	}
+
+	return 1;
+}
+
+static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
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
+			ctx->retval = -2;
+			break;
+		}
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
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	if (!sk || sk->protocol != IPPROTO_MPTCP ||
+	    (!(ctx->level == SOL_SOCKET && ctx->optname == SO_MARK) &&
+	     !(ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)))
+		return 1;
+
+	msk = bpf_core_cast(sk, struct mptcp_sock);
+	if (msk->pm.subflows != 1) {
+		ctx->retval = -1;
+		return 1;
+	}
+
+	if (ctx->optname == SO_MARK)
+		return _check_getsockopt_subflow_mark(msk, ctx);
+	return _check_getsockopt_subflow_cc(msk, ctx);
+}
-- 
2.43.0


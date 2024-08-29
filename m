Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4534A18
	for <mptcp@lists.linux.dev>; Thu, 29 Aug 2024 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900017; cv=none; b=Dh+IH8XPtXIGLS/IQL1g56cOv32biqf7i6izmXpmZ8eB6N2Gvv3//14IyRwX8AMxLj2jjwppPsMozCaHu6ZI2JzZz0O+9QPpnF29CETNxKhxmKFrFPLQZxFktpTqTkHBBy7cwDJmQ+5+8lyYj4TaEH410Cs78lQtYGG01cYBPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900017; c=relaxed/simple;
	bh=NzUQ3S++aty/5aTnVbCFRohyISGe+0ULmuR2WiWG330=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivFJJqd9upGoxTwsJK/qK6ByVYxIerQKhRB2oYn9sS3YnV8UdeJYvRpwzy6w+lD038bZPaWNuGOYI2w5oqHDcklY7b5Xpb8ycHqdzzahfuzk/u4MFjE/OQUQDLS6RB+3BSJLRb0BNF2ZzVvggi4gzKG0dhzMf/um71I3N6La8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeSYOvVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeSYOvVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EDEC4CEC4;
	Thu, 29 Aug 2024 02:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724900016;
	bh=NzUQ3S++aty/5aTnVbCFRohyISGe+0ULmuR2WiWG330=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QeSYOvVW8ba/WOsNLNYcVLNge+V7M2/7x42nEudquC54lvqnb/NC26Pv680qfOVam
	 nfsFAzlNqSWAp/3LUzHKmybFlN/ZvIgEEw0EUt0ElVoGkXVIrUsLEYwvWiiIj/GsK3
	 vLs6uMbAoZ7PvlVL2qApykoLJd8VMEY3S27ZEfEy2ddo7BR5WPIMmoXLzNIh2i9rMm
	 eKS9QwP3L69qk8QgVoPQmkaJueouxEYvwHAhk8ucYGpF8z1MjLAMXmhdA2llZvWoNU
	 ZGRYowOobsSN1Qac7bOPUr6aQAhTU3rz0q50uCKXDSGgHJZivjNjNH/9DNotuyYpE6
	 QWLkeLRZv43Ww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v5 1/3] selftests/bpf: Add getsockopt to inspect mptcp subflow
Date: Thu, 29 Aug 2024 10:53:25 +0800
Message-ID: <bd9b737530f156c6741d158300e7cb625f39dca2.1724899785.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724899785.git.tanggeliang@kylinos.cn>
References: <cover.1724899785.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 +++++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 62 +++++++++++++++++++
 2 files changed, 97 insertions(+)

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
index bc572e1d6df8..6a7cf71c2795 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -4,6 +4,7 @@
 
 /* vmlinux.h, bpf_helpers.h and other 'define' */
 #include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -57,3 +58,64 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 
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
+		if (ssk->sk_mark != ++i)
+			ctx->retval = -1;
+	}
+
+	return 1;
+}
+
+static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+		struct inet_connection_sock *icsk;
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+		icsk = bpf_core_cast(ssk, struct inet_connection_sock);
+
+		if ((ssk->sk_mark == 1 &&
+		     __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX)) ||
+		    (ssk->sk_mark == 2 &&
+		     __builtin_memcmp(icsk->icsk_ca_ops->name, "cubic", TCP_CA_NAME_MAX)))
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
+	if (!sk || sk->protocol != IPPROTO_MPTCP)
+		return 1;
+
+	msk = bpf_core_cast(sk, struct mptcp_sock);
+	if (msk->pm.subflows != 1)
+		return 1;
+
+	if (ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
+		return _check_getsockopt_subflow_mark(msk, ctx);
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)
+		return _check_getsockopt_subflow_cc(msk, ctx);
+
+	return 1;
+}
-- 
2.43.0


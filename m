Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E13EB7FE
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555400; cv=none; b=AQUInb3a5Ba9P5Gm+aNrV6H9spTxSjQ/iIaSVI84Ciyw5dRNBuCCJAKmvpHR5QnlBf7FMGEtfGt1ge5MPLi4Y/Zy63NYAJnykGz2DdLdS+aQ/ySlcpSkKrZscBj2Is4Jf1aGsAgn7jqLOljnnF45L7Kqig7+F5zLpR4JA8+n9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555400; c=relaxed/simple;
	bh=2dFPEMf9rZlNbHc96HwtCYgyUDee0DJF6TNw0sNNAoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPfDvUhnZI1X6vizMrZCzy35L/xJS0YS+g3BfS10gCiC+Y5Aaufy7HkyW7O1xYsPMiHruLIV8yjP2PUcYMHRj1yDOXp/kHisRbJmzUA53q7VK3VGJ6+K/7RbBaH9oY/kNc8D6/AsPlv/ROVlhmAL9IPjnprhCyRjHaqF6ybsGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS3jKlZH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS3jKlZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C147C1F000E9;
	Mon, 24 Aug 2026 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555398;
	bh=8h+Bdzro69nU+po6hmoBXlafBKmqlWJln6C5cFZc1n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RS3jKlZHNx/0smrnO8OQc+AAQMFBLBz4zK7oazqNb/z87/5bibmgodMoDODgzMla6
	 iuzUcEeVxOmlZ4ax7SYYowfPtjJR6/RuNJ2BV2JyOWzKznOsGT1ZuiuJNIQoLTVkxi
	 8UeSTi/S6iVeOZIojY84p2NblRce1SUT4xYXYsak5mXzPRnfugFCeoWPJYzjzUwDuH
	 ujQg6vBmOGs5IqIoOGD5oSax8Yl9AYuXGGyIuC+nOXYvf7mJBDnOPgyJtPwcOYYG4w
	 ER1SsezayLVo6BB5kQUJ9L9v4gJxZFqjlVzEDyQ4Jp2YdJ1XUmkEE3Aeo/cnj4/0mU
	 QgvkDjDIzlybQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH mptcp-next v4 4/5] mptcp: implement psock_update_sk_prot
Date: Mon, 24 Aug 2026 15:09:38 +0800
Message-ID: <7b7000bec51e276ef4cdb575f02ac5913656b325.1787554581.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787554581.git.tanggeliang@kylinos.cn>
References: <cover.1787554581.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds basic MPTCP support for BPF sockmap by implementing the
psock_update_sk_prot callback (mptcp_bpf_update_proto). This allows MPTCP
sockets to be added to sockmap and enables the sk_skb stream_verdict
redirect path via the read_skb callback. Separate protocol structures are
maintained for IPv4/IPv6 and BASE/TX/RX/TXRX configurations, mirroring
tcp_bpf_update_proto(). The IPv6 variant is lazily rebuilt via
mptcp_bpf_check_v6_needs_rebuild() when the underlying protocol ops change.

Note that unlike TCP, this implementation does not override sendmsg and
recvmsg for the BPF variants. TCP replaces sendmsg with tcp_bpf_sendmsg
to support sk_msg redirect (outbound message-level redirect) and recvmsg
with tcp_bpf_recvmsg to read from the psock ingress queue. MPTCP does
not override these because:

- sendmsg: MPTCP sendmsg dispatches data across multiple subflows via the
  scheduler. Intercepting at the MPTCP level would require coordinating
  sk_msg processing with multi-path scheduling, which is non-trivial.

- recvmsg: MPTCP recvmsg reassembles ordered data from the receive queue
  with sequence tracking. Overriding it to also check the psock ingress
  queue would duplicate significant MPTCP-specific logic.

As a result, sk_msg redirect (msg_parser / msg_verdict) is not supported
for MPTCP sockets. Only sk_skb stream_verdict redirect via the read_skb /
sk_data_ready path is functional.

Export mptcp_sendmsg, mptcp_recvmsg and mptcp_prot from protocol.c so they
can be referenced by bpf.c.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512261144.DxrvwMS3-lkp@intel.com/
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 106 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c |  10 ++--
 net/mptcp/protocol.h |   9 ++++
 3 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 82b0ad25f700..df41f72603c0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/skmsg.h>
 #include <net/bpf_sk_storage.h>
 #include "protocol.h"
 
@@ -361,3 +362,108 @@ static int __init bpf_mptcp_kfunc_init(void)
 	return ret;
 }
 late_initcall(bpf_mptcp_kfunc_init);
+
+enum {
+	MPTCP_BPF_IPV4,
+	MPTCP_BPF_IPV6,
+	MPTCP_BPF_NUM_PROTS,
+};
+
+enum {
+	MPTCP_BPF_BASE,
+	MPTCP_BPF_TX,
+	MPTCP_BPF_RX,
+	MPTCP_BPF_TXRX,
+	MPTCP_BPF_NUM_CFGS,
+};
+
+static struct proto mptcp_bpf_prots[MPTCP_BPF_NUM_PROTS][MPTCP_BPF_NUM_CFGS];
+
+static void mptcp_bpf_rebuild_protos(struct proto prot[MPTCP_BPF_NUM_CFGS],
+				     struct proto *base)
+{
+	prot[MPTCP_BPF_BASE]			= *base;
+	prot[MPTCP_BPF_BASE].destroy		= sock_map_destroy;
+	prot[MPTCP_BPF_BASE].close		= sock_map_close;
+	prot[MPTCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
+
+	prot[MPTCP_BPF_TX]			= prot[MPTCP_BPF_BASE];
+	prot[MPTCP_BPF_RX]			= prot[MPTCP_BPF_BASE];
+	prot[MPTCP_BPF_TXRX]			= prot[MPTCP_BPF_BASE];
+}
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct proto *mptcpv6_prot_saved __read_mostly;
+static DEFINE_SPINLOCK(mptcpv6_prot_lock);
+
+static void mptcp_bpf_check_v6_needs_rebuild(struct proto *ops)
+{
+	/* Load with acquire semantics to ensure we see the latest protocol
+	 * structure before checking for rebuild.
+	 */
+	if (unlikely(ops != smp_load_acquire(&mptcpv6_prot_saved))) {
+		spin_lock_bh(&mptcpv6_prot_lock);
+		if (likely(ops != mptcpv6_prot_saved)) {
+			struct proto *v6_prots;
+
+			v6_prots = mptcp_bpf_prots[MPTCP_BPF_IPV6];
+			mptcp_bpf_rebuild_protos(v6_prots, ops);
+			/* Ensure mptcpv6_prot_saved update is visible before
+			 * releasing lock
+			 */
+			smp_store_release(&mptcpv6_prot_saved, ops);
+		}
+		spin_unlock_bh(&mptcpv6_prot_lock);
+	}
+}
+
+static int mptcp_bpf_assert_proto_ops(struct proto *ops)
+{
+	/* In order to avoid retpoline, we make assumptions when we call
+	 * into ops if e.g. a psock is not present. Make sure they are
+	 * indeed valid assumptions.
+	 */
+	return ops->recvmsg == mptcp_recvmsg &&
+	       ops->sendmsg == mptcp_sendmsg ? 0 : -EOPNOTSUPP;
+}
+#endif
+
+int mptcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock,
+			   bool restore)
+{
+	int family = sk->sk_family == AF_INET6 ? MPTCP_BPF_IPV6 :
+						 MPTCP_BPF_IPV4;
+	int config = psock->progs.msg_parser   ? MPTCP_BPF_TX   :
+						 MPTCP_BPF_BASE;
+
+	if (psock->progs.stream_verdict || psock->progs.skb_verdict)
+		config = (config == MPTCP_BPF_TX) ? MPTCP_BPF_TXRX :
+						    MPTCP_BPF_RX;
+
+	if (restore) {
+		WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
+		/* Pairs with lockless read in sk_clone() */
+		sock_replace_proto(sk, psock->sk_proto);
+		return 0;
+	}
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		if (mptcp_bpf_assert_proto_ops(psock->sk_proto))
+			return -EINVAL;
+
+		mptcp_bpf_check_v6_needs_rebuild(psock->sk_proto);
+	}
+#endif
+
+	/* Pairs with lockless read in sk_clone() */
+	sock_replace_proto(sk, &mptcp_bpf_prots[family][config]);
+	return 0;
+}
+
+static int __init mptcp_bpf_v4_build_proto(void)
+{
+	mptcp_bpf_rebuild_protos(mptcp_bpf_prots[MPTCP_BPF_IPV4], &mptcp_prot);
+	return 0;
+}
+late_initcall(mptcp_bpf_v4_build_proto);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c1e26c6e5c17..7d36dc4fab6e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2030,7 +2030,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2410,8 +2410,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
-static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			 int flags)
+int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
@@ -4277,7 +4276,7 @@ static void mptcp_splice_eof(struct socket *sock)
 	release_sock(sk);
 }
 
-static struct proto mptcp_prot = {
+struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
 	.init		= mptcp_init_sock,
@@ -4309,6 +4308,9 @@ static struct proto mptcp_prot = {
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
 	.splice_eof	= mptcp_splice_eof,
+#ifdef CONFIG_BPF_SYSCALL
+	.psock_update_sk_prot	= mptcp_bpf_update_proto,
+#endif
 };
 
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d5..cc7adeb0b7f6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1377,4 +1377,13 @@ mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subflow_re
 static inline void mptcp_join_cookie_init(void) {}
 #endif
 
+extern struct proto mptcp_prot;
+int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
+int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags);
+
+#ifdef CONFIG_BPF_SYSCALL
+int mptcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock,
+			   bool restore);
+#endif
+
 #endif /* __MPTCP_PROTOCOL_H */
-- 
2.53.0


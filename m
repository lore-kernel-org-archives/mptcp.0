Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36F28B517
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294520; cv=none; b=u96iOMdM2zrSXjcciLMRaEML7UAc35d00Jb/mPmDtOfrjhne7s/4wE0QoU2cEqrpX90rCMgoyy53kfq3Mct4d/stx7sp5hOtIdLD3hEaMvqxLza8ucm7CnS0KAy2wtE4wIZ0h/1/f2Hz2b5/nfJ37uY5pjRtr22gJ16zCHp0Azg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294520; c=relaxed/simple;
	bh=oobUPJEudZmhj9feGhiTdzTJ0VlF2/E9WCWmqUpRlgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRgZkmnaY51zw1Rwuy94HYXUudU0bfOIwq3JmURchbeQF4bx9o+S7ea9nCCMPkfwR6rvzFtB9n2CXE7X6PD29l+P/u9+miAFNE+NtFZmDT5W2BaEOnlc9M14J24XAWsx2Yvg21xrWdiLPYThBumdORbuuTYLeZLn1tdsiPGv0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJpyPBVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJpyPBVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191521F00893;
	Sun, 13 Sep 2026 10:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294518;
	bh=Y/105J6kQOvqY/Q2Tgh/CaBz9o7hdSirjUI8VbCzzts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MJpyPBVcuTOslGk8GmQknOPQYncv940qRCUFe9Uo4zQAdOAfgtMGxhiA5TVrLRzmV
	 Zjh81QcsLzAiOxJldRw2YPmSUhvvEkK17kOYTBHiMDAvSPwIMoqVBvDRPWYjuZZ3YU
	 ih11hrFPVpWBAYycInI+LP/4h7WpL2Tja6ITj8EKIKUvm7tF5RUKMYNGT5dEYTvXQz
	 c0OH4LUe/0w1h3qARh4eGrDM3zehdTPBAzEfHot171lSLIcGAlZXUQdNVOanZ+m/jp
	 BXe5Ue+RB0MgxzqXiM4HqbqpquWCBc2K5k73BwokUQ+0NBoBLhIWwJOlKrDuI/5J65
	 BYuJa4UhMZUaQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH mptcp-next v5 06/16] mptcp: implement psock_update_sk_prot for sockmap
Date: Sun, 13 Sep 2026 18:14:45 +0800
Message-ID: <39ae7a2bebed6f38d02356c7e288a21a70bdd07f.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
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

MPTCP delegates to the original protocol operations so that MPTCP-specific
logic (multi-path scheduling in sendmsg, ordered reassembly in recvmsg) is
preserved. recvmsg is overridden in all BPF configurations with
mptcp_bpf_recvmsg, which checks the psock ingress queue first and falls
back to mptcp_recvmsg via the shared __tcp_bpf_recvmsg() helper. sendmsg
is overridden in the TX/TXRX configurations with mptcp_bpf_sendmsg, which
processes sk_msg redirect before delegating to mptcp_sendmsg via
__tcp_bpf_sendmsg().

Export mptcp_sendmsg, mptcp_recvmsg and mptcp_prot from protocol.c so they
can be referenced by bpf.c.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512261144.DxrvwMS3-lkp@intel.com/
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h    |   5 ++
 net/ipv4/tcp_bpf.c   |  29 +++++++---
 net/mptcp/bpf.c      | 129 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c |  10 ++--
 net/mptcp/protocol.h |  18 ++++++
 5 files changed, 179 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 14baee01c74b..d9c0214328e3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2873,6 +2873,11 @@ static inline void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 
 int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
 			  struct sk_msg *msg, u32 bytes, int flags);
+int
+__tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
+		  int (*recvmsg)(struct sock *, struct msghdr *, size_t, int));
+int __tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size,
+		      int (*sendmsg)(struct sock *, struct msghdr *, size_t));
 #endif /* CONFIG_NET_SOCK_MSG */
 
 #if !defined(CONFIG_BPF_SYSCALL) || !defined(CONFIG_NET_SOCK_MSG)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d5fcf3ce4861..e006131696e9 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -119,7 +119,7 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 
 		bvec_set_page(&bvec, page, size, off);
 		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
-		ret = tcp_sendmsg_locked(sk, &msghdr, size);
+		ret = sk->sk_socket->ops->sendmsg_locked(sk, &msghdr, size);
 		if (ret <= 0)
 			return ret;
 
@@ -364,8 +364,9 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 	return 0;
 }
 
-static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			   int flags)
+int
+__tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
+		  int (*recvmsg)(struct sock *, struct msghdr *, size_t, int))
 {
 	struct sk_psock *psock;
 	int copied, ret;
@@ -378,11 +379,11 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
-		return tcp_recvmsg(sk, msg, len, flags);
+		return recvmsg(sk, msg, len, flags);
 	if (!skb_queue_empty(&sk->sk_receive_queue) &&
 	    sk_psock_queue_empty(psock)) {
 		sk_psock_put(sk, psock);
-		return tcp_recvmsg(sk, msg, len, flags);
+		return recvmsg(sk, msg, len, flags);
 	}
 	lock_sock(sk);
 msg_bytes_ready:
@@ -402,7 +403,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				goto msg_bytes_ready;
 			release_sock(sk);
 			sk_psock_put(sk, psock);
-			return tcp_recvmsg(sk, msg, len, flags);
+			return recvmsg(sk, msg, len, flags);
 		}
 		copied = -EAGAIN;
 	}
@@ -414,6 +415,12 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	return ret;
 }
 
+static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			   int flags)
+{
+	return __tcp_bpf_recvmsg(sk, msg, len, flags, tcp_recvmsg);
+}
+
 static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 				struct sk_msg *msg, int *copied, int flags)
 {
@@ -530,7 +537,8 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	return ret;
 }
 
-static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
+int __tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size,
+		      int (*sendmsg)(struct sock *, struct msghdr *, size_t))
 {
 	struct sk_msg tmp, *msg_tx = NULL;
 	int copied = 0, err = 0, ret = 0;
@@ -544,7 +552,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
-		return tcp_sendmsg(sk, msg, size);
+		return sendmsg(sk, msg, size);
 
 	lock_sock(sk);
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
@@ -618,6 +626,11 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	return copied > 0 ? copied : err;
 }
 
+static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
+{
+	return __tcp_bpf_sendmsg(sk, msg, size, tcp_sendmsg);
+}
+
 enum {
 	TCP_BPF_IPV4,
 	TCP_BPF_IPV6,
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 82b0ad25f700..662b80ce2cf6 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/skmsg.h>
 #include <net/bpf_sk_storage.h>
 #include "protocol.h"
 
@@ -361,3 +362,131 @@ static int __init bpf_mptcp_kfunc_init(void)
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
+static int mptcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			     int flags)
+{
+	return __tcp_bpf_recvmsg(sk, msg, len, flags, mptcp_recvmsg);
+}
+
+static int mptcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
+{
+	return __tcp_bpf_sendmsg(sk, msg, size, mptcp_sendmsg);
+}
+
+static void mptcp_bpf_rebuild_protos(struct proto prot[MPTCP_BPF_NUM_CFGS],
+				     struct proto *base)
+{
+	prot[MPTCP_BPF_BASE]			= *base;
+	prot[MPTCP_BPF_BASE].destroy		= sock_map_destroy;
+	prot[MPTCP_BPF_BASE].close		= sock_map_close;
+	prot[MPTCP_BPF_BASE].recvmsg		= mptcp_bpf_recvmsg;
+	prot[MPTCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
+
+	prot[MPTCP_BPF_TX]			= prot[MPTCP_BPF_BASE];
+	prot[MPTCP_BPF_TX].sendmsg		= mptcp_bpf_sendmsg;
+
+	prot[MPTCP_BPF_RX]			= prot[MPTCP_BPF_BASE];
+
+	prot[MPTCP_BPF_TXRX]			= prot[MPTCP_BPF_TX];
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
+void mptcp_bpf_clone(const struct sock *sk, struct sock *newsk)
+{
+	struct proto *prot = newsk->sk_prot;
+
+	if (is_insidevar(prot, mptcp_bpf_prots))
+		newsk->sk_prot = sk->sk_prot_creator;
+}
+
+static int __init mptcp_bpf_v4_build_proto(void)
+{
+	mptcp_bpf_rebuild_protos(mptcp_bpf_prots[MPTCP_BPF_IPV4], &mptcp_prot);
+	return 0;
+}
+late_initcall(mptcp_bpf_v4_build_proto);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a19e494c609..3d3c5af7c266 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2185,7 +2185,7 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	int ret;
 
@@ -2436,8 +2436,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
-static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			 int flags)
+int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
@@ -3795,6 +3794,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	if (!nsk)
 		return NULL;
 
+	mptcp_bpf_clone(sk, nsk);
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (nsk->sk_family == AF_INET6)
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
@@ -4298,7 +4299,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 }
 
-static struct proto mptcp_prot = {
+struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
 	.init		= mptcp_init_sock,
@@ -4329,6 +4330,7 @@ static struct proto mptcp_prot = {
 	.obj_size	= sizeof(struct mptcp_sock),
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
+	.psock_update_sk_prot	= mptcp_bpf_update_proto,
 };
 
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3f8997f15bec..ae1e9ab78724 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1393,4 +1393,22 @@ mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subflow_re
 static inline void mptcp_join_cookie_init(void) {}
 #endif
 
+extern struct proto mptcp_prot;
+int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags);
+int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
+
+#ifdef CONFIG_BPF_SYSCALL
+int mptcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock,
+			   bool restore);
+void mptcp_bpf_clone(const struct sock *sk, struct sock *newsk);
+#else
+static inline int
+mptcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void mptcp_bpf_clone(const struct sock *sk, struct sock *newsk) {}
+#endif
+
 #endif /* __MPTCP_PROTOCOL_H */
-- 
2.53.0


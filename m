Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5381E572F
	for <mptcp@lists.linux.dev>; Thu, 25 Dec 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766653236; cv=none; b=hTWtq/RNYSrumGq4tYSV5S0koZe/B2AzhDsfvR68XwGa1uU4pDsjgv7UqFWwuWTPq2jyhDH9weTqrVE/fEELky+ym9PuPPWGKpyUtNljnLpxuruSli+eUjTuUoj1lLouh6bthGdF+ChXP+TRdjPAoYRfvV1dO+JSVtYMHGla+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766653236; c=relaxed/simple;
	bh=meNGbmUxDP7UxSRwCDVF2He6SDpTk4kPVqfZZrz/ASw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEM9pdGds41PIOwhKbskYmnW8rZUN9uwYVYkgiDWYVQO8d5Z6iZXsgrA7InQNCU8Dm2cr+A1PCr6x8xgEhurpHLJHDTflhc6owt1/piTottopyqPjl5+QHIyB76km+/CTaAILI0EVPi4goE5r5ZWGSE3RiZ2sYTdry/mE4l0jo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4wDVpAx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4wDVpAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997A0C116C6;
	Thu, 25 Dec 2025 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766653235;
	bh=meNGbmUxDP7UxSRwCDVF2He6SDpTk4kPVqfZZrz/ASw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4wDVpAxQq76lj5PfzJH9XsdhnpiQ55JK/G4hPAeQgDfk6kZBCX2kcd2BO+yehMxq
	 lNNTuuet6vyfVhTeAA5YactfRMO7l60d2rpe3WdcrjAOor5SaxuyJlVJqQBUfoSgCf
	 OIspnvCos1+aYNDD3AyTs2lTV0SKNugKIdLiUfuUwndDARj12Zgw1FkpGD27s6FIYt
	 HsdfBSgdLJZgiZ21gnl6veV2dK4iv12H6ZNJyXWzCBLSM8yqnrTynbLrTdyBbEu+Kt
	 5j9tm+Ik96TxP4GM6uGG5qtzm5RIABP9MihTDkQWslRnl9m8xMUeTrNNk4wClxY0al
	 hNlKxsJ/9Z5cg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] mptcp: implement psock_update_sk_prot
Date: Thu, 25 Dec 2025 16:59:56 +0800
Message-ID: <f2508c5923c4ed365d6c12800e43a16761ed615a.1766653030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766653030.git.tanggeliang@kylinos.cn>
References: <cover.1766653030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add MPTCP support for BPF sockmap by implementing psock_update_sk_prot
callback. This allows MPTCP sockets to dynamically switch protocol
handlers when attached to or detached from sockmap programs. Separate
protocol structures are maintained for IPv4/IPv6 and TX/RX configurations.

tcp_bpf_update_proto() in net/ipv4/tcp_bpf.c is a frame of reference for
this patch.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 96 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 900f26e21acd..d8fb71301bb4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <linux/skmsg.h>
 #include <net/aligned_data.h>
 #include <net/rps.h>
 #include <net/sock.h>
@@ -4017,6 +4018,91 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 }
 
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
+static struct proto *mptcpv6_prot_saved __read_mostly;
+static DEFINE_SPINLOCK(mptcpv6_prot_lock);
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
+	prot[MPTCP_BPF_TXRX]			= prot[MPTCP_BPF_TX];
+}
+
+static void mptcp_bpf_check_v6_needs_rebuild(struct proto *ops)
+{
+	/*
+	 * Load with acquire semantics to ensure we see the latest protocol
+	 * structure before checking for rebuild.
+	 */
+	if (unlikely(ops != smp_load_acquire(&mptcpv6_prot_saved))) {
+		spin_lock_bh(&mptcpv6_prot_lock);
+		if (likely(ops != mptcpv6_prot_saved)) {
+			mptcp_bpf_rebuild_protos(mptcp_bpf_prots[MPTCP_BPF_IPV6], ops);
+			/* Ensure mptcpv6_prot_saved update is visible before releasing lock */
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
+	return ops->recvmsg  == mptcp_recvmsg &&
+	       ops->sendmsg  == mptcp_sendmsg ? 0 : -EOPNOTSUPP;
+}
+
+static int mptcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
+{
+	int family = sk->sk_family == AF_INET6 ? MPTCP_BPF_IPV6 : MPTCP_BPF_IPV4;
+	int config = psock->progs.msg_parser   ? MPTCP_BPF_TX   : MPTCP_BPF_BASE;
+
+	if (psock->progs.stream_verdict || psock->progs.skb_verdict)
+		config = (config == MPTCP_BPF_TX) ? MPTCP_BPF_TXRX : MPTCP_BPF_RX;
+
+	if (restore) {
+		sk->sk_write_space = psock->saved_write_space;
+		/* Pairs with lockless read in sk_clone_lock() */
+		sock_replace_proto(sk, psock->sk_proto);
+		return 0;
+	}
+
+	if (sk->sk_family == AF_INET6) {
+		if (mptcp_bpf_assert_proto_ops(psock->sk_proto))
+			return -EINVAL;
+
+		mptcp_bpf_check_v6_needs_rebuild(psock->sk_proto);
+	}
+
+	/* Pairs with lockless read in sk_clone_lock() */
+	sock_replace_proto(sk, &mptcp_bpf_prots[family][config]);
+	return 0;
+}
+
 static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
@@ -4048,8 +4134,18 @@ static struct proto mptcp_prot = {
 	.obj_size	= sizeof(struct mptcp_sock),
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
+#ifdef CONFIG_BPF_SYSCALL
+	.psock_update_sk_prot	= mptcp_bpf_update_proto,
+#endif
 };
 
+static int __init mptcp_bpf_v4_build_proto(void)
+{
+	mptcp_bpf_rebuild_protos(mptcp_bpf_prots[MPTCP_BPF_IPV4], &mptcp_prot);
+	return 0;
+}
+late_initcall(mptcp_bpf_v4_build_proto);
+
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
-- 
2.51.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997EB3A0B28
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741515; cv=none; b=uQAz9fxhuF756+tdK2YCJoh2vnDKyn76kKzylOgT1V/OvJ8xQGPnDZdiaX5n6ZGR3DSEUzZGex71fGJiIdNuHANX4QcZKxue9fb2sGVRJQQGtzmQgn57VnjLcxBgyv61Rj3GamfJEN4hBEL54nsQMs3qo9Ss6lE3F2QX5C05jsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741515; c=relaxed/simple;
	bh=pPca3w6b7ndhzs+4hEVBpxOHFxwGlQtNuRRiPizzXaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1xOZPb3Mna4hwX4W2gK77+/qaGC9aiAQp9qvuyYzF1/SRuyVb/qaLeKLqSJJHbGeCFYxbSEhRr+rBBOq36TEdtHYPGPytjhKRaCNglN0TqZuAUCuYcH3S5J914I/NgiArj9sTz+1jlNioAViLE6Mg3yVEZQd5zJm0xNCBElcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoBlGNYY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoBlGNYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8440FC2BCAF;
	Tue, 17 Mar 2026 09:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741515;
	bh=pPca3w6b7ndhzs+4hEVBpxOHFxwGlQtNuRRiPizzXaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RoBlGNYYt++ZvplRfmLvO+YInrNMxxaEXCo3aEmJ4zhXJCnzb0s4tq5Y04gJYqw3Z
	 L7V4E9vEMsIajV5XZLxASB/cZZ31FPqdfwNZZfn7sWon92q8XaxTBlHFxp7UyalinR
	 T7f91ZzFj8jT8uwoCbMMgIgEPaHv4WAQ+4/KCyRHevW7+GWiqUue6EmOVA6kR1n+N9
	 eJQHOisba6nPeoPoPkH9i1xmlKMlNPvz0/FnRBHtF3MaHAv3JPj9Un7PVOduYjbMD7
	 ILpNd2Zc2+lvwCsOZiboINi8HCHAWv057PuZkUwSNOjWV0L5IH6xO7WKTnCxGy3m8c
	 LEUf4uDi1WuTA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [RESEND PATCH mptcp-next v2 1/2] mptcp: implement psock_update_sk_prot
Date: Tue, 17 Mar 2026 17:58:10 +0800
Message-ID: <dcf46a0f2f9c0790c584055d94166f6ffa5d0061.1773741427.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773741427.git.tanggeliang@kylinos.cn>
References: <cover.1773741427.git.tanggeliang@kylinos.cn>
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512261144.DxrvwMS3-lkp@intel.com/
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 105 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5676b37f8f4..5bbc67d1fa6d 100644
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
@@ -4020,6 +4021,98 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
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
+	prot[MPTCP_BPF_TXRX]			= prot[MPTCP_BPF_TX];
+}
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct proto *mptcpv6_prot_saved __read_mostly;
+static DEFINE_SPINLOCK(mptcpv6_prot_lock);
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
+#endif
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
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		if (mptcp_bpf_assert_proto_ops(psock->sk_proto))
+			return -EINVAL;
+
+		mptcp_bpf_check_v6_needs_rebuild(psock->sk_proto);
+	}
+#endif
+
+	/* Pairs with lockless read in sk_clone_lock() */
+	sock_replace_proto(sk, &mptcp_bpf_prots[family][config]);
+	return 0;
+}
+#endif
+
 static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
@@ -4051,8 +4144,20 @@ static struct proto mptcp_prot = {
 	.obj_size	= sizeof(struct mptcp_sock),
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
+#ifdef CONFIG_BPF_SYSCALL
+	.psock_update_sk_prot	= mptcp_bpf_update_proto,
+#endif
 };
 
+#ifdef CONFIG_BPF_SYSCALL
+static int __init mptcp_bpf_v4_build_proto(void)
+{
+	mptcp_bpf_rebuild_protos(mptcp_bpf_prots[MPTCP_BPF_IPV4], &mptcp_prot);
+	return 0;
+}
+late_initcall(mptcp_bpf_v4_build_proto);
+#endif
+
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
-- 
2.53.0


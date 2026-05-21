Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EB34E777
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355820; cv=none; b=HFLW/cEhVTx9e5KuoE7jTuG+QOXw56EzpUpuV8FSeBYNG5068L29p17ZXhRUH19ds5z5v9zzopz19+DOew1tT/ECg0nORVnffT/IJR6XI2VHBuCNUoAuA/Vjh3kIePy8E1Hc1IlHmeVMCOv+mL0VAOs/ngdw+YLb/mM9yAdOXUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355820; c=relaxed/simple;
	bh=b7nhkfiY6tkSWKUtQhIzrPiDERZDt9I3w2eA6FIQTBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhs1XwL3pjmzUzWp3KjgLG9Oiuiu8OzQaOe4v1u8Hmdl9O2fDjR+gKjt2ncQopgStYTEXO8Bdo1XAKgw01Uja4monkeI3/HfGFkzDXCWoUz4dPXQci5lAB7hE6+5vUhGUlfovmXGiyI+hMsvWfzSMnmVIJUVBIh2s4Bge2wXZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OytvW2a8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OytvW2a8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EDF1F00A3B;
	Thu, 21 May 2026 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355819;
	bh=HR8eiBpEgsunfrDWdNQAXbb23s1tHiH5jbsstw33kB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OytvW2a8UgE6B+PJjtMWn5hIkNLNLjYsf/yP7eCqiNG/uXIhpni6MJmxEsd+DoZMw
	 zaNglbD4T1LrYrSLUN5WtN6i0/kxFK4IqYL8QAlsRw62gfcGF9qyeIE5QqEiU5YKV8
	 fnQ7KoNyE2EDQf+RzhKVygNBAQ12Q150IR1xoKW/xIF3582ZZK6ichA5mvtEZ8JLxA
	 L1TqKuxuRJPL4rnCsGt/rGXh4EmY4oPmhZxUxnfePKYNx1JBOcrooE8uN0oHKDm/x6
	 IYmMwKjg9KQ+mIZPpnbYgtR3JXk9bpWNrfTwbFzDQy+u23FJHUkBZ/hLzN/XUzj6Y2
	 M5Uh0I3JyPCXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 05/15] mptcp: implement tls_mptcp_ops
Date: Thu, 21 May 2026 17:29:43 +0800
Message-ID: <253b88077519ea25338cfa689b26cd7576fb2f7a.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements the MPTCP-specific struct tls_prot_ops, named
'tls_mptcp_ops'.

Passing an MPTCP socket to tcp_sock_rate_check_app_limited() can
trigger a crash. Here, an MPTCP version of check_app_limited() is
implemented, which calls tcp_sock_rate_check_app_limited() for each
subflow.

When MPTCP implements lock_is_held interface, it not only checks
sock_owned_by_user_nocheck(sk) as TCP does, but also needs to check
whether the MPTCP data lock is held. This is required because TLS
may call lock_is_held from softirq context with bh_lock_sock held.
Checking both conditions ensures TLS always defers to workqueue when
the MPTCP data lock is held, avoiding deadlock.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |   2 +
 include/net/tcp.h    |   1 +
 net/ipv4/tcp.c       |   9 +++-
 net/mptcp/protocol.c | 121 +++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |   1 +
 net/tls/tls_main.c   |  13 +++++
 6 files changed, 141 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..02564eceeb7e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -132,6 +132,8 @@ struct mptcp_pm_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+extern struct tls_prot_ops tls_mptcp_ops;
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index f063eccbbba3..1c8201f69ef1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -849,6 +849,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp);
 void tcp_rate_check_app_limited(struct sock *sk);
 
 /* Read 'sendfile()'-style from a TCP socket */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a058f350a759..bdad459e6605 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1097,9 +1097,9 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 }
 
 /* If a gap is detected between sends, mark the socket application-limited. */
-void tcp_rate_check_app_limited(struct sock *sk)
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
+	struct sock *sk = (struct sock *)tp;
 
 	if (/* We have less than one packet to send. */
 	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&
@@ -1112,6 +1112,11 @@ void tcp_rate_check_app_limited(struct sock *sk)
 		tp->app_limited =
 			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
 }
+
+void tcp_rate_check_app_limited(struct sock *sk)
+{
+	tcp_sock_rate_check_app_limited(tcp_sk(sk));
+}
 EXPORT_SYMBOL_GPL(tcp_rate_check_app_limited);
 
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a36ef97155a7..505eac23f35d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,6 +24,7 @@
 #include <net/mptcp.h>
 #include <net/hotdata.h>
 #include <net/xfrm.h>
+#include <net/tls.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
@@ -1909,7 +1910,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -1921,8 +1922,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2038,7 +2037,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2049,6 +2047,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = mptcp_sendmsg_locked(sk, msg, len);
+	release_sock(sk);
+
+	return ret;
+}
+
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
 static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
@@ -4726,3 +4735,107 @@ int __init mptcp_proto_v6_init(void)
 	return err;
 }
 #endif
+
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	const struct sk_buff *skb;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	skb = skb_peek(&sk->sk_receive_queue);
+	if (skb) {
+		u64 answ = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+
+		if (answ >= INT_MAX)
+			answ = INT_MAX;
+
+		/* Subtract 1, if FIN was received */
+		if (answ &&
+		    (sk->sk_state == TCP_CLOSE ||
+		     (sk->sk_shutdown & RCV_SHUTDOWN)))
+			answ--;
+
+		return (int)answ;
+	}
+
+	return 0;
+}
+
+static bool mptcp_lock_is_held(struct sock *sk)
+{
+	return sock_owned_by_user_nocheck(sk) ||
+	       mptcp_data_is_locked(sk);
+}
+
+static void mptcp_read_done(struct sock *sk, size_t len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	size_t left;
+	u32 offset;
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
+		return;
+
+	left = len;
+	while (left && (skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		int used;
+
+		used = min_t(size_t, skb->len - offset, left);
+		msk->bytes_consumed += used;
+		MPTCP_SKB_CB(skb)->offset += used;
+		MPTCP_SKB_CB(skb)->map_seq += used;
+		left -= used;
+
+		if (skb->len > offset + used)
+			break;
+
+		mptcp_eat_recv_skb(sk, skb);
+	}
+
+	mptcp_rcv_space_adjust(msk, len - left);
+
+	/* Clean up data we have read: This will do ACK frames. */
+	if (left != len)
+		mptcp_cleanup_rbuf(msk, len - left);
+}
+
+static u32 mptcp_get_skb_seq(struct sk_buff *skb)
+{
+	return MPTCP_SKB_CB(skb)->map_seq - MPTCP_SKB_CB(skb)->offset;
+}
+
+static void mptcp_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		tcp_sock_rate_check_app_limited(tcp_sk(ssk));
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
+struct tls_prot_ops tls_mptcp_ops = {
+	.owner			= THIS_MODULE,
+	.protocol		= IPPROTO_MPTCP,
+	.inq			= mptcp_inq,
+	.sendmsg_locked		= mptcp_sendmsg_locked,
+	.recv_skb		= mptcp_recv_skb,
+	.lock_is_held		= mptcp_lock_is_held,
+	.read_sock		= mptcp_read_sock,
+	.read_done		= mptcp_read_done,
+	.get_skb_seq		= mptcp_get_skb_seq,
+	.poll			= mptcp_poll,
+	.epollin_ready		= mptcp_epollin_ready,
+	.check_app_limited	= mptcp_check_app_limited,
+};
+EXPORT_SYMBOL(tls_mptcp_ops);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 661600f8b573..1c604a1ded6f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -380,6 +380,7 @@ struct mptcp_sock {
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
 #define mptcp_data_unlock(sk) spin_unlock_bh(&(sk)->sk_lock.slock)
+#define mptcp_data_is_locked(sk) spin_is_locked(&(sk)->sk_lock.slock)
 
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 6df4503e0e9d..fcf4bc399cf9 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1409,6 +1409,12 @@ static int __init tls_register(void)
 	if (err)
 		goto err_strp;
 
+#ifdef CONFIG_MPTCP
+	err = tls_register_prot_ops(&tls_mptcp_ops);
+	if (err)
+		goto err_tcp;
+#endif
+
 	err = tls_device_init();
 	if (err)
 		goto err_ops;
@@ -1417,6 +1423,10 @@ static int __init tls_register(void)
 
 	return 0;
 err_ops:
+#ifdef CONFIG_MPTCP
+	tls_unregister_prot_ops(&tls_mptcp_ops);
+err_tcp:
+#endif
 	tls_unregister_prot_ops(&tls_tcp_ops);
 err_strp:
 	tls_strp_dev_exit();
@@ -1428,6 +1438,9 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+#ifdef CONFIG_MPTCP
+	tls_unregister_prot_ops(&tls_mptcp_ops);
+#endif
 	tls_unregister_prot_ops(&tls_tcp_ops);
 	tls_proto_cleanup();
 	tls_strp_dev_exit();
-- 
2.53.0


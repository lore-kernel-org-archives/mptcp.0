Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41413D79FF
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788817; cv=none; b=bC7IDgFp4TCbJe1Zh/5CgZz5aSTIwJPhtJbZdx2VS5/WFFog50KRdaVIcDN0fgWbHf/b4j54XiQTxo25fBS90Gic8zTz8JUdvTjKhZ+SuMlZlr17kQdEjRjnT0c4qNbCRecyML7/AbN/f5yJU1gKF+F5PGI/wTlzpBJkx6aTQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788817; c=relaxed/simple;
	bh=hMh1rzCbFTmLbnSnHK+apFvj1RNpjzu1y37MU7ojPHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFltsR3fensXwVhBZhfd8gFE86+6K1sQFvOVwAYLXUfWSUxDf5quoXV1sqVdKM8IdpCORM5kWa3Zrxw+NW8JahDE/0DghwyM725y2aL42WWLPfPIbqSNtX0JHBJsoQp/niZN9hqsC6U/Ztvn3palAjE6dai9m6JBwQhFgN+2jxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu3CekN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu3CekN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE511F00A3A;
	Tue, 26 May 2026 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788815;
	bh=TnprUotkjpZDBcs9FKnXftL+caPnSGQPA2qgk27Ubxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iu3CekN3TCsTo8Z4u0BBX9wJk22Pgi7Kq/RRgR97vJSlYN++FWS2x1kQHcQXyLdou
	 QudPbPZ8II95wuvOah7+nQTO2pVEzMiWNGv1N32qAP1AgTqeL0uEXySBGFbRFIu7cU
	 9zWNk0XWTffhGcskFsI3cXT6z2PD3nvC7jY1Z9IJ/aUKIZ2ie3KodAAHi1h8zZGP4I
	 lPlhkoMDLqr+IzVK2ZLFiW5sIt8zFL3FExhU+vDAycqSUv9chCV3Sp8XmBiZ5LFFtr
	 vVwvazdUg+jCPRwweW5Eg7E/o0XKfQwvhcsOAx27rVw0zMPVKBewek01Pt3ALzup6M
	 84zujsTvQM/4Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 05/15] mptcp: implement tls_mptcp_ops
Date: Tue, 26 May 2026 17:46:23 +0800
Message-ID: <6557d95ab11416b3e798781cf95811bd6dd60d9e.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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
index c840a228af0d..fbb60dc1832e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1425,6 +1425,12 @@ static int __init tls_register(void)
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
@@ -1433,6 +1439,10 @@ static int __init tls_register(void)
 
 	return 0;
 err_ops:
+#ifdef CONFIG_MPTCP
+	tls_unregister_prot_ops(&tls_mptcp_ops);
+err_tcp:
+#endif
 	tls_unregister_prot_ops(&tls_tcp_ops);
 err_strp:
 	tls_strp_dev_exit();
@@ -1444,6 +1454,9 @@ static int __init tls_register(void)
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


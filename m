Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8835B138
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738823; cv=none; b=u2e57kd/f9UtQxxs2DAIdZaEPiT68e4XB4I+ZG4jLSq3CPE+tnJCx8BFq0L+kIOTzIRid9jrTxQLaVXAakWih0yxmm2iUreVl3jdMj1025YFFUqBiXM1ynv+hweAiIWNpqb0je1r8XAwrONkg0b+ybg3js5xmsWaaaTysRX0BeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738823; c=relaxed/simple;
	bh=RXJAq+Mo+9sFIMRI0ntFHMkFvzN0dyO8rUGOeV/dQ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTDh4aK0g3kk41I9PNxB6RzRLIGPArVj7CbaOPLHdfN6XyrIR1d6XGPS5FRFXdA0fbonqkmdtGnDwJdQs2s759oMnj1KVK5XqWGiej7oJ+fARWPPk3HUUcQdPz3WYZSzsyZx6Gh7FIlyMo1ckbVFGSsYyt7gNfz1+gUaGlp5Bes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRlBqgFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRlBqgFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8348AC19425;
	Tue, 17 Mar 2026 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738823;
	bh=RXJAq+Mo+9sFIMRI0ntFHMkFvzN0dyO8rUGOeV/dQ+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lRlBqgFo1CoqVa52EFJ9E46SXL/1EQcPiXL9D1auVrzVI5fpHMZ8iRcpgtSrTba/u
	 VHVu79gceqP1OyDMFlYZj2WgoG/kGhuEkbeW4RnhaM8QHhRvVWWOEa+MDybKvfdVnZ
	 jCQMU548JEY+GzkT2z0duJrT9uwX8XEQpQJGmYF8AgR7DubYcFOdadbel3jBxDNt4H
	 XQrOURDBhRCvup5bDoe6npRoPKBH6dGMq/li7b55R3gVO79SplpYKZ8W5rxOxUjTU1
	 vV29qrOX6emugfgw/HU7GXkVUJQ5x8uxDE0eHcwTJCeeXSTLXNuHojB30Iacpxi9zI
	 Cc5W0CNh0FUyw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 06/14] mptcp: implement tls_mptcp_ops for MPTCP TLS
Date: Tue, 17 Mar 2026 17:12:42 +0800
Message-ID: <fc520c485a829034f3d4ddf0f4a8ea8781f29d7c.1773737371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
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

Note that there is a slight difference between mptcp_inq() and
mptcp_inq_hint(), it does not return 1 when the socket is closed or
shut down; instead, it returns 0. Otherwise, it would break the
condition "inq < 1" in tls_strp_read_sock().

Passing an MPTCP socket to tcp_sock_rate_check_app_limited() can
trigger a crash. Here, an MPTCP version of check_app_limited() is
implemented, which calls tcp_sock_rate_check_app_limited() for each
subflow.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |   2 +
 include/net/tcp.h    |   1 +
 net/ipv4/tcp.c       |   9 +++-
 net/mptcp/protocol.c | 106 ++++++++++++++++++++++++++++++++++++++++---
 net/tls/tls_main.c   |   3 ++
 5 files changed, 113 insertions(+), 8 deletions(-)

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
index f87bdacb5a69..b198938945bf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -851,6 +851,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp);
 void tcp_rate_check_app_limited(struct sock *sk);
 
 /* Read 'sendfile()'-style from a TCP socket */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index dfd677c689ef..23a35201a05a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1110,9 +1110,9 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 }
 
 /* If a gap is detected between sends, mark the socket application-limited. */
-void tcp_rate_check_app_limited(struct sock *sk)
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
+	struct sock *sk = (struct sock *)tp;
 
 	if (/* We have less than one packet to send. */
 	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&
@@ -1125,6 +1125,11 @@ void tcp_rate_check_app_limited(struct sock *sk)
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
index 1903f5b1fc44..04f9b3a0ab29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,11 +24,12 @@
 #include <net/mptcp.h>
 #include <net/hotdata.h>
 #include <net/xfrm.h>
+#include <net/tls.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
 
-static unsigned int mptcp_inq_hint(const struct sock *sk);
+static unsigned int mptcp_inq_hint(struct sock *sk);
 static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs);
 static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
 				  struct list_head *skbs);
@@ -1927,7 +1928,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -1938,8 +1939,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2047,7 +2046,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		__mptcp_push_pending(sk, msg->msg_flags);
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2058,6 +2056,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -2312,7 +2321,7 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+static int mptcp_inq(struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
@@ -2327,6 +2336,16 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 		return (unsigned int)hint_val;
 	}
 
+	return 0;
+}
+
+static unsigned int mptcp_inq_hint(struct sock *sk)
+{
+	unsigned int inq = mptcp_inq(sk);
+
+	if (inq)
+		return inq;
+
 	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
 		return 1;
 
@@ -4752,3 +4771,78 @@ int __init mptcp_proto_v6_init(void)
 	return err;
 }
 #endif
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
+static u32 mptcp_get_skb_off(struct sk_buff *skb)
+{
+	return MPTCP_SKB_CB(skb)->offset;
+}
+
+static u32 mptcp_get_skb_seq(struct sk_buff *skb)
+{
+	return MPTCP_SKB_CB(skb)->map_seq;
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
+	.protocol		= IPPROTO_MPTCP,
+	.inq			= mptcp_inq,
+	.sendmsg_locked		= mptcp_sendmsg_locked,
+	.recv_skb		= mptcp_recv_skb,
+	.read_sock		= mptcp_read_sock,
+	.read_done		= mptcp_read_done,
+	.get_skb_off		= mptcp_get_skb_off,
+	.get_skb_seq		= mptcp_get_skb_seq,
+	.poll			= mptcp_poll,
+	.epollin_ready		= mptcp_epollin_ready,
+	.check_app_limited	= mptcp_check_app_limited,
+};
+EXPORT_SYMBOL(tls_mptcp_ops);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fe8ba116504a..d98beec89ddb 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1342,6 +1342,9 @@ static int __init tls_register(void)
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
 	tls_register_prot_ops(&tls_tcp_ops);
+#ifdef CONFIG_MPTCP
+	tls_register_prot_ops(&tls_mptcp_ops);
+#endif
 
 	return 0;
 err_strp:
-- 
2.53.0


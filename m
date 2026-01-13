Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C19DA41
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284835; cv=none; b=Aj/KCIvf+S77JliTYtJEiOQ/DbXOupKCvC4sBGs1wLuug4ODDhTj6E8I2SLOWiYzTqsDjD5i0XRvyS+NnufBidzp3qS/pT4SFtssB8yxGhVysRp1NpJJ00b3Qhx7cvm8OlRqLaQjF1Re8HHrlc1EcTq5rP4G3+dJHFEAReA0EZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284835; c=relaxed/simple;
	bh=J9JjOTy4iHK94lhHXIPXji1D1kdYy/srKBioKY2BVjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfBxTHCY/jNGeFuBHBj5qylTZnfLrqESk8dBb+OB7sXpKveJaNwW3D0C53XSvs0gb6Vhf1BsVlzTGQRxBsueyMptbz4QJZWUUZXpZVR5VlBx8apQLdD3aAZr7KXfoqionUzmzG31ieJXRPCdsGoTz1HsDcmwNJZSqp6/YVAUhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvdtSdBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvdtSdBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC95EC116C6;
	Tue, 13 Jan 2026 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768284835;
	bh=J9JjOTy4iHK94lhHXIPXji1D1kdYy/srKBioKY2BVjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvdtSdBM91GateGBWyZc1tTrKN/MncPoLQkJnZnqs5cW9EVRBzHwWkwf1walGzsQY
	 C17/bm/MmtWhGSe1FQjhz8FD6W0sOy7NjjVwSJPV9W0i+cGgO9jzI6/tib1JWVZnC0
	 wLC8pnDiitFk2T57jQU3x3NGse6lrQgqJrgG3JOZxZREmMsd+HfIJi9LEyXG8xNOJs
	 e6KKEtfWfHl1oWhGvR9VClTDJj5LKd+dfEkd+nXGBC9He9q0HtZC+xPZrf9m6gjQFo
	 1M+nVSonXrYKRr2F89UA4BLbMkexSZLApFmOFRBe+W3D+RjODwkwxBeaaZNpxsY5BF
	 1UMXEDeLEJWWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v7 6/9] mptcp: implement tls_mptcp_ops
Date: Tue, 13 Jan 2026 14:13:32 +0800
Message-ID: <7ebe2388bbacb63ac91be1c7a9e6836c0554b292.1768284047.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768284047.git.tanggeliang@kylinos.cn>
References: <cover.1768284047.git.tanggeliang@kylinos.cn>
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

A direct call to mptcp_read_sock() could lead to a deadlock, as
'read_sock' interface of TLS might be invoked from within a softirq
context. In such a scenario, lock_sock_fast(), which is called by
mptcp_rcv_space_adjust() or mptcp_cleanup_rbuf(), would cause the
deadlocks. To resolve it, use in_softirq() to determine whether to
call mptcp_read_sock() or mptcp_read_sock_noack().

Passing an MPTCP socket to tcp_sock_rate_check_app_limited() can
trigger a crash. Here, an MPTCP version of check_app_limited() is
implemented, which calls tcp_sock_rate_check_app_limited() for each
subflow.

MPTCP TLS_HW mode is not yet implemented, returning EOPNOTSUPP here.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |   2 +
 include/net/tcp.h    |   1 +
 net/ipv4/tcp_rate.c  |   9 +++-
 net/mptcp/protocol.c | 116 ++++++++++++++++++++++++++++++++++++++++---
 net/tls/tls_main.c   |   6 +++
 5 files changed, 126 insertions(+), 8 deletions(-)

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
index 1ff682763ed3..4b2b9daada49 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1372,6 +1372,7 @@ void tcp_rate_skb_delivered(struct sock *sk, struct sk_buff *skb,
 			    struct rate_sample *rs);
 void tcp_rate_gen(struct sock *sk, u32 delivered, u32 lost,
 		  bool is_sack_reneg, struct rate_sample *rs);
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp);
 void tcp_rate_check_app_limited(struct sock *sk);
 
 static inline bool tcp_skb_sent_after(u64 t1, u64 t2, u32 seq1, u32 seq2)
diff --git a/net/ipv4/tcp_rate.c b/net/ipv4/tcp_rate.c
index a8f6d9d06f2e..93bf22ae58c4 100644
--- a/net/ipv4/tcp_rate.c
+++ b/net/ipv4/tcp_rate.c
@@ -191,9 +191,9 @@ void tcp_rate_gen(struct sock *sk, u32 delivered, u32 lost,
 }
 
 /* If a gap is detected between sends, mark the socket application-limited. */
-void tcp_rate_check_app_limited(struct sock *sk)
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
+	struct sock *sk = (struct sock *)tp;
 
 	if (/* We have less than one packet to send. */
 	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&
@@ -206,4 +206,9 @@ void tcp_rate_check_app_limited(struct sock *sk)
 		tp->app_limited =
 			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
 }
+
+void tcp_rate_check_app_limited(struct sock *sk)
+{
+	tcp_sock_rate_check_app_limited(tcp_sk(sk));
+}
 EXPORT_SYMBOL_GPL(tcp_rate_check_app_limited);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e5b59310bd27..7d95c0401672 100644
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
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
@@ -1884,7 +1885,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -1895,8 +1896,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2004,7 +2003,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		__mptcp_push_pending(sk, msg->msg_flags);
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2015,6 +2013,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -2242,7 +2251,7 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+static int mptcp_inq(struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
@@ -2257,6 +2266,16 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
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
 
@@ -4678,3 +4697,88 @@ int __init mptcp_proto_v6_init(void)
 	return err;
 }
 #endif
+
+static struct sk_buff *mptcp_recv_skb_tls(struct sock *sk, u32 seq, u32 *off)
+{
+	return mptcp_recv_skb(sk, off);
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
+	return MPTCP_SKB_CB(skb)->map_seq;
+}
+
+static int mptcp_read_sock_tls(struct sock *sk, read_descriptor_t *desc,
+			       sk_read_actor_t recv_actor)
+{
+	return __mptcp_read_sock(sk, desc, recv_actor, in_softirq());
+}
+
+static bool mptcp_epollin_ready_tls(const struct sock *sk, int target)
+{
+	return mptcp_epollin_ready(sk);
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
+	.recv_skb		= mptcp_recv_skb_tls,
+	.read_done		= mptcp_read_done,
+	.get_skb_seq		= mptcp_get_skb_seq,
+	.read_sock		= mptcp_read_sock_tls,
+	.poll			= mptcp_poll,
+	.epollin_ready		= mptcp_epollin_ready_tls,
+	.check_app_limited	= mptcp_check_app_limited,
+};
+EXPORT_SYMBOL(tls_mptcp_ops);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index e8bb745029e4..75e01f2dde26 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -772,6 +772,9 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 			tls_sw_strparser_arm(sk, ctx);
 	}
 
+	if (conf == TLS_HW && sk->sk_protocol == IPPROTO_MPTCP)
+		return -EOPNOTSUPP;
+
 	if (tx)
 		ctx->tx_conf = conf;
 	else
@@ -1332,6 +1335,9 @@ static int __init tls_register(void)
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
 	tls_register_prot_ops(&tls_tcp_ops);
+#ifdef CONFIG_MPTCP
+	tls_register_prot_ops(&tls_mptcp_ops);
+#endif
 
 	return 0;
 err_strp:
-- 
2.51.0


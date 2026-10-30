Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327427;
	b=Mab1HZpfgt3SQNR+NtwqNg7ke+3QsDo4S+Q5/il/wtyPMRP6xHhUWMCaRyece+4hkMiS
	 6ozTWcYXEfuC6MlGSerSik2HJqsuc+fH9tKEKhyeXw6tf8MWVArjnBrK5ybkRk7oWe/7T
	 um4T/2YBU7xTdHBOCjE2ITGDkfVbx1tleVkjwYLx/1+atzCU2hCPszJhptjF5YHMUQpYx
	 Y52fYB99FAui9h5MvWKXvdbwOpx5X1+l9B4cYcTAPLLGjxbYfEwb6+c1pTXhJNczawUPw
	 tujyhvn5Ilx41PENeCpl7SPzFt22CGK+VZQbyXxF/QdHdpP0EtuLU5LPbKZbFS3syEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327427;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=75UkmwvrSrx8JixH9eK2sB+gRor+D0VBJwMxmd5StDw=;
	b=GBapwkGMb6gYYiBKFC/yQxZG01l4Y/iPCsQfG8p7k37TN9fL5FophI0m0TYY023EeJ0S
	 6dfqUJRfBmBTebZ4TWom+LAL6G3YBKMRr07RuVnnMq1rAA6oEiyaxc7ionskx2J/5xcIW
	 00C+7/Rlu8I2fpikVO85/0mkHyvXaXzoay9mMnxr4J+wgwHE6Q5LouPCR42wFH28c6oe/
	 z1RKXj6PlPVjuGSJmyMjju0ZCSr5wCQ07jCQ9SIxSxDk0N5zp41l4qfJq5W+LduRUYe2F
	 Uwpp4ilQbrLg+rEQcPywWEad6eiaAJK2s8JhCtV/puLtenZh4Xa6lDpC9qUEOeNrMFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gdnbhAXb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF410606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gdnbhAXb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9FE1F0093A;
	Fri, 30 Oct 2026 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793327426;
	bh=75UkmwvrSrx8JixH9eK2sB+gRor+D0VBJwMxmd5StDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gdnbhAXbMQUqnw9E5DJaLOPCxNOXYhru9f6VjdE5Tb8WL2iQdjTHRCr6ezOL9zIMI
	 EJYNm91xU0oiMtaKrv1FWs6mKNobzPixmWxV098akbwoPkG62tjA5N4/gSz/ma+4wa
	 t2njCfVHYfstxkfLbCBnN6Q6JwNAU3hBxVYtQt90+xXMOjX/B/1oy46Ch26eWyKeaz
	 js1gGWXcgKJfZN9Db00D7m8jqbMRaR3G81Xla2XoSni2IRA/Rpa0sEBKPE3okzJkp8
	 nTHtPv5pCZInUtFqTLCVuD/7YHta8ARzYVeKcLo/z4CEKCGQcDF1bQTJVg3ZHJdMwW
	 Si3Yal5GI39Kw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v17 4/4] mptcp: defer read_sock cleanup to mptcp_worker
Date: Fri, 30 Oct 2026 10:30:15 +0800
Message-ID: <af5505184cc757cfc75adbe44735993fa8372f14.1793326853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793326853.git.tanggeliang@kylinos.cn>
References: <cover.1793326853.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

When MPTCP carries TLS, __mptcp_read_sock() is reached from BH context
(via tls_strp_read_copyin() -> sk->sk_read_sock()), where calling
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() is not safe as both
expect process context.

Move both calls to mptcp_worker(): __mptcp_read_sock() accumulates the
consumed bytes in msk->read_copied and signals the worker through a new
MPTCP_WORK_READ_COMPLETE bit. The worker drains the accumulator under
mptcp_data_lock() and runs rcvbuf autotuning and RBU update in process
context.

Also remove the backlog flush from mptcp_recv_skb() (covered by
mptcp_release_cb()), drop the msk_owned_by_me() assertion (BH caller
does not own the msk lock), and drop the redundant mptcp_recv_skb()
call after the main loop.

Initialize msk->read_copied in __mptcp_init_sock() and reset it in
mptcp_disconnect().

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 37 ++++++++++++++++++++++++++++---------
 net/mptcp/protocol.h |  2 ++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8447efa9dee6..8139f457cbb0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3125,6 +3125,21 @@ static void mptcp_backlog_purge(struct sock *sk)
 	sk_mem_reclaim(sk);
 }
 
+static void mptcp_read_complete(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int read_copied;
+
+	mptcp_data_lock(sk);
+	read_copied = msk->read_copied;
+	msk->read_copied = 0;
+	mptcp_data_unlock(sk);
+
+	mptcp_rcv_space_adjust(msk, read_copied);
+	if (read_copied > 0)
+		mptcp_cleanup_rbuf(msk, read_copied);
+}
+
 static void mptcp_do_fastclose(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3200,6 +3215,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3243,6 +3261,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3688,6 +3707,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4605,9 +4625,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 
@@ -4623,6 +4640,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4632,8 +4650,6 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	int copied = 0;
 	u32 offset;
 
-	msk_owned_by_me(msk);
-
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
@@ -4664,11 +4680,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	if (noack)
 		goto out;
 
-	mptcp_rcv_space_adjust(msk, copied);
-
+	/* The backlog flushing is only needed when some data is actually
+	 * moved and will take place in mptcp_release_cb() via
+	 * release_sock() in the worker.
+	 */
 	if (copied > 0) {
-		mptcp_recv_skb(sk, &offset);
-		mptcp_cleanup_rbuf(msk, copied);
+		msk->read_copied += copied;
+		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
+		mptcp_schedule_work(sk);
 	}
 out:
 	return copied;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2ab8342e198d..b0082e1c83f0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
+#define MPTCP_WORK_READ_COMPLETE 5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -326,6 +327,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	int		read_copied;
 	unsigned long	timer_ival;
 	u32		token;
 	unsigned long	flags;
-- 
2.55.0


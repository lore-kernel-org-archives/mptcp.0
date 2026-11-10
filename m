Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305519;
	b=DcvQugv9hIPwvfRxR7Sh0cJ+nOeSFclXbvrY+EPsaPrPIBQ9Hmlj1JQ5OYrvVe6Lb1dE
	 /iTzO51Wfla7dg1f7iyyKtEO8rxHgbr+TxjMW67fbuh1KXunNopqTxDh9ggMTl4TZHas0
	 eZ+eNkIudtWMX5pOywzHGHcfMVvjB0hqfFJPAfRxob854iUWz00TckYlm7OsP08Zpq2nK
	 PxTZl845kIX+laEcuaJMCAOEGD7KEzlEx3CLRpqUVXDau2kQelvArcW9/5GZH5DZodjaY
	 5mxtrdraPF1WP/6JxP2v1Cg+sa1vv+ztIJcw4r245fLNx3ZII2XAKkK85ArUKuNGxJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305519;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yV7HkXlUTLrI88+p9R4JIjKEWzNXbsq/TRP03bVYmIU=;
	b=cgRDGcGR6CczzzPcFHJny1DE2i+8o+bmMKjsH2dArz95EDAADo2e+Vk9HJdPoCGNIZia
	 1FcKg++Hjq54THt1IooL6mzq7YlVCPgWFjy3VQjLp9b2/VOo8tXrUSM7s4oqpEDclWkZG
	 9rrTzrtbqwKlUKlgPownkGlw8iF3y5T8QHF7XTIPyyMzgd1sdRB2URnFnus3e/zdHSlLX
	 OmwDn2m5HNdLdnrPoLp4eUNpeU43kS9CUpoQKv5CQpIBusqY3mwxkje6L8xzNitcji0fP
	 vdkbTEyjXPNsz+tg/ZoM9S2ygpRPS/HWRAL92soOhr1k9P2B3uv2DTSaaxxLKlop0IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8x18fjN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CA606A33C
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8x18fjN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456341F008A1
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305518;
	bh=yV7HkXlUTLrI88+p9R4JIjKEWzNXbsq/TRP03bVYmIU=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=P8x18fjNnrsjiXBxCvBObVktNJi1O1GiAJbYhytMTp/I28Q3FS+4ObyyHpN4VIfGz
	 qZhVHd6rOTML6++co5M/ZFGVf4z6n8akL5EAdmVdebweOSadVszo7h4aQb3blSuvc4
	 xssloOUw8IbmqPYH3Ya+szkPEf12/vASxGoG3r/cbK7dSUXtvztE/GqJmlbbuzcBHc
	 VK4vJiB9fk2ir9adk599muJraOY8cpTPs7ukqqZ3pj1wJ3ffsDCdEs9L8RHI1VRv/E
	 GQwHYb0MGENX8OXMzaUgntmXWliD/xYcBDsILixFcPHKYCg7XqU65Uof9t6pm2dLuI
	 YfjQeQqIWl+wA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v25 8/8] mptcp: defer read_sock cleanup to mptcp_worker
Date: Tue, 10 Nov 2026 18:11:47 +0800
Message-ID: <7396957e6e466cb4cf6864734d805c823451a5a3.1794304840.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794304840.git.tanggeliang@kylinos.cn>
References: <cover.1794304840.git.tanggeliang@kylinos.cn>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch prepares __mptcp_read_sock() for future MPTCP TLS support,
where it may be reached from BH context. In that case, calling
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() is not safe as both
expect process context.

Conditionally defer cleanup to mptcp_worker(): when the caller doesn't
own the socket lock (BH context), accumulate consumed bytes in
msk->read_copied and signal the worker through MPTCP_WORK_READ_COMPLETE.
When the caller owns the lock (process context), perform inline cleanup
to avoid delaying window updates and autotuning.

The existing backlog flush in mptcp_recv_skb() is now gated on
sock_owned_by_user(). This ensures process context callers flush the
backlog before processing skbs, while future BH context callers skip it.
The reason is that BH callers would already hold the msk spinlock, so
mptcp_data_lock() inside mptcp_move_skbs() would self-deadlock.

Initialize msk->read_copied in __mptcp_init_sock() and reset it in
mptcp_disconnect().

Note: The BH call path does not exist in the current tree. This is
groundwork for the upcoming MPTCP TLS series. Currently, the only
callers are mptcp_splice_read() and svc_tcp_recvfrom(), both of which
hold lock_sock() and run in process context.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 38 +++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  2 ++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 981599a70216..5318b54920e4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3145,6 +3145,21 @@ static void mptcp_backlog_purge(struct sock *sk)
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
@@ -3220,6 +3235,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3263,6 +3281,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3710,6 +3729,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->fastclosing = 0;
 	msk->tfo_iasn = 0;
 	msk->rcvd_dummy_seq = false;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4632,7 +4652,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
+	if (sock_owned_by_user(sk) && !list_empty(&msk->backlog_list))
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
@@ -4650,6 +4670,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4691,11 +4712,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	if (noack)
 		goto out;
 
-	mptcp_rcv_space_adjust(msk, copied);
-
 	if (copied > 0) {
-		mptcp_recv_skb(sk, &offset);
-		mptcp_cleanup_rbuf(msk, copied);
+		if (sock_owned_by_user(sk)) {
+			/* Process context: inline cleanup */
+			mptcp_rcv_space_adjust(msk, copied);
+			mptcp_recv_skb(sk, &offset);
+			mptcp_cleanup_rbuf(msk, copied);
+		} else {
+			/* BH context: defer to worker */
+			msk->read_copied += copied;
+			set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
+			mptcp_schedule_work(sk);
+		}
 	}
 out:
 	return copied;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 175648ce13d3..cf0750ecef54 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
+#define MPTCP_WORK_READ_COMPLETE 5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -328,6 +329,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	int		read_copied;
 	unsigned long	timer_ival;
 	u32		token;
 	u64		tfo_iasn;
-- 
2.55.0


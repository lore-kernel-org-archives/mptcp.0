Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349710;
	b=q4aD9BLhhlKbItnew5eo4TtGKfDXQU01Vn6smkBYKqub/nFG2ZW7HXK1yroG6sTuTrwh
	 oMJTn3pd+g9DcBDS+9M50Ut84IKCuTjSsJkbHg/JiEHPjs76O4yMwOcRwLBv88x0Se91q
	 W9zjHjYwzv80DOltFk6T7SU6i7DggBnZFvkf0zA1m+0+pYSUZ1UEITbj9sGlvk5k+9UZ1
	 bvozM4kAwC4H/W08UN6i5whXnD7XS24+1iCrO8Pn+sdnQ+5dP9Xmi70DvgLbOslnwkSW0
	 4G8m+BT+Qg3kJuw5ktH6tmFoetDUx+bZ4iBy1aZrDf7GYO+8+0+8o6VxZaUoNRnkGdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349710;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wqWhvfGHwJiGDdh05d/ZPgn+VnaRmq6HfuNpvir3clU=;
	b=lklbC7+AQKpdCpS3XNv22Aoj4MKDvTZRGQWA0DgK5C+mUEXpBW/UOq4EasKr34QtgTXO
	 B2ECm44wqvdHsmveetcSstBRs/INFyA0OLiQBjyVbu2nR2M2yG+plnoAOfd2VvrD5dk7A
	 IZ8mvG1xHHTHE4UXL1A82EP+sMXAPjkUfsQ43st9BDppiD7LJOE4TyPNJmGTr6yI349/i
	 YTn7lBZNXYMHwnXyvof3K2dLiKRjG2nHGBP9lFljcL42WAT5GY6mjkdTpoYuQS5u2SsYR
	 b3yUtRXY4O+zCJ+rtR2n0h6fJ424RgDLsMXgKGzGsjCXxv3IOv6B+ikdI5aSC2O/4uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSw6wANG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3422F606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSw6wANG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8E11F000C1;
	Fri, 30 Oct 2026 08:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793349710;
	bh=wqWhvfGHwJiGDdh05d/ZPgn+VnaRmq6HfuNpvir3clU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MSw6wANG1x7Da1c7lMl/9fBTdXmFoYZgZkWv79+//nDsk0p646YuxLl/80WjUWWHE
	 F4Wbi+nPfzpNyKjouwOFfe39MKVHsmi3/RWTK6G0ppr2Vb3Qaec0oBJjgMPp/SyGru
	 p0ZgAOzncmiploEnmKstknfF3QC4gMKQ831LDMvTFbJqAbVblGeueMjj7yVSQIqA1R
	 wrwOjvTdhor3Lkp6BHsmaJBP6UdkWKo2ltsCeslLOURZieIJwW3gP5189KxP2B1sc0
	 JzxJy8BL/yxniz305cAcsPOu2xqIIghmEmmUPWiQYOf54ePq8XbeDVaJFxHfhHFAbu
	 EKSIpr3dcW9SQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v18 5/5] mptcp: defer read_sock cleanup to mptcp_worker
Date: Fri, 30 Oct 2026 16:41:26 +0800
Message-ID: <b6e4ed70642e2f86c041381cea810db82116b836.1793349369.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793349369.git.geliang@kernel.org>
References: <cover.1793349369.git.geliang@kernel.org>
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
index 7195da74d5c7..a59247495987 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3136,6 +3136,21 @@ static void mptcp_backlog_purge(struct sock *sk)
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
@@ -3211,6 +3226,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3254,6 +3272,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3701,6 +3720,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->fastclosing = 0;
 	msk->rcvd_dummy_seq = false;
 	msk->tfo_skb_len = 0;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4622,9 +4642,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
@@ -4639,6 +4656,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4648,8 +4666,6 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	int copied = 0;
 	u32 offset;
 
-	msk_owned_by_me(msk);
-
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
@@ -4680,11 +4696,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index 9b073cbdf76e..7441da7704fe 100644
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
 	u32		tfo_skb_len;
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256457;
	b=q1Rmfw6/0l01l+frYSK4jgZbrzQtoTVMcmibVIWW658JIHLPPxO45oY0Y0NBbWd5vp19
	 NbO5B1Il54XV+CP/RUkdWEiftfgDRWmDQ/mEjssQ+G8qc0ueFrLaaasxBmjkjv0agpY3R
	 b1BLSaqYW1AJhfOsPxdr6/JIjxXt1ewzhMs7EbWqgFBhWrYVa6W92QRj4dPCsLqsAg8K5
	 xDMawSQ1kwsc5JotSFgKt/adbVTNZGDV/YWQlrI1jadnK96Fr/Me7beZeUvDo+VZYD18k
	 99XsrQ6TWQ+nUFaS7h4zodoLY2i2Q6oaFtZFyHaLNBL2ij6c6LO6llEinNHWSoLBpww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/pdOhH9uifXrjLVp13tr0nslqktQOyaJAlhej0blgow=;
	b=IMPIG/LmU2KtC/zSYqhhBdbipvcbw7rgfDlCxpmwgr1CmbzYFslelkKCyQYsLbWDyn9Y
	 kB/PISr+WzZPqj/696crB8ivb4EExEEhjccxMSJh12M+Fh/BR6h30JaNZqj+2JkY568/q
	 z6qksGmmgqGSD0FPReEzVaSRpiVJzpoiSBpgwYjLpl2yvZgWj/IC9RLuudNyeAxNApeBh
	 lzs+Je1vcMJvVosiZD06qBBfya2JK5m+EwkUhQ8YiaP0yX/RohamxsWhoa2Mv8HOLdDGm
	 JInHXhfhBh4GRF+8JmyVkh+jp+O95jKJPTIJ2Bq2cToqYSPOGxJUv7mP43sQYoIkFKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwppdsVl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540A606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwppdsVl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36EA1F031E2;
	Thu, 29 Oct 2026 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793256456;
	bh=/pdOhH9uifXrjLVp13tr0nslqktQOyaJAlhej0blgow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SwppdsVlow80+WfUJ+hQI1aV1P/QmgQH2AC2S85xVy+m6P3f2ul0XrT/RLdYZnDY+
	 DGFxPYXbEvjqY+tAbwofDJWQoRLOVRhn1JRCqtKNHwtn5CHLW3gRpQzZSvN+sFCl5Q
	 KrcdgcKawCL8h6g9pl1ahuK6NDIjYiLPg5Oew7vEwgBV+QjJCAq6Mitquai0r4fGqP
	 ne0KYP6yLkGgo0TC0gK8Dv5t+Mgs+eAuXMarN9dskcyjIqooCc1yHZ8Zqgqt4uKerJ
	 4Bva3y2fMHXENFMeFx2wTv6IwU4H1hpPX49KEELiHQAPYWaVYnyTfsA81A08dHEO3S
	 r3KnWhAXFevLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v16 4/4] mptcp: defer read_sock cleanup to mptcp_worker
Date: Thu, 29 Oct 2026 14:47:21 +0800
Message-ID: <636807b42883e8ec741f2535293e02ff751af276.1793255126.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793255126.git.tanggeliang@kylinos.cn>
References: <cover.1793255126.git.tanggeliang@kylinos.cn>
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
index bbce1bafa40e..322d7a5ba0b8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3121,6 +3121,21 @@ static void mptcp_backlog_purge(struct sock *sk)
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
@@ -3196,6 +3211,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3239,6 +3257,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3684,6 +3703,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4601,9 +4621,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
@@ -4618,6 +4635,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4627,8 +4645,6 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	int copied = 0;
 	u32 offset;
 
-	msk_owned_by_me(msk);
-
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
@@ -4659,11 +4675,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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


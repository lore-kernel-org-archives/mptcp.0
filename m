Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361993;
	b=IGBFtJs1eKzdm3DyWwIYCiWv65n64vVFEW+t4U1WqovoC4V1AuCwy/EWzq/hXw4XrXa9
	 kOwjt0yqkczGXMwFfEzG1iz6xl+6I9cPNoxYedmYhHSsA273wpqBxBxB+G+sJI7xWy1o0
	 oefDnY1zZkq25to7tQqP+ueKQiWY7P5uBtdkkQ3xhTANv5BXHdfOIxAi5T/HHlxESHQ+W
	 Hm+veBiwfDnQILK+zCnsBsdIjQlknrofJA5iaWeK2vnxHpa+BraM4I/Lz8NrpUH6FEVKe
	 lozgI1X3cV545t1DVHlz5HwAGEs494ZqFmdkdfCDmy7ukPdaCMW3q4lJ2gYbUJelfKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y1EUvFjP1r4T4/e3Hi3kf74ra6TW0DpSidIWfUtnEJo=;
	b=Qp52arnUFTcCSqXxo2rYUZ73uvbl2ItY0ZhM+NzBONcGrtqnHDpWgK0atFALpXN8UxwU
	 QTiL0+oULmbvEjmbTq5fDKqH+OzrRoSif9ZOk9WZ+aaMxiY+s+zpcdpqUF93GSpFMpkwG
	 E4pAO0fNezpJVYiPGpy6KLW5TtGm4fr2vP09a4r8VcWwnY6RBjE4Jyglc4qc83jvmkB5k
	 6R1Ex4jlPJEtc5s1J3IK1lWvFXJYgOUJu+IxRMXN0dQkh+YRy6CDSn9Mfy7hQLbTYy8Eg
	 haqh2Pczw8MLVYaA6PTb5OJErGf7jR/QPIbsb9CnL3A0asfq1rsn2zmukAHsI7qa/rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuQOoYI6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5A606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuQOoYI6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6184F1F0093A;
	Fri, 30 Oct 2026 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361992;
	bh=y1EUvFjP1r4T4/e3Hi3kf74ra6TW0DpSidIWfUtnEJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SuQOoYI6WLRxqKWgW/dg9JDTiNW8ghbEXtgu032TM3LUjnJDPhs2SllnRK1iktppK
	 5VVx8sy0SAu5ang/FA5KIisZK/C8u+l+JxnPuJ0+yJSLXpaFiHqZ8gEWWUpFOCqxZh
	 Z0AsTTl440rrMV63yhqoZ8TaYQpG8+M6gcPrEYHlOYwHjwbbJGaMJlxZWKblayuMHc
	 8WCZ8jbaGWw2BpPyLcFY6LywisuH9M+Xcmd/rjefd7JmORWkX0tCYtCwRWy36Kjcnk
	 gWUhjDq8qnIaapXzyqoa2iS6cfLwjFPCobrqb42rXKGfE1LTIcilV1Bm5VT8iqxV45
	 toqPltE3eh48A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v19 5/5] mptcp: defer read_sock cleanup to mptcp_worker
Date: Fri, 30 Oct 2026 20:06:19 +0800
Message-ID: <90a300d74f44443759ebe14be70c07385267db5b.1793361629.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793361629.git.tanggeliang@kylinos.cn>
References: <cover.1793361629.git.tanggeliang@kylinos.cn>
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

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 37 ++++++++++++++++++++++++++++---------
 net/mptcp/protocol.h |  2 ++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3ff07b9de08c..13078f2f3c49 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3143,6 +3143,21 @@ static void mptcp_backlog_purge(struct sock *sk)
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
@@ -3218,6 +3233,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3261,6 +3279,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3707,6 +3726,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
 	msk->rcvd_dummy_seq = false;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4629,9 +4649,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
@@ -4646,6 +4663,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4655,8 +4673,6 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	int copied = 0;
 	u32 offset;
 
-	msk_owned_by_me(msk);
-
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
@@ -4687,11 +4703,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index fa54f70ab501..3580cf66f303 100644
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
 	u64		tfo_iasn;
-- 
2.55.0


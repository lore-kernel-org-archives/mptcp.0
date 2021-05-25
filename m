Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6770
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621964264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPOSvso8iGVDynvkkuV+bUivg123pbBrIAqQlnfEB7w=;
	b=KJQCOqAlH3I77NzhclSXFhq4H1M18TUcPlmKVi6/z81ZQot19YPekQ/imfLFEJ4u8AtWgR
	NzClwrdwQjkwAHdjA0cSNHaNMtazfRqVDJEsg2b4tGdOt2qqAl1bUT2GVoybSuXWbo+wNE
	cHATV6NmpdfOxA5/Jl/HKl7ATgqyPqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-tPrE_qCbP4-YtjfOPzpp7w-1; Tue, 25 May 2021 13:37:42 -0400
X-MC-Unique: tPrE_qCbP4-YtjfOPzpp7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C68301020C38
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:41 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-92.ams2.redhat.com [10.36.115.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 118EB100E113;
	Tue, 25 May 2021 17:37:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [RFC PATCH 3/4] mptcp: move the whole rx path under msk socket lock protection
Date: Tue, 25 May 2021 19:37:19 +0200
Message-Id: <3fa2a7102e0ca7e89dac2e14e60469ac414bcef4.1621963632.git.pabeni@redhat.com>
In-Reply-To: <cover.1621963632.git.pabeni@redhat.com>
References: <cover.1621963632.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

After commit c2e6048fa1cf ("mptcp: fix race in release_cb") it's
pretty straight forward move the whole MPTCP rx path under the socket
lock leveraging the release_cb.

We can drop a bunch of spin_lock pairs in the receive functions, use
a single receive queue and invoke __mptcp_move_skbs only when subflows
ask for it.

This will allow more cleanup in the next patch

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 94 ++++++++++++++++++--------------------------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 39 insertions(+), 57 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6050431f4c86..57deea409d0c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -682,11 +682,6 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	unsigned int moved = 0;
 
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
-
-	mptcp_data_lock(sk);
-
 	__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 	__mptcp_ofo_queue(msk);
 
@@ -697,12 +692,11 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	 */
 	if (mptcp_pending_data_fin(sk, NULL))
 		mptcp_schedule_work(sk);
-	mptcp_data_unlock(sk);
 
 	return moved > 0;
 }
 
-void mptcp_data_ready(struct sock *sk, struct sock *ssk)
+static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -731,6 +725,16 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	}
 }
 
+void mptcp_data_ready(struct sock *sk, struct sock *ssk)
+{
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk))
+		__mptcp_data_ready(sk, ssk);
+	else
+		set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->flags);
+	mptcp_data_unlock(sk);
+}
+
 static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -967,7 +971,6 @@ static bool mptcp_wmem_alloc(struct sock *sk, int size)
 	if (msk->wmem_reserved >= size)
 		goto account;
 
-	mptcp_data_lock(sk);
 	if (!sk_wmem_schedule(sk, size)) {
 		mptcp_data_unlock(sk);
 		return false;
@@ -975,7 +978,6 @@ static bool mptcp_wmem_alloc(struct sock *sk, int size)
 
 	sk->sk_forward_alloc -= size;
 	msk->wmem_reserved += size;
-	mptcp_data_unlock(sk);
 
 account:
 	msk->wmem_reserved -= size;
@@ -1002,12 +1004,10 @@ static void mptcp_mem_reclaim_partial(struct sock *sk)
 	if (msk->wmem_reserved < 0)
 		return;
 
-	mptcp_data_lock(sk);
 	sk->sk_forward_alloc += msk->wmem_reserved;
 	sk_mem_reclaim_partial(sk);
 	msk->wmem_reserved = sk->sk_forward_alloc;
 	sk->sk_forward_alloc = 0;
-	mptcp_data_unlock(sk);
 }
 
 static void dfrag_uncharge(struct sock *sk, int len)
@@ -1092,9 +1092,7 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
 
 static void mptcp_clean_una_wakeup(struct sock *sk)
 {
-	mptcp_data_lock(sk);
 	__mptcp_clean_una_wakeup(sk);
-	mptcp_data_unlock(sk);
 }
 
 static void mptcp_enter_memory_pressure(struct sock *sk)
@@ -1713,16 +1711,22 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
 	remove_wait_queue(sk_sleep(sk), &wait);
 }
 
-static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
+static bool __mptcp_move_skbs(struct sock *sk);
+
+static int __mptcp_recvmsg_mskq(struct sock *sk,
 				struct msghdr *msg,
 				size_t len, int flags,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb, *tmp;
 	int copied = 0;
 
-	skb_queue_walk_safe(&msk->receive_queue, skb, tmp) {
+	if (skb_queue_empty(&sk->sk_receive_queue) && !__mptcp_move_skbs(sk))
+		return 0;
+
+	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
 		u32 offset = MPTCP_SKB_CB(skb)->offset;
 		u32 data_len = skb->len - offset;
 		u32 count = min_t(size_t, len - copied, data_len);
@@ -1754,7 +1758,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			/* we will bulk release the skb memory later */
 			skb->destructor = NULL;
 			msk->rmem_released += skb->truesize;
-			__skb_unlink(skb, &msk->receive_queue);
+			__skb_unlink(skb, &sk->sk_receive_queue);
 			__kfree_skb(skb);
 		}
 
@@ -1875,16 +1879,9 @@ static void __mptcp_update_rmem(struct sock *sk)
 	msk->rmem_released = 0;
 }
 
-static void __mptcp_splice_receive_queue(struct sock *sk)
+static bool __mptcp_move_skbs(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
-}
-
-static bool __mptcp_move_skbs(struct mptcp_sock *msk)
-{
-	struct sock *sk = (struct sock *)msk;
 	unsigned int moved = 0;
 	bool ret, done;
 
@@ -1893,18 +1890,12 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
 		bool slowpath;
 
-		/* we can have data pending in the subflows only if the msk
-		 * receive buffer was full at subflow_data_ready() time,
-		 * that is an unlikely slow path.
-		 */
-		if (likely(!ssk))
+		if (unlikely(!ssk))
 			break;
 
 		slowpath = lock_sock_fast(ssk);
-		mptcp_data_lock(sk);
 		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
-		mptcp_data_unlock(sk);
 		tcp_cleanup_rbuf(ssk, moved);
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
@@ -1912,17 +1903,16 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	/* acquire the data lock only if some input data is pending */
 	ret = moved > 0;
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
-	    !skb_queue_empty_lockless(&sk->sk_receive_queue)) {
-		mptcp_data_lock(sk);
+	    !skb_queue_empty(&sk->sk_receive_queue)) {
 		__mptcp_update_rmem(sk);
 		ret |= __mptcp_ofo_queue(msk);
-		__mptcp_splice_receive_queue(sk);
-		mptcp_data_unlock(sk);
 		mptcp_cleanup_rbuf(msk);
 	}
-	if (ret)
+	if (ret) {
+		set_bit(MPTCP_DATA_READY, &msk->flags);
 		mptcp_check_data_fin((struct sock *)msk);
-	return !skb_queue_empty(&msk->receive_queue);
+	}
+	return ret;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -1938,7 +1928,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
 
-	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
+	lock_sock(sk);
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
 		copied = -ENOTCONN;
 		goto out_err;
@@ -1952,7 +1942,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags, &tss, &cmsg_flags);
+		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -1964,9 +1954,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		/* be sure to advertise window change */
 		mptcp_cleanup_rbuf(msk);
 
-		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
-			continue;
-
 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
 		 */
@@ -1993,7 +1980,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
 				 */
-				if (__mptcp_move_skbs(msk))
+				if (__mptcp_move_skbs(sk))
 					continue;
 				break;
 			}
@@ -2018,16 +2005,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		mptcp_wait_data(sk, &timeo);
 	}
 
-	if (skb_queue_empty_lockless(&sk->sk_receive_queue) &&
-	    skb_queue_empty(&msk->receive_queue)) {
-		/* entire backlog drained, clear DATA_READY. */
-		clear_bit(MPTCP_DATA_READY, &msk->flags);
-
-		/* .. race-breaker: ssk might have gotten new data
-		 * after last __mptcp_move_skbs() returned false.
+	if (skb_queue_empty(&sk->sk_receive_queue)) {
+		/* entire backlog drained, clear DATA_READY.
+		 * release_cb/__mptcp_move_skbs() will eventually set it again if needed
 		 */
-		if (unlikely(__mptcp_move_skbs(msk)))
-			set_bit(MPTCP_DATA_READY, &msk->flags);
+		clear_bit(MPTCP_DATA_READY, &msk->flags);
 	}
 
 out_err:
@@ -2376,7 +2358,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	INIT_WORK(&msk->work, mptcp_worker);
-	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
 	msk->wmem_reserved = 0;
@@ -2828,9 +2809,6 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 
 	__mptcp_clear_xmit(sk);
 
-	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
-	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
-
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
@@ -2882,6 +2860,8 @@ static void mptcp_release_cb(struct sock *sk)
 			flags |= BIT(MPTCP_PUSH_PENDING);
 		if (test_and_clear_bit(MPTCP_RETRANSMIT, &mptcp_sk(sk)->flags))
 			flags |= BIT(MPTCP_RETRANSMIT);
+		if (test_and_clear_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->flags))
+			flags |= BIT(MPTCP_DEQUEUE);
 		if (!flags)
 			break;
 
@@ -2898,6 +2878,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
+		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk))
+			sk->sk_data_ready(sk);
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2f22046a7565..d392ee44deb3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -111,6 +111,7 @@
 #define MPTCP_ERROR_REPORT	8
 #define MPTCP_RETRANSMIT	9
 #define MPTCP_WORK_SYNC_SETSOCKOPT 10
+#define MPTCP_DEQUEUE		11
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -244,7 +245,6 @@ struct mptcp_sock {
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
-	struct sk_buff_head receive_queue;
 	int		tx_pending_data;
 	int		size_goal_cache;
 	struct list_head conn_list;
-- 
2.26.3


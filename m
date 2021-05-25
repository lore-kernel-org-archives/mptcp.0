Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD42FB1
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621964266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIfnSKNQzCirITF0K5U5KzE6KpntffSxsuPOXTP6N+w=;
	b=SDPcDLjPhpFuHJnnuRCb9kejpC8I/NkXLiCo++lN3Js9C0tJrzab46y1a7FVVd9y0Hjl17
	apE+X1L1gEDIOlkt+hr0ad8RmAtK7UrDRXzOVibAKewqDcbgUuRNTIMdX/UGEBQWSO8CoA
	lBhfA2n9psdcFfxOqDePGDRjjTo1dys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-mb4FdqqNOVuz3kwjJR7YpA-1; Tue, 25 May 2021 13:37:44 -0400
X-MC-Unique: mb4FdqqNOVuz3kwjJR7YpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64F37C7406
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:43 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-92.ams2.redhat.com [10.36.115.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A3CD6100EBAF;
	Tue, 25 May 2021 17:37:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [RFC PATCH 4/4] mptcp: cleanup mem accounting.
Date: Tue, 25 May 2021 19:37:20 +0200
Message-Id: <db1629617d1d6bc841f12a56a781e29a6ba6317f.1621963632.git.pabeni@redhat.com>
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

After the previous patch, updating sk_forward_memory is cheap and
we can drop a lot of complexity from the MPTCP memory acconting,
removing the bulk fwd mem allocations for wmem and rmem.

Singed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 175 ++++---------------------------------------
 net/mptcp/protocol.h |  17 +----
 2 files changed, 14 insertions(+), 178 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 57deea409d0c..1a9ac2986581 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -900,116 +900,6 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
 		df->data_seq + df->data_len == msk->write_seq;
 }
 
-static int mptcp_wmem_with_overhead(int size)
-{
-	return size + ((sizeof(struct mptcp_data_frag) * size) >> PAGE_SHIFT);
-}
-
-static void __mptcp_wmem_reserve(struct sock *sk, int size)
-{
-	int amount = mptcp_wmem_with_overhead(size);
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	WARN_ON_ONCE(msk->wmem_reserved);
-	if (WARN_ON_ONCE(amount < 0))
-		amount = 0;
-
-	if (amount <= sk->sk_forward_alloc)
-		goto reserve;
-
-	/* under memory pressure try to reserve at most a single page
-	 * otherwise try to reserve the full estimate and fallback
-	 * to a single page before entering the error path
-	 */
-	if ((tcp_under_memory_pressure(sk) && amount > PAGE_SIZE) ||
-	    !sk_wmem_schedule(sk, amount)) {
-		if (amount <= PAGE_SIZE)
-			goto nomem;
-
-		amount = PAGE_SIZE;
-		if (!sk_wmem_schedule(sk, amount))
-			goto nomem;
-	}
-
-reserve:
-	msk->wmem_reserved = amount;
-	sk->sk_forward_alloc -= amount;
-	return;
-
-nomem:
-	/* we will wait for memory on next allocation */
-	msk->wmem_reserved = -1;
-}
-
-static void __mptcp_update_wmem(struct sock *sk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-#ifdef CONFIG_LOCKDEP
-	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
-#endif
-
-	if (!msk->wmem_reserved)
-		return;
-
-	if (msk->wmem_reserved < 0)
-		msk->wmem_reserved = 0;
-	if (msk->wmem_reserved > 0) {
-		sk->sk_forward_alloc += msk->wmem_reserved;
-		msk->wmem_reserved = 0;
-	}
-}
-
-static bool mptcp_wmem_alloc(struct sock *sk, int size)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	/* check for pre-existing error condition */
-	if (msk->wmem_reserved < 0)
-		return false;
-
-	if (msk->wmem_reserved >= size)
-		goto account;
-
-	if (!sk_wmem_schedule(sk, size)) {
-		mptcp_data_unlock(sk);
-		return false;
-	}
-
-	sk->sk_forward_alloc -= size;
-	msk->wmem_reserved += size;
-
-account:
-	msk->wmem_reserved -= size;
-	return true;
-}
-
-static void mptcp_wmem_uncharge(struct sock *sk, int size)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	if (msk->wmem_reserved < 0)
-		msk->wmem_reserved = 0;
-	msk->wmem_reserved += size;
-}
-
-static void mptcp_mem_reclaim_partial(struct sock *sk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	/* if we are experiencing a transint allocation error,
-	 * the forward allocation memory has been already
-	 * released
-	 */
-	if (msk->wmem_reserved < 0)
-		return;
-
-	sk->sk_forward_alloc += msk->wmem_reserved;
-	sk_mem_reclaim_partial(sk);
-	msk->wmem_reserved = sk->sk_forward_alloc;
-	sk->sk_forward_alloc = 0;
-}
-
 static void dfrag_uncharge(struct sock *sk, int len)
 {
 	sk_mem_uncharge(sk, len);
@@ -1066,12 +956,8 @@ static void __mptcp_clean_una(struct sock *sk)
 	}
 
 out:
-	if (cleaned) {
-		if (tcp_under_memory_pressure(sk)) {
-			__mptcp_update_wmem(sk);
-			sk_mem_reclaim_partial(sk);
-		}
-	}
+	if (cleaned && tcp_under_memory_pressure(sk))
+		sk_mem_reclaim_partial(sk);
 
 	if (snd_una == READ_ONCE(msk->snd_nxt)) {
 		if (msk->timer_ival && !mptcp_data_fin_enabled(msk))
@@ -1083,18 +969,10 @@ static void __mptcp_clean_una(struct sock *sk)
 
 static void __mptcp_clean_una_wakeup(struct sock *sk)
 {
-#ifdef CONFIG_LOCKDEP
-	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
-#endif
 	__mptcp_clean_una(sk);
 	mptcp_write_space(sk);
 }
 
-static void mptcp_clean_una_wakeup(struct sock *sk)
-{
-	__mptcp_clean_una_wakeup(sk);
-}
-
 static void mptcp_enter_memory_pressure(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -1229,7 +1107,7 @@ static bool mptcp_must_reclaim_memory(struct sock *sk, struct sock *ssk)
 static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
 {
 	if (unlikely(mptcp_must_reclaim_memory(sk, ssk)))
-		mptcp_mem_reclaim_partial(sk);
+		sk_mem_reclaim_partial(sk);
 	return __mptcp_alloc_tx_skb(sk, ssk, sk->sk_allocation);
 }
 
@@ -1533,10 +1411,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 				goto out;
 			}
 
-			if (unlikely(mptcp_must_reclaim_memory(sk, ssk))) {
-				__mptcp_update_wmem(sk);
+			if (unlikely(mptcp_must_reclaim_memory(sk, ssk)))
 				sk_mem_reclaim_partial(sk);
-			}
 			if (!__mptcp_alloc_tx_skb(sk, ssk, GFP_ATOMIC))
 				goto out;
 
@@ -1560,7 +1436,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
-	__mptcp_update_wmem(sk);
 	if (copied) {
 		mptcp_set_timeout(sk, ssk);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
@@ -1598,7 +1473,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
 
-	mptcp_lock_sock(sk, __mptcp_wmem_reserve(sk, min_t(size_t, 1 << 20, len)));
+	lock_sock(sk);
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
@@ -1611,8 +1486,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	pfrag = sk_page_frag(sk);
 
 	while (msg_data_left(msg)) {
-		int total_ts, frag_truesize = 0;
 		struct mptcp_data_frag *dfrag;
+		int frag_truesize = 0;
 		bool dfrag_collapsed;
 		size_t psize, offset;
 
@@ -1644,14 +1519,13 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		offset = dfrag->offset + dfrag->data_len;
 		psize = pfrag->size - offset;
 		psize = min_t(size_t, psize, msg_data_left(msg));
-		total_ts = psize + frag_truesize;
+		frag_truesize += psize;
 
-		if (!mptcp_wmem_alloc(sk, total_ts))
+		if (!sk_wmem_schedule(sk, frag_truesize))
 			goto wait_for_memory;
 
 		if (copy_page_from_iter(dfrag->page, offset, psize,
 					&msg->msg_iter) != psize) {
-			mptcp_wmem_uncharge(sk, psize + frag_truesize);
 			ret = -EFAULT;
 			goto out;
 		}
@@ -1659,7 +1533,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		/* data successfully copied into the write queue */
 		copied += psize;
 		dfrag->data_len += psize;
-		frag_truesize += psize;
 		pfrag->offset += frag_truesize;
 		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
 		msk->tx_pending_data += psize;
@@ -1668,6 +1541,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		 * Note: we charge such data both to sk and ssk
 		 */
 		sk_wmem_queued_add(sk, frag_truesize);
+		sk_mem_charge(sk, frag_truesize);
 		if (!dfrag_collapsed) {
 			get_page(dfrag->page);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
@@ -1719,7 +1593,6 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb, *tmp;
 	int copied = 0;
 
@@ -1755,9 +1628,10 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* we will bulk release the skb memory later */
+			/* avoid the indirect call, we know the destructor is sock_wfree */
 			skb->destructor = NULL;
-			msk->rmem_released += skb->truesize;
+			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			__kfree_skb(skb);
 		}
@@ -1867,17 +1741,6 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
-static void __mptcp_update_rmem(struct sock *sk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	if (!msk->rmem_released)
-		return;
-
-	atomic_sub(msk->rmem_released, &sk->sk_rmem_alloc);
-	sk_mem_uncharge(sk, msk->rmem_released);
-	msk->rmem_released = 0;
-}
 
 static bool __mptcp_move_skbs(struct sock *sk)
 {
@@ -1894,7 +1757,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
 			break;
 
 		slowpath = lock_sock_fast(ssk);
-		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 		tcp_cleanup_rbuf(ssk, moved);
 		unlock_sock_fast(ssk, slowpath);
@@ -1904,7 +1766,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
 	ret = moved > 0;
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
 	    !skb_queue_empty(&sk->sk_receive_queue)) {
-		__mptcp_update_rmem(sk);
 		ret |= __mptcp_ofo_queue(msk);
 		mptcp_cleanup_rbuf(msk);
 	}
@@ -2250,7 +2111,7 @@ static void __mptcp_retrans(struct sock *sk)
 	struct sock *ssk;
 	int ret;
 
-	mptcp_clean_una_wakeup(sk);
+	__mptcp_clean_una_wakeup(sk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2360,8 +2221,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
-	msk->wmem_reserved = 0;
-	msk->rmem_released = 0;
 	msk->tx_pending_data = 0;
 
 	msk->ack_hint = NULL;
@@ -2576,8 +2435,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	sk->sk_prot->destroy(sk);
 
-	WARN_ON_ONCE(msk->wmem_reserved);
-	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 
@@ -2889,12 +2746,6 @@ static void mptcp_release_cb(struct sock *sk)
 		__mptcp_clean_una_wakeup(sk);
 	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
 		__mptcp_error_report(sk);
-
-	/* push_pending may touch wmem_reserved, ensure we do the cleanup
-	 * later
-	 */
-	__mptcp_update_wmem(sk);
-	__mptcp_update_rmem(sk);
 }
 
 void mptcp_subflow_process_delegated(struct sock *ssk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d392ee44deb3..94ca8d6e2f97 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -223,7 +223,6 @@ struct mptcp_sock {
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
-	int		wmem_reserved;
 	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
@@ -231,7 +230,6 @@ struct mptcp_sock {
 	u64		wnd_end;
 	unsigned long	timer_ival;
 	u32		token;
-	int		rmem_released;
 	unsigned long	flags;
 	bool		can_ack;
 	bool		fully_established;
@@ -265,19 +263,6 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 };
 
-#define mptcp_lock_sock(___sk, cb) do {					\
-	struct sock *__sk = (___sk); /* silence macro reuse warning */	\
-	might_sleep();							\
-	spin_lock_bh(&__sk->sk_lock.slock);				\
-	if (__sk->sk_lock.owned)					\
-		__lock_sock(__sk);					\
-	cb;								\
-	__sk->sk_lock.owned = 1;					\
-	spin_unlock(&__sk->sk_lock.slock);				\
-	mutex_acquire(&__sk->sk_lock.dep_map, 0, 0, _RET_IP_);		\
-	local_bh_enable();						\
-} while (0)
-
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
 #define mptcp_data_unlock(sk) spin_unlock_bh(&(sk)->sk_lock.slock)
 
@@ -296,7 +281,7 @@ static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
 
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return tcp_space(sk) + READ_ONCE(mptcp_sk(sk)->rmem_released);
+	return tcp_space(sk);
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
-- 
2.26.3


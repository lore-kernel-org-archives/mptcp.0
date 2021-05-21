Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F50B71
	for <mptcp@lists.linux.dev>; Fri, 21 May 2021 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621593014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9ZWS5/taKH+y61UrpYld5dZjtXmLnEcw1oZNHcRXjrg=;
	b=OZR+aGmrGURECloBUbdLyWhuwj176eaZg+T8aHhpuVC92Xek3F3FgQd7tFVDQXdSziOb+v
	NNJyZMggPwZPAsRi91Gm6/JVSPEZ32GlTIYxLP4BtBeUAcNmr8P2gzD4m+KvuYfwof5f5P
	VVriqjCmP+zfTcGtLm9XHNFi3urqlNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-28ztsxTEO0WCmGnNYxbjrQ-1; Fri, 21 May 2021 06:30:12 -0400
X-MC-Unique: 28ztsxTEO0WCmGnNYxbjrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCC3C1853DB1
	for <mptcp@lists.linux.dev>; Fri, 21 May 2021 10:30:11 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-152.ams2.redhat.com [10.36.114.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 525E969FB1
	for <mptcp@lists.linux.dev>; Fri, 21 May 2021 10:30:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: drop tx skb cache
Date: Fri, 21 May 2021 12:30:07 +0200
Message-Id: <f3cf8531c9215fb77194e332a1aae5e954dbd2ea.1621592920.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The mentioned cache was introduced to reduce the number of skb
allocation in atomic context, but the required complexity is
excessive.

This change remove the mentioned cache.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
formally submitting this one. I keept a VM running self-tests for ~24h
with no issues
---
 net/mptcp/protocol.c | 89 ++------------------------------------------
 1 file changed, 4 insertions(+), 85 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 446acfb85493..1114a914d845 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -903,22 +903,14 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
 		df->data_seq + df->data_len == msk->write_seq;
 }
 
-static int mptcp_wmem_with_overhead(struct sock *sk, int size)
+static int mptcp_wmem_with_overhead(int size)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int ret, skbs;
-
-	ret = size + ((sizeof(struct mptcp_data_frag) * size) >> PAGE_SHIFT);
-	skbs = (msk->tx_pending_data + size) / msk->size_goal_cache;
-	if (skbs < msk->skb_tx_cache.qlen)
-		return ret;
-
-	return ret + (skbs - msk->skb_tx_cache.qlen) * SKB_TRUESIZE(MAX_TCP_HEADER);
+	return size + ((sizeof(struct mptcp_data_frag) * size) >> PAGE_SHIFT);
 }
 
 static void __mptcp_wmem_reserve(struct sock *sk, int size)
 {
-	int amount = mptcp_wmem_with_overhead(sk, size);
+	int amount = mptcp_wmem_with_overhead(size);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	WARN_ON_ONCE(msk->wmem_reserved);
@@ -1213,49 +1205,8 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
 	return NULL;
 }
 
-static bool mptcp_tx_cache_refill(struct sock *sk, int size,
-				  struct sk_buff_head *skbs, int *total_ts)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct sk_buff *skb;
-	int space_needed;
-
-	if (unlikely(tcp_under_memory_pressure(sk))) {
-		mptcp_mem_reclaim_partial(sk);
-
-		/* under pressure pre-allocate at most a single skb */
-		if (msk->skb_tx_cache.qlen)
-			return true;
-		space_needed = msk->size_goal_cache;
-	} else {
-		space_needed = msk->tx_pending_data + size -
-			       msk->skb_tx_cache.qlen * msk->size_goal_cache;
-	}
-
-	while (space_needed > 0) {
-		skb = __mptcp_do_alloc_tx_skb(sk, sk->sk_allocation);
-		if (unlikely(!skb)) {
-			/* under memory pressure, try to pass the caller a
-			 * single skb to allow forward progress
-			 */
-			while (skbs->qlen > 1) {
-				skb = __skb_dequeue_tail(skbs);
-				*total_ts -= skb->truesize;
-				__kfree_skb(skb);
-			}
-			return skbs->qlen > 0;
-		}
-
-		*total_ts += skb->truesize;
-		__skb_queue_tail(skbs, skb);
-		space_needed -= msk->size_goal_cache;
-	}
-	return true;
-}
-
 static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
 
 	if (ssk->sk_tx_skb_cache) {
@@ -1266,22 +1217,6 @@ static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
 		return true;
 	}
 
-	skb = skb_peek(&msk->skb_tx_cache);
-	if (skb) {
-		if (likely(sk_wmem_schedule(ssk, skb->truesize))) {
-			skb = __skb_dequeue(&msk->skb_tx_cache);
-			if (WARN_ON_ONCE(!skb))
-				return false;
-
-			mptcp_wmem_uncharge(sk, skb->truesize);
-			ssk->sk_tx_skb_cache = skb;
-			return true;
-		}
-
-		/* over memory limit, no point to try to allocate a new skb */
-		return false;
-	}
-
 	skb = __mptcp_do_alloc_tx_skb(sk, gfp);
 	if (!skb)
 		return false;
@@ -1297,7 +1232,6 @@ static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
 static bool mptcp_must_reclaim_memory(struct sock *sk, struct sock *ssk)
 {
 	return !ssk->sk_tx_skb_cache &&
-	       !skb_peek(&mptcp_sk(sk)->skb_tx_cache) &&
 	       tcp_under_memory_pressure(sk);
 }
 
@@ -1340,7 +1274,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	/* compute send limit */
 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
 	avail_size = info->size_goal;
-	msk->size_goal_cache = info->size_goal;
 	skb = tcp_write_queue_tail(ssk);
 	if (skb) {
 		/* Limit the write to the size available in the
@@ -1689,7 +1622,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	while (msg_data_left(msg)) {
 		int total_ts, frag_truesize = 0;
 		struct mptcp_data_frag *dfrag;
-		struct sk_buff_head skbs;
 		bool dfrag_collapsed;
 		size_t psize, offset;
 
@@ -1722,16 +1654,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		psize = pfrag->size - offset;
 		psize = min_t(size_t, psize, msg_data_left(msg));
 		total_ts = psize + frag_truesize;
-		__skb_queue_head_init(&skbs);
-		if (!mptcp_tx_cache_refill(sk, psize, &skbs, &total_ts))
-			goto wait_for_memory;
 
-		if (!mptcp_wmem_alloc(sk, total_ts)) {
-			__skb_queue_purge(&skbs);
+		if (!mptcp_wmem_alloc(sk, total_ts))
 			goto wait_for_memory;
-		}
 
-		skb_queue_splice_tail(&skbs, &msk->skb_tx_cache);
 		if (copy_page_from_iter(dfrag->page, offset, psize,
 					&msg->msg_iter) != psize) {
 			mptcp_wmem_uncharge(sk, psize + frag_truesize);
@@ -2460,13 +2386,11 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	INIT_WORK(&msk->work, mptcp_worker);
 	__skb_queue_head_init(&msk->receive_queue);
-	__skb_queue_head_init(&msk->skb_tx_cache);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
 	msk->wmem_reserved = 0;
 	msk->rmem_released = 0;
 	msk->tx_pending_data = 0;
-	msk->size_goal_cache = TCP_BASE_MSS;
 
 	msk->ack_hint = NULL;
 	msk->first = NULL;
@@ -2527,15 +2451,10 @@ static void __mptcp_clear_xmit(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
-	struct sk_buff *skb;
 
 	WRITE_ONCE(msk->first_pending, NULL);
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(sk, dfrag);
-	while ((skb = __skb_dequeue(&msk->skb_tx_cache)) != NULL) {
-		sk->sk_forward_alloc += skb->truesize;
-		kfree_skb(skb);
-	}
 }
 
 static void mptcp_cancel_work(struct sock *sk)
-- 
2.26.3


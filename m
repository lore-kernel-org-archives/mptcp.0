Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98325B1FC
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738354; cv=none; b=aj/If3UCAsLYCmM+GDaPVopb+gtGWP46kWwh9c5+2xzvSdPoYwFfm1g71Rs5CQHJqxXJ/AK3BsYtV/HZPGtyKH8CznNJdYrS5aFsaY8IB5VDfZfwMJPjnvMh8shz43qJq51MpWRAc+mw9gc/zzWb59ptMxFQDwGZ/CbF7YZ1WLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738354; c=relaxed/simple;
	bh=KTwGBFaTvYFo5/A3Q5B6l8O80gZ2fWUigeZQHH+wGAU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G+PcpGkeoNjzLwIWhGTQeKVAHnt1Ohx13WI8rW4O2L1+BZvEl1JGXRQBQma2vSQpWBofY0AijyFf5Q5vh/uVM/iTnj5J+J34p2ojnm25xgK1Xk/CapHmCqb6ufyi7r/2TEDEfBOZv4nE9nLLYaFHCYktiDK8lZMyIrNj4mHSdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGVkwWit; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGVkwWit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ByenU1fcy6RS0oLc8BaHraDbva0dWkIekm3Dn+izs7g=;
	b=EGVkwWit7cvzpjybynMffZeTgRqdma4wIIqAK0vluiNktOZu7dRYUm5zv65DHNNxukP97L
	hqsskvTDhxkk/oOUAVJZwBdrMIILEOmCt1jN/xVnhlQkRJIc0IfiUAPIMrCOxYr7e/DXzQ
	jRbRZYvyDRUvLfBHJ8U3ivxiA0psTfI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-_bUBGMZbP0CrhBDws48paQ-1; Mon,
 06 Oct 2025 04:12:30 -0400
X-MC-Unique: _bUBGMZbP0CrhBDws48paQ-1
X-Mimecast-MFC-AGG-ID: _bUBGMZbP0CrhBDws48paQ_1759738349
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 735C318002C3
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 955D0180035E
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 10/10] mptcp: leverage the backlog for RX packet processing
Date: Mon,  6 Oct 2025 10:12:09 +0200
Message-ID: <1cb19d6e65591b81610cc0dd8ef5d0a38605b3f1.1759737859.git.pabeni@redhat.com>
In-Reply-To: <cover.1759737859.git.pabeni@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4CqJsmhSQlXoFI2MuaB2p2vo8gEmsCrzNC3bKxDuo58_1759738349
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When the msk socket is owned or the msk receive buffer is full,
move the incoming skbs in a msk level backlog list. This avoid
traversing the joined subflows and acquiring the subflow level
socket lock at reception time, improving the RX performances.

when processing the backlog, use the fwd alloc memory borrowed from
the incoming subflow. skbs exceeding the msk receive space are
not dropped; instead they are kept into the backlog until the receive
buffer is freed. Dropping packets already acked at the TCP level is
explicitly discouraged by the RFC and would corrupt the data stream
for fallback sockets.

Special care is needed to avoid adding skbs to the backlog of a closed
msk, and to avoid leaving dangling references into the backlog
at subflow closing time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
  - consolidate ssk rcvbuf accunting in __mptcp_move_skb(), remove
    some code duplication
  - return soon in __mptcp_add_backlog() when dropping skbs due to
    the msk closed. This avoid later UaF
---
 net/mptcp/protocol.c | 137 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |   2 +-
 2 files changed, 79 insertions(+), 60 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d5d3da67d1ac..a97a92eccc502 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -696,7 +696,7 @@ static void __mptcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
-					   struct sock *ssk)
+					   struct sock *ssk, bool own_msk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -712,9 +712,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		struct sk_buff *skb;
 		bool fin;
 
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		/* try to move as much data as available */
 		map_remaining = subflow->map_data_len -
 				mptcp_subflow_get_map_offset(subflow);
@@ -742,9 +739,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			int bmem;
 
 			bmem = mptcp_init_skb(ssk, skb, offset, len);
-			sk_forward_alloc_add(sk, bmem);
+			if (own_msk)
+				sk_forward_alloc_add(sk, bmem);
+			else
+				msk->borrowed_mem += bmem;
 
-			if (true)
+			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf)
 				ret |= __mptcp_move_skb(sk, skb);
 			else
 				__mptcp_add_backlog(sk, skb);
@@ -866,7 +866,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	bool moved;
 
-	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
+	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err))
 		__mptcp_subflow_error_report(sk, ssk);
@@ -898,9 +898,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		/* Wake-up the reader only for in-sequence data */
 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 			sk->sk_data_ready(sk);
-		
 	} else {
-		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
+		__mptcp_move_skbs_from_subflow(msk, ssk, false);
 	}
 	mptcp_data_unlock(sk);
 }
@@ -2135,60 +2134,56 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
-static struct mptcp_subflow_context *
-__mptcp_first_ready_from(struct mptcp_sock *msk,
-			 struct mptcp_subflow_context *subflow)
-{
-	struct mptcp_subflow_context *start_subflow = subflow;
-
-	while (!READ_ONCE(subflow->data_avail)) {
-		subflow = mptcp_next_subflow(msk, subflow);
-		if (subflow == start_subflow)
-			return NULL;
-	}
-	return subflow;
-}
-
-static bool __mptcp_move_skbs(struct sock *sk)
+static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta)
 {
-	struct mptcp_subflow_context *subflow;
+	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff, list);
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	bool ret = false;
-
-	if (list_empty(&msk->conn_list))
-		return false;
-
-	subflow = list_first_entry(&msk->conn_list,
-				   struct mptcp_subflow_context, node);
-	for (;;) {
-		struct sock *ssk;
-		bool slowpath;
+	bool moved = false;
 
-		/*
-		 * As an optimization avoid traversing the subflows list
-		 * and ev. acquiring the subflow socket lock before baling out
-		 */
+	while (1) {
+		/* If the msk recvbuf is full stop, don't drop */
 		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 			break;
 
-		subflow = __mptcp_first_ready_from(msk, subflow);
-		if (!subflow)
-			break;
+		prefetch(skb->next);
+		list_del(&skb->list);
+		*delta += skb->truesize;
 
-		ssk = mptcp_subflow_tcp_sock(subflow);
-		slowpath = lock_sock_fast(ssk);
-		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
-		if (unlikely(ssk->sk_err))
-			__mptcp_error_report(sk);
-		unlock_sock_fast(ssk, slowpath);
+		moved |= __mptcp_move_skb(sk, skb);
+		if (list_empty(skbs))
+			break;
 
-		subflow = mptcp_next_subflow(msk, subflow);
+		skb = list_first_entry(skbs, struct sk_buff, list);
 	}
 
 	__mptcp_ofo_queue(msk);
-	if (ret)
+	if (moved)
 		mptcp_check_data_fin((struct sock *)msk);
-	return ret;
+	return moved;
+}
+
+static bool mptcp_move_skbs(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	bool moved = false;
+	LIST_HEAD(skbs);
+	u32 delta = 0;
+
+	mptcp_data_lock(sk);
+	while (!list_empty(&msk->backlog_list)) {
+		list_splice_init(&msk->backlog_list, &skbs);
+		mptcp_data_unlock(sk);
+		moved |= __mptcp_move_skbs(sk, &skbs, &delta);
+
+		mptcp_data_lock(sk);
+		if (!list_empty(&skbs)) {
+			list_splice(&skbs, &msk->backlog_list);
+			break;
+		}
+	}
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - delta);
+	mptcp_data_unlock(sk);
+	return moved;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
@@ -2254,7 +2249,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (skb_queue_empty(&sk->sk_receive_queue) && __mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
 			continue;
 
 		/* only the MPTCP socket status is relevant here. The exit
@@ -2559,6 +2554,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+
 	/* The first subflow can already be closed and still in the list */
 	if (subflow->close_event_done)
 		return;
@@ -2568,6 +2566,18 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
+	/* Remove any reference from the backlog to this ssk, accounting the
+	 * related skb directly to the main socket
+	 */
+	list_for_each_entry(skb, &msk->backlog_list, list) {
+		if (skb->sk != ssk)
+			continue;
+
+		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
+		skb->sk = sk;
+	}
+
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */
@@ -3509,23 +3519,29 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
-				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
-				      BIT(MPTCP_DEQUEUE))
+				      BIT(MPTCP_FLUSH_JOIN_LIST))
 
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
 	__must_hold(&sk->sk_lock.slock)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 delta = 0;
 
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
-		struct list_head join_list;
+		LIST_HEAD(join_list);
+		LIST_HEAD(skbs);
+
+		sk_forward_alloc_add(sk, msk->borrowed_mem);
+		msk->borrowed_mem = 0;
+
+		if (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf)
+			list_splice_init(&msk->backlog_list, &skbs);
 
-		if (!flags)
+		if (!flags && list_empty(&skbs))
 			break;
 
-		INIT_LIST_HEAD(&join_list);
 		list_splice_init(&msk->join_list, &join_list);
 
 		/* the following actions acquire the subflow socket lock
@@ -3544,7 +3560,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
-		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
+		if (!list_empty(&skbs) &&
+		    __mptcp_move_skbs(sk, &skbs, &delta)) {
 			/* notify ack seq update */
 			mptcp_cleanup_rbuf(msk, 0);
 			sk->sk_data_ready(sk);
@@ -3552,7 +3569,9 @@ static void mptcp_release_cb(struct sock *sk)
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
+		list_splice(&skbs, &msk->backlog_list);
 	}
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - delta);
 
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
@@ -3784,7 +3803,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		lock_sock(sk);
-		if (__mptcp_move_skbs(sk))
+		if (mptcp_move_skbs(sk))
 			mptcp_cleanup_rbuf(msk, 0);
 		*karg = mptcp_inq_hint(sk);
 		release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a21c4955f4cfb..cfabda66e7ac4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
-#define MPTCP_DEQUEUE		8
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -301,6 +300,7 @@ struct mptcp_sock {
 	u32		last_ack_recv;
 	unsigned long	timer_ival;
 	u32		token;
+	u32		borrowed_mem;
 	unsigned long	flags;
 	unsigned long	cb_flags;
 	bool		recovery;		/* closing subflow write queue reinjected */
-- 
2.51.0


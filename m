Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682AD34E745
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143552; cv=none; b=Fnig3zBSK4Ma6FSUPhUmmxxZedVHfzMsKkxqpCI246N76ihmHCk+/5WHzMVN/Og6fu8nK2AQJFfTAj6cUeW8ZRw5Oeo+gS4WHxs/WL2mpNgrdrL1MM4tWx5Z1ILHHuOQ6j5i48h+VPFhk+w9Jz2uFcqhN0yMAN6p2ng1q0GL25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143552; c=relaxed/simple;
	bh=LKSArMTqn22YhAzDwyKldOAlGOzBs48sHtNLe1HiHvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SEylOqbnWWvRZ74alsc6gmBT/WBmluj4O3vTmf4UVHRSLoHAjACg1T8/ucaG6179doePHIDpD9L3/9Hfn9IMAwoR/2dPKwXc4M2iQW4goM0JAxfC/ImKcSaDjCSwnVNQ3ZlCY9WsKYcla5ApQnFo37Q9j9kvrk1Fucvhv2K2Dls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZR8vi5gh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZR8vi5gh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otsrmCEqmWTbrR3ElRvevVQVuA2Fc2sFeePF2UV2PxY=;
	b=ZR8vi5ghek7xeR6WdtAK8sTj3FIQbG9WVhtqQmt4hx0mLPnONzs2craf/7rKs+wOUdz/Js
	XJMQRds7LZh3pVQehSvQfAjIIO9BXmT1CPr5+naMdWOslU0HNfEx7d4k62pkwzXLSwsvSH
	OxFQuA3l7NuGobaHn+701NPDekaqu7Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-avOX9E7BPIiEwi_gTK2Sxg-1; Wed,
 22 Oct 2025 10:32:24 -0400
X-MC-Unique: avOX9E7BPIiEwi_gTK2Sxg-1
X-Mimecast-MFC-AGG-ID: avOX9E7BPIiEwi_gTK2Sxg_1761143542
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6454B1801312;
	Wed, 22 Oct 2025 14:32:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3ACD1956056;
	Wed, 22 Oct 2025 14:32:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 11/11] mptcp: leverage the backlog for RX packet processing
Date: Wed, 22 Oct 2025 16:31:54 +0200
Message-ID: <2201f259d2176bca0ad37500a352658f7ef5a1f0.1761142784.git.pabeni@redhat.com>
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MlSq82DaxMXAn1IvN3x1LKqklDIqkGlJ1iv1QTdfLPc_1761143542
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When the msk socket is owned or the msk receive buffer is full,
move the incoming skbs in a msk level backlog list. This avoid
traversing the joined subflows and acquiring the subflow level
socket lock at reception time, improving the RX performances.

When processing the backlog, use the fwd alloc memory borrowed from
the incoming subflow. skbs exceeding the msk receive space are
not dropped; instead they are kept into the backlog until the receive
buffer is freed. Dropping packets already acked at the TCP level is
explicitly discouraged by the RFC and would corrupt the data stream
for fallback sockets.

Move the conditional reschedule in release_cb() to take action only
after the first loop iteration, to avoid rescheduling just before
releasing the lock.

Special care is needed to avoid adding skbs to the backlog of a closed
msk and to avoid leaving dangling references into the backlog
at subflow closing time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v5 -> v6:
  - do backlog len update asap to advise the correct window.
  - explicitly bound backlog processing loop to the maximum BL len

v4 -> v5:
  - consolidate ssk rcvbuf accunting in __mptcp_move_skb(), remove
    some code duplication
  - return soon in __mptcp_add_backlog() when dropping skbs due to
    the msk closed. This avoid later UaF
---
 net/mptcp/protocol.c | 151 +++++++++++++++++++++++++++----------------
 net/mptcp/protocol.h |   2 +-
 2 files changed, 96 insertions(+), 57 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5a1d8f9e0fb0ec..0aae17ab77edb2 100644
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
@@ -2135,60 +2134,92 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
-static struct mptcp_subflow_context *
-__mptcp_first_ready_from(struct mptcp_sock *msk,
-			 struct mptcp_subflow_context *subflow)
+static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta)
 {
-	struct mptcp_subflow_context *start_subflow = subflow;
+	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff, list);
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	bool moved = false;
+
+	*delta = 0;
+	while (1) {
+		/* If the msk recvbuf is full stop, don't drop */
+		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+			break;
+
+		prefetch(skb->next);
+		list_del(&skb->list);
+		*delta += skb->truesize;
+
+		moved |= __mptcp_move_skb(sk, skb);
+		if (list_empty(skbs))
+			break;
 
-	while (!READ_ONCE(subflow->data_avail)) {
-		subflow = mptcp_next_subflow(msk, subflow);
-		if (subflow == start_subflow)
-			return NULL;
+		skb = list_first_entry(skbs, struct sk_buff, list);
 	}
-	return subflow;
+
+	__mptcp_ofo_queue(msk);
+	if (moved)
+		mptcp_check_data_fin((struct sock *)msk);
+	return moved;
 }
 
-static bool __mptcp_move_skbs(struct sock *sk)
+static bool mptcp_can_spool_backlog(struct sock *sk, u32 moved,
+				    struct list_head *skbs)
 {
-	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	bool ret = false;
 
-	if (list_empty(&msk->conn_list))
+	if (list_empty(&msk->backlog_list))
 		return false;
 
-	subflow = list_first_entry(&msk->conn_list,
-				   struct mptcp_subflow_context, node);
-	for (;;) {
-		struct sock *ssk;
-		bool slowpath;
+	/* Borrowed mem could be zero only in the unlikely event that the bl
+	 * is full
+	 */
+	if (likely(msk->borrowed_mem)) {
+		sk_forward_alloc_add(sk, msk->borrowed_mem);
+		msk->borrowed_mem = 0;
+		sk->sk_reserved_mem = msk->backlog_len;
+	}
 
-		/*
-		 * As an optimization avoid traversing the subflows list
-		 * and ev. acquiring the subflow socket lock before baling out
-		 */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
+	/* Limit the backlog loop to the maximum backlog size; moved skbs are
+	 * accounted on both the backlog and the receive buffer; the caller
+	 * should update the backlog usage ASAP, to avoid underestimate the
+	 * rcvwnd.
+	 */
+	if (moved > sk->sk_rcvbuf || sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+		return false;
 
-		subflow = __mptcp_first_ready_from(msk, subflow);
-		if (!subflow)
-			break;
+	INIT_LIST_HEAD(skbs);
+	list_splice_init(&msk->backlog_list, skbs);
+	return true;
+}
 
-		ssk = mptcp_subflow_tcp_sock(subflow);
-		slowpath = lock_sock_fast(ssk);
-		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
-		if (unlikely(ssk->sk_err))
-			__mptcp_error_report(sk);
-		unlock_sock_fast(ssk, slowpath);
+static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
+				  struct list_head *skbs)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
 
-		subflow = mptcp_next_subflow(msk, subflow);
-	}
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
+	list_splice(skbs, &msk->backlog_list);
+	sk->sk_reserved_mem = msk->backlog_len;
+}
 
-	__mptcp_ofo_queue(msk);
-	if (ret)
-		mptcp_check_data_fin((struct sock *)msk);
-	return ret;
+static bool mptcp_move_skbs(struct sock *sk)
+{
+	u32 moved, total_moved = 0;
+	struct list_head skbs;
+	bool enqueued = false;
+
+	mptcp_data_lock(sk);
+	while (mptcp_can_spool_backlog(sk, total_moved, &skbs)) {
+		mptcp_data_unlock(sk);
+		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
+
+		mptcp_data_lock(sk);
+		total_moved += moved;
+		mptcp_backlog_spooled(sk, moved, &skbs);
+	}
+	mptcp_data_unlock(sk);
+	return enqueued;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
@@ -2254,7 +2285,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (skb_queue_empty(&sk->sk_receive_queue) && __mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
 			continue;
 
 		/* only the MPTCP socket status is relevant here. The exit
@@ -3521,20 +3552,22 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
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
+	u32 moved, total_moved = 0;
 
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
-		struct list_head join_list;
+		struct list_head join_list, skbs;
+		bool spool_bl;
 
-		if (!flags)
+		spool_bl = mptcp_can_spool_backlog(sk, total_moved, &skbs);
+		if (!flags && !spool_bl)
 			break;
 
 		INIT_LIST_HEAD(&join_list);
@@ -3550,20 +3583,26 @@ static void mptcp_release_cb(struct sock *sk)
 		msk->cb_flags &= ~flags;
 		spin_unlock_bh(&sk->sk_lock.slock);
 
+		if (total_moved)
+			cond_resched();
+
 		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
 			__mptcp_flush_join_list(sk, &join_list);
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
-		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
+		if (spool_bl && __mptcp_move_skbs(sk, &skbs, &moved)) {
 			/* notify ack seq update */
 			mptcp_cleanup_rbuf(msk, 0);
 			sk->sk_data_ready(sk);
 		}
 
-		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
+		if (spool_bl) {
+			total_moved += moved;
+			mptcp_backlog_spooled(sk, moved, &skbs);
+		}
 	}
 
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
@@ -3796,7 +3835,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		lock_sock(sk);
-		if (__mptcp_move_skbs(sk))
+		if (mptcp_move_skbs(sk))
 			mptcp_cleanup_rbuf(msk, 0);
 		*karg = mptcp_inq_hint(sk);
 		release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d814e8151458d5..9e2a44546354a0 100644
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


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D227467B
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271970; cv=none; b=dgc8f0nl2WgexCATAQ7GdIKx8neNWSQgxueholJ0PHZmRK+SvCxqq9WHSd3j8REqNQEdsYC9jUj90dkk3RMNJfPGRLSN73buF/x74oeIU1cX7/2guqJAfuUkXVYwUfwuCcbc8u6tPWq4jsD4ysJbZUzRdldKPOh2LS5Rhpm4gWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271970; c=relaxed/simple;
	bh=uw+nRe4qcjNIeSfTSzfG+izN9upcaSpok9LGosYECdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IJ52xwFAk8J0o6B3jcltCkTfByAVBo5c36Ey2fNR5ebGdLue2Ve5/D6H+50TWkvt+4UPBLQ43ZfH05PDOfTJb+o1fJbUn93a5Qvm0Ic8+/xGs0e3Ebv8WlJD9QfxWmAThHAHiwPr9KLtA2JDuPxKhxgErSEdYFgcUF4BclGWgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8kOnrkT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8kOnrkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762271967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aT78DcoMiIk0quNF0wo3+4OIQ5TDL9cBBTMbV1xBiug=;
	b=S8kOnrkTu915E9MHsD0XwidAjMJ2RHZh9hfyDxGANDsoJx3h/MQ19L+54ko67mlXCQkB/l
	UEac1f8RQ6QHvQRb2zU6pDA8QvMc1v0QWadaxREE27Aun8U1C/1kWJEAbUoSCbLJwfGQR/
	E7gipmlRaDfO41E1/KWY9ijKQ7mXkxM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-zVQUlXpeMd-l185bS6F3qg-1; Tue,
 04 Nov 2025 10:59:24 -0500
X-MC-Unique: zVQUlXpeMd-l185bS6F3qg-1
X-Mimecast-MFC-AGG-ID: zVQUlXpeMd-l185bS6F3qg_1762271963
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 701DE19560A2;
	Tue,  4 Nov 2025 15:59:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.199])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50E41180044F;
	Tue,  4 Nov 2025 15:59:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v8 4/4] mptcp: leverage the backlog for RX packet processing
Date: Tue,  4 Nov 2025 16:59:04 +0100
Message-ID: <44e2efcff50d5c45c9a72b1efa15528e81166d34.1762271864.git.pabeni@redhat.com>
In-Reply-To: <cover.1762271864.git.pabeni@redhat.com>
References: <cover.1762271864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2t5xbD9-3ZAVSDhzrTS4cHnOLSnQCzEDt6Q3041Bf5A_1762271963
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

Special care is needed to avoid adding skbs to the backlog of a closed
msk and to avoid leaving dangling references into the backlog
at subflow closing time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v6 -> v7:
  - do not limit the overall backlog spooling loop, it's hard to do it
    right and the pre backlog code did not care for the similar existing
    loop

v5 -> v6:
  - do backlog len update asap to advise the correct window.
  - explicitly bound backlog processing loop to the maximum BL len

v4 -> v5:
  - consolidate ssk rcvbuf accunting in __mptcp_move_skb(), remove
    some code duplication
  - return soon in __mptcp_add_backlog() when dropping skbs due to
    the msk closed. This avoid later UaF
---
 net/mptcp/protocol.c | 121 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |   1 -
 2 files changed, 68 insertions(+), 54 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d075db13bb72..01114456dec6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -684,7 +684,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
-					   struct sock *ssk)
+					   struct sock *ssk, bool own_msk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -700,9 +700,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		struct sk_buff *skb;
 		bool fin;
 
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		/* try to move as much data as available */
 		map_remaining = subflow->map_data_len -
 				mptcp_subflow_get_map_offset(subflow);
@@ -730,7 +727,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (true) {
+			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
@@ -854,7 +851,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	bool moved;
 
-	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
+	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err))
 		__mptcp_subflow_error_report(sk, ssk);
@@ -887,7 +884,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 			sk->sk_data_ready(sk);
 	} else {
-		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
+		__mptcp_move_skbs_from_subflow(msk, ssk, false);
 	}
 	mptcp_data_unlock(sk);
 }
@@ -2128,60 +2125,74 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
+static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 {
-	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	bool ret = false;
 
-	if (list_empty(&msk->conn_list))
+	/* Don't spool the backlog if the rcvbuf is full. */
+	if (list_empty(&msk->backlog_list) ||
+	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 		return false;
 
-	subflow = list_first_entry(&msk->conn_list,
-				   struct mptcp_subflow_context, node);
-	for (;;) {
-		struct sock *ssk;
-		bool slowpath;
+	INIT_LIST_HEAD(skbs);
+	list_splice_init(&msk->backlog_list, skbs);
+	return true;
+}
 
-		/*
-		 * As an optimization avoid traversing the subflows list
-		 * and ev. acquiring the subflow socket lock before baling out
-		 */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
+static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
+				  struct list_head *skbs)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
 
-		subflow = __mptcp_first_ready_from(msk, subflow);
-		if (!subflow)
-			break;
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
+	list_splice(skbs, &msk->backlog_list);
+}
 
-		ssk = mptcp_subflow_tcp_sock(subflow);
-		slowpath = lock_sock_fast(ssk);
-		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
-		if (unlikely(ssk->sk_err))
-			__mptcp_error_report(sk);
-		unlock_sock_fast(ssk, slowpath);
+static bool mptcp_move_skbs(struct sock *sk)
+{
+	struct list_head skbs;
+	bool enqueued = false;
+	u32 moved;
 
-		subflow = mptcp_next_subflow(msk, subflow);
-	}
+	mptcp_data_lock(sk);
+	while (mptcp_can_spool_backlog(sk, &skbs)) {
+		mptcp_data_unlock(sk);
+		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
 
-	__mptcp_ofo_queue(msk);
-	if (ret)
-		mptcp_check_data_fin((struct sock *)msk);
-	return ret;
+		mptcp_data_lock(sk);
+		mptcp_backlog_spooled(sk, moved, &skbs);
+	}
+	mptcp_data_unlock(sk);
+	return enqueued;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
@@ -2247,7 +2258,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (skb_queue_empty(&sk->sk_receive_queue) && __mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
 			continue;
 
 		/* only the MPTCP socket status is relevant here. The exit
@@ -3532,8 +3543,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
-				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
-				      BIT(MPTCP_DEQUEUE))
+				      BIT(MPTCP_FLUSH_JOIN_LIST))
 
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
@@ -3543,9 +3553,12 @@ static void mptcp_release_cb(struct sock *sk)
 
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
-		struct list_head join_list;
+		struct list_head join_list, skbs;
+		bool spool_bl;
+		u32 moved;
 
-		if (!flags)
+		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
+		if (!flags && !spool_bl)
 			break;
 
 		INIT_LIST_HEAD(&join_list);
@@ -3567,7 +3580,7 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
-		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
+		if (spool_bl && __mptcp_move_skbs(sk, &skbs, &moved)) {
 			/* notify ack seq update */
 			mptcp_cleanup_rbuf(msk, 0);
 			sk->sk_data_ready(sk);
@@ -3575,6 +3588,8 @@ static void mptcp_release_cb(struct sock *sk)
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
+		if (spool_bl)
+			mptcp_backlog_spooled(sk, moved, &skbs);
 	}
 
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
@@ -3807,7 +3822,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		lock_sock(sk);
-		if (__mptcp_move_skbs(sk))
+		if (mptcp_move_skbs(sk))
 			mptcp_cleanup_rbuf(msk, 0);
 		*karg = mptcp_inq_hint(sk);
 		release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ca43d345b65a..d0881db16b12 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
-#define MPTCP_DEQUEUE		8
 
 struct mptcp_skb_cb {
 	u64 map_seq;
-- 
2.51.0


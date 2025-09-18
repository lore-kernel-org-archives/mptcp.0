Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7AD289805
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215722; cv=none; b=kXYLRKXVT//2BMbD1t7rE38wRIdSg4NVwRT1e9n/xCG8EwWkqw0Wy0ujeLleCZXdFQu9V7GWTqAHhz8BfMcFnB+ROMxkxNDVb5x1vGnjV5vw546P4pvmL2uo64zUSJZePH7Ji/dLOT2z/MjNEHJ/4oC0IvIAeoT9PJZQvQhhb6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215722; c=relaxed/simple;
	bh=4TZuGHmyPk9EUVHHxxiGLuUY0vPKc6ylLAl7a593+FM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CuBk3agt9EkMM0xV+yOKwZ33RYh3nNMH0TyA2cMnbIkFNEbma3OFBj+VtDkjjj/qFl4Myd9uj8AEqwoLZAbFpWyvowRMTGeGb30bBCX3DkGsCjtDldxzIOrBJQbLmLF/SGWBMy06UY9XuDXyn0rXdtpyetb3sHPAl/KDdNZeWRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXEDFyQ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXEDFyQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfirj13vacRvl7AklI0OVCYRVQqIfzbjpY5PEC8XTKU=;
	b=JXEDFyQ7ml5FpmlvYBHAJf+l18g/T3Ileh8K/eStU2Igr6H7f/poXGeEhJByYyCj3WKR1i
	F1mDuZ3PokqSbPF6fbomPuBQX/3Ks+6aMTuhzlxvTJWUvr4gORu/XsjcfwYC8TwZXwute0
	p/ZsG5H8ogEdQf4qNx+kG1/dLaCB+1k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-1NoGOxuZPZmZtWCgd7Dbjg-1; Thu,
 18 Sep 2025 13:15:17 -0400
X-MC-Unique: 1NoGOxuZPZmZtWCgd7Dbjg-1
X-Mimecast-MFC-AGG-ID: 1NoGOxuZPZmZtWCgd7Dbjg_1758215717
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC9CD1800290
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 230C030002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 09/12] mptcp: leverage the sk backlog for RX packet processing.
Date: Thu, 18 Sep 2025 19:14:51 +0200
Message-ID: <0239ffcbcd9c77f6b4eaf0897583310cae950dc2.1758214564.git.pabeni@redhat.com>
In-Reply-To: <cover.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uf4PEvt3zaWSPFbPt2s6piyaeFvDsf-tt83hQxxX4ZI_1758215717
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This streamline the RX path implementation and improves the RX
performances by reducing the subflow-level locking and the amount of
work done under the msk socket lock; the implementation mirror closely
the TCP backlog processing.

Note that MPTCP needs now to traverse the existing subflow looking for
data that was left there due to the msk receive buffer full, only after
that recvmsg completely empties the receive queue.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 103 ++++++++++++++++++++++++++++++-------------
 net/mptcp/protocol.h |   2 +-
 2 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02be42d3d11e6..07326c1e6fbae 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -355,6 +355,27 @@ static void mptcp_init_skb(struct sock *ssk,
 	skb_dst_drop(skb);
 }
 
+static void __mptcp_add_backlog(struct sock *sk, struct sock *ssk,
+				struct sk_buff *skb)
+{
+	struct sk_buff *tail = sk->sk_backlog.tail;
+	bool fragstolen;
+	int delta;
+
+	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq) {
+		delta = __mptcp_try_coalesce(sk, tail, skb, &fragstolen);
+		if (delta) {
+			sk->sk_backlog.len += delta;
+			kfree_skb_partial(skb, fragstolen);
+			return;
+		}
+	}
+
+	/* mptcp checks the limit before adding the skb to the backlog */
+	__sk_add_backlog(sk, skb);
+	sk->sk_backlog.len += skb->truesize;
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -643,7 +664,7 @@ static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
-					   struct sock *ssk)
+					   struct sock *ssk, bool own_msk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -654,12 +675,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
 	do {
+		int mem = own_msk ? sk_rmem_alloc_get(sk) : sk->sk_backlog.len;
 		u32 map_remaining, offset;
 		u32 seq = tp->copied_seq;
 		struct sk_buff *skb;
 		bool fin;
 
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+		if (mem > READ_ONCE(sk->sk_rcvbuf))
 			break;
 
 		/* try to move as much data as available */
@@ -689,7 +711,11 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 			skb_orphan(skb);
-			ret = __mptcp_move_skb(sk, skb) || ret;
+
+			if (own_msk)
+				ret |= __mptcp_move_skb(sk, skb);
+			else
+				__mptcp_add_backlog(sk, ssk, skb);
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
@@ -710,7 +736,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 	} while (more_data_avail);
 
-	if (ret)
+	if (ret && own_msk)
 		msk->last_data_recv = tcp_jiffies32;
 	return ret;
 }
@@ -808,7 +834,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	bool moved;
 
-	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
+	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err))
 		__mptcp_subflow_error_report(sk, ssk);
@@ -823,18 +849,10 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
-static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	/* Wake-up the reader only for in-sequence data */
-	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
-		sk->sk_data_ready(sk);
-}
-
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* The peer can send data while we are shutting down this
 	 * subflow at msk destruction time, but we must avoid enqueuing
@@ -844,13 +862,33 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		return;
 
 	mptcp_data_lock(sk);
-	if (!sock_owned_by_user(sk))
-		__mptcp_data_ready(sk, ssk);
-	else
-		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
+	if (!sock_owned_by_user(sk)) {
+		/* Wake-up the reader only for in-sequence data */
+		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
+			sk->sk_data_ready(sk);
+	} else {
+		__mptcp_move_skbs_from_subflow(msk, ssk, false);
+		if (unlikely(ssk->sk_err))
+			__set_bit(MPTCP_ERROR_REPORT,  &msk->cb_flags);
+	}
 	mptcp_data_unlock(sk);
 }
 
+static int mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (__mptcp_move_skb(sk, skb)) {
+		msk->last_data_recv = tcp_jiffies32;
+		__mptcp_ofo_queue(msk);
+		/* notify ack seq update */
+		mptcp_cleanup_rbuf(msk, 0);
+		mptcp_check_data_fin(sk);
+		sk->sk_data_ready(sk);
+	}
+	return 0;
+}
+
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
@@ -2112,7 +2150,7 @@ static bool __mptcp_move_skbs(struct sock *sk)
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		slowpath = lock_sock_fast(ssk);
-		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
+		ret = __mptcp_move_skbs_from_subflow(msk, ssk, true) || ret;
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
 		unlock_sock_fast(ssk, slowpath);
@@ -2188,8 +2226,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (skb_queue_empty(&sk->sk_receive_queue) && __mptcp_move_skbs(sk))
-			continue;
+		if (skb_queue_empty(&sk->sk_receive_queue)) {
+			__sk_flush_backlog(sk);
+			if (!skb_queue_empty(&sk->sk_receive_queue) ||
+			    __mptcp_move_skbs(sk))
+				continue;
+		}
 
 		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -2537,7 +2579,6 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 		mptcp_close_ssk(sk, ssk, subflow);
 	}
-
 }
 
 static bool mptcp_close_tout_expired(const struct sock *sk)
@@ -3121,6 +3162,13 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
 	mptcp_pm_connection_closed(msk);
 
+	/* process the backlog; note that it never destroies the msk */
+	local_bh_disable();
+	bh_lock_sock(sk);
+	__release_sock(sk);
+	bh_unlock_sock(sk);
+	local_bh_enable();
+
 	if (sk->sk_state == TCP_CLOSE) {
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
@@ -3421,8 +3469,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
-				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
-				      BIT(MPTCP_DEQUEUE))
+				      BIT(MPTCP_FLUSH_JOIN_LIST))
 
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
@@ -3456,11 +3503,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
-		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
-			/* notify ack seq update */
-			mptcp_cleanup_rbuf(msk, 0);
-			sk->sk_data_ready(sk);
-		}
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
@@ -3696,8 +3738,6 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		lock_sock(sk);
-		if (__mptcp_move_skbs(sk))
-			mptcp_cleanup_rbuf(msk, 0);
 		*karg = mptcp_inq_hint(sk);
 		release_sock(sk);
 		break;
@@ -3809,6 +3849,7 @@ static struct proto mptcp_prot = {
 	.sendmsg	= mptcp_sendmsg,
 	.ioctl		= mptcp_ioctl,
 	.recvmsg	= mptcp_recvmsg,
+	.backlog_rcv	= mptcp_move_skb,
 	.release_cb	= mptcp_release_cb,
 	.hash		= mptcp_hash,
 	.unhash		= mptcp_unhash,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6ac58e92a1aa3..7bfd4e0d21a8a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
-#define MPTCP_DEQUEUE		8
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -408,6 +407,7 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 static inline int __mptcp_space(const struct sock *sk)
 {
 	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
+				    READ_ONCE(sk->sk_backlog.len) -
 				    sk_rmem_alloc_get(sk));
 }
 
-- 
2.51.0


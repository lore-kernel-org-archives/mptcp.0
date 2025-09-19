Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34C238171
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297237; cv=none; b=OttbSOUSJc6e7kZ8UibzmN+U19N4tNQvlRvIKTgo6TL+3BP6XZEjo0VexBiUbjnSYLcbUkEWRWO0/14ta9rJ3ngXZbsQtY6HQFAnxM8FhE/ExaSWTlbZTCViWpKkjXrL/xg+iYneqfvXv8Kntr+0wmX/q67MQsoe44nIgn5svAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297237; c=relaxed/simple;
	bh=K4p8gtktm/tuB0liGUqVkJlJ8oAnLO3X76hg7jyRizw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XxFW89rV2OLESpPIEA+vh9t5YA2Hw8pVkE8q0/rGmZa+A3nBhSOAfMYHc9PHJbybb55Fp7zZxZ+1fXiVmJ5j6UWcHT0OJiZuPUrDFlGoKRG3F3NXFUCfBVPSdE5vEJDUBJGibM8Om6gDift7rydPinDHSXuFsr+WZMcyPOeUPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlyUGR+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlyUGR+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roCOWYSlmbnc6C2OWUhmornSiXR8e+hTye8Q6K9kfE0=;
	b=SlyUGR+PRXYUhuLK2TR5QE/G/74V7s//VURbTQQ1SCugSG/Vqj+mXoUE5BPmk8D/IS5fGR
	stRxtjgC0z4EG+FvW64ZP5O70ubXQq95F8a0zwRL4JSoOM5iyEZG+6PswE+hHn92UPiQ5q
	oNS7ZMqzR+tDkWiR34X/UjM1TkTYbSA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-qDBjnDpcNPixJmCm4S_Hgg-1; Fri,
 19 Sep 2025 11:53:52 -0400
X-MC-Unique: qDBjnDpcNPixJmCm4S_Hgg-1
X-Mimecast-MFC-AGG-ID: qDBjnDpcNPixJmCm4S_Hgg_1758297231
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2CC9180034F
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3C331800452
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 10/12] mptcp: leverage the sk backlog for RX packet processing.
Date: Fri, 19 Sep 2025 17:53:24 +0200
Message-ID: <5d137f1505b6d41092fcbc50e1ad65c8f0cc9440.1758296923.git.pabeni@redhat.com>
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rYFqJG-lPlxdqEmygiComLoC-HeelZ_EYTSn5b4wqg8_1758297231
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
index c8b02048126a9..201e6ac5fe631 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -360,6 +360,27 @@ static void mptcp_init_skb(struct sock *ssk,
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
@@ -648,7 +669,7 @@ static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
-					   struct sock *ssk)
+					   struct sock *ssk, bool own_msk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -659,12 +680,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
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
@@ -694,7 +716,11 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
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
@@ -715,7 +741,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 	} while (more_data_avail);
 
-	if (ret)
+	if (ret && own_msk)
 		msk->last_data_recv = tcp_jiffies32;
 	return ret;
 }
@@ -813,7 +839,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	bool moved;
 
-	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
+	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err))
 		__mptcp_subflow_error_report(sk, ssk);
@@ -828,18 +854,10 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
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
@@ -849,13 +867,33 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
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
@@ -2117,7 +2155,7 @@ static bool __mptcp_move_skbs(struct sock *sk)
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		slowpath = lock_sock_fast(ssk);
-		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
+		ret = __mptcp_move_skbs_from_subflow(msk, ssk, true) || ret;
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
 		unlock_sock_fast(ssk, slowpath);
@@ -2193,8 +2231,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
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
@@ -2542,7 +2584,6 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 		mptcp_close_ssk(sk, ssk, subflow);
 	}
-
 }
 
 static bool mptcp_close_tout_expired(const struct sock *sk)
@@ -3126,6 +3167,13 @@ bool __mptcp_close(struct sock *sk, long timeout)
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
@@ -3429,8 +3477,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
-				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
-				      BIT(MPTCP_DEQUEUE))
+				      BIT(MPTCP_FLUSH_JOIN_LIST))
 
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
@@ -3464,11 +3511,6 @@ static void mptcp_release_cb(struct sock *sk)
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
@@ -3704,8 +3746,6 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		lock_sock(sk);
-		if (__mptcp_move_skbs(sk))
-			mptcp_cleanup_rbuf(msk, 0);
 		*karg = mptcp_inq_hint(sk);
 		release_sock(sk);
 		break;
@@ -3817,6 +3857,7 @@ static struct proto mptcp_prot = {
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


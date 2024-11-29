Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8B1A01B8
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732902320; cv=none; b=crATHYpN4+vfYZoHPPUa+xw6GD7Fxfkyc6og0GAsBwX56HPHume/XWXScnJY4bolX1oQjg/wNcWhn9qOF08YUF/D1UD1jRKaE8/khVXUEruHRmXWAA7U5TtJdT/PNHoAd0PyCcoWZ8f17wCo1ZgTDlapbLE1o5Xn55cNrKMOKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732902320; c=relaxed/simple;
	bh=+et46xe7dXH7E+cqite9xGpuZUuKui3Tz8SoyamHWHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=a4h5H2qtDzbSTC1BvBXHV4IYtO+CK7gjX9z5KbnZPwe/rgOF+wZi9DLWSI548ds/LfSJefpxK9sExSbtSdHmerQ6P5hyJtY5M4bln4Zmb3Y9peo6fy+ZLt5ZMdapjRIpSKyNBW2aQxjU4+9RpBQVnzZ02eO9iziOw6b8YH/6rUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjkGctOR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjkGctOR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732902318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIWefwGQCRsRAodeRnbqsw99HxuzH3ERqs+5oT8ij6I=;
	b=XjkGctORQBAIPxmLYZQrhzlUNa6v8+2mockSb1WnRyMm1rz3uXic8Qs/a/u1prEmcdNTVi
	0BVeVXCwtSemm8ez5orETQO/7WxAg3L9sTuK9yVItBqSZDLSXA4O1BW9hZ/6WTq1WFpZv3
	KxnHLHHYJs+OkDQOc08SiCh/NPiwW5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-_TZYmieGPwmuL-Pm3jxEuA-1; Fri,
 29 Nov 2024 12:45:16 -0500
X-MC-Unique: _TZYmieGPwmuL-Pm3jxEuA-1
X-Mimecast-MFC-AGG-ID: _TZYmieGPwmuL-Pm3jxEuA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD6E81955EB3
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F01F81955D45
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next-next 2/3] mptcp: move the whole rx path under msk socket lock protection
Date: Fri, 29 Nov 2024 18:45:04 +0100
Message-ID: <19310c3f96743f3298c029ec5a89b4e4f1ed10b9.1732902181.git.pabeni@redhat.com>
In-Reply-To: <cover.1732902181.git.pabeni@redhat.com>
References: <cover.1732902181.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NYyj60oWeWypvYkq3z8yUuU_J0Msh5gKWhX0PDy1Ixo_1732902315
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After commit c2e6048fa1cf ("mptcp: fix race in release_cb") it's
pretty straight forward move the whole MPTCP rx path under the socket
lock leveraging the release_cb.

We can drop a bunch of spin_lock pairs in the receive functions, use
a single receive queue and invoke __mptcp_move_skbs only when subflows
ask for it.

This will allow more cleanup in the next patch

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  2 ++
 net/mptcp/protocol.c | 76 +++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  2 +-
 3 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index a29ff901df75..fb945c0d50bf 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -49,6 +49,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	mptcp_data_lock(sk);
+	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
 	mptcp_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
@@ -65,6 +66,7 @@ void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflo
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb;
 
+	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 	skb = skb_peek_tail(&sk->sk_receive_queue);
 	if (skb) {
 		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f768aa4473fb..159add48f6d9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -845,7 +845,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved > 0;
 }
 
-void mptcp_data_ready(struct sock *sk, struct sock *ssk)
+static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -868,9 +868,17 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		return;
 
 	/* Wake-up the reader only for in-sequence data */
-	mptcp_data_lock(sk);
 	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 		sk->sk_data_ready(sk);
+}
+
+void mptcp_data_ready(struct sock *sk, struct sock *ssk)
+{
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk))
+		__mptcp_data_ready(sk, ssk);
+	else
+		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
 	mptcp_data_unlock(sk);
 }
 
@@ -1077,9 +1085,7 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
 
 static void mptcp_clean_una_wakeup(struct sock *sk)
 {
-	mptcp_data_lock(sk);
 	__mptcp_clean_una_wakeup(sk);
-	mptcp_data_unlock(sk);
 }
 
 static void mptcp_enter_memory_pressure(struct sock *sk)
@@ -1939,16 +1945,22 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
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
@@ -1983,7 +1995,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			/* we will bulk release the skb memory later */
 			skb->destructor = NULL;
 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
-			__skb_unlink(skb, &msk->receive_queue);
+			__skb_unlink(skb, &sk->sk_receive_queue);
 			__kfree_skb(skb);
 			msk->bytes_consumed += count;
 		}
@@ -2107,16 +2119,9 @@ static void __mptcp_update_rmem(struct sock *sk)
 	WRITE_ONCE(msk->rmem_released, 0);
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
 
@@ -2124,37 +2129,27 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
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
 
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 
-	/* acquire the data lock only if some input data is pending */
 	ret = moved > 0;
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
-	    !skb_queue_empty_lockless(&sk->sk_receive_queue)) {
-		mptcp_data_lock(sk);
+	    !skb_queue_empty(&sk->sk_receive_queue)) {
 		__mptcp_update_rmem(sk);
 		ret |= __mptcp_ofo_queue(msk);
-		__mptcp_splice_receive_queue(sk);
-		mptcp_data_unlock(sk);
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
-	return !skb_queue_empty(&msk->receive_queue);
+	return ret;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
@@ -2162,7 +2157,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
 
-	skb = skb_peek(&msk->receive_queue);
+	skb = skb_peek(&sk->sk_receive_queue);
 	if (skb) {
 		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
 
@@ -2208,7 +2203,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int err, bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags, &tss, &cmsg_flags);
+		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -2220,8 +2215,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		/* be sure to advertise window change */
 		mptcp_cleanup_rbuf(msk);
 
-		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
-			continue;
 
 		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -2246,7 +2239,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
 				 */
-				if (__mptcp_move_skbs(msk))
+				if (__mptcp_move_skbs(sk))
 					continue;
 				break;
 			}
@@ -2290,9 +2283,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
-	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
-		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
-		 skb_queue_empty(&msk->receive_queue), copied);
+	pr_debug("msk=%p rx queue empty=%d copied=%d",
+		 msk, skb_queue_empty(&sk->sk_receive_queue), copied);
 
 	release_sock(sk);
 	return copied;
@@ -2819,7 +2811,6 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	INIT_WORK(&msk->work, mptcp_worker);
-	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
@@ -3402,12 +3393,8 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
 
-	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
-	mptcp_data_lock(sk);
-	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
 	__skb_queue_purge(&sk->sk_receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
-	mptcp_data_unlock(sk);
 
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
@@ -3450,7 +3437,8 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
-				      BIT(MPTCP_FLUSH_JOIN_LIST))
+				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
+				      BIT(MPTCP_DEQUEUE))
 
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
@@ -3484,6 +3472,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
+		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk))
+			sk->sk_data_ready(sk);
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
@@ -3721,7 +3711,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		lock_sock(sk);
-		__mptcp_move_skbs(msk);
+		__mptcp_move_skbs(sk);
 		*karg = mptcp_inq_hint(sk);
 		release_sock(sk);
 		break;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4c72a73594f..ad940cc1f26f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,6 +124,7 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
+#define MPTCP_DEQUEUE		8
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -322,7 +323,6 @@ struct mptcp_sock {
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
-	struct sk_buff_head receive_queue;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
-- 
2.45.2


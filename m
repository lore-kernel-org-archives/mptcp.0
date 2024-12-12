Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A102253E1
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022712; cv=none; b=rDVlP2QaqfuLa+94mj+E6B6zcZVk/X5gPEqKhjs7Pd+cYX0MCeZ75dfrDg+SiYJeQLZAyTNAtAb0L32E77btMlWp8rg972BEYvAHoiJ3M5c9o+YbHjKP3dXVPnQCyKvB6lf7VQVVufpiSMb/zAkerUdy5FmSF6YgyDt2Dw5D2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022712; c=relaxed/simple;
	bh=E4pnYHtO/pcD3t/4MDuF6Hackt2FW0RU1Z+qVMHnuiU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QgF5yzRSfZmG0V/TJQEheCIRITTGgGwXblgzew6bmNAdFn8gM3H550u5G3oXdEPWRfTMOdcdvOMUGOn72UtKJRORx7BREeZXuhPKMSEDz1tvgr8qqP7NLAa/Brjm0JLnr94YpvPtze2+hzDFV2yzHvKhMQ2X/mvIaLA/iprPK7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDdlaXzv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDdlaXzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734022709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXv0CYPKsB2gPkLk6RMRkvapLmtCtY8nomvYvhAw81U=;
	b=WDdlaXzvu4ns4VA4OPNy6er2qr1RIfovjEtDEMlheIYCxYZFcLGSo5WIovvb03OT4w0Civ
	aCZVATaMX/uJWEgzFfIWynYuXcotn7WUJNxB2Tu6JqrpUNc23qSfSEa3/6pKmK7sAQWMzz
	Q/67JkF6Uw5qL7Ok9iLU39S5syWFSZM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-N2_c8_PaNACSiu7K7Ow-Kg-1; Thu,
 12 Dec 2024 11:58:28 -0500
X-MC-Unique: N2_c8_PaNACSiu7K7Ow-Kg-1
X-Mimecast-MFC-AGG-ID: N2_c8_PaNACSiu7K7Ow-Kg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7282E195609D
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 16:58:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.108])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6B05195394B
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 16:58:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: micro-optimize __mptcp_move_skb()
Date: Thu, 12 Dec 2024 17:58:14 +0100
Message-ID: <b07cca4403396543aa7801e17b91b0bce4b31998.1734022547.git.pabeni@redhat.com>
In-Reply-To: <cover.1734022547.git.pabeni@redhat.com>
References: <cover.1734022547.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y4WRnzN3tFOcvvaQu9x-2ud4dft4ICCU7c98yVkqYHE_1734022707
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After the RX path refactor the mentioned function is expected to run
frequently, let's optimize it a bit.

Scan for ready subflow from the last processed one, and stop after
traversing the list once or reaching the msk memory limit - instead of
looking for dubious per-subflow conditions.
Also re-order the memory limit checks, to avoid duplicate tests.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 111 +++++++++++++++++++------------------------
 net/mptcp/protocol.h |   2 +
 2 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6e8295b9404..398ab465c256 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -567,15 +567,13 @@ static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
-					   struct sock *ssk,
-					   unsigned int *bytes)
+					   struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
-	unsigned int moved = 0;
 	bool more_data_avail;
 	struct tcp_sock *tp;
-	bool done = false;
+	bool ret = false;
 
 	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
@@ -585,20 +583,16 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		struct sk_buff *skb;
 		bool fin;
 
+		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+			break;
+
 		/* try to move as much data as available */
 		map_remaining = subflow->map_data_len -
 				mptcp_subflow_get_map_offset(subflow);
 
 		skb = skb_peek(&ssk->sk_receive_queue);
-		if (!skb) {
-			/* With racing move_skbs_to_msk() and __mptcp_move_skbs(),
-			 * a different CPU can have already processed the pending
-			 * data, stop here or we can enter an infinite loop
-			 */
-			if (!moved)
-				done = true;
+		if (unlikely(!skb))
 			break;
-		}
 
 		if (__mptcp_check_fallback(msk)) {
 			/* Under fallback skbs have no MPTCP extension and TCP could
@@ -611,19 +605,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 		offset = seq - TCP_SKB_CB(skb)->seq;
 		fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-		if (fin) {
-			done = true;
+		if (fin)
 			seq++;
-		}
 
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			if (tp->urg_data)
-				done = true;
-
-			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
-				moved += len;
+			ret = __mptcp_move_skb(msk, ssk, skb, offset, len) || ret;
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
@@ -637,22 +625,16 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			}
 
 			sk_eat_skb(ssk, skb);
-			done = true;
 		}
 
 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail = mptcp_subflow_data_available(ssk);
 
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf) {
-			done = true;
-			break;
-		}
 	} while (more_data_avail);
 
-	if (moved > 0)
+	if (ret)
 		msk->last_data_recv = tcp_jiffies32;
-	*bytes += moved;
-	return done;
+	return ret;
 }
 
 static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
@@ -746,9 +728,9 @@ void __mptcp_error_report(struct sock *sk)
 static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
-	unsigned int moved = 0;
+	bool moved;
 
-	__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err)) {
 		if (!sock_owned_by_user(sk))
@@ -764,7 +746,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	 */
 	if (mptcp_pending_data_fin(sk, NULL))
 		mptcp_schedule_work(sk);
-	return moved > 0;
+	return moved;
 }
 
 static void __mptcp_rcvbuf_update(struct sock *sk, struct sock *ssk)
@@ -779,10 +761,6 @@ static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 	__mptcp_rcvbuf_update(sk, ssk);
 
-	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-		return;
-
 	/* Wake-up the reader only for in-sequence data */
 	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 		sk->sk_data_ready(sk);
@@ -882,20 +860,6 @@ bool mptcp_schedule_work(struct sock *sk)
 	return false;
 }
 
-static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-
-	msk_owned_by_me(msk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (READ_ONCE(subflow->data_avail))
-			return mptcp_subflow_tcp_sock(subflow);
-	}
-
-	return NULL;
-}
-
 static bool mptcp_skb_can_collapse_to(u64 write_seq,
 				      const struct sk_buff *skb,
 				      const struct mptcp_ext *mpext)
@@ -2033,37 +1997,62 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
+static struct mptcp_subflow_context *
+__mptcp_first_ready_from(struct mptcp_sock *msk,
+			 struct mptcp_subflow_context *subflow)
+{
+	struct mptcp_subflow_context *start_subflow = subflow;
+
+	while (!READ_ONCE(subflow->data_avail)) {
+		subflow = mptcp_next_subflow(msk, subflow);
+		if (subflow == start_subflow)
+			return NULL;
+	}
+	return subflow;
+}
+
 static bool __mptcp_move_skbs(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	unsigned int moved = 0;
-	bool ret, done;
+	bool ret = false;
+
+	if (list_empty(&msk->conn_list))
+		return false;
 
 	/* verify we can move any data from the subflow, eventually updating */
 	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK))
 		mptcp_for_each_subflow(msk, subflow)
 			__mptcp_rcvbuf_update(sk, subflow->tcp_sock);
 
-	if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-		return false;
-
-	do {
-		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
+	subflow = list_first_entry(&msk->conn_list,
+				   struct mptcp_subflow_context, node);
+	for (;;) {
+		struct sock *ssk;
 		bool slowpath;
 
-		if (unlikely(!ssk))
+		/*
+		 * As an optimization avoid traversing the subflows list
+		 * and ev. acquiring the subflow socket lock before baling out
+		 */
+		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 			break;
 
-		slowpath = lock_sock_fast(ssk);
-		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+		subflow = __mptcp_first_ready_from(msk, subflow);
+		if (!subflow)
+			break;
 
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		slowpath = lock_sock_fast(ssk);
+		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
 		unlock_sock_fast(ssk, slowpath);
-	} while (!done);
 
-	ret = moved > 0 || __mptcp_ofo_queue(msk);
+		subflow = mptcp_next_subflow(msk, subflow);
+	}
+
+	__mptcp_ofo_queue(msk);
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 35a74b59541b..a07fe3e8f337 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -351,6 +351,8 @@ struct mptcp_sock {
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 #define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
 	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
+#define mptcp_next_subflow(__msk, __subflow)				\
+	list_next_entry_circular(__subflow, &__msk->conn_list, node);
 
 extern struct genl_family mptcp_genl_family;
 
-- 
2.45.2


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46C25A633
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738352; cv=none; b=UINUQiob0r04B3w6LuCRBxrqAFjmF8sx76vsFuJsgOXx1bUTvsK9oWxN5LikeCtkuNVVVn0gGfRqhG+z2eQq44oxy7aIe2waejKg9/gH8U5Ksat6WohghnvbwB1p7PrMJRV53ttyDa2S5OFBnwfweAbLaDnJzhUuPzSCMBn0zxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738352; c=relaxed/simple;
	bh=zjWGHdqVPzfBdgvnM0m/fHvx7NZGzIApbI28ZtnPoXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cReZ4B3atU89VrPjS1mqOvABmHoJ5LKHUKS7CnMvcTGXf3VvT991+MfWwUpHQRf4nSNjWVqp4JfUZBqebtUkd0a45xcNZXplYYNy0a7UkO0+ZqGgPP7HG4l0Bs0d0eQ9Mkxlyt+cBrxgPT2KOUvF3Fk94dPP3fJCWBek+uScT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOz3BsK+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOz3BsK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aeYLWgFVIIrf5aNPqsmJtr0e2rjGrgmSK9g0U7H0Rk=;
	b=UOz3BsK+Hc/pWz73m4JUv8hZ/le1nM80XQ87tAZggpwwm+Tns2n9BSC27o1vLjHk2hpLge
	nSv8I9tJl1lUDCza9huJ2cEIQCprcaJsAMxH9ykc8oryDvy90O/HgOI28Iry69cyJpex/d
	zXYBq72t9BhNzxPhGH7n2dVYnkGt4jI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-9XBdo8BCPVuMJBVJEmMygg-1; Mon,
 06 Oct 2025 04:12:28 -0400
X-MC-Unique: 9XBdo8BCPVuMJBVJEmMygg-1
X-Mimecast-MFC-AGG-ID: 9XBdo8BCPVuMJBVJEmMygg_1759738348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 275A419560B7
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3933218004D8
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 09/10] mptcp: introduce mptcp-level backlog
Date: Mon,  6 Oct 2025 10:12:08 +0200
Message-ID: <16ead1024784cf5913a9c9ef69d7d15cb73512a3.1759737859.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WO__qgP10_yakE1kBXHet5ZWzNXBfCvEiSSK1UcFDNI_1759738348
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We are soon using it for incoming data processing.
MPTCP can't leverage the sk_backlog, as the latter is processed
before the release callback, and such callback for MPTCP releases
and re-acquire the socket spinlock, breaking the sk_backlog processing
assumption.

Add a skb backlog list inside the mptcp sock struct, and implement
basic helper to transfer packet to and purge such list.

Packets in the backlog are not memory accounted, but still use the
incoming subflow receive memory, to allow back-pressure.

No packet is currently added to the backlog, so no functional changes
intended here.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
v4 -> v5:
  - split out of the next path, to make the latter smaller
  - set a custom destructor for skbs in the backlog, this avoid
    duplicate code, and fix a few places where the need ssk cleanup
    was not performed.
  - factor out the backlog purge in a new helper,
    use spinlock protection, clear the backlog list and zero the
    backlog len
  - explicitly init the backlog_len at mptcp_init_sock() time
---
 net/mptcp/protocol.c | 70 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  4 +++
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 05ee6bd26b7fa..2d5d3da67d1ac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -337,6 +337,11 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		mptcp_rcvbuf_grow(sk);
 }
 
+static void mptcp_bl_free(struct sk_buff *skb)
+{
+	atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+}
+
 static int mptcp_init_skb(struct sock *ssk,
 			  struct sk_buff *skb, int offset, int copy_len)
 {
@@ -360,7 +365,7 @@ static int mptcp_init_skb(struct sock *ssk,
 	skb_dst_drop(skb);
 
 	/* "borrow" the fwd memory from the subflow, instead of reclaiming it */
-	skb->destructor = NULL;
+	skb->destructor = mptcp_bl_free;
 	borrowed = ssk->sk_forward_alloc - sk_unused_reserved_mem(ssk);
 	borrowed &= ~(PAGE_SIZE - 1);
 	sk_forward_alloc_add(ssk, skb->truesize - borrowed);
@@ -373,6 +378,13 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
 
+	/* Avoid the indirect call overhead, we know destructor is
+	 * mptcp_bl_free at this point.
+	 */
+	atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+	skb->sk = NULL;
+	skb->destructor = NULL;
+
 	/* try to fetch required memory from subflow */
 	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
@@ -654,6 +666,35 @@ static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
+static void __mptcp_add_backlog(struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *tail = NULL;
+	bool fragstolen;
+	int delta;
+
+	if (unlikely(sk->sk_state == TCP_CLOSE)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
+		return;
+	}
+
+	/* Try to coalesce with the last skb in our backlog */
+	if (!list_empty(&msk->backlog_list))
+		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
+
+	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
+	    skb->sk == tail->sk &&
+	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
+		skb->truesize -= delta;
+		kfree_skb_partial(skb, fragstolen);
+		WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
+		return;
+	}
+
+	list_add_tail(&skb->list, &msk->backlog_list);
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb->truesize);
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk)
 {
@@ -701,10 +742,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			int bmem;
 
 			bmem = mptcp_init_skb(ssk, skb, offset, len);
-			skb->sk = NULL;
 			sk_forward_alloc_add(sk, bmem);
-			atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
-			ret = __mptcp_move_skb(sk, skb) || ret;
+
+			if (true)
+				ret |= __mptcp_move_skb(sk, skb);
+			else
+				__mptcp_add_backlog(sk, skb);
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
@@ -2753,12 +2796,28 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	unlock_sock_fast(ssk, slow);
 }
 
+static void mptcp_backlog_purge(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *tmp, *skb;
+	LIST_HEAD(backlog);
+
+	mptcp_data_lock(sk);
+	list_splice_init(&msk->backlog_list, &backlog);
+	msk->backlog_len = 0;
+	mptcp_data_unlock(sk);
+
+	list_for_each_entry_safe(skb, tmp, &backlog, list)
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
+}
+
 static void mptcp_do_fastclose(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_set_state(sk, TCP_CLOSE);
+	mptcp_backlog_purge(sk);
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
 				  subflow, MPTCP_CF_FASTCLOSE);
@@ -2816,11 +2875,13 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
+	INIT_LIST_HEAD(&msk->backlog_list);
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+	msk->backlog_len = 0;
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -3197,6 +3258,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	struct sock *sk = (struct sock *)msk;
 
 	__mptcp_clear_xmit(sk);
+	mptcp_backlog_purge(sk);
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 46d8432c72ee7..a21c4955f4cfb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -358,6 +358,9 @@ struct mptcp_sock {
 					 * allow_infinite_fallback and
 					 * allow_join
 					 */
+
+	struct list_head backlog_list;	/*protected by the data lock */
+	u32		backlog_len;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -408,6 +411,7 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 static inline int __mptcp_space(const struct sock *sk)
 {
 	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
+				    READ_ONCE(mptcp_sk(sk)->backlog_len) -
 				    sk_rmem_alloc_get(sk));
 }
 
-- 
2.51.0


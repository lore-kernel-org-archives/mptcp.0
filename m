Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762522D7B1
	for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576087; cv=none; b=YLSv9cRPT/hMRsG2m8kJdbFNeiY74gwJJg6HeK2zbJT/HzupaE5bNkseQ1/BCbOoJMcYRmUgjxP05ULZRGIj+seW4XzpfmBTc/HfIFQGQtJqAYuwD0n90tNg13MGxjUD7xTJMOGr5aaqALotVgtVrute+VGew/utu0yuaxdWrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576087; c=relaxed/simple;
	bh=AVcCSzSH5JeF0JktsGwpW6YbCmYmUbHHwobzwBj33Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qRXZNgGV5ZxfECJGUNO5CyRmFOaX6ezOFZnCbhkpWM+P8X8m95lRBXUbD7JR4ivYff2wevMhFlhDv/V/BEytot/0gNk7oR3ySPxt3TIRI8jvYjoPJqqJqkQ5aYj7BnjQ5vHFGPD7bwo+u2zfbZYgUruNBKCB8SHOfQDFIMEAbBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZvkHjMU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZvkHjMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIbP7kIVnTohOOxQUBE9o7GKf+zK9Wcyd9f4Uttiat0=;
	b=aZvkHjMUA7ICtWVGUDCT9PP3g8pp+GUT09tG37N62yx/q2js9DeffiiooifgUpuxp2IZ9+
	2Iv/68u61ma+RL/ZJ9cXUaMDXcJEzDzgk6+wS7lbUlfw3kHKZtOglWjW6SJcIxsgZSYrA7
	CMeK9/S80yn7GNwcjtVhkxdnC9bCpsU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-wW6ONt7GNzaXlYJX2m899A-1; Mon,
 27 Oct 2025 10:41:19 -0400
X-MC-Unique: wW6ONt7GNzaXlYJX2m899A-1
X-Mimecast-MFC-AGG-ID: wW6ONt7GNzaXlYJX2m899A_1761576078
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 416111956095;
	Mon, 27 Oct 2025 14:41:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1380030001BF;
	Mon, 27 Oct 2025 14:41:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	geliang@kernel.org
Subject: [PATCH v7 mptcp-next 3/4] mptcp: introduce mptcp-level backlog
Date: Mon, 27 Oct 2025 15:40:54 +0100
Message-ID: <b54644b9df2dddcda066b257041d486faacab656.1761568311.git.pabeni@redhat.com>
In-Reply-To: <cover.1761568311.git.pabeni@redhat.com>
References: <cover.1761568311.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 49rHW5IelnEK-7xn8U51UJFLQ1SsDrgeuRLKj--cuXQ_1761576078
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

Packets in the backlog are memory accounted and still use the incoming
subflow receive memory, to allow back-pressure. The backlog size is
implicitly bounded to the sum of subflows rcvbuf.

When a subflow is closed, references from the backlog to such sock
are removed.

No packet is currently added to the backlog, so no functional changes
intended here.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
v6 -> v7:
  - real fwd memory account for the backlog
  - do not introduce a new destructor: we only have a call-site
    dropping packets from the backlog, handle that one explicitly
  - update to new borrow fwd mem API

v5 -> v6:
  - call mptcp_bl_free() instead of inlining it.
  - report the bl mem in diag mem info
  - moved here the mptcp_close_ssk chunk from the next patch.
    (logically belongs here)

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
 net/mptcp/mptcp_diag.c |  3 +-
 net/mptcp/protocol.c   | 77 ++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h   | 25 ++++++++++----
 3 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index ac974299de71..136c2d05c0ee 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -195,7 +195,8 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_info *info = _info;
 
-	r->idiag_rqueue = sk_rmem_alloc_get(sk);
+	r->idiag_rqueue = sk_rmem_alloc_get(sk) +
+			  READ_ONCE(mptcp_sk(sk)->backlog_len);
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
 
 	if (inet_sk_state_load(sk) == TCP_LISTEN) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f6d96cb01e00..4c62de93e132 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -649,6 +649,38 @@ static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 		mptcp_subflow_reset(ssk);
 	}
 }
+static void __mptcp_add_backlog(struct sock *sk,
+				struct mptcp_subflow_context *subflow,
+				struct sk_buff *skb)
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
+		__mptcp_subflow_lend_fwdmem(subflow, delta);
+		WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
+		return;
+	}
+
+	list_add_tail(&skb->list, &msk->backlog_list);
+	mptcp_subflow_lend_fwdmem(subflow, skb);
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb->truesize);
+}
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk)
@@ -696,8 +728,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			size_t len = skb->len - offset;
 
 			mptcp_init_skb(ssk, skb, offset, len);
-			mptcp_subflow_lend_fwdmem(subflow, skb);
-			ret = __mptcp_move_skb(sk, skb) || ret;
+
+			if (true) {
+				mptcp_subflow_lend_fwdmem(subflow, skb);
+				ret |= __mptcp_move_skb(sk, skb);
+			} else {
+				__mptcp_add_backlog(sk, subflow, skb);
+			}
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
@@ -2529,6 +2566,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+
 	/* The first subflow can already be closed and still in the list */
 	if (subflow->close_event_done)
 		return;
@@ -2538,6 +2578,17 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
+	/* Remove any reference from the backlog to this ssk; backlog skbs consume
+	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
+	 */
+	list_for_each_entry(skb, &msk->backlog_list, list) {
+		if (skb->sk != ssk)
+			continue;
+
+		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+		skb->sk = NULL;
+	}
+
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */
@@ -2766,12 +2817,31 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
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
+	list_for_each_entry_safe(skb, tmp, &backlog, list) {
+		mptcp_borrow_fwdmem(sk, skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
+	}
+	sk_mem_reclaim(sk);
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
@@ -2829,11 +2899,13 @@ static void __mptcp_init_sock(struct sock *sk)
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
@@ -3210,6 +3282,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	struct sock *sk = (struct sock *)msk;
 
 	__mptcp_clear_xmit(sk);
+	mptcp_backlog_purge(sk);
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3785f0771967..6165c3cd0b40 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -358,6 +358,9 @@ struct mptcp_sock {
 					 * allow_infinite_fallback and
 					 * allow_join
 					 */
+
+	struct list_head backlog_list;	/* protected by the data lock */
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
 
@@ -651,22 +655,31 @@ static inline void mptcp_borrow_fwdmem(struct sock *sk, struct sk_buff *skb)
 {
 	struct sock *ssk = skb->sk;
 
-	/* The subflow just lend the skb fwd memory, and we know that the skb
-	 * is only accounted on the incoming subflow rcvbuf.
+	/* The subflow just lend the skb fwd memory; if the subflow meanwhile
+	 * closed mptcp_close_ssk already released the ssk rcv memory.
 	 */
-	skb->sk = NULL;
 	sk_forward_alloc_add(sk, skb->truesize);
+	if (!ssk)
+		return;
+
 	atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
+	skb->sk = NULL;
+}
+
+static inline void
+__mptcp_subflow_lend_fwdmem(struct mptcp_subflow_context *subflow, int size)
+{
+	int frag = (subflow->lent_mem_frag + size) & (PAGE_SIZE - 1);
+
+	subflow->lent_mem_frag = frag;
 }
 
 static inline void
 mptcp_subflow_lend_fwdmem(struct mptcp_subflow_context *subflow,
 			  struct sk_buff *skb)
 {
-	int frag = (subflow->lent_mem_frag + skb->truesize) & (PAGE_SIZE - 1);
-
+	__mptcp_subflow_lend_fwdmem(subflow, skb->truesize);
 	skb->destructor = NULL;
-	subflow->lent_mem_frag = frag;
 }
 
 static inline u64
-- 
2.51.0


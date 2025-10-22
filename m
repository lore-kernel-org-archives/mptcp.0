Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C634DB77
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143549; cv=none; b=t3at25kcvN9HzdB86SPrsp8Amufw0tjngpCaCmNq/Vp3FL4gV9xcikOgI9LqnQ5A+EDcUXwej2yS/yM8GkkRNiZOqnOSS8Vsi98Cq4T+PXIFThT44AAFW7Midaxyl3xbEFyD+2ARk+dkXWjL9CFcKtWs1f0GKEUFaysqz5PqvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143549; c=relaxed/simple;
	bh=moSIjfPSzQGeOLbv4n4MwJtNqYMzSg42jMOWoBapWWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=igFMmJkBAE0MvT+SJ26+EyakAUsCOrrMPx5vAYK+vy0OhCWy76rSl+ySL3I4tntbA9Lgby71V9nntX1gpTzJ0ACJaGdAmMCvak4j18XQ8iaoKON9mE5buN3JncctH0lln+WqFWuHJ2PYH04CaFUQkUk5RllW/nueZg3elXM2unY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAOGo03+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAOGo03+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amXsxLfjkO/birrnkPHv1ERF1at+xhVIm+Nv4cVA5lU=;
	b=SAOGo03+2DEzan1Tqti/XO7Nj+mqvzosedbmSpt2SSPbjiv6eYfWz6j66XcOMo3hCOPtBG
	jamIgf1jcHUbJSKLk+rFflgkrd2Ftkz2W6D2eQjpewMakJ2LBgcMwo9gjoEW409QGAoVyB
	M+o3YO13tzP2zMOAEM4OxkZIdKQnu+8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-i4zxc5RWNGy8ctyU_R2clA-1; Wed,
 22 Oct 2025 10:32:22 -0400
X-MC-Unique: i4zxc5RWNGy8ctyU_R2clA-1
X-Mimecast-MFC-AGG-ID: i4zxc5RWNGy8ctyU_R2clA_1761143540
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72312195605B;
	Wed, 22 Oct 2025 14:32:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 077081956056;
	Wed, 22 Oct 2025 14:32:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 10/11] mptcp: introduce mptcp-level backlog
Date: Wed, 22 Oct 2025 16:31:53 +0200
Message-ID: <56af6ae6256042ffd201aa6e95c907f260480010.1761142784.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: s4Bi1g2oAspK8M0OsRH6XuFFkHv95SdW2HDj-ZjFdcQ_1761143540
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
 net/mptcp/protocol.c   | 85 ++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h   |  4 ++
 3 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index ac974299de71cd..136c2d05c0eeb8 100644
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
index c68a4b410e7e5b..5a1d8f9e0fb0ec 100644
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
+	mptcp_bl_free(skb);
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
@@ -2516,6 +2559,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+
 	/* The first subflow can already be closed and still in the list */
 	if (subflow->close_event_done)
 		return;
@@ -2525,6 +2571,18 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
@@ -2753,12 +2811,28 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
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
@@ -2816,11 +2890,13 @@ static void __mptcp_init_sock(struct sock *sk)
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
@@ -3197,6 +3273,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	struct sock *sk = (struct sock *)msk;
 
 	__mptcp_clear_xmit(sk);
+	mptcp_backlog_purge(sk);
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dc61579282b2fc..d814e8151458d5 100644
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
 
-- 
2.51.0


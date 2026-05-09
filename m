Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1923ED5B
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312965; cv=none; b=KPwjMqG2/GCsqTkrW3ePrZvZxOq+ddhA/5nRLR+EuR+waXxE+MTL6fwFdiizyjC09TDJzJ+A5cJO76rqYKSMCJZ0UoXYsGsBupGq9UhVIbm64iTqGXwg3KtQMZMDM/j1CggmNV9xKyr68ECsWbkYtgJoe8KFAz8i/dXxw/LyJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312965; c=relaxed/simple;
	bh=OKowSt75jIrv7MZU6hMgG/xeLnWTFVXjEfNrahFK9nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PxurDLbpjE9FwelZ06farj4EutUPDBpnQ6dxJCGmAJOBcJoxAxi5L4mUOo5REcnVEQITQJG2h2ZSvYxqUm4HPpHts+gTfbWDeO99pr08ucuU/GKxegEOTbwcZFD4AG8zbbsyH2i1tgxiccsCERx3vZm+dDVycBxltzWMvOAe8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpNxpyqO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpNxpyqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778312962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEoiiKpaFpBcwSOPtUHAw4svUC/cxtL/toFxqQ2jpMg=;
	b=QpNxpyqOwiMr+Jb3eVNyZtaEZwo7IjCKxd6OA+r/r94ohlK1434Dt7N7/WT2rAkwl7nwVb
	yz5hkilfTckwyzsSA1k1fSn3+r9Am1a82t2LSphjB4tXGkwSWTbbRw2VyPXGydKfKifC4l
	oj22VnsiXv4w1x85DZDaXHhbS88fNto=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-u19Us9WsNJy3NPY0Sdr7tg-1; Sat,
 09 May 2026 03:49:19 -0400
X-MC-Unique: u19Us9WsNJy3NPY0Sdr7tg-1
X-Mimecast-MFC-AGG-ID: u19Us9WsNJy3NPY0Sdr7tg_1778312958
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AFBB1800343;
	Sat,  9 May 2026 07:49:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3FD4818004A3;
	Sat,  9 May 2026 07:49:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 07/12] mptcp: sync mptcp skb cb layout with tcp one
Date: Sat,  9 May 2026 09:48:27 +0200
Message-ID: <1e267ae38b704d5c97483073156b044971faeec4.1778312843.git.pabeni@redhat.com>
In-Reply-To: <cover.1778312843.git.pabeni@redhat.com>
References: <cover.1778312843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5F84D-9wL2F9cXjXmeCTtdHphve0fejg2L6VoIoUXbQ_1778312958
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol uses a significantly different CB layout WRT TCP, as it
includes different information and use 64 bits for the sequence numbers.

As the msk-level rcvbuf buffer size is limited by the core socket code the
INT_MAX; after validating the incoming skb vs the current receive window,
we can safely use 32 bits for MPTCP-level sequence number. This allow
updating the MPTCP CB layout so that fields with a corresponding TCP-level
data use the same area inside the CB itself.

Add build time check to ensure the latter invariant.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - fix wrong check for OoO skb in mptcp_move_skb().

v1 -> v2:
  - use u64 for admission checks

rfc -> v1:
  - keep `ack_seq` up2date
---
 net/mptcp/fastopen.c |   6 ++-
 net/mptcp/protocol.c | 106 +++++++++++++++++++++++--------------------
 net/mptcp/protocol.h |   7 ++-
 3 files changed, 66 insertions(+), 53 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 03e605b050f8..a9e90dc14f77 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -47,8 +47,10 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	/* The TFO segment data sits before the IASN; before receiving
 	 * the remote key, IASN is assumed being 0.
 	 */
-	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
+	MPTCP_SKB_CB(skb)->map_seq64 = -(u64)skb->len;
+	MPTCP_SKB_CB(skb)->map_seq = MPTCP_SKB_CB(skb)->map_seq64;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
+	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	mptcp_data_lock(sk);
@@ -56,7 +58,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	msk = mptcp_sk(sk);
 	msk->rcvd_dummy_seq = true;
-	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq64;
 	msk->tfo_skb_len = skb->len;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 87df66a682c9..f03f967d8679 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -164,7 +164,7 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
+	pr_debug("colesced seq %x into %x new len %d new end seq %x\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -234,14 +234,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct rb_node **p, *parent;
-	u64 seq, end_seq, max_seq;
+	u64 end_seq, max_seq;
 	struct sk_buff *skb1;
+	u32 seq;
 
 	seq = MPTCP_SKB_CB(skb)->map_seq;
-	end_seq = MPTCP_SKB_CB(skb)->end_seq;
+	end_seq = MPTCP_SKB_CB(skb)->map_seq64 + skb->len;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
+	/* Use the full sequence space to perform the admission checks, to
+	 * protect vs possible wrap-arounds.
+	 */
+	pr_debug("msk=%p seq=%x limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(end_seq, max_seq)) {
 		/* out of window */
@@ -272,7 +276,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+	if (!before(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -284,18 +288,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	while (*p) {
 		parent = *p;
 		skb1 = rb_to_skb(parent);
-		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
+		if (before(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
 			p = &parent->rb_left;
 			continue;
 		}
-		if (before64(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
-			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
+		if (before(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
+			if (!after(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
 				/* All the bits are present. Drop. */
 				mptcp_drop(sk, skb);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 				return;
 			}
-			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
+			if (after(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
 				/* partial overlap:
 				 *     |     skb      |
 				 *  |     skb1    |
@@ -326,7 +330,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
+		if (before((u32)end_seq, MPTCP_SKB_CB(skb1)->end_seq))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -346,13 +350,15 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
-	/* the skb map_seq accounts for the skb offset:
+	/* The skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
-	 * value
+	 * value; note that end seq number is only available in 32bits format.
 	 */
-	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
-				     offset;
+	MPTCP_SKB_CB(skb)->map_seq64 = mptcp_subflow_get_mapped_dsn(subflow) -
+				       offset;
+	MPTCP_SKB_CB(skb)->map_seq = (u32)MPTCP_SKB_CB(skb)->map_seq64;
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
+	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
@@ -375,13 +381,14 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 	if (!skb)
 		return;
 
-	MPTCP_SKB_CB(skb)->map_seq = mptcp_iasn(msk) - skb->len;
+	MPTCP_SKB_CB(skb)->map_seq64 = mptcp_iasn(msk) - skb->len;
+	MPTCP_SKB_CB(skb)->map_seq = (u32)MPTCP_SKB_CB(skb)->map_seq64;
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
-	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
 
@@ -402,7 +409,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		return false;
 	}
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	if (MPTCP_SKB_CB(skb)->map_seq64 == msk->ack_seq) {
+add_queue:
 		/* in sequence */
 		msk->bytes_received += copy_len;
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
@@ -413,31 +421,19 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
-	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
+	} else if (after64(MPTCP_SKB_CB(skb)->map_seq64, msk->ack_seq)) {
 		mptcp_data_queue_ofo(msk, skb);
 		return false;
+	} else if (after64(MPTCP_SKB_CB(skb)->map_seq64 + skb->len,
+			   msk->ack_seq)) {
+		/* Partial packet: map_seq < ack_seq < end_seq.*/
+		copy_len -= (u32)msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+		goto add_queue;
 	}
 
-	/* Completely old data? */
-	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-		mptcp_drop(sk, skb);
-		return false;
-	}
-
-	/* Partial packet: map_seq < ack_seq < end_seq.
-	 * Skip the already-acked bytes and enqueue the new data.
-	 */
-	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
-	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-				      MPTCP_SKB_CB(skb)->map_seq;
-	msk->bytes_received += copy_len;
-	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
-
-	skb_set_owner_r(skb, sk);
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
-	return true;
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+	mptcp_drop(sk, skb);
+	return false;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
@@ -818,40 +814,40 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb, *tail;
+	u32 seq_delta, ack_seq;
 	bool moved = false;
 	struct rb_node *p;
-	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
+		ack_seq = msk->ack_seq;
 		skb = rb_to_skb(p);
-		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
+		if (after(MPTCP_SKB_CB(skb)->map_seq, ack_seq))
 			break;
 
 		p = rb_next(p);
 		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
 
-		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq,
-				      msk->ack_seq))) {
+		if (unlikely(!after(MPTCP_SKB_CB(skb)->end_seq, ack_seq))) {
 			mptcp_drop(sk, skb);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 			continue;
 		}
 
-		end_seq = MPTCP_SKB_CB(skb)->end_seq;
+		seq_delta = MPTCP_SKB_CB(skb)->end_seq - ack_seq;
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
-			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+			int delta = ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
-				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
+			pr_debug("uncoalesced seq=%x ack seq=%x delta=%d\n",
+				 MPTCP_SKB_CB(skb)->map_seq, ack_seq,
 				 delta);
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
-		msk->bytes_received += end_seq - msk->ack_seq;
-		WRITE_ONCE(msk->ack_seq, end_seq);
+		msk->bytes_received += seq_delta;
+		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
 		moved = true;
 	}
 	return moved;
@@ -2100,7 +2096,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	int copied = 0;
 
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
-		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
+		u32 offset = (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
 		u32 count, data_len = skb->len - offset;
 		int err;
 
@@ -4630,11 +4626,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+#define CHK_CB_FIELD(mptcp_field, tcp_field)	\
+	({					\
+		BUILD_BUG_ON(offsetof(struct mptcp_skb_cb, mptcp_field) !=    \
+			     offsetof(struct tcp_skb_cb, tcp_field));	      \
+		BUILD_BUG_ON(offsetofend(struct mptcp_skb_cb, mptcp_field) != \
+			     offsetofend(struct tcp_skb_cb, tcp_field));      \
+	})
+
 void __init mptcp_proto_init(void)
 {
 	struct mptcp_delegated_action *delegated;
 	int cpu;
 
+	CHK_CB_FIELD(map_seq, seq);
+	CHK_CB_FIELD(end_seq, end_seq);
+	CHK_CB_FIELD(flags, tcp_flags);
+
 	mptcp_prot.h.hashinfo = tcp_prot.h.hashinfo;
 
 	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f3d852e52982..6786da97bbc8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -127,9 +127,12 @@
 #define MPTCP_SYNC_SEQ		8
 
 struct mptcp_skb_cb {
-	u64 map_seq;
-	u64 end_seq;
+	u32 map_seq;
+	u32 end_seq;
+	u32 unused;
+	u16 flags;
 	u8  has_rxtstamp;
+	u64 map_seq64;
 };
 
 #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
-- 
2.54.0


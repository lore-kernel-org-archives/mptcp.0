Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B6391829
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681018; cv=none; b=eV6qlnYU6dh0hvW0zhpZcaLQfhJS923S+xFCHcgLWAiQW4xM9ca0CjEKoENenTcLUCIu0p/bFM2+Kpfcy5EwuS/rNCT2QIXEWYko5KiJHdR9Iw3Sazn4uhx73JEMT9YxdlVrtJFidzoqyfCX0PZoaDd1pJxgOtPkOMrHKC2Sb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681018; c=relaxed/simple;
	bh=a6RCc2G7zE84WKXNKjAk3EGDSnUveZnZ9GtQUok90VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JD2pZJpyjvxhUrd0jw0FSALY2ftNLOzP04lYhF0AcPoDpEOe2yMXaCXsphcgxwyYS39ROGu3+jY5/1+a79wCvAR2yI0HfZidGUznRENS9INUrPfka/hyzeHlKwZzLQmWaeq1U0vLt11DprwgK/n8N9FHaeKQ1DKgCN0uYlYcSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVjMyajw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVjMyajw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776681013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwpM0wUufr71r4zvoe7mJOaYelmfbA4VEXiIAbo6fmQ=;
	b=TVjMyajwKXshZBf0sIsRE2kDNzIYGrmrMuq1eaUcibiBz7QVPUNdmVx5w8Ku9MrbH7TNM5
	19GZdhupKZqKBPogEXP392/irS+HrWrQA0raJ30e1sCch0DOqclqlCJuedYZvpI55ygQPC
	qGxhBGKgjsxT6HU4RUeNE5nvmxYmXA8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-7Rxyc8BWNhKYVQK-q8ON9g-1; Mon,
 20 Apr 2026 06:30:07 -0400
X-MC-Unique: 7Rxyc8BWNhKYVQK-q8ON9g-1
X-Mimecast-MFC-AGG-ID: 7Rxyc8BWNhKYVQK-q8ON9g_1776681003
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3A1D195608F;
	Mon, 20 Apr 2026 10:30:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B09A195608E;
	Mon, 20 Apr 2026 10:30:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [RFC PATCH 2/6] mptcp: sync mptcp skb cb layout with tcp one
Date: Mon, 20 Apr 2026 12:29:26 +0200
Message-ID: <c9a6e4de8ddcfe145ac95cf4b04b8f50d87cfa98.1776680489.git.pabeni@redhat.com>
In-Reply-To: <cover.1776680489.git.pabeni@redhat.com>
References: <cover.1776680489.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vL8Gbp3jJCOlsR5sDhA2Brm7MYYdNyBHbRzD-B3ZKWo_1776681003
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol uses a significantly different CB layout WRT TCP, as it
includes different information and use 64 bits for the sequence numbers.

As the msk-level rcvbuf buffer size is limited by the core socket code the
INT_MAX, we can safely use 32 bits for MPTCP-level sequence number. This
allow updating the MPTCP CB layout so that fields with a corresponding TCP-level
data use the same area inside the CB itself.

Add build time check the unsure the latter invariant.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 81 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  5 +--
 2 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d143b929bbf..800aa7d9408e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -28,7 +28,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-static unsigned int mptcp_inq_hint(const struct sock *sk);
+static int mptcp_inq_hint(const struct sock *sk);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
@@ -165,7 +165,7 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
+	pr_debug("colesced seq %x into %x new len %d new end seq %x\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -244,20 +244,20 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct rb_node **p, *parent;
-	u64 seq, end_seq, max_seq;
+	u32 seq, end_seq, max_seq;
 	struct sk_buff *skb1;
 
 	seq = MPTCP_SKB_CB(skb)->map_seq;
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%x limit=%x empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
-	if (after64(end_seq, max_seq)) {
+	if (after(end_seq, max_seq)) {
 		/* out of window */
 		mptcp_drop(sk, skb);
-		pr_debug("oow by %lld, rcv_wnd_sent %llu\n",
-			 (unsigned long long)end_seq - (unsigned long)max_seq,
+		pr_debug("oow by %d, rcv_wnd_sent %llu\n",
+			 end_seq - max_seq,
 			 (unsigned long long)atomic64_read(&msk->rcv_wnd_sent));
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
 		return;
@@ -282,7 +282,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+	if (!before(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -294,18 +294,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
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
@@ -336,7 +336,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
+		if (before(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -359,11 +359,12 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
-	 * value
+	 * value; note that seq numbers are truncated to 32bits
 	 */
 	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset = offset;
+	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
@@ -375,13 +376,14 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
-	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 ack_seq = msk->ack_seq;
 	struct sk_buff *tail;
 
 	mptcp_borrow_fwdmem(sk, skb);
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	if (MPTCP_SKB_CB(skb)->map_seq == ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
@@ -392,7 +394,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
-	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
+	} else if (after(MPTCP_SKB_CB(skb)->map_seq, ack_seq)) {
 		mptcp_data_queue_ofo(msk, skb);
 		return false;
 	}
@@ -772,44 +774,42 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 {
+	u32 seq_delta, ack_seq = msk->ack_seq;
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb, *tail;
 	bool moved = false;
 	struct rb_node *p;
-	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
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
 		if (!tail || !mptcp_ooo_try_coalesce(msk, tail, skb)) {
-			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+			int delta = ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
-				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
-				 delta);
+			pr_debug("uncoalesced seq=%x ack seq=%x delta=%d\n",
+				 MPTCP_SKB_CB(skb)->map_seq, ack_seq, delta);
 			MPTCP_SKB_CB(skb)->offset += delta;
 			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
-		msk->bytes_received += end_seq - msk->ack_seq;
-		WRITE_ONCE(msk->ack_seq, end_seq);
+		msk->bytes_received += seq_delta;
+		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
 		moved = true;
 	}
 	return moved;
@@ -2260,19 +2260,20 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+static int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
 
 	skb = skb_peek(&sk->sk_receive_queue);
 	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+		int hint_val = (u32)READ_ONCE(msk->ack_seq) -
+			       MPTCP_SKB_CB(skb)->map_seq;
 
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
+		if (hint_val < 0)
+			return -hint_val;
 
-		return (unsigned int)hint_val;
+		return hint_val;
 	}
 
 	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
@@ -2380,7 +2381,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			tcp_recv_timestamp(msg, sk, &tss);
 
 		if (cmsg_flags & MPTCP_CMSG_INQ) {
-			unsigned int inq = mptcp_inq_hint(sk);
+			int inq = mptcp_inq_hint(sk);
 
 			put_cmsg(msg, SOL_TCP, TCP_CM_INQ, sizeof(inq), &inq);
 		}
@@ -4601,11 +4602,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
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
index 661600f8b573..ad906737ee9f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -126,9 +126,10 @@
 #define MPTCP_SYNC_SNDBUF	7
 
 struct mptcp_skb_cb {
-	u64 map_seq;
-	u64 end_seq;
+	u32 map_seq;
+	u32 end_seq;
 	u32 offset;
+	u16 flags;
 	u8  has_rxtstamp;
 	u8  cant_coalesce;
 };
-- 
2.53.0


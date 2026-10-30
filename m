Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327425;
	b=NTnc5nzd18cjW+FAY8+lgyjcS8pBP9DZoUcETiyzLeJKuwWdQI8jPYm38l3F6yr8u4iU
	 9xeURVcIRizlCoM44ZoG8xN3l0XCKbymDphk8yUAd1nIUJ3DbJvAPtN7sDcZ2gWRT5UZP
	 ySfNWsrwBYGcvuuZXlE++7YNRjYDlqMEvB/AhZKVajNmTJPHduXLNFjkuAfkSNYrQIfg7
	 SQABh99eHyjRABgRib5A70LEx+8EafdRIoC6X/Y9Rr1ajp1z0kWz5fg6vi5hKuL5YSLSz
	 rqjBchwt+86fd2X2R9yTAfhtWpuPAyGak22DPOnZUFOEkPIYcjUXIoxKJUTsxP6GrfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U0CGyVCXYRcXN1ZfpDY+iJ+xrUaTb9VDYAnZdTunyFg=;
	b=D/+xnJ/gPT/OY4X9zH8Rcro8NoT7PAtmJFLBo9UqPAE6Pegt6bIhhBapdNLohCWtGRzq
	 POgR601H/d0OPujvdC8ldux9H3PJCmDvk+8XABiQEJ1Jz7AhZ+NimjH3FBGIkEnjZmKLN
	 7YUBlnasesuHA/Gp7X5TQKYsSJrKlD3HseRcqioShAygcbmZD1NF6eKsniXmIkOgOYueU
	 EKTPNrD3ORHbKgb61UMDAO5A9MbmeXc+m4a71XLcu6XZavEPaVNaWC0/Uytx5dRZqOF2t
	 KF55tbz/FTDz8bFcvKxY8K9TtrodRlRwxNCdGgElqn/5uvdFqi2S8crpK00np7ai4Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1FkQH7L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7373D606A321
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1FkQH7L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121431F000C1;
	Fri, 30 Oct 2026 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793327424;
	bh=U0CGyVCXYRcXN1ZfpDY+iJ+xrUaTb9VDYAnZdTunyFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T1FkQH7LCVJrlA6tQBiG2w7vb5lt+wwCQdPRe6GW91PimAWQ/62Wcd2P3n1+8o0lr
	 h4fTbJuwlV++saIoPgKFQAhv8SvB7A+Lz9qdyv8zfoMCi8JU1SHM0FY5c5uBeN8TJG
	 TdNupuRkhM0Q9QPuCuWTzu26RQY7/nugqXYRuS/F1b+mRXj/9tL8vCo3jTe8at/Ozt
	 fuUqIDfMAhJF+qtvJnA7aUfqtFYtzw02EPfbPQZeuqL/L/wOKXa4tWl3V3t3kzR90B
	 YG7RA15sjVi1xWEbhkROlzmogygqh3GFz/p7SBFZU0orGBSm55GnTFLprf7eAupjWg
	 yHwhcW+2OYl1A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v17 3/4] mptcp: sync mptcp skb cb layout with tcp one
Date: Fri, 30 Oct 2026 10:30:14 +0800
Message-ID: <fe11356d3e5637de94fbe89540271d5f4ee381b4.1793326853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793326853.git.tanggeliang@kylinos.cn>
References: <cover.1793326853.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol uses a significantly different CB layout WRT TCP, as it
includes different information and use 64 bits for the sequence numbers.

As the msk-level rcvbuf buffer size is limited by the core socket code the
INT_MAX; after validating the incoming skb vs the current receive window,
we can safely use 32 bits for MPTCP-level sequence number. This allow
updating the MPTCP CB layout so that fields with a corresponding TCP-level
data use the same area inside the CB itself.

The 32-bit sequence numbers are safe because all SKBs in the receive queue
and OFO queue have been validated against the receive window (max INT_MAX),
so their sequence numbers are guaranteed to be within 2^31 of the current
ack_seq or copied_seq. This ensures that 32-bit arithmetic (comparisons
and subtractions) produces correct results even when 64-bit values cross
the 2^32 boundary, as the relative distance remains small.

Add build time check to ensure the latter invariant.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  6 ++-
 net/mptcp/protocol.c | 90 +++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |  7 +++-
 net/mptcp/subflow.c  |  3 +-
 4 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 04b1038b5200..08f0402324c2 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -48,8 +48,10 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	/* The TFO segment data sits before the IASN; before receiving
 	 * the remote key, IASN is assumed being 0.
 	 */
-	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
+	MPTCP_SKB_CB(skb)->map_seq64 = -(u64)skb->len;
+	MPTCP_SKB_CB(skb)->map_seq = MPTCP_SKB_CB(skb)->map_seq64;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
+	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
@@ -57,7 +59,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
 	msk = mptcp_sk(sk);
-	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq64;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f3b1b6b282a2..8447efa9dee6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -168,12 +168,14 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
+	    MPTCP_SKB_CB(from)->map_seq64 != MPTCP_SKB_CB(to)->map_seq64 +
+					     to->len ||
 	    unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
+	pr_debug("colesced seq %x into %x new len %d new end seq %x\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -255,8 +257,8 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
 		struct sk_buff *skb = rb_to_skb(node);
 
 		/* Stop pruning if the incoming skb would land in OoO tail. */
-		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
-			    MPTCP_SKB_CB(skb)->map_seq))
+		if (after(MPTCP_SKB_CB(in_skb)->map_seq,
+			  MPTCP_SKB_CB(skb)->map_seq))
 			break;
 
 		pruned = true;
@@ -302,16 +304,21 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
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
+	pr_debug("msk=%p seq=%x limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
-	if (after64(end_seq, max_seq)) {
+	/* Use the full sequence space to perform the admission checks, to
+	 * protect vs possible wrap-arounds.
+	 */
+	if (after64(MPTCP_SKB_CB(skb)->map_seq64, max_seq) ||
+	    after64(end_seq, max_seq)) {
 		/* out of window */
 		mptcp_drop(sk, skb);
 		pr_debug("oow by %lld, rcv_wnd_sent %llu\n",
@@ -346,7 +353,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+	if (!before(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -358,18 +365,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
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
+			if (!after((u32)end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
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
@@ -400,7 +407,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
+		if (before((u32)end_seq, MPTCP_SKB_CB(skb1)->end_seq))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -422,11 +429,13 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 
 	/* the skb map_seq accounts for the skb offset:
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
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
@@ -438,13 +447,13 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
-	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
 
 	mptcp_borrow_fwdmem(sk, skb);
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	if (MPTCP_SKB_CB(skb)->map_seq64 == msk->ack_seq) {
 		/* in sequence */
 insert:
 		if (!mptcp_try_rmem_schedule(sk, skb)) {
@@ -462,14 +471,14 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
-	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
+	} else if (after64(MPTCP_SKB_CB(skb)->map_seq64, msk->ack_seq)) {
 		mptcp_data_queue_ofo(msk, skb);
 		return false;
 	}
 
 	/* Partial packet */
-	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
-		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	if (after64(MPTCP_SKB_CB(skb)->map_seq64 + skb->len, msk->ack_seq)) {
+		copy_len = MPTCP_SKB_CB(skb)->end_seq - (u32)msk->ack_seq;
 		goto insert;
 	}
 
@@ -864,39 +873,37 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
-
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
-				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
-				 delta);
+			pr_debug("uncoalesced seq=%x ack seq=%x delta=%d\n",
+				 MPTCP_SKB_CB(skb)->map_seq, ack_seq,
+				 ack_seq - MPTCP_SKB_CB(skb)->map_seq);
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
-		msk->bytes_received += end_seq - msk->ack_seq;
-		WRITE_ONCE(msk->ack_seq, end_seq);
+		msk->bytes_received += seq_delta;
+		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
 		moved = true;
 	}
 	return moved;
@@ -2192,7 +2199,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 		int err;
 
 		if (msk->copied_seq >= MPTCP_SKB_CB(skb)->map_seq)
-			offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
+			offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 		/* Skip skbs that are entirely before copied_seq */
 		if (offset >= skb->len) {
@@ -4602,7 +4609,8 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
+		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
+
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4852,11 +4860,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
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
index 5c1fa117e5d5..2ab8342e198d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -128,10 +128,13 @@
 #define MPTCP_SYNC_SNDBUF	7
 
 struct mptcp_skb_cb {
-	u64 map_seq;
-	u64 end_seq;
+	u32 map_seq;
+	u32 end_seq;
+	u32 unused;
+	u16 flags;
 	u8  has_rxtstamp;
 	u8  cant_coalesce;
+	u64 map_seq64;
 };
 
 #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6a66841ca24a..5a8d837e55d0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -542,7 +542,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 		if (skb) {
 			u64 tfo_map_seq = subflow->iasn - skb->len;
 
-			WRITE_ONCE(MPTCP_SKB_CB(skb)->map_seq, tfo_map_seq);
+			WRITE_ONCE(MPTCP_SKB_CB(skb)->map_seq, (u32)tfo_map_seq);
+			WRITE_ONCE(MPTCP_SKB_CB(skb)->map_seq64, tfo_map_seq);
 			WRITE_ONCE(MPTCP_SKB_CB(skb)->end_seq, subflow->iasn);
 
 			if (READ_ONCE(msk->copied_seq) != -(u64)skb->len)
-- 
2.55.0


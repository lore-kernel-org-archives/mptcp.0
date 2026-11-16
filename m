Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811162;
	b=DQASfzGcTfL8taz77rRrKsDQG9cjpCv7zu9AV+CdX1TRkmBno6J2YQ0uxq5wse6zIVbe
	 vB6WG+Fy15zDXRGwexoNuX+i15tWHzEPt/yUm9l6dkTNDZ3KAeO4wUlwW3mzjQ94tCbOi
	 hCc2i1yJbJHoHJioAAp3fZ9NDdVEiuSYAh20bVBjbTgP7EQryWKxGtL6oxn6JLMTwe1GO
	 KALWRpVc1PYJ7GWN28CIYCcbyQtl33+kHVSl65GhNXEybObjQsdyJNnKuDip+2DtRjHi+
	 UJcFTA6axR6qGOehvEwGe5fdJH65EpNLr5o5I8rybQef5HS032DvF5w0jqDuQQs+kig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811162;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gWpP2m8L9S9yYUXwDgH7P4AG2654E+sY+KyNt06awV8=;
	b=ao2uqrYdYV2dJF9JqvZitoPCO0Om757LQY4TufX+L3IMKEBn+ldcjhV5CCkghQp6LZhL
	 W3OVsd+qkpqCfndJJjqkX/MqJhSCrIBdmhP5zC4p8ImCsG+G9SrxnIAmbhqVcGo8zC1op
	 0xxb135/7q0hB30ZzMf7NSxiAsn4HfTra9qkyRfDQm1vP1XKqoDus4356cjiAKRERtsfr
	 02CR9gX1HaP/R14i3uV09TTldA8yuL05IvqjayNX9LFkORTPVqKK35rGnwwc3wcXJJrLK
	 KSIDve6I//FWVosxbFX5CVG80mbr4BwAziV/Q0OQBJ+NagD6+wVnQH6CVVfKTq+J4zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2WA03Pz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A82606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2WA03Pz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD6A1F000CF
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811161;
	bh=gWpP2m8L9S9yYUXwDgH7P4AG2654E+sY+KyNt06awV8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=g2WA03PzqB3Ld5HDkxeTVZOdLDv2U0UyI5iGtyRTSWpAQdcXwnoulMh4nRB2Jk9g1
	 Dtkt7wdshxlEHQ7y7kZJDXjzJRxAlYal8iiMLhHKpso7mCe+L6u+kjtEoI6gXMMb+I
	 tNLTmeML3XlJGv4tSy0DKSZ7U424ZWPtTQceFKaa/f+EO8qlv9pU1Y6OL0M/oJdOgb
	 5HmA/DDdrJ0wZWKRjtK2cVSboCZQQg35SW5vxt+I3VT6mLU0N4NjfSsb8nocJQMeyx
	 1G6try5Q3j72cRXvooeTO8o4GCJWfqEbuO01Xfy4e4HI/MYN1NZGYxxE1BaEQX7nsY
	 dOasCfcRp7M1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v28 10/11] mptcp: sync mptcp skb cb layout with tcp one
Date: Mon, 16 Nov 2026 14:39:03 +0800
Message-ID: <af0a3423548713de827ea0597b8b637fde99e3b2.1794810809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
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
includes different information and uses 64 bits for the sequence numbers.

The CB layout changes map_seq and end_seq from u64 to u32, adds a new
map_seq64 field to track the full 64-bit DSN, and aligns the existing flags
field with TCP's tcp_flags offset. Add a build time check to ensure the CB
layout matches TCP's layout for the three shared fields: map_seq, end_seq,
and flags.

The 32-bit sequence numbers are safe because the relative distances remain
small. For OFO queue skbs, sequence numbers are validated against
rcv_wnd_sent in mptcp_data_queue_ofo(), bounded by the TCP-scaled receive
window. For receive queue skbs, no window check is performed, but the
unsigned offset calculations in __mptcp_recvmsg_mskq() and mptcp_recv_skb()
are safe because copied_seq always falls inside or at the edge of the head
skb. This ensures that 32-bit arithmetic (comparisons and subtractions)
produces correct results even when 64-bit values cross the 2^32 boundary.

map_seq64 is computed as mptcp_subflow_get_mapped_dsn() in mptcp_init_skb()
minus offset, and map_seq is the lower 32 bits.

The receive path now uses 32-bit before()/after() helpers for most sequence
comparisons, while map_seq64 is used for window validation and coalescing
checks. __mptcp_try_coalesce() gains a map_seq64 contiguity check to ensure
skbs are truly adjacent in the 64-bit DSN space.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  5 +--
 net/mptcp/protocol.c | 76 ++++++++++++++++++++++++++------------------
 net/mptcp/protocol.h | 10 +++---
 3 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 8dcfcff9087f..952f04dffc9e 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -46,7 +46,8 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* Only the sequence delta is relevant */
-	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
+	MPTCP_SKB_CB(skb)->map_seq64 = -(u64)skb->len;
+	MPTCP_SKB_CB(skb)->map_seq = MPTCP_SKB_CB(skb)->map_seq64;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
@@ -56,7 +57,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	msk = mptcp_sk(sk);
 	msk->rcvd_dummy_seq = true;
-	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq64;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 78ca580c6d9c..50ae8cdec8a4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -167,14 +167,14 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 {
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
-	if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||
+	if (MPTCP_SKB_CB(from)->map_seq64 != mptcp_end_dsn(to) ||
 	    (MPTCP_SKB_CB(from)->flags | MPTCP_SKB_CB(to)->flags) &
 	     MPTCP_SKB_CB_F_OFFSET ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
+	pr_debug("colesced seq %x into %x new len %d new end seq %x\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -256,7 +256,7 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
 		struct sk_buff *skb = rb_to_skb(node);
 
 		/* Stop pruning if the incoming skb would land in OoO tail. */
-		if (after64(mptcp_dsn(in_skb), mptcp_dsn(skb)))
+		if (after((u32)mptcp_dsn(in_skb), (u32)mptcp_dsn(skb)))
 			break;
 
 		pruned = true;
@@ -302,14 +302,15 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct rb_node **p, *parent;
-	u64 seq, end_seq, max_seq;
+	u64 end_seq, max_seq;
 	struct sk_buff *skb1;
+	u32 seq;
 
-	seq = mptcp_dsn(skb);
+	seq = (u32)mptcp_dsn(skb);
 	end_seq = mptcp_end_dsn(skb);
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%x limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(end_seq, max_seq)) {
 		/* out of window */
@@ -346,7 +347,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, mptcp_end_dsn(msk->ooo_last_skb))) {
+	if (!before(seq, (u32)mptcp_end_dsn(msk->ooo_last_skb))) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -358,18 +359,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	while (*p) {
 		parent = *p;
 		skb1 = rb_to_skb(parent);
-		if (before64(seq, mptcp_dsn(skb1))) {
+		if (before(seq, (u32)mptcp_dsn(skb1))) {
 			p = &parent->rb_left;
 			continue;
 		}
-		if (before64(seq, mptcp_end_dsn(skb1))) {
-			if (!after64(end_seq, mptcp_end_dsn(skb1))) {
+		if (before(seq, (u32)mptcp_end_dsn(skb1))) {
+			if (!after((u32)end_seq, (u32)mptcp_end_dsn(skb1))) {
 				/* All the bits are present. Drop. */
 				mptcp_drop(sk, skb);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 				return;
 			}
-			if (after64(seq, mptcp_dsn(skb1))) {
+			if (after(seq, (u32)mptcp_dsn(skb1))) {
 				/* partial overlap:
 				 *     |     skb      |
 				 *  |     skb1    |
@@ -400,7 +401,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq, mptcp_end_dsn(skb1)))
+		if (before((u32)end_seq, (u32)mptcp_end_dsn(skb1)))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -423,10 +424,11 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 
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
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
@@ -451,13 +453,14 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 	if (!skb)
 		return;
 
-	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len;
+	MPTCP_SKB_CB(skb)->map_seq64 = msk->tfo_iasn - skb->len;
+	MPTCP_SKB_CB(skb)->map_seq = (u32)MPTCP_SKB_CB(skb)->map_seq64;
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
-	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	u64 dsn = mptcp_dsn(skb);
 	struct sk_buff *tail;
@@ -495,7 +498,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	/* Partial packet */
 	if (after64(mptcp_end_dsn(skb), msk->ack_seq)) {
-		copy_len = mptcp_end_dsn(skb) - msk->ack_seq;
+		copy_len = (u32)mptcp_end_dsn(skb) - (u32)msk->ack_seq;
 		goto insert;
 	}
 
@@ -910,38 +913,37 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
-		if (after64(mptcp_dsn(skb), msk->ack_seq))
+		if (after((u32)mptcp_dsn(skb), ack_seq))
 			break;
 
 		p = rb_next(p);
 		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
 
-		if (unlikely(!after64(mptcp_end_dsn(skb), msk->ack_seq))) {
+		if (unlikely(!after((u32)mptcp_end_dsn(skb), ack_seq))) {
 			mptcp_drop(sk, skb);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 			continue;
 		}
 
-		end_seq = mptcp_end_dsn(skb);
+		seq_delta = (u32)mptcp_end_dsn(skb) - ack_seq;
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
@@ -2231,7 +2233,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	int copied = 0;
 
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
-		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
+		u32 offset = (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
 		u32 data_len = skb->len - offset;
 		u32 count;
 		int err;
@@ -4654,7 +4656,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
+		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4904,11 +4906,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
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
index 0c7c58b51f61..86634c04f499 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -131,10 +131,12 @@
 #define MPTCP_SKB_CB_F_OFFSET	(TCPHDR_FLAGS_MASK + 1)
 
 struct mptcp_skb_cb {
-	u64 map_seq;
-	u64 end_seq;
+	u32 map_seq;
+	u32 end_seq;
+	u32 unused;
 	u16 flags;
 	u8  has_rxtstamp;
+	u64 map_seq64;
 };
 
 #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
@@ -1386,12 +1388,12 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 
 static inline u64 mptcp_end_dsn(const struct sk_buff *skb)
 {
-	return MPTCP_SKB_CB(skb)->map_seq + skb->len;
+	return MPTCP_SKB_CB(skb)->map_seq64 + skb->len;
 }
 
 static inline u64 mptcp_dsn(const struct sk_buff *skb)
 {
-	return MPTCP_SKB_CB(skb)->map_seq + skb->len -
+	return MPTCP_SKB_CB(skb)->map_seq64 + skb->len -
 	       (MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq);
 }
 
-- 
2.55.0


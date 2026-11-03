Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696257;
	b=bl3MMJ/QjgwtEVPTJKfIPawPuWt6U5dPtakbfGtb+M7pKpvUeDV4DA9DZ1QSfP7t0pPR
	 GJYqv0ZQoI2t5EBIpFlMYJMipnRk0KQTxVmozsz2NWAjQ+Dq9BaAGxu+eDllp26TpdFv+
	 7tGzq4tC2qwQmmVv4LDPosM95BBzyU5DihRzF9CUQjrMdY8WMlCPb8mxcmWCZpSAjzilk
	 FmVVSFVsAS7zTKaGhOytvflq5TakCYQ6wqZJHy0J+yK8/W2T1AMUm39DlvX3ktSmHYKwL
	 tILmct/nOzSVJaqxf8hx5sa6ouVgmwWrkpoP9yfREO7YjR5pyd35n88VtIM7uBmbsIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696257;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8llgsJBvrSemn2be+Mp6yjQui1PRyoRGMXd26JcbR4s=;
	b=sFpzWRIw9PLNYHYwK1V9pU/4I8uM4jb5EzYEAbZXaCo/J7HzJ9u3SyN+cuIeilgS05kp
	 0Xs0N627q4QU1cDjfFviIJ2C+JBZIhuOfq5gjFHe3ZEqrFw7nUSaPqUNPMQWknfmj9+wW
	 bSQ5mnhEGUSjiD2Yy2tp6CeDz8Ic5WnkIwomIaQK+9NyWpxTQsMWhHA18Se+RvrEC/nLC
	 U1g9YcusoADt/XH1d7tnZ1kAN6RNaO1+dQZAiWezhUx6qL0k93HD12U2IFOMaCerjt2k9
	 LdIyeDR/kHnCyeG8rmuHhgsL7csF/IeaOUdo0V9UZkxBgwGUcsyq67VBn5ytKizxhtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDNyK03O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B8606D80D
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDNyK03O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5792A1F00A1A;
	Tue,  3 Nov 2026 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696257;
	bh=8llgsJBvrSemn2be+Mp6yjQui1PRyoRGMXd26JcbR4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDNyK03OXEAnxWbSYngVFEWULUvexXDw54lQvZGXtOUKnBPyTcoIkIbVmg6XWWNkF
	 MxsnOORyAs6vjAEXg9/I/1f2Fr0O7ZILK3bUetC2/0GklMWxwO3kfoIfZCdUnqJsn0
	 yAsVh8J4VqBvtyxV1eboyS086yc/QPcVmZPWGLxguxBben+q71m9Zq/PRqvfvsppsl
	 F1JLXG7CDqWJtgmTbuKmXfPTZCglCC6AuvhHwSXPcGFeAstNYgl4/KI/mmUWSmDdUr
	 UuqydeI7P9LoU32JEzAcCUXXYMk5WiUMrmD8ZA3evOcdUgT0RSj87fDNJJctR2Weh6
	 tQntSVKOWN9eQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v20 5/6] mptcp: sync mptcp skb cb layout with tcp one
Date: Tue,  3 Nov 2026 16:57:24 +0800
Message-ID: <cf2994ec4440d24183bea5c407c1962270392c32.1793695518.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 94 +++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |  7 +++-
 3 files changed, 68 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 78481c100e2a..bd52e9528b29 100644
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
 
 	mptcp_data_lock(sk);
@@ -57,7 +59,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	msk = mptcp_sk(sk);
 	msk->rcvd_dummy_seq = true;
-	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq64;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3bd7d38ce78c..3e10b06b7772 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -168,11 +168,13 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
+	    MPTCP_SKB_CB(from)->map_seq64 != MPTCP_SKB_CB(to)->map_seq64 +
+					     to->len ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
+	pr_debug("colesced seq %x into %x new len %d new end seq %x\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -254,8 +256,8 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
 		struct sk_buff *skb = rb_to_skb(node);
 
 		/* Stop pruning if the incoming skb would land in OoO tail. */
-		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
-			    MPTCP_SKB_CB(skb)->map_seq))
+		if (after(MPTCP_SKB_CB(in_skb)->map_seq,
+			  MPTCP_SKB_CB(skb)->map_seq))
 			break;
 
 		pruned = true;
@@ -301,16 +303,23 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
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
+	if (after64(READ_ONCE(msk->ack_seq), max_seq))
+		max_seq = READ_ONCE(msk->ack_seq);
 
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
@@ -345,7 +354,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+	if (!before(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -357,18 +366,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
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
@@ -399,7 +408,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
+		if (before((u32)end_seq, MPTCP_SKB_CB(skb1)->end_seq))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -425,10 +434,14 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 	 *
 	 * This is correct even when offset > 0 and mapping is out-of-order,
 	 * because consumed prefix bytes are part of the same logical DSN range.
+	 *
+	 * Note that end seq number is only available in 32bits format.
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
@@ -451,13 +464,14 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
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
 	struct sk_buff *tail;
 
@@ -469,7 +483,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(msk->rcvd_dummy_seq))
 		__mptcp_sync_rcv_sequence(sk);
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	if (MPTCP_SKB_CB(skb)->map_seq64 == msk->ack_seq) {
 		/* in sequence */
 insert:
 		if (!mptcp_try_rmem_schedule(sk, skb)) {
@@ -487,14 +501,14 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
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
 
@@ -889,39 +903,37 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
@@ -2210,7 +2222,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	int copied = 0;
 
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
-		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
+		u32 offset = (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
 		u32 data_len = skb->len - offset;
 		u32 count;
 		int err;
@@ -4635,7 +4647,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
+		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4885,11 +4897,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
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
index 7878e6ac6c0b..fa54f70ab501 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -129,9 +129,12 @@
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
2.55.0


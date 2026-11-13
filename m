Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563943;
	b=u8ujToyMrXdpe6+X/lPGBgBKATG/NLDn0dekkI8rAS/j1xd3YbFxsql/l0PO0llls6Jg
	 vWGlGa63hs8W5W89K0hSHAHzacl2VHj2y8ixD7rlL92z5YEbqsXv1348pNvm2X56llaV2
	 5oPDfPDEv5ID8k/rzFge0ZtI0JtMEYzM6L8DRNNA9AdkbiJK8dkmB97lHJiSe/7d5x0cr
	 yz9C1uYdK5sbd7+IAyOOz3Ag5/c60w9vmGJDl4Jqzx262HXAwA0SFI24qMgxKLZzUS4sX
	 lgjscqFzn1UbincIAfxTN15u6spWxL/J16bMnozlOXgKDow/iNWRFEjf3D6ixJvQB0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563943;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kzbRxsbzGSWFcVikn1/P3s9Ss9UEpi9d3M5amLdtxmc=;
	b=vMM4PAu3fig63zzYjknG/uH9TP7IyToYzjsRNAW6lL7roM2B54I4/6XfG0fDYPQb7K8W
	 OvGEKoXqdGyIcQpgMQxtAPf2kc9g8zfIezZKbNRtkMb8PKT8kwNfPkUrvqctYYauSDNld
	 /k0fEASbX0KhNRqZg7ZAxaz7lVjnNyv6u59e/b6elaTu4JkWRdFxr3l5D/FMtlqcxsCj6
	 nfexIUrg0vIONklwhIr44qf4uQoO3YToY7Dqf3+mMMZcCbfW+Pl3neSejOMfhpN7T7KIu
	 tFLoaFZlI+b/vui2vT8V1UaMcg04trPrKS4XbJZRCss51XVLdtVgDOW8KkGLkmp9Tfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7YyntXH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A13606A31C
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7YyntXH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920301F000C9
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563943;
	bh=kzbRxsbzGSWFcVikn1/P3s9Ss9UEpi9d3M5amLdtxmc=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=K7YyntXHl8D4Z2RnwQ7K1f5SxTJjTycEUszofOMMIbc0ZkI9L76wzx+vYDncd6mRs
	 CfrvnuaOchaAmfcx+36pKrnle4IMFHybNuzKCdJKi7BiSh5OPtGUU3GFI4XHZjEpg3
	 i4NRDOp0oP0+gdUzxALv2SMzHQ7gWo614ZPhnnC+Aj6x10z4Fz8itgAiD6aOIXVi09
	 dIgo7DKXS7/zWz8Az1WL1abiaWXPsVI/pJw/vSg4Uaj+ulnuey7ueOCTXtC3aElhIl
	 JWOQ0dXklb9nhzRMdkaMqI71zDmV8K4+21kLF8Ib53PalLCHZsER+MO6ItS+riIssb
	 YbqPg6Ygt6L9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v26 7/8] mptcp: sync mptcp skb cb layout with tcp one
Date: Fri, 13 Nov 2026 17:58:46 +0800
Message-ID: <328ddc33883506606aecad77f6645616df082740.1794563432.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794563432.git.tanggeliang@kylinos.cn>
References: <cover.1794563432.git.tanggeliang@kylinos.cn>
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
comparisons, while map_seq64 is used for window validation, coalescing
checks, and DATA_FIN validation. __mptcp_try_coalesce() gains a map_seq64
contiguity check to ensure skbs are truly adjacent in the 64-bit DSN space.
The DATA_FIN check in __mptcp_move_skb() now uses map_seq64 to compare
against rcv_data_fin_seq in the full 64-bit DSN space.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  5 ++-
 net/mptcp/protocol.c | 96 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  6 ++-
 3 files changed, 62 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 48298bfe85a4..bd52e9528b29 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -48,7 +48,8 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	/* The TFO segment data sits before the IASN; before receiving
 	 * the remote key, IASN is assumed being 0.
 	 */
-	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
+	MPTCP_SKB_CB(skb)->map_seq64 = -(u64)skb->len;
+	MPTCP_SKB_CB(skb)->map_seq = MPTCP_SKB_CB(skb)->map_seq64;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
@@ -58,7 +59,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	msk = mptcp_sk(sk);
 	msk->rcvd_dummy_seq = true;
-	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq64;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99dfcd0488a4..d124b702c957 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -167,14 +167,14 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 {
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
-	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->map_seq +
-					   to->len ||
+	if (MPTCP_SKB_CB(from)->map_seq64 != MPTCP_SKB_CB(to)->map_seq64 +
+					     to->len ||
 	    MPTCP_SKB_CB(from)->flags & MPTCP_SKB_CB_F_OFFSET ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
+	pr_debug("colesced seq %x into %x new len %d new end seq %x\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -256,8 +256,8 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
 		struct sk_buff *skb = rb_to_skb(node);
 
 		/* Stop pruning if the incoming skb would land in OoO tail. */
-		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
-			    MPTCP_SKB_CB(skb)->map_seq))
+		if (after(MPTCP_SKB_CB(in_skb)->map_seq,
+			  MPTCP_SKB_CB(skb)->map_seq))
 			break;
 
 		pruned = true;
@@ -303,14 +303,15 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct rb_node **p, *parent;
-	u64 seq, end_seq, max_seq;
+	u64 end_seq, max_seq;
 	struct sk_buff *skb1;
+	u32 seq;
 
 	seq = MPTCP_SKB_CB(skb)->map_seq;
-	end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
+	end_seq = MPTCP_SKB_CB(skb)->map_seq64 + skb->len;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%x limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(end_seq, max_seq)) {
 		/* out of window */
@@ -347,8 +348,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->map_seq +
-		      msk->ooo_last_skb->len)) {
+	if (!before(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->map_seq +
+		    msk->ooo_last_skb->len)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -360,19 +361,19 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	while (*p) {
 		parent = *p;
 		skb1 = rb_to_skb(parent);
-		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
+		if (before(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
 			p = &parent->rb_left;
 			continue;
 		}
-		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
-			if (!after64(end_seq,
-				     MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
+		if (before(seq, MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
+			if (!after((u32)end_seq,
+				   MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
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
@@ -403,8 +404,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq,
-			     MPTCP_SKB_CB(skb1)->map_seq + skb1->len))
+		if (before((u32)end_seq,
+			   MPTCP_SKB_CB(skb1)->map_seq + skb1->len))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -427,10 +428,11 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 
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
@@ -455,19 +457,20 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
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
-	u64 dsn = MPTCP_SKB_CB(skb)->map_seq + skb->len - copy_len;
+	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	u64 dsn = MPTCP_SKB_CB(skb)->map_seq64 + skb->len - copy_len;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
 
 	if (READ_ONCE(msk->rcv_data_fin) &&
-	    !before64(MPTCP_SKB_CB(skb)->map_seq,
+	    !before64(MPTCP_SKB_CB(skb)->map_seq64,
 		      READ_ONCE(msk->rcv_data_fin_seq))) {
 		mptcp_drop(sk, skb);
 		return false;
@@ -505,8 +508,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	/* Partial packet */
-	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
-		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	if (after64(MPTCP_SKB_CB(skb)->map_seq64 + skb->len, msk->ack_seq)) {
+		copy_len = MPTCP_SKB_CB(skb)->end_seq - (u32)msk->ack_seq;
 		goto insert;
 	}
 
@@ -901,42 +904,41 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb, *tail;
+	u32 seq_delta, ack_seq;
 	bool moved = false;
 	struct rb_node *p;
-	u64 end_seq;
 	u64 dsn;
 
 	p = rb_first(&msk->out_of_order_queue);
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
+		ack_seq = msk->ack_seq;
 		skb = rb_to_skb(p);
-		dsn = MPTCP_SKB_CB(skb)->map_seq + skb->len -
+		dsn = MPTCP_SKB_CB(skb)->map_seq64 + skb->len -
 		      (MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq);
-		if (after64(dsn, msk->ack_seq))
+		if (after((u32)dsn, ack_seq))
 			break;
 
 		p = rb_next(p);
 		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
 
-		if (unlikely(!after64(MPTCP_SKB_CB(skb)->map_seq + skb->len,
-				      msk->ack_seq))) {
+		if (unlikely(!after(MPTCP_SKB_CB(skb)->map_seq + skb->len,
+				    ack_seq))) {
 			mptcp_drop(sk, skb);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 			continue;
 		}
 
-		end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
+		seq_delta = MPTCP_SKB_CB(skb)->map_seq + skb->len - ack_seq;
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
@@ -2226,7 +2228,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	int copied = 0;
 
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
-		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
+		u32 offset = (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
 		u32 data_len = skb->len - offset;
 		u32 count;
 		int err;
@@ -4646,7 +4648,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
+		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4896,11 +4898,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
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
index e195993f7aec..90d67c170e7a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -131,10 +131,12 @@
 #define MPTCP_SKB_CB_F_OFFSET	0x0100
 
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
-- 
2.55.0


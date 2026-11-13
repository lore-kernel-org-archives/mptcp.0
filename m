Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563942;
	b=qFwKHatQOJhm0If9t/Mk6H2mvL9UXg10JoQE6JbAD6poqeR9jxf8Q03+nZmO7xHSZOf1
	 d0PR7vktTnCmewDuwNPxY60EJ5WyAebdFc9pKkZlXLyFmAT7IAqvs02ATVci9Si7+bn0H
	 q7xO/e5jAOfUR238yoijmDKghUDPXL2FXgs+hKv81lobNcNioGY6USO3PFtHoucxPGPFq
	 52TP9CMNyThT7yVLBfRlJwo32fDgfd2p5g4fmjv09QhucTUG6JiAPyqZCZbyNwT55r0Pa
	 MopL0bjV2qUxGkrdrfbqPDMsKK/06XgdzhJ7hZtP5Kj9QZgF5hAmSQTecmwvDph6qyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563942;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=20c0LKgm7EiXbMe1XTG/XJ5QNZDf2UH/A6pGS/zsbBY=;
	b=3ShrLziD07UNiYhd+bkJ4MaartXU+uqdlTM0UmMd9ci9yQM1cxreMhNUaRx1BTun6td3
	 oWCwr2K24sUce6WaPPqQQSGJVIuZF3iUEtofAgwt/0A5/CBbvev9sR5VSSK3qk2aAbouZ
	 moYW9VzlPvHsEmQiQBl/yxtTsRK+Dnho8IRVI7m8BUe9SCwX/OKHTzx/wcNhWO/DD9G8x
	 +Q8FfVnj213KlcmoOlRj9UVQdJwvBxibGMxPLj5/Zpn3W2eE4qJaWOOwNLdl9sEB8LsnC
	 cqu/U7VpjtuJ8tcWxGYh68qajiCdSSVWG5wK8EyzZnqI4KjzdQhrhD0IDIhf8iGEN5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QId4mu7X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C1606A323
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QId4mu7X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5721F000C4
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563942;
	bh=20c0LKgm7EiXbMe1XTG/XJ5QNZDf2UH/A6pGS/zsbBY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=QId4mu7XQa0mxjOxvpEPgGT2+1areZ8Sj7F5wsuZlkeMjKq9559IjK5f1FrLATdjy
	 5earx6hcfzVot8jK1hxggO8A3gja7cJLRK9SzLhBijiz1q4n61cIb1Zf4KB3lTSfMJ
	 eLVc6OJbgYbxqQ0H7T+McsDrsQetgxec86NzoKJMFPnFFqp8l+LFIfyfUMtkMhkXHK
	 Zvmy/aArZ7/7xvRAVZs54kYKo873RAyvf+nr7O9mfonNuhIza4j5EK26EWiCMprmtI
	 pXdQrdbq8c8iFTT6FQ7C0q7ip7IbPf1NiDktlsirnSkkcwgvB8mTu7CwSsgNKxDI9i
	 NntEKOaWJXoQQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v26 6/8] mptcp: remove CB offset field
Date: Fri, 13 Nov 2026 17:58:45 +0800
Message-ID: <0bd74213de97c6d796b835f567e0f426bee89008.1794563432.git.tanggeliang@kylinos.cn>
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

Instead, use a new msk-level field to track the bytes already consumed
inside each skb, carrying the amount of bytes already copied to
user-space, alike what TCP is already doing.

The newly introduced `copied_seq` field is always accessed under the msk
socket lock, delegating the synchronization with IASN to mptcp_move_skbs()
and the msk release CB, when the socket is owned by the user-space at
remote key reception time. Such synchronization preserves any partial
progress (copy) made on the TFO packet.

In mptcp_init_skb(), map_seq is computed as mptcp_subflow_get_mapped_dsn()
minus offset. A mapping boundary check using before() for proper 32-bit
modular arithmetic detects when the skb spans multiple DSS mappings
(offset > 0 and skb starts before the current mapping). In that case,
the consumed prefix bytes belong to an old mapping and must be removed
before setting map_seq. The function now returns bool to indicate success.

When removing the prefix, we handle linear and paged data separately.
For offset within linear data where offset <= skb_headlen, use skb_pull()
which is safe and doesn't modify truesize. For offset in paged data where
offset > skb_headlen, use pskb_pull() which may expand the skb head. To
avoid truesize corruption in pskb_expand_head(), we first orphan the skb
to disconnect it from the socket, perform the pull, recompute truesize
manually, then reattach with skb_set_owner_r(). This ensures proper memory
accounting.

When mptcp_init_skb() fails, the caller increments seq to skip the
problematic skb, records the failure via MPTCP_MIB_RCVPRUNED, and jumps
to cleanup to ensure tp->copied_seq and more_data_avail are properly
updated. This maintains TCP/MPTCP state consistency, and MPTCP-level
retransmission will fill any resulting gaps.

When the skb stays within a single mapping and offset > 0, map_seq is
rewound to cover the already-consumed prefix. A new MPTCP_SKB_CB_F_OFFSET
flag marks such skbs. __mptcp_try_coalesce() refuses to coalesce when the
from skb carries this flag, preventing an unvalidated prefix from being
merged into a validated buffer. mptcp_data_queue_ofo() skips the
rb_replace_node() replacement when the new skb covers an existing OFO
entry and carries the flag, so that previously validated data is not
overwritten by an unvalidated prefix; the new skb is inserted after the
existing entry instead, and the prefix is naturally skipped when the OFO
queue is later processed.

To prevent offset calculation underflow when a protocol-violating peer
sends data after DATA_FIN, __mptcp_move_skb() rejects skbs whose map_seq
is at or beyond rcv_data_fin_seq when DATA_FIN has been received. Since
copied_seq tracks only payload bytes and cannot advance past the DATA_FIN
sequence number, accepting data after DATA_FIN would cause the read
position calculation (copied_seq - map_seq) to underflow.

Overall this simplifies a bit the __mptcp_recvmsg_mskq() and the
__mptcp_move_skb() code and will also make possible the next patch.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |   9 ++--
 net/mptcp/protocol.c | 117 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |   5 +-
 net/mptcp/subflow.c  |   6 ++-
 4 files changed, 79 insertions(+), 58 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index e18b31028e7e..48298bfe85a4 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -45,10 +45,12 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	subflow->ssn_offset += skb->len;
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
-	/* Only the sequence delta is relevant */
-	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
+	/* The TFO segment data sits before the IASN; before receiving
+	 * the remote key, IASN is assumed being 0.
+	 */
+	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
-	MPTCP_SKB_CB(skb)->offset = 0;
+	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	mptcp_data_lock(sk);
@@ -56,6 +58,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	msk = mptcp_sk(sk);
 	msk->rcvd_dummy_seq = true;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 41fc2429d2fe..99dfcd0488a4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -167,8 +167,9 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 {
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
-	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
-	    MPTCP_SKB_CB(from)->offset ||
+	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->map_seq +
+					   to->len ||
+	    MPTCP_SKB_CB(from)->flags & MPTCP_SKB_CB_F_OFFSET ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
@@ -306,7 +307,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	struct sk_buff *skb1;
 
 	seq = MPTCP_SKB_CB(skb)->map_seq;
-	end_seq = MPTCP_SKB_CB(skb)->end_seq;
+	end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
 	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
@@ -346,7 +347,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->map_seq +
+		      msk->ooo_last_skb->len)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -362,8 +364,9 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 			p = &parent->rb_left;
 			continue;
 		}
-		if (before64(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
-			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
+		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
+			if (!after64(end_seq,
+				     MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
 				/* All the bits are present. Drop. */
 				mptcp_drop(sk, skb);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
@@ -400,7 +403,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
+		if (before64(end_seq,
+			     MPTCP_SKB_CB(skb1)->map_seq + skb1->len))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -425,9 +429,10 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
 	 * value
 	 */
-	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
+	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
+				     offset;
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
-	MPTCP_SKB_CB(skb)->offset = offset;
+	MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
@@ -450,17 +455,24 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 	if (!skb)
 		return;
 
-	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len +
-				     MPTCP_SKB_CB(skb)->offset;
-	MPTCP_SKB_CB(skb)->end_seq = msk->tfo_iasn;
+	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	u64 dsn = MPTCP_SKB_CB(skb)->map_seq + skb->len - copy_len;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
 
+	if (READ_ONCE(msk->rcv_data_fin) &&
+	    !before64(MPTCP_SKB_CB(skb)->map_seq,
+		      READ_ONCE(msk->rcv_data_fin_seq))) {
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
 	mptcp_borrow_fwdmem(sk, skb);
 
 	/* Be sure to sync the eventual fastopen dummy mapping before any other
@@ -469,7 +481,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(msk->rcvd_dummy_seq))
 		__mptcp_sync_rcv_sequence(sk);
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	if (dsn == msk->ack_seq) {
 		/* in sequence */
 insert:
 		if (!mptcp_try_rmem_schedule(sk, skb)) {
@@ -487,7 +499,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
-	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
+	} else if (after64(dsn, msk->ack_seq)) {
 		mptcp_data_queue_ofo(msk, skb);
 		return false;
 	}
@@ -495,10 +507,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	/* Partial packet */
 	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
 		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
-					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
 
@@ -896,35 +904,35 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	bool moved = false;
 	struct rb_node *p;
 	u64 end_seq;
+	u64 dsn;
 
 	p = rb_first(&msk->out_of_order_queue);
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
 		skb = rb_to_skb(p);
-		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
+		dsn = MPTCP_SKB_CB(skb)->map_seq + skb->len -
+		      (MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq);
+		if (after64(dsn, msk->ack_seq))
 			break;
 
 		p = rb_next(p);
 		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
 
-		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq,
+		if (unlikely(!after64(MPTCP_SKB_CB(skb)->map_seq + skb->len,
 				      msk->ack_seq))) {
 			mptcp_drop(sk, skb);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 			continue;
 		}
 
-		end_seq = MPTCP_SKB_CB(skb)->end_seq;
+		end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
-			/* skip overlapping data, if any */
 			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
-			MPTCP_SKB_CB(skb)->offset += delta;
-			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
 		msk->bytes_received += end_seq - msk->ack_seq;
@@ -2209,33 +2217,24 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
 }
 
 static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
-				size_t len, int flags, int copied_total,
+				size_t len, int flags, u64 *seq,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags, struct sk_buff **last)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb, *tmp;
-	int total_data_len = 0;
 	int copied = 0;
 
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
-		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
+		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
 		u32 data_len = skb->len - offset;
 		u32 count;
 		int err;
 
-		if (flags & MSG_PEEK) {
-			/* skip already peeked skbs */
-			if (total_data_len + data_len <= copied_total) {
-				total_data_len += data_len;
-				*last = skb;
-				continue;
-			}
-
-			/* skip the already peeked data in the current skb */
-			delta = copied_total - total_data_len;
-			offset += delta;
-			data_len -= delta;
+		/* Skip the already peeked data. */
+		if (offset >= skb->len) {
+			*last = skb;
+			continue;
 		}
 
 		count = min_t(size_t, len - copied, data_len);
@@ -2255,14 +2254,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 		}
 
 		copied += count;
+		*seq += count;
 
 		if (!(flags & MSG_PEEK)) {
 			msk->bytes_consumed += count;
-			if (count < data_len) {
-				MPTCP_SKB_CB(skb)->offset += count;
-				MPTCP_SKB_CB(skb)->map_seq += count;
+			if (count < data_len)
 				break;
-			}
 
 			mptcp_eat_recv_skb(sk, skb);
 		} else {
@@ -2401,8 +2398,10 @@ static bool mptcp_move_skbs(struct sock *sk)
 
 	mptcp_data_lock(sk);
 	while (1) {
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
 			__mptcp_sync_rcv_sequence(sk);
+		}
 
 		if (!mptcp_can_spool_backlog(sk, &skbs))
 			break;
@@ -2442,6 +2441,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
+	u64 peek_seq, *seq;
 	int target;
 	long timeo;
 
@@ -2460,6 +2460,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	len = min_t(size_t, len, INT_MAX);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+	seq = &msk->copied_seq;
+	if (flags & MSG_PEEK) {
+		peek_seq = msk->copied_seq;
+		seq = &peek_seq;
+	}
 
 	if (unlikely(msk->recvmsg_inq))
 		cmsg_flags = MPTCP_CMSG_INQ;
@@ -2469,7 +2474,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags,
+						  seq, &tss, &cmsg_flags,
 						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
@@ -2479,8 +2484,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
+			if (flags & MSG_PEEK)
+				peek_seq = msk->copied_seq + copied;
 			continue;
+		}
 
 		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -2523,6 +2531,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			copied = copied ? : err;
 			goto out_err;
 		}
+
+		/* Recompute peek offset after eventual seq resync. */
+		if (flags & MSG_PEEK)
+			peek_seq = msk->copied_seq + copied;
 	}
 
 	mptcp_cleanup_rbuf(msk, copied);
@@ -3699,6 +3711,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 	msk->bytes_consumed = 0;
+	msk->copied_seq = 0;
 	msk->bytes_acked = 0;
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
@@ -3909,8 +3922,10 @@ static void mptcp_release_cb(struct sock *sk)
 		struct list_head join_list, skbs;
 		bool spool_bl;
 
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
 			__mptcp_sync_rcv_sequence(sk);
+		}
 
 		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
 		if (!flags && !spool_bl)
@@ -4631,7 +4646,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4673,11 +4688,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		copied += count;
 
 		msk->bytes_consumed += count;
-		if (count < data_len) {
-			MPTCP_SKB_CB(skb)->offset += count;
-			MPTCP_SKB_CB(skb)->map_seq += count;
+		msk->copied_seq += count;
+		if (count < data_len)
 			break;
-		}
 
 		mptcp_eat_recv_skb(sk, skb);
 		if (!desc->count)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4e49d719200..e195993f7aec 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -128,10 +128,12 @@
 #define MPTCP_SYNC_SNDBUF	7
 #define MPTCP_SYNC_SEQ		8
 
+#define MPTCP_SKB_CB_F_OFFSET	0x0100
+
 struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
-	u32 offset;
+	u16 flags;
 	u8  has_rxtstamp;
 };
 
@@ -311,6 +313,7 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	u64		bytes_consumed;
+	u64		copied_seq;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f9dfb6662e3c..83beaa54b634 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -541,10 +541,12 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 	msk->tfo_iasn = subflow->iasn;
 
-	if (!sock_owned_by_user(sk))
+	if (!sock_owned_by_user(sk)) {
+		msk->copied_seq += subflow->iasn;
 		__mptcp_sync_rcv_sequence(sk);
-	else
+	} else {
 		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
+	}
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.55.0


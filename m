Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216268;
	b=mquy8LFeo6VWvJNgvt3bAImcpIPphXECegBb+tTGoYPGdS8gVbOkH/W1Cr3Ui9YRbOIH
	 LBp3au/6r0F1bx6QzVEhvRjuBbbcG4pe45+TPwY7pqw74lbVymdk/vPEvGKFeDanUqQh7
	 4AQSsM4gAkN8gtpz0IspSOlrYRKc0To/ViJ/ttozTSo+O9LPWROtwGcqUVG/ZoaDkkI7p
	 7jOPrCBDCGUZnpCUNiVBPVR4PyxK19/HKcxycnD5YTbVLwj1i4YQHkjmR8/5HzLgLqqyf
	 Xh1i5gtBSyrCBV5zHMepf1XBGweWM4KO0KvA7QwWEfP2CG8rvoIBAF3rOXZjp/mShzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216268;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zjJCn89IO1FptIopZdbtBbKrSfoS8S4q+jA8zD97GAE=;
	b=E2PZGF1xHUwO7lyzgmYTHxA6Jk5wGHjUjR/50irbqu3lZkDwFCeLGKMM3OZmbBXGeAqP
	 a0GZczeXa/9Gcy9iYNgs/bJak8hSMYtppasEZThMRG1cYg4U7nH87/7kCUIfZOlc0MpNe
	 e5Z6xPhJY+Vx8Uv2tZIAQKT6Y2MOFNuTqFvuCcronah8X162zvhdCfvYmaaLT4HH2YFu4
	 XJu5McjecTHbCdqYU0MeQBSh/+92jRh8PM6rOOVgFaVb2I4DMP71H6U0y+60euvAyl0rL
	 nuwlB2S7sBGAUvn6kRA00wv488WAk+CKsClySE/g+riN3S4ScKib1bsyRI2OFWuLd5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvYuJmlL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44445606D81B
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvYuJmlL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F3E1F008A1
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216267;
	bh=zjJCn89IO1FptIopZdbtBbKrSfoS8S4q+jA8zD97GAE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=bvYuJmlLkG3HXwwwV9vZfXCckyX6Fhk9O/bQ4OCdyuEY2KHwTpYT4G4N2IR474xx5
	 coaqWUq6SQifThsrcIph8paXVRZgmIOQjQfe8xLlS3WlE0Yetn/k2s6kDsDX7nFv/j
	 avHXOmTPRpPnakPMpfRVsKIzo2vZNZTuDx1/P3AamRzHGeZaR1e0Ig4CeiOMJeRcrp
	 jn8bUD5EkmB8TDV0gRsq5allkv9On2tCJN+doNkLSwXI/Y17brBVenBorMCNCcpEEu
	 I8HaYCihoViWV7nZu1Fb36fw3KCS6JtDmsMv5oYDdOk/1g70LCQNNQDtAJnGtQzr0e
	 aqntPR7THhoUg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v24 6/8] mptcp: remove CB offset field
Date: Mon,  9 Nov 2026 17:24:08 +0800
Message-ID: <8b30d5f811cfc37189badb3f7c86f565059063e4.1794215614.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794215614.git.tanggeliang@kylinos.cn>
References: <cover.1794215614.git.tanggeliang@kylinos.cn>
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

Overall this simplifies a bit the __mptcp_recvmsg_mskq() and the
__mptcp_move_skb() code and will also make possible the next patch.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |   9 ++--
 net/mptcp/protocol.c | 122 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |   5 +-
 net/mptcp/subflow.c  |   6 ++-
 4 files changed, 94 insertions(+), 48 deletions(-)

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
index ce0f9c2e6fd1..30933dd9f0b1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -168,7 +168,7 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
-	    MPTCP_SKB_CB(from)->offset ||
+	    MPTCP_SKB_CB(from)->flags & MPTCP_SKB_CB_F_OFFSET ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
@@ -375,6 +375,11 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 				 *  |     skb1    |
 				 * continue traversing
 				 */
+			} else if (MPTCP_SKB_CB(skb)->flags &
+				   MPTCP_SKB_CB_F_OFFSET) {
+				/* skb covers skb1 but has an unvalidated
+				 * prefix; keep skb1, continue traversing.
+				 */
 			} else {
 				/* skb's seq == skb1's seq and skb covers skb1.
 				 * Replace skb1 with skb.
@@ -415,25 +420,54 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	skb_set_owner_r(skb, sk);
 }
 
-static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
-			   int copy_len)
+static bool mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
+	/* Detect mapping boundary: skb spans multiple mappings */
+	if (unlikely(offset > 0 &&
+		     before(TCP_SKB_CB(skb)->seq - subflow->ssn_offset,
+			    subflow->map_subflow_seq))) {
+		if (offset >= skb->len) {
+			sk_eat_skb(ssk, skb);
+			return false;
+		}
+
+		if (offset > skb_headlen(skb)) {
+			skb_orphan(skb);
+			if (!pskb_pull(skb, offset)) {
+				sk_eat_skb(ssk, skb);
+				return false;
+			}
+			skb->truesize = SKB_TRUESIZE(skb_end_offset(skb)) +
+					skb->data_len;
+			skb_set_owner_r(skb, ssk);
+		} else {
+			if (!skb_pull(skb, offset)) {
+				sk_eat_skb(ssk, skb);
+				return false;
+			}
+		}
+		offset = 0;
+	}
+
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
 	 * value
 	 */
-	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
-	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
-	MPTCP_SKB_CB(skb)->offset = offset;
+	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
+				     offset;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
+	MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 
 	skb_ext_reset(skb);
 	skb_dst_drop(skb);
+
+	return true;
 }
 
 void __mptcp_sync_rcv_sequence(struct sock *sk)
@@ -494,10 +528,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	/* Partial packet */
 	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
 		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
-					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
 
@@ -855,7 +885,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			mptcp_init_skb(ssk, skb, offset, len);
+			if (!mptcp_init_skb(ssk, skb, offset)) {
+				MPTCP_INC_STATS(sock_net(sk),
+						MPTCP_MIB_RCVPRUNED);
+				seq += len;
+				goto out;
+			}
 
 			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
@@ -878,6 +913,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			}
 		}
 
+out:
 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail = mptcp_subflow_data_available(ssk);
 
@@ -918,12 +954,9 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
@@ -2207,33 +2240,24 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -2252,14 +2276,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2398,8 +2420,10 @@ static bool mptcp_move_skbs(struct sock *sk)
 
 	mptcp_data_lock(sk);
 	while (1) {
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
 			__mptcp_sync_rcv_sequence(sk);
+		}
 
 		if (!mptcp_can_spool_backlog(sk, &skbs))
 			break;
@@ -2439,6 +2463,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
+	u64 peek_seq, *seq;
 	int target;
 	long timeo;
 
@@ -2457,6 +2482,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	len = min_t(size_t, len, INT_MAX);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+	seq = &msk->copied_seq;
+	if (flags & MSG_PEEK) {
+		peek_seq = msk->copied_seq;
+		seq = &peek_seq;
+	}
 
 	if (unlikely(msk->recvmsg_inq))
 		cmsg_flags = MPTCP_CMSG_INQ;
@@ -2466,7 +2496,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags,
+						  seq, &tss, &cmsg_flags,
 						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
@@ -2476,8 +2506,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
+			if (flags & MSG_PEEK)
+				peek_seq = msk->copied_seq + copied;
 			continue;
+		}
 
 		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -2520,6 +2553,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			copied = copied ? : err;
 			goto out_err;
 		}
+
+		/* Recompute peek offset after eventual seq resync. */
+		if (flags & MSG_PEEK)
+			peek_seq = msk->copied_seq + copied;
 	}
 
 	mptcp_cleanup_rbuf(msk, copied);
@@ -3696,6 +3733,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 	msk->bytes_consumed = 0;
+	msk->copied_seq = 0;
 	msk->bytes_acked = 0;
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
@@ -3906,8 +3944,10 @@ static void mptcp_release_cb(struct sock *sk)
 		struct list_head join_list, skbs;
 		bool spool_bl;
 
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
 			__mptcp_sync_rcv_sequence(sk);
+		}
 
 		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
 		if (!flags && !spool_bl)
@@ -4628,7 +4668,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4670,11 +4710,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index b4e49d719200..fd3326518ee5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -128,10 +128,12 @@
 #define MPTCP_SYNC_SNDBUF	7
 #define MPTCP_SYNC_SEQ		8
 
+#define MPTCP_SKB_CB_F_OFFSET	0x01
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


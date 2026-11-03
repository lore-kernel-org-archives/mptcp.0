Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696256;
	b=5BfvXFbf1hi4BLi2+2tvjwUa4OAYknur7fuSEwSjDd2ndoGvERXBjXpN32mkTqBJGLuh
	 odTzo3fPaXQR9j/9E6MKaht/HQ9bcDH0vld8APPmaiOXPVl1tI779vpwVLGh0gCnY27VB
	 X5CeY4MrOZwC1G9ytiJF1TedHiGjudPxg5iieTJcHYSOC+QAusrvONuquMhK7hYY6ilRq
	 uWYto2eLkVjjKONw+KQ6R3qG67UmxjcFtCRu+lbnYam2kOUYrvBCOTxKZkUT8M9MuSZ9Z
	 2K1Rh1Y8fd4CJ2lwdWN2ZjMEU4Xz/aWO9UlIAQpgTvb9SvLbHCaUQKjsWsTHeEPoGVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4KiZ3dmr8gD7SWhOHGIv++CBSW7FDjFfn5WrCserku4=;
	b=nbcGTXJvp/yjdLKBORTC2NcBm5lietsCP697jFDxhStYHUQLpTEnS2MMmvSsw9ziKS2U
	 MJnhHhtGa9NiH82E+dT2+Fc9RGglbrkGBCzNXj3JpIQd8c/BKV16ubvTiUnViKNWGztri
	 4qJILFsUCvY9foiUxHDuU10mF2rPSpEPPKF0E/XDR0znUNW/9D5CiPZBguzeOZcAno1BZ
	 hGtmKeWL9VXhoPzXOjdn04o98zwJmuCDddYz0OZ0iFpScZ8CpSD5K+/4rIzDr9k2R8hgO
	 F7zzDEh+ibyQrFmjb1FY2KBiJxMo3dKBMDFByZMFL1UcG1JmDGS2nPgjZXZ7SfIwuaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHEhEXui;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041D606D801
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHEhEXui
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC271F00A15;
	Tue,  3 Nov 2026 08:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696255;
	bh=4KiZ3dmr8gD7SWhOHGIv++CBSW7FDjFfn5WrCserku4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aHEhEXuiZa32Pyc2fxzjzwEGYl6qXW2INA7Kk5A+oPIAYeYudpE85eQvIM89ipiO5
	 pVuWGbHEgmEFKZzCAU8KOae6dictif+zyYZxAnSO1qiX9MMx6e1Bqk1+VJUP9iAWi1
	 qxrODQpndmuDSDIgtOf0d5bgUcd9PdVVj9mY7uK/nf7ag47r/R+nKecyKhpzDkwHsF
	 Mf3bNdaXJgptiDZg2GBcsJIrase/FAN58ElCSmY1mWbYFu+oyNPcoWsWRmGbL03ojB
	 Owf+Mdv8oQJoqytR7DFYDbZ6eQJhkG3WBww24l9jVicVevhsg6uXF5kX78rLFlNDRn
	 vzMm++EXgWb9Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v20 4/6] mptcp: remove CB offset field
Date: Tue,  3 Nov 2026 16:57:23 +0800
Message-ID: <866f86ad2ea894fc21af7546ed0cf6f8b9d816de.1793695518.git.tanggeliang@kylinos.cn>
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

Instead, use a new msk-level field to track the bytes already consumed
inside each skb, carrying the amount of bytes already copied to
user-space, alike what TCP is already doing.

The newly introduce `copied_seq` field is always accessed under the msk
socket lock, delegating the synchronization with IASN to mptcp_move_skbs()
and the msk release CB, when the socket is owned by the user-space at
remote key reception time. Such synchronization preserves any partial
progress (copy) made on the TFO packet.

Prior to this patch, the TFO skb dummy mapping (map_seq = -(u32)skb->len,
zero-extended to u64) caused mptcp_inq_hint() to compute a wrapped
ack_seq - map_seq, so SIOCINQ and TCP_CM_INQ returned INT_MAX before the
MPC ACK.  This patch fixes that behaviour through both the -(u64)skb->len
sign fix and the new ack_seq - copied_seq hint.

Overall this simplifies a bit the __mptcp_recvmsg_mskq(), mptcp_inq_hint()
and the __mptcp_move_skb() code and will also make possible the next
patch.

In mptcp_init_skb(), map_seq is computed as mptcp_subflow_get_mapped_dsn()
minus offset. This is correct even when offset > 0 and the mapping is
out-of-order, because mptcp_subflow_get_mapped_dsn() returns the DSN for
the byte at tp->copied_seq (position 'offset' in the skb), and the
consumed prefix bytes are part of the same logical DSN range.

Initialize MPTCP sequence space to 0 in mptcp_propagate_state() when mp_opt
is NULL, ensuring SKB's map_seq starts from 0 to match msk->copied_seq and
prevent offset calculation underflow in fallback mode.  The writes are safe
without sock_owned_by_user() deferral because mptcp_propagate_state()
already holds mptcp_data_lock().

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  2 +-
 net/mptcp/protocol.c | 93 +++++++++++++++++++++++---------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  | 15 +++++--
 4 files changed, 62 insertions(+), 50 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 79765cf55286..78481c100e2a 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -50,7 +50,6 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	 */
 	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
-	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	mptcp_data_lock(sk);
@@ -58,6 +57,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	msk = mptcp_sk(sk);
 	msk->rcvd_dummy_seq = true;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f3b07b303f55..3bd7d38ce78c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -168,7 +168,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
-	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
@@ -415,8 +414,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	skb_set_owner_r(skb, sk);
 }
 
-static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
-			   int copy_len)
+static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
@@ -424,10 +422,13 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
 	 * value
+	 *
+	 * This is correct even when offset > 0 and mapping is out-of-order,
+	 * because consumed prefix bytes are part of the same logical DSN range.
 	 */
-	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
-	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
-	MPTCP_SKB_CB(skb)->offset = offset;
+	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
+				     offset;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
@@ -451,7 +452,7 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 		return;
 
 	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len;
-	MPTCP_SKB_CB(skb)->end_seq = msk->tfo_iasn;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
@@ -494,10 +495,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	/* Partial packet */
 	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
 		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
-					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
 
@@ -855,7 +852,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			mptcp_init_skb(ssk, skb, offset, len);
+			mptcp_init_skb(ssk, skb, offset);
 
 			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
@@ -918,12 +915,9 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
@@ -2207,33 +2201,24 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -2252,14 +2237,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2397,9 +2380,15 @@ static bool mptcp_move_skbs(struct sock *sk)
 	u32 moved = 0;
 
 	mptcp_data_lock(sk);
-	if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
-		__mptcp_sync_rcv_sequence(sk);
-	while (mptcp_can_spool_backlog(sk, &skbs)) {
+	while (1) {
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
+			__mptcp_sync_rcv_sequence(sk);
+		}
+
+		if (!mptcp_can_spool_backlog(sk, &skbs))
+			break;
+
 		mptcp_data_unlock(sk);
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
 
@@ -2441,6 +2430,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
+	u64 peek_seq, *seq;
 	int target;
 	long timeo;
 
@@ -2459,6 +2449,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	len = min_t(size_t, len, INT_MAX);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+	seq = &msk->copied_seq;
+	if (flags & MSG_PEEK) {
+		peek_seq = msk->copied_seq;
+		seq = &peek_seq;
+	}
 
 	if (unlikely(msk->recvmsg_inq))
 		cmsg_flags = MPTCP_CMSG_INQ;
@@ -2468,7 +2463,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags,
+						  seq, &tss, &cmsg_flags,
 						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
@@ -2478,8 +2473,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
+			if (flags & MSG_PEEK)
+				peek_seq = msk->copied_seq + copied;
 			continue;
+		}
 
 		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -2522,6 +2520,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			copied = copied ? : err;
 			goto out_err;
 		}
+
+		/* Recompute peek offset after eventual seq resync. */
+		if (flags & MSG_PEEK)
+			peek_seq = msk->copied_seq + copied;
 	}
 
 	mptcp_cleanup_rbuf(msk, copied);
@@ -3698,6 +3700,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 	msk->bytes_consumed = 0;
+	msk->copied_seq = 0;
 	msk->bytes_acked = 0;
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
@@ -3908,8 +3911,10 @@ static void mptcp_release_cb(struct sock *sk)
 		struct list_head join_list, skbs;
 		bool spool_bl;
 
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
 			__mptcp_sync_rcv_sequence(sk);
+		}
 
 		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
 		if (!flags && !spool_bl)
@@ -4630,7 +4635,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4672,11 +4677,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index b4e49d719200..7878e6ac6c0b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -131,7 +131,6 @@
 struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
-	u32 offset;
 	u8  has_rxtstamp;
 };
 
@@ -311,6 +310,7 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	u64		bytes_consumed;
+	u64		copied_seq;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8a3ba490b577..71c3b148cf04 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -537,10 +537,12 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
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
@@ -557,6 +559,13 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
 		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 		subflow_set_remote_key(msk, subflow, mp_opt);
+	} else {
+		/* Fallback (no MPTCP options at SYN-ACK) */
+		subflow->map_seq = 0;
+		subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
+					   subflow->ssn_offset;
+		WRITE_ONCE(msk->ack_seq, 0);
+		msk->copied_seq = 0;
 	}
 
 	if (!sock_owned_by_user(sk)) {
@@ -1493,7 +1502,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
 	subflow->map_data_len = skb->len;
-	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;
 	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
 					      subflow->iasn +
 					      TCP_SKB_CB(skb)->seq -
-- 
2.55.0


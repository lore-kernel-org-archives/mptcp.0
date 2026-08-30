Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F753B777F
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100389; cv=none; b=aQM1saAU+StuNOPGqSulV8/WVNCQ78FFnQPjM/MbbwVRcpQMKtDcjRBjvez40imvVhPiF7dqXJvCwaNpD6eE5VXCiLPinQlCrDrT5QdwP3SY977RjHTaEYVuGQ4FYPBWa+zAaiHSkir53FDQo1tSS1sa9cgAejku82cUOleQJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100389; c=relaxed/simple;
	bh=RCJLP4ImlgAMRvaiEZKBwbKIiSylnv9907gjD1difmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=um4TjzqJPwJdD5/rxzqFvFqTdqjChLntRchPswUROrf8xmvO7qNQijh/d9gKFscOgP8amVUTjszbv8SIV0Kd2PsbSa4mbp8ZEQ2NVrX7ASLEHwRxV4RJvvsARqBfdGo6bapU1XJiDupgBGRDAJjtrpXB6H+cE2C+5GdAh4d5KlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4Sl/Erx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4Sl/Erx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216291F00A3D;
	Sun, 30 Aug 2026 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100385;
	bh=tLKeV7JJxA9wBGNEtvx55qYTWBfawTDagEzGKdoPYN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4Sl/ErxWaLTQpMQ7xVhkl2cp+5+7MEpuziFAI+vNGTXdepbcdy008tZXzi3QWVIV
	 wm+pOoBITeArFXvvp23BMhi3ZBOf0ue4mF715DBqlxCjJkjI1Yt/23I9DUTxXVBoig
	 zFKDSbmfwjVDiJpIS6r0fsEJtc/Vv456RLTfbIouUUwNmhJRVoanKi1Z7W9reKAp4T
	 6viFoDI1mn4ax6KZ2RKLd9uAOIGXjGf8+qlF5EL2xPYOW4YmGy9D0tKx52JrhFxbyR
	 +HkJzgEUAtnnmm/lJIky5CKWemOrTMa8ezt0m9neG/2vMMiUA/+AMnSgNQhos5WS+x
	 Bz5At26+PCY1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v11 03/10] mptcp: remove CB offset field
Date: Sun, 30 Aug 2026 22:32:46 +0800
Message-ID: <a11e4fe7492659532f82f0fc142dfd5c42ff8fda.1788099847.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788099847.git.tanggeliang@kylinos.cn>
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Instead, use a new msk-level field to track the bytes already consumed
inside each skb, carrying the amount of bytes already copied to
user-space, alike what TCP is already doing.

The newly introduce `copied_seq` field is always accessed under the msk
socket lock, delegating the synchronization with IASN to the msk release
CB, when the socket is owned by the user-space at remote key reception
time. Such synchronization preserves any partial progress (copy) made on
the TFO packet.

Note that the explicit synchronization in __mptcp_move_skb() is needed to
ensure that the TFO skb in the receive queue got its map_seq synched
before the next skb lands into the receive queue when spooling the backlog
at mptcp_release_cb() time, as the release CB synchronization will happen
later.

Prior to this patch, the TFO skb dummy mapping was always ignored, now it
affects the `copied_seq` initial update: be sure to extends the sign
correctly of such mapping initialization time.

Overall this simplify a bit the __mptcp_recvmsg_mskq(), mptcp_inq_hint()
and the __mptcp_move_skb() code and will also make possible the next
patch.

Initialize MPTCP sequence space to 0 in mptcp_propagate_state() when mp_opt
is NULL, ensuring SKB's map_seq starts from 0 to match msk->copied_seq and
prevent offset calculation underflow in fallback mode.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |   9 ++--
 net/mptcp/protocol.c | 108 +++++++++++++++++++++----------------------
 net/mptcp/protocol.h |   8 +++-
 net/mptcp/subflow.c  |   9 ++++
 4 files changed, 74 insertions(+), 60 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index e18b31028e7e..421a50a85547 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -45,10 +45,11 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
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
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	mptcp_data_lock(sk);
@@ -56,6 +57,8 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	msk = mptcp_sk(sk);
 	msk->rcvd_dummy_seq = true;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
+	msk->tfo_skb_len = skb->len;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 834bf540117b..5c308342c1a9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -29,7 +29,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-static unsigned int mptcp_inq_hint(const struct sock *sk);
+static unsigned int mptcp_inq_hint(struct sock *sk);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
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
@@ -425,9 +423,9 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
 	 * value
 	 */
-	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
-	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
-	MPTCP_SKB_CB(skb)->offset = offset;
+	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
+				     offset;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
@@ -440,7 +438,6 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
-	u32 offset;
 
 	if (likely(!msk->rcvd_dummy_seq))
 		return;
@@ -451,9 +448,8 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 	if (!skb)
 		return;
 
-	offset = MPTCP_SKB_CB(skb)->offset;
-	MPTCP_SKB_CB(skb)->map_seq = msk->ack_seq - skb->len + offset;
-	MPTCP_SKB_CB(skb)->end_seq = msk->ack_seq;
+	MPTCP_SKB_CB(skb)->map_seq = mptcp_iasn(msk) - skb->len;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
@@ -467,6 +463,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
 		/* Ensure we see the updated ack_seq after seeing the flag */
 		smp_rmb();
+		msk->copied_seq += mptcp_iasn(msk);
 
 		/* Be sure to sync the eventual fastopen dummy mapping before
 		 * any other skb lands into the msk.
@@ -501,10 +498,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	/* Partial packet */
 	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
 		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
-					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
 
@@ -862,7 +855,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			mptcp_init_skb(ssk, skb, offset, len);
+			mptcp_init_skb(ssk, skb, offset);
 
 			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
@@ -929,8 +922,6 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
-			MPTCP_SKB_CB(skb)->offset += delta;
-			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
 		msk->bytes_received += end_seq - msk->ack_seq;
@@ -2204,33 +2195,24 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -2249,14 +2231,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2409,25 +2389,27 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+static unsigned int mptcp_inq_hint(struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
-
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
-
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
+	u64 hint_val;
 
-		return (unsigned int)hint_val;
+	/* Avoid races vs ack_seq updates and MPTCP_SYNC_SEQ flag. */
+	mptcp_data_lock(sk);
+	if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+		mptcp_data_unlock(sk);
+		return 0;
 	}
+	hint_val = msk->ack_seq - msk->copied_seq;
+	mptcp_data_unlock(sk);
+	if (hint_val >= INT_MAX)
+		return INT_MAX;
 
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
+	if (!hint_val &&
+	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
 		return 1;
 
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -2436,6 +2418,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
+	u64 peek_seq, *seq;
 	int target;
 	long timeo;
 
@@ -2454,6 +2437,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	len = min_t(size_t, len, INT_MAX);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+	seq = &msk->copied_seq;
+	if (flags & MSG_PEEK) {
+		peek_seq = msk->copied_seq;
+		seq = &peek_seq;
+	}
 
 	if (unlikely(msk->recvmsg_inq))
 		cmsg_flags = MPTCP_CMSG_INQ;
@@ -2463,7 +2451,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags,
+						  seq, &tss, &cmsg_flags,
 						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
@@ -2473,8 +2461,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
+			if (flags & MSG_PEEK)
+				peek_seq = msk->copied_seq + copied;
 			continue;
+		}
 
 		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -2518,6 +2509,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			err = copied ? : err;
 			goto out_err;
 		}
+
+		/* Recompute peek offset after eventual seq resync. */
+		if (flags & MSG_PEEK)
+			peek_seq = msk->copied_seq + copied;
 	}
 
 	mptcp_cleanup_rbuf(msk, copied);
@@ -3701,11 +3696,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
+	msk->tfo_skb_len = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
 	atomic64_set(&msk->rcv_wnd_sent, 0);
+	msk->copied_seq = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
@@ -3935,6 +3932,7 @@ static void mptcp_release_cb(struct sock *sk)
 			 * the flag
 			 */
 			smp_rmb();
+			msk->copied_seq += mptcp_iasn(msk);
 			__mptcp_sync_rcv_sequence(sk);
 		}
 	}
@@ -4601,7 +4599,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4643,11 +4641,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index 767021ac65a9..91a7bbaf46b4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -131,7 +131,6 @@
 struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
-	u32 offset;
 	u8  has_rxtstamp;
 };
 
@@ -292,6 +291,7 @@ struct mptcp_sock {
 	u64		bytes_sent;
 	u64		snd_nxt;
 	u64		bytes_received;
+	u64		copied_seq;
 	u64		ack_seq;
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
@@ -311,6 +311,7 @@ struct mptcp_sock {
 	u32		last_ack_recv;
 	unsigned long	timer_ival;
 	u32		token;
+	u32		tfo_skb_len;
 	unsigned long	flags;
 	unsigned long	cb_flags;
 	bool		rcvd_dummy_seq;
@@ -865,6 +866,11 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
+static inline u64 mptcp_iasn(const struct mptcp_sock *msk)
+{
+	return msk->ack_seq - msk->bytes_received + msk->tfo_skb_len;
+}
+
 static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ed3a48cf9c97..6b7a45710758 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -498,6 +498,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 
 	if (!sock_owned_by_user(sk)) {
+		/* User space could have already read partially the TFO skb */
+		msk->copied_seq += subflow->iasn;
 		__mptcp_sync_rcv_sequence(sk);
 	} else {
 		/* Ensure ack_seq is visible before setting the flag */
@@ -520,6 +522,13 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
 		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 		subflow_set_remote_key(msk, subflow, mp_opt);
+	} else {
+		/* Fallback: initialize sequence space to 0 (no remote key) */
+		subflow->map_seq = 0;
+		/* ensure mptcp_subflow_get_map_offset() returns 0 */
+		subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
+					   subflow->ssn_offset;
+		WRITE_ONCE(msk->ack_seq, 0);
 	}
 
 	if (!sock_owned_by_user(sk)) {
-- 
2.53.0


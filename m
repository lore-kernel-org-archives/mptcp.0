Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065054;
	b=Zscw9Ct4tFHBywbQIRV+TL6ZwwFLzttqOkeXO/Hd+Ud63OtRepciILMjEo6tzLu+5s+W
	 nkVOzdKedsaCVGslRgtO4f2VdZNLi8I+by0ZdGeopnEhoAxPBlEMSoroQuTdXvv4q/AWZ
	 VHxjutmsetSinvkON125mcUSBssyoDJIbC8FYVt8fLWsXKd7Ehz3ZZSz/iBx+CKbpIFKw
	 FAd4NqWepoq3E4Nqwvpm9Cb6Kr+lvCUyytIjcSb+LZx4i02ZMSt/4JadsULpeI5zZaEFC
	 wyE9oD1d5v8J1uvq3tla7E1u4gxID7ga6ITdmtVtO+FO41WfHEqfgWOhuZfo368kJrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065054;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fH0H5mcSx+RjKaB/EEWwO8r4sbx84XcU0q6RrtPbk0s=;
	b=W9E9H8AU9D2PAjUQPJHjJ+x9YjF51Xvmv44qOOzR7wlJdwHACLDTRkcUBFlVGZJsrMvw
	 WfHg46y/1nEro4aczFT0zDDuATfrNGq0uEHOrrB5Fe/5GylOrLY8g8/HcHS053XpEve1z
	 OgBNZiWShR+rpzGvIAW1heF5ENtJdWEM4XFNwUbFvmKSvpK08TUOBc9Uq7jDiEa+DnGxs
	 KojTRUa4HTDxN7z6bVg6iFIm8ES9SMopm0G2oNbXTJvqi1tks7AijJJ7MjqM5yXZfFi6a
	 GGWPZcky3MvYCzq695mqNCUGb2UfHaG9izY7rD96YYEgitFgfwP6cea/sJqqRSUxzeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qs2gcbdu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364F606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qs2gcbdu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB5F1F000C6
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065053;
	bh=fH0H5mcSx+RjKaB/EEWwO8r4sbx84XcU0q6RrtPbk0s=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Qs2gcbduyxcAIXQDl/7c6BWUs9XCbbLtjlf/nhlqHn20A0jv0ntt0N9dAJXWwO2jK
	 oFNskeus+IwDlI8whsAdvwidm7HN3ZMjqybpcruYncOcttR0I87Q7o9Nd93IxuDUll
	 dHvXjw5WeH/qLFjp4QbPMDZz6CMSHm5ENMysMoEmTUYIAwJcZ/eIwgQ7li88JHROu4
	 0H7p+CkYqgjmrGah8V0nJNJ6bpm3xbr7qTCjkF+gLp6uV4PUrgiA1koix4gEthpG9n
	 jlt3rttMLjpqMNN77i/icjMyucFagfRBLq1MCrSL7hp8Pqe5B5ppR9epl4edMZG0iZ
	 kuYkroW5xVnDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v29 6/8] mptcp: remove CB offset field
Date: Thu, 19 Nov 2026 13:10:32 +0800
Message-ID: <fbc3299b9062220507c5e1d50c13eae8c513b6f4.1795063943.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795063943.git.tanggeliang@kylinos.cn>
References: <cover.1795063943.git.tanggeliang@kylinos.cn>
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

The newly introduced 'copied_seq' field is always accessed under the msk
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
affects the 'copied_seq' initial update: be sure to extend the sign
correctly of such mapping initialization time.

The end_seq field changes meaning: it now stores map_seq + copy_len
(where copy_len = skb->len - offset) rather than the end DSN. Helper
functions mptcp_dsn() and mptcp_end_dsn() are updated to compute the
actual DSN and end DSN from map_seq, end_seq and skb length.

Overall this simplifies a bit the __mptcp_recvmsg_mskq() and the
__mptcp_move_skb() code and will also make possible the next patch.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |   5 ++-
 net/mptcp/protocol.c | 102 ++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |  10 +++--
 net/mptcp/subflow.c  |   6 ++-
 4 files changed, 76 insertions(+), 47 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index e18b31028e7e..8dcfcff9087f 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -46,9 +46,9 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* Only the sequence delta is relevant */
-	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
+	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
-	MPTCP_SKB_CB(skb)->offset = 0;
+	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	mptcp_data_lock(sk);
@@ -56,6 +56,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	msk = mptcp_sk(sk);
 	msk->rcvd_dummy_seq = true;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a5d1f97c087..1ed232a4e8b4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -168,7 +168,8 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||
-	    MPTCP_SKB_CB(from)->offset ||
+	    (MPTCP_SKB_CB(from)->flags | MPTCP_SKB_CB(to)->flags) &
+	     MPTCP_SKB_CB_F_OFFSET ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
@@ -424,9 +425,10 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
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
@@ -449,9 +451,8 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 	if (!skb)
 		return;
 
-	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len +
-				     MPTCP_SKB_CB(skb)->offset;
-	MPTCP_SKB_CB(skb)->end_seq = msk->tfo_iasn;
+	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
@@ -495,10 +496,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	/* Partial packet */
 	if (after64(mptcp_end_dsn(skb), msk->ack_seq)) {
 		copy_len = mptcp_end_dsn(skb) - msk->ack_seq;
-		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
-					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
 
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
@@ -2208,33 +2202,39 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
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
-		u32 data_len = skb->len - offset;
+		u32 data_len;
+		u64 offset;
 		u32 count;
 		int err;
 
-		if (flags & MSG_PEEK) {
-			/* skip already peeked skbs */
-			if (total_data_len + data_len <= copied_total) {
-				total_data_len += data_len;
+		if (unlikely(before64(*seq, MPTCP_SKB_CB(skb)->map_seq))) {
+			*seq = mptcp_end_dsn(skb);
+			msk->bytes_consumed += skb->len;
+			if (!(flags & MSG_PEEK))
+				mptcp_eat_recv_skb(sk, skb);
+			else
 				*last = skb;
-				continue;
-			}
+			continue;
+		}
 
-			/* skip the already peeked data in the current skb */
-			delta = copied_total - total_data_len;
-			offset += delta;
-			data_len -= delta;
+		offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
+		data_len = skb->len - offset;
+
+		if (offset >= skb->len) {
+			if (!(flags & MSG_PEEK))
+				mptcp_eat_recv_skb(sk, skb);
+			else
+				*last = skb;
+			continue;
 		}
 
 		count = min_t(size_t, len - copied, data_len);
@@ -2254,14 +2254,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2400,8 +2398,10 @@ static bool mptcp_move_skbs(struct sock *sk)
 
 	mptcp_data_lock(sk);
 	while (1) {
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
 			__mptcp_sync_rcv_sequence(sk);
+		}
 
 		if (!mptcp_can_spool_backlog(sk, &skbs))
 			break;
@@ -2440,6 +2440,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
+	u64 peek_seq, *seq;
 	int target;
 	long timeo;
 
@@ -2458,6 +2459,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	len = min_t(size_t, len, INT_MAX);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+	seq = &msk->copied_seq;
+	if (flags & MSG_PEEK) {
+		peek_seq = msk->copied_seq;
+		seq = &peek_seq;
+	}
 
 	if (unlikely(msk->recvmsg_inq))
 		cmsg_flags = MPTCP_CMSG_INQ;
@@ -2467,7 +2473,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags,
+						  seq, &tss, &cmsg_flags,
 						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
@@ -2477,8 +2483,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
+			if (flags & MSG_PEEK)
+				peek_seq = msk->copied_seq + copied;
 			continue;
+		}
 
 		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -2521,6 +2530,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			copied = copied ? : err;
 			goto out_err;
 		}
+
+		/* Recompute peek offset after eventual seq resync. */
+		if (flags & MSG_PEEK)
+			peek_seq = msk->copied_seq + copied;
 	}
 
 	mptcp_cleanup_rbuf(msk, copied);
@@ -3699,6 +3712,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 	msk->bytes_consumed = 0;
+	msk->copied_seq = 0;
 	msk->bytes_acked = 0;
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
@@ -3909,8 +3923,10 @@ static void mptcp_release_cb(struct sock *sk)
 		struct list_head join_list, skbs;
 		bool spool_bl;
 
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
 			__mptcp_sync_rcv_sequence(sk);
+		}
 
 		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
 		if (!flags && !spool_bl)
@@ -4631,7 +4647,15 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		if (unlikely(before64(msk->copied_seq,
+				      MPTCP_SKB_CB(skb)->map_seq))) {
+			msk->copied_seq = mptcp_end_dsn(skb);
+			msk->bytes_consumed += skb->len;
+			mptcp_eat_recv_skb(sk, skb);
+			continue;
+		}
+
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4673,11 +4697,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index 9f0cfda70b23..147dc209725a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -128,10 +128,12 @@
 #define MPTCP_SYNC_SNDBUF	7
 #define MPTCP_SYNC_SEQ		8
 
+#define MPTCP_SKB_CB_F_OFFSET	(TCPHDR_FLAGS_MASK + 1)
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
@@ -1387,12 +1390,13 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 
 static inline u64 mptcp_end_dsn(const struct sk_buff *skb)
 {
-	return MPTCP_SKB_CB(skb)->end_seq;
+	return MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
 static inline u64 mptcp_dsn(const struct sk_buff *skb)
 {
-	return MPTCP_SKB_CB(skb)->map_seq;
+	return MPTCP_SKB_CB(skb)->map_seq + skb->len -
+	       (MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq);
 }
 
 #ifdef CONFIG_SYN_COOKIES
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8f64a9aef2c1..a7e8d03452ec 100644
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
 		__set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
+	}
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.55.0


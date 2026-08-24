Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726C34AB14
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538068; cv=none; b=dNmuy44WtQBh4Ii6zEE+mgRRqsSHQMujATj8bbUYMmHTOi5WQPdVj+3W19LKVwbYBi+ZCcJCabk0agVm3W+fDXaX9kYAGt8HMfOlzloCVC3qjp8pM/GM4KBsbWA8FPK0BUrTuB81YWp+KuzE2qAG7sing7FGgSXgTqT3/MITeSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538068; c=relaxed/simple;
	bh=cOhhGdH2cPjNpF3dgHVIXXq00dkV64F2yOKXwo8Qn/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqoLLzpaQMclsBT07plErZ6ENIBxY9gjtO3gevmg6lDLNn/Ng/u71PjRvvvXiSnekytdSuCniFowa9ykY3a6WBq3hx/BQtFfYgcWwlTpTg3fDZ2yEDMRwmqX7qv2CdvvyHd446e0wmODagtYuui4PzLgDvxjmL8Bpl9AhBsYVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2iJvahB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2iJvahB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21B11F00A3A;
	Mon, 24 Aug 2026 02:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787538066;
	bh=Xp8MA/wCNqzc7xDGPPnRIyub1QeyC9w0eQq4u2Iw6d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2iJvahBTcjO3SLGsFapcZtbm4uXgcGcjx35nTHMb24vUl4Zo5g7Bcqbq0UxtOU0D
	 puh4q98hNzDEukzt5XsnzM4jH3b/fmdD4PR9nvy1XsvHjPkMr6R8WK6SGLperviE6k
	 KGitFnq3RhamH7tFxP5qNIYPTPyJZ/7E9fpcMlDG/t56JXwGb31epnvl2DnGRp4n4p
	 QkDYQHBGu5u/M6odLa88/44ld7AEV+aU7IcZ9KKms1wZq10vW0aAtz5nV24KdBHFDV
	 aS8fzaw5CkcM8lOPRqG66fT6HvzqGWMLMmnN6Se45hcRRSRox8LAW9fAhowxkkWulF
	 CRkYgcobqtZBg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v7 4/8] mptcp: remove CB offset field
Date: Mon, 24 Aug 2026 10:20:39 +0800
Message-ID: <5237bcbcc25cd63b713a6cf254ec64550b8476e2.1787537436.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787537436.git.tanggeliang@kylinos.cn>
References: <cover.1787537436.git.tanggeliang@kylinos.cn>
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
 net/mptcp/fastopen.c |  15 ++++--
 net/mptcp/protocol.c | 114 ++++++++++++++++++++-----------------------
 net/mptcp/protocol.h |   9 +++-
 net/mptcp/subflow.c  |   9 ++++
 4 files changed, 81 insertions(+), 66 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index d6895c2200cc..421a50a85547 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -9,6 +9,7 @@
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req)
 {
+	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
@@ -44,20 +45,24 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
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
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
-	mptcp_sk(sk)->rcvd_dummy_seq = true;
+	msk = mptcp_sk(sk);
+	msk->rcvd_dummy_seq = true;
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
+	msk->tfo_skb_len = skb->len;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
-	mptcp_sk(sk)->bytes_received += skb->len;
+	msk->bytes_received += skb->len;
 
 	sk->sk_data_ready(sk);
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c23046b1e51b..a9faae858a21 100644
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
@@ -440,8 +438,6 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
-	u64 ack_seq;
-	u32 offset;
 
 	if (likely(!msk->rcvd_dummy_seq))
 		return;
@@ -452,10 +448,8 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 	if (!skb)
 		return;
 
-	ack_seq = atomic64_read(&msk->ack_seq);
-	offset = MPTCP_SKB_CB(skb)->offset;
-	MPTCP_SKB_CB(skb)->map_seq = ack_seq - skb->len + offset;
-	MPTCP_SKB_CB(skb)->end_seq = ack_seq;
+	MPTCP_SKB_CB(skb)->map_seq = mptcp_iasn(msk) - skb->len;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
@@ -467,6 +461,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+		/* Ensure we see the updated ack_seq after seeing the flag */
+		smp_rmb();
+		msk->copied_seq += mptcp_iasn(msk);
+	}
+
 	/* Be sure to sync the eventual fastopen dummy mapping before any other
 	 * skb lands into the msk.
 	 */
@@ -500,10 +500,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	/* Partial packet */
 	if (after64(MPTCP_SKB_CB(skb)->end_seq, ack_seq)) {
 		copy_len = MPTCP_SKB_CB(skb)->end_seq - ack_seq;
-		MPTCP_SKB_CB(skb)->offset += ack_seq -
-					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += ack_seq -
-					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
 
@@ -861,7 +857,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			mptcp_init_skb(ssk, skb, offset, len);
+			mptcp_init_skb(ssk, skb, offset);
 
 			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
@@ -928,8 +924,6 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, ack_seq,
 				 delta);
-			MPTCP_SKB_CB(skb)->offset += delta;
-			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
 		msk->bytes_received += end_seq - ack_seq;
@@ -2203,33 +2197,24 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -2248,14 +2233,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2408,26 +2391,23 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+static unsigned int mptcp_inq_hint(struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
+	u64 hint_val;
 
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = atomic64_read(&msk->ack_seq) -
-			       MPTCP_SKB_CB(skb)->map_seq;
-
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
-
-		return (unsigned int)hint_val;
-	}
+	/* Avoid races vs ack_seq updates. */
+	mptcp_data_lock(sk);
+	hint_val = atomic64_read(&msk->ack_seq) - msk->copied_seq;
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
@@ -2436,6 +2416,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
+	u64 peek_seq, *seq;
 	int target;
 	long timeo;
 
@@ -2454,6 +2435,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	len = min_t(size_t, len, INT_MAX);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+	seq = &msk->copied_seq;
+	if (flags & MSG_PEEK) {
+		peek_seq = msk->copied_seq;
+		seq = &peek_seq;
+	}
 
 	if (unlikely(msk->recvmsg_inq))
 		cmsg_flags = MPTCP_CMSG_INQ;
@@ -2463,7 +2449,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags,
+						  seq, &tss, &cmsg_flags,
 						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
@@ -2473,8 +2459,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
+			if (flags & MSG_PEEK)
+				peek_seq = msk->copied_seq + copied;
 			continue;
+		}
 
 		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -2518,6 +2507,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			err = copied ? : err;
 			goto out_err;
 		}
+
+		/* Recompute peek offset after eventual seq resync. */
+		if (flags & MSG_PEEK)
+			peek_seq = msk->copied_seq + copied;
 	}
 
 	mptcp_cleanup_rbuf(msk, copied);
@@ -3695,11 +3688,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
+	msk->tfo_skb_len = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
 	atomic64_set(&msk->ack_seq, 0);
 	atomic64_set(&msk->rcv_wnd_sent, 0);
+	msk->copied_seq = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
@@ -3929,6 +3924,7 @@ static void mptcp_release_cb(struct sock *sk)
 			 * the flag
 			 */
 			smp_rmb();
+			msk->copied_seq += mptcp_iasn(msk);
 			__mptcp_sync_rcv_sequence(sk);
 		}
 	}
@@ -4593,7 +4589,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4635,11 +4631,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index 18ae5d78c3f1..18c59cedfe1b 100644
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
 	atomic64_t	ack_seq;
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
@@ -865,6 +866,12 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
+static inline u64 mptcp_iasn(const struct mptcp_sock *msk)
+{
+	return atomic64_read(&msk->ack_seq) - msk->bytes_received +
+	       msk->tfo_skb_len;
+}
+
 static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e3f77257f030..7fc526d0deae 100644
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
+		atomic64_set(&msk->ack_seq, 0);
 	}
 
 	if (!sock_owned_by_user(sk)) {
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDC43F8B1
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828271; cv=none; b=B6zfvVWxhX93Qb0H9llNdJ4L8plRyJC8cQaz2UVbMtfPnXUpsuHQQOYbR38DF3D7YZRRdCYgifalNtSWV6PFf00u26InfHJgXlwzYU2t+EZm4+P8Mhv5smeTLUSt5lYUT3iaPNDAIv4E6/xUMVkTJFcvkSl7J15yxhTEkN6uJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828271; c=relaxed/simple;
	bh=S4CvDOwW6qufRcZhm6R6YIINhppRUkT6TYEBCiBphGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toGgVmPJpFgClyna/dGo4P1EKPuTolh6IETOqMax0WDrnBvuG1CHJDPYxnLQo7SprF9XbQWyV+Qtwbt6yUCaclBUEeQCD3E2BBISVhC2e+Ot4XMAk5j6zPWM86Fal4++4ifma8aaLwRu4j/dGQLKb2r8NYgByzyaS//r1EPu/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS3vTFZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS3vTFZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844A31F00A3A;
	Thu, 27 Aug 2026 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787828268;
	bh=OoDMCyfCiJm6MtDYSaoELBRrPu/bkdYymZb3xqUa/KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bS3vTFZtzu74btjkYEolQbtiR7X+ycZGyUqUQ+Sb5q/ckoH+FttEiTIBoM45MYenD
	 vLHELJehIk12RMmnKPwG0DNnh3WaONciJL6tgBJGYkwYSBEsMIjP8F8rlEeY4G/7p/
	 eq07grW22iyjJcdQw/6jctdl2Vfwl9ZO6rmQH1akpMihOUJIrFzLMKOvdSbKheElMG
	 zZ8B6daCIteQ0MNvijnI4f4DrgFvslilqnoEtgo1ei4XFg2LGWQUOiyhscJnicNdP/
	 b4gyKJo6fXi18mh2LNYtDcRyXzmtN8T122fwpKoR/tkNpwaq43AobsZyO38UTgz1Kh
	 cl20bUBUjcyYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 01/11] mptcp: use atomic64_t for locklessly accessed u64 fields
Date: Thu, 27 Aug 2026 18:57:25 +0800
Message-ID: <dc178617946d445a9ec95a3f0a92d1a66a78d9f0.1787827525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Several u64 fields in struct mptcp_sock are accessed locklessly and
could suffer from torn reads on 32-bit architectures:

- ack_seq: updated in process context without mptcp_data_lock() and
  read concurrently in softirq via mptcp_write_options()
- write_seq, snd_nxt: sequence numbers accessed from multiple contexts
- bytes_received, bytes_consumed: byte counters for flow control
- snd_una, wnd_end: send window tracking fields

On 32-bit architectures, 64-bit READ_ONCE/WRITE_ONCE compiles to two
32-bit accesses, so a torn read could produce corrupted values.

Convert these fields from u64 to atomic64_t to guarantee tear-free
accesses on all architectures. Also cache atomic64_read() in local
variables where the same field is read multiple times within a function
to avoid inconsistent repeated reads (e.g., in __mptcp_move_skb(),
__mptcp_ofo_queue(), __mptcp_retrans(), __mptcp_clean_una(),
mptcp_check_send_data_fin(), mptcp_update_post_push(), and
mptcp_sk_clone_init()).

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/trace/events/mptcp.h |   7 +-
 net/mptcp/fastopen.c         |   4 +-
 net/mptcp/options.c          |  26 +++---
 net/mptcp/protocol.c         | 151 ++++++++++++++++++++---------------
 net/mptcp/protocol.h         |  24 +++---
 net/mptcp/sockopt.c          |   8 +-
 net/mptcp/subflow.c          |  18 +++--
 7 files changed, 134 insertions(+), 104 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 22882bd03459..b3660cc94601 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -215,7 +215,9 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		struct inet_sock *inet = inet_sk(sk);
 		bool ofo_empty;
 		__be32 *p32;
+		u64 ack_seq;
 
+		ack_seq = atomic64_read(&msk->ack_seq);
 		__entry->time = time;
 		__entry->rtt_us = mptcp_rtt_us_est(msk) >> 3;
 		__entry->copied = msk->rcvq_space.copied;
@@ -224,11 +226,10 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		ofo_empty = RB_EMPTY_ROOT(&msk->out_of_order_queue);
 		__entry->ooo_space = ofo_empty ? 0 :
 				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
-				     msk->ack_seq;
+				     ack_seq;
 
 		__entry->rcvbuf = sk->sk_rcvbuf;
-		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -
-				   msk->ack_seq;
+		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) - ack_seq;
 		__entry->scaling_ratio = msk->scaling_ratio;
 		__entry->sport = ntohs(inet->inet_sport);
 		__entry->dport = ntohs(inet->inet_dport);
diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index f717750906ff..0012690a2202 100644
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
@@ -54,10 +55,11 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
+	msk = mptcp_sk(sk);
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
-	mptcp_sk(sk)->bytes_received += skb->len;
+	atomic64_add(skb->len, &msk->bytes_received);
 
 	sk->sk_data_ready(sk);
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f87707110c75..b33bf445c0ba 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -600,7 +600,8 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 	/* The write_seq value has already been incremented, so the actual
 	 * sequence number for the DATA_FIN is one less.
 	 */
-	u64 data_fin_tx_seq = READ_ONCE(mptcp_sk(subflow->conn)->write_seq) - 1;
+	u64 data_fin_tx_seq =
+		atomic64_read(&mptcp_sk(subflow->conn)->write_seq) - 1;
 
 	if (!ext->use_map || !skb->len) {
 		/* RFC6824 requires a DSS mapping with specific values
@@ -1086,8 +1087,8 @@ u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
 
 static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd_una)
 {
-	msk->bytes_acked += new_snd_una - msk->snd_una;
-	WRITE_ONCE(msk->snd_una, new_snd_una);
+	msk->bytes_acked += new_snd_una - atomic64_read(&msk->snd_una);
+	atomic64_set(&msk->snd_una, new_snd_una);
 }
 
 static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
@@ -1120,7 +1121,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
 {
-	u64 new_wnd_end, new_snd_una, snd_nxt = READ_ONCE(msk->snd_nxt);
+	u64 new_wnd_end, new_snd_una, snd_nxt = atomic64_read(&msk->snd_nxt);
 	struct sock *sk = (struct sock *)msk;
 	u64 old_snd_una;
 
@@ -1130,7 +1131,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	 * wrongly expanding to a future ack sequence number, which is way
 	 * more dangerous than missing an ack
 	 */
-	old_snd_una = msk->snd_una;
+	old_snd_una = atomic64_read(&msk->snd_una);
 	new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
 
 	/* ACK for data not even sent yet? Ignore.*/
@@ -1139,11 +1140,11 @@ static void ack_update_msk(struct mptcp_sock *msk,
 
 	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
 
-	if (after64(new_wnd_end, msk->wnd_end))
-		WRITE_ONCE(msk->wnd_end, new_wnd_end);
+	if (after64(new_wnd_end, atomic64_read(&msk->wnd_end)))
+		atomic64_set(&msk->wnd_end, new_wnd_end);
 
 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
-	if (after64(msk->wnd_end, snd_nxt))
+	if (after64(atomic64_read(&msk->wnd_end), snd_nxt))
 		__mptcp_check_push(sk, ssk);
 
 	if (after64(new_snd_una, old_snd_una)) {
@@ -1155,7 +1156,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 
 	trace_ack_update_msk(mp_opt->data_ack,
 			     old_snd_una, new_snd_una,
-			     new_wnd_end, READ_ONCE(msk->wnd_end));
+			     new_wnd_end, atomic64_read(&msk->wnd_end));
 }
 
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit)
@@ -1169,7 +1170,8 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 		return false;
 
 	WRITE_ONCE(msk->rcv_data_fin_seq,
-		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
+		   mptcp_expand_seq(atomic64_read(&msk->ack_seq),
+				    data_fin_seq, use_64bit));
 	WRITE_ONCE(msk->rcv_data_fin, 1);
 
 	return true;
@@ -1242,7 +1244,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		/* on fallback we just need to ignore the msk-level snd_una, as
 		 * this is really plain TCP
 		 */
-		__mptcp_snd_una_update(msk, READ_ONCE(msk->snd_nxt));
+		__mptcp_snd_una_update(msk, atomic64_read(&msk->snd_nxt));
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
@@ -1539,7 +1541,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			 */
 			subflow = mptcp_subflow_ctx(ssk);
 			msk = mptcp_sk(subflow->conn);
-			ack_seq = READ_ONCE(msk->ack_seq);
+			ack_seq = atomic64_read(&msk->ack_seq);
 			if (mpext->ack64) {
 				put_unaligned_be64(ack_seq, ptr);
 				ptr += 2;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f22d64ab1c53..26b49480941c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -59,7 +59,7 @@ static struct net_device *mptcp_napi_dev;
 /* Returns end sequence number of the receiver's advertised window */
 u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->wnd_end);
+	return atomic64_read(&msk->wnd_end);
 }
 
 static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
@@ -451,10 +451,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
+	u64 ack_seq;
 
 	mptcp_borrow_fwdmem(sk, skb);
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	ack_seq = atomic64_read(&msk->ack_seq);
+	if (MPTCP_SKB_CB(skb)->map_seq == ack_seq) {
 		/* in sequence */
 insert:
 		if (!mptcp_try_rmem_schedule(sk, skb)) {
@@ -463,8 +465,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 			return false;
 		}
 
-		msk->bytes_received += copy_len;
-		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+		atomic64_add(copy_len, &msk->bytes_received);
+		atomic64_add(copy_len, &msk->ack_seq);
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
 			return true;
@@ -472,17 +474,17 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
-	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
+	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, ack_seq)) {
 		mptcp_data_queue_ofo(msk, skb);
 		return false;
 	}
 
 	/* Partial packet */
-	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
-		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
+	if (after64(MPTCP_SKB_CB(skb)->end_seq, ack_seq)) {
+		copy_len = MPTCP_SKB_CB(skb)->end_seq - ack_seq;
+		MPTCP_SKB_CB(skb)->offset += ack_seq -
 					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+		MPTCP_SKB_CB(skb)->map_seq += ack_seq -
 					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
@@ -533,7 +535,7 @@ static bool mptcp_pending_data_fin_ack(struct sock *sk)
 
 	return ((1 << sk->sk_state) &
 		(TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
-	       msk->write_seq == READ_ONCE(msk->snd_una);
+	       atomic64_read(&msk->write_seq) == atomic64_read(&msk->snd_una);
 }
 
 static void mptcp_check_data_fin_ack(struct sock *sk)
@@ -569,7 +571,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
 		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 
-		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
+		if (atomic64_read(&msk->ack_seq) == rcv_data_fin_seq) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
 
@@ -710,7 +712,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 	 */
 
 	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
-		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
+		atomic64_inc(&msk->ack_seq);
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
 		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
@@ -879,22 +881,22 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb, *tail;
+	u64 end_seq, ack_seq;
 	bool moved = false;
 	struct rb_node *p;
-	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
+		ack_seq = atomic64_read(&msk->ack_seq);
 		skb = rb_to_skb(p);
-		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
+		if (after64(MPTCP_SKB_CB(skb)->map_seq, ack_seq))
 			break;
 
 		p = rb_next(p);
 		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
 
-		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq,
-				      msk->ack_seq))) {
+		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq, ack_seq))) {
 			mptcp_drop(sk, skb);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 			continue;
@@ -903,18 +905,18 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		end_seq = MPTCP_SKB_CB(skb)->end_seq;
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (!tail || !mptcp_ooo_try_coalesce(msk, tail, skb)) {
-			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+			int delta = ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
 			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
-				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
+				 MPTCP_SKB_CB(skb)->map_seq, ack_seq,
 				 delta);
 			MPTCP_SKB_CB(skb)->offset += delta;
 			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
-		msk->bytes_received += end_seq - msk->ack_seq;
-		WRITE_ONCE(msk->ack_seq, end_seq);
+		atomic64_add(end_seq - ack_seq, &msk->bytes_received);
+		atomic64_set(&msk->ack_seq, end_seq);
 		moved = true;
 	}
 	return moved;
@@ -1072,7 +1074,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
-	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
+	mptcp_subflow_ctx(ssk)->map_seq = atomic64_read(&msk->ack_seq);
 	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
@@ -1178,7 +1180,7 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
 		pfrag->page == df->page &&
 		pfrag->size - pfrag->offset > 0 &&
 		pfrag->offset == (df->offset + df->data_len) &&
-		df->data_seq + df->data_len == msk->write_seq;
+		df->data_seq + df->data_len == atomic64_read(&msk->write_seq);
 }
 
 static void dfrag_uncharge(struct sock *sk, int len)
@@ -1201,9 +1203,11 @@ static void __mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
-	u64 snd_una;
+	u64 snd_una, snd_nxt, write_seq;
 
-	snd_una = msk->snd_una;
+	snd_una = atomic64_read(&msk->snd_una);
+	snd_nxt = atomic64_read(&msk->snd_nxt);
+	write_seq = atomic64_read(&msk->write_seq);
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
 			break;
@@ -1241,11 +1245,11 @@ static void __mptcp_clean_una(struct sock *sk)
 	}
 
 	/* all retransmitted data acked, recovery completed */
-	if (unlikely(msk->recovery) && after64(msk->snd_una, msk->recovery_snd_nxt))
+	if (unlikely(msk->recovery) && after64(snd_una, msk->recovery_snd_nxt))
 		msk->recovery = false;
 
 out:
-	if (snd_una == msk->snd_nxt && snd_una == msk->write_seq) {
+	if (snd_una == snd_nxt && snd_una == write_seq) {
 		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
 			mptcp_stop_rtx_timer(sk);
 	} else {
@@ -1305,7 +1309,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 
 	dfrag = (struct mptcp_data_frag *)(page_to_virt(pfrag->page) + offset);
 	dfrag->data_len = 0;
-	dfrag->data_seq = msk->write_seq;
+	dfrag->data_seq = atomic64_read(&msk->write_seq);
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
 	dfrag->already_sent = 0;
@@ -1499,13 +1503,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	/* Zero window and all data acked? Probe. */
 	copy = mptcp_check_allowed_size(msk, ssk, data_seq, copy);
 	if (copy == 0) {
-		u64 snd_una = READ_ONCE(msk->snd_una);
+		u64 snd_una = atomic64_read(&msk->snd_una);
 
 		/* No need for zero probe if there are any data pending
 		 * either at the msk or ssk level; skb is the current write
 		 * queue tail and can be empty at this point.
 		 */
-		if (snd_una != msk->snd_nxt || skb->len ||
+		if (snd_una != atomic64_read(&msk->snd_nxt) || skb->len ||
 		    skb != tcp_send_head(ssk)) {
 			tcp_remove_empty_skb(ssk);
 			return 0;
@@ -1686,7 +1690,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
-	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	burst = min(MPTCP_SEND_BURST_SIZE,
+		    mptcp_wnd_end(msk) - atomic64_read(&msk->snd_nxt));
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	if (!burst)
 		return ssk;
@@ -1709,6 +1714,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
 {
+	u64 snd_nxt = atomic64_read(&msk->snd_nxt);
 	u64 snd_nxt_new = dfrag->data_seq;
 
 	dfrag->already_sent += sent;
@@ -1726,9 +1732,9 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 	 * that has been handed to the subflow for transmission
 	 * and skip update in case it was old dfrag.
 	 */
-	if (likely(after64(snd_nxt_new, msk->snd_nxt))) {
-		msk->bytes_sent += snd_nxt_new - msk->snd_nxt;
-		WRITE_ONCE(msk->snd_nxt, snd_nxt_new);
+	if (likely(after64(snd_nxt_new, snd_nxt))) {
+		msk->bytes_sent += snd_nxt_new - snd_nxt;
+		atomic64_set(&msk->snd_nxt, snd_nxt_new);
 	}
 }
 
@@ -1915,7 +1921,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			mptcp_reset_rtx_timer(sk);
 
 		if (msk->snd_data_fin_enable &&
-		    msk->snd_nxt + 1 == msk->write_seq)
+		    atomic64_read(&msk->snd_nxt) + 1 ==
+		    atomic64_read(&msk->write_seq))
 			mptcp_schedule_work(sk);
 	}
 }
@@ -2009,7 +2016,8 @@ static u32 mptcp_send_limit(const struct sock *sk)
 	if (limit == UINT_MAX)
 		return UINT_MAX;
 
-	not_sent = msk->write_seq - msk->snd_nxt;
+	not_sent = atomic64_read(&msk->write_seq) -
+		   atomic64_read(&msk->snd_nxt);
 	if (not_sent >= limit)
 		return 0;
 
@@ -2121,7 +2129,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		dfrag->data_len += psize;
 		frag_truesize += psize;
 		pfrag->offset += frag_truesize;
-		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
+		atomic64_add(psize, &msk->write_seq);
 
 		/* charge data on mptcp pending queue to the msk socket
 		 * Note: we charge such data both to sk and ssk
@@ -2231,7 +2239,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 		copied += count;
 
 		if (!(flags & MSG_PEEK)) {
-			msk->bytes_consumed += count;
+			atomic64_add(count, &msk->bytes_consumed);
 			if (count < data_len) {
 				MPTCP_SKB_CB(skb)->offset += count;
 				MPTCP_SKB_CB(skb)->map_seq += count;
@@ -2393,10 +2401,12 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
+	u64 hint_val, ack_seq;
 
 	skb = skb_peek(&sk->sk_receive_queue);
 	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+		ack_seq = atomic64_read(&msk->ack_seq);
+		hint_val = ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 		if (hint_val >= INT_MAX)
 			return INT_MAX;
@@ -2609,7 +2619,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 		return false;
 	}
 
-	msk->recovery_snd_nxt = msk->snd_nxt;
+	msk->recovery_snd_nxt = atomic64_read(&msk->snd_nxt);
 	msk->recovery = true;
 	mptcp_data_unlock(sk);
 
@@ -2969,7 +2979,7 @@ static void __mptcp_retrans(struct sock *sk)
 	/* Get an updated and consistent rtx queue status. */
 	mptcp_data_lock(sk);
 	__mptcp_clean_una_wakeup(sk);
-	retrans_seq = msk->snd_una;
+	retrans_seq = atomic64_read(&msk->snd_una);
 	dfrag = mptcp_rtx_head(sk);
 	need_retrans = !!dfrag;
 	mptcp_data_unlock(sk);
@@ -2999,8 +3009,8 @@ static void __mptcp_retrans(struct sock *sk)
 
 		/* With csum enabled, retransmission can send new data. */
 		sent_seq = dfrag->already_sent + dfrag->data_seq;
-		if (after64(sent_seq, msk->snd_nxt))
-			WRITE_ONCE(msk->snd_nxt, sent_seq);
+		if (after64(sent_seq, atomic64_read(&msk->snd_nxt)))
+			atomic64_set(&msk->snd_nxt, sent_seq);
 
 		/* Attempt the next fragment only if the current one is
 		 * completely retransmitted.
@@ -3017,15 +3027,16 @@ static void __mptcp_retrans(struct sock *sk)
 		 * across loop iterations, if so start again from RTX head.
 		 */
 		mptcp_data_lock(sk);
-		already_acked = !before64(msk->snd_una, dfrag->data_seq +
+		already_acked = !before64(atomic64_read(&msk->snd_una),
+					  dfrag->data_seq +
 					  dfrag->already_sent);
 		if (already_acked) {
 			__mptcp_clean_una_wakeup(sk);
-			retrans_seq = msk->snd_una;
+			retrans_seq = atomic64_read(&msk->snd_una);
 			dfrag = mptcp_rtx_head(sk);
 			need_retrans = !!dfrag;
-		} else if (after64(msk->snd_una, retrans_seq)) {
-			retrans_seq = msk->snd_una;
+		} else if (after64(atomic64_read(&msk->snd_una), retrans_seq)) {
+			retrans_seq = atomic64_read(&msk->snd_una);
 		}
 		mptcp_data_unlock(sk);
 	}
@@ -3314,6 +3325,8 @@ void mptcp_cancel_work(struct sock *sk)
 
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
 	lock_sock(ssk);
 
 	switch (ssk->sk_state) {
@@ -3325,7 +3338,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
 		break;
 	default:
-		if (__mptcp_check_fallback(mptcp_sk(sk))) {
+		if (__mptcp_check_fallback(msk)) {
 			pr_debug("Fallback\n");
 			ssk->sk_shutdown |= how;
 			tcp_shutdown(ssk, how);
@@ -3333,7 +3346,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			/* simulate the data_fin ack reception to let the state
 			 * machine move forward
 			 */
-			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
+			atomic64_set(&msk->snd_una,
+				     atomic64_read(&msk->snd_nxt));
 			mptcp_schedule_work(sk);
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p\n", ssk);
@@ -3404,19 +3418,23 @@ static void mptcp_check_send_data_fin(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 snd_nxt, write_seq;
+
+	snd_nxt = atomic64_read(&msk->snd_nxt);
+	write_seq = atomic64_read(&msk->write_seq);
 
 	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu\n",
 		 msk, msk->snd_data_fin_enable, !!mptcp_send_head(sk),
-		 msk->snd_nxt, msk->write_seq);
+		 snd_nxt, write_seq);
 
 	/* we still need to enqueue subflows or not really shutting down,
 	 * skip this
 	 */
-	if (!msk->snd_data_fin_enable || msk->snd_nxt + 1 != msk->write_seq ||
+	if (!msk->snd_data_fin_enable || snd_nxt + 1 != write_seq ||
 	    mptcp_send_head(sk))
 		return;
 
-	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
+	atomic64_set(&msk->snd_nxt, write_seq);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
@@ -3434,7 +3452,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 		 !!mptcp_send_head(sk));
 
 	/* will be ignored by fallback sockets */
-	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
+	atomic64_add(1, &msk->write_seq);
 	WRITE_ONCE(msk->snd_data_fin_enable, 1);
 
 	mptcp_check_send_data_fin(sk);
@@ -3668,9 +3686,9 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
-	msk->bytes_consumed = 0;
+	atomic64_set(&msk->bytes_consumed, 0);
 	msk->bytes_acked = 0;
-	msk->bytes_received = 0;
+	atomic64_set(&msk->bytes_received, 0);
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
@@ -3678,7 +3696,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
-	WRITE_ONCE(msk->ack_seq, 0);
+	atomic64_set(&msk->ack_seq, 0);
 	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
@@ -3742,6 +3760,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
 	struct mptcp_subflow_context *subflow;
+	u64 seq = subflow_req->idsn + 1;
 	struct mptcp_sock *msk;
 
 	if (!nsk)
@@ -3769,10 +3788,10 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);
 
-	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
-	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
-	WRITE_ONCE(msk->snd_una, msk->write_seq);
-	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
+	atomic64_set(&msk->write_seq, seq);
+	atomic64_set(&msk->snd_nxt, seq);
+	atomic64_set(&msk->snd_una, seq);
+	atomic64_set(&msk->wnd_end, seq + tcp_sk(ssk)->snd_wnd);
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
@@ -4120,7 +4139,7 @@ static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
 	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
 		return 0;
 
-	delta = msk->write_seq - v;
+	delta = atomic64_read(&msk->write_seq) - v;
 	if (__mptcp_check_fallback(msk) && msk->first) {
 		struct tcp_sock *tp = tcp_sk(msk->first);
 
@@ -4156,12 +4175,12 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 		break;
 	case SIOCOUTQ:
 		slow = lock_sock_fast(sk);
-		*karg = mptcp_ioctl_outq(msk, READ_ONCE(msk->snd_una));
+		*karg = mptcp_ioctl_outq(msk, atomic64_read(&msk->snd_una));
 		unlock_sock_fast(sk, slow);
 		break;
 	case SIOCOUTQNSD:
 		slow = lock_sock_fast(sk);
-		*karg = mptcp_ioctl_outq(msk, msk->snd_nxt);
+		*karg = mptcp_ioctl_outq(msk, atomic64_read(&msk->snd_nxt));
 		unlock_sock_fast(sk, slow);
 		break;
 	default:
@@ -4201,9 +4220,9 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 					     MPTCP_MIB_TOKENFALLBACKINIT);
 	}
 
-	WRITE_ONCE(msk->write_seq, subflow->idsn);
-	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
-	WRITE_ONCE(msk->snd_una, subflow->idsn);
+	atomic64_set(&msk->write_seq, subflow->idsn);
+	atomic64_set(&msk->snd_nxt, subflow->idsn);
+	atomic64_set(&msk->snd_una, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 
@@ -4607,7 +4626,7 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 		copied += count;
 
-		msk->bytes_consumed += count;
+		atomic64_add(count, &msk->bytes_consumed);
 		if (count < data_len) {
 			MPTCP_SKB_CB(skb)->offset += count;
 			MPTCP_SKB_CB(skb)->map_seq += count;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d5..29405d045291 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -288,15 +288,15 @@ struct mptcp_sock {
 						 * lockless access read
 						 */
 	u64		remote_key;		/* same as above */
-	u64		write_seq;
+	atomic64_t	write_seq;
 	u64		bytes_sent;
-	u64		snd_nxt;
-	u64		bytes_received;
-	u64		ack_seq;
+	atomic64_t	snd_nxt;
+	atomic64_t	bytes_received;
+	atomic64_t	ack_seq;
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
-	u64		bytes_consumed;
+	atomic64_t	bytes_consumed;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
@@ -304,8 +304,8 @@ struct mptcp_sock {
 						 * protection
 						 */
 	u64		bytes_acked;
-	u64		snd_una;
-	u64		wnd_end;
+	atomic64_t	snd_una;
+	atomic64_t	wnd_end;
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
@@ -488,7 +488,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (msk->snd_una == msk->snd_nxt)
+	if (atomic64_read(&msk->snd_una) == atomic64_read(&msk->snd_nxt))
 		return NULL;
 
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
@@ -866,7 +866,8 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);
+	return atomic64_read(&msk->bytes_received) -
+	       atomic64_read(&msk->bytes_consumed);
 }
 
 static inline bool mptcp_epollin_ready(const struct sock *sk)
@@ -989,7 +990,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->snd_data_fin_enable) &&
-	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
+	       atomic64_read(&msk->write_seq) == atomic64_read(&msk->snd_nxt);
 }
 
 static inline u32 mptcp_notsent_lowat(const struct sock *sk)
@@ -1006,7 +1007,8 @@ static inline bool mptcp_stream_memory_free(const struct sock *sk, int wake)
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	u32 notsent_bytes;
 
-	notsent_bytes = READ_ONCE(msk->write_seq) - READ_ONCE(msk->snd_nxt);
+	notsent_bytes = atomic64_read(&msk->write_seq) -
+			atomic64_read(&msk->snd_nxt);
 	return (notsent_bytes << wake) < mptcp_notsent_lowat(sk);
 }
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80c..ed221b36fd25 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1086,10 +1086,10 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	slow = lock_sock_fast(sk);
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	info->mptcpi_token = msk->token;
-	info->mptcpi_write_seq = msk->write_seq;
+	info->mptcpi_write_seq = atomic64_read(&msk->write_seq);
 	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
 	info->mptcpi_bytes_sent = msk->bytes_sent;
-	info->mptcpi_bytes_received = msk->bytes_received;
+	info->mptcpi_bytes_received = atomic64_read(&msk->bytes_received);
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
 	info->mptcpi_subflows_total = info->mptcpi_extra_subflows +
 		__mptcp_has_initial_subflow(msk);
@@ -1100,8 +1100,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 
 	mptcp_data_lock(sk);
 	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
-	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_snd_una = atomic64_read(&msk->snd_una);
+	info->mptcpi_rcv_nxt = atomic64_read(&msk->ack_seq);
 	info->mptcpi_bytes_acked = msk->bytes_acked;
 	mptcp_data_unlock(sk);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d234..8dc200d8d072 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -457,16 +457,18 @@ void __mptcp_sync_state(struct sock *sk, int state)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk = msk->first;
+	u64 seq;
 
 	subflow = mptcp_subflow_ctx(ssk);
+	seq = subflow->idsn + 1;
 	__mptcp_propagate_sndbuf(sk, ssk);
 
 	if (sk->sk_state == TCP_SYN_SENT) {
 		/* subflow->idsn is always available is TCP_SYN_SENT state,
 		 * even for the FASTOPEN scenarios
 		 */
-		WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
-		WRITE_ONCE(msk->snd_nxt, msk->write_seq);
+		atomic64_set(&msk->write_seq, seq);
+		atomic64_set(&msk->snd_nxt, seq);
 		mptcp_set_state(sk, state);
 		sk->sk_state_change(sk);
 	}
@@ -491,7 +493,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	subflow->map_seq = subflow->iasn;
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
-	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	atomic64_set(&msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
@@ -501,14 +503,15 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
 				  const struct mptcp_options_received *mp_opt)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 seq = subflow->idsn + 1;
 
 	mptcp_data_lock(sk);
 	if (mp_opt) {
 		/* Options are available only in the non fallback cases
 		 * avoid updating rx path fields otherwise
 		 */
-		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
-		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
+		atomic64_set(&msk->snd_una, seq);
+		atomic64_set(&msk->wnd_end, seq + tcp_sk(ssk)->snd_wnd);
 		subflow_set_remote_key(msk, subflow, mp_opt);
 	}
 
@@ -1198,7 +1201,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		data_len--;
 	}
 
-	map_seq = mptcp_expand_seq(READ_ONCE(msk->ack_seq), mpext->data_seq, mpext->dsn64);
+	map_seq = mptcp_expand_seq(atomic64_read(&msk->ack_seq),
+				   mpext->data_seq, mpext->dsn64);
 	WRITE_ONCE(mptcp_sk(subflow->conn)->use_64bit_ack, !!mpext->dsn64);
 
 	if (subflow->map_valid) {
@@ -1386,7 +1390,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		if (unlikely(!READ_ONCE(msk->can_ack)))
 			goto fallback;
 
-		old_ack = READ_ONCE(msk->ack_seq);
+		old_ack = atomic64_read(&msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
 		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
 			 ack_seq);
-- 
2.53.0


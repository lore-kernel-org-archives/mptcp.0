Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327424;
	b=lwQ4hVlxck3vO9vRexsYueCxU72gD+iBVjqoJUc3S6a472qrQZ49WNDnNZ38nqE3MuZ6
	 j+zycFNth1O2d6SltJoQPXUnHnDyKpddpudyosWj2Lkg4oKz8itW5wbIsary+YeIYd1Nv
	 BYs9kOL6LO1JgFvJ4L5LWEcg0AJY04u2amVGOpCZ7mmCCBWohL9AI23E6S8hLDb1waxx7
	 L3MDCx3ezn2umoQdTilEuEUOo3RaTkr31/D2IoSFF9s5MzfHjoAvUWOQy4ZwcZW5OmA62
	 N3Py8yoAkuF2KNYu/vka6rmFq4lMh6tkyJeba6mtVyGM0U8yfA9KPoxjeu45f6LbBOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327424;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/2aSQJ+FAJqI1UFGfQdZ7HR0EQ7cNqLpAGJwH7cxOug=;
	b=EzeuJ0OGFzg6Nj2svJ5yThySL9Bd8u0x2LGyZHfILPc6EtUv1K+DVv2cLZTb0QzU55sj
	 Z38sCD7JA3ijCOxbIq4sQCrCWAI8d57HvdEh17L6i5XqrwGd1r3RmsWfkpkF1CxLmcAm5
	 HUw1F+WSMn5ku/jcJgYDu74RAyoCL1GUypjefIKvWiEjdCbns/gIFQcV5QIzf++Fv+uEg
	 3KYfx5KtX/MNrshsSr/XZBHRZ2uvFeqNOZjbA+e43eoXpnTk2wfrQ9Cmr1rTHkEOj33OQ
	 pdUm/iByxOJZ155MGEjo9nbpGkpoquRRSGN9JKtvjD+hnY14QZt8dMjl7PdQ7AF2D7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBNfggsx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3192606A321
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBNfggsx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6525A1F0093A;
	Fri, 30 Oct 2026 02:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793327423;
	bh=/2aSQJ+FAJqI1UFGfQdZ7HR0EQ7cNqLpAGJwH7cxOug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBNfggsxm/6fC07rXFNKaJWL7/8PIlwPpO2pxt4aeLUCVTEzMGFwh80ZpUtunqKLU
	 VILPnY9otHbNPH2E346jFp/dUTEh0fyS6DAw3oax8xtHmgWOS/+E+1/aU3qNCNITAV
	 Pj4QBu01ev4ZzMbL2gGNBlOSHqGRe70imXhO/cHo5cQV+uoA4EbtX9ocB5IX1/b0E6
	 egzLc2h184Z4VWe+tufI1mKH/xEhbFQZKJIfEqmaEPpdBxYzwVjO0XoZeb0pMkaIvQ
	 67AxtpMw6oxwfFRtaUVw+GDBGADrPIv1l/LYeJ8fZxEMd3TH6nmz4uBp7MEmy0YKP3
	 0SAypl2wE0n+Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v17 2/4] mptcp: remove CB offset field
Date: Fri, 30 Oct 2026 10:30:13 +0800
Message-ID: <9a98772b14e535454de5bafbf113aa72a3ee6f44.1793326853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793326853.git.tanggeliang@kylinos.cn>
References: <cover.1793326853.git.tanggeliang@kylinos.cn>
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

Instead, use a new msk-level copied_seq field to track the bytes already
consumed from the MPTCP receive queue, carrying the amount of bytes already
copied to user-space, alike what TCP is already doing.

The newly introduced copied_seq field (u64) is always accessed under the
msk socket lock. For TFO synchronization, subflow_set_remote_key() checks
if copied_seq still equals the initial TFO value (-(u64)skb->len) before
updating it. If user-space has already partially read the TFO data, the
progress is preserved. WRITE_ONCE/READ_ONCE ensure proper memory ordering
between BH context (3rd ACK processing) and user-space readers.

Since both map_seq and copied_seq are u64, the offset calculation
(copied_seq - map_seq) is straightforward. We check copied_seq >= map_seq
before the subtraction to prevent underflow, which is critical for
MSG_PEEK operations that traverse multiple skbs without advancing
copied_seq.

Prior to this patch, the TFO skb dummy mapping (map_seq = -(u32)skb->len,
zero-extended to u64) caused mptcp_inq_hint() to compute a wrapped
ack_seq - map_seq, so SIOCINQ and TCP_CM_INQ returned INT_MAX before the
MPC ACK. This patch fixes that behaviour through both the -(u64)skb->len
sign fix and the new ack_seq - copied_seq hint.

Overall this simplifies __mptcp_recvmsg_mskq(), __mptcp_move_skb(), and
__mptcp_read_sock() by removing per-skb offset tracking and will also
make possible the next patch.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c | 12 ++++++----
 net/mptcp/protocol.c | 53 ++++++++++++++++++++++----------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  | 22 +++++++++++++++++-
 4 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index f717750906ff..04b1038b5200 100644
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
@@ -44,20 +45,23 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
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
 	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
+	msk = mptcp_sk(sk);
+	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
-	mptcp_sk(sk)->bytes_received += skb->len;
+	msk->bytes_received += skb->len;
 
 	sk->sk_data_ready(sk);
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 528a72da646c..f3b1b6b282a2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -169,7 +169,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
 	    unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
-	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
@@ -416,8 +415,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	skb_set_owner_r(skb, sk);
 }
 
-static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
-			   int copy_len)
+static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
@@ -426,9 +424,9 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
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
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
@@ -472,10 +470,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	/* Partial packet */
 	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
 		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
-					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
 
@@ -833,7 +827,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			mptcp_init_skb(ssk, skb, offset, len);
+			mptcp_init_skb(ssk, skb, offset);
 
 			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
@@ -896,12 +890,9 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
@@ -2195,11 +2186,22 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	int copied = 0;
 
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
-		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
-		u32 data_len = skb->len - offset;
+		u32 delta, offset = 0;
+		u32 data_len;
 		u32 count;
 		int err;
 
+		if (msk->copied_seq >= MPTCP_SKB_CB(skb)->map_seq)
+			offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
+
+		/* Skip skbs that are entirely before copied_seq */
+		if (offset >= skb->len) {
+			*last = skb;
+			continue;
+		}
+
+		data_len = skb->len - offset;
+
 		if (flags & MSG_PEEK) {
 			/* skip already peeked skbs */
 			if (total_data_len + data_len <= copied_total) {
@@ -2233,11 +2235,9 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 
 		if (!(flags & MSG_PEEK)) {
 			msk->bytes_consumed += count;
-			if (count < data_len) {
-				MPTCP_SKB_CB(skb)->offset += count;
-				MPTCP_SKB_CB(skb)->map_seq += count;
+			msk->copied_seq += count;
+			if (count < data_len)
 				break;
-			}
 
 			mptcp_eat_recv_skb(sk, skb);
 		} else {
@@ -2394,11 +2394,11 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
+	u64 hint_val;
 
 	skb = skb_peek(&sk->sk_receive_queue);
 	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
-
+		hint_val = READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
 		if (hint_val >= INT_MAX)
 			return INT_MAX;
 
@@ -3674,6 +3674,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 	msk->bytes_consumed = 0;
+	msk->copied_seq = 0;
 	msk->bytes_acked = 0;
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
@@ -4601,7 +4602,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4643,11 +4644,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index 3be60da12924..5c1fa117e5d5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -130,7 +130,6 @@
 struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
-	u32 offset;
 	u8  has_rxtstamp;
 	u8  cant_coalesce;
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
index 78e886b20258..6a66841ca24a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -533,6 +533,26 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+
+	if (subflow->is_mptfo) {
+		struct sock *sk = (struct sock *)msk;
+		struct sk_buff *skb;
+
+		skb = skb_peek(&sk->sk_receive_queue);
+		if (skb) {
+			u64 tfo_map_seq = subflow->iasn - skb->len;
+
+			WRITE_ONCE(MPTCP_SKB_CB(skb)->map_seq, tfo_map_seq);
+			WRITE_ONCE(MPTCP_SKB_CB(skb)->end_seq, subflow->iasn);
+
+			if (READ_ONCE(msk->copied_seq) != -(u64)skb->len)
+				return;
+
+			WRITE_ONCE(msk->copied_seq, tfo_map_seq);
+			return;
+		}
+	}
+	WRITE_ONCE(msk->copied_seq, subflow->iasn);
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
@@ -1485,7 +1505,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
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


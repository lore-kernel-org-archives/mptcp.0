Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161235B63D
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312961; cv=none; b=NzMMzbFMEyjLNuUDGfdqCHm7h6HxuMCyoUAFpl/iGO6uV0wxmgf1kwDO9UKhFD3wiv9QqZ04KT8/Zx9F8Yo0TqsRQwM3qY6Kad4/EUVm1z3dVQbWzd/Bu9b7bom4pITtbf2lij1R7aaj+uPLg8iVb43N7IaSB2PL7XZJihRETqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312961; c=relaxed/simple;
	bh=8GkVV7UehmmYE8pkzDJ303W1AsGuwuX2M1NqfqIGqcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=S5Gv62p3WMEPAPlQ9bilyMwjwTZnkDPTfEHYT4A8l2OeO1ocymPt8GC4KCzWl6uGYxugDMdeOHMd0imiisSku508nBI4BVM6k+hWxVgXpmPvhuD411LmhBbUOD741ToNRQLAI6YXxea17Y746CaVPQiLr47y2xlEqRWky4har5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNRAvA9Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNRAvA9Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778312959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPa/qHxDDBaN3pGsLDvVm7U2XWuhUW+k2BaDVf3GGNY=;
	b=bNRAvA9Zx7RZXSd4Qf+skR5yRHBu2zjD/YiXtATBjc+C1ytFhO9Mj4D1jVAFBtXQrRqrAK
	nRGuCxHsK4Nu9ilErE5UhR+gnSHMb1DOtRFekivDqZyY+2mfoKMl6h4EUTDotFjmLFtX3N
	TJfqHlwrRuWhvEDhQ1KyQeEqEcTZiC0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-LflxGEPdO5qzVJaveramsw-1; Sat,
 09 May 2026 03:49:17 -0400
X-MC-Unique: LflxGEPdO5qzVJaveramsw-1
X-Mimecast-MFC-AGG-ID: LflxGEPdO5qzVJaveramsw_1778312956
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E386180034A;
	Sat,  9 May 2026 07:49:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C2AB18004A3;
	Sat,  9 May 2026 07:49:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 06/12] mptcp: remove CB offset field
Date: Sat,  9 May 2026 09:48:26 +0200
Message-ID: <abe9923377952ae63c600c888512b0e8c835bcea.1778312843.git.pabeni@redhat.com>
In-Reply-To: <cover.1778312843.git.pabeni@redhat.com>
References: <cover.1778312843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gnU6xZnlJ6_A1fJ21mYrObZk6T3kbozEHEl219D_g6w_1778312956
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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

Overall this simplify a bit the __mptcp_recvmsg_mskq() and mptcp_inq_hint()
code and will also make possible the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - fix peek seq race

v2 -> v3:
  - do not use msk->first in release_cb to deal with MPTCP_SYNC_SEQ:
    subflow->iasn access is (data) racy and msk->first can be null, instead
    recompute iasn from msk bytes_received and TFO skb len
  - when updating copied_seq after remote key reception, add iasn to it
    instead of overwriting, to avoid deleting any partial progress.

v1 -> v2:
  - deal correctly with peek, as usally "inspired" from the correspondent
    tcp code
  - update mptcp_inq_hint(), too

Notes:
- this explicitly relays on "mptcp: do not drop partial packets" to
avoid dropping partially consumed packets
- sashiko may confuse the 'offset' in mptcp_init_skb for an MPTCP-level
  one, but it refers to the TCP sequence space. Conclusion out of the
  that assumptions are wrong.
- the data race in mptcp_inq_hint() is real, but pre-existing and can
  impact only sockopt() output - the other call-sites are race free, as
  ack_seq updates are serialized by the RX path.
  Fixing the race for good without sashiko tripping on other similar
  minor races would require another largish series. Postponed.
- sashiko may see a race with `copied_seq` in mptcp_recv_skb(), that is
  not real: subflow_set_remote_key()/__mptcp_sync_rcv_sequence() has seen
  the msk owned; if mptcp_data_ready() has seen again the msk owend, the
  only skb in the receive queue can be the (unsynched) TFO one, with dummy
  sequence. If mptcp_data_ready() observed msk not owned and queued more
  skbs, the release_cb() has run and synched `copied_seq` and TFO skb
  map_seq.
---
 net/mptcp/fastopen.c | 15 ++++---
 net/mptcp/protocol.c | 93 +++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  8 +++-
 net/mptcp/subflow.c  |  7 +++-
 4 files changed, 63 insertions(+), 60 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index c7d5bee8088e..03e605b050f8 100644
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
@@ -43,20 +44,24 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
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
index 6909586a3090..87df66a682c9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -160,7 +160,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
-	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
@@ -342,8 +341,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	skb_set_owner_r(skb, sk);
 }
 
-static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
-			   int copy_len)
+static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
@@ -352,9 +350,9 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
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
@@ -377,8 +375,8 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 	if (!skb)
 		return;
 
-	MPTCP_SKB_CB(skb)->map_seq = msk->ack_seq - skb->len;
-	MPTCP_SKB_CB(skb)->end_seq = msk->ack_seq;
+	MPTCP_SKB_CB(skb)->map_seq = mptcp_iasn(msk) - skb->len;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
@@ -783,7 +781,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			mptcp_init_skb(ssk, skb, offset, len);
+			mptcp_init_skb(ssk, skb, offset);
 
 			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
@@ -850,8 +848,6 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
-			MPTCP_SKB_CB(skb)->offset += delta;
-			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
 		msk->bytes_received += end_seq - msk->ack_seq;
@@ -2095,34 +2091,22 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
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
-		u32 count;
+		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
+		u32 count, data_len = skb->len - offset;
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
-		}
+		/* Skip the already peeked data. */
+		if (offset >= skb->len)
+			continue;
 
 		count = min_t(size_t, len - copied, data_len);
 		if (!(flags & MSG_TRUNC)) {
@@ -2140,14 +2124,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2299,22 +2281,17 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
-
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+	u64 hint_val;
 
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
+	hint_val = READ_ONCE(msk->ack_seq) - msk->copied_seq;
+	if (hint_val >= INT_MAX)
+		return INT_MAX;
 
-		return (unsigned int)hint_val;
-	}
-
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
+	if (!hint_val &&
+	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
 		return 1;
 
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -2323,6 +2300,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
+	u64 peek_seq, *seq;
 	int target;
 	long timeo;
 
@@ -2342,6 +2320,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	len = min_t(size_t, len, INT_MAX);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+	seq = &msk->copied_seq;
+	if (flags & MSG_PEEK) {
+		peek_seq = msk->copied_seq;
+		seq = &peek_seq;
+	}
 
 	if (unlikely(msk->recvmsg_inq))
 		cmsg_flags = MPTCP_CMSG_INQ;
@@ -2351,7 +2334,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags,
+						  seq, &tss, &cmsg_flags,
 						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
@@ -2406,6 +2389,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			err = copied ? : err;
 			goto out_err;
 		}
+
+		/* Recompute peek offset after eventual seq resync. */
+		if (flags & MSG_PEEK)
+			peek_seq = msk->copied_seq + copied;
 	}
 
 	mptcp_cleanup_rbuf(msk, copied);
@@ -3500,11 +3487,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
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
@@ -3729,8 +3718,10 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_error_report(sk);
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += mptcp_iasn(msk);
 			__mptcp_sync_rcv_sequence(sk);
+		}
 	}
 }
 
@@ -4390,7 +4381,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4432,11 +4423,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 16a1f4531dad..f3d852e52982 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -129,7 +129,6 @@
 struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
-	u32 offset;
 	u8  has_rxtstamp;
 };
 
@@ -289,6 +288,7 @@ struct mptcp_sock {
 	u64		bytes_sent;
 	u64		snd_nxt;
 	u64		bytes_received;
+	u64		copied_seq;
 	u64		ack_seq;
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
@@ -308,6 +308,7 @@ struct mptcp_sock {
 	u32		last_ack_recv;
 	unsigned long	timer_ival;
 	u32		token;
+	u32		tfo_skb_len;
 	unsigned long	flags;
 	unsigned long	cb_flags;
 	bool		rcvd_dummy_seq;
@@ -859,6 +860,11 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
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
index 5f371bf773f8..c8ea876bdd03 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -499,10 +499,13 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 
-	if (!sock_owned_by_user(sk))
+	if (!sock_owned_by_user(sk)) {
+		/* User space could have already read partially the TFO skb */
+		msk->copied_seq += subflow->iasn;
 		__mptcp_sync_rcv_sequence(sk);
-	else
+	} else {
 		__set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
+	}
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.54.0


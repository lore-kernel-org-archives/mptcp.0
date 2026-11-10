Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305517;
	b=KhisO3OFJt5L/BNt/Gheng1Gk/plloq24aKCJKq3WYgbNauTq7inOWcQK5znBbaVhpDi
	 urGYwR7JbdaZOgaTtytPyi23xOEWw5cNQGdT7EPmuv+AFHL+Q7am41Yx051XBJbTn0nID
	 J4DzttCheUJuh5DlWugMX83QpWJOTpeTv4ltOVztFiSj/4AA4MihqWLi//qU7AIFmwu9w
	 rGQtEX1BiFr1wd69cAadFX7d3a7QMlYc4Y9SmnzHWyAFtLAq4u+r31WWujQzN9kL2/qMs
	 DI4gDpA4YTJy0P52rO4q6MPxIYAYCUHOSYwglnXhCGAFtFa5Ht7xMHzc/2QrLK/lbHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305517;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ds2ksEBXXBzmwzAA3NvbN9gQjvChceJ4f9q8XGecZfw=;
	b=16cIEruBIguNlcbHlyqvPXAoNXNTDdORyQdtdRRUrG2S+rLqz+8Rne3e7u1VPfqzPDOD
	 mXQSUOs7lwMBH+FheCs6VZhNIuWVbLMzKYL2kri9/oIb3gwSUHZO5j5JCy8o3K25aWcKK
	 nL+IeaPVrN2dnbwtd/v90xbyWQkdULo1j8QXE93biceNyfreKFt4PxdNlMhGGecLe6Agm
	 0D7r5XvH2s+a+iIdDNN7fwuPnFnA40nyHl59nVXnxDfbBfBblFLjOWSqaKxhncaZOYCKE
	 hAEphptpu5jZfleklrbdg0O9FiuZh2MefNFxAQlTf7jxGODAGGC8RhyK+PIPm4Z19PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqGn1uIZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9A606A33C
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqGn1uIZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233E31F008A1
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305516;
	bh=Ds2ksEBXXBzmwzAA3NvbN9gQjvChceJ4f9q8XGecZfw=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=CqGn1uIZtOfIWMr66bWHeYszr3MUvZAU7V4sE+oghKHbWQdVqxkt++bHlwdmH/Mh8
	 YrtTC9+bniM4FqWpMYnIxPKr4yZQx/pXqxGgVJe+DZObdt/nvSm6knwPONZ8R8WK+M
	 Z1DJkZNlkIP/Etk5JrSR8TaatQnjYhemUp3AfuD621pEJvoeeYxzJiriarXHdAWaCM
	 +hr1xVD0MuA649HXGguwyASa2PEXJG2ge4CJMmq2rsnJCqO6dhPuOqtySmTcJZxBIs
	 NB0u43JvyVhKRSv8lmy42ThJnreOQFps8tUvgy+jw6UwWuvfn6xrjhBR1EK5LFhHyS
	 Gzmd1BeXW6GEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v25 6/8] mptcp: remove CB offset field
Date: Tue, 10 Nov 2026 18:11:45 +0800
Message-ID: <cb95c9ef7c21a759db68ab8e9697a52d32848b0c.1794304840.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794304840.git.tanggeliang@kylinos.cn>
References: <cover.1794304840.git.tanggeliang@kylinos.cn>
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

In mptcp_init_skb(), map_seq is set to mptcp_subflow_get_mapped_dsn()
without subtracting offset, and end_seq is set to map_seq + copy_len.
This keeps map_seq pointing to the actual start of new data, avoiding
issues with OFO queue comparisons and coalescing when the skb spans
multiple DSS mappings with non-contiguous DSNs.

A new MPTCP_SKB_CB_F_OFFSET flag marks skbs where offset > 0. This flag
is used in __mptcp_try_coalesce() to refuse coalescing when the from skb
carries a prefix, preventing the prefix bytes from ending up in the middle
of the merged skb which would break the offset calculation.

A new helper mptcp_offset() computes the prefix length on-the-fly as
skb->len - (end_seq - map_seq). The recvmsg path (__mptcp_recvmsg_mskq()
and mptcp_recv_skb()) uses this helper to skip prefix bytes when reading
data, instead of relying on a stored offset field.

The partial packet handling in __mptcp_move_skb() and __mptcp_ofo_queue()
no longer adjusts offset and map_seq, as the recvmsg path computes the
correct read position using mptcp_offset().

Overall this simplifies a bit the __mptcp_recvmsg_mskq() and the
__mptcp_move_skb() code and will also make possible the next patch.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  9 ++++--
 net/mptcp/protocol.c | 77 ++++++++++++++++++++++----------------------
 net/mptcp/protocol.h | 11 ++++++-
 net/mptcp/subflow.c  |  6 ++--
 4 files changed, 58 insertions(+), 45 deletions(-)

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
index ce0f9c2e6fd1..645eaf3078a9 100644
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
@@ -421,13 +421,12 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
-	/* the skb map_seq accounts for the skb offset:
-	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
+	/* mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
 	 * value
 	 */
 	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
-	MPTCP_SKB_CB(skb)->offset = offset;
+	MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
@@ -494,10 +493,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	/* Partial packet */
 	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
 		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
-					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
 
@@ -918,12 +913,9 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
@@ -2207,33 +2199,25 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
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
+		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq +
+			     mptcp_offset(skb);
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
@@ -2252,14 +2236,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2398,8 +2380,10 @@ static bool mptcp_move_skbs(struct sock *sk)
 
 	mptcp_data_lock(sk);
 	while (1) {
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
 			__mptcp_sync_rcv_sequence(sk);
+		}
 
 		if (!mptcp_can_spool_backlog(sk, &skbs))
 			break;
@@ -2439,6 +2423,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
+	u64 peek_seq, *seq;
 	int target;
 	long timeo;
 
@@ -2457,6 +2442,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	len = min_t(size_t, len, INT_MAX);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+	seq = &msk->copied_seq;
+	if (flags & MSG_PEEK) {
+		peek_seq = msk->copied_seq;
+		seq = &peek_seq;
+	}
 
 	if (unlikely(msk->recvmsg_inq))
 		cmsg_flags = MPTCP_CMSG_INQ;
@@ -2466,7 +2456,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags,
+						  seq, &tss, &cmsg_flags,
 						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
@@ -2476,8 +2466,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
+			if (flags & MSG_PEEK)
+				peek_seq = msk->copied_seq + copied;
 			continue;
+		}
 
 		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -2520,6 +2513,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			copied = copied ? : err;
 			goto out_err;
 		}
+
+		/* Recompute peek offset after eventual seq resync. */
+		if (flags & MSG_PEEK)
+			peek_seq = msk->copied_seq + copied;
 	}
 
 	mptcp_cleanup_rbuf(msk, copied);
@@ -3696,6 +3693,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 	msk->bytes_consumed = 0;
+	msk->copied_seq = 0;
 	msk->bytes_acked = 0;
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
@@ -3906,8 +3904,10 @@ static void mptcp_release_cb(struct sock *sk)
 		struct list_head join_list, skbs;
 		bool spool_bl;
 
-		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			msk->copied_seq += msk->tfo_iasn;
 			__mptcp_sync_rcv_sequence(sk);
+		}
 
 		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
 		if (!flags && !spool_bl)
@@ -4628,7 +4628,8 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq +
+			 mptcp_offset(skb);
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4670,11 +4671,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index b4e49d719200..2b583846a93e 100644
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
@@ -1381,6 +1384,12 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 	return sk->sk_state == TCP_SYN_RECV && is_active_ssk(subflow);
 }
 
+static inline u32 mptcp_offset(const struct sk_buff *skb)
+{
+	return skb->len -
+	       (MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq);
+}
+
 #ifdef CONFIG_SYN_COOKIES
 void subflow_init_req_cookie_join_save(const struct mptcp_subflow_request_sock *subflow_req,
 				       struct sk_buff *skb);
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


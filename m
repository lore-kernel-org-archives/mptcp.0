Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811157;
	b=GxQrkEV9eQ08/Z+NM1uRX1KSJrwNf+gqtIr9SmqpSgmKk/fNO6EEuvqI56oW7pCIqK3n
	 Yq8EgmP40/VjnDsgjpqeRc9YiSPEftgi/C5ZfIZ4NtGPvoavwSzS3BvRLYgyZY7UGGS4+
	 ZVH3yiLHwgAgMj76xMmI0GSn/To/xEPNoFcE+n464+70iyAaQ8rscU/ADNwr2Rh1fnk68
	 REhcYC3UP6J8G4CXtyTpbjhpucA/63Ws9/aqpcfTxO+lR91Qp4O6tGKgXLp05DKQT4QBO
	 tpVOmubmiqT357uSsilhvRBSVcT5ktxsCj61YrN9LpG/GPMbQ1Cq9xlFi7NdRKt4ZQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811157;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MT0nMYPcp+aoBnYxYNzvLA/NtxZLSMZGldWsY26QqBg=;
	b=u27p3wfYlCF2B7TcbkQ3dYXzQ8C+O40hTsT8NaXRAHcUsCdO6W9FF1UM8ASmuPcgaLeg
	 r5Zf6VsN7OeUKn8fJT/C4yGaiYLfKVSINQXAqqMb/qpAztYBkod4oXOhYLkz5MB9caZ1E
	 S6qbK+lL3wdvuQaY60QsAUfa9yTSQ/rYLePa6u8E09fOivgNiIF+ojo8HLTuWRfytrKfC
	 R616T10z86MAIWZWhfnteQsSGf3HwATCB74q++hg/jwINKfYQVj1m9RGMSV/+ng1ss+X7
	 k2dEB9P21P1lUNzuTdEX2ca9JdTr1DO6L5He7jSOSsQuu4P+YO0Vq78RXkzO+erTh1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK+ULeRx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FF4606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK+ULeRx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865121F000C4
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811157;
	bh=MT0nMYPcp+aoBnYxYNzvLA/NtxZLSMZGldWsY26QqBg=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=KK+ULeRxM9oKaVtqs/7CGjkqxzf8Vbb1GBR0p7KjZQKncdhtCDGCadOwS78DDP2+L
	 4uP2ujP1KvAtKmb64OHlht7Bhz2qe6AvDIO0mBlAuvO73ozXKQjZ/cHkokzZ2FHQRo
	 8nGYYvJzL+VzSpWjucIrGwSAdc0VIGMHCLbUFM/TgBr7k8wq0nGmkdfEFBj+D0RjQ8
	 Xwxx1zhawX2ji6oRd7f1/IVmRxt057xhfyEXx9lCsXZB2zc+a30heD8tEIxwZCpWKv
	 I8BcptfapQ8T+BKWZ4MbDxGmRGCxTiwF/1HmEtuyKehjZBxzEk9RA6GwAuNSdRp7PS
	 gLModnLK8jv1A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v28 07/11] mptcp: encapsulate CB DSN field access with helpers
Date: Mon, 16 Nov 2026 14:39:00 +0800
Message-ID: <143b8387b6159088b7acf529a3cf43b45615aacc.1794810809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_dsn() and mptcp_end_dsn() helper functions to access the DSN
(Data Sequence Number) from MPTCP skb CB. mptcp_dsn() returns the start
DSN (map_seq) and mptcp_end_dsn() returns the end DSN (end_seq).

Replace direct accesses to MPTCP_SKB_CB(skb)->map_seq and end_seq with
these helpers throughout the receive path. This encapsulation will make
it easier to change the CB layout in subsequent commits.

This is a pure refactoring patch with no behavior change.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 37 ++++++++++++++++++------------------
 net/mptcp/protocol.h         | 10 ++++++++++
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index c47fa2672b84..cb990186ec30 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -223,7 +223,7 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__entry->space = msk->rcvq_space.space;
 		ofo_empty = RB_EMPTY_ROOT(&msk->out_of_order_queue);
 		__entry->ooo_space = ofo_empty ? 0 :
-				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
+				     (u32)mptcp_end_dsn(msk->ooo_last_skb) -
 				     msk->ack_seq;
 
 		__entry->rcvbuf = sk->sk_rcvbuf;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 395bdcd0080c..c780529342d6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -167,7 +167,7 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 {
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
-	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
+	if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||
 	    (MPTCP_SKB_CB(from)->flags | MPTCP_SKB_CB(to)->flags) &
 	     MPTCP_SKB_CB_F_OFFSET ||
 	    ((to->len + from->len) > (limit >> 3)) ||
@@ -256,8 +256,7 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
 		struct sk_buff *skb = rb_to_skb(node);
 
 		/* Stop pruning if the incoming skb would land in OoO tail. */
-		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
-			    MPTCP_SKB_CB(skb)->map_seq))
+		if (after64(mptcp_dsn(in_skb), mptcp_dsn(skb)))
 			break;
 
 		pruned = true;
@@ -306,8 +305,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	u64 seq, end_seq, max_seq;
 	struct sk_buff *skb1;
 
-	seq = MPTCP_SKB_CB(skb)->map_seq;
-	end_seq = MPTCP_SKB_CB(skb)->end_seq;
+	seq = mptcp_dsn(skb);
+	end_seq = mptcp_end_dsn(skb);
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
 	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
@@ -347,7 +346,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+	if (!before64(seq, mptcp_end_dsn(msk->ooo_last_skb))) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -359,18 +358,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	while (*p) {
 		parent = *p;
 		skb1 = rb_to_skb(parent);
-		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
+		if (before64(seq, mptcp_dsn(skb1))) {
 			p = &parent->rb_left;
 			continue;
 		}
-		if (before64(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
-			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
+		if (before64(seq, mptcp_end_dsn(skb1))) {
+			if (!after64(end_seq, mptcp_end_dsn(skb1))) {
 				/* All the bits are present. Drop. */
 				mptcp_drop(sk, skb);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 				return;
 			}
-			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
+			if (after64(seq, mptcp_dsn(skb1))) {
 				/* partial overlap:
 				 *     |     skb      |
 				 *  |     skb1    |
@@ -401,7 +400,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
+		if (before64(end_seq, mptcp_end_dsn(skb1)))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -461,6 +460,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 dsn = mptcp_dsn(skb);
 	struct sk_buff *tail;
 
 	mptcp_borrow_fwdmem(sk, skb);
@@ -471,7 +471,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(msk->rcvd_dummy_seq))
 		__mptcp_sync_rcv_sequence(sk);
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	if (dsn == msk->ack_seq) {
 		/* in sequence */
 insert:
 		if (!mptcp_try_rmem_schedule(sk, skb)) {
@@ -489,14 +489,14 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
-	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
+	} else if (after64(dsn, msk->ack_seq)) {
 		mptcp_data_queue_ofo(msk, skb);
 		return false;
 	}
 
 	/* Partial packet */
-	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
-		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	if (after64(mptcp_end_dsn(skb), msk->ack_seq)) {
+		copy_len = mptcp_end_dsn(skb) - msk->ack_seq;
 		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
 					     MPTCP_SKB_CB(skb)->map_seq;
 		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
@@ -903,20 +903,19 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
 		skb = rb_to_skb(p);
-		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
+		if (after64(mptcp_dsn(skb), msk->ack_seq))
 			break;
 
 		p = rb_next(p);
 		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
 
-		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq,
-				      msk->ack_seq))) {
+		if (unlikely(!after64(mptcp_end_dsn(skb), msk->ack_seq))) {
 			mptcp_drop(sk, skb);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 			continue;
 		}
 
-		end_seq = MPTCP_SKB_CB(skb)->end_seq;
+		end_seq = mptcp_end_dsn(skb);
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 241437deaf2d..755d524ef6b7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1384,6 +1384,16 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 	return sk->sk_state == TCP_SYN_RECV && is_active_ssk(subflow);
 }
 
+static inline u64 mptcp_end_dsn(const struct sk_buff *skb)
+{
+	return MPTCP_SKB_CB(skb)->end_seq;
+}
+
+static inline u64 mptcp_dsn(const struct sk_buff *skb)
+{
+	return MPTCP_SKB_CB(skb)->map_seq;
+}
+
 #ifdef CONFIG_SYN_COOKIES
 void subflow_init_req_cookie_join_save(const struct mptcp_subflow_request_sock *subflow_req,
 				       struct sk_buff *skb);
-- 
2.55.0


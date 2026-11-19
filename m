Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065050;
	b=G95tp52LXspUnxkyZNeRdyLhnBvfRlFwfgnWx/KeS4S5nf/LQZc3K5HWXkXTXFYOM9EO
	 Fzbkdx9d8IAAghqEYp+ALJTqmrvKyvNeVts8BrZUy/lUeAAVz/sTsLb8DCOOhtrxqBF+P
	 5zL7R59ZH1DckH1eZ2L9l1JxZ/F8v/RgUYiuR3HmSYm12YZE2eOQnrFporr+RP3QhG9UX
	 mp7hL2WdO10GglXJVgoVmi2ZPoQwdBapmcc4/i52pKXNKDXdNeWDEubDiw9wiKXedNddu
	 JSIAOWxOQyuGoYg8w5/t7hkUz8ZQw+jBoPaqbaCv20+voPwBfsaI/np7JAv7lt4UqXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065050;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wwLJa7PCDyeD8g7RwMPKUf1Bgvt7EDs0l+bCr8QtUwA=;
	b=E3lU5+Jyb4L+3oOBG/cwNZhd+Pqo94ZWQb9MClw9NsV0hYn2KmtUSmWybElFIn7CBNlO
	 BuNe9jrEhHYEBPdCBvJjm91YZSXfoJ/gqgtwVj31WjuStB4aIwuOnujbBGTTX4Tgb3Ytb
	 Sz/Hlb9ng/1OR3rr38auAN+yv68FMeY0S8Sni2zR0+7hTO/xECc3dMEchfNOK3Ebs7NXo
	 p5ZMQKZmwMqompiVEMHr8qv6ukBlKT5gRDPySrWIeX4NGNk3I7jSNpV+NJkKh9rOU8W+n
	 aUJxeAp3hEXPLpZr6RpGCtIJfoy4KO+ywA7Nagzez3CeDrcKgS9iqvdasH68R55htzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beEOHglp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0565C606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beEOHglp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C641F000CC
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065049;
	bh=wwLJa7PCDyeD8g7RwMPKUf1Bgvt7EDs0l+bCr8QtUwA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=beEOHglpgKJ7ZcR2sbhVzXPXMS2amtCly07FgAn+iRubFKqyN5/tBlkTwLLXoSszq
	 7CpdcKbGre7Y2Z3SPlg0LGWvEQARb5dESefuZOO4GDQg6/IgbcEEmPzbGziHqRRULi
	 En47EASI5FY/eOMvQtsD7x/P2vbE0WC3FVXltg+DOJ0B7kDqe+qcmhlmFF6mGhYR/M
	 S06wKxojlDdxkpgPkiILmeAougbJptrfhBWw8XHGgIjOrY2l9Qcwwq4DpQw+ADV+7h
	 GnXXKth0TsDsUPJR8xozA9DEp/eeROy8M1p+eoyTYUUyDTYDuW2pMs4MC2UMSg8ddQ
	 PFEluBkpQZeUg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v29 5/8] mptcp: encapsulate CB DSN field access with helpers
Date: Thu, 19 Nov 2026 13:10:31 +0800
Message-ID: <93f8727507735aefbf0794b1af5b555993249a5e.1795063943.git.tanggeliang@kylinos.cn>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_dsn() and mptcp_end_dsn() helper functions to access the DSN
(Data Sequence Number) from MPTCP skb CB. mptcp_dsn() returns the start
DSN (map_seq) and mptcp_end_dsn() returns the end DSN (end_seq).

Replace direct accesses to MPTCP_SKB_CB(skb)->map_seq and end_seq with
these helpers where appropriate. This encapsulation will make it easier
to change the CB layout in subsequent commits.

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
index 6548f8c703d6..1a5d1f97c087 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -167,7 +167,7 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 {
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
-	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
+	if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||
 	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
@@ -255,8 +255,7 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
 		struct sk_buff *skb = rb_to_skb(node);
 
 		/* Stop pruning if the incoming skb would land in OoO tail. */
-		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
-			    MPTCP_SKB_CB(skb)->map_seq))
+		if (after64(mptcp_dsn(in_skb), mptcp_dsn(skb)))
 			break;
 
 		pruned = true;
@@ -305,8 +304,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	u64 seq, end_seq, max_seq;
 	struct sk_buff *skb1;
 
-	seq = MPTCP_SKB_CB(skb)->map_seq;
-	end_seq = MPTCP_SKB_CB(skb)->end_seq;
+	seq = mptcp_dsn(skb);
+	end_seq = mptcp_end_dsn(skb);
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
 	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
@@ -346,7 +345,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+	if (!before64(seq, mptcp_end_dsn(msk->ooo_last_skb))) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -358,18 +357,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
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
@@ -400,7 +399,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
+		if (before64(end_seq, mptcp_end_dsn(skb1)))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -459,6 +458,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 dsn = mptcp_dsn(skb);
 	struct sk_buff *tail;
 
 	mptcp_borrow_fwdmem(sk, skb);
@@ -469,7 +469,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(msk->rcvd_dummy_seq))
 		__mptcp_sync_rcv_sequence(sk);
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	if (dsn == msk->ack_seq) {
 		/* in sequence */
 insert:
 		if (!mptcp_try_rmem_schedule(sk, skb)) {
@@ -487,14 +487,14 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -901,20 +901,19 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
index ee07f17eecd5..9f0cfda70b23 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1385,6 +1385,16 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
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


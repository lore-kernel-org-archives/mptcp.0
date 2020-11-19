Content-Type: multipart/mixed; boundary="===============7353450093650592730=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v5 4/6] mptcp: allocate TX skbs in msk context.
Date: Thu, 19 Nov 2020 13:38:24 +0100
Message-ID: <8678c1babccb885a8c6da75c04655a1eff48f2c6.1605789317.git.pabeni@redhat.com>
In-Reply-To: cover.1605789317.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6831

--===============7353450093650592730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the TX skbs allocation in mptcp_sendmsg() scope,
and tentativelly allocate a skbs based on the goal
size on the last used subflow.

Use the ssk tx skb cache to prevent the subflow allocation.

This allows removing the msk skb extension cache and will
make possible the later patch.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v2 -> v3:
 - update __mptcp_wmem_schedule() to take in account skb truesize,
   too
 - mptcp_reclaim_partial takes in account wmem_reserved status
---
 net/mptcp/protocol.c | 248 ++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |   4 +-
 2 files changed, 210 insertions(+), 42 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3074e0720110..cf90426ab725 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -804,16 +804,6 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 	mptcp_close_wake_up(sk);
 }
 =

-static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
-{
-	const struct sock *sk =3D (const struct sock *)msk;
-
-	if (!msk->cached_ext)
-		msk->cached_ext =3D __skb_ext_alloc(sk->sk_allocation);
-
-	return !!msk->cached_ext;
-}
-
 static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -852,14 +842,22 @@ static bool mptcp_frag_can_collapse_to(const struct m=
ptcp_sock *msk,
 		df->data_seq + df->data_len =3D=3D msk->write_seq;
 }
 =

-static int mptcp_wmem_with_overhead(int size)
+static int mptcp_wmem_with_overhead(struct sock *sk, int size)
 {
-	return size + ((sizeof(struct mptcp_data_frag) * size) >> PAGE_SHIFT);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	int ret, skbs;
+
+	ret =3D size + ((sizeof(struct mptcp_data_frag) * size) >> PAGE_SHIFT);
+	skbs =3D (msk->tx_pending_data + size) / msk->size_goal_cache;
+	if (skbs < msk->skb_tx_cache.qlen)
+		return ret;
+
+	return ret + (skbs - msk->skb_tx_cache.qlen) * SKB_TRUESIZE(MAX_TCP_HEADE=
R);
 }
 =

 static void __mptcp_wmem_reserve(struct sock *sk, int size)
 {
-	int amount =3D mptcp_wmem_with_overhead(size);
+	int amount =3D mptcp_wmem_with_overhead(sk, size);
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	WARN_ON_ONCE(msk->wmem_reserved);
@@ -940,6 +938,25 @@ static void mptcp_wmem_uncharge(struct sock *sk, int s=
ize)
 	msk->wmem_reserved +=3D size;
 }
 =

+static void mptcp_mem_reclaim_partial(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	/* if we are experiencing a transint allocation error,
+	 * the forward allocation memory has been already
+	 * released
+	 */
+	if (msk->wmem_reserved < 0)
+		return;
+
+	mptcp_data_lock(sk);
+	sk->sk_forward_alloc +=3D msk->wmem_reserved;
+	sk_mem_reclaim_partial(sk);
+	msk->wmem_reserved =3D sk->sk_forward_alloc;
+	sk->sk_forward_alloc =3D 0;
+	mptcp_data_unlock(sk);
+}
+
 static void dfrag_uncharge(struct sock *sk, int len)
 {
 	sk_mem_uncharge(sk, len);
@@ -1016,19 +1033,12 @@ static void mptcp_clean_una_wakeup(struct sock *sk)
 	}
 }
 =

-/* ensure we get enough memory for the frag hdr, beyond some minimal amoun=
t of
- * data
- */
-static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfra=
g)
+static void mptcp_enter_memory_pressure(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	bool first =3D true;
 =

-	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
-					pfrag, sk->sk_allocation)))
-		return true;
-
 	sk_stream_moderate_sndbuf(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
@@ -1038,6 +1048,18 @@ static bool mptcp_page_frag_refill(struct sock *sk, =
struct page_frag *pfrag)
 		sk_stream_moderate_sndbuf(ssk);
 		first =3D false;
 	}
+}
+
+/* ensure we get enough memory for the frag hdr, beyond some minimal amoun=
t of
+ * data
+ */
+static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfra=
g)
+{
+	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
+					pfrag, sk->sk_allocation)))
+		return true;
+
+	mptcp_enter_memory_pressure(sk);
 	return false;
 }
 =

@@ -1084,6 +1106,128 @@ static int mptcp_check_allowed_size(struct mptcp_so=
ck *msk, u64 data_seq,
 	return avail_size;
 }
 =

+static bool __mptcp_add_ext(struct sk_buff *skb, gfp_t gfp)
+{
+	struct skb_ext *mpext =3D __skb_ext_alloc(gfp);
+
+	if (!mpext)
+		return false;
+	__skb_ext_set(skb, SKB_EXT_MPTCP, mpext);
+	return true;
+}
+
+static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk)
+{
+	struct sk_buff *skb;
+
+	skb =3D alloc_skb_fclone(MAX_TCP_HEADER, sk->sk_allocation);
+	if (likely(skb)) {
+		if (likely(__mptcp_add_ext(skb, sk->sk_allocation))) {
+			skb_reserve(skb, MAX_TCP_HEADER);
+			skb->reserved_tailroom =3D skb->end - skb->tail;
+			return skb;
+		}
+		__kfree_skb(skb);
+	} else {
+		mptcp_enter_memory_pressure(sk);
+	}
+	return NULL;
+}
+
+static bool mptcp_tx_cache_refill(struct sock *sk, int size,
+				  struct sk_buff_head *skbs, int *total_ts)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct sk_buff *skb;
+	int space_needed;
+
+	if (unlikely(tcp_under_memory_pressure(sk))) {
+		mptcp_mem_reclaim_partial(sk);
+
+		/* under pressure pre-allocate at most a single skb */
+		if (msk->skb_tx_cache.qlen)
+			return true;
+		space_needed =3D msk->size_goal_cache;
+	} else {
+		space_needed =3D msk->tx_pending_data + size -
+			       msk->skb_tx_cache.qlen * msk->size_goal_cache;
+	}
+
+	while (space_needed > 0) {
+		skb =3D __mptcp_do_alloc_tx_skb(sk);
+		if (unlikely(!skb)) {
+			/* under memory pressure, try to pass the caller a
+			 * single skb to allow forward progress
+			 */
+			while (skbs->qlen > 1) {
+				skb =3D __skb_dequeue_tail(skbs);
+				__kfree_skb(skb);
+			}
+			return skbs->qlen > 0;
+		}
+
+		*total_ts +=3D skb->truesize;
+		__skb_queue_tail(skbs, skb);
+		space_needed -=3D msk->size_goal_cache;
+	}
+	return true;
+}
+
+static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct sk_buff *skb;
+
+	if (ssk->sk_tx_skb_cache) {
+		skb =3D ssk->sk_tx_skb_cache;
+		if (unlikely(!skb_ext_find(skb, SKB_EXT_MPTCP) &&
+			     !__mptcp_add_ext(skb, sk->sk_allocation)))
+			return false;
+		return true;
+	}
+
+	skb =3D skb_peek(&msk->skb_tx_cache);
+	if (skb) {
+		if (likely(sk_wmem_schedule(ssk, skb->truesize))) {
+			skb =3D __skb_dequeue(&msk->skb_tx_cache);
+			if (WARN_ON_ONCE(!skb))
+				return false;
+
+			mptcp_wmem_uncharge(sk, skb->truesize);
+			ssk->sk_tx_skb_cache =3D skb;
+			return true;
+		}
+
+		/* over memory limit, no point to try to allocate a new skb */
+		return false;
+	}
+
+	skb =3D __mptcp_do_alloc_tx_skb(sk);
+	if (!skb)
+		return false;
+
+	if (likely(sk_wmem_schedule(ssk, skb->truesize))) {
+		ssk->sk_tx_skb_cache =3D skb;
+		return true;
+	}
+	kfree_skb(skb);
+	return false;
+}
+
+static bool mptcp_must_reclaim_memory(struct sock *sk, struct sock *ssk)
+{
+	return !ssk->sk_tx_skb_cache &&
+	       !skb_peek(&mptcp_sk(sk)->skb_tx_cache) &&
+	       tcp_under_memory_pressure(sk);
+}
+
+static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
+{
+	if (unlikely(mptcp_must_reclaim_memory(sk, ssk)))
+		mptcp_mem_reclaim_partial(sk);
+	return __mptcp_alloc_tx_skb(sk, ssk);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1095,7 +1239,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	struct sk_buff *skb, *tail;
 	bool can_collapse =3D false;
 	int avail_size;
-	size_t ret;
+	size_t ret =3D 0;
 =

 	pr_debug("msk=3D%p ssk=3D%p sending dfrag at seq=3D%lld len=3D%d already =
sent=3D%d",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
@@ -1103,6 +1247,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	/* compute send limit */
 	info->mss_now =3D tcp_send_mss(ssk, &info->size_goal, info->flags);
 	avail_size =3D info->size_goal;
+	msk->size_goal_cache =3D info->size_goal;
 	skb =3D tcp_write_queue_tail(ssk);
 	if (skb) {
 		/* Limit the write to the size available in the
@@ -1151,8 +1296,11 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
 		goto out;
 	}
 =

-	mpext =3D __skb_ext_set(tail, SKB_EXT_MPTCP, msk->cached_ext);
-	msk->cached_ext =3D NULL;
+	mpext =3D skb_ext_find(tail, SKB_EXT_MPTCP);
+	if (WARN_ON_ONCE(!mpext)) {
+		/* should never reach here, stream corrupted */
+		return -EINVAL;
+	}
 =

 	memset(mpext, 0, sizeof(*mpext));
 	mpext->data_seq =3D data_seq;
@@ -1225,9 +1373,6 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 	sock_owned_by_me((struct sock *)msk);
 =

 	*sndbuf =3D 0;
-	if (!mptcp_ext_cache_refill(msk))
-		return NULL;
-
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
 			return NULL;
@@ -1336,6 +1481,15 @@ static void mptcp_push_pending(struct sock *sk, unsi=
gned int flags)
 			if (ssk !=3D prev_ssk || !prev_ssk)
 				lock_sock(ssk);
 =

+			/* keep it simple and always provide a new skb for the
+			 * subflow, even if we will not use it when collapsing
+			 * on the pending one
+			 */
+			if (!mptcp_alloc_tx_skb(sk, ssk)) {
+				mptcp_push_release(sk, ssk, &info);
+				goto out;
+			}
+
 			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <=3D 0) {
 				mptcp_push_release(sk, ssk, &info);
@@ -1346,6 +1500,7 @@ static void mptcp_push_pending(struct sock *sk, unsig=
ned int flags)
 			dfrag->already_sent +=3D ret;
 			msk->snd_nxt +=3D ret;
 			msk->snd_burst -=3D ret;
+			msk->tx_pending_data -=3D ret;
 			copied +=3D ret;
 			len -=3D ret;
 		}
@@ -1389,8 +1544,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	mptcp_clean_una(sk);
 =

 	while (msg_data_left(msg)) {
+		int total_ts, frag_truesize =3D 0;
 		struct mptcp_data_frag *dfrag;
-		int frag_truesize =3D 0;
+		struct sk_buff_head skbs;
 		bool dfrag_collapsed;
 		size_t psize, offset;
 =

@@ -1424,9 +1580,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 		offset =3D dfrag->offset + dfrag->data_len;
 		psize =3D pfrag->size - offset;
 		psize =3D min_t(size_t, psize, msg_data_left(msg));
-		if (!mptcp_wmem_alloc(sk, psize + frag_truesize))
+		total_ts =3D psize + frag_truesize;
+		__skb_queue_head_init(&skbs);
+		if (!mptcp_tx_cache_refill(sk, psize, &skbs, &total_ts))
 			goto wait_for_memory;
 =

+		if (!mptcp_wmem_alloc(sk, total_ts)) {
+			__skb_queue_purge(&skbs);
+			goto wait_for_memory;
+		}
+
+		skb_queue_splice_tail(&skbs, &msk->skb_tx_cache);
 		if (copy_page_from_iter(dfrag->page, offset, psize,
 					&msg->msg_iter) !=3D psize) {
 			mptcp_wmem_uncharge(sk, psize + frag_truesize);
@@ -1455,8 +1619,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
 =

-		if (!mptcp_ext_cache_refill(msk))
-			goto wait_for_memory;
 		continue;
 =

 wait_for_memory:
@@ -1468,8 +1630,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 			goto out;
 	}
 =

-	if (copied)
+	if (copied) {
+		msk->tx_pending_data +=3D copied;
 		mptcp_push_pending(sk, msg->msg_flags);
+	}
 =

 out:
 	release_sock(sk);
@@ -2052,9 +2216,6 @@ static void mptcp_worker(struct work_struct *work)
 	if (!dfrag)
 		goto unlock;
 =

-	if (!mptcp_ext_cache_refill(msk))
-		goto reset_unlock;
-
 	ssk =3D mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		goto reset_unlock;
@@ -2065,6 +2226,9 @@ static void mptcp_worker(struct work_struct *work)
 	info.sent =3D 0;
 	info.limit =3D dfrag->already_sent;
 	while (info.sent < dfrag->already_sent) {
+		if (!mptcp_alloc_tx_skb(sk, ssk))
+			break;
+
 		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 		if (ret <=3D 0)
 			break;
@@ -2072,9 +2236,6 @@ static void mptcp_worker(struct work_struct *work)
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
 		copied +=3D ret;
 		info.sent +=3D ret;
-
-		if (!mptcp_ext_cache_refill(msk))
-			break;
 	}
 	if (copied)
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
@@ -2103,10 +2264,13 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	INIT_WORK(&msk->work, mptcp_worker);
 	__skb_queue_head_init(&msk->receive_queue);
+	__skb_queue_head_init(&msk->skb_tx_cache);
 	msk->out_of_order_queue =3D RB_ROOT;
 	msk->first_pending =3D NULL;
 	msk->wmem_reserved =3D 0;
 	msk->rmem_released =3D 0;
+	msk->tx_pending_data =3D 0;
+	msk->size_goal_cache =3D TCP_BASE_MSS;
 =

 	msk->ack_hint =3D NULL;
 	msk->first =3D NULL;
@@ -2154,12 +2318,17 @@ static void __mptcp_clear_xmit(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
+	struct sk_buff *skb;
 =

 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
 =

 	WRITE_ONCE(msk->first_pending, NULL);
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(sk, dfrag);
+	while ((skb =3D __skb_dequeue(&msk->skb_tx_cache)) !=3D NULL) {
+		sk->sk_forward_alloc +=3D skb->truesize;
+		kfree_skb(skb);
+	}
 }
 =

 static void mptcp_cancel_work(struct sock *sk)
@@ -2538,9 +2707,6 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (msk->cached_ext)
-		__skb_ext_put(msk->cached_ext);
-
 	mptcp_destroy_common(msk);
 	sk_sockets_allocated_dec(sk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f49662ffb607..5997d1ca5323 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -240,11 +240,13 @@ struct mptcp_sock {
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
 	struct sk_buff_head receive_queue;
+	struct sk_buff_head skb_tx_cache;	/* this is wmem accounted */
+	int		tx_pending_data;
+	int		size_goal_cache;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
 	struct list_head join_list;
-	struct skb_ext	*cached_ext;	/* for the next sendmsg */
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
-- =

2.26.2

--===============7353450093650592730==--

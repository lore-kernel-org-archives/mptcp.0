Content-Type: multipart/mixed; boundary="===============8245328405987099151=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 06/13] mptcp: move ooo skbs into msk out
 of order queue.
Date: Mon, 14 Sep 2020 10:01:12 +0200
Message-ID: <26988dc9d753a61cd344d71d4bf16b50920913c7.1599854632.git.pabeni@redhat.com>
In-Reply-To: cover.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5838

--===============8245328405987099151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add an RB-tree to cope with OoO (at MPTCP level) data.
__mptcp_move_skb() insert into the RB tree "future"
data, eventually coalescing skb as allowed by the
MPTCP DSN.

To simplify sequence accounting, move the DSN inside
the cb.

After successfully enqueuing in sequence data, check
if we can use any data from the RB tree.

Additionally move the data_fin check after spooling
data from the OoO tree, otherwise we could miss shutdown
events.

The RB tree code is copied as verbatim as possible
from tcp_data_queue_ofo(), with a few simplifications
due to the fact that MPTCP doesn't need to cope with
sacks. All bugs here are added by me.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 264 ++++++++++++++++++++++++++++++++++---------
 net/mptcp/protocol.h |   2 +
 net/mptcp/subflow.c  |   1 +
 3 files changed, 211 insertions(+), 56 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5a2ff333e426..6fbfbab51660 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -32,6 +32,8 @@ struct mptcp6_sock {
 #endif
 =

 struct mptcp_skb_cb {
+	u64 map_seq;
+	u64 end_seq;
 	u32 offset;
 };
 =

@@ -110,6 +112,12 @@ static int __mptcp_socket_create(struct mptcp_sock *ms=
k)
 	return 0;
 }
 =

+static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
+{
+	sk_drops_add(sk, skb);
+	__kfree_skb(skb);
+}
+
 static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 			       struct sk_buff *from)
 {
@@ -120,16 +128,127 @@ static bool mptcp_try_coalesce(struct sock *sk, stru=
ct sk_buff *to,
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 =

+	MPTCP_SKB_CB(to)->end_seq =3D MPTCP_SKB_CB(from)->end_seq;
 	kfree_skb_partial(from, fragstolen);
 	atomic_add(delta, &sk->sk_rmem_alloc);
 	sk_mem_charge(sk, delta);
 	return true;
 }
 =

-static void __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
-			     struct sk_buff *skb,
-			     unsigned int offset, size_t copy_len)
+static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff =
*to,
+				   struct sk_buff *from)
+{
+	if (MPTCP_SKB_CB(from)->map_seq !=3D MPTCP_SKB_CB(to)->end_seq)
+		return false;
+
+	return mptcp_try_coalesce((struct sock *)msk, to, from);
+}
+
+/* "inspired" by tcp_data_queue_ofo(), main differences:
+ * - use mptcp seqs
+ * - don't cope with sacks
+ */
+static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *s=
kb)
 {
+	struct sock *sk =3D (struct sock *)msk;
+	struct rb_node **p, *parent;
+	u64 seq, end_seq, max_seq;
+	struct sk_buff *skb1;
+
+	seq =3D MPTCP_SKB_CB(skb)->map_seq;
+	end_seq =3D MPTCP_SKB_CB(skb)->end_seq;
+	max_seq =3D tcp_space(sk);
+	max_seq =3D max_seq > 0 ? max_seq + msk->ack_seq : msk->ack_seq;
+
+	if (after64(seq, max_seq)) {
+		/* out of window */
+		mptcp_drop(sk, skb);
+		return;
+	}
+
+	p =3D &msk->out_of_order_queue.rb_node;
+	if (RB_EMPTY_ROOT(&msk->out_of_order_queue)) {
+		rb_link_node(&skb->rbnode, NULL, p);
+		rb_insert_color(&skb->rbnode, &msk->out_of_order_queue);
+		msk->ooo_last_skb =3D skb;
+		goto end;
+	}
+
+	/* with 2 subflows, adding at end of ooo queue is quite likely
+	 * Use of ooo_last_skb avoids the O(Log(N)) rbtree lookup.
+	 */
+	if (mptcp_ooo_try_coalesce(msk, msk->ooo_last_skb, skb))
+		return;
+
+	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
+	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+		parent =3D &msk->ooo_last_skb->rbnode;
+		p =3D &parent->rb_right;
+		goto insert;
+	}
+
+	/* Find place to insert this segment. Handle overlaps on the way. */
+	parent =3D NULL;
+	while (*p) {
+		parent =3D *p;
+		skb1 =3D rb_to_skb(parent);
+		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
+			p =3D &parent->rb_left;
+			continue;
+		}
+		if (before64(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
+			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
+				/* All the bits are present. Drop. */
+				mptcp_drop(sk, skb);
+				return;
+			}
+			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
+				/* partial overlap:
+				 *     |     skb      |
+				 *  |     skb1    |
+				 * continue traversing
+				 */
+			} else {
+				/* skb's seq =3D=3D skb1's seq and skb covers skb1.
+				 * Replace skb1 with skb.
+				 */
+				rb_replace_node(&skb1->rbnode, &skb->rbnode,
+						&msk->out_of_order_queue);
+				mptcp_drop(sk, skb1);
+				goto merge_right;
+			}
+		} else if (mptcp_ooo_try_coalesce(msk, skb1, skb)) {
+			return;
+		}
+		p =3D &parent->rb_right;
+	}
+insert:
+	/* Insert segment into RB tree. */
+	rb_link_node(&skb->rbnode, parent, p);
+	rb_insert_color(&skb->rbnode, &msk->out_of_order_queue);
+
+merge_right:
+	/* Remove other segments covered by skb. */
+	while ((skb1 =3D skb_rb_next(skb)) !=3D NULL) {
+		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
+			break;
+		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
+		mptcp_drop(sk, skb1);
+	}
+	/* If there is no skb after us, we are the last_skb ! */
+	if (!skb1)
+		msk->ooo_last_skb =3D skb;
+
+end:
+	skb_condense(skb);
+	skb_set_owner_r(skb, sk);
+}
+
+static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
+			     struct sk_buff *skb, unsigned int offset,
+			     size_t copy_len)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct sock *sk =3D (struct sock *)msk;
 	struct sk_buff *tail;
 =

@@ -137,15 +256,35 @@ static void __mptcp_move_skb(struct mptcp_sock *msk, =
struct sock *ssk,
 =

 	skb_ext_reset(skb);
 	skb_orphan(skb);
+
+	/* the skb map_seq accounts for the skb offset:
+	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
+	 * value
+	 */
+	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset =3D offset;
-	msk->ack_seq +=3D copy_len;
 =

-	tail =3D skb_peek_tail(&sk->sk_receive_queue);
-	if (tail && mptcp_try_coalesce(sk, tail, skb))
-		return;
+	if (MPTCP_SKB_CB(skb)->map_seq =3D=3D msk->ack_seq) {
+		/* in sequence */
+		msk->ack_seq +=3D copy_len;
+		tail =3D skb_peek_tail(&sk->sk_receive_queue);
+		if (tail && mptcp_try_coalesce(sk, tail, skb))
+			return true;
 =

-	skb_set_owner_r(skb, sk);
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
+		skb_set_owner_r(skb, sk);
+		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		return true;
+	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
+		mptcp_data_queue_ofo(msk, skb);
+		return false;
+	}
+
+	/* old data, keep it simple and drop the whole pkt, sender
+	 * will retransmit as needed, if needed.
+	 */
+	mptcp_drop(sk, skb);
+	return false;
 }
 =

 static void mptcp_stop_timer(struct sock *sk)
@@ -156,28 +295,6 @@ static void mptcp_stop_timer(struct sock *sk)
 	mptcp_sk(sk)->timer_ival =3D 0;
 }
 =

-/* both sockets must be locked */
-static bool mptcp_subflow_dsn_valid(const struct mptcp_sock *msk,
-				    struct sock *ssk)
-{
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
-	u64 dsn =3D mptcp_subflow_get_mapped_dsn(subflow);
-
-	/* revalidate data sequence number.
-	 *
-	 * mptcp_subflow_data_available() is usually called
-	 * without msk lock.  Its unlikely (but possible)
-	 * that msk->ack_seq has been advanced since the last
-	 * call found in-sequence data.
-	 */
-	if (likely(dsn =3D=3D msk->ack_seq))
-		return true;
-
-	subflow->data_avail =3D 0;
-	mptcp_subflow_data_available(ssk);
-	return subflow->data_avail =3D=3D MPTCP_SUBFLOW_DATA_AVAIL;
-}
-
 static void mptcp_check_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -321,18 +438,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 	struct tcp_sock *tp;
 	bool done =3D false;
 =

-	pr_debug("msk=3D%p ssk=3D%p data avail=3D%d valid=3D%d empty=3D%d",
-		 msk, ssk, subflow->data_avail,
-		 mptcp_subflow_dsn_valid(msk, ssk),
-		 !skb_peek(&ssk->sk_receive_queue));
-	if (subflow->data_avail =3D=3D MPTCP_SUBFLOW_OOO_DATA) {
-		mptcp_subflow_discard_data(ssk, subflow->map_data_len);
-		return false;
-	}
-
-	if (!mptcp_subflow_dsn_valid(msk, ssk))
-		return false;
-
+	pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
 	tp =3D tcp_sk(ssk);
 	do {
 		u32 map_remaining, offset;
@@ -370,9 +476,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 			if (tp->urg_data)
 				done =3D true;
 =

-			__mptcp_move_skb(msk, ssk, skb, offset, len);
+			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
+				moved +=3D len;
 			seq +=3D len;
-			moved +=3D len;
 =

 			if (WARN_ON_ONCE(map_remaining < len))
 				break;
@@ -393,18 +499,47 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
 =

 	*bytes +=3D moved;
 =

-	/* If the moves have caught up with the DATA_FIN sequence number
-	 * it's time to ack the DATA_FIN and change socket state, but
-	 * this is not a good place to change state. Let the workqueue
-	 * do it.
-	 */
-	if (mptcp_pending_data_fin(sk, NULL) &&
-	    schedule_work(&msk->work))
-		sock_hold(sk);
-
 	return done;
 }
 =

+static bool mptcp_ofo_queue(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct sk_buff *skb, *tail;
+	bool moved =3D false;
+	struct rb_node *p;
+	u64 end_seq;
+
+	p =3D rb_first(&msk->out_of_order_queue);
+	while (p) {
+		skb =3D rb_to_skb(p);
+		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
+			break;
+
+		p =3D rb_next(p);
+		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
+
+		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq,
+				      msk->ack_seq))) {
+			mptcp_drop(sk, skb);
+			continue;
+		}
+
+		end_seq =3D MPTCP_SKB_CB(skb)->end_seq;
+		tail =3D skb_peek_tail(&sk->sk_receive_queue);
+		if (!tail || !mptcp_ooo_try_coalesce(msk, tail, skb)) {
+			int delta =3D msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+
+			/* skip overlapping data, if any */
+			MPTCP_SKB_CB(skb)->offset +=3D delta;
+			__skb_queue_tail(&sk->sk_receive_queue, skb);
+		}
+		msk->ack_seq =3D end_seq;
+		moved =3D true;
+	}
+	return moved;
+}
+
 /* In most cases we will be able to lock the mptcp socket.  If its already
  * owned, we need to defer to the work queue to avoid ABBA deadlock.
  */
@@ -420,8 +555,19 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, s=
truct sock *ssk)
 		return false;
 =

 	/* must re-check after taking the lock */
-	if (!READ_ONCE(sk->sk_lock.owned))
+	if (!READ_ONCE(sk->sk_lock.owned)) {
 		__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+		mptcp_ofo_queue(msk);
+
+		/* If the moves have caught up with the DATA_FIN sequence number
+		 * it's time to ack the DATA_FIN and change socket state, but
+		 * this is not a good place to change state. Let the workqueue
+		 * do it.
+		 */
+		if (mptcp_pending_data_fin(sk, NULL) &&
+		    schedule_work(&msk->work))
+			sock_hold(sk);
+	}
 =

 	spin_unlock_bh(&sk->sk_lock.slock);
 =

@@ -1218,7 +1364,11 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 		release_sock(ssk);
 	} while (!done);
 =

-	return moved > 0;
+	if (mptcp_ofo_queue(msk) || moved > 0) {
+		mptcp_check_data_fin((struct sock *)msk);
+		return true;
+	}
+	return false;
 }
 =

 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -1530,6 +1680,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 	INIT_WORK(&msk->work, mptcp_worker);
+	msk->out_of_order_queue =3D RB_ROOT;
 =

 	msk->first =3D NULL;
 	inet_csk(sk)->icsk_sync_mss =3D mptcp_sync_mss;
@@ -1869,6 +2020,7 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

+	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_token_destroy(msk);
 	if (msk->cached_ext)
 		__skb_ext_put(msk->cached_ext);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 794997852c5e..0a602acf1f3d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -204,6 +204,8 @@ struct mptcp_sock {
 	bool		snd_data_fin_enable;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
+	struct sk_buff  *ooo_last_skb;
+	struct rb_root  out_of_order_queue;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct list_head join_list;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 071ee54b3c9f..0b1d73a69daf 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -434,6 +434,7 @@ static void mptcp_sock_destruct(struct sock *sk)
 		sock_orphan(sk);
 	}
 =

+	skb_rbtree_purge(&mptcp_sk(sk)->out_of_order_queue);
 	mptcp_token_destroy(mptcp_sk(sk));
 	inet_sock_destruct(sk);
 }
-- =

2.26.2

--===============8245328405987099151==--

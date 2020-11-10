Content-Type: multipart/mixed; boundary="===============6100319221058228024=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/6] mptcp: protect the rx path with the msk
 socket spinlock
Date: Tue, 10 Nov 2020 12:25:44 +0100
Message-ID: <d1779b7594d19cfcf84a64e11726f190f14bfa6c.1605006569.git.pabeni@redhat.com>
In-Reply-To: cover.1605006569.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6647

--===============6100319221058228024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Such spinlock is currently used only to protect the 'owned'
flag inside the socket lock itself. With this patch we extend
it's scope to protect the whole msk receive path and
sk_forward_memory.

Given the above we can always move data into the msk receive queue
(and OoO queue) from the subflow.

We leverage the previous commit, so that we need to acquire the
spinlock in the tx path only when moving fwd memory
to wfwd and vice versa.

recvmsg() must now explicitly acquire the socket spinlock
when moving skbs out of sk_receive_queue. We use a snd rx
queue and splice the first into the latter to reduce the number locks
required.

Signed-off-by: <pabeni(a)redhat.com>
---
- add __mptcp_mem_reclaim_partial() variant
---
 net/mptcp/protocol.c | 158 +++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |   4 ++
 2 files changed, 113 insertions(+), 49 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7000560c0cd9..c6370aa58ecb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -270,7 +270,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk=
, struct sk_buff *skb)
 =

 end:
 	skb_condense(skb);
-	skb_set_owner_r(skb, sk);
+	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
+	sk_mem_charge(sk, skb->truesize);
 }
 =

 static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
@@ -310,7 +311,8 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, st=
ruct sock *ssk,
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
 			return true;
 =

-		skb_set_owner_r(skb, sk);
+		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
+		sk_mem_charge(sk, skb->truesize);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
 	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
@@ -600,7 +602,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 	return done;
 }
 =

-static bool mptcp_ofo_queue(struct mptcp_sock *msk)
+static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	struct sk_buff *skb, *tail;
@@ -646,34 +648,24 @@ static bool mptcp_ofo_queue(struct mptcp_sock *msk)
 /* In most cases we will be able to lock the mptcp socket.  If its already
  * owned, we need to defer to the work queue to avoid ABBA deadlock.
  */
-static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
+static void move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	unsigned int moved =3D 0;
 =

-	if (READ_ONCE(sk->sk_lock.owned))
-		return false;
-
-	if (unlikely(!spin_trylock_bh(&sk->sk_lock.slock)))
-		return false;
+	mptcp_data_lock(sk);
 =

-	/* must re-check after taking the lock */
-	if (!READ_ONCE(sk->sk_lock.owned)) {
-		__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
-		mptcp_ofo_queue(msk);
-
-		/* If the moves have caught up with the DATA_FIN sequence number
-		 * it's time to ack the DATA_FIN and change socket state, but
-		 * this is not a good place to change state. Let the workqueue
-		 * do it.
-		 */
-		if (mptcp_pending_data_fin(sk, NULL))
-			mptcp_schedule_work(sk);
-	}
+	__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+	__mptcp_ofo_queue(msk);
 =

-	spin_unlock_bh(&sk->sk_lock.slock);
-
-	return moved > 0;
+	/* If the moves have caught up with the DATA_FIN sequence number
+	 * it's time to ack the DATA_FIN and change socket state, but
+	 * this is not a good place to change state. Let the workqueue
+	 * do it.
+	 */
+	if (mptcp_pending_data_fin(sk, NULL))
+		mptcp_schedule_work(sk);
+	mptcp_data_unlock(sk);
 }
 =

 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
@@ -849,14 +841,18 @@ static bool mptcp_wmem_alloc(struct sock *sk, int siz=
e)
 	if (msk->wforward_alloc >=3D size)
 		goto account;
 =

+	mptcp_data_lock(sk);
 	ret =3D sk_wmem_schedule(sk, size);
-	if (!ret)
+	if (!ret) {
+		mptcp_data_unlock(sk);
 		return false;
+	}
 =

 	/* try to keep half fwd alloc memory for each direction */
 	amount =3D max(size, sk->sk_forward_alloc >> 1);
 	sk->sk_forward_alloc -=3D amount;
 	msk->wforward_alloc +=3D amount;
+	mptcp_data_unlock(sk);
 =

 account:
 	msk->wforward_alloc -=3D size;
@@ -868,12 +864,11 @@ static void mptcp_wmem_uncharge(struct sock *sk, int =
size)
 	mptcp_sk(sk)->wforward_alloc +=3D size;
 }
 =

-static void mptcp_mem_reclaim_partial(struct sock *sk)
+static void __mptcp_mem_reclaim_partial(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	sk->sk_forward_alloc +=3D msk->wforward_alloc;
-	msk->wforward_alloc =3D 0;
 	sk_mem_reclaim_partial(sk);
 =

 	/* split the remaining fwd allocated memory between rx and tx */
@@ -881,6 +876,13 @@ static void mptcp_mem_reclaim_partial(struct sock *sk)
 	sk->sk_forward_alloc -=3D msk->wforward_alloc;
 }
 =

+static void mptcp_mem_reclaim_partial(struct sock *sk)
+{
+	mptcp_data_lock(sk);
+	__mptcp_mem_reclaim_partial(sk);
+	mptcp_data_unlock(sk);
+}
+
 static void dfrag_uncharge(struct sock *sk, int len)
 {
 	mptcp_wmem_uncharge(sk, len);
@@ -1432,13 +1434,12 @@ static void mptcp_wait_data(struct sock *sk, long *=
timeo)
 =

 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
-				size_t len)
+				size_t len, int *released)
 {
-	struct sock *sk =3D (struct sock *)msk;
 	struct sk_buff *skb;
 	int copied =3D 0;
 =

-	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
+	while ((skb =3D skb_peek(&msk->receive_queue)) !=3D NULL) {
 		u32 offset =3D MPTCP_SKB_CB(skb)->offset;
 		u32 data_len =3D skb->len - offset;
 		u32 count =3D min_t(size_t, len - copied, data_len);
@@ -1458,7 +1459,8 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *ms=
k,
 			break;
 		}
 =

-		__skb_unlink(skb, &sk->sk_receive_queue);
+		*released +=3D skb->truesize;
+		__skb_unlink(skb, &msk->receive_queue);
 		__kfree_skb(skb);
 =

 		if (copied >=3D len)
@@ -1566,25 +1568,49 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
k *msk, int copied)
 	msk->rcvq_space.time =3D mstamp;
 }
 =

-static bool __mptcp_move_skbs(struct mptcp_sock *msk, unsigned int rcv)
+static void __mptcp_update_rmem(struct sock *sk, int *released)
+{
+	sk_mem_uncharge(sk, *released);
+	atomic_sub(*released, &sk->sk_rmem_alloc);
+	*released =3D 0;
+}
+
+static void mptcp_update_rmem(struct sock *sk, int *released)
 {
+	if (!released)
+		return;
+
+	mptcp_data_lock(sk);
+	__mptcp_update_rmem(sk, released);
+	mptcp_data_unlock(sk);
+}
+
+static bool __mptcp_move_skbs(struct mptcp_sock *msk, unsigned int rcv, in=
t *released)
+{
+	struct sock *sk =3D (struct sock *)msk;
 	unsigned int moved =3D 0;
-	bool done;
+	bool ret, done;
 =

 	/* avoid looping forever below on racing close */
-	if (((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE)
-		return false;
+	if (sk->sk_state =3D=3D TCP_CLOSE)
+		goto chk_splice;
 =

 	__mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
 		bool slowpath;
 =

-		if (!ssk)
+		/* we can have data pending in the subflows only if the msk
+		 * receive buffer was full at subflow_data_ready() time,
+		 * it is an likely slow path
+		 */
+		if (likely(!ssk))
 			break;
 =

 		slowpath =3D lock_sock_fast(ssk);
+		mptcp_data_lock(sk);
 		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+		mptcp_data_unlock(sk);
 		if (moved && rcv) {
 			WRITE_ONCE(msk->rmem_pending, min(rcv, moved));
 			tcp_cleanup_rbuf(ssk, 1);
@@ -1593,17 +1619,28 @@ static bool __mptcp_move_skbs(struct mptcp_sock *ms=
k, unsigned int rcv)
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 =

-	if (mptcp_ofo_queue(msk) || moved > 0) {
-		mptcp_check_data_fin((struct sock *)msk);
-		return true;
+chk_splice:
+	/* acquire the data lock only if some input data is pending */
+	ret =3D moved > 0;
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
+	    !skb_queue_empty_lockless(&sk->sk_receive_queue)) {
+		mptcp_data_lock(sk);
+		__mptcp_update_rmem(sk, released);
+		ret |=3D __mptcp_ofo_queue(msk);
+		skb_queue_splice_tail_init(&sk->sk_receive_queue,
+					   &msk->receive_queue);
+		mptcp_data_unlock(sk);
 	}
-	return false;
+	if (ret)
+		mptcp_check_data_fin((struct sock *)msk);
+	return !skb_queue_empty(&msk->receive_queue);
 }
 =

 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	int released =3D 0;
 	int copied =3D 0;
 	int target;
 	long timeo;
@@ -1621,7 +1658,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 	for (;;) {
 		int bytes_read, old_space;
 =

-		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
+		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied,
+						  &released);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied =3D bytes_read;
@@ -1630,8 +1668,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 =

 		copied +=3D bytes_read;
 =

-		if (skb_queue_empty(&sk->sk_receive_queue) &&
-		    __mptcp_move_skbs(msk, len - copied))
+		if (skb_queue_empty(&msk->receive_queue) &&
+		    __mptcp_move_skbs(msk, len - copied, &released))
 			continue;
 =

 		/* be sure to advertize window change */
@@ -1661,8 +1699,15 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
 			if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 				mptcp_check_for_eof(msk);
 =

-			if (sk->sk_shutdown & RCV_SHUTDOWN)
+			if (sk->sk_shutdown & RCV_SHUTDOWN) {
+				/* race breaker: the shutdown could be after the
+				 * previous receive queue check
+				 */
+				if (__mptcp_move_skbs(msk, len - copied,
+						      &released))
+					continue;
 				break;
+			}
 =

 			if (sk->sk_state =3D=3D TCP_CLOSE) {
 				copied =3D -ENOTCONN;
@@ -1681,26 +1726,29 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
 		}
 =

 		pr_debug("block timeout %ld", timeo);
+		mptcp_update_rmem(sk, &released);
 		mptcp_wait_data(sk, &timeo);
 	}
 =

-	if (skb_queue_empty(&sk->sk_receive_queue)) {
+	if (skb_queue_empty_lockless(&sk->sk_receive_queue) &&
+	    skb_queue_empty(&msk->receive_queue)) {
 		/* entire backlog drained, clear DATA_READY. */
 		clear_bit(MPTCP_DATA_READY, &msk->flags);
 =

 		/* .. race-breaker: ssk might have gotten new data
 		 * after last __mptcp_move_skbs() returned false.
 		 */
-		if (unlikely(__mptcp_move_skbs(msk, 0)))
+		if (unlikely(__mptcp_move_skbs(msk, 0, &released)))
 			set_bit(MPTCP_DATA_READY, &msk->flags);
 	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
 		/* data to read but mptcp_wait_data() cleared DATA_READY */
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
 out_err:
+	mptcp_update_rmem(sk, &released);
 	pr_debug("msk=3D%p data_ready=3D%d rx queue empty=3D%d copied=3D%d",
 		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
-		 skb_queue_empty(&sk->sk_receive_queue), copied);
+		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
 	mptcp_rcv_space_adjust(msk, copied);
 =

 	release_sock(sk);
@@ -2004,6 +2052,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	INIT_WORK(&msk->work, mptcp_worker);
+	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue =3D RB_ROOT;
 	msk->first_pending =3D NULL;
 	msk->wforward_alloc =3D 0;
@@ -2200,6 +2249,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk->sk_forward_alloc +=3D msk->wforward_alloc;
 	msk->wforward_alloc =3D 0;
 	sk_stream_kill_queues(sk);
+
 	xfrm_sk_free_policy(sk);
 	sk_refcnt_debug_release(sk);
 	sock_put(sk);
@@ -2422,7 +2472,17 @@ static struct sock *mptcp_accept(struct sock *sk, in=
t flags, int *err,
 =

 void mptcp_destroy_common(struct mptcp_sock *msk)
 {
-	skb_rbtree_purge(&msk->out_of_order_queue);
+	struct sock *sk =3D (struct sock *)msk;
+	struct sk_buff *skb;
+	int queued =3D 0;
+
+	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
+	while ((skb =3D __skb_dequeue(&msk->receive_queue)) !=3D NULL) {
+		queued +=3D skb->truesize;
+		kfree_skb(skb);
+	}
+	queued +=3D skb_rbtree_purge(&msk->out_of_order_queue);
+	__mptcp_update_rmem(sk, &queued);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2a842d228950..a7107a70badd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -239,6 +239,7 @@ struct mptcp_sock {
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
+	struct sk_buff_head receive_queue;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
@@ -255,6 +256,9 @@ struct mptcp_sock {
 	} rcvq_space;
 };
 =

+#define mptcp_data_lock(sk) spin_lock_bh(&sk->sk_lock.slock)
+#define mptcp_data_unlock(sk) spin_unlock_bh(&sk->sk_lock.slock)
+
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 =

-- =

2.26.2

--===============6100319221058228024==--

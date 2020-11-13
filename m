Content-Type: multipart/mixed; boundary="===============7516496080937048199=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/6] mptcp: protect the rx path with the msk socket
 spinlock
Date: Fri, 13 Nov 2020 17:27:32 +0100
Message-ID: <1fcf0844bb7648ad703114d36558a89ea16e601c.1605283958.git.pabeni@redhat.com>
In-Reply-To: cover.1605283958.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6717

--===============7516496080937048199==
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
when moving skbs out of sk_receive_queue. We use a second rx
queue and splice the first into the latter to reduce the number locks
required.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - keep skb->destructor set for skbs in the msk receive queue
   and clear it at dequeue time. This simplify rmem accounting
   and reduces the deltas
 - added {READ,WRITE}_ONCE annotation for ack_hint
 - drop no-more-needed check in __mptcp_move_skbs(): we are always
   called under socket lock and can't race anymore with close
---
 net/mptcp/protocol.c | 148 +++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |   4 ++
 2 files changed, 103 insertions(+), 49 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 87d8659b9bcc..915d69957227 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -446,7 +446,7 @@ static void mptcp_send_ack(struct mptcp_sock *msk, bool=
 force)
 =

 		/* if the hintes ssk is still active, use it */
 		pick =3D ssk;
-		if (ssk =3D=3D msk->ack_hint)
+		if (ssk =3D=3D READ_ONCE(msk->ack_hint))
 			break;
 	}
 	if (!force && pick) {
@@ -606,13 +606,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
 			break;
 		}
 	} while (more_data_avail);
-	msk->ack_hint =3D ssk;
+	WRITE_ONCE(msk->ack_hint, ssk);
 =

 	*bytes +=3D moved;
 	return done;
 }
 =

-static bool mptcp_ofo_queue(struct mptcp_sock *msk)
+static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	struct sk_buff *skb, *tail;
@@ -658,34 +658,27 @@ static bool mptcp_ofo_queue(struct mptcp_sock *msk)
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
-
-	/* must re-check after taking the lock */
-	if (!READ_ONCE(sk->sk_lock.owned)) {
-		__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
-		mptcp_ofo_queue(msk);
+	if (inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
+		return;
 =

-		/* If the moves have caught up with the DATA_FIN sequence number
-		 * it's time to ack the DATA_FIN and change socket state, but
-		 * this is not a good place to change state. Let the workqueue
-		 * do it.
-		 */
-		if (mptcp_pending_data_fin(sk, NULL))
-			mptcp_schedule_work(sk);
-	}
+	mptcp_data_lock(sk);
 =

-	spin_unlock_bh(&sk->sk_lock.slock);
+	__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+	__mptcp_ofo_queue(msk);
 =

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
@@ -860,13 +853,17 @@ static bool mptcp_wmem_alloc(struct sock *sk, int siz=
e)
 	if (msk->wforward_alloc >=3D size)
 		goto account;
 =

-	if (!sk_wmem_schedule(sk, size))
+	mptcp_data_lock(sk);
+	if (!sk_wmem_schedule(sk, size)) {
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
@@ -878,12 +875,11 @@ static void mptcp_wmem_uncharge(struct sock *sk, int =
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
@@ -891,6 +887,13 @@ static void mptcp_mem_reclaim_partial(struct sock *sk)
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
@@ -1442,13 +1445,12 @@ static void mptcp_wait_data(struct sock *sk, long *=
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
@@ -1468,7 +1470,10 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *m=
sk,
 			break;
 		}
 =

-		__skb_unlink(skb, &sk->sk_receive_queue);
+		/* we will bulk release the skb memory later */
+		skb->destructor =3D NULL;
+		*released +=3D skb->truesize;
+		__skb_unlink(skb, &msk->receive_queue);
 		__kfree_skb(skb);
 =

 		if (copied >=3D len)
@@ -1576,25 +1581,45 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
k *msk, int copied)
 	msk->rcvq_space.time =3D mstamp;
 }
 =

-static bool __mptcp_move_skbs(struct mptcp_sock *msk, unsigned int rcv)
+static void __mptcp_update_rmem(struct sock *sk, int *released)
 {
-	unsigned int moved =3D 0;
-	bool done;
+	atomic_sub(*released, &sk->sk_rmem_alloc);
+	sk_mem_uncharge(sk, *released);
+	*released =3D 0;
+}
 =

-	/* avoid looping forever below on racing close */
-	if (((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE)
-		return false;
+static void mptcp_update_rmem(struct sock *sk, int *released)
+{
+	if (!*released)
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
+	unsigned int moved =3D 0;
+	bool ret, done;
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
@@ -1603,17 +1628,27 @@ static bool __mptcp_move_skbs(struct mptcp_sock *ms=
k, unsigned int rcv)
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 =

-	if (mptcp_ofo_queue(msk) || moved > 0) {
-		mptcp_check_data_fin((struct sock *)msk);
-		return true;
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
@@ -1631,7 +1666,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
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
@@ -1640,8 +1676,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
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
@@ -1671,8 +1707,15 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
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
@@ -1691,26 +1734,29 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
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
@@ -2014,6 +2060,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	INIT_WORK(&msk->work, mptcp_worker);
+	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue =3D RB_ROOT;
 	msk->first_pending =3D NULL;
 	msk->wforward_alloc =3D 0;
@@ -2428,6 +2475,9 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 =

 void mptcp_destroy_common(struct mptcp_sock *msk)
 {
+	struct sock *sk =3D (struct sock *)msk;
+
+	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2a842d228950..54d5d117ae28 100644
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

+#define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
+#define mptcp_data_unlock(sk) spin_unlock_bh(&(sk)->sk_lock.slock)
+
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 =

-- =

2.26.2

--===============7516496080937048199==--

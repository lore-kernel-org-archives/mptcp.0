Content-Type: multipart/mixed; boundary="===============5733738639968324631=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 3/7] mptcp: protect the rx path with the msk socket
 spinlock
Date: Wed, 18 Nov 2020 23:30:12 +0100
Message-ID: <a8611a9dc47eedc6d6ee26486ed2d9ea3ee5d1cc.1605737933.git.pabeni@redhat.com>
In-Reply-To: cover.1605737932.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6799

--===============5733738639968324631==
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
spinlock in the tx path only when moving fwd memory.

recvmsg() must now explicitly acquire the socket spinlock
when moving skbs out of sk_receive_queue. To reduce the numnber of
lock operation required we use a second rx queue and splice the
first into the latter in mptcp_lock_sock(). Additionally rmem
allocated memory is bulk-freed via release_cb()

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v2 -> v3:
 - use an msk variable to track rmem bulk free
 - use release_cb()/mptcp_lock_sock() to avoid a couple of
   data lock contentions.
v1 -> v2:
 - keep skb->destructor set for skbs in the msk receive queue
   and clear it at dequeue time. This simplify rmem accounting
   and reduces the deltas
 - added {READ,WRITE}_ONCE annotation for ack_hint
 - drop no-more-needed check in __mptcp_move_skbs(): we are always
   called under socket lock and can't race anymore with close
---
 net/mptcp/protocol.c | 142 +++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |   5 ++
 2 files changed, 103 insertions(+), 44 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 44751ea02e54..3074e0720110 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -448,7 +448,7 @@ static void mptcp_send_ack(struct mptcp_sock *msk, bool=
 force)
 =

 		/* if the hintes ssk is still active, use it */
 		pick =3D ssk;
-		if (ssk =3D=3D msk->ack_hint)
+		if (ssk =3D=3D READ_ONCE(msk->ack_hint))
 			break;
 	}
 	if (!force && pick) {
@@ -600,13 +600,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
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
@@ -652,34 +652,27 @@ static bool mptcp_ofo_queue(struct mptcp_sock *msk)
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
@@ -923,17 +916,30 @@ static bool mptcp_wmem_alloc(struct sock *sk, int siz=
e)
 	if (msk->wmem_reserved >=3D size)
 		goto account;
 =

-	if (!sk_wmem_schedule(sk, size))
+	mptcp_data_lock(sk);
+	if (!sk_wmem_schedule(sk, size)) {
+		mptcp_data_unlock(sk);
 		return false;
+	}
 =

 	sk->sk_forward_alloc -=3D size;
 	msk->wmem_reserved +=3D size;
+	mptcp_data_unlock(sk);
 =

 account:
 	msk->wmem_reserved -=3D size;
 	return true;
 }
 =

+static void mptcp_wmem_uncharge(struct sock *sk, int size)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (msk->wmem_reserved < 0)
+		msk->wmem_reserved =3D 0;
+	msk->wmem_reserved +=3D size;
+}
+
 static void dfrag_uncharge(struct sock *sk, int len)
 {
 	sk_mem_uncharge(sk, len);
@@ -962,6 +968,7 @@ static void mptcp_clean_una(struct sock *sk)
 	if (__mptcp_check_fallback(msk))
 		atomic64_set(&msk->snd_una, msk->snd_nxt);
 =

+	mptcp_data_lock(sk);
 	snd_una =3D atomic64_read(&msk->snd_una);
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
@@ -993,6 +1000,7 @@ static void mptcp_clean_una(struct sock *sk)
 out:
 	if (cleaned && tcp_under_memory_pressure(sk))
 		sk_mem_reclaim_partial(sk);
+	mptcp_data_unlock(sk);
 }
 =

 static void mptcp_clean_una_wakeup(struct sock *sk)
@@ -1421,7 +1429,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 		if (copy_page_from_iter(dfrag->page, offset, psize,
 					&msg->msg_iter) !=3D psize) {
-			msk->wmem_reserved +=3D psize + frag_truesize;
+			mptcp_wmem_uncharge(sk, psize + frag_truesize);
 			ret =3D -EFAULT;
 			goto out;
 		}
@@ -1487,11 +1495,10 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *=
msk,
 				struct msghdr *msg,
 				size_t len)
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
@@ -1511,7 +1518,10 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *m=
sk,
 			break;
 		}
 =

-		__skb_unlink(skb, &sk->sk_receive_queue);
+		/* we will bulk release the skb memory later */
+		skb->destructor =3D NULL;
+		msk->rmem_released +=3D skb->truesize;
+		__skb_unlink(skb, &msk->receive_queue);
 		__kfree_skb(skb);
 =

 		if (copied >=3D len)
@@ -1619,25 +1629,47 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
k *msk, int copied)
 	msk->rcvq_space.time =3D mstamp;
 }
 =

+static void __mptcp_update_rmem(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (!msk->rmem_released)
+		return;
+
+	atomic_sub(msk->rmem_released, &sk->sk_rmem_alloc);
+	sk_mem_uncharge(sk, msk->rmem_released);
+	msk->rmem_released =3D 0;
+}
+
+static void __mptcp_splice_receive_queue(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
+}
+
 static bool __mptcp_move_skbs(struct mptcp_sock *msk, unsigned int rcv)
 {
+	struct sock *sk =3D (struct sock *)msk;
 	unsigned int moved =3D 0;
-	bool done;
-
-	/* avoid looping forever below on racing close */
-	if (((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE)
-		return false;
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
@@ -1646,11 +1678,19 @@ static bool __mptcp_move_skbs(struct mptcp_sock *ms=
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
+		__mptcp_update_rmem(sk);
+		ret |=3D __mptcp_ofo_queue(msk);
+		__mptcp_splice_receive_queue(sk);
+		mptcp_data_unlock(sk);
 	}
-	return false;
+	if (ret)
+		mptcp_check_data_fin((struct sock *)msk);
+	return !skb_queue_empty(&msk->receive_queue);
 }
 =

 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -1664,7 +1704,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
 		return -EOPNOTSUPP;
 =

-	lock_sock(sk);
+	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
 	timeo =3D sock_rcvtimeo(sk, nonblock);
 =

 	len =3D min_t(size_t, len, INT_MAX);
@@ -1683,7 +1723,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 =

 		copied +=3D bytes_read;
 =

-		if (skb_queue_empty(&sk->sk_receive_queue) &&
+		if (skb_queue_empty(&msk->receive_queue) &&
 		    __mptcp_move_skbs(msk, len - copied))
 			continue;
 =

@@ -1714,8 +1754,14 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
 			if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 				mptcp_check_for_eof(msk);
 =

-			if (sk->sk_shutdown & RCV_SHUTDOWN)
+			if (sk->sk_shutdown & RCV_SHUTDOWN) {
+				/* race breaker: the shutdown could be after the
+				 * previous receive queue check
+				 */
+				if (__mptcp_move_skbs(msk, len - copied))
+					continue;
 				break;
+			}
 =

 			if (sk->sk_state =3D=3D TCP_CLOSE) {
 				copied =3D -ENOTCONN;
@@ -1737,7 +1783,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		mptcp_wait_data(sk, &timeo);
 	}
 =

-	if (skb_queue_empty(&sk->sk_receive_queue)) {
+	if (skb_queue_empty_lockless(&sk->sk_receive_queue) &&
+	    skb_queue_empty(&msk->receive_queue)) {
 		/* entire backlog drained, clear DATA_READY. */
 		clear_bit(MPTCP_DATA_READY, &msk->flags);
 =

@@ -1753,7 +1800,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 out_err:
 	pr_debug("msk=3D%p data_ready=3D%d rx queue empty=3D%d copied=3D%d",
 		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
-		 skb_queue_empty(&sk->sk_receive_queue), copied);
+		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
 	mptcp_rcv_space_adjust(msk, copied);
 =

 	release_sock(sk);
@@ -2055,9 +2102,11 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	INIT_WORK(&msk->work, mptcp_worker);
+	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue =3D RB_ROOT;
 	msk->first_pending =3D NULL;
 	msk->wmem_reserved =3D 0;
+	msk->rmem_released =3D 0;
 =

 	msk->ack_hint =3D NULL;
 	msk->first =3D NULL;
@@ -2257,6 +2306,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk->sk_prot->destroy(sk);
 =

 	WARN_ON_ONCE(msk->wmem_reserved);
+	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 	sk_refcnt_debug_release(sk);
@@ -2476,6 +2526,9 @@ static struct sock *mptcp_accept(struct sock *sk, int=
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
@@ -2611,6 +2664,7 @@ static void mptcp_release_cb(struct sock *sk)
 =

 	/* clear any wmem reservation and errors */
 	__mptcp_update_wmem(sk);
+	__mptcp_update_rmem(sk);
 =

 	do {
 		flags =3D sk->sk_tsq_flags;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4d7d14ea0fb0..f49662ffb607 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -227,6 +227,7 @@ struct mptcp_sock {
 	unsigned long	timer_ival;
 	u32		token;
 	int		rmem_pending;
+	int		rmem_released;
 	unsigned long	flags;
 	bool		can_ack;
 	bool		fully_established;
@@ -238,6 +239,7 @@ struct mptcp_sock {
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
+	struct sk_buff_head receive_queue;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
@@ -269,6 +271,9 @@ void __lock_sock(struct sock *sk);
 	local_bh_enable();						\
 } while (0)
 =

+#define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
+#define mptcp_data_unlock(sk) spin_unlock_bh(&(sk)->sk_lock.slock)
+
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 =

-- =

2.26.2

--===============5733738639968324631==--

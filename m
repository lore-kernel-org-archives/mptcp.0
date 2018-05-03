Content-Type: multipart/mixed; boundary="===============6234034114376417337=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 10/14] mptcp: Make subflow-list an
 RCU-list
Date: Thu, 03 May 2018 14:04:54 -0700
Message-ID: <20180503210458.21524-11-cpaasch@apple.com>
In-Reply-To: 20180503210458.21524-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 610

--===============6234034114376417337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_add_sock() will now be called without holding the meta-level lock.
However, mptcp_add_sock() wants to add the subflow to the meta-level
list, thus we need to protect this by a lock. We use the mpcb_list_lock
for that.

Now that we are locking during add/del, and want to allow lockless
traversal of the list, this implies that we need to make it an RCU-list.

So, this patch transitions to the RCU hlist. The list-traversal macros
(hlist_for_each_entry_rcu) require me to now pass the mptcp_tcp_sock to
mptcp_for_each_*. So, I had to change all the places in the code where
we call one of the list-traversal macros to adapt to this.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 7a662b690069642c138da16ff9396e6826fd0a95)
---
 include/net/mptcp.h        | 67 +++++++++++++++++-----------------
 net/ipv4/af_inet.c         |  9 ++---
 net/ipv4/ip_sockglue.c     |  7 ++--
 net/ipv4/tcp.c             | 31 +++++++++-------
 net/mptcp/mptcp_ctrl.c     | 89 ++++++++++++++++++++++++++++--------------=
----
 net/mptcp/mptcp_fullmesh.c | 28 ++++++++++-----
 net/mptcp/mptcp_input.c    | 44 +++++++++++++++--------
 net/mptcp/mptcp_output.c   | 38 +++++++++++++-------
 net/mptcp/mptcp_sched.c    | 21 +++++++----
 9 files changed, 207 insertions(+), 127 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0f9d47b45895..091e56a7b334 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -156,7 +156,7 @@ struct mptcp_options_received {
 };
 =

 struct mptcp_tcp_sock {
-	struct tcp_sock	*next;		/* Next subflow socket */
+	struct hlist_node node;
 	struct hlist_node cb_list;
 	struct mptcp_options_received rx_opt;
 =

@@ -254,7 +254,7 @@ struct mptcp_sched_ops {
 =

 struct mptcp_cb {
 	/* list of sockets in this multipath connection */
-	struct tcp_sock *connection_list;
+	struct hlist_head conn_list;
 	/* list of sockets that need a call to release_cb */
 	struct hlist_head callback_list;
 =

@@ -309,7 +309,7 @@ struct mptcp_cb {
 	/***** Start of fields, used for subflow establishment */
 	struct sock *meta_sk;
 =

-	/* Master socket, also part of the connection_list, this
+	/* Master socket, also part of the conn_list, this
 	 * socket is the one that the application sees.
 	 */
 	struct sock *master_sk;
@@ -661,21 +661,17 @@ extern struct workqueue_struct *mptcp_wq;
 			pr_err(fmt, ##args);					\
 	} while (0)
 =

-/* Iterates over all subflows */
-#define mptcp_for_each_tp(mpcb, tp)					\
-	for ((tp) =3D (mpcb)->connection_list; (tp); (tp) =3D (tp)->mptcp->next)
+static inline struct sock *mptcp_to_sock(const struct mptcp_tcp_sock *mptc=
p)
+{
+	return (struct sock *)mptcp->tp;
+}
 =

-#define mptcp_for_each_sk(mpcb, sk)					\
-	for ((sk) =3D (struct sock *)(mpcb)->connection_list;		\
-	     sk;							\
-	     sk =3D (struct sock *)tcp_sk(sk)->mptcp->next)
+#define mptcp_for_each_sub(__mpcb, __mptcp)					\
+	hlist_for_each_entry_rcu(__mptcp, &((__mpcb)->conn_list), node)
 =

-#define mptcp_for_each_sk_safe(__mpcb, __sk, __temp)			\
-	for (__sk =3D (struct sock *)(__mpcb)->connection_list,		\
-	     __temp =3D __sk ? (struct sock *)tcp_sk(__sk)->mptcp->next : NULL; \
-	     __sk;							\
-	     __sk =3D __temp,						\
-	     __temp =3D __sk ? (struct sock *)tcp_sk(__sk)->mptcp->next : NULL)
+/* Must be called with the appropriate lock held */
+#define mptcp_for_each_sub_safe(__mpcb, __mptcp, __tmp)				\
+	hlist_for_each_entry_safe(__mptcp, __tmp, &((__mpcb)->conn_list), node)
 =

 /* Iterates over all bit set to 1 in a bitset */
 #define mptcp_for_each_bit_set(b, i)					\
@@ -922,12 +918,14 @@ struct request_sock *rev_mptcp_rsk(const struct mptcp=
_request_sock *req)
 =

 static inline bool mptcp_can_sendpage(struct sock *sk)
 {
-	struct sock *sk_it;
+	struct mptcp_tcp_sock *mptcp;
 =

 	if (tcp_sk(sk)->mpcb->dss_csum)
 		return false;
 =

-	mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it) {
+	mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
+		struct sock *sk_it =3D mptcp_to_sock(mptcp);
+
 		if (!(sk_it->sk_route_caps & NETIF_F_SG))
 			return false;
 	}
@@ -961,9 +959,12 @@ static inline void mptcp_send_reset(struct sock *sk)
 static inline void mptcp_sub_force_close_all(struct mptcp_cb *mpcb,
 					     struct sock *except)
 {
-	struct sock *sk_it, *tmp;
+	struct mptcp_tcp_sock *mptcp;
+	struct hlist_node *tmp;
+
+	mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
+		struct sock *sk_it =3D mptcp_to_sock(mptcp);
 =

-	mptcp_for_each_sk_safe(mpcb, sk_it, tmp) {
 		if (sk_it !=3D except)
 			mptcp_send_reset(sk_it);
 	}
@@ -1149,12 +1150,14 @@ static inline int mptcp_sk_can_send_ack(const struc=
t sock *sk)
 =

 static inline bool mptcp_can_sg(const struct sock *meta_sk)
 {
-	struct sock *sk;
+	struct mptcp_tcp_sock *mptcp;
 =

 	if (tcp_sk(meta_sk)->mpcb->dss_csum)
 		return false;
 =

-	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
+	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
+		struct sock *sk =3D mptcp_to_sock(mptcp);
+
 		if (!mptcp_sk_can_send(sk))
 			continue;
 		if (!(sk->sk_route_caps & NETIF_F_SG))
@@ -1165,9 +1168,9 @@ static inline bool mptcp_can_sg(const struct sock *me=
ta_sk)
 =

 static inline void mptcp_set_rto(struct sock *sk)
 {
-	struct tcp_sock *tp =3D tcp_sk(sk);
-	struct sock *sk_it;
 	struct inet_connection_sock *micsk =3D inet_csk(mptcp_meta_sk(sk));
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_tcp_sock *mptcp;
 	__u32 max_rto =3D 0;
 =

 	/* We are in recovery-phase on the MPTCP-level. Do not update the
@@ -1176,7 +1179,9 @@ static inline void mptcp_set_rto(struct sock *sk)
 	if (micsk->icsk_retransmits)
 		return;
 =

-	mptcp_for_each_sk(tp->mpcb, sk_it) {
+	mptcp_for_each_sub(tp->mpcb, mptcp) {
+		struct sock *sk_it =3D mptcp_to_sock(mptcp);
+
 		if ((mptcp_sk_can_send(sk_it) || sk->sk_state =3D=3D TCP_SYN_RECV) &&
 		    inet_csk(sk_it)->icsk_rto > max_rto)
 			max_rto =3D inet_csk(sk_it)->icsk_rto;
@@ -1265,10 +1270,10 @@ static inline bool mptcp_can_new_subflow(const stru=
ct sock *meta_sk)
 =

 static inline int mptcp_subflow_count(const struct mptcp_cb *mpcb)
 {
-	struct sock *sk;
+	struct mptcp_tcp_sock *mptcp;
 	int i =3D 0;
 =

-	mptcp_for_each_sk(mpcb, sk)
+	mptcp_for_each_sub(mpcb, mptcp)
 		i++;
 =

 	return i;
@@ -1286,12 +1291,8 @@ bool mptcp_prune_ofo_queue(struct sock *sk);
 	do {				\
 	} while (0)
 =

-/* Without MPTCP, we just do one iteration
- * over the only socket available. This assumes that
- * the sk/tp arg is the socket in that case.
- */
-#define mptcp_for_each_sk(mpcb, sk)
-#define mptcp_for_each_sk_safe(__mpcb, __sk, __temp)
+#define mptcp_for_each_sub(__mpcb, __mptcp)					\
+	if (0)
 =

 #define MPTCP_INC_STATS(net, field)	\
 	do {				\
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a58a8fbd6192..4b44aa87af2d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -744,13 +744,14 @@ int inet_accept(struct socket *sock, struct socket *n=
ewsock, int flags,
 	sock_rps_record_flow(sk2);
 =

 	if (sk2->sk_protocol =3D=3D IPPROTO_TCP && mptcp(tcp_sk(sk2))) {
-		struct sock *sk_it =3D sk2;
+		struct mptcp_tcp_sock *mptcp;
 =

-		mptcp_for_each_sk(tcp_sk(sk2)->mpcb, sk_it)
-			sock_rps_record_flow(sk_it);
+		mptcp_for_each_sub(tcp_sk(sk2)->mpcb, mptcp) {
+			sock_rps_record_flow(mptcp_to_sock(mptcp));
+		}
 =

 		if (tcp_sk(sk2)->mpcb->master_sk) {
-			sk_it =3D tcp_sk(sk2)->mpcb->master_sk;
+			struct sock *sk_it =3D tcp_sk(sk2)->mpcb->master_sk;
 =

 			write_lock_bh(&sk_it->sk_callback_lock);
 			sk_it->sk_wq =3D newsock->wq;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 6a41981c276e..eb72cf990876 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -753,8 +753,11 @@ static int do_ip_setsockopt(struct sock *sk, int level,
 			sk_dst_reset(sk);
 			/* Update TOS on mptcp subflow */
 			if (is_meta_sk(sk)) {
-				struct sock *sk_it;
-				mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it) {
+				struct mptcp_tcp_sock *mptcp;
+
+				mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
+					struct sock *sk_it =3D mptcp_to_sock(mptcp);
+
 					if (inet_sk(sk_it)->tos !=3D inet_sk(sk)->tos) {
 						inet_sk(sk_it)->tos =3D inet_sk(sk)->tos;
 						sk_it->sk_priority =3D sk->sk_priority;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index eeb98619b181..ab17bc222490 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -813,9 +813,11 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *p=
pos,
 =

 #ifdef CONFIG_MPTCP
 	if (mptcp(tcp_sk(sk))) {
-		struct sock *sk_it;
-		mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it)
-			sock_rps_record_flow(sk_it);
+		struct mptcp_tcp_sock *mptcp;
+
+		mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
+			sock_rps_record_flow(mptcp_to_sock(mptcp));
+		}
 	}
 #endif
 	/*
@@ -993,7 +995,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *=
page, int offset,
 	}
 =

 	if (mptcp(tp)) {
-		struct sock *sk_it =3D sk;
+		struct mptcp_tcp_sock *mptcp;
 =

 		/* We must check this with socket-lock hold because we iterate
 		 * over the subflows.
@@ -1008,8 +1010,9 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page=
 *page, int offset,
 			return ret;
 		}
 =

-		mptcp_for_each_sk(tp->mpcb, sk_it)
-			sock_rps_record_flow(sk_it);
+		mptcp_for_each_sub(tp->mpcb, mptcp) {
+			sock_rps_record_flow(mptcp_to_sock(mptcp));
+		}
 	}
 =

 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
@@ -1287,9 +1290,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghd=
r *msg, size_t size)
 	}
 =

 	if (mptcp(tp)) {
-		struct sock *sk_it =3D sk;
-		mptcp_for_each_sk(tp->mpcb, sk_it)
-			sock_rps_record_flow(sk_it);
+		struct mptcp_tcp_sock *mptcp;
+
+		mptcp_for_each_sub(tp->mpcb, mptcp) {
+			sock_rps_record_flow(mptcp_to_sock(mptcp));
+		}
 	}
 =

 	if (unlikely(tp->repair)) {
@@ -1994,9 +1999,11 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg,=
 size_t len, int nonblock,
 =

 #ifdef CONFIG_MPTCP
 	if (mptcp(tp)) {
-		struct sock *sk_it;
-		mptcp_for_each_sk(tp->mpcb, sk_it)
-			sock_rps_record_flow(sk_it);
+		struct mptcp_tcp_sock *mptcp;
+
+		mptcp_for_each_sub(tp->mpcb, mptcp) {
+			sock_rps_record_flow(mptcp_to_sock(mptcp));
+		}
 	}
 #endif
 =

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 052ae0e052b0..925d05d673d8 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -553,10 +553,12 @@ void mptcp_hash_remove_bh(struct tcp_sock *meta_tp)
 struct sock *mptcp_select_ack_sock(const struct sock *meta_sk)
 {
 	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct sock *sk, *rttsk =3D NULL, *lastsk =3D NULL;
+	struct sock *rttsk =3D NULL, *lastsk =3D NULL;
 	u32 min_time =3D 0, last_active =3D 0;
+	struct mptcp_tcp_sock *mptcp;
 =

-	mptcp_for_each_sk(meta_tp->mpcb, sk) {
+	mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
+		struct sock *sk =3D mptcp_to_sock(mptcp);
 		struct tcp_sock *tp =3D tcp_sk(sk);
 		u32 elapsed;
 =

@@ -689,7 +691,8 @@ void mptcp_sock_destruct(struct sock *sk)
 void mptcp_destroy_sock(struct sock *sk)
 {
 	if (is_meta_sk(sk)) {
-		struct sock *sk_it, *tmpsk;
+		struct mptcp_tcp_sock *mptcp;
+		struct hlist_node *tmp;
 =

 		__skb_queue_purge(&tcp_sk(sk)->mpcb->reinject_queue);
 =

@@ -699,7 +702,9 @@ void mptcp_destroy_sock(struct sock *sk)
 		 * not have been closed properly (as we are waiting for the
 		 * DATA_ACK of the DATA_FIN).
 		 */
-		mptcp_for_each_sk_safe(tcp_sk(sk)->mpcb, sk_it, tmpsk) {
+		mptcp_for_each_sub_safe(tcp_sk(sk)->mpcb, mptcp, tmp) {
+			struct sock *sk_it =3D mptcp_to_sock(mptcp);
+
 			/* Already did call tcp_close - waiting for graceful
 			 * closure, or if we are retransmitting fast-close on
 			 * the subflow. The reset (or timeout) will kill the
@@ -1281,6 +1286,7 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 	INIT_LIST_HEAD(&mpcb->tw_list);
 =

 	INIT_HLIST_HEAD(&mpcb->callback_list);
+	INIT_HLIST_HEAD(&mpcb->conn_list);
 	spin_lock_init(&mpcb->mpcb_list_lock);
 =

 	mptcp_mpcb_inherit_sockopts(meta_sk, master_sk);
@@ -1370,8 +1376,12 @@ int mptcp_add_sock(struct sock *meta_sk, struct sock=
 *sk, u8 loc_id, u8 rem_id,
 	sock_hold(meta_sk);
 	refcount_inc(&mpcb->mpcb_refcnt);
 =

-	tp->mptcp->next =3D mpcb->connection_list;
-	mpcb->connection_list =3D tp;
+	local_bh_disable();
+	spin_lock(&mpcb->mpcb_list_lock);
+	hlist_add_head_rcu(&tp->mptcp->node, &mpcb->conn_list);
+	spin_unlock(&mpcb->mpcb_list_lock);
+	local_bh_enable();
+
 	tp->mptcp->attached =3D 1;
 =

 	atomic_add(atomic_read(&((struct sock *)tp)->sk_rmem_alloc),
@@ -1415,14 +1425,13 @@ int mptcp_add_sock(struct sock *meta_sk, struct soc=
k *sk, u8 loc_id, u8 rem_id,
 =

 void mptcp_del_sock(struct sock *sk)
 {
-	struct tcp_sock *tp =3D tcp_sk(sk), *tp_prev;
+	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct mptcp_cb *mpcb;
 =

 	if (!tp->mptcp || !tp->mptcp->attached)
 		return;
 =

 	mpcb =3D tp->mpcb;
-	tp_prev =3D mpcb->connection_list;
 =

 	if (mpcb->pm_ops->delete_subflow)
 		mpcb->pm_ops->delete_subflow(sk);
@@ -1431,17 +1440,10 @@ void mptcp_del_sock(struct sock *sk)
 		    __func__, mpcb->mptcp_loc_token, tp->mptcp->path_index,
 		    sk->sk_state, is_meta_sk(sk));
 =

-	if (tp_prev =3D=3D tp) {
-		mpcb->connection_list =3D tp->mptcp->next;
-	} else {
-		for (; tp_prev && tp_prev->mptcp->next; tp_prev =3D tp_prev->mptcp->next=
) {
-			if (tp_prev->mptcp->next =3D=3D tp) {
-				tp_prev->mptcp->next =3D tp->mptcp->next;
-				break;
-			}
-		}
-	}
-	tp->mptcp->next =3D NULL;
+	spin_lock(&mpcb->mpcb_list_lock);
+	hlist_del_init_rcu(&tp->mptcp->node);
+	spin_unlock(&mpcb->mpcb_list_lock);
+
 	tp->mptcp->attached =3D 0;
 	mpcb->path_index_bits &=3D ~(1 << tp->mptcp->path_index);
 =

@@ -1488,8 +1490,8 @@ void mptcp_update_metasocket(const struct sock *meta_=
sk)
 void mptcp_cleanup_rbuf(struct sock *meta_sk, int copied)
 {
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct sock *sk;
 	bool recheck_rcv_window =3D false;
+	struct mptcp_tcp_sock *mptcp;
 	__u32 rcv_window_now =3D 0;
 =

 	if (copied > 0 && !(meta_sk->sk_shutdown & RCV_SHUTDOWN)) {
@@ -1500,7 +1502,8 @@ void mptcp_cleanup_rbuf(struct sock *meta_sk, int cop=
ied)
 			recheck_rcv_window =3D true;
 	}
 =

-	mptcp_for_each_sk(meta_tp->mpcb, sk) {
+	mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
+		struct sock *sk =3D mptcp_to_sock(mptcp);
 		struct tcp_sock *tp =3D tcp_sk(sk);
 		const struct inet_connection_sock *icsk =3D inet_csk(sk);
 =

@@ -1687,10 +1690,13 @@ EXPORT_SYMBOL(mptcp_sub_force_close);
  */
 void mptcp_update_sndbuf(const struct tcp_sock *tp)
 {
-	struct sock *meta_sk =3D tp->meta_sk, *sk;
+	struct sock *meta_sk =3D tp->meta_sk;
 	int new_sndbuf =3D 0, old_sndbuf =3D meta_sk->sk_sndbuf;
+	struct mptcp_tcp_sock *mptcp;
+
+	mptcp_for_each_sub(tp->mpcb, mptcp) {
+		struct sock *sk =3D mptcp_to_sock(mptcp);
 =

-	mptcp_for_each_sk(tp->mpcb, sk) {
 		if (!mptcp_sk_can_send(sk))
 			continue;
 =

@@ -1719,8 +1725,8 @@ void mptcp_update_sndbuf(const struct tcp_sock *tp)
 void mptcp_close(struct sock *meta_sk, long timeout)
 {
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct sock *sk_it, *tmpsk;
 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct mptcp_tcp_sock *mptcp;
 	struct sk_buff *skb;
 	int data_was_unread =3D 0;
 	int state;
@@ -1753,7 +1759,12 @@ void mptcp_close(struct sock *meta_sk, long timeout)
 =

 	/* If socket has been already reset (e.g. in tcp_reset()) - kill it. */
 	if (meta_sk->sk_state =3D=3D TCP_CLOSE) {
-		mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
+		struct mptcp_tcp_sock *mptcp;
+		struct hlist_node *tmp;
+
+		mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
+			struct sock *sk_it =3D mptcp_to_sock(mptcp);
+
 			if (tcp_sk(sk_it)->send_mp_fclose)
 				continue;
 			mptcp_sub_close(sk_it, 0);
@@ -1774,10 +1785,14 @@ void mptcp_close(struct sock *meta_sk, long timeout)
 	} else if (tcp_close_state(meta_sk)) {
 		mptcp_send_fin(meta_sk);
 	} else if (meta_tp->snd_una =3D=3D meta_tp->write_seq) {
+		struct mptcp_tcp_sock *mptcp;
+		struct hlist_node *tmp;
+
 		/* The DATA_FIN has been sent and acknowledged
 		 * (e.g., by sk_shutdown). Close all the other subflows
 		 */
-		mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
+		mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
+			struct sock *sk_it =3D mptcp_to_sock(mptcp);
 			unsigned long delay =3D 0;
 			/* If we are the passive closer, don't trigger
 			 * subflow-fin until the subflow has been finned
@@ -1801,7 +1816,9 @@ void mptcp_close(struct sock *meta_sk, long timeout)
 	/* socket will be freed after mptcp_close - we have to prevent
 	 * access from the subflows.
 	 */
-	mptcp_for_each_sk(mpcb, sk_it) {
+	mptcp_for_each_sub(mpcb, mptcp) {
+		struct sock *sk_it =3D mptcp_to_sock(mptcp);
+
 		/* Similar to sock_orphan, but we don't set it DEAD, because
 		 * the callbacks are still set and must be called.
 		 */
@@ -1886,8 +1903,9 @@ void mptcp_close(struct sock *meta_sk, long timeout)
 =

 void mptcp_disconnect(struct sock *sk)
 {
-	struct sock *subsk, *tmpsk;
+	struct mptcp_tcp_sock *mptcp;
 	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct hlist_node *tmp;
 =

 	__skb_queue_purge(&tp->mpcb->reinject_queue);
 =

@@ -1895,7 +1913,9 @@ void mptcp_disconnect(struct sock *sk)
 		mptcp_hash_remove_bh(tp);
 =

 	local_bh_disable();
-	mptcp_for_each_sk_safe(tp->mpcb, subsk, tmpsk) {
+	mptcp_for_each_sub_safe(tp->mpcb, mptcp, tmp) {
+		struct sock *subsk =3D mptcp_to_sock(mptcp);
+
 		/* The socket will get removed from the subsocket-list
 		 * and made non-mptcp by setting mpc to 0.
 		 *
@@ -2579,7 +2599,6 @@ static void mptcp_get_sub_info(struct sock *sk, struc=
t mptcp_sub_info *info)
 int mptcp_get_info(const struct sock *meta_sk, char __user *optval, int op=
tlen)
 {
 	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct sock *sk;
 =

 	struct mptcp_meta_info meta_info;
 	struct mptcp_info m_info;
@@ -2625,16 +2644,17 @@ int mptcp_get_info(const struct sock *meta_sk, char=
 __user *optval, int optlen)
 =

 	if (m_info.subflows) {
 		unsigned int len, sub_len =3D 0;
+		struct mptcp_tcp_sock *mptcp;
 		char __user *ptr;
 =

 		ptr =3D (char __user *)m_info.subflows;
 		len =3D m_info.sub_len;
 =

-		mptcp_for_each_sk(meta_tp->mpcb, sk) {
+		mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
 			struct tcp_info t_info;
 			unsigned int tmp_len;
 =

-			tcp_get_info(sk, &t_info);
+			tcp_get_info(mptcp_to_sock(mptcp), &t_info);
 =

 			tmp_len =3D min_t(unsigned int, len, info_len);
 			len -=3D tmp_len;
@@ -2654,6 +2674,7 @@ int mptcp_get_info(const struct sock *meta_sk, char _=
_user *optval, int optlen)
 =

 	if (m_info.subflow_info) {
 		unsigned int len, sub_info_len, total_sub_info_len =3D 0;
+		struct mptcp_tcp_sock *mptcp;
 		char __user *ptr;
 =

 		ptr =3D (char __user *)m_info.subflow_info;
@@ -2663,11 +2684,11 @@ int mptcp_get_info(const struct sock *meta_sk, char=
 __user *optval, int optlen)
 				     sizeof(struct mptcp_sub_info));
 		m_info.sub_info_len =3D sub_info_len;
 =

-		mptcp_for_each_sk(meta_tp->mpcb, sk) {
+		mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
 			struct mptcp_sub_info m_sub_info;
 			unsigned int tmp_len;
 =

-			mptcp_get_sub_info(sk, &m_sub_info);
+			mptcp_get_sub_info(mptcp_to_sock(mptcp), &m_sub_info);
 =

 			tmp_len =3D min_t(unsigned int, len, sub_info_len);
 			len -=3D tmp_len;
diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
index d29102a1dffb..53c1ba7319f5 100644
--- a/net/mptcp/mptcp_fullmesh.c
+++ b/net/mptcp/mptcp_fullmesh.c
@@ -903,8 +903,9 @@ static void mptcp_address_worker(struct work_struct *wo=
rk)
 			}
 =

 			if (event->code =3D=3D MPTCP_EVENT_DEL) {
-				struct sock *sk, *tmpsk;
+				struct mptcp_tcp_sock *mptcp;
 				struct mptcp_loc_addr *mptcp_local;
+				struct hlist_node *tmp;
 				bool found =3D false;
 =

 				mptcp_local =3D rcu_dereference_bh(fm_ns->local);
@@ -914,7 +915,9 @@ static void mptcp_address_worker(struct work_struct *wo=
rk)
 					update_addr_bitfields(meta_sk, mptcp_local);
 =

 				/* Look for the socket and remove him */
-				mptcp_for_each_sk_safe(mpcb, sk, tmpsk) {
+				mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
+					struct sock *sk =3D mptcp_to_sock(mptcp);
+
 					if ((event->family =3D=3D AF_INET6 &&
 					     (sk->sk_family =3D=3D AF_INET ||
 					      mptcp_v6_is_v4_mapped(sk))) ||
@@ -964,9 +967,10 @@ static void mptcp_address_worker(struct work_struct *w=
ork)
 			}
 =

 			if (event->code =3D=3D MPTCP_EVENT_MOD) {
-				struct sock *sk;
+				struct mptcp_tcp_sock *mptcp;
 =

-				mptcp_for_each_sk(mpcb, sk) {
+				mptcp_for_each_sub(mpcb, mptcp) {
+					struct sock *sk =3D mptcp_to_sock(mptcp);
 					struct tcp_sock *tp =3D tcp_sk(sk);
 					if (event->family =3D=3D AF_INET &&
 					    (sk->sk_family =3D=3D AF_INET ||
@@ -1455,8 +1459,9 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
 	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(meta_sk));
-	struct sock *sk, *tmpsk;
 	bool meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
+	struct mptcp_tcp_sock *mptcp;
+	struct hlist_node *tmp;
 	int i;
 =

 	rcu_read_lock_bh();
@@ -1470,7 +1475,8 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 		struct in_addr ifa =3D mptcp_local->locaddr4[i].addr;
 		bool found =3D false;
 =

-		mptcp_for_each_sk(mpcb, sk) {
+		mptcp_for_each_sub(mpcb, mptcp) {
+			struct sock *sk =3D mptcp_to_sock(mptcp);
 			struct tcp_sock *tp =3D tcp_sk(sk);
 =

 			if (sk->sk_family =3D=3D AF_INET6 &&
@@ -1491,6 +1497,8 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 		}
 =

 		if (!found) {
+			struct sock *sk;
+
 			fmp->add_addr++;
 			mpcb->addr_signal =3D 1;
 =

@@ -1511,7 +1519,8 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 		struct in6_addr ifa =3D mptcp_local->locaddr6[i].addr;
 		bool found =3D false;
 =

-		mptcp_for_each_sk(mpcb, sk) {
+		mptcp_for_each_sub(mpcb, mptcp) {
+			struct sock *sk =3D mptcp_to_sock(mptcp);
 			struct tcp_sock *tp =3D tcp_sk(sk);
 =

 			if (sk->sk_family =3D=3D AF_INET ||
@@ -1532,6 +1541,8 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 		}
 =

 		if (!found) {
+			struct sock *sk;
+
 			fmp->add_addr++;
 			mpcb->addr_signal =3D 1;
 =

@@ -1546,7 +1557,8 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 #endif
 =

 	/* Now, detect address-removals */
-	mptcp_for_each_sk_safe(mpcb, sk, tmpsk) {
+	mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
+		struct sock *sk =3D mptcp_to_sock(mptcp);
 		bool shall_remove =3D true;
 =

 		if (sk->sk_family =3D=3D AF_INET || mptcp_v6_is_v4_mapped(sk)) {
diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 211605347f70..64b0265bfd06 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -126,12 +126,14 @@ static void mptcp_clean_rtx_queue(struct sock *meta_s=
k, u32 prior_snd_una)
 		tcp_rtx_queue_unlink(skb, meta_sk);
 =

 		if (mptcp_is_data_fin(skb)) {
-			struct sock *sk_it, *sk_tmp;
+			struct mptcp_tcp_sock *mptcp;
+			struct hlist_node *tmp;
 =

 			/* DATA_FIN has been acknowledged - now we can close
 			 * the subflows
 			 */
-			mptcp_for_each_sk_safe(mpcb, sk_it, sk_tmp) {
+			mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
+				struct sock *sk_it =3D mptcp_to_sock(mptcp);
 				unsigned long delay =3D 0;
 =

 				/* If we are the passive closer, don't trigger
@@ -347,6 +349,7 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 =

 	/* Now, checksum must be 0 */
 	if (unlikely(csum_fold(csum_tcp))) {
+		struct mptcp_tcp_sock *mptcp;
 		struct sock *sk_it =3D NULL;
 =

 		pr_err("%s csum is wrong: %#x tcp-seq %u dss_csum_added %d overflowed %d=
 iterations %d\n",
@@ -362,7 +365,9 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 		tp->mpcb->csum_cutoff_seq =3D tp->mptcp->map_data_seq;
 =

 		/* Search for another subflow that is fully established */
-		mptcp_for_each_sk(tp->mpcb, sk_it) {
+		mptcp_for_each_sub(tp->mpcb, mptcp) {
+			sk_it =3D mptcp_to_sock(mptcp);
+
 			if (sk_it !=3D sk &&
 			    tcp_sk(sk_it)->mptcp->fully_established)
 				break;
@@ -1308,12 +1313,15 @@ int mptcp_do_join_short(struct sk_buff *skb,
  */
 void mptcp_fin(struct sock *meta_sk)
 {
-	struct sock *sk =3D NULL, *sk_it;
+	struct sock *sk =3D NULL;
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct mptcp_tcp_sock *mptcp;
 	unsigned char state;
 =

-	mptcp_for_each_sk(mpcb, sk_it) {
+	mptcp_for_each_sub(mpcb, mptcp) {
+		struct sock *sk_it =3D mptcp_to_sock(mptcp);
+
 		if (tcp_sk(sk_it)->mptcp->path_index =3D=3D mpcb->dfin_path_index) {
 			sk =3D sk_it;
 			break;
@@ -1585,9 +1593,12 @@ void mptcp_clean_rtx_infinite(const struct sk_buff *=
skb, struct sock *sk)
 =

 static void mptcp_send_reset_rem_id(const struct mptcp_cb *mpcb, u8 rem_id)
 {
-	struct sock *sk_it, *tmpsk;
+	struct mptcp_tcp_sock *mptcp;
+	struct hlist_node *tmp;
+
+	mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
+		struct sock *sk_it =3D mptcp_to_sock(mptcp);
 =

-	mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
 		if (tcp_sk(sk_it)->mptcp->rem_id =3D=3D rem_id) {
 			mptcp_reinject_data(sk_it, 0);
 			mptcp_send_reset(sk_it);
@@ -1892,13 +1903,15 @@ void tcp_parse_mptcp_options(const struct sk_buff *=
skb,
 bool mptcp_check_rtt(const struct tcp_sock *tp, int time)
 {
 	struct mptcp_cb *mpcb =3D tp->mpcb;
-	struct sock *sk;
+	struct mptcp_tcp_sock *mptcp;
 	u32 rtt_max =3D 0;
 =

 	/* In MPTCP, we take the max delay across all flows,
 	 * in order to take into account meta-reordering buffers.
 	 */
-	mptcp_for_each_sk(mpcb, sk) {
+	mptcp_for_each_sub(mpcb, mptcp) {
+		struct sock *sk =3D mptcp_to_sock(mptcp);
+
 		if (!mptcp_sk_can_recv(sk))
 			continue;
 =

@@ -2173,9 +2186,9 @@ bool mptcp_handle_options(struct sock *sk, const stru=
ct tcphdr *th,
 		if (mopt->saw_low_prio =3D=3D 1) {
 			tp->mptcp->rcv_low_prio =3D mopt->low_prio;
 		} else {
-			struct sock *sk_it;
-			mptcp_for_each_sk(tp->mpcb, sk_it) {
-				struct mptcp_tcp_sock *mptcp =3D tcp_sk(sk_it)->mptcp;
+			struct mptcp_tcp_sock *mptcp;
+
+			mptcp_for_each_sub(tp->mpcb, mptcp) {
 				if (mptcp->rem_id =3D=3D mopt->prio_addr_id)
 					mptcp->rcv_low_prio =3D mopt->low_prio;
 			}
@@ -2359,7 +2372,7 @@ bool mptcp_should_expand_sndbuf(const struct sock *sk)
 {
 	const struct sock *meta_sk =3D mptcp_meta_sk(sk);
 	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	const struct sock *sk_it;
+	const struct mptcp_tcp_sock *mptcp;
 =

 	/* We circumvent this check in tcp_check_space, because we want to
 	 * always call sk_write_space. So, we reproduce the check here.
@@ -2385,8 +2398,9 @@ bool mptcp_should_expand_sndbuf(const struct sock *sk)
 	/* For MPTCP we look for a subsocket that could send data.
 	 * If we found one, then we update the send-buffer.
 	 */
-	mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
-		struct tcp_sock *tp_it =3D tcp_sk(sk_it);
+	mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
+		const struct sock *sk_it =3D mptcp_to_sock(mptcp);
+		const struct tcp_sock *tp_it =3D tcp_sk(sk_it);
 =

 		if (!mptcp_sk_can_send(sk_it))
 			continue;
diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 4b88b32d5954..12733ba2c1e1 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -644,7 +644,6 @@ int mptcp_write_wakeup(struct sock *meta_sk, int mib)
 {
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
 	struct sk_buff *skb;
-	struct sock *sk_it;
 	int ans =3D 0;
 =

 	if (meta_sk->sk_state =3D=3D TCP_CLOSE)
@@ -701,17 +700,22 @@ int mptcp_write_wakeup(struct sock *meta_sk, int mib)
 =

 		return 0;
 	} else {
+		struct mptcp_tcp_sock *mptcp;
+
 window_probe:
 		if (between(meta_tp->snd_up, meta_tp->snd_una + 1,
 			    meta_tp->snd_una + 0xFFFF)) {
-			mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
+			mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
+				struct sock *sk_it =3D mptcp_to_sock(mptcp);
+
 				if (mptcp_sk_can_send_ack(sk_it))
 					tcp_xmit_probe_skb(sk_it, 1, mib);
 			}
 		}
 =

 		/* At least one of the tcp_xmit_probe_skb's has to succeed */
-		mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
+		mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
+			struct sock *sk_it =3D mptcp_to_sock(mptcp);
 			int ret;
 =

 			if (!mptcp_sk_can_send_ack(sk_it))
@@ -729,6 +733,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 		     int push_one, gfp_t gfp)
 {
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *subtp;
+	struct mptcp_tcp_sock *mptcp;
 	struct sock *subsk =3D NULL;
 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
 	struct sk_buff *skb;
@@ -853,7 +858,8 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 			break;
 	}
 =

-	mptcp_for_each_sk(mpcb, subsk) {
+	mptcp_for_each_sub(mpcb, mptcp) {
+		subsk =3D mptcp_to_sock(mptcp);
 		subtp =3D tcp_sk(subsk);
 =

 		if (!(path_mask & mptcp_pi_to_flag(subtp->mptcp->path_index)))
@@ -1350,7 +1356,7 @@ void mptcp_send_active_reset(struct sock *meta_sk, gf=
p_t priority)
 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
 	struct sock *sk;
 =

-	if (!mpcb->connection_list)
+	if (hlist_empty(&mpcb->conn_list))
 		return;
 =

 	WARN_ON(meta_tp->send_mp_fclose);
@@ -1725,10 +1731,11 @@ void mptcp_select_initial_window(const struct sock =
*sk, int __space, __u32 mss,
 static inline u64 mptcp_calc_rate(const struct sock *meta_sk, unsigned int=
 mss,
 				  unsigned int (*mss_cb)(struct sock *sk))
 {
-	struct sock *sk;
+	struct mptcp_tcp_sock *mptcp;
 	u64 rate =3D 0;
 =

-	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
+	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
+		struct sock *sk =3D mptcp_to_sock(mptcp);
 		struct tcp_sock *tp =3D tcp_sk(sk);
 		int this_mss;
 		u64 this_rate;
@@ -1780,11 +1787,12 @@ static inline u64 mptcp_calc_rate(const struct sock=
 *meta_sk, unsigned int mss,
 static unsigned int __mptcp_current_mss(const struct sock *meta_sk,
 					unsigned int (*mss_cb)(struct sock *sk))
 {
+	struct mptcp_tcp_sock *mptcp;
 	unsigned int mss =3D 0;
 	u64 rate =3D 0;
-	struct sock *sk;
 =

-	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
+	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
+		struct sock *sk =3D mptcp_to_sock(mptcp);
 		int this_mss;
 		u64 this_rate;
 =

@@ -1849,14 +1857,16 @@ int mptcp_select_size(const struct sock *meta_sk, b=
ool first_skb, bool zc)
 =

 int mptcp_check_snd_buf(const struct tcp_sock *tp)
 {
-	const struct sock *sk;
+	const struct mptcp_tcp_sock *mptcp;
 	u32 rtt_max =3D tp->srtt_us;
 	u64 bw_est;
 =

 	if (!tp->srtt_us)
 		return tp->reordering + 1;
 =

-	mptcp_for_each_sk(tp->mpcb, sk) {
+	mptcp_for_each_sub(tp->mpcb, mptcp) {
+		const struct sock *sk =3D mptcp_to_sock(mptcp);
+
 		if (!mptcp_sk_can_send(sk))
 			continue;
 =

@@ -1874,11 +1884,13 @@ int mptcp_check_snd_buf(const struct tcp_sock *tp)
 unsigned int mptcp_xmit_size_goal(const struct sock *meta_sk, u32 mss_now,
 				  int large_allowed)
 {
-	struct sock *sk;
 	u32 xmit_size_goal =3D 0;
 =

 	if (large_allowed && !tcp_sk(meta_sk)->mpcb->dss_csum) {
-		mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
+		struct mptcp_tcp_sock *mptcp;
+
+		mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
+			struct sock *sk =3D mptcp_to_sock(mptcp);
 			int this_size_goal;
 =

 			if (!mptcp_sk_can_send(sk))
diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
index a2543c60bd31..b440df7aae71 100644
--- a/net/mptcp/mptcp_sched.c
+++ b/net/mptcp/mptcp_sched.c
@@ -135,9 +135,10 @@ static struct sock
 	u32 min_srtt =3D 0xffffffff;
 	bool found_unused =3D false;
 	bool found_unused_una =3D false;
-	struct sock *sk;
+	struct mptcp_tcp_sock *mptcp;
 =

-	mptcp_for_each_sk(mpcb, sk) {
+	mptcp_for_each_sub(mpcb, mptcp) {
+		struct sock *sk =3D mptcp_to_sock(mptcp);
 		struct tcp_sock *tp =3D tcp_sk(sk);
 		bool unused =3D false;
 =

@@ -219,7 +220,11 @@ static struct sock *get_available_subflow(struct sock =
*meta_sk,
 	/* Answer data_fin on same subflow!!! */
 	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
 	    skb && mptcp_is_data_fin(skb)) {
-		mptcp_for_each_sk(mpcb, sk) {
+		struct mptcp_tcp_sock *mptcp;
+
+		mptcp_for_each_sub(mpcb, mptcp) {
+			sk =3D mptcp_to_sock(mptcp);
+
 			if (tcp_sk(sk)->mptcp->path_index =3D=3D mpcb->dfin_path_index &&
 			    mptcp_is_available(sk, skb, zero_wnd_test))
 				return sk;
@@ -252,7 +257,7 @@ static struct sk_buff *mptcp_rcv_buf_optimization(struc=
t sock *sk, int penal)
 {
 	struct sock *meta_sk;
 	const struct tcp_sock *tp =3D tcp_sk(sk);
-	struct tcp_sock *tp_it;
+	struct mptcp_tcp_sock *mptcp;
 	struct sk_buff *skb_head;
 	struct defsched_priv *dsp =3D defsched_get_priv(tp);
 =

@@ -275,7 +280,9 @@ static struct sk_buff *mptcp_rcv_buf_optimization(struc=
t sock *sk, int penal)
 		goto retrans;
 =

 	/* Half the cwnd of the slow flow */
-	mptcp_for_each_tp(tp->mpcb, tp_it) {
+	mptcp_for_each_sub(tp->mpcb, mptcp) {
+		struct tcp_sock *tp_it =3D mptcp->tp;
+
 		if (tp_it !=3D tp &&
 		    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptcp->pat=
h_index)) {
 			if (tp->srtt_us < tp_it->srtt_us && inet_csk((struct sock *)tp_it)->ics=
k_ca_state =3D=3D TCP_CA_Open) {
@@ -298,7 +305,9 @@ static struct sk_buff *mptcp_rcv_buf_optimization(struc=
t sock *sk, int penal)
 	/* Segment not yet injected into this path? Take it!!! */
 	if (!(TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp->mptcp->path_=
index))) {
 		bool do_retrans =3D false;
-		mptcp_for_each_tp(tp->mpcb, tp_it) {
+		mptcp_for_each_sub(tp->mpcb, mptcp) {
+			struct tcp_sock *tp_it =3D mptcp->tp;
+
 			if (tp_it !=3D tp &&
 			    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptcp->pa=
th_index)) {
 				if (tp_it->snd_cwnd <=3D 4) {
-- =

2.16.2


--===============6234034114376417337==--

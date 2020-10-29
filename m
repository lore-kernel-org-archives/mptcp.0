Content-Type: multipart/mixed; boundary="===============4287906976167925328=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH] mptcp: refine MPTCP-level ack scheduling
Date: Thu, 29 Oct 2020 17:53:14 +0100
Message-ID: <023a1e762e1a8aae511ce2c91687b10621fca99e.1603989332.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6475

--===============4287906976167925328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Send timely MPTCP-level ack is somewhat when the insertion
into the msk receive level is performed by the worker.
It needs TCP-level dup-ack to notify the MPTCP-level
ack_seq increase, as both the TCP-level ack seq and the
rcv window are unchanged.

We can actually avoid processing incoming data with the
worker, and let the subflow or recevmsg() send ack as needed.

When recvmsg() moves the skbs inside the msk receive queue,
the msk space is still unchanged, so tcp_cleanup_rbuf() could
end-up skipping TCP-level ack generation. Anyway, when
__mptcp_move_skbs() is invoked, a known amount of bytes is
going to be consumed soon: we update rcv wnd computation taking
them in account.

Additionally we need to explicitly trigger tcp_cleanup_rbuf()
when recvmsg() consumes a significant amount of the receive buffer.

Signed-off-by:  Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  |  1 +
 net/mptcp/protocol.c | 74 +++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  7 +++++
 net/mptcp/subflow.c  |  4 +--
 4 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 248e3930c0cb..8a59b3e44599 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -530,6 +530,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 		opts->ext_copy.ack64 =3D 0;
 	}
 	opts->ext_copy.use_ack =3D 1;
+	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
 =

 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size =3D=3D 0)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a6bd06c724d5..0a618cd26df7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -405,7 +405,7 @@ static void mptcp_set_timeout(const struct sock *sk, co=
nst struct sock *ssk)
 	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
 }
 =

-static void mptcp_send_ack(struct mptcp_sock *msk)
+static void mptcp_send_ack(struct mptcp_sock *msk, bool force)
 {
 	struct mptcp_subflow_context *subflow;
 =

@@ -413,8 +413,13 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

 		lock_sock(ssk);
-		tcp_send_ack(ssk);
+		if (force)
+			tcp_send_ack(ssk);
+		else
+			tcp_cleanup_rbuf(ssk, 1);
 		release_sock(ssk);
+		if (!force)
+			break;
 	}
 }
 =

@@ -466,7 +471,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 =

 		ret =3D true;
 		mptcp_set_timeout(sk, NULL);
-		mptcp_send_ack(msk);
+		mptcp_send_ack(msk, true);
 		if (sock_flag(sk, SOCK_DEAD))
 			return ret;
 =

@@ -489,7 +494,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 	unsigned int moved =3D 0;
 	bool more_data_avail;
 	struct tcp_sock *tp;
-	u32 old_copied_seq;
 	bool done =3D false;
 	int sk_rbuf;
 =

@@ -506,7 +510,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 =

 	pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
 	tp =3D tcp_sk(ssk);
-	old_copied_seq =3D tp->copied_seq;
 	do {
 		u32 map_remaining, offset;
 		u32 seq =3D tp->copied_seq;
@@ -571,10 +574,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 		}
 	} while (more_data_avail);
 =

-	*bytes +=3D moved;
-	if (tp->copied_seq !=3D old_copied_seq)
-		tcp_cleanup_rbuf(ssk, 1);
-
+	*bytes =3D moved;
 	return done;
 }
 =

@@ -678,19 +678,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ss=
k)
 	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
 		goto wake;
 =

-	if (move_skbs_to_msk(msk, ssk))
-		goto wake;
-
-	/* mptcp socket is owned, release_cb should retry */
-	if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED,
-			      &sk->sk_tsq_flags)) {
-		sock_hold(sk);
+	move_skbs_to_msk(msk, ssk);
 =

-		/* need to try again, its possible release_cb() has already
-		 * been called after the test_and_set_bit() above.
-		 */
-		move_skbs_to_msk(msk, ssk);
-	}
 wake:
 	if (wake)
 		sk->sk_data_ready(sk);
@@ -1522,9 +1511,9 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock =
*msk, int copied)
 	msk->rcvq_space.time =3D mstamp;
 }
 =

-static bool __mptcp_move_skbs(struct mptcp_sock *msk)
+static bool __mptcp_move_skbs(struct mptcp_sock *msk, unsigned int rcv)
 {
-	unsigned int moved =3D 0;
+	unsigned int moved_total =3D 0;
 	bool done;
 =

 	/* avoid looping forever below on racing close */
@@ -1534,6 +1523,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	__mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
+		unsigned int moved;
 		bool slowpath;
 =

 		if (!ssk)
@@ -1541,12 +1531,17 @@ static bool __mptcp_move_skbs(struct mptcp_sock *ms=
k)
 =

 		slowpath =3D lock_sock_fast(ssk);
 		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+		moved_total +=3D moved;
+		if (moved_total && rcv) {
+			WRITE_ONCE(msk->rmem_pending, min(rcv, moved_total));
+			tcp_cleanup_rbuf(ssk, 1);
+			WRITE_ONCE(msk->rmem_pending, 0);
+		}
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 =

-	if (mptcp_ofo_queue(msk) || moved > 0) {
-		if (!mptcp_check_data_fin((struct sock *)msk))
-			mptcp_send_ack(msk);
+	if (mptcp_ofo_queue(msk) || moved_total > 0) {
+		mptcp_check_data_fin((struct sock *)msk);
 		return true;
 	}
 	return false;
@@ -1570,8 +1565,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 	__mptcp_flush_join_list(msk);
 =

-	while (len > (size_t)copied) {
-		int bytes_read;
+	for (;;) {
+		int bytes_read, old_space;
 =

 		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
 		if (unlikely(bytes_read < 0)) {
@@ -1583,9 +1578,14 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
 		copied +=3D bytes_read;
 =

 		if (skb_queue_empty(&sk->sk_receive_queue) &&
-		    __mptcp_move_skbs(msk))
+		    __mptcp_move_skbs(msk, len - copied))
 			continue;
 =

+		/* be sure to advertize window change */
+		old_space =3D READ_ONCE(msk->old_wspace);
+		if ((tcp_space(sk) - old_space) >=3D old_space)
+			mptcp_send_ack(msk, false);
+
 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
 		 */
@@ -1638,7 +1638,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		/* .. race-breaker: ssk might have gotten new data
 		 * after last __mptcp_move_skbs() returned false.
 		 */
-		if (unlikely(__mptcp_move_skbs(msk)))
+		if (unlikely(__mptcp_move_skbs(msk, 0)))
 			set_bit(MPTCP_DATA_READY, &msk->flags);
 	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
 		/* data to read but mptcp_wait_data() cleared DATA_READY */
@@ -1870,7 +1870,6 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(msk);
 =

-	__mptcp_move_skbs(msk);
 	if (mptcp_send_head(sk))
 		mptcp_push_pending(sk, 0);
 =

@@ -2491,8 +2490,7 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 	return -EOPNOTSUPP;
 }
 =

-#define MPTCP_DEFERRED_ALL (TCPF_DELACK_TIMER_DEFERRED | \
-			    TCPF_WRITE_TIMER_DEFERRED)
+#define MPTCP_DEFERRED_ALL (TCPF_WRITE_TIMER_DEFERRED)
 =

 /* this is very alike tcp_release_cb() but we must handle differently a
  * different set of events
@@ -2510,16 +2508,6 @@ static void mptcp_release_cb(struct sock *sk)
 =

 	sock_release_ownership(sk);
 =

-	if (flags & TCPF_DELACK_TIMER_DEFERRED) {
-		struct mptcp_sock *msk =3D mptcp_sk(sk);
-		struct sock *ssk;
-
-		ssk =3D mptcp_subflow_recv_lookup(msk);
-		if (!ssk || sk->sk_state =3D=3D TCP_CLOSE ||
-		    !schedule_work(&msk->work))
-			__sock_put(sk);
-	}
-
 	if (flags & TCPF_WRITE_TIMER_DEFERRED) {
 		mptcp_retransmit_handler(sk);
 		__sock_put(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7a5c16f176c0..fe24e480689e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -221,10 +221,12 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	struct sock	*last_snd;
 	int		snd_burst;
+	int		old_wspace;
 	atomic64_t	snd_una;
 	atomic64_t	wnd_end;
 	unsigned long	timer_ival;
 	u32		token;
+	int		rmem_pending;
 	unsigned long	flags;
 	bool		can_ack;
 	bool		fully_established;
@@ -259,6 +261,11 @@ static inline struct mptcp_sock *mptcp_sk(const struct=
 sock *sk)
 	return (struct mptcp_sock *)sk;
 }
 =

+static inline int __mptcp_space(const struct sock *sk)
+{
+	return tcp_space(sk) + READ_ONCE(mptcp_sk(sk)->rmem_pending);
+}
+
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *s=
k)
 {
 	const struct mptcp_sock *msk =3D mptcp_sk(sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1e9a72af67dc..dcfb5c65924e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -850,8 +850,6 @@ static void mptcp_subflow_discard_data(struct sock *ssk=
, struct sk_buff *skb,
 		sk_eat_skb(ssk, skb);
 	if (mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len)
 		subflow->map_valid =3D 0;
-	if (incr)
-		tcp_cleanup_rbuf(ssk, incr);
 }
 =

 static bool subflow_check_data_avail(struct sock *ssk)
@@ -973,7 +971,7 @@ void mptcp_space(const struct sock *ssk, int *space, in=
t *full_space)
 	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	const struct sock *sk =3D subflow->conn;
 =

-	*space =3D tcp_space(sk);
+	*space =3D __mptcp_space(sk);
 	*full_space =3D tcp_full_space(sk);
 }
 =

-- =

2.26.2

--===============4287906976167925328==--

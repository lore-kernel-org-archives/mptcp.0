Content-Type: multipart/mixed; boundary="===============8947431001143228318=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH] mptcp: Use full MPTCP-level disconnect state
 machine
Date: Fri, 26 Jun 2020 17:15:37 -0700
Message-ID: <20200627001537.881377-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4838

--===============8947431001143228318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RFC 8684 appendix D describes the connection state machine for
MPTCP. This patch implements the DATA_FIN / DATA_ACK exchanges and
MPTCP-level socket state changes described in that appendix, rather than
simply sending DATA_FIN along with TCP FIN when disconnecting subflows.

DATA_FIN is now sent and acknowledged before shutting down the
subflows. Received DATA_FIN information (if not part of a data packet)
is written to the MPTCP socket when the incoming DSS option is parsed by
the subflow, and the MPTCP worker is scheduled to process the
flag. DATA_FIN received as part of a full DSS mapping will be handled
when the mapping is processed.

The DATA_FIN is acknowledged by the worker if the reader is caught
up. If there is still data to be moved to the MPTCP-level queue, ack_seq
will be incremented to account for the DATA_FIN when it reaches the end
of the stream and a DATA_ACK will be sent to the peer.

In this RFC patch, DATA_FIN is sent when calling shutdown(fd, SHUT_WR)
on the MPTCP socket. mptcp_close() has not yet been updated to wait for
the peer to DATA_ACK before forcing all the subflows to be closed and
cleaned up. The handshake is working with both peers using test programs
with shutdown() and delays, but is not yet working consistently with the
self tests. It also doesn't currently detect if fallback has happened,
so there are extra acks sent on fallback connections.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  |  36 +++++--
 net/mptcp/protocol.c | 246 +++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.h |   4 +
 net/mptcp/subflow.c  |  32 +++++-
 4 files changed, 272 insertions(+), 46 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b96d3660562fb..75dc030d4362d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -482,17 +482,10 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 	struct mptcp_sock *msk;
 	unsigned int ack_size;
 	bool ret =3D false;
-	u8 tcp_fin;
 =

-	if (skb) {
-		mpext =3D mptcp_get_ext(skb);
-		tcp_fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-	} else {
-		mpext =3D NULL;
-		tcp_fin =3D 0;
-	}
+	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
 =

-	if (!skb || (mpext && mpext->use_map) || tcp_fin) {
+	if (!skb || (mpext && mpext->use_map) || subflow->data_fin_tx_enable) {
 		unsigned int map_size;
 =

 		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
@@ -502,7 +495,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 		if (mpext)
 			opts->ext_copy =3D *mpext;
 =

-		if (skb && tcp_fin && subflow->data_fin_tx_enable)
+		if (skb && subflow->data_fin_tx_enable)
 			mptcp_write_data_fin(subflow, &opts->ext_copy);
 		ret =3D true;
 	}
@@ -784,6 +777,26 @@ static void update_una(struct mptcp_sock *msk,
 	}
 }
 =

+static void update_data_fin(struct sock *sk,
+			    struct mptcp_options_received *mp_opt)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	/* Skip if DATA_FIN was already received. If updating
+	 * simultaneously with the recvmsg loop, values should match. If
+	 * they mismatch, the peer sent us bad data and we will prefer
+	 * the most recent information.
+	 */
+	if (READ_ONCE(msk->rcv_data_fin))
+		return;
+
+	WRITE_ONCE(msk->rcv_data_fin_seq, mp_opt->data_seq);
+	WRITE_ONCE(msk->rcv_data_fin, 1);
+
+	if (schedule_work(&msk->work))
+		sock_hold(sk);
+}
+
 static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 				struct mptcp_options_received *mp_opt)
 {
@@ -854,6 +867,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	if (mp_opt.use_ack)
 		update_una(msk, &mp_opt);
 =

+	if (mp_opt.data_fin && mp_opt.data_len =3D=3D 1)
+		update_data_fin(subflow->conn, &mp_opt);
+
 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8e9cef974f4b1..60596ef097b88 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -16,6 +16,7 @@
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
+#include <net/tcp_states.h>
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 #include <net/transp_v6.h>
 #endif
@@ -141,6 +142,14 @@ static void __mptcp_move_skb(struct mptcp_sock *msk, s=
truct sock *ssk,
 	MPTCP_SKB_CB(skb)->offset =3D offset;
 }
 =

+static void mptcp_stop_timer(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+	mptcp_sk(sk)->timer_ival =3D 0;
+}
+
 /* both sockets must be locked */
 static bool mptcp_subflow_dsn_valid(const struct mptcp_sock *msk,
 				    struct sock *ssk)
@@ -162,6 +171,116 @@ static bool mptcp_subflow_dsn_valid(const struct mptc=
p_sock *msk,
 	return mptcp_subflow_data_available(ssk);
 }
 =

+static void mptcp_check_data_fin_ack(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	/* Look for an acknowledged DATA_FIN */
+	if (((1 << sk->sk_state) &
+	    (TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
+	    (msk->write_seq =3D=3D atomic64_read(&msk->snd_una))) {
+		struct mptcp_subflow_context *subflow;
+
+		mptcp_stop_timer(sk);
+
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+			lock_sock(ssk);
+			subflow->data_fin_tx_enable =3D 0;
+			release_sock(ssk);
+		}
+
+		switch (sk->sk_state) {
+		case TCP_FIN_WAIT1:
+			inet_sk_state_store(sk, TCP_FIN_WAIT2);
+			break;
+		case TCP_CLOSING:
+			fallthrough;
+		case TCP_LAST_ACK:
+			inet_sk_state_store(sk, TCP_CLOSE);
+			// @@ Close subflows now?
+			break;
+		}
+	}
+}
+
+static bool mptcp_pending_data_fin(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	return (READ_ONCE(msk->rcv_data_fin) &&
+		((1 << sk->sk_state) &
+		 (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2)) &&
+		msk->ack_seq =3D=3D READ_ONCE(msk->rcv_data_fin_seq));
+}
+
+static void mptcp_check_data_fin(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	/* Need to ack a DATA_FIN in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
+	 * If we are caught up to the sequence number of the incoming
+	 * DATA_FIN, send the DATA_ACK now and do state transition.
+	 * If not caught up, do nothing and let the recv code DATA_ACK
+	 * along with the received data.
+	 */
+
+	if (READ_ONCE(msk->rcv_data_fin) &&
+	    ((1 << sk->sk_state) &
+	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
+		u64 rcv_data_fin_seq =3D READ_ONCE(msk->rcv_data_fin_seq);
+		struct mptcp_subflow_context *subflow;
+
+		if (msk->ack_seq =3D=3D rcv_data_fin_seq) {
+			msk->ack_seq++;
+			WRITE_ONCE(msk->rcv_data_fin, 0);
+
+			sk->sk_shutdown |=3D RCV_SHUTDOWN;
+
+			switch (sk->sk_state) {
+			case TCP_ESTABLISHED:
+				inet_sk_state_store(sk, TCP_CLOSE_WAIT);
+				break;
+			case TCP_FIN_WAIT1:
+				inet_sk_state_store(sk, TCP_CLOSING);
+				break;
+			case TCP_FIN_WAIT2:
+				inet_sk_state_store(sk, TCP_CLOSE);
+				// @@ Close subflows now?
+				break;
+			default:
+				/* Other states not expected */
+				WARN_ON_ONCE(1);
+				break;
+			}
+
+			mptcp_set_timeout(sk, NULL);
+			mptcp_for_each_subflow(msk, subflow) {
+				struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+				lock_sock(ssk);
+				tcp_send_ack(ssk);
+				release_sock(ssk);
+			}
+
+			sk->sk_state_change(sk);
+
+			if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
+			    sk->sk_state =3D=3D TCP_CLOSE)
+				sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
+			else
+				sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+		}
+	}
+}
+
+static void mptcp_schedule_work(struct sock *sk)
+{
+	if (schedule_work(&mptcp_sk(sk)->work))
+		sock_hold(sk);
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -219,6 +338,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 			seq +=3D len;
 			moved +=3D len;
 =

+			if (mptcp_pending_data_fin(sk))
+				mptcp_schedule_work(sk);
+
 			if (WARN_ON_ONCE(map_remaining < len))
 				break;
 		} else {
@@ -302,7 +424,7 @@ static void __mptcp_flush_join_list(struct mptcp_sock *=
msk)
 	spin_unlock_bh(&msk->join_list_lock);
 }
 =

-static void mptcp_set_timeout(const struct sock *sk, const struct sock *ss=
k)
+void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
 {
 	long tout =3D ssk && inet_csk(ssk)->icsk_pending ?
 				      inet_csk(ssk)->icsk_timeout - jiffies : 0;
@@ -333,7 +455,8 @@ void mptcp_data_acked(struct sock *sk)
 {
 	mptcp_reset_timer(sk);
 =

-	if (!sk_stream_is_writeable(sk) &&
+	if ((!sk_stream_is_writeable(sk) ||
+	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
 	    schedule_work(&mptcp_sk(sk)->work))
 		sock_hold(sk);
 }
@@ -368,14 +491,6 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 	}
 }
 =

-static void mptcp_stop_timer(struct sock *sk)
-{
-	struct inet_connection_sock *icsk =3D inet_csk(sk);
-
-	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
-	mptcp_sk(sk)->timer_ival =3D 0;
-}
-
 static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
 {
 	const struct sock *sk =3D (const struct sock *)msk;
@@ -742,8 +857,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 restart:
 	mptcp_clean_una(sk);
 =

+	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)) {
+		ret =3D -EPIPE;
+		goto out;
+	}
+
+
 wait_for_sndbuf:
 	__mptcp_flush_join_list(msk);
+
 	ssk =3D mptcp_subflow_get_send(msk);
 	while (!sk_stream_memory_free(sk) ||
 	       !ssk ||
@@ -1249,6 +1371,7 @@ static void mptcp_worker(struct work_struct *work)
 =

 	lock_sock(sk);
 	mptcp_clean_una(sk);
+	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
 	__mptcp_move_skbs(msk);
 =

@@ -1258,6 +1381,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 =

+	mptcp_check_data_fin(sk);
+
 	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		goto unlock;
 =

@@ -1383,30 +1508,28 @@ static void mptcp_cancel_work(struct sock *sk)
 		sock_put(sk);
 }
 =

-static void mptcp_subflow_shutdown(struct sock *ssk, int how,
-				   bool data_fin_tx_enable, u64 data_fin_tx_seq)
+static void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk,
+				   u64 data_fin_tx_seq, int how)
 {
+	struct mptcp_subflow_context *subflow;
+
 	lock_sock(ssk);
 =

 	switch (ssk->sk_state) {
 	case TCP_LISTEN:
 		if (!(how & RCV_SHUTDOWN))
 			break;
-		/* fall through */
+		fallthrough;
 	case TCP_SYN_SENT:
 		tcp_disconnect(ssk, O_NONBLOCK);
 		break;
 	default:
-		if (data_fin_tx_enable) {
-			struct mptcp_subflow_context *subflow;
-
-			subflow =3D mptcp_subflow_ctx(ssk);
-			subflow->data_fin_tx_seq =3D data_fin_tx_seq;
-			subflow->data_fin_tx_enable =3D 1;
-		}
+		subflow =3D mptcp_subflow_ctx(ssk);
+		subflow->data_fin_tx_seq =3D data_fin_tx_seq;
+		subflow->data_fin_tx_enable =3D 1;
 =

-		ssk->sk_shutdown |=3D how;
-		tcp_shutdown(ssk, how);
+		mptcp_set_timeout(sk, ssk);
+		tcp_send_ack(ssk);
 		break;
 	}
 =

@@ -1418,11 +1541,14 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	bool data_fin_tx_enable;
 	LIST_HEAD(conn_list);
 	u64 data_fin_tx_seq;
+	int prev_state;
 =

 	lock_sock(sk);
-
+pr_debug("closing");
+	prev_state =3D sk->sk_state;
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

 	/* be sure to always acquire the join list lock, to sync vs
@@ -1433,7 +1559,17 @@ static void mptcp_close(struct sock *sk, long timeou=
t)
 	spin_unlock_bh(&msk->join_list_lock);
 	list_splice_init(&msk->conn_list, &conn_list);
 =

-	data_fin_tx_seq =3D msk->write_seq;
+	if ((1 << prev_state) &
+	    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
+	     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) {
+		data_fin_tx_seq =3D msk->write_seq;
+		data_fin_tx_enable =3D 1;
+
+		msk->write_seq++;
+	} else {
+		/* DATA_FIN has already been sent in other states */
+		data_fin_tx_enable =3D 0;
+	}
 =

 	__mptcp_clear_xmit(sk);
 =

@@ -1442,8 +1578,11 @@ static void mptcp_close(struct sock *sk, long timeou=
t)
 	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		subflow->data_fin_tx_seq =3D data_fin_tx_seq;
-		subflow->data_fin_tx_enable =3D 1;
+		if (data_fin_tx_enable) {
+			subflow->data_fin_tx_seq =3D data_fin_tx_seq;
+			subflow->data_fin_tx_enable =3D 1;
+		}
+
 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 	}
 =

@@ -2109,6 +2248,33 @@ static __poll_t mptcp_poll(struct file *file, struct=
 socket *sock,
 	return mask;
 }
 =

+static const unsigned char new_state[16] =3D {
+  /* current state:        new state:      action:	*/
+  [0 /* (Invalid) */]	=3D TCP_CLOSE,
+  [TCP_ESTABLISHED]	=3D TCP_FIN_WAIT1 | TCP_ACTION_FIN,
+  [TCP_SYN_SENT]	=3D TCP_CLOSE,
+  [TCP_SYN_RECV]	=3D TCP_FIN_WAIT1 | TCP_ACTION_FIN,
+  [TCP_FIN_WAIT1]	=3D TCP_FIN_WAIT1,
+  [TCP_FIN_WAIT2]	=3D TCP_FIN_WAIT2,
+  [TCP_TIME_WAIT]	=3D TCP_CLOSE,	/* should not happen ! */
+  [TCP_CLOSE]		=3D TCP_CLOSE,
+  [TCP_CLOSE_WAIT]	=3D TCP_LAST_ACK  | TCP_ACTION_FIN,
+  [TCP_LAST_ACK]	=3D TCP_LAST_ACK,
+  [TCP_LISTEN]		=3D TCP_CLOSE,
+  [TCP_CLOSING]		=3D TCP_CLOSING,
+  [TCP_NEW_SYN_RECV]	=3D TCP_CLOSE,	/* should not happen ! */
+};
+
+static int mptcp_close_state(struct sock *sk)
+{
+	int next =3D (int)new_state[sk->sk_state];
+	int ns =3D next & TCP_STATE_MASK;
+
+	inet_sk_state_store(sk, ns);
+
+	return next & TCP_ACTION_FIN;
+}
+
 static int mptcp_shutdown(struct socket *sock, int how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
@@ -2118,11 +2284,8 @@ static int mptcp_shutdown(struct socket *sock, int h=
ow)
 	pr_debug("sk=3D%p, how=3D%d", msk, how);
 =

 	lock_sock(sock->sk);
-	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
-		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
 =

 	how++;
-
 	if ((how & ~SHUTDOWN_MASK) || !how) {
 		ret =3D -EINVAL;
 		goto out_unlock;
@@ -2136,11 +2299,28 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
 			sock->state =3D SS_CONNECTED;
 	}
 =

-	__mptcp_flush_join_list(msk);
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+	/* If we've already sent a FIN, or it's a closed state, skip this. */
+	if ((how & SEND_SHUTDOWN) &&
+	    ((1 << sock->sk->sk_state) &
+	     (TCPF_ESTABLISHED | TCPF_SYN_SENT |
+	      TCPF_SYN_RECV | TCPF_CLOSE_WAIT))) {
+
+		if (mptcp_close_state(sock->sk)) {
+			u64 data_fin_tx_seq =3D msk->write_seq;
 =

-		mptcp_subflow_shutdown(tcp_sk, how, 1, msk->write_seq);
+			__mptcp_flush_join_list(msk);
+
+			msk->write_seq++;
+
+			mptcp_for_each_subflow(msk, subflow) {
+				struct sock *tcp_sk;
+
+				tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+
+				mptcp_subflow_shutdown(sock->sk, tcp_sk,
+						       data_fin_tx_seq, how);
+			}
+		}
 	}
 =

 	/* Wake up anyone sleeping in poll. */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dfe67e8a86ed2..834312af5ac66 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -193,11 +193,13 @@ struct mptcp_sock {
 	u64		remote_key;
 	u64		write_seq;
 	u64		ack_seq;
+	u64		rcv_data_fin_seq;
 	atomic64_t	snd_una;
 	unsigned long	timer_ival;
 	u32		token;
 	unsigned long	flags;
 	bool		can_ack;
+	bool		rcv_data_fin;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct list_head conn_list;
@@ -505,4 +507,6 @@ static inline bool subflow_simultaneous_connect(struct =
sock *sk)
 	       !subflow->conn_finished;
 }
 =

+void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk);
+
 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0f0fa1ba57a89..76d05bf05f14c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -581,7 +581,8 @@ static bool validate_mapping(struct sock *ssk, struct s=
k_buff *skb)
 	return true;
 }
 =

-static enum mapping_status get_mapping_status(struct sock *ssk)
+static enum mapping_status get_mapping_status(struct sock *ssk,
+					      struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct mptcp_ext *mpext;
@@ -631,7 +632,9 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 =

 	if (mpext->data_fin =3D=3D 1) {
 		if (data_len =3D=3D 1) {
-			pr_debug("DATA_FIN with no payload");
+			WRITE_ONCE(msk->rcv_data_fin_seq, mpext->data_seq);
+			WRITE_ONCE(msk->rcv_data_fin, 1);
+			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -643,6 +646,11 @@ static enum mapping_status get_mapping_status(struct s=
ock *ssk)
 			} else {
 				return MAPPING_DATA_FIN;
 			}
+		} else {
+			WRITE_ONCE(msk->rcv_data_fin_seq,
+				   mpext->data_seq + data_len);
+			WRITE_ONCE(msk->rcv_data_fin, 1);
+			pr_debug("DATA_FIN with mapping seq=3D%llu", mpext->data_seq + data_len=
);
 		}
 =

 		/* Adjust for DATA_FIN using 1 byte of sequence space */
@@ -731,7 +739,25 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		u64 ack_seq;
 		u64 old_ack;
 =

-		status =3D get_mapping_status(ssk);
+		if (READ_ONCE(msk->rcv_data_fin)) {
+			u64 rcv_data_fin_seq =3D READ_ONCE(msk->rcv_data_fin_seq);
+
+			ack_seq =3D READ_ONCE(msk->ack_seq);
+
+			if (ack_seq =3D=3D rcv_data_fin_seq) {
+				return false;
+			} else if (ack_seq =3D=3D rcv_data_fin_seq - 1) {
+				/* Acknowledge the received DATA_FIN
+				 * by incrementing the sequence number
+				 */
+				msk->ack_seq++;
+				mptcp_set_timeout(subflow->conn, ssk);
+				tcp_send_ack(ssk);
+				return false;
+			}
+		}
+
+		status =3D get_mapping_status(ssk, msk);
 		pr_debug("msk=3D%p ssk=3D%p status=3D%d", msk, ssk, status);
 		if (status =3D=3D MAPPING_INVALID) {
 			ssk->sk_err =3D EBADMSG;
-- =

2.27.0

--===============8947431001143228318==--

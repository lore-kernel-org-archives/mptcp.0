Content-Type: multipart/mixed; boundary="===============4668400145062720121=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v3 08/12] mptcp: Use full MPTCP-level
 disconnect state machine
Date: Thu, 23 Jul 2020 10:43:12 -0700
Message-ID: <20200723174316.131049-9-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200723174316.131049-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5267

--===============4668400145062720121==
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
 net/mptcp/options.c  | 11 ++++++
 net/mptcp/protocol.c | 87 +++++++++++++++++++++++++++++++++++++-------
 net/mptcp/subflow.c  | 11 ++++--
 3 files changed, 92 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bac38ea12b73..a8cd2cc8a9c7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -865,6 +865,17 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 	if (mp_opt.use_ack)
 		update_una(msk, &mp_opt);
 =

+	/* Zero-length packets, like bare ACKs carrying a DATA_FIN, are
+	 * dropped by the caller and not propagated to the MPTCP layer.
+	 * Copy the DATA_FIN information now.
+	 */
+	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
+		if (mp_opt.data_fin && mp_opt.data_len =3D=3D 1 &&
+		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq) &&
+		    schedule_work(&msk->work))
+			sock_hold(subflow->conn);
+	}
+
 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ce924d06963c..71d768543387 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -381,6 +381,15 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 =

 	*bytes =3D moved;
 =

+	/* If the moves have caught up with the DATA_FIN sequence number
+	 * it's time to ack the DATA_FIN and change socket state, but
+	 * this is not a good place to change state. Let the workqueue
+	 * do it.
+	 */
+	if (mptcp_pending_data_fin(sk, NULL) &&
+	    schedule_work(&msk->work))
+		sock_hold(sk);
+
 	return done;
 }
 =

@@ -466,7 +475,8 @@ void mptcp_data_acked(struct sock *sk)
 {
 	mptcp_reset_timer(sk);
 =

-	if (!sk_stream_is_writeable(sk) &&
+	if ((!sk_stream_is_writeable(sk) ||
+	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
 	    schedule_work(&mptcp_sk(sk)->work))
 		sock_hold(sk);
 }
@@ -1384,6 +1394,7 @@ static void mptcp_worker(struct work_struct *work)
 =

 	lock_sock(sk);
 	mptcp_clean_una(sk);
+	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
 	__mptcp_move_skbs(msk);
 =

@@ -1393,6 +1404,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 =

+	mptcp_check_data_fin(sk);
+
 	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		goto unlock;
 =

@@ -1518,7 +1531,7 @@ static void mptcp_cancel_work(struct sock *sk)
 		sock_put(sk);
 }
 =

-static void mptcp_subflow_shutdown(struct sock *ssk, int how)
+static void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int =
how)
 {
 	lock_sock(ssk);
 =

@@ -1531,8 +1544,15 @@ static void mptcp_subflow_shutdown(struct sock *ssk,=
 int how)
 		tcp_disconnect(ssk, O_NONBLOCK);
 		break;
 	default:
-		ssk->sk_shutdown |=3D how;
-		tcp_shutdown(ssk, how);
+		if (__mptcp_check_fallback(mptcp_sk(sk))) {
+			pr_debug("Fallback");
+			ssk->sk_shutdown |=3D how;
+			tcp_shutdown(ssk, how);
+		} else {
+			pr_debug("Sending DATA_FIN on subflow %p", ssk);
+			mptcp_set_timeout(sk, ssk);
+			tcp_send_ack(ssk);
+		}
 		break;
 	}
 =

@@ -1573,9 +1593,35 @@ static void mptcp_close(struct sock *sk, long timeou=
t)
 	LIST_HEAD(conn_list);
 =

 	lock_sock(sk);
+	sk->sk_shutdown =3D SHUTDOWN_MASK;
+
+	if (sk->sk_state =3D=3D TCP_LISTEN) {
+		inet_sk_state_store(sk, TCP_CLOSE);
+		goto cleanup;
+	} else if (sk->sk_state =3D=3D TCP_CLOSE) {
+		goto cleanup;
+	}
+
+	if (__mptcp_check_fallback(msk)) {
+		goto update_state;
+	} else if (mptcp_close_state(sk)) {
+		pr_debug("Sending DATA_FIN sk=3D%p", sk);
+		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
+		WRITE_ONCE(msk->snd_data_fin_enable, 1);
+
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+
+			mptcp_subflow_shutdown(sk, tcp_sk, SHUTDOWN_MASK);
+		}
+	}
 =

+	sk_stream_wait_close(sk, timeout);
+
+update_state:
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

+cleanup:
 	/* be sure to always acquire the join list lock, to sync vs
 	 * mptcp_finish_join().
 	 */
@@ -1584,8 +1630,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	spin_unlock_bh(&msk->join_list_lock);
 	list_splice_init(&msk->conn_list, &conn_list);
 =

-	msk->snd_data_fin_enable =3D 1;
-
 	__mptcp_clear_xmit(sk);
 =

 	release_sock(sk);
@@ -2270,11 +2314,8 @@ static int mptcp_shutdown(struct socket *sock, int h=
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
@@ -2288,13 +2329,31 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
 			sock->state =3D SS_CONNECTED;
 	}
 =

-	__mptcp_flush_join_list(msk);
-	msk->snd_data_fin_enable =3D 1;
+	/* If we've already sent a FIN, or it's a closed state, skip this. */
+	if (__mptcp_check_fallback(msk)) {
+		if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
+			inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
 =

-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		mptcp_subflow_shutdown(tcp_sk, how);
+			mptcp_subflow_shutdown(sock->sk, tcp_sk, how);
+		}
+	} else if ((how & SEND_SHUTDOWN) &&
+		   ((1 << sock->sk->sk_state) &
+		    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
+		     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) &&
+		   mptcp_close_state(sock->sk)) {
+		__mptcp_flush_join_list(msk);
+
+		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
+		WRITE_ONCE(msk->snd_data_fin_enable, 1);
+
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+
+			mptcp_subflow_shutdown(sock->sk, tcp_sk, how);
+		}
 	}
 =

 	/* Wake up anyone sleeping in poll. */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e645483d1200..7ab2a52ad150 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -598,7 +598,8 @@ static bool validate_mapping(struct sock *ssk, struct s=
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
@@ -648,7 +649,8 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 =

 	if (mpext->data_fin =3D=3D 1) {
 		if (data_len =3D=3D 1) {
-			pr_debug("DATA_FIN with no payload");
+			mptcp_update_rcv_data_fin(msk, mpext->data_seq);
+			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -660,6 +662,9 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 			} else {
 				return MAPPING_DATA_FIN;
 			}
+		} else {
+			mptcp_update_rcv_data_fin(msk, mpext->data_seq + data_len);
+			pr_debug("DATA_FIN with mapping seq=3D%llu", mpext->data_seq + data_len=
);
 		}
 =

 		/* Adjust for DATA_FIN using 1 byte of sequence space */
@@ -748,7 +753,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		u64 ack_seq;
 		u64 old_ack;
 =

-		status =3D get_mapping_status(ssk);
+		status =3D get_mapping_status(ssk, msk);
 		pr_debug("msk=3D%p ssk=3D%p status=3D%d", msk, ssk, status);
 		if (status =3D=3D MAPPING_INVALID) {
 			ssk->sk_err =3D EBADMSG;
-- =

2.27.0

--===============4668400145062720121==--

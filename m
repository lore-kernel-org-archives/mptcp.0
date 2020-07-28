Content-Type: multipart/mixed; boundary="===============0707391489115474739=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 05/12] mptcp: Track received DATA_FIN
 sequence number and add related helpers
Date: Tue, 28 Jul 2020 15:12:03 -0700
Message-ID: <20200728221210.92841-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200728221210.92841-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5345

--===============0707391489115474739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Incoming DATA_FIN headers need to propagate the presence of the DATA_FIN
bit and the associated sequence number to the MPTCP layer, even when
arriving on a bare ACK that does not get added to the receive queue. Add
structure members to store the DATA_FIN information and helpers to set
and check those values.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  |  16 +++++++
 net/mptcp/protocol.c | 106 +++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |   3 ++
 3 files changed, 115 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f157cb7e14c0..38583d1b9b5f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -782,6 +782,22 @@ static void update_una(struct mptcp_sock *msk,
 	}
 }
 =

+bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq)
+{
+	/* Skip if DATA_FIN was already received.
+	 * If updating simultaneously with the recvmsg loop, values
+	 * should match. If they mismatch, the peer is misbehaving and
+	 * we will prefer the most recent information.
+	 */
+	if (READ_ONCE(msk->rcv_data_fin) || !READ_ONCE(msk->first))
+		return false;
+
+	WRITE_ONCE(msk->rcv_data_fin_seq, data_fin_seq);
+	WRITE_ONCE(msk->rcv_data_fin, 1);
+
+	return true;
+}
+
 static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 				struct mptcp_options_received *mp_opt)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dd403ba3679a..e1c71bfd61a3 100644
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
@@ -163,6 +164,101 @@ static bool mptcp_subflow_dsn_valid(const struct mptc=
p_sock *msk,
 	return mptcp_subflow_data_available(ssk);
 }
 =

+static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (READ_ONCE(msk->rcv_data_fin) &&
+	    ((1 << sk->sk_state) &
+	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
+		u64 rcv_data_fin_seq =3D READ_ONCE(msk->rcv_data_fin_seq);
+
+		if (msk->ack_seq =3D=3D rcv_data_fin_seq) {
+			if (seq)
+				*seq =3D rcv_data_fin_seq;
+
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static void mptcp_set_timeout(const struct sock *sk, const struct sock *ss=
k)
+{
+	long tout =3D ssk && inet_csk(ssk)->icsk_pending ?
+				      inet_csk(ssk)->icsk_timeout - jiffies : 0;
+
+	if (tout <=3D 0)
+		tout =3D mptcp_sk(sk)->timer_ival;
+	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
+}
+
+static void mptcp_check_data_fin(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	u64 rcv_data_fin_seq;
+
+	if (__mptcp_check_fallback(msk) || !msk->first)
+		return;
+
+	/* Need to ack a DATA_FIN received from a peer while this side
+	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
+	 * msk->rcv_data_fin was set when parsing the incoming options
+	 * at the subflow level and the msk lock was not held, so this
+	 * is the first opportunity to act on the DATA_FIN and change
+	 * the msk state.
+	 *
+	 * If we are caught up to the sequence number of the incoming
+	 * DATA_FIN, send the DATA_ACK now and do state transition.  If
+	 * not caught up, do nothing and let the recv code send DATA_ACK
+	 * when catching up.
+	 */
+
+	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
+		struct mptcp_subflow_context *subflow;
+
+		msk->ack_seq++;
+		WRITE_ONCE(msk->rcv_data_fin, 0);
+
+		sk->sk_shutdown |=3D RCV_SHUTDOWN;
+
+		switch (sk->sk_state) {
+		case TCP_ESTABLISHED:
+			inet_sk_state_store(sk, TCP_CLOSE_WAIT);
+			break;
+		case TCP_FIN_WAIT1:
+			inet_sk_state_store(sk, TCP_CLOSING);
+			break;
+		case TCP_FIN_WAIT2:
+			inet_sk_state_store(sk, TCP_CLOSE);
+			// @@ Close subflows now?
+			break;
+		default:
+			/* Other states not expected */
+			WARN_ON_ONCE(1);
+			break;
+		}
+
+		mptcp_set_timeout(sk, NULL);
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+			lock_sock(ssk);
+			tcp_send_ack(ssk);
+			release_sock(ssk);
+		}
+
+		sk->sk_state_change(sk);
+
+		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
+		    sk->sk_state =3D=3D TCP_CLOSE)
+			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
+		else
+			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+	}
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -303,16 +399,6 @@ static void __mptcp_flush_join_list(struct mptcp_sock =
*msk)
 	spin_unlock_bh(&msk->join_list_lock);
 }
 =

-static void mptcp_set_timeout(const struct sock *sk, const struct sock *ss=
k)
-{
-	long tout =3D ssk && inet_csk(ssk)->icsk_pending ?
-				      inet_csk(ssk)->icsk_timeout - jiffies : 0;
-
-	if (tout <=3D 0)
-		tout =3D mptcp_sk(sk)->timer_ival;
-	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
-}
-
 static bool mptcp_timer_pending(struct sock *sk)
 {
 	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3f49cc105772..beb34b8a5363 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -193,12 +193,14 @@ struct mptcp_sock {
 	u64		remote_key;
 	u64		write_seq;
 	u64		ack_seq;
+	u64		rcv_data_fin_seq;
 	atomic64_t	snd_una;
 	unsigned long	timer_ival;
 	u32		token;
 	unsigned long	flags;
 	bool		can_ack;
 	bool		fully_established;
+	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
@@ -385,6 +387,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk=
);
 bool mptcp_finish_join(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
+bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq);
 =

 void __init mptcp_token_init(void);
 static inline void mptcp_token_init_request(struct request_sock *req)
-- =

2.28.0

--===============0707391489115474739==--

Content-Type: multipart/mixed; boundary="===============0509453257441434771=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 13/13] mptcp: send explicit ack on delayed
 ack_seq incr
Date: Thu, 12 Nov 2020 18:45:33 +0100
Message-ID: <7b0edf5d7a17a07e3c7a2c9f91f98e5dbc2979aa.1605199807.git.pabeni@redhat.com>
In-Reply-To: cover.1605199807.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6703

--===============0509453257441434771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the worker moves some bytes from the OoO queue into
the receive queue, the msk->ask_seq is updated, the MPTCP-level
ack carrying that value needs to wait the next ingress packet,
possibly slowing down or hanging the peer

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 05daed57ae4a..bb9a0bc7ee33 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -405,13 +405,27 @@ static void mptcp_set_timeout(const struct sock *sk, =
const struct sock *ssk)
 	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
 }
 =

-static void mptcp_check_data_fin(struct sock *sk)
+static void mptcp_send_ack(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+		tcp_send_ack(ssk);
+		release_sock(ssk);
+	}
+}
+
+static bool mptcp_check_data_fin(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	u64 rcv_data_fin_seq;
+	bool ret =3D false;
 =

 	if (__mptcp_check_fallback(msk) || !msk->first)
-		return;
+		return ret;
 =

 	/* Need to ack a DATA_FIN received from a peer while this side
 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
@@ -427,8 +441,6 @@ static void mptcp_check_data_fin(struct sock *sk)
 	 */
 =

 	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
-		struct mptcp_subflow_context *subflow;
-
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 =

@@ -452,17 +464,11 @@ static void mptcp_check_data_fin(struct sock *sk)
 			break;
 		}
 =

+		ret =3D true;
 		mptcp_set_timeout(sk, NULL);
-		mptcp_for_each_subflow(msk, subflow) {
-			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-
-			lock_sock(ssk);
-			tcp_send_ack(ssk);
-			release_sock(ssk);
-		}
-
+		mptcp_send_ack(msk);
 		if (sock_flag(sk, SOCK_DEAD))
-			return;
+			return ret;
 =

 		sk->sk_state_change(sk);
 		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
@@ -471,6 +477,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 		else
 			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 	}
+	return ret;
 }
 =

 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
@@ -1542,7 +1549,8 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	} while (!done);
 =

 	if (mptcp_ofo_queue(msk) || moved > 0) {
-		mptcp_check_data_fin((struct sock *)msk);
+		if (!mptcp_check_data_fin((struct sock *)msk))
+			mptcp_send_ack(msk);
 		return true;
 	}
 	return false;
-- =

2.26.2

--===============0509453257441434771==--

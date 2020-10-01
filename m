Content-Type: multipart/mixed; boundary="===============6886348377791584403=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 13/13] mptcp: send explicit ack on delayed ack_seq
 incr
Date: Thu, 01 Oct 2020 16:08:14 +0200
Message-ID: <70378eeeaa6cfbfe9aa810351a62c97e11948224.1601552158.git.pabeni@redhat.com>
In-Reply-To: cover.1601552158.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6140

--===============6886348377791584403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 76d5fd11d2f5..79cd8e879c10 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -395,13 +395,27 @@ static void mptcp_set_timeout(const struct sock *sk, =
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
@@ -417,8 +431,6 @@ static void mptcp_check_data_fin(struct sock *sk)
 	 */
 =

 	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
-		struct mptcp_subflow_context *subflow;
-
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 =

@@ -442,17 +454,11 @@ static void mptcp_check_data_fin(struct sock *sk)
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
@@ -461,6 +467,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 		else
 			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 	}
+	return ret;
 }
 =

 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
@@ -1522,7 +1529,8 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
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

--===============6886348377791584403==--

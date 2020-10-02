Content-Type: multipart/mixed; boundary="===============5762017797659101224=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 13/13] mptcp: send explicit ack on delayed ack_seq
 incr
Date: Fri, 02 Oct 2020 11:26:23 +0200
Message-ID: <6b46da79c7efd8cd85b971f7d4b81ffa58d08f80.1601630384.git.pabeni@redhat.com>
In-Reply-To: cover.1601630384.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6163

--===============5762017797659101224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the worker moves some bytes from the OoO queue into
the receive queue, the msk->ask_seq is updated, the MPTCP-level
ack carrying that value needs to wait the next ingress packet,
possibly slowing down or hanging the peer

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v2 -> v3:
 - add commit message ;)
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ba1209c75994..6b5a8f8d2175 100644
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
@@ -1523,7 +1530,8 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
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

--===============5762017797659101224==--

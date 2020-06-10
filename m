Content-Type: multipart/mixed; boundary="===============6705143431635737321=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix races between shutdown and recvmsg
Date: Wed, 10 Jun 2020 10:47:41 +0200
Message-ID: <766c50ce4e7e0415adaf0c63e3f92e75abb8470c.1591778786.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4628

--===============6705143431635737321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The msk sk_shutdown flag is set by a workqueue, possibly
introducing some delay in user-space notification. If the last
subflow carries some data with the fin packet, the user space
can wake-up before RCV_SHUTDOWN is set. If it executes unblocking
recvmsg(), it may return with an error instead of eof.

Address the issue explicitly checking for eof in recvmsg(), when
no data is found.

Fixes: 59832e246515 ("mptcp: subflow: check parent mptcp socket on subflow =
state change")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 45 +++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 14b253d10ccf..3980fbb6f31e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -374,6 +374,27 @@ void mptcp_subflow_eof(struct sock *sk)
 		sock_hold(sk);
 }
 =

+static void mptcp_check_for_eof(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	int receivers =3D 0;
+
+	mptcp_for_each_subflow(msk, subflow)
+		receivers +=3D !subflow->rx_eof;
+
+	if (!receivers && !(sk->sk_shutdown & RCV_SHUTDOWN)) {
+		/* hopefully temporary hack: propagate shutdown status
+		 * to msk, when all subflows agree on it
+		 */
+		sk->sk_shutdown |=3D RCV_SHUTDOWN;
+
+		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
+		set_bit(MPTCP_DATA_READY, &msk->flags);
+		sk->sk_data_ready(sk);
+	}
+}
+
 static void mptcp_stop_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -1011,6 +1032,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 				break;
 			}
 =

+			if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
+				mptcp_check_for_eof(msk);
+
 			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				break;
 =

@@ -1148,27 +1172,6 @@ static unsigned int mptcp_sync_mss(struct sock *sk, =
u32 pmtu)
 	return 0;
 }
 =

-static void mptcp_check_for_eof(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk =3D (struct sock *)msk;
-	int receivers =3D 0;
-
-	mptcp_for_each_subflow(msk, subflow)
-		receivers +=3D !subflow->rx_eof;
-
-	if (!receivers && !(sk->sk_shutdown & RCV_SHUTDOWN)) {
-		/* hopefully temporary hack: propagate shutdown status
-		 * to msk, when all subflows agree on it
-		 */
-		sk->sk_shutdown |=3D RCV_SHUTDOWN;
-
-		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
-		set_bit(MPTCP_DATA_READY, &msk->flags);
-		sk->sk_data_ready(sk);
-	}
-}
-
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
-- =

2.21.3

--===============6705143431635737321==--

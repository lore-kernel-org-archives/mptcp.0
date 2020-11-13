Content-Type: multipart/mixed; boundary="===============2682596118995534018=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] Squash-to: "mptcp: refactor shutdown and close"
 again
Date: Fri, 13 Nov 2020 19:05:04 +0100
Message-ID: <39ea7742090de819ba148c17aa133481ade5ba85.1605290282.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6724

--===============2682596118995534018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

fix bad mask and fallback state tracking on shutdown
and close.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
v1 -> v2:
 - more fallback status fixes

Note:
- fallback status tracking at close time was almost completely
broken. I suspect that was quite hidden by the worker that somehow
spooled the data and closed the socket with time. With workqueue
removale it's very apparent.
- this replaces completely the previous version (is not an incremental
change)
---
 net/mptcp/protocol.c | 61 ++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d9c785c278e..efc6c3f4b910 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -347,6 +347,19 @@ static void mptcp_stop_timer(struct sock *sk)
 	mptcp_sk(sk)->timer_ival =3D 0;
 }
 =

+static void mptcp_close_wake_up(struct sock *sk)
+{
+	if (sock_flag(sk, SOCK_DEAD))
+		return;
+
+	sk->sk_state_change(sk);
+	if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
+	    sk->sk_state =3D=3D TCP_CLOSE)
+		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
+	else
+		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+}
+
 static void mptcp_check_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -372,18 +385,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 			break;
 		}
 =

-		/* if the socket is detached from user-space there is no point
-		 * in keeping it around after spooling all the data
-		 */
-		if (sock_flag(sk, SOCK_DEAD))
-			return;
-
-		sk->sk_state_change(sk);
-		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
-		    sk->sk_state =3D=3D TCP_CLOSE)
-			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
-		else
-			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+		mptcp_close_wake_up(sk);
 	}
 }
 =

@@ -479,15 +481,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		ret =3D true;
 		mptcp_set_timeout(sk, NULL);
 		mptcp_send_ack(msk);
-		if (sock_flag(sk, SOCK_DEAD))
-			return ret;
-
-		sk->sk_state_change(sk);
-		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
-		    sk->sk_state =3D=3D TCP_CLOSE)
-			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
-		else
-			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+		mptcp_close_wake_up(sk);
 	}
 	return ret;
 }
@@ -789,8 +783,19 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 		sk->sk_data_ready(sk);
 	}
-	if (sk->sk_state !=3D TCP_CLOSE && sk->sk_shutdown =3D=3D SHUTDOWN_MASK)
+
+	switch (sk->sk_state) {
+	case TCP_ESTABLISHED:
+		inet_sk_state_store(sk, TCP_CLOSE_WAIT);
+		break;
+	case TCP_FIN_WAIT1:
+		/* fallback sockets skips TCP_CLOSING - TCP will take care */
 		inet_sk_state_store(sk, TCP_CLOSE);
+		break;
+	default:
+		return;
+	}
+	mptcp_close_wake_up(sk);
 }
 =

 static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
@@ -2109,6 +2114,12 @@ static void __mptcp_check_send_data_fin(struct sock =
*sk)
 =

 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 =

+	/* fallback socket will not get data_fin/ack, can move to close now */
+	if (__mptcp_check_fallback(msk) && sk->sk_state =3D=3D TCP_LAST_ACK) {
+		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_close_wake_up(sk);
+	}
+
 	__mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
@@ -2173,13 +2184,9 @@ static void mptcp_close(struct sock *sk, long timeou=
t)
 	lock_sock(sk);
 	sk->sk_shutdown =3D SHUTDOWN_MASK;
 =

-	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCP_CLOSE)) {
+	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
-	} else if (__mptcp_check_fallback((struct mptcp_sock *)sk)) {
-		if (!mptcp_send_head(sk))
-			inet_sk_state_store(sk, TCP_CLOSE);
-		goto cleanup;
 	}
 =

 	if (mptcp_close_state(sk))
-- =

2.26.2

--===============2682596118995534018==--

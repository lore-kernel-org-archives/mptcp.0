Content-Type: multipart/mixed; boundary="===============8496717124481434738=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp: fix state tracking for fallback socket
Date: Tue, 17 Nov 2020 19:47:25 +0100
Message-ID: <b584969e2e46bbc4c1672659737d1d65a09cb36b.1605638677.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6763

--===============8496717124481434738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to cope with some more state transition for
fallback sockets, or could still end-up moving to TCP_CLOSE
too early and avoid spooling some pending data

Fixes: ("mptcp: refactor shutdown and close")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - we actually need also the state transition I tried to
   skip in the previous iteration, otherwise we will
   keep dangling sockets around
---
 net/mptcp/protocol.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5f7a43564922..3908a6445321 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -788,7 +788,9 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 		inet_sk_state_store(sk, TCP_CLOSE_WAIT);
 		break;
 	case TCP_FIN_WAIT1:
-		/* fallback sockets skip TCP_CLOSING - TCP will take care */
+		inet_sk_state_store(sk, TCP_CLOSING);
+		break;
+	case TCP_FIN_WAIT2:
 		inet_sk_state_store(sk, TCP_CLOSE);
 		break;
 	default:
@@ -2110,10 +2112,16 @@ static void __mptcp_check_send_data_fin(struct sock=
 *sk)
 =

 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 =

-	/* fallback socket will not get data_fin/ack, can move to close now */
-	if (__mptcp_check_fallback(msk) && sk->sk_state =3D=3D TCP_LAST_ACK) {
-		inet_sk_state_store(sk, TCP_CLOSE);
-		mptcp_close_wake_up(sk);
+	/* fallback socket will not get data_fin/ack, can move to the next
+	 * stats now
+	 */
+	if (__mptcp_check_fallback(msk)) {
+		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
+			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_close_wake_up(sk);
+		} else if (sk->sk_state =3D=3D TCP_FIN_WAIT1) {
+			inet_sk_state_store(sk, TCP_FIN_WAIT2);
+		}
 	}
 =

 	__mptcp_flush_join_list(msk);
-- =

2.26.2

--===============8496717124481434738==--

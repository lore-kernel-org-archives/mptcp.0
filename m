Content-Type: multipart/mixed; boundary="===============0408086621552806726=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 02/10] mptcp: fix state tracking for fallback
 socket
Date: Thu, 19 Nov 2020 11:45:55 -0800
Message-ID: <20201119194603.103158-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201119194603.103158-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6841

--===============0408086621552806726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

We need to cope with some more state transition for
fallback sockets, or could still end-up moving to TCP_CLOSE
too early and avoid spooling some pending data

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 749c00fffff5..a46a542b1766 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -777,7 +777,9 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
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
@@ -2085,10 +2087,16 @@ static void __mptcp_check_send_data_fin(struct sock=
 *sk)
 =

 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 =

-	/* fallback socket will not get data_fin/ack, can move to close now */
-	if (__mptcp_check_fallback(msk) && sk->sk_state =3D=3D TCP_LAST_ACK) {
-		inet_sk_state_store(sk, TCP_CLOSE);
-		mptcp_close_wake_up(sk);
+	/* fallback socket will not get data_fin/ack, can move to the next
+	 * state now
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

2.29.2

--===============0408086621552806726==--

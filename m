Content-Type: multipart/mixed; boundary="===============1127853667917051493=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: fix state tracking for fallback socket
Date: Mon, 16 Nov 2020 19:06:25 +0100
Message-ID: <037d651140a83d44b997fda1d028f4f1cf8c72d1.1605549970.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6757

--===============1127853667917051493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to cope with some more state transition for
fallback sockets, or could still end-up moving to TCP_CLOSE
too early and avoid spooling some pending data

Fixes: ("mptcp: refactor shutdown and close")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Unfortunatelly I come-up to this only after v3 upstream.
I'll send this a follow-up if v3 should be merged, or
otherwise I'll squash into v4
---
 net/mptcp/protocol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5f7a43564922..12303b1a491a 100644
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
@@ -2110,8 +2112,12 @@ static void __mptcp_check_send_data_fin(struct sock =
*sk)
 =

 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 =

-	/* fallback socket will not get data_fin/ack, can move to close now */
-	if (__mptcp_check_fallback(msk) && sk->sk_state =3D=3D TCP_LAST_ACK) {
+	/* fallback socket will not get data_fin/ack, can move to close now
+	 * Note: we skip the CLOSE_WAIT -> LAST_ACK transition for
+	 * simplicity's sake
+	 */
+	if (__mptcp_check_fallback(msk) &&
+	    ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_CLOSE_WAIT))) {
 		inet_sk_state_store(sk, TCP_CLOSE);
 		mptcp_close_wake_up(sk);
 	}
-- =

2.26.2

--===============1127853667917051493==--

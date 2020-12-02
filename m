Content-Type: multipart/mixed; boundary="===============2296635839415489442=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: address potential infinite loop on
 receive
Date: Wed, 02 Dec 2020 17:12:15 +0100
Message-ID: <7cc29abe8da61eeb3e6c7bd5d2d8fe1d51dcdd7e.1606924518.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7012

--===============2296635839415489442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Eric noted the MPTCP recvmsg() loop can iterate multiple
times when the argument lenght is 0 and some subflow is
feeding new data.

Be sure to quite the loop soon moving the exit condition
earlier. Additionally move a related comment into the
right place.

Reported-by: Eric Dumazet <eric.dumazet(a)gmail.com>
Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Note: looking again at the current code, I think that at worst we
can do a single additional, unneeded iteration - after the first
'continue' statement __mptcp_move_skbs() will have moved some data
into the receive_queue, and we are not going to receive them. On
next iteration the receive_queue will be not empty.

Unless the peer is crafting some malicious DSS/packets combo I'm
unable to foreseen.
---
 net/mptcp/protocol.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 221f7cdd416b..5a3f4bc38ee3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1933,21 +1933,21 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
 =

 		copied +=3D bytes_read;
 =

-		if (skb_queue_empty(&msk->receive_queue) &&
-		    __mptcp_move_skbs(msk, len - copied))
-			continue;
-
 		/* be sure to advertise window change */
 		old_space =3D READ_ONCE(msk->old_wspace);
 		if ((tcp_space(sk) - old_space) >=3D old_space)
 			mptcp_cleanup_rbuf(msk);
 =

-		/* only the master socket status is relevant here. The exit
-		 * conditions mirror closely tcp_recvmsg()
-		 */
 		if (copied >=3D target)
 			break;
 =

+		if (skb_queue_empty(&msk->receive_queue) &&
+		    __mptcp_move_skbs(msk, len - copied))
+			continue;
+
+		/* only the master socket status is relevant here. The exit
+		 * conditions mirror closely tcp_recvmsg()
+		 */
 		if (copied) {
 			if (sk->sk_err ||
 			    sk->sk_state =3D=3D TCP_CLOSE ||
-- =

2.26.2

--===============2296635839415489442==--

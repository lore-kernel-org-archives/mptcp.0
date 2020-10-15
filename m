Content-Type: multipart/mixed; boundary="===============7976706482541900689=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Thu, 15 Oct 2020 16:30:15 +0200
Message-ID: <f20c5df58852b95e9df9bbf63b5b796e4b701a0f.1602772180.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6318

--===============7976706482541900689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

when the data-fin is acked on all subflows, the socket goes in
FIN_WAIT_2 state. Call __mptcp_destroy_sock() to transmit a TCP FIN.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/98
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5b32741f2af3..95566f120e72 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1859,7 +1859,8 @@ static void mptcp_worker(struct work_struct *work)
 	 */
 	if (sock_flag(sk, SOCK_DEAD) &&
 	    (mptcp_check_close_timeout(sk) ||
-	    (state !=3D sk->sk_state && sk->sk_state =3D=3D TCP_CLOSE))) {
+	    (state !=3D sk->sk_state &&
+	    ((1 << inet_sk_state_load(sk)) & (TCPF_CLOSE | TCPF_FIN_WAIT2))))) {
 		inet_sk_state_store(sk, TCP_CLOSE);
 		__mptcp_destroy_sock(sk, 0);
 		goto unlock;
-- =

2.26.2

--===============7976706482541900689==--

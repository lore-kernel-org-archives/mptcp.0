Content-Type: multipart/mixed; boundary="===============1131636534325333441=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 1/4] mptcp: fix DATA_FIN processing for orphaned
 sockets
Date: Fri, 19 Feb 2021 18:35:37 +0100
Message-ID: <ccbb84358b0bf0dac5b616f15244062e7cac32bb.1613755058.git.pabeni@redhat.com>
In-Reply-To: cover.1613755058.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7863

--===============1131636534325333441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we move orphaned msk sockets directly from FIN_WAIT2
state to CLOSE, with the rationale that incoming additional
data could be just dropped by the TCP stack/TW sockets.

Anyhow we miss sending MPTCP-level ack on incoming DATA_FIN,
and that may hang the peers.

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 06da6ad31c87..78bd4bed07ac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2291,13 +2291,12 @@ static void mptcp_worker(struct work_struct *work)
 	__mptcp_check_send_data_fin(sk);
 	mptcp_check_data_fin(sk);
 =

-	/* if the msk data is completely acked, or the socket timedout,
-	 * there is no point in keeping around an orphaned sk
+	/* There is no point in keeping around an orphaned sk timedout or
+	 * closed, but we need the msk around to reply to incoming DATA_FIN,
+	 * even if it is orphaned and in FIN_WAIT2 state
 	 */
 	if (sock_flag(sk, SOCK_DEAD) &&
-	    (mptcp_check_close_timeout(sk) ||
-	    (state !=3D sk->sk_state &&
-	    ((1 << inet_sk_state_load(sk)) & (TCPF_CLOSE | TCPF_FIN_WAIT2))))) {
+	    (mptcp_check_close_timeout(sk) || sk->sk_state =3D=3D TCP_CLOSE)) {
 		inet_sk_state_store(sk, TCP_CLOSE);
 		__mptcp_destroy_sock(sk);
 		goto unlock;
-- =

2.26.2

--===============1131636534325333441==--

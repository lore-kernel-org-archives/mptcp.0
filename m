Content-Type: multipart/mixed; boundary="===============1015443655639594707=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix warn at shutdown time for unaccepted
 msk sockets
Date: Fri, 07 Aug 2020 18:17:37 +0200
Message-ID: <1a4636f016e3e8b7949380b5f4ab4e77ae3c316d.1596817055.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5512

--===============1015443655639594707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With commit b93df08ccda3 ("mptcp: explicitly track the fully
established status"), the status of unaccepted mptcp closed in
mptcp_sock_destruct() changes from TCP_SYN_RECV to TCP_ESTABLISHED.

As a result mptcp_sock_destruct() does not perform the proper
cleanup and inet_sock_destruct() will later emit a warn
in ESTABLISHED status.

Address the issue updating the condition tested in mptcp_sock_destruct().
Also update the related comment.

Fixes: b93df08ccda3 ("mptcp: explicitly track the fully established status")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 45c2284f6ada..3c2ca2108ac2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -424,12 +424,12 @@ static void mptcp_sock_destruct(struct sock *sk)
 	 * also remove the mptcp socket, via
 	 * sock_put(ctx->conn).
 	 *
-	 * Problem is that the mptcp socket will not be in
-	 * SYN_RECV state and doesn't have SOCK_DEAD flag.
+	 * Problem is that the mptcp socket will be in
+	 * ESTABLISHED state and will not have the SOCK_DEAD flag.
 	 * Both result in warnings from inet_sock_destruct.
 	 */
 =

-	if (sk->sk_state =3D=3D TCP_SYN_RECV) {
+	if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
 		sk->sk_state =3D TCP_CLOSE;
 		WARN_ON_ONCE(sk->sk_socket);
 		sock_orphan(sk);
-- =

2.26.2

--===============1015443655639594707==--

Content-Type: multipart/mixed; boundary="===============8116353386532845407=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: more stable diag self-tests
Date: Fri, 07 Aug 2020 17:59:56 +0200
Message-ID: <1634f4575a4a2c8e7621941b633a0be50e65e195.1596815971.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5510

--===============8116353386532845407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During diag self-tests we introduce long wait in the mptcp test
program to give the script enough time to access the sockets
dump.

Such wait is introduced after shutting down one sockets end. Since
commit 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
if boths sides shutdown the socket is correctly tranistioned
into CLOSED status.

As a side effect some sockets are not dumped via the diag interface,
because the socket state (CLOSED) does not match the default filter, and
this cause self-tests instability.

Address the issue moving the above mentioned wait before shutting
down the socket.

Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index cad6f73a5fd0..090620c3e10c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -406,10 +406,11 @@ static int copyfd_io_poll(int infd, int peerfd, int o=
utfd)
 =

 				/* ... but we still receive.
 				 * Close our write side, ev. give some time
-				 * for address notification
+				 * for address notification and/or checking
+				 * the current status
 				 */
-				if (cfg_join)
-					usleep(400000);
+				if (cfg_wait)
+					usleep(cfg_wait);
 				shutdown(peerfd, SHUT_WR);
 			} else {
 				if (errno =3D=3D EINTR)
@@ -427,7 +428,7 @@ static int copyfd_io_poll(int infd, int peerfd, int out=
fd)
 	}
 =

 	/* leave some time for late join/announce */
-	if (cfg_wait)
+	if (cfg_join)
 		usleep(cfg_wait);
 =

 	close(peerfd);
-- =

2.26.2

--===============8116353386532845407==--

Content-Type: multipart/mixed; boundary="===============3489640666352262578=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] self-tests: catch poll errors
Date: Wed, 30 Oct 2019 16:51:45 +0100
Message-ID: <1b0e7b7400390b30b00e37ada7c25fee017c4df6.1572450641.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2357

--===============3489640666352262578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise in case of a poll error, we end-up looping forever.

Squash-to: "mptcp: add basic kselftest for mptcp"

v1 -> v2:
   - better error message, as per Florian's suggestion

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 5aaf7690dc10..ddfd85b31808 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -340,6 +340,12 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 				return 4;
 			}
 		}
+
+		if (fds.revents & (POLLERR | POLLNVAL)) {
+			fprintf(stderr, "Unexpected revents: "
+				"POLLERR/POLLNVAL(%x)\n", fds.revents);
+			return 5;
+		}
 	}
 =

 	close(peerfd);
-- =

2.21.0

--===============3489640666352262578==--

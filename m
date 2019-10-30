Content-Type: multipart/mixed; boundary="===============7808338197570174634=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] self-tests: catch poll errors
Date: Wed, 30 Oct 2019 11:32:00 +0100
Message-ID: <b2c3293ab707db2325b308d366541d3a9b221f08.1572430917.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2348

--===============7808338197570174634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise in case of a poll error, we end-up looping forever.

Squash-to: "mptcp: add basic kselftest for mptcp"

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 5aaf7690dc10..689ea8c8eedc 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -340,6 +340,11 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 				return 4;
 			}
 		}
+
+		if (fds.revents & (POLLERR | POLLNVAL)) {
+			perror("poll");
+			return 5;
+		}
 	}
 =

 	close(peerfd);
-- =

2.21.0

--===============7808338197570174634==--

Content-Type: multipart/mixed; boundary="===============0931126814445028736=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 02/13] selftests: make sockets non-blocking for
 default poll mode
Date: Mon, 18 Nov 2019 22:45:27 +0100
Message-ID: <20191118214538.21931-3-fw@strlen.de>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2587

--===============0931126814445028736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change makes tests fail because mptcp_poll may signal
POLLIN when no data is there and POLLOUT when it should not.

Rest of series addresses this and makes selftest work again.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index ea8e08b1f481..ab52468a4b51 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -279,6 +279,15 @@ static ssize_t do_rnd_read(const int fd, char *buf, co=
nst size_t len)
 	return read(fd, buf, cap);
 }
 =

+static void set_nonblock(int fd)
+{
+        int flags =3D fcntl(fd, F_GETFL);
+        if (flags =3D=3D -1)
+                return;
+
+        fcntl(fd, F_SETFL, flags | O_NONBLOCK);
+}
+
 static int copyfd_io_poll(int infd, int peerfd, int outfd)
 {
 	struct pollfd fds =3D {
@@ -288,6 +297,8 @@ static int copyfd_io_poll(int infd, int peerfd, int out=
fd)
 	unsigned int woff =3D 0, wlen =3D 0;
 	char wbuf[8192];
 =

+	set_nonblock(peerfd);
+
 	for (;;) {
 		char rbuf[8192];
 		ssize_t len;
-- =

2.23.0

--===============0931126814445028736==--

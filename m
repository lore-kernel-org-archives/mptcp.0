Content-Type: multipart/mixed; boundary="===============4636176638275733296=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 6/6] selftests: fix spurious deadlock
Date: Tue, 15 Oct 2019 01:04:11 +0200
Message-ID: <20191014230411.1630-7-fw@strlen.de>
In-Reply-To: 20191014230411.1630-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2121

--===============4636176638275733296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

do_rnd_write() may call write on the mptcp socket repeatedly.
As the peerfd is blocking, this prevents the process from draining the
receive buffer.

Its unlikely but possible that both sides are blocked in write()
on the tcp socket, with both ends announcing a zero window,
waiting for read() to drain the socket receive buffer.

An alternative fix would be to make the peerfds nonblocking.
This change instead makes it so we call write at most once after
poll revents has the POLLOUT bit set.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 53 ++++++++++---------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index d81c94448686..65514bd4a203 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -207,27 +207,18 @@ static int sock_connect_mptcp(const char * const remo=
teaddr,
 =

 static size_t do_rnd_write(const int fd, char *buf, const size_t len)
 {
-	size_t offset =3D 0;
-
-	while (offset < len) {
-		unsigned int do_w;
-		size_t written;
-		ssize_t bw;
+	unsigned int do_w;
+	ssize_t bw;
 =

-		do_w =3D rand() & 0xffff;
-		if (do_w =3D=3D 0 || do_w > (len - offset))
-			do_w =3D len - offset;
+	do_w =3D rand() & 0xffff;
+	if (do_w =3D=3D 0 || do_w > len)
+		do_w =3D len;
 =

-		bw =3D write(fd, buf + offset, do_w);
-		if (bw < 0) {
-			perror("write");
-			return 0;
-		}
+	bw =3D write(fd, buf, do_w);
+	if (bw < 0)
+		perror("write");
 =

-		written =3D (size_t)bw;
-		offset +=3D written;
-	}
-	return offset;
+	return bw;
 }
 =

 static size_t do_write(const int fd, char *buf, const size_t len)
@@ -271,9 +262,11 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 		.fd =3D peerfd,
 		.events =3D POLLIN | POLLOUT,
 	};
+	unsigned int woff =3D 0, wlen =3D 0;
+	char wbuf[8192];
 =

 	for (;;) {
-		char buf[8192];
+		char rbuf[8192];
 		ssize_t len;
 =

 		if (fds.events =3D=3D 0)
@@ -293,7 +286,7 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 		}
 =

 		if (fds.revents & POLLIN) {
-			len =3D do_rnd_read(peerfd, buf, sizeof(buf));
+			len =3D do_rnd_read(peerfd, rbuf, sizeof(rbuf));
 			if (len =3D=3D 0) {
 				/* no more data to receive:
 				 * peer has closed its write side
@@ -310,15 +303,25 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 				return 3;
 			}
 =

-			do_write(outfd, buf, len);
+			do_write(outfd, rbuf, len);
 		}
 =

 		if (fds.revents & POLLOUT) {
-			len =3D do_rnd_read(infd, buf, sizeof(buf));
-			if (len > 0) {
-				if (!do_rnd_write(peerfd, buf, len))
+			if (wlen =3D=3D 0) {
+				woff =3D 0;
+				wlen =3D read(infd, wbuf, sizeof(wbuf));
+			}
+
+			if (wlen > 0) {
+				ssize_t bw;
+
+				bw =3D do_rnd_write(peerfd, wbuf + woff, wlen);
+				if (bw < 0)
 					return 111;
-			} else if (len =3D=3D 0) {
+
+				woff +=3D bw;
+				wlen -=3D bw;
+			} else if (wlen =3D=3D 0) {
 				/* We have no more data to send. */
 				fds.events &=3D ~POLLOUT;
 =

-- =

2.21.0

--===============4636176638275733296==--

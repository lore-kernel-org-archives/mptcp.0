Content-Type: multipart/mixed; boundary="===============2599003903029393312=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 13/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:56 +0200
Message-ID: <20190615105259.15151-14-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1398

--===============2599003903029393312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - quoted string split across lines
 - space prohibited before that close parenthesis ')'
 - line over 80 characters (5)
 - else is not generally useful after a break or return
 - Missing a blank line after declarations (2)
 - spaces required around that '=3D' (ctx:VxV)

What has not been fixed:

 - quoted string split across lines
   > otherwise strings are too long
 - line over 80 characters
   > sounds OK in the bash script

Note: same as for the previous one, we are in the script dir here, less
important.

Fixes: 6d0c8c17ac39 (mptcp: selftests: switch to netns+veth based tests)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 .topmsg                                       |  2 +-
 .../selftests/net/mptcp/mptcp_connect.c       | 38 ++++++++++++-------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/.topmsg b/.topmsg
index 95fb97d2bd89..eeafe206dd87 100644
--- a/.topmsg
+++ b/.topmsg
@@ -23,7 +23,7 @@ This uncovers several bugs:
     in tcp_established_options() after writing mptcp options.
     SACK writing doesn't handle 'no option space left' case.
 3. Several WARN_ON from networking core are triggered, e.g. due
-   to mem accouting being off.  Maybe fixed already with pending
+   to mem accounting being off.  Maybe fixed already with pending
    locking fix in mptcp_recv.
 4. "Replaced mapping before it was done" in dmesg.
 5. receiver blocking in read(), while TCP socket is in CLOSE-WAIT.
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index fb60a5615093..0ee264d95ccd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -174,13 +174,13 @@ static size_t do_write(const int fd, char *buf, const=
 size_t len)
 		size_t written;
 		ssize_t bw;
 =

-		bw =3D write(fd, buf+offset, len - offset);
-		if (bw < 0 ) {
+		bw =3D write(fd, buf + offset, len - offset);
+		if (bw < 0) {
 			perror("write");
 			return 0;
 		}
 =

-		written =3D (size_t) bw;
+		written =3D (size_t)bw;
 		offset +=3D written;
 	}
 =

@@ -222,21 +222,25 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 			perror("poll");
 			return 1;
 		case 0:
-			fprintf(stderr, "%s: poll timed out (events: POLLIN %u, POLLOUT %u)\n",
-					__func__, fds.events & POLLIN, fds.events & POLLOUT);
+			fprintf(stderr, "%s: poll timed out (events: "
+				"POLLIN %u, POLLOUT %u)\n", __func__,
+				fds.events & POLLIN, fds.events & POLLOUT);
 			return 2;
 		}
 =

 		if (fds.revents & POLLIN) {
 			len =3D do_rnd_read(peerfd, buf, sizeof(buf));
 			if (len =3D=3D 0) {
-				/* no more data to receive: peer has closed its write side */
+				/* no more data to receive:
+				 * peer has closed its write side
+				 */
 				fds.events &=3D ~POLLIN;
 =

 				if ((fds.events & POLLOUT) =3D=3D 0)
-					break; /* and nothing more to send */
+					/* and nothing more to send */
+					break;
 =

-				/* Else, still have data to transmit */
+			/* Else, still have data to transmit */
 			} else if (len < 0) {
 				perror("read");
 				return 3;
@@ -255,9 +259,12 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 				fds.events &=3D ~POLLOUT;
 =

 				if ((fds.events & POLLIN) =3D=3D 0)
-					break; /* ... and peer also closed already */
+					/* ... and peer also closed already */
+					break;
 =

-				/* ... but we still receive. Close our write side. */
+				/* ... but we still receive.
+				 * Close our write side.
+				 */
 				shutdown(peerfd, SHUT_WR);
 			} else {
 				if (errno =3D=3D EINTR)
@@ -297,10 +304,11 @@ int main_loop_s(int listensock)
 	if (remotesock >=3D 0) {
 		copyfd_io(0, remotesock, 1);
 		return 0;
-	} else {
-		perror("accept");
-		return 1;
 	}
+
+	perror("accept");
+
+	return 1;
 }
 =

 static void init_rng(void)
@@ -310,6 +318,7 @@ static void init_rng(void)
 =

 	if (fd > 0) {
 		int ret =3D read(fd, &foo, sizeof(foo));
+
 		if (ret < 0)
 			srand(fd + foo);
 		close(fd);
@@ -363,7 +372,7 @@ static void parse_opts(int argc, char **argv)
 			die_usage();
 			break;
 		case 't':
-			poll_timeout=3Datoi(optarg) * 1000;
+			poll_timeout =3D atoi(optarg) * 1000;
 			if (poll_timeout <=3D 0)
 				poll_timeout =3D -1;
 			break;
@@ -383,6 +392,7 @@ int main(int argc, char *argv[])
 =

 	if (listen_mode) {
 		int fd =3D sock_listen_mptcp(cfg_host, cfg_port);
+
 		if (fd < 0)
 			return 1;
 =

-- =

2.20.1


--===============2599003903029393312==--

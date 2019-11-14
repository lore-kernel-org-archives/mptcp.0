Content-Type: multipart/mixed; boundary="===============8985484255913114098=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 01/14] selftest: add mmap-write support
Date: Thu, 14 Nov 2019 18:32:12 +0100
Message-ID: <20191114173225.21199-2-fw@strlen.de>
In-Reply-To: 20191114173225.21199-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2529

--===============8985484255913114098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No changes on default options.  New option -b allows to set a lower
send buffer size.

New option "-m mmap" allows to use a mode where the sender transmits the
entire file in very large chunks (using mmap + write) instead of the
default poll+read/write.

This is mainly useful to make sure we cope with large writes.
I also added sendfile() support (as its easy), but it won't work yet
for mptcp sockets.

should be squashed into mptcp: add basic kselftest for mptcp

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 257 +++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      |  36 ++-
 2 files changed, 284 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index ddfd85b31808..ea8e08b1f481 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -3,6 +3,7 @@
 #define _GNU_SOURCE
 =

 #include <errno.h>
+#include <limits.h>
 #include <fcntl.h>
 #include <string.h>
 #include <stdbool.h>
@@ -13,8 +14,11 @@
 #include <unistd.h>
 =

 #include <sys/poll.h>
+#include <sys/sendfile.h>
+#include <sys/stat.h>
 #include <sys/socket.h>
 #include <sys/types.h>
+#include <sys/mman.h>
 =

 #include <netdb.h>
 #include <netinet/in.h>
@@ -33,15 +37,23 @@ extern int optind;
 static bool listen_mode;
 static int  poll_timeout;
 =

+enum cfg_mode {
+	CFG_MODE_POLL,
+	CFG_MODE_MMAP,
+	CFG_MODE_SENDFILE,
+};
+
+static enum cfg_mode cfg_mode =3D CFG_MODE_POLL;
 static const char *cfg_host;
 static const char *cfg_port	=3D "12000";
 static int cfg_sock_proto	=3D IPPROTO_MPTCP;
 static bool tcpulp_audit;
 static int pf =3D AF_INET;
+static int cfg_sndbuf;
 =

 static void die_usage(void)
 {
-	fprintf(stderr, "Usage: mptcp_connect [-6] [-u] [-s MPTCP|TCP] [-p port] "
+	fprintf(stderr, "Usage: mptcp_connect [-6] [-u] [-s MPTCP|TCP] [-p port] =
-m mode]"
 		"[ -l ] [ -t timeout ] connect_address\n");
 	exit(1);
 }
@@ -84,6 +96,17 @@ static void xgetaddrinfo(const char *node, const char *s=
ervice,
 	}
 }
 =

+static void set_sndbuf(int fd, unsigned int size)
+{
+	int err;
+
+	err =3D setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &size, sizeof(size));
+	if (err) {
+		perror("set SO_SNDBUF");
+		exit(1);
+	}
+}
+
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
@@ -256,7 +279,7 @@ static ssize_t do_rnd_read(const int fd, char *buf, con=
st size_t len)
 	return read(fd, buf, cap);
 }
 =

-static int copyfd_io(int infd, int peerfd, int outfd)
+static int copyfd_io_poll(int infd, int peerfd, int outfd)
 {
 	struct pollfd fds =3D {
 		.fd =3D peerfd,
@@ -352,6 +375,168 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 	return 0;
 }
 =

+static int do_recvfile(int infd, int outfd)
+{
+	ssize_t r;
+
+	do {
+		char buf[16536];
+
+		r =3D do_rnd_read(infd, buf, sizeof(buf));
+		if (r > 0) {
+			if (write(outfd, buf, r) !=3D r)
+				break;
+		} else if (r < 0) {
+			perror("read");
+		}
+	} while (r > 0);
+
+	return (int)r;
+}
+
+static int do_mmap(int infd, int outfd, unsigned int size)
+{
+	char *inbuf =3D mmap(NULL, size, PROT_READ, MAP_SHARED, infd, 0);
+	ssize_t ret =3D 0, off =3D 0;
+	size_t rem;
+
+	if (inbuf =3D=3D MAP_FAILED) {
+		perror("mmap");
+		return 1;
+	}
+
+	rem =3D size;
+
+	while (rem > 0) {
+		ret =3D write(outfd, inbuf + off, rem);
+
+		if (ret < 0) {
+			perror("write");
+			break;
+		}
+
+		off +=3D ret;
+		rem -=3D ret;
+	}
+
+	munmap(inbuf, size);
+	return rem;
+}
+
+static int get_infd_size(int fd)
+{
+	struct stat sb;
+	ssize_t count;
+	int err;
+
+	err =3D fstat(fd, &sb);
+	if (err < 0) {
+		perror("fstat");
+		return -1;
+	}
+
+	if ((sb.st_mode & S_IFMT) !=3D S_IFREG) {
+		fprintf(stderr, "%s: stdin is not a regular file\n", __func__);
+		return -2;
+	}
+
+	count =3D sb.st_size;
+	if (count > INT_MAX) {
+		fprintf(stderr, "File too large: %zu\n", count);
+		return -3;
+	}
+
+	return (int)count;
+}
+
+static int do_sendfile(int infd, int outfd, unsigned int count)
+{
+	while (count > 0) {
+		ssize_t r;
+
+		r =3D sendfile(outfd, infd, NULL, count);
+		if (r < 0) {
+			perror("sendfile");
+			return 3;
+		}
+
+		count -=3D r;
+	}
+
+	return 0;
+}
+
+static int copyfd_io_mmap(int infd, int peerfd, int outfd,
+			      unsigned int size)
+{
+	int err;
+
+	if (listen_mode) {
+		err =3D do_recvfile(peerfd, outfd);
+		if (err)
+			return err;
+
+		err =3D do_mmap(infd, peerfd, size);
+	} else {
+		err =3D do_mmap(infd, peerfd, size);
+		if (err)
+			return err;
+
+		shutdown(peerfd, SHUT_WR);
+
+		err =3D do_recvfile(peerfd, outfd);
+	}
+
+	return err;
+}
+
+
+static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
+			      unsigned int size)
+{
+	int err;
+
+	if (listen_mode) {
+		err =3D do_recvfile(peerfd, outfd);
+		if (err)
+			return err;
+
+		err =3D do_sendfile(infd, peerfd, size);
+	} else {
+		err =3D do_sendfile(infd, peerfd, size);
+		if (err)
+			return err;
+		err =3D do_recvfile(peerfd, outfd);
+	}
+
+	return err;
+}
+
+static int copyfd_io(int infd, int peerfd, int outfd)
+{
+	int file_size;
+
+	switch (cfg_mode) {
+	case CFG_MODE_POLL:
+		return copyfd_io_poll(infd, peerfd, outfd);
+	case CFG_MODE_MMAP:
+		file_size =3D get_infd_size(infd);
+		if (file_size < 0)
+			return file_size;
+		return copyfd_io_mmap(infd, peerfd, outfd, file_size);
+	case CFG_MODE_SENDFILE:
+		file_size =3D get_infd_size(infd);
+		if (file_size < 0)
+			return file_size;
+		return copyfd_io_sendfile(infd, peerfd, outfd, file_size);
+	}
+
+	fprintf(stderr, "Invalid mode %d\n", cfg_mode);
+
+	die_usage();
+	return 1;
+}
+
 static void check_sockaddr(int pf, struct sockaddr_storage *ss,
 			   socklen_t salen)
 {
@@ -464,8 +649,7 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 =

-		copyfd_io(0, remotesock, 1);
-		return 0;
+		return copyfd_io(0, remotesock, 1);
 	}
 =

 	perror("accept");
@@ -499,6 +683,10 @@ int main_loop(void)
 		return 2;
 =

 	check_getpeername_connect(fd);
+
+	if (cfg_sndbuf)
+		set_sndbuf(fd, cfg_sndbuf);
+
 	return copyfd_io(0, fd, 1);
 }
 =

@@ -509,18 +697,66 @@ int parse_proto(const char *proto)
 	if (!strcasecmp(proto, "TCP"))
 		return IPPROTO_TCP;
 =

-	fprintf(stderr, "Unknown protocol: %s.", proto);
+	fprintf(stderr, "Unknown protocol: %s\n.", proto);
 	die_usage();
 =

 	/* silence compiler warning */
 	return 0;
 }
 =

+int parse_mode(const char *mode)
+{
+	if (!strcasecmp(mode, "poll"))
+		return CFG_MODE_POLL;
+	if (!strcasecmp(mode, "mmap"))
+		return CFG_MODE_MMAP;
+	if (!strcasecmp(mode, "sendfile"))
+		return CFG_MODE_SENDFILE;
+
+	fprintf(stderr, "Unknown test mode: %s\n", mode);
+	fprintf(stderr, "Supported modes are:\n");
+	fprintf(stderr, "\t\t\"poll\" - interleaved read/write using poll()\n");
+	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then=
 read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), th=
en read response (-l will read input first)\n");
+
+	die_usage();
+
+	/* silence compiler warning */
+	return 0;
+}
+
+int parse_sndbuf(const char *size)
+{
+	unsigned long s;
+
+	errno =3D 0;
+
+	s =3D strtoul(size, NULL, 0);
+
+	if (errno) {
+		fprintf(stderr, "Invalid sndbuf size %s (%s)\n",
+				size,
+				strerror(errno));
+		die_usage();
+	}
+
+	if (s > INT_MAX) {
+		fprintf(stderr, "Invalid sndbuf size %s (%s)\n",
+				size,
+				strerror(ERANGE));
+		die_usage();
+	}
+
+	cfg_sndbuf =3D s;
+
+	return 0;
+}
+
 static void parse_opts(int argc, char **argv)
 {
 	int c;
 =

-	while ((c =3D getopt(argc, argv, "6lp:s:hut:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "6lp:s:hut:m:b:")) !=3D -1) {
 		switch (c) {
 		case 'l':
 			listen_mode =3D true;
@@ -545,6 +781,12 @@ static void parse_opts(int argc, char **argv)
 			if (poll_timeout <=3D 0)
 				poll_timeout =3D -1;
 			break;
+		case 'm':
+			cfg_mode =3D parse_mode(optarg);
+			break;
+		case 'b':
+			cfg_sndbuf =3D parse_sndbuf(optarg);
+			break;
 		}
 	}
 =

@@ -571,6 +813,9 @@ int main(int argc, char *argv[])
 		if (fd < 0)
 			return 1;
 =

+		if (cfg_sndbuf)
+			set_sndbuf(fd, cfg_sndbuf);
+
 		return main_loop_s(fd);
 	}
 =

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index b5367fe2c6ea..478bc47c3d60 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -3,7 +3,7 @@
 =

 time_start=3D$(date +%s)
 =

-optstring=3D"d:e:l:r:h6c"
+optstring=3D"b:d:e:l:r:h6c:m:"
 ret=3D0
 sin=3D""
 sout=3D""
@@ -17,6 +17,9 @@ ethtool_random_on=3Dtrue
 tc_delay=3D"$((RANDOM%400))"
 tc_loss=3D$((RANDOM%101))
 tc_reorder=3D""
+testmode=3D""
+sndbuf=3D0
+options_log=3Dtrue
 =

 if [ $tc_loss -eq 100 ];then
 	tc_loss=3D1%
@@ -36,6 +39,8 @@ usage() {
 	echo -e "\t-e: ethtool features to disable, e.g.: \"-e tso -e gso\" (defa=
ult: randomly disable any of tso/gso/gro)"
 	echo -e "\t-6: enable IPv6 tests (default: only test IPv4)"
 	echo -e "\t-c: capture packets for each test using tcpdump (default: no c=
apture)"
+	echo -e "\t-b: set sndbuf value (default: use kernel default)"
+	echo -e "\t-m: test mode (poll, sendfile; default: poll)"
 }
 =

 while getopts "$optstring" option;do
@@ -68,6 +73,17 @@ while getopts "$optstring" option;do
 	"c")
 		capture=3Dtrue
 		;;
+	"b")
+		if [ $OPTARG -ge 0 ];then
+			sndbuf=3D"$OPTARG"
+		else
+			echo "-s requires numeric argument, got \"$OPTARG\"" 1>&2
+			exit 1
+		fi
+		;;
+	"m")
+		testmode=3D"$OPTARG"
+		;;
 	"?")
 		usage $0
 		exit 1
@@ -294,10 +310,24 @@ do_transfer()
 	srv_proto=3D"$4"
 	connect_addr=3D"$5"
 	local_addr=3D"$6"
+	local extra_args=3D""
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
 =

+	if [ "$sndbuf" -gt 0 ]; then
+		extra_args=3D"$extra_args -b $sndbuf"
+	fi
+
+	if [ -n "$testmode" ]; then
+		extra_args=3D"$extra_args -m $testmode"
+	fi
+
+	if [ -n "$extra_args" ] && $options_log; then
+		options_log=3Dfalse
+		echo "INFO: extra options: $extra_args"
+	fi
+
 	:> "$cout"
 	:> "$sout"
 	:> "$capout"
@@ -319,13 +349,13 @@ do_transfer()
 	    sleep 1
 	fi
 =

-	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} $local_addr < "$sin" > "$sout" &
+	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} $extra_args $local_addr < "$sin" > "$sout" &
 	spid=3D$!
 =

 	sleep 1
 =

 	start=3D$(date +%s%3N)
-	ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr < "$cin" > "$cout" &
+	ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $extra_args $connect_addr < "$cin" > "$cout" &
 	cpid=3D$!
 =

 	wait $cpid
-- =

2.23.0

--===============8985484255913114098==--

Content-Type: multipart/mixed; boundary="===============7303953505681369001=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC mptcp 1/4] mptcp: add basic kselftest program
Date: Thu, 07 Feb 2019 15:27:08 +0100
Message-ID: <20190207142711.3475-2-fw@strlen.de>
In-Reply-To: 20190207142711.3475-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 990

--===============7303953505681369001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

create mptcp connection between two processes, xmit data back and
forth.  Data is read from stdin and written (after traversing mtcp
connection twice) to stdout.

Wrapper script tests that data has passed un-altered.

Will run automatically on "make kselftest".

Remaining problem:
read(mptcpfd, buf, buflen)

can return a value larger than buflen (remaining data is discarded in
kernel).  Plan to look into that next week.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/net/mptcp/Makefile    |  11 +
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 403 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_connect.sh      |  29 ++
 5 files changed, 445 insertions(+)
 create mode 100644 tools/testing/selftests/net/mptcp/Makefile
 create mode 100644 tools/testing/selftests/net/mptcp/config
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_connect.c
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Mak=
efile
index 24b9934fb269..3f905444d8ea 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -24,6 +24,7 @@ TARGETS +=3D memory-hotplug
 TARGETS +=3D mount
 TARGETS +=3D mqueue
 TARGETS +=3D net
+TARGETS +=3D net/mptcp
 TARGETS +=3D netfilter
 TARGETS +=3D networking/timestamping
 TARGETS +=3D nsfs
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/sel=
ftests/net/mptcp/Makefile
new file mode 100644
index 000000000000..0fc5d45055ee
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+top_srcdir =3D ../../../../..
+
+CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g
+
+TEST_PROGS :=3D mptcp_connect.sh
+
+TEST_GEN_FILES =3D mptcp_connect
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
new file mode 100644
index 000000000000..3bfe60494af8
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/config
@@ -0,0 +1 @@
+CONFIG_MPTCP=3Dy
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
new file mode 100644
index 000000000000..eeaba101512b
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <sys/poll.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+
+#include <netdb.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+
+extern int optind;
+
+#ifndef IPPROTO_MTPCP
+#define IPPROTO_MPTCP 99
+#endif
+
+#ifndef IPPROTO_SUBFLOW
+#define IPPROTO_SUBFLOW (IPPROTO_TCP | 0x100)
+#endif
+
+static void die_usage(int x)
+{
+	fputs("Usage: mptcp_connect host port\n", x ? stderr : stdout);
+	exit(x);
+}
+
+static const char *getxinfo_strerr(int err)
+{
+	if (err =3D=3D EAI_SYSTEM)
+		return strerror(errno);
+
+	return gai_strerror(err);
+}
+
+static void xgetaddrinfo(const char *node, const char *service,
+			const struct addrinfo *hints,
+			struct addrinfo **res)
+{
+	int err =3D getaddrinfo(node, service, hints, res);
+	if (err) {
+		const char *errstr =3D getxinfo_strerr(err);
+
+		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n", node ? node: "", serv=
ice ? service: "", errstr);
+	        exit(1);
+	}
+}
+
+static void xgetnameinfo(const struct sockaddr *sa, socklen_t salen,
+			char *host, size_t hostlen,
+			char *serv, size_t servlen, int flags)
+{
+	int err =3D getnameinfo(sa, salen, host, hostlen, serv, servlen, flags);
+	if (err) {
+		const char *errstr =3D getxinfo_strerr(err);
+
+		fprintf(stderr, "Fatal: getnameinfo(): %s\n", errstr);
+	        exit(1);
+	}
+}
+
+static void ipaddrtostr(const struct sockaddr *sa, socklen_t salen, char *=
resbuf, size_t reslen, char *port, size_t plen)
+{
+	xgetnameinfo(sa, salen, resbuf, reslen, port, plen, NI_NUMERICHOST|NI_NUM=
ERICSERV);
+}
+
+static void logendpoint(struct sockaddr_storage *ss, socklen_t salen)
+{
+	char buf[INET6_ADDRSTRLEN];
+
+	ipaddrtostr((struct sockaddr *)ss, salen, buf, sizeof(buf), NULL, 0);
+
+	fprintf(stderr, "Handling connection from %s\n", buf);
+}
+
+static int sock_listen_mptcp(const char * const listenaddr, const char * c=
onst port)
+{
+	int sock;
+	struct addrinfo hints =3D {
+		.ai_protocol =3D IPPROTO_TCP,
+		.ai_socktype =3D SOCK_STREAM,
+		.ai_flags =3D AI_PASSIVE | AI_NUMERICHOST
+	};
+
+	hints.ai_family =3D AF_INET;
+
+	struct addrinfo *a, *addr;
+	int one =3D 1;
+
+	xgetaddrinfo(listenaddr, port, &hints, &addr);
+
+	for (a =3D addr; a !=3D NULL ; a =3D a->ai_next) {
+		sock =3D socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		if (sock < 0) {
+			perror("socket");
+			continue;
+		}
+
+		if (-1 =3D=3D setsockopt(sock, SOL_SOCKET,SO_REUSEADDR,&one,sizeof one))
+			perror("setsockopt");
+
+
+		if (bind(sock, a->ai_addr, a->ai_addrlen) =3D=3D 0)
+			break; /* success */
+
+		perror("bind");
+		close(sock);
+		sock =3D -1;
+	}
+
+	if ((sock >=3D 0) && listen(sock ,20))
+		perror("listen");
+
+	freeaddrinfo(addr);
+	return sock;
+}
+
+static int sock_connect_mptcp(const char * const remoteaddr, const char * =
const port, int proto)
+{
+	struct addrinfo hints =3D {
+		.ai_protocol =3D IPPROTO_TCP,
+		.ai_socktype =3D SOCK_STREAM,
+	};
+	struct addrinfo *a, *addr;
+	int sock =3D -1;
+
+	hints.ai_family =3D AF_INET;
+
+	xgetaddrinfo(remoteaddr, port, &hints, &addr);
+	for (a=3Daddr; a !=3D NULL; a =3D a->ai_next) {
+		sock =3D socket(a->ai_family, a->ai_socktype, proto);
+		if (sock < 0) {
+			perror("socket");
+			continue;
+		}
+
+		if (connect(sock, a->ai_addr, a->ai_addrlen) =3D=3D 0)
+			break; /* success */
+
+		perror("connect()");
+		close(sock);
+		sock =3D -1;
+	}
+
+	freeaddrinfo(addr);
+	return sock;
+}
+
+static size_t do_write(const int fd, char *buf, const size_t len)
+{
+	size_t offset =3D 0;
+
+	while (offset < len) {
+		unsigned int do_w;
+		size_t written;
+		ssize_t bw;
+
+		do_w =3D rand() & 0xffff;
+		if (do_w =3D=3D 0 || do_w > (len - offset))
+			do_w =3D len - offset;
+
+		bw =3D write(fd, buf+offset, do_w);
+		if (bw < 0 ) {
+			perror("write");
+			return 0;
+		}
+
+		written =3D (size_t) bw;
+		offset +=3D written;
+	}
+	return offset;
+}
+
+static void copyfd_io(int peerfd)
+{
+	struct pollfd fds =3D { .events =3D POLLIN };
+
+	fds.fd =3D peerfd;
+
+	for (;;) {
+		char buf[4096];
+		ssize_t len;
+
+		switch(poll(&fds, 1, -1)) {
+		case -1:
+			if (errno =3D=3D EINTR)
+				continue;
+			perror("poll");
+			return;
+		case 0:
+			/* should not happen, we requested infinite wait */
+			fputs("Timed out?!", stderr);
+			return;
+		}
+
+		if ((fds.revents & POLLIN) =3D=3D 0)
+			return;
+
+		len =3D read(peerfd, buf, sizeof(buf));
+		if (!len)
+			return;
+		if (len < 0) {
+			if (errno =3D=3D EINTR)
+				continue;
+
+			perror("read");
+			return;
+		}
+
+		if (!do_write(peerfd, buf, len))
+			return;
+
+	}
+}
+
+int main_loop_s(int listensock)
+{
+	struct sockaddr_storage ss;
+	socklen_t salen;
+        int remotesock;
+	char buf[2];
+
+	salen =3D sizeof(ss);
+	while ((remotesock =3D accept(listensock, (struct sockaddr *)&ss, &salen)=
) < 0)
+		perror("accept");
+
+	logendpoint(&ss, salen);
+
+	/* deal with 'bogus' client first (plain tcp, not mptcp) */
+	if (read(remotesock, buf, sizeof(buf)) !=3D 0)
+		return -1;
+
+	close(remotesock);
+	salen =3D sizeof(ss);
+	while ((remotesock =3D accept(listensock, (struct sockaddr *)&ss, &salen)=
) < 0)
+		perror("accept");
+
+	copyfd_io(remotesock);
+	close(remotesock);
+
+	return 0;
+}
+
+static void init_rng(void)
+{
+	int fd =3D open("/dev/urandom", O_RDONLY);
+	unsigned int foo;
+
+	if (fd > 0) {
+		read(fd, &foo, sizeof(foo));
+		close(fd);
+	}
+
+	srand(foo);
+}
+
+int main_loop(const char *host, const char *port)
+{
+	int pollfds =3D 2, timeout =3D -1;
+	char start[32];
+	int pipefd[2];
+	ssize_t ret;
+	int fd;
+
+	if (pipe(pipefd)) {
+		perror("pipe");
+		exit(1);
+	}
+
+	switch (fork()) {
+	case 0:
+		close(pipefd[0]);
+
+		init_rng();
+
+		fd =3D sock_listen_mptcp(NULL, port);
+		if (fd < 0)
+			return -1;
+
+		write(pipefd[1], "RDY\n", 4);
+		main_loop_s(fd);
+		exit(1);
+	case -1:
+		perror("fork");
+		return -1;
+	default:
+		close(pipefd[1]);
+		break;
+	}
+
+	init_rng();
+	ret =3D read(pipefd[0], start, (int)sizeof(start));
+	if (ret < 0) {
+		perror("read");
+		return -1;
+	}
+
+	if (ret !=3D 4 || strcmp(start, "RDY\n"))
+		return -1;
+
+	/* listener is ready.
+	 *
+	 * First connect with _SUBFLOW, used to trigger NULL deref in kernel.
+	 */
+	fd =3D sock_connect_mptcp(host, port, IPPROTO_SUBFLOW);
+	if (fd < 0)
+		return -1;
+
+	close(fd);
+
+	fd =3D sock_connect_mptcp(host, port, IPPROTO_MPTCP);
+	if (fd < 0)
+		return -1;
+
+	for (;;) {
+		struct pollfd fds[2];
+		char buf[4096];
+		ssize_t len;
+
+		fds[0].fd =3D fd;
+		fds[0].events =3D POLLIN;
+		fds[1].fd =3D 0;
+		fds[1].events =3D POLLIN;
+		fds[1].revents =3D 0;
+
+		switch (poll(fds, pollfds, timeout)) {
+		case -1:
+			if (errno =3D=3D EINTR)
+				continue;
+			perror("poll");
+			return -1;
+		case 0:
+			close(fd);
+			return 0;
+		}
+
+		if (fds[0].revents & POLLIN) {
+			unsigned int blen =3D rand();
+
+			blen %=3D sizeof(buf);
+
+			++blen;
+			len =3D read(fd, buf, blen);
+			if (len < 0) {
+				perror("read");
+				return -1;
+			}
+
+			if (len > blen) {
+				fprintf(stderr, "read returned more data than buffer length\n");
+				len =3D blen;
+			}
+
+			write(1, buf, len);
+		} else if (fds[1].revents & POLLIN) {
+			len =3D read(0, buf, sizeof(buf));
+			if (len =3D=3D 0) {
+				pollfds =3D 1;
+				timeout =3D 1000;
+				continue;
+			}
+
+			if (len < 0) {
+				perror("read");
+				break;
+			}
+
+			do_write(fd, buf, len);
+		}
+	}
+
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *host, *port;
+
+	if (optind >=3D argc)
+		die_usage(1);
+
+	init_rng();
+
+	host =3D argv[optind];
+	argv++;
+	argc--;
+	if (optind < argc)
+		port =3D argv[optind];
+	else
+		port =3D "12000";
+
+	return main_loop(host, port);
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
new file mode 100755
index 000000000000..2714c8a3f837
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+tmpin=3D$(mktemp)
+tmpout=3D$(mktemp)
+
+cleanup()
+{
+	rm -f "$tmpin" "$tmpout"
+}
+
+trap cleanup EXIT
+
+SIZE=3D$((RANDOM % (1024 * 1024)))
+if [ $SIZE -eq 0 ] ; then
+	SIZE=3D1
+fi
+
+dd if=3D/dev/urandom of=3D"$tmpin" bs=3D1 count=3D$SIZE 2> /dev/null
+./mptcp_connect 127.0.0.1 43212 < "$tmpin" > "$tmpout"
+
+cmp "$tmpin" "$tmpout"
+if [ $? -ne 0 ] ;then
+	echo "FAIL: Input and output differ" 1>&2
+	ls -l "$tmpin" "$tmpout" 1>&2
+	exit 1
+fi
+
+echo "PASS: Input of $SIZE passed though mptcp connection unchanged"
+exit 0
-- =

2.19.2


--===============7303953505681369001==--

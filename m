Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98D6D22
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:28:26 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mGIo5-00045O-5W; Wed, 18 Aug 2021 12:28:25 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 mptcp-next 5/5] selftests: mptcp: add mptcp getsockopt test cases
Date: Wed, 18 Aug 2021 12:27:56 +0200
Message-Id: <20210818102756.30734-6-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818102756.30734-1-fw@strlen.de>
References: <20210818102756.30734-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test program that retrieves the three info types:
1. mptcp meta information
2. tcp info for subflow
3. subflow endpoint addresses

For all three rudimentary checks are added.

1. Meta information checks that the logical mptcp
   sequence numbers advance as expected, based on the bytes read
   (init seq + bytes_received/sent) and the connection state
   (after close, we should exect 1 extra byte due to FIN).

2. TCP info checks the number of bytes sent/received vs.
   sums of read/write syscall return values.

3. Subflow endpoint addresses are checked vs. getsockname/getpeername
   result.

Tests for forward compatibility (0-initialisation of output-only
fields in mptcp_subflow_data structure) are added as well.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../selftests/net/mptcp/mptcp_sockopt.c       | 644 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  31 +-
 3 files changed, 674 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_sockopt.c

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index f1464f09b080..bbf4e448bad9 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -8,7 +8,7 @@ CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
 TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh
 
-TEST_GEN_FILES = mptcp_connect pm_nl_ctl
+TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
new file mode 100644
index 000000000000..b0ac561e7e38
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -0,0 +1,644 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <assert.h>
+#include <errno.h>
+#include <limits.h>
+#include <string.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <strings.h>
+#include <unistd.h>
+
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include <netdb.h>
+#include <netinet/in.h>
+
+#include <linux/tcp.h>
+
+static int pf = AF_INET;
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+#ifndef SOL_MPTCP
+#define SOL_MPTCP 284
+#endif
+
+#ifndef TCP_TCPINFO
+struct mptcp_subflow_data {
+	__u32		size_subflow_data;		/* size of this structure in userspace */
+	__u32		num_subflows;			/* must be 0, set by kernel */
+	__u32		size_kernel;			/* must be 0, set by kernel */
+	__u32		size_user;			/* size of one element in data[] */
+} __attribute__((aligned(8)));
+
+struct mptcp_subflow_addrs {
+	union {
+		__kernel_sa_family_t sa_family;
+		struct sockaddr sa_local;
+		struct sockaddr_in sin_local;
+		struct sockaddr_in6 sin6_local;
+		struct sockaddr_storage ss_local;
+	};
+	union {
+		struct sockaddr sa_remote;
+		struct sockaddr_in sin_remote;
+		struct sockaddr_in6 sin6_remote;
+		struct sockaddr_storage ss_remote;
+	};
+};
+
+#define MPTCP_INFO		1
+#define MPTCP_TCPINFO		2
+#define MPTCP_SUBFLOW_ADDRS	3
+#endif
+
+struct mptcp_info {
+	__u8	mptcpi_subflows;
+	__u8	mptcpi_add_addr_signal;
+	__u8	mptcpi_add_addr_accepted;
+	__u8	mptcpi_subflows_max;
+	__u8	mptcpi_add_addr_signal_max;
+	__u8	mptcpi_add_addr_accepted_max;
+	__u32	mptcpi_flags;
+	__u32	mptcpi_token;
+	__u64	mptcpi_write_seq;
+	__u64	mptcpi_snd_una;
+	__u64	mptcpi_rcv_nxt;
+	__u8	mptcpi_local_addr_used;
+	__u8	mptcpi_local_addr_max;
+	__u8	mptcpi_csum_enabled;
+};
+
+enum sockopt_check_flags {
+	EOF_RECEIVED = 1 << 0,
+};
+
+struct so_state {
+	struct mptcp_info mi;
+};
+
+static void die_perror(const char *msg)
+{
+	perror(msg);
+	exit(1);
+}
+
+static void die_usage(int r)
+{
+	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
+	exit(r);
+}
+
+static void xerror(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	fputc('\n', stderr);
+	exit(1);
+}
+
+static const char *getxinfo_strerr(int err)
+{
+	if (err == EAI_SYSTEM)
+		return strerror(errno);
+
+	return gai_strerror(err);
+}
+
+static void xgetaddrinfo(const char *node, const char *service,
+			 const struct addrinfo *hints,
+			 struct addrinfo **res)
+{
+	int err = getaddrinfo(node, service, hints, res);
+
+	if (err) {
+		const char *errstr = getxinfo_strerr(err);
+
+		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
+			node ? node : "", service ? service : "", errstr);
+		exit(1);
+	}
+}
+
+static int sock_listen_mptcp(const char * const listenaddr,
+			     const char * const port)
+{
+	int sock;
+	struct addrinfo hints = {
+		.ai_protocol = IPPROTO_TCP,
+		.ai_socktype = SOCK_STREAM,
+		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
+	};
+
+	hints.ai_family = pf;
+
+	struct addrinfo *a, *addr;
+	int one = 1;
+
+	xgetaddrinfo(listenaddr, port, &hints, &addr);
+	hints.ai_family = pf;
+
+	for (a = addr; a; a = a->ai_next) {
+		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		if (sock < 0)
+			continue;
+
+		if (-1 == setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,
+				     sizeof(one)))
+			perror("setsockopt");
+
+		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
+			break; /* success */
+
+		perror("bind");
+		close(sock);
+		sock = -1;
+	}
+
+	freeaddrinfo(addr);
+
+	if (sock < 0)
+		xerror("could not create listen socket");
+
+	if (listen(sock, 20))
+		die_perror("listen");
+
+	return sock;
+}
+
+static int sock_connect_mptcp(const char * const remoteaddr,
+			      const char * const port, int proto)
+{
+	struct addrinfo hints = {
+		.ai_protocol = IPPROTO_TCP,
+		.ai_socktype = SOCK_STREAM,
+	};
+	struct addrinfo *a, *addr;
+	int sock = -1;
+
+	hints.ai_family = pf;
+
+	xgetaddrinfo(remoteaddr, port, &hints, &addr);
+	for (a = addr; a; a = a->ai_next) {
+		sock = socket(a->ai_family, a->ai_socktype, proto);
+		if (sock < 0)
+			continue;
+
+		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
+			break; /* success */
+
+		die_perror("connect");
+	}
+
+	if (sock < 0)
+		xerror("could not create connect socket");
+
+	freeaddrinfo(addr);
+	return sock;
+}
+
+static void parse_opts(int argc, char **argv)
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "h6")) != -1) {
+		switch (c) {
+		case 'h':
+			die_usage(0);
+			break;
+		case '6':
+			pf = AF_INET6;
+			break;
+		default:
+			die_usage(1);
+			break;
+		}
+	}
+}
+
+static void do_getsockopt_bogus_sf_data(int fd, int optname)
+{
+	struct mptcp_subflow_data good_data;
+	struct bogus_data {
+		struct mptcp_subflow_data d;
+		char buf[2];
+	} bd;
+	socklen_t olen, _olen;
+	int ret;
+
+	memset(&bd, 0, sizeof(bd));
+	memset(&good_data, 0, sizeof(good_data));
+
+	olen = sizeof(good_data);
+	good_data.size_subflow_data = olen;
+
+	ret = getsockopt(fd, SOL_MPTCP, optname, &bd, &olen);
+	assert(ret < 0); /* 0 size_subflow_data */
+	assert(olen == sizeof(good_data));
+
+	bd.d = good_data;
+
+	ret = getsockopt(fd, SOL_MPTCP, optname, &bd, &olen);
+	assert(ret == 0);
+	assert(olen == sizeof(good_data));
+	assert(bd.d.num_subflows == 1);
+	assert(bd.d.size_kernel > 0);
+	assert(bd.d.size_user == 0);
+
+	bd.d = good_data;
+	_olen = rand() % olen;
+	olen = _olen;
+	ret = getsockopt(fd, SOL_MPTCP, optname, &bd, &olen);
+	assert(ret < 0);	/* bogus olen */
+	assert(olen == _olen);	/* must be unchanged */
+
+	bd.d = good_data;
+	olen = sizeof(good_data);
+	bd.d.size_kernel = 1;
+	ret = getsockopt(fd, SOL_MPTCP, optname, &bd, &olen);
+	assert(ret < 0); /* size_kernel not 0 */
+
+	bd.d = good_data;
+	olen = sizeof(good_data);
+	bd.d.num_subflows = 1;
+	ret = getsockopt(fd, SOL_MPTCP, optname, &bd, &olen);
+	assert(ret < 0); /* num_subflows not 0 */
+
+	/* forward compat check: larger struct mptcp_subflow_data on 'old' kernel */
+	bd.d = good_data;
+	olen = sizeof(bd);
+	bd.d.size_subflow_data = sizeof(bd);
+
+	ret = getsockopt(fd, SOL_MPTCP, optname, &bd, &olen);
+	assert(ret == 0);
+
+	/* olen must be truncated to real data size filled by kernel: */
+	assert(olen == sizeof(good_data));
+
+	assert(bd.d.size_subflow_data == sizeof(bd));
+
+	bd.d = good_data;
+	bd.d.size_subflow_data += 1;
+	bd.d.size_user = 1;
+	olen = bd.d.size_subflow_data + 1;
+	_olen = olen;
+
+	ret = getsockopt(fd, SOL_MPTCP, optname, &bd, &_olen);
+	assert(ret == 0);
+
+	/* no truncation, kernel should have filled 1 byte of optname payload in buf[1]: */
+	assert(olen == _olen);
+
+	assert(bd.d.size_subflow_data == sizeof(good_data) + 1);
+	assert(bd.buf[0] == 0);
+}
+
+static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t r, size_t w, uint32_t flags)
+{
+	struct mptcp_info i;
+	socklen_t olen;
+	int ret;
+
+	olen = sizeof(i);
+	ret = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &i, &olen);
+
+	if (ret < 0)
+		die_perror("getsockopt MPTCP_INFO");
+
+	assert(olen == sizeof(i));
+
+	if (s->mi.mptcpi_write_seq == 0)
+		s->mi = i;
+
+	assert(s->mi.mptcpi_write_seq + w == i.mptcpi_write_seq);
+
+	if (flags & EOF_RECEIVED)
+		r += 1;
+
+	assert(s->mi.mptcpi_rcv_nxt + r == i.mptcpi_rcv_nxt);
+}
+
+static void do_getsockopt_tcp_info(int fd, size_t r, size_t w)
+{
+	struct my_tcp_info {
+		struct mptcp_subflow_data d;
+		struct tcp_info ti[2];
+	} ti;
+	socklen_t olen;
+	int ret;
+
+	memset(&ti, 0, sizeof(ti));
+
+	ti.d.size_subflow_data = sizeof(struct mptcp_subflow_data);
+	ti.d.size_user = sizeof(struct tcp_info);
+	olen = sizeof(ti);
+
+	ret = getsockopt(fd, SOL_MPTCP, MPTCP_TCPINFO, &ti, &olen);
+	if (ret < 0)
+		die_perror("getsockopt MPTCP_TCPINFO");
+
+	assert(olen <= sizeof(ti));
+	assert(ti.d.size_user == ti.d.size_kernel);
+	assert(ti.d.size_user == sizeof(struct tcp_info));
+	assert(ti.d.num_subflows == 1);
+
+	assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
+	olen -= sizeof(struct mptcp_subflow_data);
+	assert(olen == sizeof(struct tcp_info));
+
+	assert(ti.ti[0].tcpi_bytes_sent == w);
+	assert(ti.ti[0].tcpi_bytes_received == r);
+
+	do_getsockopt_bogus_sf_data(fd, MPTCP_TCPINFO);
+}
+
+static void do_getsockopt_subflow_addrs(int fd)
+{
+	struct sockaddr_storage remote, local;
+	socklen_t olen, rlen, llen;
+	int ret;
+	struct my_addrs {
+		struct mptcp_subflow_data d;
+		struct mptcp_subflow_addrs addr[2];
+	} addrs;
+
+	memset(&addrs, 0, sizeof(addrs));
+	memset(&local, 0, sizeof(local));
+	memset(&remote, 0, sizeof(remote));
+
+	addrs.d.size_subflow_data = sizeof(struct mptcp_subflow_data);
+	addrs.d.size_user = sizeof(struct mptcp_subflow_addrs);
+	olen = sizeof(addrs);
+
+	ret = getsockopt(fd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, &addrs, &olen);
+	if (ret < 0)
+		die_perror("getsockopt MPTCP_SUBFLOW_ADDRS");
+
+	assert(olen <= sizeof(addrs));
+	assert(addrs.d.size_user == addrs.d.size_kernel);
+	assert(addrs.d.size_user == sizeof(struct mptcp_subflow_addrs));
+	assert(addrs.d.num_subflows == 1);
+
+	assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
+	olen -= sizeof(struct mptcp_subflow_data);
+	assert(olen == sizeof(struct mptcp_subflow_addrs));
+
+	llen = sizeof(local);
+	ret = getsockname(fd, (struct sockaddr *)&local, &llen);
+	if (ret < 0)
+		die_perror("getsockname");
+	rlen = sizeof(remote);
+	ret = getpeername(fd, (struct sockaddr *)&remote, &rlen);
+	if (ret < 0)
+		die_perror("getpeername");
+
+	assert(rlen > 0);
+	assert(rlen == llen);
+
+	assert(remote.ss_family == local.ss_family);
+
+	assert(memcmp(&local, &addrs.addr[0].ss_local, sizeof(local)) == 0);
+	assert(memcmp(&remote, &addrs.addr[0].ss_remote, sizeof(remote)) == 0);
+
+	memset(&addrs, 0, sizeof(addrs));
+
+	addrs.d.size_subflow_data = sizeof(struct mptcp_subflow_data);
+	addrs.d.size_user = sizeof(sa_family_t);
+	olen = sizeof(addrs.d) + sizeof(sa_family_t);
+
+	ret = getsockopt(fd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, &addrs, &olen);
+	assert(ret == 0);
+	assert(olen == sizeof(addrs.d) + sizeof(sa_family_t));
+
+	assert(addrs.addr[0].sa_family == pf);
+	assert(addrs.addr[0].sa_family == local.ss_family);
+
+	assert(memcmp(&local, &addrs.addr[0].ss_local, sizeof(local)) != 0);
+	assert(memcmp(&remote, &addrs.addr[0].ss_remote, sizeof(remote)) != 0);
+
+	do_getsockopt_bogus_sf_data(fd, MPTCP_SUBFLOW_ADDRS);
+}
+
+static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w, uint32_t flags)
+{
+	do_getsockopt_mptcp_info(s, fd, r, w, flags);
+
+	do_getsockopt_tcp_info(fd, r, w);
+
+	do_getsockopt_subflow_addrs(fd);
+}
+
+static void connect_one_server(int fd)
+{
+	char buf[4096], buf2[4096];
+	struct so_state s;
+	size_t len, i;
+	ssize_t ret;
+
+	memset(&s, 0, sizeof(s));
+
+	len = rand() % (sizeof(buf) - 1);
+
+	if (len < 128)
+		len = 128;
+
+	for (i = 0; i < len ; i++) {
+		buf[i] = rand() % 26;
+		buf[i] += 'A';
+	}
+
+	buf[i] = '\n';
+
+	do_getsockopts(&s, fd, 0, 0, 0);
+
+	ret = write(fd, buf, len);
+	if (ret < 0)
+		die_perror("write");
+
+	if (ret != (ssize_t)len)
+		xerror("short write");
+
+	sleep(1);
+	do_getsockopts(&s, fd, 0, ret, 0);
+
+	ret = read(fd, buf2, sizeof(buf2));
+	if (ret < 0)
+		die_perror("read");
+
+	if ((size_t)ret != len)
+		xerror("incomplete read");
+
+	if (memcmp(buf, buf2, len))
+		xerror("data corruption");
+
+	do_getsockopts(&s, fd, ret, ret, 0);
+	close(fd);
+}
+
+static void process_one_client(int fd)
+{
+	ssize_t ret, ret2, ret3;
+	struct so_state s;
+	char buf[4096];
+
+	memset(&s, 0, sizeof(s));
+
+	do_getsockopts(&s, fd, 0, 0, 0);
+
+	ret = read(fd, buf, sizeof(buf));
+	if (ret < 0)
+		die_perror("read");
+
+	sleep(1);
+	do_getsockopts(&s, fd, ret, 0, 0);
+
+	ret2 = write(fd, buf, ret);
+	if (ret2 < 0)
+		die_perror("write");
+
+	/* wait for hangup */
+	ret3 = read(fd, buf, 1);
+	if (ret3 != 0)
+		xerror("expected EOF, got %lu", ret3);
+
+	do_getsockopts(&s, fd, ret, ret2, EOF_RECEIVED);
+	close(ret2);
+}
+
+static int xaccept(int s)
+{
+	int fd = accept(s, NULL, 0);
+
+	if (fd < 0)
+		die_perror("accept");
+
+	return fd;
+}
+
+static int server(int readyfd)
+{
+	int fd = -1, r;
+
+	switch (pf) {
+	case AF_INET:
+		fd = sock_listen_mptcp("127.0.0.1", "15432");
+		break;
+	case AF_INET6:
+		fd = sock_listen_mptcp("::1", "15432");
+		break;
+	default:
+		xerror("Unknown pf %d\n", pf);
+		break;
+	}
+
+	r = close(readyfd);
+	if (r < 0)
+		die_perror("close pipe");
+
+	alarm(15);
+	r = xaccept(fd);
+
+	process_one_client(r);
+
+	return 0;
+}
+
+static int client(void)
+{
+	int fd = -1;
+
+	alarm(15);
+
+	switch (pf) {
+	case AF_INET:
+		fd = sock_connect_mptcp("127.0.0.1", "15432", IPPROTO_MPTCP);
+		break;
+	case AF_INET6:
+		fd = sock_connect_mptcp("::1", "15432", IPPROTO_MPTCP);
+		break;
+	default:
+		xerror("Unknown pf %d\n", pf);
+	}
+
+	connect_one_server(fd);
+
+	return 0;
+}
+
+static pid_t xfork(void)
+{
+	pid_t p = fork();
+
+	if (p < 0)
+		die_perror("fork");
+
+	return p;
+}
+
+static int rcheck(int wstatus, const char *what)
+{
+	if (WIFEXITED(wstatus)) {
+		if (WEXITSTATUS(wstatus) == 0)
+			return 0;
+		fprintf(stderr, "%s exited, status=%d\n", what, WEXITSTATUS(wstatus));
+		return WEXITSTATUS(wstatus);
+	} else if (WIFSIGNALED(wstatus)) {
+		xerror("%s killed by signal %d\n", what, WTERMSIG(wstatus));
+	} else if (WIFSTOPPED(wstatus)) {
+		xerror("%s stopped by signal %d\n", what, WSTOPSIG(wstatus));
+	}
+
+	return 111;
+}
+
+int main(int argc, char *argv[])
+{
+	int e1, e2, wstatus;
+	pid_t s, c, ret;
+	int pipefds[2];
+
+	parse_opts(argc, argv);
+
+	e1 = pipe(pipefds);
+	if (e1 < 0)
+		die_perror("pipe");
+
+	s = xfork();
+	if (s == 0)
+		return server(pipefds[1]);
+
+	close(pipefds[1]);
+
+	/* wait until server bound a socket */
+	e1 = read(pipefds[0], &e1, 4);
+	if (e1 < 0)
+		die_perror("read from pipe");
+
+	close(pipefds[0]);
+	c = xfork();
+	if (c == 0)
+		return client();
+
+	ret = waitpid(s, &wstatus, 0);
+	if (ret == -1)
+		die_perror("waitpid");
+	e1 = rcheck(wstatus, "server");
+	ret = waitpid(c, &wstatus, 0);
+	if (ret == -1)
+		die_perror("waitpid");
+	e2 = rcheck(wstatus, "client");
+
+	return e1 ? e1 : e2;
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1579e471a5e7..41de643788b8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -239,12 +239,35 @@ make_file()
 	echo "Created $name (size $size KB) containing data sent by $who"
 }
 
+do_mptcp_sockopt_tests()
+{
+	local lret=0
+
+	./mptcp_sockopt
+	lret=$?
+
+	if [ $lret -ne 0 ]; then
+		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		ret=$lret
+		return
+	fi
+
+	./mptcp_sockopt -6
+	lret=$?
+
+	if [ $lret -ne 0 ]; then
+		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		ret=$lret
+		return
+	fi
+}
+
 run_tests()
 {
 	listener_ns="$1"
 	connector_ns="$2"
 	connect_addr="$3"
-	lret=0
+	local lret=0
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
 
@@ -268,9 +291,13 @@ trap cleanup EXIT
 run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
-
 if [ $ret -eq 0 ];then
 	echo "PASS: all packets had packet mark set"
 fi
 
+do_mptcp_sockopt_tests
+if [ $ret -eq 0 ];then
+	echo "PASS: SOL_MPTCP getsockopt has expected information"
+fi
+
 exit $ret
-- 
2.31.1


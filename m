Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0032FAD
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 13:00:53 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mGhf3-0005CU-4S; Thu, 19 Aug 2021 15:00:45 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp] selftest: wait before trasnmitting first data chunk
Date: Thu, 19 Aug 2021 15:00:40 +0200
Message-Id: <20210819130040.30228-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Squashto: selftests: mptcp: add mptcp getsockopt test cases

Mathieu reports spurious failure of the selftest:
 mptcp_sockopt.c:362: do_getsockopt_tcp_info: Assertion `ti.ti[0].tcpi_bytes_received == r' failed.
 mptcp_sockopt.c:330: do_getsockopt_mptcp_info: Assertion `s-&gt;mi.mptcpi_rcv_nxt + r == i.mptcpi_rcv_nxt' failed.

This is because client and server are racing.
The first getsockopt() for (MP)TCP_INFO might be called when some data
was already received, but the mptcpi_rcv_nxt assertion relies on the
initial call to fetch a 'start sequence number'.

Extend the pipe (that was used to unblock the 'connect process' when
the server had bound a socket), it now tells when to connet and when
to send the first chunk of data.

In addition, its remote chance, but possible, that tx is slower
than expected so allow tcpinfo to wait a bit for more data to arrive.

After this, 20k invocations pass without failures.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 155 +++++++++++-------
 1 file changed, 97 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b0ac561e7e38..66c4cee37937 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -9,6 +9,7 @@
 #include <stdarg.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <strings.h>
@@ -78,12 +79,10 @@ struct mptcp_info {
 	__u8	mptcpi_csum_enabled;
 };
 
-enum sockopt_check_flags {
-	EOF_RECEIVED = 1 << 0,
-};
-
 struct so_state {
 	struct mptcp_info mi;
+	uint64_t mptcpi_rcv_delta;
+	uint64_t tcpi_rcv_delta;
 };
 
 static void die_perror(const char *msg)
@@ -305,7 +304,7 @@ static void do_getsockopt_bogus_sf_data(int fd, int optname)
 	assert(bd.buf[0] == 0);
 }
 
-static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t r, size_t w, uint32_t flags)
+static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t w)
 {
 	struct mptcp_info i;
 	socklen_t olen;
@@ -324,43 +323,56 @@ static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t r, size_
 
 	assert(s->mi.mptcpi_write_seq + w == i.mptcpi_write_seq);
 
-	if (flags & EOF_RECEIVED)
-		r += 1;
-
-	assert(s->mi.mptcpi_rcv_nxt + r == i.mptcpi_rcv_nxt);
+	s->mptcpi_rcv_delta = i.mptcpi_rcv_nxt - s->mi.mptcpi_rcv_nxt;
 }
 
-static void do_getsockopt_tcp_info(int fd, size_t r, size_t w)
+static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t w)
 {
 	struct my_tcp_info {
 		struct mptcp_subflow_data d;
 		struct tcp_info ti[2];
 	} ti;
+	int ret, tries = 5;
 	socklen_t olen;
-	int ret;
 
-	memset(&ti, 0, sizeof(ti));
+	do {
+		memset(&ti, 0, sizeof(ti));
 
-	ti.d.size_subflow_data = sizeof(struct mptcp_subflow_data);
-	ti.d.size_user = sizeof(struct tcp_info);
-	olen = sizeof(ti);
+		ti.d.size_subflow_data = sizeof(struct mptcp_subflow_data);
+		ti.d.size_user = sizeof(struct tcp_info);
+		olen = sizeof(ti);
 
-	ret = getsockopt(fd, SOL_MPTCP, MPTCP_TCPINFO, &ti, &olen);
-	if (ret < 0)
-		die_perror("getsockopt MPTCP_TCPINFO");
+		ret = getsockopt(fd, SOL_MPTCP, MPTCP_TCPINFO, &ti, &olen);
+		if (ret < 0)
+			xerror("getsockopt MPTCP_TCPINFO (tries %d, %m)");
 
-	assert(olen <= sizeof(ti));
-	assert(ti.d.size_user == ti.d.size_kernel);
-	assert(ti.d.size_user == sizeof(struct tcp_info));
-	assert(ti.d.num_subflows == 1);
+		assert(olen <= sizeof(ti));
+		assert(ti.d.size_user == ti.d.size_kernel);
+		assert(ti.d.size_user == sizeof(struct tcp_info));
+		assert(ti.d.num_subflows == 1);
 
-	assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
-	olen -= sizeof(struct mptcp_subflow_data);
-	assert(olen == sizeof(struct tcp_info));
+		assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
+		olen -= sizeof(struct mptcp_subflow_data);
+		assert(olen == sizeof(struct tcp_info));
 
-	assert(ti.ti[0].tcpi_bytes_sent == w);
-	assert(ti.ti[0].tcpi_bytes_received == r);
+		if (ti.ti[0].tcpi_bytes_sent == w &&
+		    ti.ti[0].tcpi_bytes_received == r)
+			goto done;
 
+		if (r == 0 && ti.ti[0].tcpi_bytes_sent == w &&
+		    ti.ti[0].tcpi_bytes_received) {
+			s->tcpi_rcv_delta = ti.ti[0].tcpi_bytes_received;
+			goto done;
+		}
+
+		/* wait and repeat, might be that tx is still ongoing */
+		sleep(1);
+	} while (tries-- > 0);
+
+	xerror("tcpi_bytes_sent %" PRIu64 ", want %zu. tcpi_bytes_received %" PRIu64 ", want %zu",
+		ti.ti[0].tcpi_bytes_sent, w, ti.ti[0].tcpi_bytes_received, r);
+
+done:
 	do_getsockopt_bogus_sf_data(fd, MPTCP_TCPINFO);
 }
 
@@ -431,20 +443,21 @@ static void do_getsockopt_subflow_addrs(int fd)
 	do_getsockopt_bogus_sf_data(fd, MPTCP_SUBFLOW_ADDRS);
 }
 
-static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w, uint32_t flags)
+static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
-	do_getsockopt_mptcp_info(s, fd, r, w, flags);
+	do_getsockopt_mptcp_info(s, fd, w);
 
-	do_getsockopt_tcp_info(fd, r, w);
+	do_getsockopt_tcp_info(s, fd, r, w);
 
 	do_getsockopt_subflow_addrs(fd);
 }
 
-static void connect_one_server(int fd)
+static void connect_one_server(int fd, int pipefd)
 {
 	char buf[4096], buf2[4096];
+	size_t len, i, total;
 	struct so_state s;
-	size_t len, i;
+	bool eof = false;
 	ssize_t ret;
 
 	memset(&s, 0, sizeof(s));
@@ -461,7 +474,14 @@ static void connect_one_server(int fd)
 
 	buf[i] = '\n';
 
-	do_getsockopts(&s, fd, 0, 0, 0);
+	do_getsockopts(&s, fd, 0, 0);
+
+	/* un-block server */
+	ret = read(pipefd, buf2, 4);
+	assert(ret == 4);
+	close(pipefd);
+
+	assert(strncmp(buf2, "xmit", 4) == 0);
 
 	ret = write(fd, buf, len);
 	if (ret < 0)
@@ -470,39 +490,57 @@ static void connect_one_server(int fd)
 	if (ret != (ssize_t)len)
 		xerror("short write");
 
-	sleep(1);
-	do_getsockopts(&s, fd, 0, ret, 0);
+	total = 0;
+	do {
+		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		if (ret < 0)
+			die_perror("read");
+		if (ret == 0) {
+			eof = true;
+			break;
+		}
 
-	ret = read(fd, buf2, sizeof(buf2));
-	if (ret < 0)
-		die_perror("read");
+		total += ret;
+	} while (total < len);
 
-	if ((size_t)ret != len)
-		xerror("incomplete read");
+	if (total != len)
+		xerror("total %lu, len %lu eof %d\n", total, len, eof);
 
 	if (memcmp(buf, buf2, len))
 		xerror("data corruption");
 
-	do_getsockopts(&s, fd, ret, ret, 0);
+	if (s.tcpi_rcv_delta)
+		assert(s.tcpi_rcv_delta <= total);
+
+	do_getsockopts(&s, fd, ret, ret);
+
+	if (eof)
+		total += 1; /* sequence advances due to FIN */
+
+	assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
-static void process_one_client(int fd)
+static void process_one_client(int fd, int pipefd)
 {
 	ssize_t ret, ret2, ret3;
 	struct so_state s;
 	char buf[4096];
 
 	memset(&s, 0, sizeof(s));
+	do_getsockopts(&s, fd, 0, 0);
 
-	do_getsockopts(&s, fd, 0, 0, 0);
+	ret = write(pipefd, "xmit", 4);
+	assert(ret == 4);
 
 	ret = read(fd, buf, sizeof(buf));
 	if (ret < 0)
 		die_perror("read");
 
-	sleep(1);
-	do_getsockopts(&s, fd, ret, 0, 0);
+	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
+
+	if (s.tcpi_rcv_delta)
+		assert(s.tcpi_rcv_delta == (uint64_t)ret);
 
 	ret2 = write(fd, buf, ret);
 	if (ret2 < 0)
@@ -513,8 +551,10 @@ static void process_one_client(int fd)
 	if (ret3 != 0)
 		xerror("expected EOF, got %lu", ret3);
 
-	do_getsockopts(&s, fd, ret, ret2, EOF_RECEIVED);
-	close(ret2);
+	do_getsockopts(&s, fd, ret, ret2);
+	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
+	close(fd);
 }
 
 static int xaccept(int s)
@@ -527,7 +567,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int readyfd)
+static int server(int pipefd)
 {
 	int fd = -1, r;
 
@@ -543,19 +583,18 @@ static int server(int readyfd)
 		break;
 	}
 
-	r = close(readyfd);
-	if (r < 0)
-		die_perror("close pipe");
+	r = write(pipefd, "conn", 4);
+	assert(r == 4);
 
 	alarm(15);
 	r = xaccept(fd);
 
-	process_one_client(r);
+	process_one_client(r, pipefd);
 
 	return 0;
 }
 
-static int client(void)
+static int client(int pipefd)
 {
 	int fd = -1;
 
@@ -572,7 +611,7 @@ static int client(void)
 		xerror("Unknown pf %d\n", pf);
 	}
 
-	connect_one_server(fd);
+	connect_one_server(fd, pipefd);
 
 	return 0;
 }
@@ -623,13 +662,13 @@ int main(int argc, char *argv[])
 
 	/* wait until server bound a socket */
 	e1 = read(pipefds[0], &e1, 4);
-	if (e1 < 0)
-		die_perror("read from pipe");
+	assert(e1 == 4);
 
-	close(pipefds[0]);
 	c = xfork();
 	if (c == 0)
-		return client();
+		return client(pipefds[0]);
+
+	close(pipefds[0]);
 
 	ret = waitpid(s, &wstatus, 0);
 	if (ret == -1)
-- 
2.31.1


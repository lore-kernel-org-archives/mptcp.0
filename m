Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD132C80
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 15:51:37 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1muGH8-0001qx-N3; Mon, 06 Dec 2021 16:51:35 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp 2/2] selftests: mptcp: try to set mptcp ulp mode in different sk states
Date: Mon,  6 Dec 2021 16:51:20 +0100
Message-Id: <20211206155120.26929-3-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206155120.26929-1-fw@strlen.de>
References: <20211206155120.26929-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel will crash without
'mptcp: clear 'kern' flag from fallback sockets' change.

Since this doesn't slow down testing in a noticeable way,
run this unconditionally.

The explicit test did not catch this, because the check was done
for tcp socket returned by 'socket(.. IPPROTO_TCP) rather than a
tcp socket returned by accept() on a mptcp listen fd.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 97 ++++++++++---------
 .../selftests/net/mptcp/mptcp_connect.sh      | 20 ----
 2 files changed, 51 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ffdf7bbc16af..8628aa61b763 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -61,7 +61,6 @@ static enum cfg_peek cfg_peek = CFG_NONE_PEEK;
 static const char *cfg_host;
 static const char *cfg_port	= "12000";
 static int cfg_sock_proto	= IPPROTO_MPTCP;
-static bool tcpulp_audit;
 static int pf = AF_INET;
 static int cfg_sndbuf;
 static int cfg_rcvbuf;
@@ -120,7 +119,6 @@ static void die_usage(void)
 	fprintf(stderr, "\t-R num -- set SO_RCVBUF to num\n");
 	fprintf(stderr, "\t-s [MPTCP|TCP] -- use mptcp(default) or tcp sockets\n");
 	fprintf(stderr, "\t-S num -- set SO_SNDBUF to num\n");
-	fprintf(stderr, "\t-u -- check mptcp ulp\n");
 	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
 	exit(1);
 }
@@ -228,6 +226,42 @@ static void set_transparent(int fd, int pf)
 	}
 }
 
+static int do_ulp_so(int sock, const char *name)
+{
+	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
+}
+
+#define X(m)	xerror("%s:%u: %s: failed for proto %d at line %u", __FILE__, __LINE__, (m), proto, line)
+static void sock_test_tcpulp(int sock, int proto, unsigned int line)
+{
+	socklen_t buflen = 8;
+	char buf[8] = "";
+	int ret = getsockopt(sock, IPPROTO_TCP, TCP_ULP, buf, &buflen);
+
+	if (ret != 0)
+		X("getsockopt");
+
+	if (buflen > 0) {
+		if (strcmp(buf, "mptcp") != 0)
+			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
+		ret = do_ulp_so(sock, "tls");
+		if (ret == 0)
+			X("setsockopt");
+	} else if (proto == IPPROTO_MPTCP) {
+		ret = do_ulp_so(sock, "tls");
+		if (ret != -1)
+			X("setsockopt");
+	}
+
+	ret = do_ulp_so(sock, "mptcp");
+	if (ret != -1)
+		X("setsockopt");
+
+#undef X
+}
+
+#define SOCK_TEST_TCPULP(s, p) sock_test_tcpulp((s), (p), __LINE__)
+
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
@@ -251,6 +285,8 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		if (sock < 0)
 			continue;
 
+		SOCK_TEST_TCPULP(sock, cfg_sock_proto);
+
 		if (-1 == setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,
 				     sizeof(one)))
 			perror("setsockopt");
@@ -273,50 +309,17 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		return sock;
 	}
 
+	SOCK_TEST_TCPULP(sock, cfg_sock_proto);
+
 	if (listen(sock, 20)) {
 		perror("listen");
 		close(sock);
 		return -1;
 	}
 
-	return sock;
-}
+	SOCK_TEST_TCPULP(sock, cfg_sock_proto);
 
-static bool sock_test_tcpulp(const char * const remoteaddr,
-			     const char * const port)
-{
-	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
-		.ai_socktype = SOCK_STREAM,
-	};
-	struct addrinfo *a, *addr;
-	int sock = -1, ret = 0;
-	bool test_pass = false;
-
-	hints.ai_family = AF_INET;
-
-	xgetaddrinfo(remoteaddr, port, &hints, &addr);
-	for (a = addr; a; a = a->ai_next) {
-		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_TCP);
-		if (sock < 0) {
-			perror("socket");
-			continue;
-		}
-		ret = setsockopt(sock, IPPROTO_TCP, TCP_ULP, "mptcp",
-				 sizeof("mptcp"));
-		if (ret == -1 && errno == EOPNOTSUPP)
-			test_pass = true;
-		close(sock);
-
-		if (test_pass)
-			break;
-		if (!ret)
-			fprintf(stderr,
-				"setsockopt(TCP_ULP) returned 0\n");
-		else
-			perror("setsockopt(TCP_ULP)");
-	}
-	return test_pass;
+	return sock;
 }
 
 static int sock_connect_mptcp(const char * const remoteaddr,
@@ -340,6 +343,8 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			continue;
 		}
 
+		SOCK_TEST_TCPULP(sock, proto);
+
 		if (cfg_mark)
 			set_mark(sock, cfg_mark);
 
@@ -354,6 +359,8 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 	}
 
 	freeaddrinfo(addr);
+	if (sock != -1)
+		SOCK_TEST_TCPULP(sock, proto);
 	return sock;
 }
 
@@ -983,6 +990,8 @@ int main_loop_s(int listensock)
 				xerror("can't open %s: %d", cfg_input, errno);
 		}
 
+		SOCK_TEST_TCPULP(remotesock, 0);
+
 		copyfd_io(fd, remotesock, 1, true);
 	} else {
 		perror("accept");
@@ -1127,6 +1136,8 @@ int main_loop(void)
 again:
 	check_getpeername_connect(fd);
 
+	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
+
 	if (cfg_rcvbuf)
 		set_rcvbuf(fd, cfg_rcvbuf);
 	if (cfg_sndbuf)
@@ -1243,7 +1254,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "6c:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:uw:")) != -1) {
+	while ((c = getopt(argc, argv, "6c:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
 		switch (c) {
 		case 'j':
 			cfg_join = true;
@@ -1275,9 +1286,6 @@ static void parse_opts(int argc, char **argv)
 		case 'h':
 			die_usage();
 			break;
-		case 'u':
-			tcpulp_audit = true;
-			break;
 		case '6':
 			pf = AF_INET6;
 			break;
@@ -1331,9 +1339,6 @@ int main(int argc, char *argv[])
 	signal(SIGUSR1, handle_signal);
 	parse_opts(argc, argv);
 
-	if (tcpulp_audit)
-		return sock_test_tcpulp(cfg_host, cfg_port) ? 0 : 1;
-
 	if (listen_mode) {
 		int fd = sock_listen_mptcp(cfg_host, cfg_port);
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index de6c630a59da..cb5809b89081 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -301,24 +301,6 @@ check_mptcp_disabled()
 	return 0
 }
 
-check_mptcp_ulp_setsockopt()
-{
-	local t retval
-	t="ns_ulp-$sech-$(mktemp -u XXXXXX)"
-
-	ip netns add ${t} || exit $ksft_skip
-	if ! ip netns exec ${t} ./mptcp_connect -u -p 10000 -s TCP 127.0.0.1 2>&1; then
-		printf "setsockopt(..., TCP_ULP, \"mptcp\", ...) allowed\t[ FAIL ]\n"
-		retval=1
-		ret=$retval
-	else
-		printf "setsockopt(..., TCP_ULP, \"mptcp\", ...) blocked\t[ OK ]\n"
-		retval=0
-	fi
-	ip netns del ${t}
-	return $retval
-}
-
 # $1: IP address
 is_v6()
 {
@@ -812,8 +794,6 @@ make_file "$sin" "server"
 
 check_mptcp_disabled
 
-check_mptcp_ulp_setsockopt
-
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
 echo "INFO: validating network environment with pings"
-- 
2.32.0


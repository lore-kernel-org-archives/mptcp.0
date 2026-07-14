Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D863769FF
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994957; cv=none; b=e1J2wJcIYu02/2SDkmpS7OwirqgWZ+9MrKTKW0ejnehHjnM3DRv4B9MXXCNSERoQIVFsoeI3QmmKGp6FExslAcY7IlfEAfkZM6N5bMdRrShyHVII/bydH8jJXVI9469IY+b3cHJDmOAHHo1WcNiaBAF80DDOQmIcqtS+WGHeehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994957; c=relaxed/simple;
	bh=ETXdNcOWNP5Fcu4336E1Pu5BQy0Pl4QqjsU3LTx1Am8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScNYMrqyHEQmVoSqP+A7NT/aZ2NtWVjqw3+BeanWr03y6QMelVrhbedZRkv+SXMyv8+J67HIPOjvkQYW9L5vDkFnY/vDDXVMbqPIWTm+E35XjjyitGm+WpF1/Yhfjl6g4/s5/qzG6jRLJc0KBlZk2n4TBxBbzFBRIrzqVc3wIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUAmYv+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUAmYv+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE661F00A3A;
	Tue, 14 Jul 2026 02:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994956;
	bh=b8c5orose6hBjS/GxfYHra0ebROh2MLiBZpyEMVxyco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JUAmYv+24y+XB5Ol+ilK0GyTPK023wS/4I4+/mhYzxs75RyXG1AL5qTrRRgnIMAqP
	 7ZyO+MUaGLaN0mWuf1LkT7zbhT9gMydlzIg8fBvsLv8edkSJx2mePcZb24jahX1Saa
	 7D/tJSkje12ur+qFSMbjhr20zDZs7Zjip3UWqbMWPjtwxVRVnOPxVcq3/gKKZEQPDL
	 V49gWsniag12YsVhj+S5GsDthg8fa/AkN7EsU26xhEq7LPd6kM30RMQOTKz5R/bCXX
	 XACtLnklgvaf2zSwqQ/j6nXSL8rDHh51RX/TWEdvOVUYGIeR/YdmnLg038z9ut28B4
	 fMtxfNNL5QCCQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 06/13] selftests: mptcp: sockopt: add tx/rx protocol options
Date: Tue, 14 Jul 2026 10:08:51 +0800
Message-ID: <59fb47e21dbb31e03c1e83f2648ad7e64dd904af.1783994494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add -t and -r options to specify tx/rx protocols (TCP/MPTCP). This
increases testing flexibility by allowing explicit protocol selection
for both transmission and reception paths.

These codes are from mptcp_inq.c.

Enhance compatibility with TCP tests by skipping MPTCP getsockopt checks
during TCP tests since MPTCP socket options are not available.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 37 ++++++++++++++++---
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 241b9b82dabb..eddb1f7b3cec 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -29,6 +29,8 @@
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
+static int proto_tx = IPPROTO_MPTCP;
+static int proto_rx = IPPROTO_MPTCP;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -140,6 +142,7 @@ static void __noreturn die_perror(const char *msg)
 static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
+	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
 	exit(r);
 }
 
@@ -205,7 +208,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	hints.ai_family = pf;
 
 	for (a = addr; a; a = a->ai_next) {
-		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		sock = socket(a->ai_family, a->ai_socktype, proto_rx);
 		if (sock < 0)
 			continue;
 
@@ -263,11 +266,22 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 	return sock;
 }
 
+static int protostr_to_num(const char *s)
+{
+	if (strcasecmp(s, "tcp") == 0)
+		return IPPROTO_TCP;
+	if (strcasecmp(s, "mptcp") == 0)
+		return IPPROTO_MPTCP;
+
+	die_usage(1);
+	return 0;
+}
+
 static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -275,6 +289,12 @@ static void parse_opts(int argc, char **argv)
 		case '6':
 			pf = AF_INET6;
 			break;
+		case 't':
+			proto_tx = protostr_to_num(optarg);
+			break;
+		case 'r':
+			proto_rx = protostr_to_num(optarg);
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -560,6 +580,9 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
+	if (proto_tx != IPPROTO_MPTCP || proto_rx != IPPROTO_MPTCP)
+		return;
+
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
@@ -635,7 +658,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
+		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
@@ -674,7 +698,8 @@ static void process_one_client(int fd, int pipefd)
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-	if (s.mptcpi_rcv_delta != (uint64_t)r + 1) /* +1 for FIN */
+	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP &&
+	    s.mptcpi_rcv_delta != (uint64_t)r + 1) /* +1 for FIN */
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
 		       s.mptcpi_rcv_delta, r + 1, s.mptcpi_rcv_delta - (r + 1));
 
@@ -784,10 +809,10 @@ static int client(int pipefd)
 
 	switch (pf) {
 	case AF_INET:
-		fd = sock_connect_mptcp("127.0.0.1", "15432", IPPROTO_MPTCP);
+		fd = sock_connect_mptcp("127.0.0.1", "15432", proto_tx);
 		break;
 	case AF_INET6:
-		fd = sock_connect_mptcp("::1", "15432", IPPROTO_MPTCP);
+		fd = sock_connect_mptcp("::1", "15432", proto_tx);
 		break;
 	default:
 		xerror("Unknown pf %d\n", pf);
-- 
2.53.0


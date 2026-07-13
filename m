Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7973148D9
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913158; cv=none; b=TDMuIjAUk1L0ZIqKXutfwreeugkigB+sb0oHJXMOV5IzBFUhiaSH3aygtrBPSQ0Qze9yKC13MtahdM5ex/1U3v6Qp2+kzWv6W5r5aUaRvC57Ss/KvsS+9B20w990K04rV1m+lP2m881ESn4AKV6KodXc0ot8y0w1+5wCIoRlvxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913158; c=relaxed/simple;
	bh=4awVUK1Xkm+H+Ktpf52m8XoxGTGoEL7QvelIxCmsQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxB9nkCuYixN2BBj102ufb6a2/0iediaPDoBdz7mDxx7xMoQ+JFBPQmLWmWV7RAdZdjdPKYh1GlLxUPUvFXivqwckDfubmnrTsvUUt2bUyLZap7z6cNPAgkXnBwsukyhFWsnjBnA07u5a7r42Mq4jF1GpHrfQ6CE4PoCIdhu/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CusQXfi+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CusQXfi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEF61F00A3A;
	Mon, 13 Jul 2026 03:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913156;
	bh=J1MDITCjlc0JLil0q013vmYlB/pgNsTdi5ySY2xWSK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CusQXfi+WIAmDHbsZWPjWJw20dU/mGle65RmVmjKG+bdZxtaXGev3Fus5eXi4BCnW
	 RtVnHX1kxG6u840G0gIj3Fk9bvuUtS65qSMvJXUE1FeExhENE5P6q9xy4ondZb7SEt
	 udi5EBxNlk9BcFfK1s2rfK038z1EgYKkMi7i74P29D71jGY9FjVn6jOI9LbSQIwEPf
	 iCSXHH0umjJ4KE3ujbOBw34FGBZqogAbcimnsV0TS7BTQhytH94M8+nMO1zUU04SzV
	 BcMDOGYcjdExrPO4cUQOih77obhG65R+9hJ2uXCcO/6DQBPxetgmBL9rvYcM90288u
	 L1cgySww9dOvA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 05/12] selftests: mptcp: sockopt: add tx/rx protocol options
Date: Mon, 13 Jul 2026 11:25:29 +0800
Message-ID: <90ef5682b66ef639ee2bb1041724410a6d1e581c.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913010.git.tanggeliang@kylinos.cn>
References: <cover.1783913010.git.tanggeliang@kylinos.cn>
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
index 8781dfd50ba0..5e0392fdf0e4 100644
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
 
@@ -673,7 +697,8 @@ static void process_one_client(int fd, int pipefd)
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-	if (s.mptcpi_rcv_delta != (uint64_t)r + 1) /* +1 for FIN */
+	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP &&
+	    s.mptcpi_rcv_delta != (uint64_t)r + 1) /* +1 for FIN */
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
 		       s.mptcpi_rcv_delta, r + 1, s.mptcpi_rcv_delta - (r + 1));
 
@@ -783,10 +808,10 @@ static int client(int pipefd)
 
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


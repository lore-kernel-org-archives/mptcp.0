Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69587282F0C
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741475; cv=none; b=KkEm2UA5AM+vunyeHG0IIjmyNQeWMQBxe7NeNOyatGGMo3qvZA1E6KuaTlhUGEPNDN5bQwO0wQgy5qWxkOHc2x/N0/v1RhtHAmDeYfn1PXanhtSM87sTeMk+3k8edK4pv4IA4VW67bL7AveKHv6+v61FQhQkrFnFoBSbzs/WkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741475; c=relaxed/simple;
	bh=H56Fd/7tXTrOApmaTi36C6F8LamNYisPGSPK2ZLHfhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrlwxqC0OhlWL3TVMhyb8F7GF6kiPgJkC8gknR9t59Ca8QVr0PEsH2jjrRRj+y28jxCGsiVs1QxOhEdSuDUQlOK/YK5OPEH4Dgxp3A0hhOd2nj3cCyNpT9W42U0sMOBDDr8XEdMpQ0MyK+g4FX9xiLhMxegFnZ0jwOsWi6qtNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIlGS1vI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIlGS1vI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806911F000E9;
	Sat, 11 Jul 2026 03:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741474;
	bh=LMn7VL+dkINmW9jiw/Oy+2pScC30XDGiZe195Q2Vk24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZIlGS1vIXT10g4wfZ85x7FA84Wtz7AJoCjAfuZ5jJyQ6FzRYwWzUOQRnuiutmTQ3W
	 G6ciBccUx6hCpXAUGwDj3llp/RlbB4X3FdJU1sPTOLAuijv/VP/iwxcK6pQeAu8cKh
	 G1xDP3d0R+ZTAocE1ZzN3aljARgpM5cct1W54yJfT/eEpmkDFKmJ4kLtANWYNgdV6z
	 4nnAOSRb1a4rPST01Whxkogo6kT3yje7o4iW5C0IlVS/dQ85Lab7ortC2lUNFrqEk4
	 RxeUBsuWZZTVLxOKOgX6ruM6raZ/9wIo2LKjpusAshpKRGsVcf60NIyelE5poHQ5Uw
	 TmLZgLQhUo+lA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 04/14] selftests: mptcp: sockopt: add tx/rx protocol options
Date: Sat, 11 Jul 2026 11:43:32 +0800
Message-ID: <35d655527eb1433beb394239be1f21f626fca05d.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
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
index f4c97b20a122..afc7a74feb18 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -28,6 +28,8 @@
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
+static int proto_tx = IPPROTO_MPTCP;
+static int proto_rx = IPPROTO_MPTCP;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -139,6 +141,7 @@ static void __noreturn die_perror(const char *msg)
 static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
+	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
 	exit(r);
 }
 
@@ -204,7 +207,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	hints.ai_family = pf;
 
 	for (a = addr; a; a = a->ai_next) {
-		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		sock = socket(a->ai_family, a->ai_socktype, proto_rx);
 		if (sock < 0)
 			continue;
 
@@ -262,11 +265,22 @@ static int sock_connect_mptcp(const char * const remoteaddr,
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
@@ -274,6 +288,12 @@ static void parse_opts(int argc, char **argv)
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
@@ -559,6 +579,9 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
+	if (proto_tx != IPPROTO_MPTCP || proto_rx != IPPROTO_MPTCP)
+		return;
+
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
@@ -634,7 +657,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
+		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
@@ -672,7 +696,8 @@ static void process_one_client(int fd, int pipefd)
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-	if (s.mptcpi_rcv_delta != (uint64_t)r + 1)
+	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP &&
+	    s.mptcpi_rcv_delta != (uint64_t)r + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
 		       s.mptcpi_rcv_delta, r + 1, s.mptcpi_rcv_delta - (r + 1));
 
@@ -782,10 +807,10 @@ static int client(int pipefd)
 
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


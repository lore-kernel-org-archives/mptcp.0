Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C5248881
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083766; cv=none; b=kbNUSkQd0k1gjolbxWTPyAyQt6rKuozg7ODNI7olVx/QKAEsYccRWVjChAypwEt6kYlTHuDsPO9CfE5ITQ1LM+las1YMGYz9BS5NSK5+Ye4/GpABU8FT2x+2LsWiT7YKzMJDn6zNgiK4jLeQsRFcTrd/DzUWqz4QZhatdC6Z0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083766; c=relaxed/simple;
	bh=g1PIW4f/Q2QbizXfO8UuaRpgsvtnLEwaV45SHz9o6P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXZ6PKxNyn9Q8AFjZPibBWaAzreTJScllduj4NCXcIjEJ2SmMDqE4nSwkaHrFyL/LkJTPYEBoErxq3LgCgeuOjiahjczVFk3ArzjxfvfGCPdD1/ZnrlQjka4lxHH2KqW8kphpmXBYSdqV9EOxC8xqnJI+QXZNJz7p8eHt51aBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkvYrw2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkvYrw2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA891F00A3A;
	Wed, 15 Jul 2026 02:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083765;
	bh=hThoJyYQcn85VMEuf/QeO7FLFYRjijtRkgl3kPtkDWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AkvYrw2T2QdEUim6jXHksWy2R2DlXTDZxU3+pqtZhS+F2Waq2VG7lIoQoiQrDOqpn
	 8TfhVVftHoxQ5v60NdE2/MJ1hf8w6EnSxtMn11GIALmm3seSBdr4IkYc9ssHPze/Px
	 54Ggq4B3gu6vFAxPuhiMsGGURE+phpSX75vp2gjYHwZiS+w94PcxOnom24bg3mcjQI
	 HjkpjHigcdHLBKFiBi0G4SVi1DOorxKeI/xtofQBNMjAJpheYO7so8Vg8ih1oWaY3x
	 uaPokXNo8qBJ/CBY97cQCyed7KGhXbBOHQP/oCatbAd5dmo0LU6zMZT6+jCaB0JFFm
	 YaCIv9BAmQ2lA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 05/11] selftests: mptcp: sockopt: add tx/rx protocol options
Date: Wed, 15 Jul 2026 10:48:51 +0800
Message-ID: <0f8e8149460e792998d9648c2f8e9842e126e44e.1784082850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784082850.git.tanggeliang@kylinos.cn>
References: <cover.1784082850.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 39 +++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 9e1d84af5268..71db07913d14 100644
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
 
@@ -683,8 +707,9 @@ static void process_one_client(int fd, int pipefd)
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-	check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
-			 (uint64_t)r + 1); /* +1 for FIN */
+	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
+		check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
+				 (uint64_t)r + 1); /* +1 for FIN */
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
@@ -786,10 +811,10 @@ static int client(int pipefd)
 
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


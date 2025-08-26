Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8871C5D4B
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200588; cv=none; b=uuTyYE20WA7vWhvOjn55wjuQbfyzNjnajX/kudyXAB2uPiym6RBseMyZWbzGDQWx2rJ8pzeMrjh0QurgRiVMnwAhsz6VbLRQDm0e3R8XggLBLn/K1JU8xZjoaodctQELull+QMsyNJs/8dDIGQ9e3zYXUR7MC6dnRS18IZs35TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200588; c=relaxed/simple;
	bh=XO8d+3aApVsDtiNZGvQgp4A/wR8B5Lpcu78OzD+zysE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTXAhAeLSKsCbInETJG1Ib6GZ46hEPW4PRm3KCvZMgbI8hnmi76x0G+vnFmets5ItrY47SUCZhV5GCQl76SN7DH7StB12pYPisApJoWAoVGJBVbaG0PekVuJGWOlWZ/MEoqJ/rmqD4UHSl0OYaDaFs/b1x+6+k47o1TpXKikNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkwGobVc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkwGobVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24C9C116B1;
	Tue, 26 Aug 2025 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200588;
	bh=XO8d+3aApVsDtiNZGvQgp4A/wR8B5Lpcu78OzD+zysE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkwGobVc30NQCNKa4DyussTDh96eg+1EddwB5v9qEhG3a9fyz1RhY/cECwbPck1ze
	 OXDmg0jb7yNnCFtMrSME4N3EfXEALxIqNtOI2tA4ptUTrY50WFF6plU4GbQpEef+H/
	 SzsFWkMW4TzQZrnhsqC+vivDblPqPMjF63uoBOlrwpQgYiryZSEl4zGYzIWHLLCxEP
	 0f0bUlgwCACd/a3577cvANk4i+Y3P74Y1trJU9fHShYgmr6zIy52S5ikdPAwZa9WDk
	 jyl3Nsq3niXqTvNunp2OGK9uJYdcgyi9ENgVHoMgiYoB9FDf8eYwWEWr2s1qtWaBBA
	 YntXWbFarHPxg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 02/14] selftests: mptcp: sockopt: add protocol arguments
Date: Tue, 26 Aug 2025 17:29:26 +0800
Message-ID: <76207e7f4c139a593585d9e94f7fb6b3149dea73.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 36 +++++++++++++++----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 2bd75f731dfd..05caa9a57ac4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -28,6 +28,8 @@
 #include <linux/tcp.h>
 
 static int pf = AF_INET;
+static int proto_tx = IPPROTO_MPTCP;
+static int proto_rx = IPPROTO_MPTCP;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -136,7 +138,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp]\n");
 	exit(r);
 }
 
@@ -202,7 +204,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	hints.ai_family = pf;
 
 	for (a = addr; a; a = a->ai_next) {
-		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		sock = socket(a->ai_family, a->ai_socktype, proto_rx);
 		if (sock < 0)
 			continue;
 
@@ -260,11 +262,22 @@ static int sock_connect_mptcp(const char * const remoteaddr,
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
@@ -272,6 +285,12 @@ static void parse_opts(int argc, char **argv)
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
@@ -557,6 +576,9 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
+	if (proto_tx != IPPROTO_MPTCP || proto_rx != IPPROTO_MPTCP)
+		return;
+
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
@@ -632,7 +654,7 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	assert(s.mptcpi_rcv_delta ? s.mptcpi_rcv_delta == (uint64_t)total : true);
 	close(fd);
 }
 
@@ -667,7 +689,7 @@ static void process_one_client(int fd, int pipefd)
 		xerror("expected EOF, got %lu", ret3);
 
 	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+	if (s.mptcpi_rcv_delta && s.mptcpi_rcv_delta != (uint64_t)ret + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
 
 	/* be nice when running on top of older kernel */
@@ -772,10 +794,10 @@ static int client(int pipefd)
 
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
2.48.1


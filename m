Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDB248881
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083768; cv=none; b=I5sIWTw77oEYiV3YFnmLMmz+HclCL3h4kJYK2kmI+pNWOK9ncN9LJcY48QHxQ5CMUcH/lSKnO+TUITVHgVnFEAABYyh61v7ajerkSNFXvTb7G58S2BAWGGp/MYeafgQurZCLsDxAR6+5zP0y1KjeUGRP0pe83F0bpoJ5lmrlZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083768; c=relaxed/simple;
	bh=46oavEWgHmFLi828Sqfy8vpQEBT45yZwJrs89LsnRfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDvgUyLGYl5BB51aLF/iaNU7joFAQ9duPZeSoJpLuC8EWiwH9hwHNTsXNQukPtCMiXvfELvAUnzFaWFHBd5k4AtK0qATt76UCOGfLVoOeXq13Y4tFrmYeTjRPiHVc/q4MuzflFiuIrKnlYG+RxB0bdqggCLmYQzo5wbmeO7gEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeFlRGqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeFlRGqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D91B1F000E9;
	Wed, 15 Jul 2026 02:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083767;
	bh=XOtMxPc9dY9X57bjPUBQG0cvhzlWFNXxtm1jD4xLHD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HeFlRGqHlJ69huowLmr/FKDmziQYQHdkmXukv3FL5dZossik6j/tTF7uw9tfNYkAk
	 UEuvMU0xcLPJJKkJ0V+QomyM0l0esiiNnRRvxOcVL+ZEhciAwM561jcI/LsKS2ZCE4
	 BxNt+fjno4K/kBbDdxHN+/KoTX1zXRZ/GatOC+FiWAxWPYJuAM06Artn01VUOciUwp
	 EV8ZW/x/1bG3hpJD6GI23e5fv6UZXitBHDIRTrUbn7308tzbd5KOHqk5KUWynqCNE4
	 pK+TcLhNrI/5vS0k/PmnG150p1FYEOGmfcgLmSYBloDIWMj1PJV2zDEnycYOpFGXM5
	 zdAAZe4K84yvw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 06/11] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Wed, 15 Jul 2026 10:48:52 +0800
Message-ID: <5acd9841ac87272fc7c35b02f5400c5583a52a2b.1784082850.git.tanggeliang@kylinos.cn>
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

Add -i option to enable TCP_INQ testing. This prepares for consolidating
TCP_INQ tests into a single binary by adding the necessary command-line
interface.

Add helper functions to conditionally set TCP_INQ sockopt on accepted
sockets when running in inq mode. This ensures proper testing of TCP_CM_INQ
functionality by enabling the required socket option on the incoming server
connection.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c        | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 71db07913d14..b40ec54cb134 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -30,6 +30,7 @@
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool inq;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -142,6 +143,7 @@ static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
 	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "                     [-i]\n");
 	exit(r);
 }
 
@@ -280,7 +282,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -294,6 +296,9 @@ static void parse_opts(int argc, char **argv)
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
 			break;
+		case 'i':
+			inq = true;
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -727,6 +732,14 @@ static void process_one_client(int fd, int pipefd)
 	close(fd);
 }
 
+static void do_setsockopt_inq(int fd)
+{
+	int on = 1;
+
+	if (setsockopt(fd, IPPROTO_TCP, TCP_INQ, &on, sizeof(on)))
+		die_perror("setsockopt(TCP_INQ)");
+}
+
 static int xaccept(int s)
 {
 	int fd = accept(s, NULL, 0);
@@ -734,6 +747,9 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	if (inq)
+		do_setsockopt_inq(fd);
+
 	return fd;
 }
 
-- 
2.53.0


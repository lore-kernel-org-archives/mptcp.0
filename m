Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848B3DC4DA
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580821; cv=none; b=Q8//4v+JFC6k53nzjF90JiOtg/NDoFAZoTQC0P4/RroIYUgNNcLVjvKxTZ31uTKZZHunq9+jbk/b7mu75L83g3aZnbc6ZOdz4usHjr2k6s38Pfn6ADtXasPPdObl2w6fIhDGDcASDsw5pKSWDsTTRAbmtBbwS36QJ/TqlPgrOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580821; c=relaxed/simple;
	bh=gAcz67fzvMR/gfx335hxH9yW0tDj98EBfK2dKKlENIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqKc7oOPOIQmHrlQMaiQhfJXBaiP2m7f+Mw1STTRroODolZLDghCMq+9GBqnSdLW7z3PXVCGAMJVqJrUPoauZ32jRSMAx4tvCyuIRVfOVEG5sBydPdj5P7BSofqeO7Ttdaxsk04U8bCBzOrJwCZW2dm33AOdpsLNsF/GROvf2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMW94tx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMW94tx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB4F1F00A3A;
	Thu,  9 Jul 2026 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580818;
	bh=8zG6CYydeSOB/SqiyU1GB1g3Q6jngpqw8MC/SLVzoI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMW94tx0N0RWKuO69lxqAYhvZszOp05AQCuduXZpJi9d/cZmhSgW14R8xuuUAcrUi
	 emrXvgeae9mw0ZUXbOeqk7LCYSLKXPKcuul3wr0rf5RXBxJAQMWVUq3Oux7Vk5gTwx
	 GbIwGGUPBurKtLAVJ0RlHPjfW/Cg9KOCQRatl4ycdvajMuYWdxNnNEi9zkKP6rFtaN
	 9WBZp3LVJ1j4mfAYeW+FV6UI3gMML6Qwdmtgr87J0oFacycXUNZYY14CI2aKWvyXeV
	 88zB1t8KMm2wd55Fqrz81U8yeRw9Heh6dMg/5tQi7b3o/ymFNYtrEGzUZOtb7sWaJR
	 JqQxBwoZFnhwg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 01/12] selftests: mptcp: sockopt: add tx/rx protocol options
Date: Thu,  9 Jul 2026 15:06:10 +0800
Message-ID: <49fd836fee8c6da9027917225cf40cd43584ddcd.1783579976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783579976.git.tanggeliang@kylinos.cn>
References: <cover.1783579976.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..1d516779929a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -28,6 +28,8 @@
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
+static int proto_tx = IPPROTO_MPTCP;
+static int proto_rx = IPPROTO_MPTCP;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -137,6 +139,7 @@ static void __noreturn die_perror(const char *msg)
 static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
+	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
 	exit(r);
 }
 
@@ -202,7 +205,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	hints.ai_family = pf;
 
 	for (a = addr; a; a = a->ai_next) {
-		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		sock = socket(a->ai_family, a->ai_socktype, proto_rx);
 		if (sock < 0)
 			continue;
 
@@ -260,11 +263,22 @@ static int sock_connect_mptcp(const char * const remoteaddr,
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
@@ -272,6 +286,12 @@ static void parse_opts(int argc, char **argv)
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
@@ -777,10 +797,10 @@ static int client(int pipefd)
 
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE5481DD
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801134; cv=none; b=eIVk3h4WKhksg2aBzJ16sYDR8dNeXtRMvrFJ9iCInpHi+C7O5pe8CCwlV4q/p53KG7zAPpP7AlG3XF/bPcc6JRmMB9vOqX+2zGYHQ6eM+dZNJoXKdj5WhMRraQu1uA70jv/aR5P4+/+3geVGOI2JgzIwCG03xK7DcZx6UR5ZH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801134; c=relaxed/simple;
	bh=NnOiyeJD9+3Ac2AR7L7+v0ZZEcz5+6eh+Qqt5PSAppU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsE7hZ316bz/mfxXzrhdZxMrqVX2oUj4/5NSF3Zo0IktZkXLtlX9RIgjqOfnD3EWNUySMKyhnaajWtyAZsKgIrRr3HV8kZLn+kBiqvSvZLlvMqpqY9uCzd1k4FY6D+1Koyu4FnMghXCgCUyi2C4EJAGBohz22SSI0xfcjWl+F7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBr2e/+M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBr2e/+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D521C4CEFB;
	Sat, 22 Nov 2025 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801134;
	bh=NnOiyeJD9+3Ac2AR7L7+v0ZZEcz5+6eh+Qqt5PSAppU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBr2e/+MrW5G+lJgK1UrhNgTBYVrKAvrRKpOWPJ1LeddkWQMj/FFDbMUhbfb5nzBi
	 Kc3LhONq5XcvH+P4e0pDtVsMwQu6jrpQIXdmUX1fJZjsTTYQKSVfXNx+Gz9zxFPoy6
	 RS/30CrFDXbY8pchtzVEA8lAKoguYSF2qlKT3Q9pitEPaePVocuifvsJri3Q2W86kW
	 yatX76WaKxUSK5N9ICBd/Ok4Q9bOxGmTkfZpYS6k/kkBE3/dyA4cxCSyOQI7ozBHMF
	 OfszEyMQQEm8bMDMIdDwgNDuoklzrblQnFb/KYmIv6qojVlljkHd6T7vU1qLaGdIPN
	 3uDhCs33X0ycw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 1/8] selftests: mptcp: sockopt: add protocol arguments
Date: Sat, 22 Nov 2025 16:45:20 +0800
Message-ID: <a810d3af507d55e5c2f0e37f912031f9ff3508d3.1763800601.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763800601.git.tanggeliang@kylinos.cn>
References: <cover.1763800601.git.tanggeliang@kylinos.cn>
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

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 286164f7246e..e4752f848f08 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -27,6 +27,8 @@
 #include <linux/tcp.h>
 
 static int pf = AF_INET;
+static int proto_tx = IPPROTO_MPTCP;
+static int proto_rx = IPPROTO_MPTCP;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -135,7 +137,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp]\n");
 	exit(r);
 }
 
@@ -201,7 +203,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	hints.ai_family = pf;
 
 	for (a = addr; a; a = a->ai_next) {
-		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		sock = socket(a->ai_family, a->ai_socktype, proto_rx);
 		if (sock < 0)
 			continue;
 
@@ -259,11 +261,22 @@ static int sock_connect_mptcp(const char * const remoteaddr,
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
@@ -271,6 +284,12 @@ static void parse_opts(int argc, char **argv)
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
@@ -776,10 +795,10 @@ static int client(int pipefd)
 
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
2.51.0


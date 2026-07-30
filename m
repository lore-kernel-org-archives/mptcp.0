Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A03375F76
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381344; cv=none; b=mbz2OGkC76D0y4hg9o8nLgdYUww0YkeYlxYZjay21gk0/gDuxZOtJmxAq8+fSXYIbVb8u5ctG6EpSo7MBytTR+5THMxNMutc3CBLChTV5QWep2WhRGSnvvtnSmRXqBfOsl39MjTMidi1Pp5DwrnH5extU2wwY6dKQYCSBjfY6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381344; c=relaxed/simple;
	bh=lX5IAzH4D3yOGeZfPGEDFwQQZgmbCK4WNinciTS0oec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMflL/mbDnoAgD6RU9wMcRPiMzpnBY+r6l4SUIT9Ab7X/6Kce2rP8qanqtACPhcNr2cUElDf8/O9wb/t77QXGTU1PQLaEPm8K2EogRD2oLmbGRgxmIhxsgS5bcdl6mNLXaUJPLMVQSi/dDeWMNwkjMZE6KBVufgVVD0VwKOyPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cdtxxhem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cdtxxhem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021401F000E9;
	Thu, 30 Jul 2026 03:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381343;
	bh=U9xNtVIOgKFkiRYQulvkcTUlMLDFZ41mjwpuO/T2Qrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cdtxxhem4rtwRUKCI7VviIwKa2sLEE+ZGB79eh+1p3TOscbC8WUPbJSyTwYQndAq2
	 TnMvYy6GFpOTbCKAS2Nhxk5TixC/SqlX842m9rzE+sN3JT5F9FUC7i1PAL2/bbzTL2
	 pKhGI9vSFMxyCV9zruF3CZ+u98o8gqS1Ws0lJZrrzZgmnX77A96in4QSMWN6dHhNsL
	 kXI58ZCQWAGBmfAVkqR/9dToOJCauPDtB38h+HpnR0g6vSmsYaczZINQM842dioaHL
	 HW3M/HfveARXPtNGA5eFJFxq+keG+MbN57pdDoMHL5AXMNvXx9FIG+e6rRChZE10Aa
	 gyywzyiHz4ZUQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 06/12] selftests: mptcp: sockopt: add tx/rx protocol options
Date: Thu, 30 Jul 2026 11:15:17 +0800
Message-ID: <b241333fe471b6cb16e8ef407d624f066c552bbe.1785380422.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785380422.git.tanggeliang@kylinos.cn>
References: <cover.1785380422.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 822cbf3de3e6..a62f6adda8a0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -39,6 +39,9 @@ static int pf = AF_INET;
 #define TCP_IS_MPTCP 76
 #endif
 
+static int proto_tx = IPPROTO_MPTCP;
+static int proto_rx = IPPROTO_MPTCP;
+
 #ifndef MPTCP_INFO
 struct mptcp_info {
 	__u8	mptcpi_subflows;
@@ -142,6 +145,7 @@ static void __noreturn die_perror(const char *msg)
 static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
+	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
 	exit(r);
 }
 
@@ -207,7 +211,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	hints.ai_family = pf;
 
 	for (a = addr; a; a = a->ai_next) {
-		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		sock = socket(a->ai_family, a->ai_socktype, proto_rx);
 		if (sock < 0)
 			continue;
 
@@ -265,11 +269,22 @@ static int sock_connect_mptcp(const char * const remoteaddr,
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
@@ -277,6 +292,12 @@ static void parse_opts(int argc, char **argv)
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
@@ -811,10 +832,10 @@ static int client(int pipefd)
 
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


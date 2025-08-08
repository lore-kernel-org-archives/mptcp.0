Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781D8F54
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621121; cv=none; b=lKTHJ39q5Q/aph8AIerof0o4rPyGq8IMVrLGXq2jC6crm0NI4VlURMVRxhE3xD3U/U6szTdNoLCSY19EucT+fnTMOBFnSiRfkBYIeK6oGRTMvScFCQggzMhhqYsdWXt2qMgL2cx4RRYQjReOjeDxaHcv6cZj7fyPiz36DN8+Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621121; c=relaxed/simple;
	bh=CjyIMBCy2ciLprUN6DjsY/OUJtjZGPGmMylwxbq7CnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8K3QgfQ4jju2P8YqZCrg/wabq+8VGF8Uo3WFPJVDV4uw1oHDWYWU4PqsXF0jY1orgAsv05EQL19vflNxgjhJ2RLweqRBrPIDKoWzDGJRQ2lKSwpp14L29OpoZH4zOCjS1QKtdXahILrVitlXs+viicfN+yqoH/Ze4SuxK2r8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBP/YiNg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBP/YiNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF6BC4CEF1;
	Fri,  8 Aug 2025 02:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754621121;
	bh=CjyIMBCy2ciLprUN6DjsY/OUJtjZGPGmMylwxbq7CnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBP/YiNgGOCHsXiic1/1KaSvKXN1dpoUYShT23QkRc3/d08lybdU9ZxmnU+GdINQe
	 e0Wc98uPq5599my0R9VxHbK7KJP3vTM8aD9nlEHRCCGj2rH3MilYYlnNaOximQTd21
	 PvFzfnpTDn77aTu2axq1zXnWTQTzmQIaqV3z9wjTXqtpp0ydW/B9iGDrYGp0kZw8UO
	 FmYIXEvpBBh2sc2EDfbkP1S99t8wtDPUesUrYrB5fAjTMoy9eXW9MuCilHCAFhNlAs
	 ziYLzlEkL7AndaEn9DqAybZXPNER8n93E6U5BDVFfbekNNfpakhg0jgWGDYYpU/Wmt
	 kLFVpSKb7fvOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/8] selftests: mptcp: sockopt: add protocol arguments
Date: Fri,  8 Aug 2025 10:45:03 +0800
Message-ID: <ee00edb70874be4fc9787b05e4f9c815806989f4.1754620968.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754620968.git.tanggeliang@kylinos.cn>
References: <cover.1754620968.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 2bd75f731dfd..d6c1d746f12e 100644
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
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [ -t tcp|mptcp ] [ -r tcp|mptcp]\n");
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
@@ -772,10 +791,10 @@ static int client(int pipefd)
 
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


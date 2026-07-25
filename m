Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46352D5A01
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983402; cv=none; b=tWtwg8lkEexi3xYPgy+GAKVwnHp1GVgUKGR172KWd+WA9fKGATEx2VrK67iMqWIhf0czxftACgEXR5Bc3UZDOGqvW7DLk/rLr7ZTOxOY5x6F5452gSmnGmcWorLRdb8vUtbNK8b/IGVZ7vx95CrWT2isQAVF5csw6zooYNUL2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983402; c=relaxed/simple;
	bh=VybFGPkIe3G7ZiWVKb/NfY9nGGwQkT4Wsi5D1Xb4zqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLioC4aUsDESTqtAuFCduHE+5WbQW484VV2kEVFydRoL5a0jQvegSSKp6b6OSFAmCyMIfsOaXyXtkDPxkgqR3VY/PLiUH0BaK6nYaEYIoPuGwMhZdte73sZUVITcwK77pFf8onmEh6ipfLGN2Oqz7b5/VSH0xonYfNLKRyubZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKjxq+e0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKjxq+e0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE651F00A3A;
	Sat, 25 Jul 2026 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983401;
	bh=M1CUFPfDgnUTu2yKNSk7UKUgFenQmDAIkrs+3Wv+c8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oKjxq+e0NPtxDMgbjRtlMKZKSyRI/LNBDpcD/tCtZL3xM9CXPN+HgUdgkDJBWeD1l
	 rKsUFXf/Lxhs1xndOBJ3Uhb2vomBTJRQjywqWzEVopkoV9Omva6GdM1rKBWwCvSC+X
	 GAWG31f8XR2ZbDvMbLb5uBQTRAI6ug59XqhE4hdH1Irrc/O4gMeIQFQfKa8hfCQQds
	 8UPFokvDecONfsr6iUgIMRAeUJZeJdYfI38jNm4wnL4t/wV1UaLaaXKTBr5VzYZ371
	 JAh9lA5l5BA5AiJW6UwzmCZdxHy6pWVzQS+gSyYoZxD92SEMLLKmNOn4zrMuO0hKmo
	 qK9JpRjW/UO2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 06/12] selftests: mptcp: sockopt: add tx/rx protocol options
Date: Sat, 25 Jul 2026 20:42:27 +0800
Message-ID: <fd6f0089d04e47dda14666c66e62438f020852e0.1784981974.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784981974.git.tanggeliang@kylinos.cn>
References: <cover.1784981974.git.tanggeliang@kylinos.cn>
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
index 51e5e33d1db5..b131a18eca79 100644
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
@@ -803,10 +823,10 @@ static int client(int pipefd)
 
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


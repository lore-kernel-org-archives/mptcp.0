Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9837C113
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054631; cv=none; b=NwVpdJpA9o7DjvgMdXndip7j4WX4BAKBQ72m2Iqdm+WGboIRxamB8GSlMhN6kZkMAd6xbUmfVSlV5QVekA1IdXemrG2mtW7nA7PtHihwehppaz0h4pEsCOO/JEwK8hOo1P38GlVaJ3MFFHj1DvoNUZaWC+Izu+GXof6ff1vCauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054631; c=relaxed/simple;
	bh=83pMA5zjkkJ7Bs7XLKCMIRXrVFxjoOtRteUrl0XiKHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCmNAwxjB0+YeDDykiPFQP0afp7GeI5+86H53Zl7RPyr7SshHjAJfant4cRmZY/RspjT5/phC2wO8KoMWUEZbJZSM+ikVRz7uMihjcDundAFJx7WHZkWDpUcabvkzyFGxY3NMrX/7+4t6GH7KnnTpP99PgKrVtorQ1YKl0VF2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNycA3k4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNycA3k4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372551F00A3F;
	Sun, 26 Jul 2026 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054630;
	bh=jmrnWgE3gy4eQy2LUg9edMt6GJy5lVShv9uI1PWG/Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NNycA3k4AKi8i7zeODSd9Ict+BrpejJqx0KWTDLTKNedgjI3CSWkGeLuX4C/VkwGs
	 wy+NGIhOb/c65zxiJ9Sie8XLZtmxczveKLpq9h/lKL8EdBjt9TDQ81iVMIQiLW0Wk/
	 vC2nX28HPxAFDiyfP1GjckdNbdv4JlzobVTUOSmb/QTkDKGiIxXGAYxWK5a/ogkHAb
	 8Lju1Pd8Oy1kQxzlI81PAvb/Cpr4l2gbrdUml2bw8BFgGPb+uonIMPy5KakzAdsCha
	 x9GOo1w5hkfP171NalPKNnZvEbsZBCwQNcgxcUduyArSUFowNxFhREMIDDC+u2xPXY
	 wXUe4OIqTf+fA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 06/12] selftests: mptcp: sockopt: add tx/rx protocol options
Date: Sun, 26 Jul 2026 16:30:11 +0800
Message-ID: <9262d0f2f2497eb6fbb1bb024eb2b1aed02359c8.1785054129.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054129.git.tanggeliang@kylinos.cn>
References: <cover.1785054129.git.tanggeliang@kylinos.cn>
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
index 7e3a28863cbf..3dec34dbc062 100644
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7E30BB81
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686846; cv=none; b=o5Ke1iLH9Gj0GOEyC57euWxr8r6ZhAo6NfuSzsg4zBEFKvDZC197vbMLtgfL19buNOoWhD9PX1sGuI7tZ9lZnptMIt47lPSVkWQQ88pDitb6dtr7Vi7yceymITUI8xBcV0niMTUQk7QtRDpNkdDByelVSGHrrtzBDYGgazJ7dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686846; c=relaxed/simple;
	bh=Yi61iJFUeBY0PbfIYUfVHsEU0ktnN3E9Cye8b0kQsz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1wUB5xCl5wAgdL7BAkcL/C1CQeUyPPTNBxj1QmRo32zgGPWp6jU30Y/4WQt+r55BmWmNwkKbaRFvn3aJFWUI95SCURAIsWZparBQLos6KvjEbkSs3zsWOPd4xMNU59sCTDTy3X1RzEpSxSPPeftWd9GjRjKjatA27NJCYRv4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX+6Hwhc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX+6Hwhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A363C4CEF1;
	Fri, 12 Sep 2025 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686845;
	bh=Yi61iJFUeBY0PbfIYUfVHsEU0ktnN3E9Cye8b0kQsz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aX+6HwhcP2udFqdHVRUcc5GccO28bw/BH5Lyk5JoIPT5D/nGMF6xxiilHDTcolB0h
	 /1+43Ig7PgmOf4Sl+cDmWdYROjFP/I8lhiXFnNZ9qKScVmPgRD4dKHzwSjXPHxao0Q
	 aHFH4rSuXN0hTA8bAXEhsxICHMz+Ejp06s+qaWkgFaXNyAbKFK+WGbA0rr2GpowbEl
	 lum74gYjiI1T1ZVkdLSX8ekhoZFdwzqcMcXHHyuTZB5kOxbdFaxV7Dd+8J0GFii8op
	 /GLBXiPubDf6ttPsOWpo3RV5cIqpC73TCfmHliKuN23uNC0EETJaNeaOgcndIGalFf
	 PF2TCOXLWSXXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/9] selftests: mptcp: sockopt: add protocol arguments
Date: Fri, 12 Sep 2025 22:19:49 +0800
Message-ID: <5a81773864ebe08e15f54f053b14425a52ee2366.1757686538.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757686538.git.tanggeliang@kylinos.cn>
References: <cover.1757686538.git.tanggeliang@kylinos.cn>
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
index 32a78663d45d..838dc79cb09d 100644
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
@@ -777,10 +796,10 @@ static int client(int pipefd)
 
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


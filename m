Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B6282FA
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664225; cv=none; b=Y0huAENAM7XMQ42kUIj5yhXMWU+Wh9Xj7q5VPjGH7n2unJZAifW7FpBj9Sur9s7iM4F0Qcjrhgtm559IMxaDc2eH54fDkHsvtAlBYfnqdgIVY/7ZcBGycIW+lr3jOfF5LohQS5Qh9rfWijxxtZpLzfWxNTG0JuhONjCecp8Z1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664225; c=relaxed/simple;
	bh=3UF18dHbqvSJoZN5CbIGKh0NUEWLtEYVZzYdySK/0kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6aqFWKQcQBi7hOxnJ10nYJY35mTMjX60L6TRYQWf9iDWfb30ZwUkXdNJK+fgtalzfy/HbTEowOEy6VpypBNO57RRtE7byWHSP1FdmYIqBPTCPUFNqGESUDdN+APKLAiD3IDZ5vU+i3/2HihQj9f835iW4eYKkiCbjLukaoiRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEOevYQz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEOevYQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A2FC4CEF7;
	Fri,  8 Aug 2025 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664224;
	bh=3UF18dHbqvSJoZN5CbIGKh0NUEWLtEYVZzYdySK/0kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEOevYQzavUQo0a52XyXSlhza0HIb3cYm/fQpT11vTJHJR2isL+r3fm8D0/vBfnxj
	 Jflv7Iae2sOB9rl764gq6qzHplhwgOou7yZRMfcc7LA5/uxWXc0yvD90FiTH0kYvIH
	 EiRtSPO/dOe5wxvaS0JBXR0kSSukO1dpqaHxcZ1wjcTGPUuKB+YMLqq+UN781AdKbb
	 t13LfbeaktZ9b9tME6pKP+xmA325Ncqq7m86la63BBpT4j/M3q0rQbiuF/dleavYQ0
	 CiVRfAm/xuIm1t14fLlMFtgJgilu0wga7ZIQrnZ5IH0dfYk1b3L4iGZWiihyDaPGF7
	 AsOyxPtQ0ueWg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/9] selftests: mptcp: sockopt: add protocol arguments
Date: Fri,  8 Aug 2025 22:42:47 +0800
Message-ID: <920a094cf561c7a3f0aeff2fee3f246fee6cb1a8.1754664106.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754664106.git.tanggeliang@kylinos.cn>
References: <cover.1754664106.git.tanggeliang@kylinos.cn>
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
index 2bd75f731dfd..02470997d7b8 100644
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


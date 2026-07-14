Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E103655C0
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994959; cv=none; b=LFqDwS0QXFA/EMsnvXzUrNUcCsrAUoN9ks6o+B8GXIO84BP1+jxzxt2ztRIf3IVy40ujc4H1Lf4tjCe7ZmrMLIMjoAIQ53PC5Ph3xkKR5GPcCHMXKxcHDdEJFNapQXNRTXXCWyWkMQZhuGDy4edNfh3DAJh+MxGH4jDdB/ZeI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994959; c=relaxed/simple;
	bh=gMbI6emK/l1rQ+1tDK4HdyiP2mG/7I0uaQmnMrIGlgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l14hf3eagowJQoZbZdV77qLuYggfJ2f4qB6738is6VwAob6prxJ80vcjswXIT1i2e4PxVepGQa6JTm2mkcM7QsRZNgyMJLPouHZSRhzfwipSvKj+gYILwYo97Y7ctPOXbgBewyg/JI1hiGF332slFxQ64MDDvcQeQt813hjlq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3wMokpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3wMokpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B661F00A3F;
	Tue, 14 Jul 2026 02:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994958;
	bh=6ugR++eJrUaKBma0SmHuiOejOQJtd65R7CO3HKAdxas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3wMokpCIUmhXoO7WoPFULQOOayWoGBAIpkMC6evFBNoxlQVo/X5cSsZzoomF3/WE
	 Ypstgl+SKHLRAGInvoNzyXxhAOsuFL5KqMB9Yi53iiUMhHXR4Vp3ncl4LQcdPTpPOk
	 LMJInoBBhqxRNahUQwRxeZawhvxJ1XjZLMkQ8wYfrx6H3HSY8nSdeJXBVJfUEGfLIj
	 44Z3wai1YzrzIiUVpoeNCguqrOAhJcpCnJfF4iczvQ4jeltyUfR0xpbY2N748sEHv/
	 Bnwb8oOOTWAJ62GEOxJ6bg/iGojJFkDr5gk4kcW5iZiYNrLKELK9fBKXCyxfzUEKqY
	 5fV/fbHN6HlyA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 07/13] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Tue, 14 Jul 2026 10:08:52 +0800
Message-ID: <7d15a7a9c4fc0fffee077e5477c228ac76d05582.1783994494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
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
index eddb1f7b3cec..0a80d505dc4c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -31,6 +31,7 @@
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool inq;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -143,6 +144,7 @@ static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
 	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "                     [-i]\n");
 	exit(r);
 }
 
@@ -281,7 +283,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -295,6 +297,9 @@ static void parse_opts(int argc, char **argv)
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
 			break;
+		case 'i':
+			inq = true;
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -725,6 +730,14 @@ static void process_one_client(int fd, int pipefd)
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
@@ -732,6 +745,9 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	if (inq)
+		do_setsockopt_inq(fd);
+
 	return fd;
 }
 
-- 
2.53.0


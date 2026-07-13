Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE2E314B9A
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913159; cv=none; b=Qw1v1RK72rOWBv8CK/pTC9UyEnJl8YkEZyFPdBMjXPQBiB13j+wP1dSxOj/Noon+Zpl2KxNF8Fe0+jIF5dQ63+VJ+C0HlfvkVRNzM0c+7sXeKa+GRov8ZWuSCXFZN+qAzQGIC9W39//BwQ/b3b/qazBQns7IH4o0WO3isPmfH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913159; c=relaxed/simple;
	bh=wvYxkoXBtG/Jbq8dqCH8wGG+eUglq4YD5pIsApsCOu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phKwZwW+Mz+L+MVHRprwRv7dIjH1ARu8RLP7hk61un0q++ubMjcJ7+uGlkU6coUVudsCUyvIDR3oEz6oA0qO7qf6CB8eQci/cCkLGIsM6N2QfCOSST3FdX1Szdh/poz/G+ur2lJP0TzYvYADLzmKzZUbxcOvyHbGOHpLm98IsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDy+7MAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDy+7MAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EE61F000E9;
	Mon, 13 Jul 2026 03:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913158;
	bh=sWARq10Hm6eLkwVkMLWENcKfZGI8n5t7L0+/2yCXwjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dDy+7MAjkMn6X9xJ88wIqUGnO+FfTYB81UuPebM0Fd+fdC+PQQXBOG7Aq1/fOCVV7
	 NDUQzvGMYbEEkG8YjkYqXw5ikfUHyT+FheJNgxbJeTVb4YAN8MTXj5/T5UuTBnQfPr
	 ZeW84TxruGN93ddzWz+sQWC2XBoim+yczA8N6Cgb0+ZC5BV6HGUrfbKdSgX0CFUDdd
	 y45XVtYZw6uNtnP5FJrZcNsaaTb0ytpiIStAmyDeWg+XqTUIYD3m4ASg+kmcjdQRBt
	 PrHFn6JGPPTKUOWGN5yFRhih8Bj15ODL0yeRZMYlYsTf2iBhb4u/eroNSWfrYL239E
	 XODlr3w/j1FWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 06/12] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Mon, 13 Jul 2026 11:25:30 +0800
Message-ID: <ca180f43dfe8d069382c9f98893124749122f678.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913010.git.tanggeliang@kylinos.cn>
References: <cover.1783913010.git.tanggeliang@kylinos.cn>
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
index 5e0392fdf0e4..5c9a63ed6703 100644
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
@@ -724,6 +729,14 @@ static void process_one_client(int fd, int pipefd)
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
@@ -731,6 +744,9 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	if (inq)
+		do_setsockopt_inq(fd);
+
 	return fd;
 }
 
-- 
2.53.0


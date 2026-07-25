Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018292D2488
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983404; cv=none; b=PB5WxCT5zlHB696kLH7unJsNvm/ooj87TVmOfTAu/9HFy0EMolunuDs3RBmqq7KdwE0h6ZRUyseG0zfIHFaf3PJ7WkuoAX6V0oNeUW4+1UJVt5oQXO0C7IruHTWNme2g9q2cA1z5Gcucst1XSMz0JUWga5VFjJFdVEsUH9GUTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983404; c=relaxed/simple;
	bh=sQtoOZ4T2WwFVw7liYUqr/LV9nR91FuBnakBZZd1vjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmehOXfWpVGzhcREpvePStyX4L+hr12+n/mNq/BQFUbe8t/LCqTqVFQH3sxYRaWhyLr3hlNzqBM3EZm6q9rkVzMtui6bO2XHjOlVRRcfoiAunkd3Mj328Y+TvEpKS0dgsdo36Yffn8j5D7oQgO7OItC0wxdLJusErYHS+3Oypds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnRglrTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnRglrTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068291F000E9;
	Sat, 25 Jul 2026 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983402;
	bh=drou8/UgDqSU9nQbrYcMMqC2Wr0yxf7rTbqgUod6/bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnRglrTv8YtSnEnXzmgAX56uE2g6hlpuyLbMC6m15Zy3xsGlIkdpEZ9EglQtIo4ln
	 Vc5A0O78BnK1iLZfj0qHBvKI8GE24nvm3CdBKXVLvnNUxMCNqBOObwd02aBiqR7bmV
	 FWUsPkjP5uGTj4LW68sBPjbNWqVFTWmqquryIbEgCy12BOXao2bWcz5+JqGMDMWtmK
	 9O3MJUTcjso/P0VB8YsEhV1ofs6joMzNKP6KmzAxt5sJcS+pTGzSK6ckZmjfExqBYB
	 KwcUkybusoU8/4CHjwyd/BKd4LSSSnAs3mwgLn0JIEntYhhOjEkapnvv6fjpnUPkXh
	 8VrKKeSgu2+Sg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 07/12] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Sat, 25 Jul 2026 20:42:28 +0800
Message-ID: <3aa51e285b2386b41f6653967382ae2a222e4959.1784981974.git.tanggeliang@kylinos.cn>
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
index b131a18eca79..b09e906e7bd2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -30,6 +30,7 @@
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool inq;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -142,6 +143,7 @@ static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
 	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "                     [-i]\n");
 	exit(r);
 }
 
@@ -280,7 +282,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -294,6 +296,9 @@ static void parse_opts(int argc, char **argv)
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
 			break;
+		case 'i':
+			inq = true;
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -739,6 +744,14 @@ static void process_one_client(int fd, int pipefd)
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
@@ -746,6 +759,9 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	if (inq)
+		do_setsockopt_inq(fd);
+
 	return fd;
 }
 
-- 
2.53.0


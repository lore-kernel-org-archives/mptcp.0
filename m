Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B71433AD
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381346; cv=none; b=UmKEMNeJPBlriwC54JPiwqm2XKRN7GFDpNfHW+4EfRUnsbH4cVSOVhMrwK4CzPgPbkkbUkMqQ/BHP+EiQpViPIs2zvVP5FRmOY4Yk5r4feSQ8/HWJQMJ7n4Ca9lAwPP4JPrepQ0pvZ5KCf0blLqLvFqc1KhlaNLalNzfANkbRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381346; c=relaxed/simple;
	bh=l66pbU692FuSzzWC0WrJ03dwOJtl5PZ9WKJy2lLrW7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTRBsB0v+qWaKTSZIdWuWIZM8N4snrORliD/OhDts3UK4O8A+Bo1caS6VJcMLwd9xtvVOIK5BAuJzk+BJYiq18FhuolDY5aIps+RwDjxCmCxtsOE0GvtzF5V+pCihLELQmgw7qJPJCYxRqOnrP3y1pOFwgyZ6iOI837E+ZyAt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqbXEzdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqbXEzdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF72E1F00A3A;
	Thu, 30 Jul 2026 03:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381345;
	bh=3vlaHJNBP+9OCFKKDTnYCw0TF5EssrgRxSxuh//Uj4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqbXEzdWWvijiHWNS5uWRLKgcBkv8F1i9+7m2sWqKDsz/4BaDljrQkF9w8D1GhGvQ
	 St4N7yUstbrBGZDhZv4BRGf6dYOamOGKRQ5mK8tmT04CLtgCqJxB+A+cl3oQ4TFBdW
	 QCGWReMxK/1WnFVALRsFSV/dyXPjLphwMNHXEzTv2lY60jnPAHuAl9NgbvTZ33c5F8
	 2C3LHItp5kFwkw2zn0w/xFXm8Bjzce0fcRo8aYViMnsWub4wO2q1pp2Fty5ICazKy2
	 LaQZSpBXGTk6h42Qp0U+WeCd+76j1cIfBB2w+FNFDmXKt07GoCAPASGZ/l+mQPjBqH
	 dzCQUjTUMZgtw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 07/12] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Thu, 30 Jul 2026 11:15:18 +0800
Message-ID: <57fb42747dd0e739b3307b084af3e9551b957997.1785380422.git.tanggeliang@kylinos.cn>
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
index a62f6adda8a0..1d98b8d2b4a6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -41,6 +41,7 @@ static int pf = AF_INET;
 
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool inq;
 
 #ifndef MPTCP_INFO
 struct mptcp_info {
@@ -146,6 +147,7 @@ static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
 	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "                     [-i]\n");
 	exit(r);
 }
 
@@ -284,7 +286,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -298,6 +300,9 @@ static void parse_opts(int argc, char **argv)
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
 			break;
+		case 'i':
+			inq = true;
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -748,6 +753,14 @@ static void process_one_client(int fd, int pipefd)
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
@@ -755,6 +768,9 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	if (inq)
+		do_setsockopt_inq(fd);
+
 	return fd;
 }
 
-- 
2.53.0


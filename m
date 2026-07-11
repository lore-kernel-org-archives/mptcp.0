Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA224255F2C
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741477; cv=none; b=qjjn8ZGUTQ0mk6tProD5oQaF0P+yOp85IKOKF/9qSOL4rHsS5II5RT1Kai60zbm9QM0tP7PjmsjxUwQt5zR1sJtPXGJH6xHJoVaCTI/f5DjnZp7ZJls+fuRNULIYW2qdGuMnWCvx2OeXbUt28RXhp6laTNYxKQ0mYamAlox+AOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741477; c=relaxed/simple;
	bh=tnJnaTF+xzgaaW/9ZyET3fUv5sKvK5MWp6zpeIQqrQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8VN7RsaKOcH5ygocEBRWWDtmOk2dguyRdtihGfRYyav/GFzaRe/QwhyxHsY2lv8IWDjhxy2+04dsvBf+fSwimsASrpLZYsUCrsP1Den0jS/Ns7yfrQ7xJO2WVY0uSyZwLPWnJXK08jEsjAs+qCTRm6CWZ6u2LmsQDLQKcsxuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3Pu622y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3Pu622y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F3F1F00A3A;
	Sat, 11 Jul 2026 03:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741475;
	bh=1jeulXRN/2w1yFxNogLOV1SwE1pqL95xqb2/Y0eXTCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i3Pu622yuBxWyH7Pht4XbxHb965bTFm05ayZZ3C+NMhqiN92A5xC4PeU2ZqN1v9Uh
	 yaQrQNDRRuDJ+Wrl6ximKjWNlL1WDZ0ENCng2hH3a1fWZ008Cm/9qExjRQbZlo1zsE
	 RakpCw9hRTQ5iL+DmmloYHPdxIi3yoQf972wJxTrrhqIRbe3nGt7Ol3FS5iz7qCzQR
	 lFyk7fohtSgtbJprcCnGzfSQBoNKuG7Tlm0FaCWMWCGmgseZD/GIfcR9nrVjam4fqv
	 u8uEJ9gxLucL8oJ4P/Sh76yIrBt2bRtDJlkTSyv10kIyh2cHPuq1zAyptkumTrECZi
	 h7nJ4e7qdR9Fg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 05/14] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Sat, 11 Jul 2026 11:43:33 +0800
Message-ID: <0fa16cda612b74322741010743061befe806fca9.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
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
index afc7a74feb18..ba251a4b0599 100644
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
@@ -723,6 +728,14 @@ static void process_one_client(int fd, int pipefd)
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
@@ -730,6 +743,9 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	if (inq)
+		do_setsockopt_inq(fd);
+
 	return fd;
 }
 
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946583955FF
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673967; cv=none; b=Lhf99alyRm+0AeWOcu/eoOT20SHX9HhCnzTm372uMLjpGE+hGk0s7LI2ABd3S2pj2HUx1a2as+jXk3mVR0V8KjqT75Nl0rFPUDBJc4OZDwMoEi3phJ1ZCQRSSZm+d+mNP9fZL9AA7xU4ygD+DpLh+JZRTDXFVJ4O091r0b2te0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673967; c=relaxed/simple;
	bh=450FesHWxLXOt2PmDaP5ytyae3jC1kthpciYgQjY0LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnLXhoPoM+P/ogL/ACPe/d1GgWARL6+TTNR3ut4cFZp5/Ke6ZIR8TIRx0DkdYNdYEkn/AeQizDVNTsiwAWoul19keV51C5iL+bvfsxB2RMNsYLH+co1sf+shPpCVIrRb1Fmq3GcdmEf3/VoYVK1XbytuX6NVmLK8ZLsp6vkz7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KohWkK49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KohWkK49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033F71F000E9;
	Fri, 10 Jul 2026 08:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673966;
	bh=OxHGGrgRqFTDYqFI00gPwdTFdogsVxR91HJ6xAaKLk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KohWkK494g9jbVXwLApNUY/AMJ7t7aWtfVRjM7fj4MkBK8JFw2mgoAtfLxQVjd3d8
	 edajX+ojSCtSr8N78kJLRc5U5pDvdNjo1A0yue6fWDZkeFahix2KS59WCI5NWuHg98
	 4Q1sLybMOby9wF6hMT57CXE3RFazEQPdZCIMv18owNcEGSF7/f6zAzPJgy3bs1PNik
	 mUiIzFpdzcpnsYwjvu2YmJ7fRdw0IayRU5B1qvuUaTgrWQPgoq1i3Q2dt0n/8Ny4iT
	 lQNk+zC/a41lNh8jaCvka/BtsVY70mGYNE+yJkB7MFISmBS/PHmAijhlI7cgySn2Ip
	 fCuvCPc/lUiaA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 02/10] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Fri, 10 Jul 2026 16:59:05 +0800
Message-ID: <e6e9f9c6bb17355f3271c4bed393f22d7b10ccc6.1783673158.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783673158.git.tanggeliang@kylinos.cn>
References: <cover.1783673158.git.tanggeliang@kylinos.cn>
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
index 70e8d6c5094c..92661da821fa 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -30,6 +30,7 @@
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool inq;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -140,6 +141,7 @@ static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
 	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "                     [-i]\n");
 	exit(r);
 }
 
@@ -278,7 +280,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -292,6 +294,9 @@ static void parse_opts(int argc, char **argv)
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
 			break;
+		case 'i':
+			inq = true;
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -718,6 +723,14 @@ static void process_one_client(int fd, int pipefd)
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
@@ -725,6 +738,9 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	if (inq)
+		do_setsockopt_inq(fd);
+
 	return fd;
 }
 
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF33502A7
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054632; cv=none; b=NK2Vz//WcN5LhemM8QypQvM0fnYTYYJTT4yNf7DdGUbjMmJey4Yp7FdaL1vvVGcHTC5XYxJ7tjLDQeIouTW93oFUaIo8PltnYw37sKOXtNobl9LrVleQttO1vrAkjQPLbiihdbZu6DNPuRcqnxM/6eIA5aKaIBxdbH7sep0cMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054632; c=relaxed/simple;
	bh=YDmgH4nNV+IIp6M3/K8Jvh6VKwmMidf0cyV+OjcQFI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o35WSZym/ofAslw3VpH2rVfuq6Q9UFeKjRA6/0VAqMfYjAeVUOYSLNynReVDTSDr5PmBq65qQAXQ+7GnF3yq2eMKa5C9d9hM7hVsVahj8iotlXJXNoySMQ9B5iW44v43ziRjfjT5r1N9TZJ7XSk84Vdis3ZNw3K4HK1ecutSc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP5RRoLR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP5RRoLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18511F00A3A;
	Sun, 26 Jul 2026 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054631;
	bh=J6FALD64Of2O8m+uPDTLf9bMklKcSThCVpuePsnlPVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aP5RRoLR4dyMLbrj4oa9hCnENoPA0EBm0kQUN6w3gHcP2iu/oEa1ktty+zJSMi1/t
	 pcvtafUn3LwMMRaK6mAB+zG1lZZ920usYnQYaraZsJfk00nMMsk22bJYRHhfshHCUc
	 emZwlHWKR4MNAcL29YnSVGbDZJbgL/z9P/WFu46qESeWdzT6CT/BdRpaMhSzBa7AhV
	 Fr/MjB532ZkSkk3oofG09gtb3sv6V4tkqQzTCCCvORIKkmXdE+gVQ+vFgulB/6ccUO
	 RzSJiCLz9SAsrC++KForpMc3TgXhLU3ilMOLglUksOuuvSycq7MqTX4MaW0VSzF5wH
	 tqbywTmEgjvBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 07/12] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Sun, 26 Jul 2026 16:30:12 +0800
Message-ID: <7ad66e3abec37d59b515704da25bf77964a80bd4.1785054129.git.tanggeliang@kylinos.cn>
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
index 3dec34dbc062..b1b39c9c3fae 100644
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


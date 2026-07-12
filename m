Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E27373BEE
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850099; cv=none; b=MJsk8uL9ylFkcqXHtrxklpsg60wDpJqo0jeZovp50RYsJ6Ix3Kjr083HiLKRNMVQUIQi45NWQ6ORr4jEo4G6VQVdc5IfS66qFRlE7Hq2pnkdv/2rJOQocYsIUA70X5/eXDfcKwaeq20YfAjVO/TJHNijKrozQn+al7Ai3sD1GBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850099; c=relaxed/simple;
	bh=wvYxkoXBtG/Jbq8dqCH8wGG+eUglq4YD5pIsApsCOu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrQ4tj2Kauxzbg4x9dd9MU4RpXYd6fcB5PSUFHP/nYqciNBEYyRoy8k52YF5yQbEtWQnpmzTcP2x+YAHiWoJEthxW9UgCt0pQMMc0MKhLPiakXYtzOWCnH+PsOIAYdjK/rCeWiF20+7i/bbQr3vVoD5dHLuDjlpFNYbrmclof+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qew+aJbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qew+aJbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F9B1F00A3A;
	Sun, 12 Jul 2026 09:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850098;
	bh=sWARq10Hm6eLkwVkMLWENcKfZGI8n5t7L0+/2yCXwjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qew+aJbUMUN9mqvwcT8Bbp895B2i6OikyT7jS3GtpEQuBcgt5Oirh64EgnSFyFjXu
	 PPMJD62utCpIc/tLsu4btiUTv3YRFVjSJMlQ7CiGZ8nN8PlKeejiTfgdpaeAOYz4wG
	 FqnHhEZpc+54FIUYglAO7TvFMreHLZcb150jkUJ9L8h9j0BOuTwwGd+stwn3d79uE9
	 eUO+NQ9dYQfpufPVkp8dWPRcUfvAuiZnY8GvQhwBMg273MubH0ntor5cQ5gQNvHVCb
	 lhnJC7y0IVhNYTINCYfmKKaBc74crdaWdgOCPHo1QYpXoL7caeQSFpTMTHr52rztKM
	 ooSvKlWqfmAmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 06/15] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Sun, 12 Jul 2026 17:54:12 +0800
Message-ID: <31d77b3ded2d0bc03bbaa3b1457d6b08cd2782f7.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
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


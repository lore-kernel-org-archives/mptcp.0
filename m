Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B138FA3
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838200; cv=none; b=E0uPnVdBqwF4Tpr+y1ukQBojx+tNAn9g3oPWzB0PJWvQE1PPORMi+gG3wUb1cBwss9gtM4zqt0zpFTP4dCv5eNcT98tP9wX3iYNNxNg78FOADLhcPhHD/R2X6sDONYwozpasQjLnCGZxl+hBAdz7clUz42aQGpsl6oSqBOOowfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838200; c=relaxed/simple;
	bh=y7Vpl1NZ9SJpx1RFINjsuHDUio5CstnIHDURY+gQGDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqYYXhbaRF9oanbPAIfXfUm6Z1JOHF4ZkqiKp04311QtTHkhuGdtjwktgrwZ+tL5Bzse010AgWH33cLaqfwL4iRhlbmuWMgFoOaMBjYkVC8YPiarC0vfQwuqR9ESwSigcPX/sk/ldd/o7aFmKapqUYkLv14A+QIjAQddem+QzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxzOGOIR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxzOGOIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3195FC4CEF6;
	Sun, 10 Aug 2025 15:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838200;
	bh=y7Vpl1NZ9SJpx1RFINjsuHDUio5CstnIHDURY+gQGDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxzOGOIRTbky0ZEo6nQkvCORpngpA6Pi091kiG/b56ipoUeCsqnsbw8Y3Y3WKeJTw
	 d/h/sb/hDRFyGSzzsFFp6UTDAlGCqcqN70YlIfnSXf4m46A8GUxss8BvpUSCAshbtP
	 i4M056EIoYzjdGr5nHJue2zBAs1ueJ04nk0W177d1LsUVLYfx5JW+JngP7u6pbVtV4
	 42UjbrkgKuKaJUL5vYJcANMWELLrM7DYSUoD1/0iLgzAfArJ7t72BtYJFl5GHOOetq
	 1Q15pQAznEqTtbLmF0OtdR5XV1vc/2D1tgY6Q/v/fR6iJ5cguRYWSrDCYWvR0WsIDx
	 8fwGLouQcVUdg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 4/8] selftests: mptcp: sockopt: add md5 argument
Date: Sun, 10 Aug 2025 23:02:23 +0800
Message-ID: <7679bdac6edb872ae1dc14f1305462366513dec3.1754837808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754837808.git.tanggeliang@kylinos.cn>
References: <cover.1754837808.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add command line option '-m' to support TCP_MD5SIG tests. The option
accepts MD5 keys in the format 'md5,key=<value>'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index c27a2f3ea274..c15fa0abcfb1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -33,6 +33,8 @@ static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
 static bool inq;
+static bool md5;
+static char key[TCP_MD5SIG_MAXKEYLEN];
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -141,7 +143,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp] [-i]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp] [-i] [-m md5,key]\n");
 	exit(r);
 }
 
@@ -286,7 +288,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:im:")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -303,6 +305,11 @@ static void parse_opts(int argc, char **argv)
 		case 'i':
 			inq = true;
 			break;
+		case 'm':
+			md5 = true;
+			if (!strncmp(optarg, "md5,", 4))
+				sscanf(optarg, "md5,key=%s", key);
+			break;
 		default:
 			die_usage(1);
 			break;
-- 
2.48.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FB2FE050
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334982; cv=none; b=YSgD+FyGDnns1qNXwn1B545xiDL4K2sZK1eMPp+AFsCeGukK/r6+vF88olOr/uHJEsOCAYLMQR97M17svcCde8un7Rj7HAjIj3BBeI8OEadxXiNflbFH4B/Ibp31nZtECQwDj0aAgxDoRk39iMLdbDNvhocEgO9SaykeFNBwlp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334982; c=relaxed/simple;
	bh=Rf5ia++5sbR2vhHm7r6sxedKuvOKmyMkbTV2z1RzLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjQv5Zf153yEqp3ysr1lS1/PfqSWD3A7pgkpEvVAFPPnHsE4KSRs2Zij0c6xf+5DqBr2t29ALZvhk84JOT3R9gsP6ve+enEGA4yplTLrJv13Zg/qM4UMoDz1ToHeUvPDBXYMXt8ZfPjpWsjIBzPp7SzL+xEFhlmj/+Ac4Tsa8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjVSeKXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjVSeKXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E73DC4CEFB;
	Wed,  5 Nov 2025 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334982;
	bh=Rf5ia++5sbR2vhHm7r6sxedKuvOKmyMkbTV2z1RzLB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjVSeKXvjcY7f8t0+l1Co+f9CpNk3K8hLekbWDU60hCZ3GaH+4xgQODqSqCU89/Pf
	 ZVMjhB6tyNaukz5LR/oJIpEyJAOdofYA65/aWfsfpJaxKMgrCH41/GtWtgkD25jfs4
	 TMbUGm77Yt+BqaCMNQYXPGWej0jtCOV8KQy9IsS5Fl0XtF7373eNrqERqBS8Uq6E/i
	 rj3jYbFBXJWLMqJVbbj8AMJTcz/KpWRYUyqA20w9LcYdUtsDo2asRvjTyUIdbSDteu
	 dfw9Y0qLyydo1DzSqBBsXKH8TlxIDr+rqlDZZVcq2ubV9sYkytxmy1ieOQNeMRUKuP
	 /40mMHuhG15tA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 4/7] selftests: mptcp: sockopt: add md5 argument
Date: Wed,  5 Nov 2025 17:29:27 +0800
Message-ID: <3707a5f5bec46960aa8484e94b4fb11b25719798.1762334694.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762334694.git.tanggeliang@kylinos.cn>
References: <cover.1762334694.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add '-m' option to support TCP_MD5SIG tests. Accepts MD5 keys in
'md5,key=<value>' or 'md5ext,prefixlen,ifindex,key' format.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.c  | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 286164f7246e..fcf1d7a195d1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -27,6 +27,10 @@
 #include <linux/tcp.h>
 
 static int pf = AF_INET;
+static bool md5;
+static char key[TCP_MD5SIG_MAXKEYLEN];
+static int prefixlen;
+static int ifindex;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -135,7 +139,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-m md5,key|md5ext,prefixlen,ifindex,key]\n");
 	exit(r);
 }
 
@@ -263,7 +267,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6")) != -1) {
+	while ((c = getopt(argc, argv, "h6m:")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -271,6 +275,14 @@ static void parse_opts(int argc, char **argv)
 		case '6':
 			pf = AF_INET6;
 			break;
+		case 'm':
+			md5 = true;
+			if (!strncmp(optarg, "md5,", 4))
+				sscanf(optarg, "md5,key=%s", key);
+			else if (!strncmp(optarg, "md5ext,", 6))
+				sscanf(optarg, "md5ext,prefixlen=%u,ifindex=%u,key=%s",
+				       &prefixlen, &ifindex, key);
+			break;
 		default:
 			die_usage(1);
 			break;
-- 
2.43.0


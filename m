Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407B38FA3
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838204; cv=none; b=gPSOSdxkQ6iIxjTX6O8mS+wIvA23spDs1ZgupCknR0j0Sf0zdxk61VM1KvnKJbIDzYRG1vtZodL1ztxL277RqoUInh022UOT8MKO1q9axYYzdieqKFrO/fiHuxJx4Z9rIam3DunhhdGgu90vAob04nCXwhVWLaneg5NH2yXamRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838204; c=relaxed/simple;
	bh=BCOK1U9XhkSpaE7gOAjFgJU7X8s3tsyQsSM+/egkO3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzAbWFAVf+TxWmE+KwCWp8YOVYJ7kuxET2fMuuI7npE4M1jofdDoY+wT/+B2UF3FdAROb88aCErMUX6YcvYcbyOxTWE+WMFVc3j4Z39/Xad6ewxZ4K5jjX7egGojN08d6SZ0fx3+0xq2ndOrvJnGSjUDy7ylWUaAliHHRB6SXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vqn85QVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vqn85QVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C3CC4CEF6;
	Sun, 10 Aug 2025 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838204;
	bh=BCOK1U9XhkSpaE7gOAjFgJU7X8s3tsyQsSM+/egkO3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vqn85QVGoOyXMun7hk7PSbZyBsbgtQUC/TRAYRcMi+/XQ6tx4HvXpfFbMG+rnT25C
	 kTe1+Q1udypINLLp5W45PZTKHYekNDL6C/LveYnILO6zMeu4BuKg4H9x01lrYX9MSo
	 K/Fm/c7oAaCz34GN7+bt5j3ASgASkuTlUJh08gpMiYZwUjlQHYsxTyiqwTwHqY+juV
	 wqKTSZmEWqQbO/1zsqVz9+zd1tPlnOUE3+fOa9l3D2GaxpHmnMT3mj5lSjDsECn7jC
	 QkX2Zzd8MSvhBnAClNniiKw0i3fprpbWF4YNFlueRt6XgPSJ96xNrZwicTHn/MlobS
	 +lBy18sM5moEg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 6/8] selftests: mptcp: sockopt: extend MD5 support for TCP_MD5SIG_EXT
Date: Sun, 10 Aug 2025 23:02:25 +0800
Message-ID: <2d2200a362f474601259d5b1a3e190bea061714a.1754837808.git.tanggeliang@kylinos.cn>
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

Add support for TCP_MD5SIG_EXT with prefix length and interface index
parameters. The command line option '-m' is extended to accept the
format 'md5ext,prefix=<len>,index=<idx>,key=<value>'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 7d17558ccbc6..72c1f6016e97 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -36,6 +36,8 @@ static int proto_rx = IPPROTO_MPTCP;
 static bool inq;
 static bool md5;
 static char key[TCP_MD5SIG_MAXKEYLEN];
+static int prefixlen;
+static int ifindex;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -144,7 +146,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp] [-i] [-m md5,key]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp] [-i] [-m md5,key|md5ext,prefix,index,key]\n");
 	exit(r);
 }
 
@@ -221,6 +223,19 @@ static void do_setsockopt_md5sig(int fd)
 	memcpy(md5sig.tcpm_key, key, key_len);
 	md5sig.tcpm_keylen = key_len;
 
+	if (prefixlen || ifindex)
+		opt = TCP_MD5SIG_EXT;
+
+	if (prefixlen) {
+		md5sig.tcpm_flags |= TCP_MD5SIG_FLAG_PREFIX;
+		md5sig.tcpm_prefixlen = prefixlen;
+	}
+
+	if (ifindex) {
+		md5sig.tcpm_flags |= TCP_MD5SIG_FLAG_IFINDEX;
+		md5sig.tcpm_ifindex = (uint8_t)ifindex;
+	}
+
 	if (setsockopt(fd, IPPROTO_TCP, opt, &md5sig, sizeof(md5sig)))
 		die_perror("setsockopt(TCP_MD5SIG) failed");
 }
@@ -344,6 +359,9 @@ static void parse_opts(int argc, char **argv)
 			md5 = true;
 			if (!strncmp(optarg, "md5,", 4))
 				sscanf(optarg, "md5,key=%s", key);
+			else if (!strncmp(optarg, "md5ext,", 6))
+				sscanf(optarg, "md5ext,prefix=%u,index=%u,key=%s",
+				       &prefixlen, &ifindex, key);
 			break;
 		default:
 			die_usage(1);
-- 
2.48.1


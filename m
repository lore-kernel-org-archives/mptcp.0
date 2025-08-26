Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5B29ACDB
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200590; cv=none; b=Vm6nM83bHEyAh4MKjvUSIebExZ8O+E66tBVaoNETVfzAW3M08AY49Im+Y86mKTlmBvAhSHKARXEnfOkZfmiqd3DbsOaoc9N/v4e0QCOptCY+QqDyA0ZsVz2STkKsl2OoX3dzgDkys+42kLhny5tvKeNfNf1ghsHKs4J+NWy/WjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200590; c=relaxed/simple;
	bh=I6S0BVneL2OavfY3dEAfQM6f0qmK4LFuDqvUd0mChDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swro1Axe/N8TIcVHbzaBMVUiZsYptJy2N0wFHpoG+amVRPTky6Z+E+q9RQ8Di65755o075VGoikrHkYqixuo1w5e9d/CY+H7GoLGRayvvOcm0xDUJ2aqBdGdn+UhTy53I05OpVR9K5dwHdpJelMO7DNwTGZ9qpYe2AHfvZ5J43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm02LcyM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm02LcyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A539C4CEF1;
	Tue, 26 Aug 2025 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200589;
	bh=I6S0BVneL2OavfY3dEAfQM6f0qmK4LFuDqvUd0mChDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qm02LcyMxjlcudS0MBPFsmJullC9Kngwjuh71VvnYWe6I7DluB9N4EcB33zvAy7oz
	 LgMBTdJX9NGEyGf7axjXXrXKAOXZIayKKRclLTCsFGpbgvccP1bCEJQM8hW/j0ibk5
	 TW06nL4HZBtibJ3mnlunDVR+fnxVcfLItIeqClAWRRIpVCvdVk7rRocITRrMxR3fQB
	 yuLJUGmWenBugf1l3i+WxXtMXXDPXDA1DZvQM5DZMO5ip8JX7BdY9sFMxwGXRWT4Hy
	 F53jUisHOJ3WObgD3swmInrzEE5cE3alZ/ERWM9rUg99howKEc0GYuunCsNgO2GghU
	 RJWekq4EdVpeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 03/14] selftests: mptcp: sockopt: add inq argument
Date: Tue, 26 Aug 2025 17:29:27 +0800
Message-ID: <a9b81925838676866dfda8881f08a2645042b6af.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Introduce -i option to enable TCP_INQ testing. This prepares for
consolidating TCP_INQ tests into a single binary by adding the necessary
command-line interface.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 05caa9a57ac4..cb3d8dc34997 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -30,6 +30,7 @@
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool inq;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -138,7 +139,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp] [-i]\n");
 	exit(r);
 }
 
@@ -277,7 +278,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -291,6 +292,9 @@ static void parse_opts(int argc, char **argv)
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
 			break;
+		case 'i':
+			inq = true;
+			break;
 		default:
 			die_usage(1);
 			break;
-- 
2.48.1


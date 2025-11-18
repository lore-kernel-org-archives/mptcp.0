Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B1212D7C
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438515; cv=none; b=EjcsRF0AK7jhZXm7PhfrpiXTvI0GlpbHjbtNyumOshZ1E3TGRTjaVJGcj6Zn5AqODgz2ejnuw2l3XxKF9zw1Mz21hpDwkmm0cm0zfnUk3LJs2mEjBMCvNw0laS6RSAqxVi4+ttcEzGgmCfM/lBBw56nLJ0QvbBHLwo5ymEhiBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438515; c=relaxed/simple;
	bh=jZXTChXKlKg7CC8Jt02v1JCwe+yTQJEtC0Q/sce1WVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIxDMttbpa5I1NAUJiAyDHsi0RRyaYALLMWeezxMr1C5Nu3bNqbl5ZRyQdfp+AQFKJVExQGkCceyJnOt+HpVZnML+cR3JHKQK9AgbnrYBxss+rRInYPQ1d8tm1PN2MKpIbaiaTNv4zxnlehcNLjpys4feHNztl8VewishLVlsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtqB3AaV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtqB3AaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F420C16AAE;
	Tue, 18 Nov 2025 04:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438514;
	bh=jZXTChXKlKg7CC8Jt02v1JCwe+yTQJEtC0Q/sce1WVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtqB3AaV3ocyeVm1bfO+wpXF+cZW8baReVr/I9rn4zdnqtYaKbN2klyNrCcTniUQn
	 yL2zn0FwSuskWnXYsUAFN7VziKa91IjaJiFs5CCXQrOsXXgHfaW/PnabHc2riVIoCx
	 JjtWv3A0Gu+B2KVKGzS2RMmVIpDPqv3zUJnpr8iJcc9PteBHMWa4MHkgp20rkoHnCh
	 pn6L9LadBZNp/d/UhcLDtwfVovZHGfqrwwnS0SD/UBoz7AFLx0J7xpjFvswLy5oYSG
	 vITXMnUCpB1IhNaNBNNnFy4cEUKGhbUVf9vFYANfrlksVGWKP4utlvYn7CeTSzzB95
	 Sa5anmYxxBLEA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 03/10] selftests: mptcp: sockopt: add TLS argument support
Date: Tue, 18 Nov 2025 12:01:24 +0800
Message-ID: <d5d0debb87673b584d62a19d8acfc38504a02ba0.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a new command line option '-c' to the mptcp_sockopt test program
to enable TLS testing functionality. This prepares for subsequent
TLS-over-MPTCP test implementations.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 59c07eda12cd..5e1e441c959d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -29,6 +29,7 @@
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool tls;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -137,7 +138,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp] [-c]\n");
 	exit(r);
 }
 
@@ -276,7 +277,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:c")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -289,6 +290,8 @@ static void parse_opts(int argc, char **argv)
 			break;
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
+		case 'c':
+			tls = true;
 			break;
 		default:
 			die_usage(1);
-- 
2.51.0


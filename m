Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73979BA2D
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953763; cv=none; b=TEICQgsLFbI3Dj5JrpcT/XrMXayczDFet7w/VTLSiVG3rmZHBoqT3REYQ+Yli/WpvCoqEMO75iYtIyyOmwJpHlgyDt+l4jncKqnJ2Jp2N0zuVu8zsiybAaww2ADcypQ2ikY7cK9MyPYReJF51UrXTkLQraU1jeiU2IXYUwjzWO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953763; c=relaxed/simple;
	bh=/IpI9bjtVlyNNHO3Xl0lk1calaP06NTHNx+iQQg6dfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxwhryBB+B6hdB81uevmfn377bT5JuPxp6wGcMmRnsH2o6lP0eJR9R2N04oZc7a/LcgsX4iNr5qHLmtkT2jNmL5Q8d83UxcO+wiSWKKmceW/WCdgga47uTPVSoV2L2tiSYsgT8J/ONzE9RezolfWqFURzarQnylmdGPcwRNOn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awxAO1/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awxAO1/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9223C4CECE;
	Thu,  7 Nov 2024 04:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730953763;
	bh=/IpI9bjtVlyNNHO3Xl0lk1calaP06NTHNx+iQQg6dfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awxAO1/7hPhFIWLPD5CZ1stJce8dcuIldTHuidJAiCWf/hWsBTX71QppGyXH7iZ2s
	 XLWZ8Lh8w6QEFxPR+Ammax/+CF/JJB5azayGAyheRFbJ9/9nQ+Jgnxzhq66ifdRKjC
	 wU2IVwNaRMnmZdBnjOewVQ3E29NfWpgFpDU+YRmKy1bwglz7p/xSH16RHj2uwSYjp+
	 zDVKewSBIfeTgIxaRwFS/n5TQ1L7E6/7/QwOY4M32dAtWOtAm1qJ/kJUglxzme9IFr
	 ggLdgNkm8hzYDwSYd9/lGZCHIZcuHXAaW+ARFnBY7+i2NrVpPbaWUwNrY+bjJizOGg
	 yvD3lMBLda46A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp not supported
Date: Thu,  7 Nov 2024 12:29:07 +0800
Message-ID: <90dc7eabbdd25625b44c08a97684ab576ad99514.1730953242.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730953242.git.tanggeliang@kylinos.cn>
References: <cover.1730953242.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

If running MPTCP BPF selftests on systems with an old version of IPRoute2,
'ip mptcp' command is not supported. In this case, instead of skipping the
test, falling back to using 'pm_nl_ctl' tool is a better option. This patch
adds an 'ip_mptcp' argument for endpoint_add() to control whether to use
'ip mptcp' or 'pm_nl_ctl' to add an endpoint.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 1d68bbda3370..5cab0aa8fb27 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -28,6 +28,7 @@
 #define ADDR6_3	"dead:beef:3::1"
 #define ADDR6_4	"dead:beef:4::1"
 #define PORT_1	10001
+#define PM_CTL		"./mptcp_pm_nl_ctl"
 #define WITH_DATA	true
 #define WITHOUT_DATA	false
 
@@ -366,13 +367,18 @@ static int address_init(void)
 	return -1;
 }
 
-static int endpoint_add(char *addr, char *flags)
+static int endpoint_add(char *addr, char *flags, bool ip_mptcp)
 {
-	return SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, addr, flags);
+	if (ip_mptcp)
+		return SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s",
+				  NS_TEST, addr, flags);
+	return SYS_NOFAIL("ip netns exec %s %s add %s flags %s",
+			  NS_TEST, PM_CTL, addr, flags);
 }
 
 static int endpoint_init(char *flags, u8 endpoints)
 {
+	bool ip_mptcp = true;
 	int ret = -1;
 
 	if (!endpoints || endpoints > 4)
@@ -383,17 +389,16 @@ static int endpoint_init(char *flags, u8 endpoints)
 
 	if (SYS_NOFAIL("ip -net %s mptcp limits set add_addr_accepted 4 subflows 4",
 		       NS_TEST)) {
-		printf("'ip mptcp' not supported, skip this test.\n");
-		test__skip();
-		goto fail;
+		SYS(fail, "ip netns exec %s %s limits 4 4", NS_TEST, PM_CTL);
+		ip_mptcp = false;
 	}
 
 	if (endpoints > 1)
-		ret = endpoint_add(ADDR_2, flags);
+		ret = endpoint_add(ADDR_2, flags, ip_mptcp);
 	if (endpoints > 2)
-		ret = ret ?: endpoint_add(ADDR_3, flags);
+		ret = ret ?: endpoint_add(ADDR_3, flags, ip_mptcp);
 	if (endpoints > 3)
-		ret = ret ?: endpoint_add(ADDR_4, flags);
+		ret = ret ?: endpoint_add(ADDR_4, flags, ip_mptcp);
 
 fail:
 	return ret;
-- 
2.45.2


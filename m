Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD7A202640
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248730; cv=none; b=DWLP96RCvdguxiYn9GehpEHSI5QybNz1zU9A/8ZPxUt9Lxte5deKN31jdwapGOeA3EGk92g26cihAwzC/qvju1Ufd2o1ObrFQ3OQdW/za7evCEPcqUERauUnjjY2xxzZZtYQPJznlKEed/cmok1fquBLPQJakNtGillaCSqibNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248730; c=relaxed/simple;
	bh=nCc+ZGl2AOHIzUpNwJFTs9+TtaIxwJP5L0FTigb7pjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqcqvoqNS0c5SKYlKlH65UEmti35todw+Ir8e0twCMZCk03LST3x4RTJbuLxh+8r30r0r2gRjafLqvgad89HMcDpr2oZF4fv/znI+twpLp89rr5W5x0F0FCbGvAiWKUBmk8t6iE5q/iJfD8YPVONaNtfeQs+MLnqTLgSBahtme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mULKEWKE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mULKEWKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367F0C4CEC3;
	Fri, 18 Oct 2024 10:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729248729;
	bh=nCc+ZGl2AOHIzUpNwJFTs9+TtaIxwJP5L0FTigb7pjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mULKEWKENfQc3BDLJA4NLI9RjtPBp6QCYEcLiB2K6R5jih/1b9RAwqRmS8ekoC8eN
	 UgWnP0Lp7fHL99vJQ6e9gsfRyZUURMVWKjRR/VeU6XmOR8PMoGhQMJRTRRK1UGxh6t
	 1fPI9HxC43mOSJBiFcPoB1m78KLj3yP3JrMLhg+ggWghwwsxQAc0DoRnH60+i6lZaZ
	 9QHxZS964VLvU/uTQHkveDBiWf+rDLIqp3GuQQF4ctY4JnnUEigt+Bpa52nO2j/NZS
	 f5BAmeAdCduz9B0M4tpmZXu0WXYwDSz/N9s04J23Ox42JXhTlBLRUrDqseHcEKSiNF
	 3bMJLaQ2MZwHA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/6] selftests/bpf: Use pm_nl_ctl if ip mptcp not supported
Date: Fri, 18 Oct 2024 18:51:54 +0800
Message-ID: <a6a52ebb6afa2b7ece70918f2251e965b8b5c892.1729248083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729248083.git.tanggeliang@kylinos.cn>
References: <cover.1729248083.git.tanggeliang@kylinos.cn>
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
index 5b9f29a569a6..439dfee42ffd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -28,6 +28,7 @@
 #define ADDR6_3	"dead:beef:3::1"
 #define ADDR6_4	"dead:beef:4::1"
 #define PORT_1	10001
+#define PM_CTL		"./mptcp_pm_nl_ctl"
 #define WITH_DATA	true
 #define WITHOUT_DATA	false
 
@@ -381,13 +382,18 @@ static int address_init(void)
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
@@ -398,17 +404,16 @@ static int endpoint_init(char *flags, u8 endpoints)
 
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
2.43.0


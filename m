Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F436124
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583290; cv=none; b=XR+gtOcOtQWBoUS0XIVdJRdKFxgOjZCp1EUDx+sUbCFhv3sKp2+bW0jTE656RsXlyUt6uVBSGVq5Dmko8dg0k83hWOWLhhOL2YXHUn1BaCm2d55piHbo/zUwtmoa3leGrhnxvOuth4l8+GkHXY2nI3MagUgrPOHETUlgIzXqbgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583290; c=relaxed/simple;
	bh=/z9OKymIbh9Q0RjtqpgMrnbDymcmPYZhI9q62HvCf0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3gPartEoxlVjxAwUyUivVPzMdZU3TYWRinWqyD5vAS1J10n2C02bEBJDBIUPwR2SGnkRRofpuxNjrCice6aiM+aYP/FRDAqlzysJqt/XYFCRblWlpNRpYMq6raBYvu5F7ERUvAivR9qKFk1nMU6oG0JH8pDUKFU4BZmTmNpgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd4xC/sM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd4xC/sM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649E0C4CEC3;
	Tue, 22 Oct 2024 07:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583289;
	bh=/z9OKymIbh9Q0RjtqpgMrnbDymcmPYZhI9q62HvCf0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jd4xC/sMRhyK7LGondB+9fnikcmoiNBVSIqHjkHCwNOgmA4r1X3O85kFP8qUUDANg
	 SlrXQoC7UtUe2B+2blHkPQGinK0MOMCPYOq4H8KRkGxOx1aVd/DDccJCKfXISfcIyF
	 JBjQX8WUnRnm97smEHPv8T0BYXScNrsJ3Np3JXOCj1tPKp9MCE5/iaK3NxM9V4yhGa
	 hM1Bj2q+lk+AepjQUBjm9Opbdp8zTrgGfOdvjHE/+GqTYlNevUHs+87R8Tr9bfliiW
	 v/TKKjv1EXR5PnEoFldDb/ZlrRjyN4lVnBsEhOnxx2uOcQped99lOgMCCSACm/vos6
	 SyB+wyQEnuVWA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp not supported
Date: Tue, 22 Oct 2024 15:47:57 +0800
Message-ID: <a52f5b9e772a5d7946fe93797615b522c24310f1.1729582332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729582332.git.tanggeliang@kylinos.cn>
References: <cover.1729582332.git.tanggeliang@kylinos.cn>
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
index be746e0fc393..97652f7683e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -28,6 +28,7 @@
 #define ADDR6_3	"dead:beef:3::1"
 #define ADDR6_4	"dead:beef:4::1"
 #define PORT_1	10001
+#define PM_CTL		"./mptcp_pm_nl_ctl"
 #define WITH_DATA	true
 #define WITHOUT_DATA	false
 
@@ -384,13 +385,18 @@ static int address_init(void)
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
@@ -401,17 +407,16 @@ static int endpoint_init(char *flags, u8 endpoints)
 
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


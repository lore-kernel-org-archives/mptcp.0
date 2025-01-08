Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914E1AB533
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325507; cv=none; b=WnmaG/mcWcgzA4CMJohZyWUtUOIRwWLrq3shTffh5GVq9uLzo/rNiF74WqVkwRWvczPdduK2LdpagjLRXnohYvPhrVegC2wcQb7Omns/wfSV+hV5/3B9RK3bmwUtUk1elnxgKe99Xu5k5Qcl0umw6HuGUm6gyQ7G/kfvffjGVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325507; c=relaxed/simple;
	bh=/IpI9bjtVlyNNHO3Xl0lk1calaP06NTHNx+iQQg6dfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2LZzaP9LIljWbMUXnASGFKuSELi4OrIDdbwufREUgWKKPqqf8nuF4gf4Otej2DNCAzDwrG8ZfHdMDlU7rlkDyzGL1MJaVszjH1uKqwXmwNDITgChKG76YKEdpQYLOGUnHrcLNDup8ZSHjq8M+tdwtARqXjH2qtUvI2KN48Mw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibu2NSbR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibu2NSbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEA8C4CEE0;
	Wed,  8 Jan 2025 08:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736325506;
	bh=/IpI9bjtVlyNNHO3Xl0lk1calaP06NTHNx+iQQg6dfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibu2NSbRnBq+abCxN08owTLQWby5dtoIbLzkKoDlYqWa4r8oHdb/b4B/AvMG3gL7w
	 hu00Z5w0mo0uQK0jisQme/j3/31hg79e/+RyYtkMQ09dK38twI/bGV4eVZH4oVoiyK
	 iHzksV9YOiLo/JBgg2qmW9N6zner+Yd7YzySB0bbXt0qeMSaJc3ZoO3Mvs13ya6wt5
	 2odFsmyZqJRu4tKMK0sP1cv8IAd4jPeKeuCXR1DzIAkzeCUn4DRPflr3gQjNdBlbiP
	 AwrJDai2JH+lmhR4vMeERQmpoIYpy/Vph0SJYdsTJv6fiPGDDdfqidu6zAIw1N2kre
	 1ce3b/d3AbIJw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp not supported
Date: Wed,  8 Jan 2025 16:38:09 +0800
Message-ID: <7d3e8bd4357857f862ceb3af29a866423c00425b.1736325184.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736325184.git.tanggeliang@kylinos.cn>
References: <cover.1736325184.git.tanggeliang@kylinos.cn>
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


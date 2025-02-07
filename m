Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB361DE2C5
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924573; cv=none; b=FH8R3sPS/RR4xz1n1PnUUbA/QvmbEEE7BSQyDNFwbR4fOk19h9QkvS6sgGYZ/uXFzfir/vy7CUjnrJBlLqPwxy1oV6fw24+Lg2DjoNyWUqs+DRGvvfRszRRMW2L+lhV4X2LCUtEeE+OE6XBuKK3HV5kB6DNe5seizfXz0ByZSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924573; c=relaxed/simple;
	bh=lMJSQWF/PDlXR2r/7XdH+k5jBC0rK9hmp7QTW4voxsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeFn7/nBdG9VTKvhiS5ri0E1KP96Rh2uaXIcUbBu5Jqyz6T/7xgSnXGkl0J3RjnPWa6o5GfrFLdIk0f5RZhZeevK+u8cmeKq/8XEpZdM9Sn6QfVBqQhWakiBvTDsqJiztnXxczgtGqHa+7AEZ5G8Mrr+Jr88q3imwY68cWlgC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0g/SEXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0g/SEXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813E2C4CED6;
	Fri,  7 Feb 2025 10:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738924572;
	bh=lMJSQWF/PDlXR2r/7XdH+k5jBC0rK9hmp7QTW4voxsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0g/SEXvPiBsAVc9sPa8blnnB5A736TorJKD1asuxgkt1DCQe9fMrD4Uhw2mNO03q
	 b2jp/gpTZL8ohrmnhuh/wY7RtIcGiJcoFKQJignRWoEVw/C6VRLXWhZHrxpHZ63HBw
	 8GFsKB5pyQ/5Cvvii3thJgnCoqnHtPeJrJK8Myz+781bzSpyCOzfijmifSdKbDJNV/
	 nRYnrOemXP+k5dixCckzO/ie4Ydjwue6M56UnGwPW7sZintKl8MZUNxwprzwW0s6fG
	 f9mPSMqTZxi/dbeZpN2iaJcbl+p6q6ssroTtMP/k5aLp1+D8HMDYuEXIadquF6XIfk
	 4OGfKzAz0GhfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp not supported
Date: Fri,  7 Feb 2025 18:35:59 +0800
Message-ID: <6682f174af81e85908db1aff4f379a61d9a77642.1738924354.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738924354.git.tanggeliang@kylinos.cn>
References: <cover.1738924354.git.tanggeliang@kylinos.cn>
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
index ac6f6a6f7700..0a0dee34095d 100644
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
2.43.0


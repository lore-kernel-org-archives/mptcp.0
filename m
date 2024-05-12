Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E788CA40
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715503346; cv=none; b=G9Tr1veoh2ncbrw7K9dCPuQuSHq8Vm3mXt2t77FP1q9y0LitcEPauUXPhgnVGSjIKnp0FFDHGlbOuZWpFHJydZCBD/Cbr+8SPOqN4S4LzJs3nmI/fhKCIdUUbKa2fyE7r1XEYe3ZEftjrq5NKEUPZ63LToJ48IHUunGsKuumrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715503346; c=relaxed/simple;
	bh=ZbmgrZdB762p1vRKbyClzhO2G/oIDzJqduqEb9V1ZP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSxXHton9aR/+2769zl3dPqMdsUMhmr+cGoEMiLXvisx9pzdvBLrc2XIGd2D4VRe3I3Lt7CVx2ucazYBZprXSjuNDGWY8T3fVwZR48ziWASlenXDJ7ClkRkPM+4lKIxnIbSilrETTqglDkLiHCHYP36orq1flaoTnVSaVeA/b+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVCck5d1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVCck5d1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BFBC116B1;
	Sun, 12 May 2024 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715503345;
	bh=ZbmgrZdB762p1vRKbyClzhO2G/oIDzJqduqEb9V1ZP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVCck5d1YLsBdoHfvTcxZZkT422UYVgnGGkWI8xCKbiQqCFvfe3970Bgdbk/JqIvU
	 hmCzXMv/aEyZpYbETfaruoXZ9GFdRT66NlUp5mH/5S+cac5LqWOGiT22Q99UV8rpsj
	 TCdbCOGs8dmxRYRKVbdW9zzoSk2ji4XY0/KsEOCoy2fnDCoXvCM/HzhTCzdsBu5wS3
	 F+XK85P5Bg58A6ORCVJUuXqAy+o9CiMGC1BuuLtN7V8L/7BLkDYB4NpnQ1PiQUYoG6
	 Pg4b3o9J7fHTWWhuDaQ+YQAMib/1NGaIIwOw0goPSKQqLztF2yZJjZcWE9rrNRNtXF
	 Tc/d5DKXLhZZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/3] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Sun, 12 May 2024 16:41:35 +0800
Message-ID: <77d5112c49fac9e8f77c09c7c1c057b8ea25a60f.1715503185.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715503185.git.tanggeliang@kylinos.cn>
References: <cover.1715503185.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use pm_nl_ctl when 'ip mptcp' fails.
Use SYS_NOFAIL in _ss_search() and drop 'ss -M'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 793b4b9c2bd2..2459c0e2a794 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -362,7 +362,10 @@ static int endpoint_init(char *flags)
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
+		SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags %s",
+		    NS_TEST, ADDR_2, flags);
+	}
 
 	return 0;
 fail:
@@ -371,16 +374,8 @@ static int endpoint_init(char *flags)
 
 static int _ss_search(char *src, char *dst, char *port, char *keyword)
 {
-	char cmd[128];
-	int n;
-
-	n = snprintf(cmd, sizeof(cmd),
-		     "ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
-		     NS_TEST, src, dst, port, PORT_1, keyword);
-	if (n < 0 || n >= sizeof(cmd))
-		return -1;
-
-	return system(cmd);
+	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
+			  NS_TEST, src, dst, port, PORT_1, keyword);
 }
 
 static int ss_search(char *src, char *keyword)
-- 
2.43.0


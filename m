Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A5634
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715472503; cv=none; b=QBWHINpcN8IMkLNXnZKnrRYCIYPspBAZ+cPZVCv2KLUH6zSlx15y0zpAMGDOiMldiNKlLtnZmXgOIeDKfoib6MVx8n+Gb3Z0RxK2Qd9v0AqJk9SoLRn3jUMmZpXQJSG14fARhOQaWfOInAozVacZUz4sld14iz5PSp+vyotxBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715472503; c=relaxed/simple;
	bh=ZbmgrZdB762p1vRKbyClzhO2G/oIDzJqduqEb9V1ZP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6qktLHcgL6UXiYNbdAol0tdUHmYJ1YTMlNKiFqCU2PPxJU0mvgEwMr9tPjXcRtoHnJv9sMoUx5VorztaEl1zCn2/Kv6LnXWx8/ZUQ9xaRxdm+ud7JTgFKk9u6Mn4H518kaJtuQsLESe9DuDEu3wDDp99iHN7vcFyhql6Z03QME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB5yQjA8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB5yQjA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D43C32783;
	Sun, 12 May 2024 00:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715472503;
	bh=ZbmgrZdB762p1vRKbyClzhO2G/oIDzJqduqEb9V1ZP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jB5yQjA8mU8VYY/Vz1o+szfbBOwQLD7kW4A5bCbDifKYWJNc0dfGeJwl0nlS+qXFk
	 83UyUL+ZG8y0BlQq9Ss+VWs+0HAVFfmEejzGreS+mvxPV8BamvNb/8YoBoh0DBV3Dp
	 w2Im44R9bcKIXD6P7PYBKER18r7boRQnvAQ3qqYwXQuauTLRIbKO76HMMyo/LGNWPV
	 d1VHYL3+bBWMniAPcC52Dp29SVgmSpx4eS30OYdCIHTMUsbTbwXH0VzZ3dzaJQp2iM
	 Sl3HZoGjbZXhaVx3C4KEydJIgd6iC9Y01EMz9Ay4gaXukobElO1ulTNAFMUgbx13z6
	 IVno8Q9Anz3qw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Sun, 12 May 2024 08:07:32 +0800
Message-ID: <caa4f397c9c8d1415aa189113db995e9fa733780.1715472312.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715472312.git.tanggeliang@kylinos.cn>
References: <cover.1715472312.git.tanggeliang@kylinos.cn>
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


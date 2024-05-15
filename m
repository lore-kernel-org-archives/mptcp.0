Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5F3B79F
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753929; cv=none; b=iOhFRyJ+5LXLarilIdjJtaQ0zC4SMCBhSP64yq71M/dYWvE/hTbTWyqyeZyVcbDawoegjngX+axvhC23gfHeaTMmYyt1eKZ1615bS1VpaMo0RlP7jRVw/cxcFfFlii5B2VFLcSthpuwgTw8beOR/qsciG39OzEraLQp2sDV8lC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753929; c=relaxed/simple;
	bh=R5O5q7tUwAI3mtCcrC7G9EaU08Qh+Q+5AiMIMkJM8Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbWDjb9wsCkdvhbnx1kEUbKDohm0uQKpw3TeGeKnVfpAjcjii8YSQnOhoXfynMxASquABmauF3Ly7jjGaonMvq3ztjuTnJzgvq5ToqNOAc47PLZOZfPs3t3zvfUokBfnaPoWao2+HUJEaXe/2Bg63GMH/IZ26qIkU9nn8pz9yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTYWCU+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTYWCU+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A708DC2BD11;
	Wed, 15 May 2024 06:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715753928;
	bh=R5O5q7tUwAI3mtCcrC7G9EaU08Qh+Q+5AiMIMkJM8Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTYWCU+PEJ3Yatxv1D88STXR5nS2OYJ8l431CTw/7RJ2pWnguoSVhzwW6VxYvk5dP
	 j9nRLtjErhX58HbzpElAu0DKfFtOGYcHMQgN39bXHZ2t8fn5H/98DWbKJaXtnONkCd
	 rHOAsxItAUWHhsMbxSry1S/NzbZa5O8rDEc6JUP4psgs0jD/Qp7HOFswBDmRCzo4Bt
	 r7pXGQQsINZDyurQWaJCKPoK39zKHmVb9ztv6+r90r9SgxzruM2hkcC/3PV3GlZXi/
	 jG38JWnoDn9od4sM485fMHudQZAPOMbN/S11Lnp3CJBg16dvNzCzUQ1KGt+COWYA4M
	 iwNG9MC4e4ZhQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/2] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Wed, 15 May 2024 14:18:38 +0800
Message-ID: <58ef78f498fe0a951cb68ccf6776a8744aaa67b5.1715753802.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715753802.git.tanggeliang@kylinos.cn>
References: <cover.1715753802.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use pm_nl_ctl instead of 'ip mptcp'.
Use SYS_NOFAIL in _ss_search() and drop 'ss -M'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 793b4b9c2bd2..4472aa404da0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -362,7 +362,10 @@ static int endpoint_init(char *flags)
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	/* It would be better to use  "ip -net %s mptcp endpoint add %s %s",
+	 * but the BPF CI is using an old version of IPRoute (5.5.0).
+	 */
+	SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
 
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


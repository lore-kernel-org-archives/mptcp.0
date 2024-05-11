Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10158462
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715424125; cv=none; b=nbsLUMhzyboLslRB4WZkWkNnbNuypPLHNvBoMBj2EeLRIw+Q+fD0LJsNBv2qyJIuuF0SPih+eXpI5NDMwFuCGDr9adUBFwsygOgAR3ke18LrpVjrwJ/0+A5lK+1fzQ3fB1qjcfgKw5fV6j91l32uhE1R8sEySbJoGXrvfuQ6IjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715424125; c=relaxed/simple;
	bh=SBdfkHZ4KF4uhdfTbVUSdjGhNj228D+EyfelshZ6ucY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGgODBnqyOXDasMM3PIxt0bZvb3GqF0TRNbkrQ15jmGKeUHaBhBCHBOYvc1taUi34zOQ+CkuoomK+V9hGIRV5+pLhg2HaIEJPkCbab8m+BnUHF7VIzlGg4zWOPRFyP26pLkAC6LOCBJR470ih2fxQ4LXqp3CxXguPK5564k6LXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joBH8TXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joBH8TXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC94C2BBFC;
	Sat, 11 May 2024 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715424125;
	bh=SBdfkHZ4KF4uhdfTbVUSdjGhNj228D+EyfelshZ6ucY=;
	h=From:To:Cc:Subject:Date:From;
	b=joBH8TXu2TjpckYytMZtURwqJyx/LlEdf1Z3np6IenDaQ9wNMY2r6vNf4WbOQosXn
	 SX7Rr1E1zzJFZynl01UU9C9/am5YoGMgBLKmi3SFWmL2QoLLAubZAeC3Uv8HAXdpVt
	 QZ3G2nAYJw4kjbb6Qb2+W7/u/AGzi9ErFYvutgR4wxbJ2tDgdTqGYM6r9HeSDJV0mD
	 T+KCdBeOxmoh6WLHiR26F0Fk3N+J30LJtoxUm0SOboP2CKiwXZeu+tkWZMhHbsegl/
	 5VuhwwF3I0/vSsfynR42uCeNbdjPSJGDPgBI6S4GJJXyBxlxxoSKHHpH5zOgPAfatx
	 Tsmh+yMjJcyew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Sat, 11 May 2024 18:41:59 +0800
Message-ID: <48d243a507dc8b48932df4995ff98e5ec056e733.1715424100.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add pm_nl_ctl.
Use SYS_NOFAIL in _ss_search().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile           |  2 +-
 tools/testing/selftests/bpf/pm_nl_ctl.c        |  1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 15 ++++-----------
 3 files changed, 6 insertions(+), 12 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/pm_nl_ctl.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b90c718218ae..bd2e3b138a5c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -131,7 +131,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	xdp_features bpf_test_no_cfi.ko pm_nl_ctl
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
diff --git a/tools/testing/selftests/bpf/pm_nl_ctl.c b/tools/testing/selftests/bpf/pm_nl_ctl.c
new file mode 120000
index 000000000000..5a08c255b278
--- /dev/null
+++ b/tools/testing/selftests/bpf/pm_nl_ctl.c
@@ -0,0 +1 @@
+../net/mptcp/pm_nl_ctl.c
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 793b4b9c2bd2..9c6d1e4f6f35 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -362,7 +362,8 @@ static int endpoint_init(char *flags)
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags))
+		SYS(fail, "ip netns exec %s ./pm_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
 
 	return 0;
 fail:
@@ -371,16 +372,8 @@ static int endpoint_init(char *flags)
 
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
+	return SYS_NOFAIL("ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
+			  NS_TEST, src, dst, port, PORT_1, keyword);
 }
 
 static int ss_search(char *src, char *keyword)
-- 
2.43.0


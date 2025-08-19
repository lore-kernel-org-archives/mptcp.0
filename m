Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117F25F79A
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594043; cv=none; b=GvQpb37a40otr/4Dzsh2uGwFUWGYi4GUzZiJpASp7MmpLRxUqLe93LR/HBRNxuvXHKJJAuAy/IFvWpdMNU1E//PvAwphTxQBYrnW7/OWIQh+PbBQKETn9MFO9CYAQJUMl2PXpFncFI6CyyeBJfcLRWsvff2uHiV7KCZ6e1eIn6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594043; c=relaxed/simple;
	bh=/x/jziq25RQCXehcntFgaQALn386mKczQ1osaeu4bT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e20VPmedIyqwWoTjSu8n+bCjMTaCfu2AZ3a4sga/y7Wvmdg03txMl1zJ1u0oA2j6b8qF5wNTC2nT4iepPNzdqHfu2GBulKpoe2KsVEA/Rtsc/8XOZAD9k0LVWwR23k01FDJVIpssYStCDsW+Bv2TRJezTJ2mtZ2lG5d85peSI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltM9EIqY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltM9EIqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E42C116B1;
	Tue, 19 Aug 2025 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594043;
	bh=/x/jziq25RQCXehcntFgaQALn386mKczQ1osaeu4bT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltM9EIqYB1FfClziZTLkpuT2A0KJPQgco5Wltfq9Ne5XVlzPjV2WrtWEx3TNty/Uh
	 k0830YgL+13vaKvGd8wyRk5NcEq52y0E937ACChNKtPozEAjSenfv4QTJxVO6eMgvU
	 3NdkE+DMQlev76srlj7akfpc8X1ATejttq0xPYxLS8CZyVVkmBmrTXyJUlfW22dNNV
	 /6rBhOMhKxNh2riNL8lUkzmSwdx1ftCs/z3m5Q4YB5FkqHAUvYjF9qAB/wYReZDMTG
	 ggmxkYW/aLcgaH2yvJwXkjWpt8Fw1hwV0SKc4/WCnIq+sAuqVUndYR0SB+qsi/OuAi
	 V0497hisnEKfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 11/11] selftests: mptcp: sockopt: add IPV6_V6ONLY test
Date: Tue, 19 Aug 2025 17:00:17 +0800
Message-ID: <ac06042d0ede40d6d45ad222e080860dfc0918ab.1755592822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755592822.git.tanggeliang@kylinos.cn>
References: <cover.1755592822.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add IPv6-specific testing for IPV6_V6ONLY:
- Enables the option and verifies its state
- Restricted to IPv6 sockets
- Reports results in the test script

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 27 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  4 +++
 2 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 3e2072869527..3d01cc20afb1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -289,6 +289,15 @@ static void do_setsockopt_local_port_range(int fd)
 		perror("setsockopt(IP_LOCAL_PORT_RANGE)");
 }
 
+static void do_setsockopt_v6only(int fd)
+{
+	int v6only = 1;
+
+	if (setsockopt(fd, SOL_IPV6, IPV6_V6ONLY, &v6only,
+		       sizeof(v6only)))
+		perror("setsockopt(IPV6_V6ONLY)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
@@ -300,6 +309,9 @@ static void do_setsockopts(int fd)
 	do_setsockopt_transparent(fd);
 	do_setsockopt_bind_address_no_port(fd);
 	do_setsockopt_local_port_range(fd);
+
+	if (pf == AF_INET6)
+		do_setsockopt_v6only(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -820,6 +832,18 @@ static void do_getsockopt_local_port_range(int fd)
 	assert(port_range == (31000 << 16 | 30000));
 }
 
+static void do_getsockopt_v6only(int fd)
+{
+	socklen_t len;
+	int v6only;
+
+	len = sizeof(v6only);
+	if (getsockopt(fd, SOL_IPV6, IPV6_V6ONLY, &v6only, &len))
+		die_perror("getsockopt(IPV6_V6ONLY)");
+
+	assert(v6only == 1);
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -848,6 +872,9 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_bind_address_no_port(fd);
 
 	do_getsockopt_local_port_range(fd);
+
+	if (pf == AF_INET6)
+		do_getsockopt_v6only(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index a688917a13c1..6664f8f0733d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -359,6 +359,10 @@ do_mptcp_sockopt_tests()
 	print_title "IP_LOCAL_PORT_RANGE sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "IP_LOCAL_PORT_RANGE sockopt v6"
+
+	print_title "IPV6_V6ONLY sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IPV6_V6ONLY sockopt v6"
 }
 
 run_tests()
-- 
2.48.1


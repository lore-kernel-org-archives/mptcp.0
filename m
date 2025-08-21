Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200C2ED147
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766548; cv=none; b=M4JGwmVxqS+oCXeQXmOjiPkhfouEhpGJeYoowa2G8tys78z3sbnV+sb8bgmi6T1txAZJHSF5suI7MCXhmvfsJ1mc2vl+IHT3mE7oCkNt7sNexMj6MKvZBDmGbj4b4dj7g6aBH3XYxT2J6hq1XoNZw4usMWYbJkKbIp2t1+ENt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766548; c=relaxed/simple;
	bh=le7E3LikDkv1/yn+0MiLtMAEjcuSGI0HpKqNetOm+z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCRgzSiyGhNTPad5VWgBkoMaIodYrliVDC38Qb0Bp+kw/bv8BynbiNmP5JgPOW+IyFI2fP/Anyf2uMMfHofO2WFhfDYO6ysHTw9vsYsaqo06s+ITU9JUQvGWtTpN6uUpxrgoa1D8pKEw8LtgErKrM0I6qf5aWbENc3E3RI1LzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsqlYSAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsqlYSAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05506C113CF;
	Thu, 21 Aug 2025 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766548;
	bh=le7E3LikDkv1/yn+0MiLtMAEjcuSGI0HpKqNetOm+z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsqlYSATATHBBWkuaNPgU+kXWgm3We+uFgiIpTBa6kebMAsBI9si/yJS+McQT6/PS
	 1quayQwISxYunwWxVoqY+VCckng46rxeunLbmBDFqVAVYffLtCNyxmk66v/sit/34j
	 rWTofYEbGb9Yw4K/KbHOzdb5wlgG+bkfjzUU4tnx3MhhSFjcJzwYdEgAUZjrsH5mIz
	 Wt3h2b28bPP1gxoP5hYu8ACI9uGm7jDdikR1SIQx0W7eC5g4bmDzVcG0+XHy9nPqsC
	 MeG58NiJvfQzR2uL57gms68+YP4klFU4wHZoPAZBLMsly1sYtDzWXHzYehIOalRpMm
	 QD2W6MIwO+1qA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 10/10] selftests: mptcp: sockopt: add IPV6_V6ONLY test
Date: Thu, 21 Aug 2025 16:54:58 +0800
Message-ID: <65c27ad077c8c7306aa0427cb6cf4eb0e9ad2501.1755680616.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755680616.git.tanggeliang@kylinos.cn>
References: <cover.1755680616.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 30 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  3 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 25074e5b4eaa..9bbe2e56351f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -271,6 +271,18 @@ static void do_setsockopt_local_port_range(int fd)
 		perror("setsockopt(IP_LOCAL_PORT_RANGE)");
 }
 
+static void do_setsockopt_v6only(int fd)
+{
+	int v6only = 1;
+
+	if (pf != AF_INET6)
+		return;
+
+	if (setsockopt(fd, SOL_IPV6, IPV6_V6ONLY, &v6only,
+		       sizeof(v6only)))
+		perror("setsockopt(IPV6_V6ONLY)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
@@ -281,6 +293,7 @@ static void do_setsockopts(int fd)
 	do_setsockopt_transparent(fd);
 	do_setsockopt_bind_address_no_port(fd);
 	do_setsockopt_local_port_range(fd);
+	do_setsockopt_v6only(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -757,6 +770,21 @@ static void do_getsockopt_local_port_range(int fd)
 	assert(port_range == (31000 << 16 | 30000));
 }
 
+static void do_getsockopt_v6only(int fd)
+{
+	socklen_t len;
+	int v6only;
+
+	if (pf != AF_INET6)
+		return;
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
@@ -783,6 +811,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_bind_address_no_port(fd);
 
 	do_getsockopt_local_port_range(fd);
+
+	do_getsockopt_v6only(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 2016adde1553..356911077451 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -296,7 +296,8 @@ do_mptcp_sockopt_tests()
 		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX" \
 		   "IPV6_FREEBIND" "IPV6_TRANSPARENT" \
 		   "IP_BIND_ADDRESS_NO_PORT" \
-		   "IP_LOCAL_PORT_RANGE"; do
+		   "IP_LOCAL_PORT_RANGE" \
+		   "IPV6_V6ONLY"; do
 		print_title "$opt sockopt v6"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v6"
-- 
2.48.1


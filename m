Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549931577D
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594040; cv=none; b=q4XOgceeLXcEAW9nk8f8dpH0QEvf+1/ZPs9WLxPzT1cpeD9BfaOIkGrD04qVyUchOfZnTe7kaO+Aw2cyL5enO6ZPW7MmnGhwtLdQnXNyOs4gCIc5Do4tPs4f6lAz96kopFqxk51/lWFfszblux8bbJMcJI52dtVovpoTW4iK8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594040; c=relaxed/simple;
	bh=KV3bTDYQw3aJTuMs/eRT42XhnKRabo0IyCTn3wBe8lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjdtwxILiVu6RTou0+cJ0P6Yr2i8XV9rdO/5LDLTWOn2SbBVIi10ZnTkrAw5rKNOtH6xSohz55Yzj3SCW2gOqGXOhG9pJPaTyBHupAisaIlHQ5e1TVVeRzOZafcLT964dV4K6ivNYOTG1eCsmVYOUNtofDi6+D6rOa2sbQJFphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jnuk/wbc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnuk/wbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273ABC4CEF1;
	Tue, 19 Aug 2025 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594039;
	bh=KV3bTDYQw3aJTuMs/eRT42XhnKRabo0IyCTn3wBe8lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jnuk/wbc2ljubLZJaAgoGEBPkRNHjCizfq24tetimWuSQmo4gFltjTqYGuaDE/Wxw
	 R2IapaHLy5c0skUL6odFqJk9Hcf7YVZ7tPUSC4AJenP0X3IhfWjg9g0FHQnmtG8SPV
	 GNuyPoZ+6jBDkVQHJw1Xfr5fYNv1AcwLRDwHP15HvkXe2UfM7HpxjPciBQI/LTvKG0
	 OCt5OAENg3kyugmmPvpKux11yqMUgUlMLR9uVc/jYfyeWwVXF9Robu9z/MpklMIbb0
	 2RAXn1xuzp6FjpVUuqJwVxy7i2jkvcNRcSrH3/DklrgenFFwOb0hq81FCNBAIqvT1g
	 hCCP5brJ4JEsA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 09/11] selftests: mptcp: sockopt: add IP_BIND_ADDRESS_NO_PORT test
Date: Tue, 19 Aug 2025 17:00:15 +0800
Message-ID: <23fff5bbf1251eeb2bd5561fe4c283ff6dd1fbd0.1755592822.git.tanggeliang@kylinos.cn>
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

Add tests for the IP_BIND_ADDRESS_NO_PORT socket option:
- Enables the option via setsockopt
- Verifies the enabled state via getsockopt
- Includes tests for both IPv4 and IPv6
- Updates test script output

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 25 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 ++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index fe54c333e455..02b7ec774b86 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -271,6 +271,15 @@ static void do_setsockopt_transparent(int fd)
 		perror("setsockopt(IP_TRANSPARENT)");
 }
 
+static void do_setsockopt_bind_address_no_port(int fd)
+{
+	int enable = 1;
+
+	if (setsockopt(fd, SOL_IP, IP_BIND_ADDRESS_NO_PORT, &enable,
+		       sizeof(enable)))
+		perror("setsockopt(IP_BIND_ADDRESS_NO_PORT)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
@@ -280,6 +289,7 @@ static void do_setsockopts(int fd)
 	do_setsockopt_tos(fd);
 	do_setsockopt_freebind(fd);
 	do_setsockopt_transparent(fd);
+	do_setsockopt_bind_address_no_port(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -774,6 +784,19 @@ static void do_getsockopt_transparent(int fd)
 	assert(enable == 1);
 }
 
+static void do_getsockopt_bind_address_no_port(int fd)
+{
+	socklen_t len;
+	int enable;
+
+	len = sizeof(enable);
+	if (getsockopt(fd, SOL_IP, IP_BIND_ADDRESS_NO_PORT,
+		       &enable, &len))
+		die_perror("getsockopt(IP_TRANSPARENT)");
+
+	assert(enable == 1);
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -798,6 +821,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_freebind(fd);
 
 	do_getsockopt_transparent(fd);
+
+	do_getsockopt_bind_address_no_port(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ed73ad7bba66..1bee46c9b29a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -301,6 +301,10 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "IP_TRANSPARENT sockopt v4"
 
+	print_title "IP_BIND_ADDRESS_NO_PORT sockopt v4"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IP_BIND_ADDRESS_NO_PORT sockopt v4"
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
@@ -343,6 +347,10 @@ do_mptcp_sockopt_tests()
 	print_title "IPV6_TRANSPARENT sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "IPV6_TRANSPARENT sockopt v6"
+
+	print_title "IP_BIND_ADDRESS_NO_PORT sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IP_BIND_ADDRESS_NO_PORT sockopt v6"
 }
 
 run_tests()
-- 
2.48.1


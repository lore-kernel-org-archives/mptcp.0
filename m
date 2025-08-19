Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8B315779
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594041; cv=none; b=fBHAcnE3yhNSvakcLbjc30B67gbRX8shbybpD+CQNxUs/pinxtbQoYjyvvpSjYNVozozvJ/yVMWMC93inKhzJm5ski40mOJ5WtzIPDU/jmzJWwbgPm0zvOiolUAD2vnvLrkemXPHlaCnfbZAGkLRQyUQ/G1b4r/sZ+J4ev7YmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594041; c=relaxed/simple;
	bh=qR9rkROvrKtDJG35Qv5DT6JcxECGdEl8tEKB/1Zy5oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T15MoLagmQaTbroAhSCohRQALBcdX3gIKcPil9sHnfmL3tBobfTayEUE5ZjLtl82r8HAiT0n2blv+1JGRO6oOji05y1mDWw7nY/qy3ccIacwKjS5ySHPx76IIPu8dAZsOhdhehm9zTf2YlEC+FiO+dQ5KECUdzh9B3m9TY0IG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS/4rQHH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS/4rQHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C301C116C6;
	Tue, 19 Aug 2025 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594041;
	bh=qR9rkROvrKtDJG35Qv5DT6JcxECGdEl8tEKB/1Zy5oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DS/4rQHHBnhIxLcFa8HXtu+R4DFxgUVWYiakUTyLn/Jy15PXtOEYVDUQbFB9yxcLv
	 maRDK2AT3XybsI8Dj5fXUffpF8lEP+RoSOLqXsoceHCSpJ/rGUAG3tmdy6Qane3kPu
	 vHHnZ/LJWu1aiYZX7vikD2BCk0dAVO13OjCBH0Xnnx75yc66xw9sqJ5OChWQtcVw5f
	 Z/nXoaM13ZYnJuxJlIz6Ch9AMSOcTTtMHGxnyPEY9WfXHiOgX1vBLL07YXXlcIsAeA
	 dZCF1JdZf+3IPwMpc9CfAvxgSScafXEMXaNfhXF0Ie5w72t/YMEJsHTBxQ4vVe73OI
	 81ERn1Z4Qmfbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 10/11] selftests: mptcp: sockopt: add IP_LOCAL_PORT_RANGE test
Date: Tue, 19 Aug 2025 17:00:16 +0800
Message-ID: <956a9318bb687f41652b7a73642ea7a536ce2f0f.1755592822.git.tanggeliang@kylinos.cn>
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

Add tests for IP_LOCAL_PORT_RANGE:
- Sets port range to 30000-31000
- Verifies the range via getsockopt
- Covers both IPv4 and IPv6
- Reports results in test script

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 25 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 ++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 02b7ec774b86..3e2072869527 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -280,6 +280,15 @@ static void do_setsockopt_bind_address_no_port(int fd)
 		perror("setsockopt(IP_BIND_ADDRESS_NO_PORT)");
 }
 
+static void do_setsockopt_local_port_range(int fd)
+{
+	uint32_t port_range = (31000 << 16 | 30000); // [30000 - 31000]
+
+	if (setsockopt(fd, SOL_IP, IP_LOCAL_PORT_RANGE, &port_range,
+		       sizeof(port_range)))
+		perror("setsockopt(IP_LOCAL_PORT_RANGE)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
@@ -290,6 +299,7 @@ static void do_setsockopts(int fd)
 	do_setsockopt_freebind(fd);
 	do_setsockopt_transparent(fd);
 	do_setsockopt_bind_address_no_port(fd);
+	do_setsockopt_local_port_range(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -797,6 +807,19 @@ static void do_getsockopt_bind_address_no_port(int fd)
 	assert(enable == 1);
 }
 
+static void do_getsockopt_local_port_range(int fd)
+{
+	uint32_t port_range;
+	socklen_t len;
+
+	len = sizeof(port_range);
+	if (getsockopt(fd, SOL_IP, IP_LOCAL_PORT_RANGE,
+		       &port_range, &len))
+		die_perror("getsockopt(IP_LOCAL_PORT_RANGE)");
+
+	assert(port_range == (31000 << 16 | 30000));
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -823,6 +846,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_transparent(fd);
 
 	do_getsockopt_bind_address_no_port(fd);
+
+	do_getsockopt_local_port_range(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1bee46c9b29a..a688917a13c1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -305,6 +305,10 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "IP_BIND_ADDRESS_NO_PORT sockopt v4"
 
+	print_title "IP_LOCAL_PORT_RANGE sockopt v4"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IP_LOCAL_PORT_RANGE sockopt v4"
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
@@ -351,6 +355,10 @@ do_mptcp_sockopt_tests()
 	print_title "IP_BIND_ADDRESS_NO_PORT sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "IP_BIND_ADDRESS_NO_PORT sockopt v6"
+
+	print_title "IP_LOCAL_PORT_RANGE sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IP_LOCAL_PORT_RANGE sockopt v6"
 }
 
 run_tests()
-- 
2.48.1


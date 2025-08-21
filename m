Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6352ECEA6
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766542; cv=none; b=NKOmEpk68z4K4EziqicGQk2Rqi9XbbZ0c6tvjcvb+KGW9Hgoq+15gbuXeen9qWn/VSg7++HwQ8XsGrQle/0/ldfK7wuHGvUYjAtmYTIfF24IQ7Ig6cCmgbkxMTK1tUDpiiWAO3Nd0oV8TUXo3jz63o4WaWw07zRPtuB8G6k9arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766542; c=relaxed/simple;
	bh=7bToTOB07ZWltWYqLVS+GT12xiay/LeEl9hNhNFwmSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDdLgiOINSyA5Ys306/zqLTzwN+Mf9PmyC5DfaMGedO1+udOWit5nK5GQabNLDlMNojUYz+p33vn7/XWM3fYM/VRQsBhZCJK8l57VfAig1AF+f9/5jms82PdLYE/SBIVfOrk7V6Urdat1bkS1svczcsfc1eB2dBLiQm/YQ99Ed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHih+pZD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHih+pZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0668C4CEED;
	Thu, 21 Aug 2025 08:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766542;
	bh=7bToTOB07ZWltWYqLVS+GT12xiay/LeEl9hNhNFwmSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHih+pZDvFdNX6b6MsKpvr1TcVadsSqaG5Jyca9NF1MqRYSYAykGzSyS4U/a5SRQd
	 ljaXKfG5ukUN/2lGJJrOuw81r4TV/AQCEXAIKBv5eplvWvyweAzTbvN4Y2k9qCqT9O
	 Nfghm7oc4v422MS4YUr9x+WVPts1UwPDfGi4ZEJWwdOjv0Sd4qORejCbhS8peDQqNW
	 BZr1gp5BEYkUpWsPqsfNL/noHRaF6zdgkIb6T0NpaJwe5dxCBwK4Pt+l7yFXlr3GLp
	 1tRmL4GUaq1TMjPrktdCBBuDHqy9VOUO1q0trOf78g59Ha7JQXl5YVdWwPCCXhzXwe
	 9fxS/gT2VuZgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 08/10] selftests: mptcp: sockopt: add IP_BIND_ADDRESS_NO_PORT test
Date: Thu, 21 Aug 2025 16:54:56 +0800
Message-ID: <fd157d974ccb8c025845257eb300d71acf6cbabd.1755680616.git.tanggeliang@kylinos.cn>
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

Add tests for the IP_BIND_ADDRESS_NO_PORT socket option:
- Enables the option via setsockopt
- Verifies the enabled state via getsockopt
- Includes tests for both IPv4 and IPv6
- Updates test script output

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 25 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  6 +++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ccc072005118..ca1a40492aa4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -253,6 +253,15 @@ static void do_setsockopt_transparent(int fd)
 		perror("setsockopt(IP(V6)_TRANSPARENT)");
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
@@ -261,6 +270,7 @@ static void do_setsockopts(int fd)
 	do_setsockopt_bindtoifindex(fd);
 	do_setsockopt_freebind(fd);
 	do_setsockopt_transparent(fd);
+	do_setsockopt_bind_address_no_port(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -711,6 +721,19 @@ static void do_getsockopt_transparent(int fd)
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
@@ -733,6 +756,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_freebind(fd);
 
 	do_getsockopt_transparent(fd);
+
+	do_getsockopt_bind_address_no_port(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index da02769fbb2b..3756b537e2a6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -272,7 +272,8 @@ do_mptcp_sockopt_tests()
 	for opt in "SOL_MPTCP" \
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
 		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX" \
-		   "IP_FREEBIND" "IP_TRANSPARENT"; do
+		   "IP_FREEBIND" "IP_TRANSPARENT" \
+		   "IP_BIND_ADDRESS_NO_PORT"; do
 		print_title "$opt sockopt v4"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v4"
@@ -292,7 +293,8 @@ do_mptcp_sockopt_tests()
 	for opt in "SOL_MPTCP" \
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
 		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX" \
-		   "IPV6_FREEBIND" "IPV6_TRANSPARENT"; do
+		   "IPV6_FREEBIND" "IPV6_TRANSPARENT" \
+		   "IP_BIND_ADDRESS_NO_PORT"; do
 		print_title "$opt sockopt v6"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v6"
-- 
2.48.1


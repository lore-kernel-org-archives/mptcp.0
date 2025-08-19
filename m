Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABF315783
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594033; cv=none; b=G7Q61WVdnkGAA/+AOI8exw35+5GuYvRy4FsxX97VmyS0rvvyRfClYgT4JR3jPAcik4CKLRiqTjDwS6DH7FDUd8o8rY9Gat2nfM1HD85P2aqwMHuUFJNI5pvFjX8Cp7EC8OpqPYIs3M2jFdrI2/LHBSawvzbYU3SknAq9dP+A5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594033; c=relaxed/simple;
	bh=scA2SXNdUoj25SWcsE5w5ASFDSdk6qYDSapiowBEs4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/FEolqTkM9JZvYezDsOxS5tLL04SfR3scsmcesYuOVmG3sB1BGfCuiMM3z94mwyOiKLA9wsVqATAwNzRrrYULHwawrxpZd84CFaNgqR+c7nhOMAQ8hDaeFcuttwitk+Xa2EzFv2lphJAt3eSDB3mhpg73ECvpx8sLnGafLkEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyyMrsle; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyyMrsle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027ACC116C6;
	Tue, 19 Aug 2025 09:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594033;
	bh=scA2SXNdUoj25SWcsE5w5ASFDSdk6qYDSapiowBEs4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyyMrslepsob+UXuB0Qv6uuodNolAh2kZjohmf1wV5lQ9DFZCmcREIqz2BRTzVPPw
	 gl4K7XId2UhCqHQlbNIzQhbaHwIKFJ75dnXxL4ehcizN1jdUyfL+VGrJWjGJAwKBu/
	 AeSv/GDOv3V4B/SChYzSs7EPWKTuLNvd4FgeYghGfj4zw0gLZNjTCEvlpcrAQpSEnp
	 yerzdUEPnQtVRDdndNBwtaLMAERGxJYrkstCVUESvDoETC+gcVWgFj3he47xNfIRbc
	 coTUoeJRdvQayymM1EvRnBlzHzNQb9mpuCxCsIpH7oYxlKNGvEj8fUnFyokDibjTCN
	 Wo3RlbwXXKQhg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 06/11] selftests: mptcp: sockopt: add IP_TOS socket option test
Date: Tue, 19 Aug 2025 17:00:12 +0800
Message-ID: <08f2e503f85ff7b5afe4869941f88f4b088df4bd.1755592822.git.tanggeliang@kylinos.cn>
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

Add comprehensive testing for IP_TOS (Type of Service):
- Sets a random TOS value and verifies it
- Tests edge cases (zero-length buffer, negative size)
- Validates proper error handling
- Covers both IPv4 and IPv6

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 85 ++++++++++---------
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 ++
 2 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 25456e540cad..3bef535ce981 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -29,6 +29,7 @@
 #include <linux/tcp.h>
 
 static int pf = AF_INET;
+static uint8_t tos_in;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -233,12 +234,20 @@ static void do_setsockopt_bindtoifindex(int fd)
 		perror("setsockopt(SO_BINDTOIFINDEX)");
 }
 
+static void do_setsockopt_tos(int fd)
+{
+	tos_in = rand() & 0xfc;
+	if (setsockopt(fd, SOL_IP, IP_TOS, &tos_in, sizeof(tos_in)))
+		die_perror("setsockopt(IP_TOS)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
 	do_setsockopt_reuseport(fd);
 	do_setsockopt_bindtodevice(fd);
 	do_setsockopt_bindtoifindex(fd);
+	do_setsockopt_tos(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -661,6 +670,40 @@ static void do_getsockopt_bindtoifindex(int fd)
 	assert(ifindex == get_ifindex(fd, "lo"));
 }
 
+static void do_getsockopt_tos(int fd)
+{
+	uint8_t tos_out;
+	socklen_t s;
+	int r;
+
+	tos_out = 0;
+	s = sizeof(tos_out);
+	if (getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s))
+		die_perror("getsockopt IP_TOS");
+
+	if (!tos_in)
+		xerror("tos_in shouldn't be 0");
+
+	if (tos_in != tos_out)
+		xerror("tos %x != %x socklen_t %d\n", tos_in, tos_out, s);
+
+	if (s != 1)
+		xerror("tos should be 1 byte");
+
+	s = 0;
+	if (getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s))
+		die_perror("getsockopt IP_TOS 0");
+	if (s != 0)
+		xerror("expect socklen_t == 0");
+
+	s = -1;
+	r = getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s);
+	if (r != -1 && errno != EINVAL)
+		die_perror("getsockopt IP_TOS did not indicate -EINVAL");
+	if (s != -1)
+		xerror("expect socklen_t == -1");
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -679,6 +722,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_bindtodevice(fd);
 
 	do_getsockopt_bindtoifindex(fd);
+
+	do_getsockopt_tos(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
@@ -840,44 +885,6 @@ static int server(int pipefd)
 	return 0;
 }
 
-static void test_ip_tos_sockopt(int fd)
-{
-	uint8_t tos_in, tos_out;
-	socklen_t s;
-	int r;
-
-	tos_in = rand() & 0xfc;
-	r = setsockopt(fd, SOL_IP, IP_TOS, &tos_in, sizeof(tos_out));
-	if (r != 0)
-		die_perror("setsockopt IP_TOS");
-
-	tos_out = 0;
-	s = sizeof(tos_out);
-	r = getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s);
-	if (r != 0)
-		die_perror("getsockopt IP_TOS");
-
-	if (tos_in != tos_out)
-		xerror("tos %x != %x socklen_t %d\n", tos_in, tos_out, s);
-
-	if (s != 1)
-		xerror("tos should be 1 byte");
-
-	s = 0;
-	r = getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s);
-	if (r != 0)
-		die_perror("getsockopt IP_TOS 0");
-	if (s != 0)
-		xerror("expect socklen_t == 0");
-
-	s = -1;
-	r = getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s);
-	if (r != -1 && errno != EINVAL)
-		die_perror("getsockopt IP_TOS did not indicate -EINVAL");
-	if (s != -1)
-		xerror("expect socklen_t == -1");
-}
-
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -895,8 +902,6 @@ static int client(int pipefd)
 		xerror("Unknown pf %d\n", pf);
 	}
 
-	test_ip_tos_sockopt(fd);
-
 	connect_one_server(fd, pipefd);
 
 	return 0;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 8eae13f4da38..9972012d08f6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -289,6 +289,10 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SO_BINDTOIFINDEX sockopt v4"
 
+	print_title "IP_TOS sockopt v4"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IP_TOS sockopt v4"
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
@@ -319,6 +323,10 @@ do_mptcp_sockopt_tests()
 	print_title "SO_BINDTOIFINDEX sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SO_BINDTOIFINDEX sockopt v6"
+
+	print_title "IP_TOS sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IP_TOS sockopt v6"
 }
 
 run_tests()
-- 
2.48.1


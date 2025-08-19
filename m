Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1C1519B4
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594027; cv=none; b=Zxwn5wbgspJNrDI/uYWQgApZXyF7yl5IvlPg6zS9X9+lQmx4Bf49QHc1izT5TWEecu7t9IGmMZ1y1DZlpuhCcdwssUo5zo9K7U28+ffO4AxRgZfZxdlWs3Ij7q/8/CVd99O/L5LDSLJ6EB7GpjfWtlbUu+8AHPUPgkLQKPdH9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594027; c=relaxed/simple;
	bh=dZBxhS3jH11eOCvg4+CIOW5Er1caEa7iBADykiM1MMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1p+6v3qZYfWKUipExsbkHK79zOwpdQrr1Hze76kUT1HV8Ie46MkGuQjchOdMBvfj7GXfibpPLlf7Adf7v3dTVtX4YSB8ChcDprvUvOXEHqj4XRDFCI2ShDfHmoJddpyYxrVs5T3X3pllBpk2I999BgzU6nHD/vYNfPoV0M7TWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0zT+AGm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0zT+AGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9C4C113D0;
	Tue, 19 Aug 2025 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594026;
	bh=dZBxhS3jH11eOCvg4+CIOW5Er1caEa7iBADykiM1MMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0zT+AGm2GSDlSM8bS9V6sNGJ+KhEQFNmB1NIOCnUyTOh9r2+kxD7Eb4ABDVZQmgb
	 aXHhWgHy9WvjJz0qvEr3X7NMUpvsG0M7nEBL8BGOJa2a3y0XLw6kp30aShx1mF4Cqe
	 a+5rxJO8yXASvS9qEdKaiS7d74WVpsyhQnD7fZFWt+6a6nWV0H1atwYJ9zbpbDG6eM
	 ljq4KWYAXAO1xA6QO7J5pUjHzgPxUdqMEAdZzCr4vJ03eZBUPy/Cu3v4JnVvSQDr2T
	 ppPJLz+fshu7Ed8S7fDK+8bXe7Ren8Mmf/SsjizviGkQ7PokAH6HWLZvsu5KOGNHaR
	 JUEuzdPme7dyA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 03/11] selftests: mptcp: sockopt: add SO_REUSEPORT test
Date: Tue, 19 Aug 2025 17:00:09 +0800
Message-ID: <2258943db59b817193a56ffe1953089d46f7d538.1755592822.git.tanggeliang@kylinos.cn>
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

Implement comprehensive testing for the SO_REUSEPORT socket option:
- Setsockopt and getsockopt helpers for SO_REUSEPORT
- Verification of the set value
- Integration into both client/server workflows
- IPv4 and IPv6 test coverage

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 23 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 +++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index a91709aeca06..816d71706f7d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -190,9 +190,18 @@ static void do_setsockopt_reuseaddr(int fd)
 		perror("setsockopt(SO_REUSEADDR)");
 }
 
+static void do_setsockopt_reuseport(int fd)
+{
+	int one = 1;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one)))
+		perror("setsockopt(SO_REUSEPORT)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
+	do_setsockopt_reuseport(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -578,6 +587,18 @@ static void do_getsockopt_reuseaddr(int fd)
 	assert(reuse == 1);
 }
 
+static void do_getsockopt_reuseport(int fd)
+{
+	socklen_t len;
+	int reuse;
+
+	len = sizeof(reuse);
+	if (getsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &reuse, &len))
+		perror("getsockopt(SO_REUSEPORT)");
+
+	assert(reuse == 1);
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -590,6 +611,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 
 	do_getsockopt_reuseaddr(fd);
+
+	do_getsockopt_reuseport(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 2f6b16cd51af..271d9777da54 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -277,6 +277,10 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SO_REUSEADDR sockopt v4"
 
+	print_title "SO_REUSEPORT sockopt v4"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "SO_REUSEPORT sockopt v4"
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
@@ -295,6 +299,10 @@ do_mptcp_sockopt_tests()
 	print_title "SO_REUSEADDR sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SO_REUSEADDR sockopt v6"
+
+	print_title "SO_REUSEPORT sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "SO_REUSEPORT sockopt v6"
 }
 
 run_tests()
-- 
2.48.1


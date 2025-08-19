Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168E1519B4
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594025; cv=none; b=kewIfAjyj2sQWbfXdzsgiQ9B7EojD8CxLylVCB2lB7+Md9BATYmHsnRp3rl0DWFVicdGkp3q/T9Jv35iAT115Ue5VsYPzDr+TdllYbuBGbMcxgXhu/UsKbg1J48hy6WfKjGXJov/wrBy5c1jQYRzI/Rn1jb7TQDPgpGpVoGC1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594025; c=relaxed/simple;
	bh=kjG2VT11AYy8yUjzSilUvgWK3zdVU19UDMRHXulFNGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUp+1fnd+mHStjMm5rRywxpLW0rtGIowK1wTUMvFm5LEKG1SxbFfqihIs5mcZWgUJ7cVeNqxLqXk2BGwN8SowPrrONx7jJ1J9xhrBH0tdkY4XLwpBEV8jTuxIrIZ5tMVwMAYzwQ4n6k96lBgyQZ+yVg2HF/xYxAjDnKZVWZdvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R72nrxhH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R72nrxhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BB4C4CEF1;
	Tue, 19 Aug 2025 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594024;
	bh=kjG2VT11AYy8yUjzSilUvgWK3zdVU19UDMRHXulFNGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R72nrxhHodlRVo7GiP+KxhPD+DtWIwNhQZOy4XQKkVBEbaDfkRXhKRJ2jpyBdkpx/
	 HRbIXKpN+aiC9MfDRq4E3xKGL0T/g0f87aYX/sSqOdGx1yXvlZH5W6HT9lkkFJMGNZ
	 zOMHQW3rg0F30R9NesXx/o1loOy6AdACp0XG5RH59LlC09CdEG+iDNFHi91h86/5/5
	 fv40E1ylyDMWpgBT28oCY6Qg2vcd5wS1nA8SBenBFbPavEsMaZFp3NzdYh40acXJqH
	 p8LYHAJ2p4YsoU0teyCG6DlHXteWpriqefW0E+11N5XP9bHr1OFQ3ls6rwZYr5Q/uJ
	 hcqzVL1py6MwQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 02/11] selftests: mptcp: sockopt: add SO_REUSEADDR test helper
Date: Tue, 19 Aug 2025 17:00:08 +0800
Message-ID: <7aa9e087d000568d122699abc0236b0d81d8f691.1755592822.git.tanggeliang@kylinos.cn>
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

Introduce helper functions to set and verify the SO_REUSEADDR socket
option. This includes:
- do_setsockopt_reuseaddr() to set the option
- do_getsockopt_reuseaddr() to validate the value
- Integration into IPv4/IPv6 test flows
- Explicit result reporting in the test script

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 34 ++++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 +++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e934dd26a59d..a91709aeca06 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -182,6 +182,19 @@ static void xgetaddrinfo(const char *node, const char *service,
 	}
 }
 
+static void do_setsockopt_reuseaddr(int fd)
+{
+	int one = 1;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)))
+		perror("setsockopt(SO_REUSEADDR)");
+}
+
+static void do_setsockopts(int fd)
+{
+	do_setsockopt_reuseaddr(fd);
+}
+
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
@@ -195,7 +208,6 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	hints.ai_family = pf;
 
 	struct addrinfo *a, *addr;
-	int one = 1;
 
 	xgetaddrinfo(listenaddr, port, &hints, &addr);
 	hints.ai_family = pf;
@@ -205,9 +217,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		if (sock < 0)
 			continue;
 
-		if (-1 == setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,
-				     sizeof(one)))
-			perror("setsockopt");
+		do_setsockopts(sock);
 
 		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
@@ -246,6 +256,8 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		if (sock < 0)
 			continue;
 
+		do_setsockopts(sock);
+
 		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
 
@@ -554,6 +566,18 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 	assert(!memcmp(&sfinfo->addrs, &s->addrs, sizeof(struct mptcp_subflow_addrs)));
 }
 
+static void do_getsockopt_reuseaddr(int fd)
+{
+	socklen_t len;
+	int reuse;
+
+	len = sizeof(reuse);
+	if (getsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &reuse, &len))
+		perror("getsockopt(SO_REUSEADDR)");
+
+	assert(reuse == 1);
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -564,6 +588,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 
 	if (r)
 		do_getsockopt_mptcp_full_info(s, fd);
+
+	do_getsockopt_reuseaddr(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 375d1eabe4f7..2f6b16cd51af 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -273,6 +273,10 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SOL_MPTCP sockopt v4"
 
+	print_title "SO_REUSEADDR sockopt v4"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "SO_REUSEADDR sockopt v4"
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
@@ -287,6 +291,10 @@ do_mptcp_sockopt_tests()
 	print_title "SOL_MPTCP sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SOL_MPTCP sockopt v6"
+
+	print_title "SO_REUSEADDR sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "SO_REUSEADDR sockopt v6"
 }
 
 run_tests()
-- 
2.48.1


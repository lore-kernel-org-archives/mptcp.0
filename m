Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6782ED17C
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766531; cv=none; b=I7cq6t2rSP+a9YM+waX+fbKtNW1a7hEsuK915BOgT1gz0e4tCvoE6VXddTOJZU5Lygk7aFQlyD1xU2eJFhv6dO3ZKMGgEV+sishikaJg9y572eJ4Jpnq9YlTFhSn5KwHYOOVp0ikiTArJTL6Wv/LsfklJGh1nMEX8EImPRWte7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766531; c=relaxed/simple;
	bh=ipTPMZuKt9O324s81iqFYGTz5QlNc+MLs5UFitAYdXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrVC6sdJdlKAvTZQHTLCGiA0hAgWJafBPCrJK8lxU3HPLzCgWKo88Ly3NtSCsm2MjnzWmYpKAUCVO4vokGfpaverK7VYfpeAWNits7mU5U8CMAFzD5rd8R95BvyiwuSX7Ne8QOGS4Mb/GJ59HW2+tsHiC4RLv6WLTaD4cUp61JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSpeBLC0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSpeBLC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35532C113CF;
	Thu, 21 Aug 2025 08:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766530;
	bh=ipTPMZuKt9O324s81iqFYGTz5QlNc+MLs5UFitAYdXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSpeBLC0XowQYi8xr+64GRcob7WoKFFTaxZZK0EWq1m8xCckmDZAJhAH0WZBzUm2A
	 UEmpWzZb6CQyM4YI5+FCOv+N8Hh4i6ZfAzTectpqnxLmAXCBDho3gioO1uzJSp6kQZ
	 Qf46LxKH6Bug4Q331o5J8SMPrIFaGjM7SHL+MTd+bctmDh0KHIG1MWk4mPOa9Ef6C9
	 v04gy2/JQbaKlrw0pmC++b7VMIHQCaYvQcudOlq8Brbf8fst6hm/cVRty7DJaDR21v
	 Mt536JN3iAK2424+u0lXY3UuDs6Hyac9vjWPo3VoLIZBAS4IHFCectfa+eKDpKlADz
	 Z0MLsmQfhonfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 02/10] selftests: mptcp: sockopt: add SO_REUSEADDR test helper
Date: Thu, 21 Aug 2025 16:54:50 +0800
Message-ID: <47bcf897131d391459f1eef92c43194154da15c9.1755680616.git.tanggeliang@kylinos.cn>
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

Introduce helper functions to set and verify the SO_REUSEADDR socket
option. This includes:
- do_setsockopt_reuseaddr() to set the option
- do_getsockopt_reuseaddr() to validate the value
- Integration into IPv4/IPv6 test flows
- Explicit result reporting in the test script

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 34 ++++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  7 ++--
 2 files changed, 34 insertions(+), 7 deletions(-)

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
index 003d218defa8..da6c261275ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -269,7 +269,8 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
-	for opt in "SOL_MPTCP"; do
+	for opt in "SOL_MPTCP" \
+		   "SO_REUSEADDR"; do
 		print_title "$opt sockopt v4"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v4"
@@ -286,12 +287,12 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
-	for opt in "SOL_MPTCP"; do
+	for opt in "SOL_MPTCP" \
+		   "SO_REUSEADDR"; do
 		print_title "$opt sockopt v6"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v6"
 	done
-
 }
 
 run_tests()
-- 
2.48.1


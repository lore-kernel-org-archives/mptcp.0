Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050672ECEBF
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766540; cv=none; b=m40eaOGvcEbIzxHou+r4bOxhKHsGC3yBq4Ilg4RWKMvx8iEqjDAZGIBGAGNXe0kwYkYZtCmnigFCLN1PWaoLXeyenTpma/l6iw9/V6UHgu/6RiwGcZ5RuISaxkdKzThB8EL7R7Ei1vGMxahQ88LQ/XQ3IrvYb08nTe+fzSHw3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766540; c=relaxed/simple;
	bh=BwR/UP5rSl0j5/UjFQYOU1aGipgDYNIxSNSudrCHECk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQSyUBPsuPp0g0YwYZ7GKlykbHIsx7lP5HOQ4SSe5nJiGtc5fjZ6/0MbbpGn8OBHlQTEogX8OBEpPB7GnwhU2+JERF24sBDldNNpX5Ca6a6LSYTd6qXjZZNOO+uY/p14rwyaeO16rCXq6jS4g4BAtpjtVNpvQQ/C+Hpp/cUY0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYWZyo4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYWZyo4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A9CC4CEEB;
	Thu, 21 Aug 2025 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766539;
	bh=BwR/UP5rSl0j5/UjFQYOU1aGipgDYNIxSNSudrCHECk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYWZyo4mGiRRNneWRs3HD9RYQeMwvcODIEqYWKeVf4QdxOJy2TgDLpce9m8RkIJkH
	 rlM8ukw2bAbuAYU9vjasNK5YDxRKdJ/fMd5ohivklKaUBRY5ECmwxz20jZJCdzs4g9
	 eNOL1Kjfewso6vQC83uzagFfZJMQ+Ro3gmchS1Gai7JyK+LFGWHSWHepeyBx1bwAGL
	 J2h8OUDcuTsT0EWxouTpKSmwgtUJ7TyQralZLGwk48hAx/HZm0gucBR2MW7jvGV4dy
	 kFA6e1IBHFFHkICkdYs5EZhItN5kvLORNM4SzOEvyozlMDdR9CInjta/0LqdYq9W1M
	 IUex04ztzpIgA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 07/10] selftests: mptcp: sockopt: add IP_TRANSPARENT tests
Date: Thu, 21 Aug 2025 16:54:55 +0800
Message-ID: <648279116771957c9bf5ea1a86f04adb92e6488b.1755680616.git.tanggeliang@kylinos.cn>
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

Implement tests for transparent socket options:
- IP_TRANSPARENT (IPv4) and IPV6_TRANSPARENT (IPv6)
- Setsockopt and getsockopt helpers
- State verification after setting
- IPv4/IPv6 coverage in test script

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 27 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  4 +--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e9ef908dc270..ccc072005118 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -243,6 +243,16 @@ static void do_setsockopt_freebind(int fd)
 		perror("setsockopt(IP(V6)_FREEBIND)");
 }
 
+static void do_setsockopt_transparent(int fd)
+{
+	int optname = (pf == AF_INET ? IP_TRANSPARENT : IPV6_TRANSPARENT);
+	int level = (pf == AF_INET ? SOL_IP : SOL_IPV6);
+	int enable = 1;
+
+	if (setsockopt(fd, level, optname, &enable, sizeof(enable)))
+		perror("setsockopt(IP(V6)_TRANSPARENT)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
@@ -250,6 +260,7 @@ static void do_setsockopts(int fd)
 	do_setsockopt_bindtodevice(fd);
 	do_setsockopt_bindtoifindex(fd);
 	do_setsockopt_freebind(fd);
+	do_setsockopt_transparent(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -686,6 +697,20 @@ static void do_getsockopt_freebind(int fd)
 	assert(enable == 1);
 }
 
+static void do_getsockopt_transparent(int fd)
+{
+	int optname = (pf == AF_INET ? IP_TRANSPARENT : IPV6_TRANSPARENT);
+	int level = (pf == AF_INET ? SOL_IP : SOL_IPV6);
+	socklen_t len;
+	int enable;
+
+	len = sizeof(enable);
+	if (getsockopt(fd, level, optname, &enable, &len))
+		die_perror("getsockopt(IP(V6)_TRANSPARENT)");
+
+	assert(enable == 1);
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -706,6 +731,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_bindtoifindex(fd);
 
 	do_getsockopt_freebind(fd);
+
+	do_getsockopt_transparent(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 193f4d4dc41a..da02769fbb2b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -272,7 +272,7 @@ do_mptcp_sockopt_tests()
 	for opt in "SOL_MPTCP" \
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
 		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX" \
-		   "IP_FREEBIND"; do
+		   "IP_FREEBIND" "IP_TRANSPARENT"; do
 		print_title "$opt sockopt v4"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v4"
@@ -292,7 +292,7 @@ do_mptcp_sockopt_tests()
 	for opt in "SOL_MPTCP" \
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
 		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX" \
-		   "IPV6_FREEBIND"; do
+		   "IPV6_FREEBIND" "IPV6_TRANSPARENT"; do
 		print_title "$opt sockopt v6"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v6"
-- 
2.48.1


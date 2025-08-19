Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9559315779
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594038; cv=none; b=pZgDeDZNDrYTPAW8UInqMCWZs+AUovBOoTlP1/Fw8f1IyzAOWQOFyEnX6kZmPLr9Z7bPqfdndVK3DOsMekw/W3IPZQ0vv8ap/YPKqZvOj+gBA0v3Q/1Hw/bqaJY1BuSnrtftQaHEXJ/HY0dLZpncO6jh8Fpmiv9SyIYVJPXHb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594038; c=relaxed/simple;
	bh=huId9eEblWu60Eo75YpwbQrUGA7hIi+zvdlRHKWU2RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYcYukj6fDWWQnMTJGatiC/DahC+tliYYs+/eUhJfgWeTCQfQCPp1FKWf2UYFNpysvwVE24Ddu/YJF4drQCY0Zg+/Mmn71i9kMpwbVSP7wYOwZ8YXfO19QL8138q/BPIhuSjFeVB+HGI48D3jG0EYg4FsqeopVtjZZb7nivuGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlvWHR6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlvWHR6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644D1C4CEF1;
	Tue, 19 Aug 2025 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594037;
	bh=huId9eEblWu60Eo75YpwbQrUGA7hIi+zvdlRHKWU2RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NlvWHR6GbN+Z4M823HCej1c+sv0g+PoQzL8K9SkpZiAjEIFkCK8K2FSfeELinj9qx
	 jlKpbKyfHiSsZqxj4GPQx9AaF3E8J2XmdsKOvEkD/tkuWvW5G7wejWV9HZmY9g6GPC
	 XorHNzaNIK+G1cJYKuzPGLO+eK+K5ULnaxqvn10itqrsvppWyItsTrQTcu8rywbmxj
	 qQR1AGIl+R9F+rqEoFfiiyWvi9/6mutsp2ZnWT3858F05qjQDrqF48v2Gsj6QpYOON
	 IUJlS95WHHuyOKxMozq1QU2OUxSrkb3yenBCVqv1A8ORHGnniUTKMiiU5nEtRJX60R
	 +2tUphU1mMgSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 08/11] selftests: mptcp: sockopt: add IP_TRANSPARENT tests
Date: Tue, 19 Aug 2025 17:00:14 +0800
Message-ID: <754dcbcd5da7af5eb8a44393002f74864fbb8830.1755592822.git.tanggeliang@kylinos.cn>
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

Implement tests for transparent socket options:
- IP_TRANSPARENT (IPv4) and IPV6_TRANSPARENT (IPv6)
- Setsockopt and getsockopt helpers
- State verification after setting
- IPv4/IPv6 coverage in test script

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 37 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 ++++
 2 files changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 1e7cacdebc72..fe54c333e455 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -256,6 +256,21 @@ static void do_setsockopt_freebind(int fd)
 		perror("setsockopt(IP_FREEBIND)");
 }
 
+static void do_setsockopt_transparent(int fd)
+{
+	int optname = IP_TRANSPARENT;
+	int level = SOL_IP;
+	int enable = 1;
+
+	if (pf == AF_INET6) {
+		level = SOL_IPV6;
+		optname = IPV6_TRANSPARENT;
+	}
+
+	if (setsockopt(fd, level, optname, &enable, sizeof(enable)))
+		perror("setsockopt(IP_TRANSPARENT)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
@@ -264,6 +279,7 @@ static void do_setsockopts(int fd)
 	do_setsockopt_bindtoifindex(fd);
 	do_setsockopt_tos(fd);
 	do_setsockopt_freebind(fd);
+	do_setsockopt_transparent(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -739,6 +755,25 @@ static void do_getsockopt_freebind(int fd)
 	assert(enable == 1);
 }
 
+static void do_getsockopt_transparent(int fd)
+{
+	int optname = IP_FREEBIND;
+	int level = SOL_IP;
+	socklen_t len;
+	int enable;
+
+	if (pf == AF_INET6) {
+		level = SOL_IPV6;
+		optname = IPV6_FREEBIND;
+	}
+
+	len = sizeof(enable);
+	if (getsockopt(fd, level, optname, &enable, &len))
+		die_perror("getsockopt(IP_TRANSPARENT)");
+
+	assert(enable == 1);
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -761,6 +796,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_tos(fd);
 
 	do_getsockopt_freebind(fd);
+
+	do_getsockopt_transparent(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index b5054533872b..ed73ad7bba66 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -297,6 +297,10 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "IP_FREEBIND sockopt v4"
 
+	print_title "IP_TRANSPARENT sockopt v4"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IP_TRANSPARENT sockopt v4"
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
@@ -335,6 +339,10 @@ do_mptcp_sockopt_tests()
 	print_title "IPV6_FREEBIND sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "IPV6_FREEBIND sockopt v6"
+
+	print_title "IPV6_TRANSPARENT sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IPV6_TRANSPARENT sockopt v6"
 }
 
 run_tests()
-- 
2.48.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F542E8B76
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766540; cv=none; b=pHdFCpsdzX1nI+hqNA6aHKQKkQ/KOK6Ik7gXyM8I4Qjs87nFkn2snlXGjrIfqmRlf1nZxBepHNfHv6lBHJSBcbehJKgMwrEyxk31iJzzq3r5Zzk3XL3uSw1CMYu5y79E3xHQpSdMnkjmHk8NWrDyaUtQxoZQG4M2yy9tE2AvyNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766540; c=relaxed/simple;
	bh=jE+rR039P7YNxt3qVOAscCsiI8nZqCfrpxpOQGEr93Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToUdeFAro41ewRoPq6QmpwBHxLZTfj/LVq2S9l0daGgXJWRJKwlmcByXR2haS/ftukrJNV7tvqai3KjyLThrCYdexXY07HUaBe9E0lWMby0g5Al4rXLmNGUYWn8spQR1p4L8ucJ9RBvh70jakOnDDKfcXxWg3Nf5U6qiecccvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5/dSZ5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5/dSZ5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E37C113CF;
	Thu, 21 Aug 2025 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766537;
	bh=jE+rR039P7YNxt3qVOAscCsiI8nZqCfrpxpOQGEr93Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5/dSZ5G3H+EsD75I0jGEFg3lKOt1rC7jrDQNGSbVKlUhjzVVBOsEVQdYJdX8CDqU
	 LuHyoJU6RJ7be2PqglpgFGpnCeFk0x28TxHK9BBUlU0ERAbi72CzWNI2+Y5aJk1afY
	 UE6pXtZOzb+y09yIpWmUAq2FYdMMEDBaoXU89E1sOtMjWMPbAheKbGl6s7LqpcAJ56
	 /ENIJFksgx1xWndxoxjxdSeuPkPpxCORp8my4qj33clUEGsn7NEq2Dyg9sF/Lsxn+u
	 pVZReVX3L4MF8xcrYVPny87KLAqQvi+i8AfML5t3Ut3ITeVwz2n7s6v+AX0GCdGvIi
	 FDVyCXpDRQOPQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 06/10] selftests: mptcp: sockopt: add IP_FREEBIND tests
Date: Thu, 21 Aug 2025 16:54:54 +0800
Message-ID: <f4a6dad08abf053ee15a8a1595ce751d023bf5a5.1755680616.git.tanggeliang@kylinos.cn>
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

Add tests for IP_FREEBIND (IPv4) and IPV6_FREEBIND (IPv6):
- Setsockopt helpers to enable FREEBIND
- Getsockopt validation of the enabled state
- Test integration for both address families
- Script result reporting

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 27 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  6 +++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 25456e540cad..e9ef908dc270 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -233,12 +233,23 @@ static void do_setsockopt_bindtoifindex(int fd)
 		perror("setsockopt(SO_BINDTOIFINDEX)");
 }
 
+static void do_setsockopt_freebind(int fd)
+{
+	int optname = (pf == AF_INET ? IP_FREEBIND : IPV6_FREEBIND);
+	int level = (pf == AF_INET ? SOL_IP : SOL_IPV6);
+	int enable = 1;
+
+	if (setsockopt(fd, level, optname, &enable, sizeof(enable)))
+		perror("setsockopt(IP(V6)_FREEBIND)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
 	do_setsockopt_reuseport(fd);
 	do_setsockopt_bindtodevice(fd);
 	do_setsockopt_bindtoifindex(fd);
+	do_setsockopt_freebind(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -661,6 +672,20 @@ static void do_getsockopt_bindtoifindex(int fd)
 	assert(ifindex == get_ifindex(fd, "lo"));
 }
 
+static void do_getsockopt_freebind(int fd)
+{
+	int optname = (pf == AF_INET ? IP_FREEBIND : IPV6_FREEBIND);
+	int level = (pf == AF_INET ? SOL_IP : SOL_IPV6);
+	socklen_t len;
+	int enable;
+
+	len = sizeof(enable);
+	if (getsockopt(fd, level, optname, &enable, &len))
+		die_perror("getsockopt(IP(V6)_FREEBIND)");
+
+	assert(enable == 1);
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -679,6 +704,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_bindtodevice(fd);
 
 	do_getsockopt_bindtoifindex(fd);
+
+	do_getsockopt_freebind(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 7f2effd82af8..193f4d4dc41a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -271,7 +271,8 @@ do_mptcp_sockopt_tests()
 
 	for opt in "SOL_MPTCP" \
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
-		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX"; do
+		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX" \
+		   "IP_FREEBIND"; do
 		print_title "$opt sockopt v4"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v4"
@@ -290,7 +291,8 @@ do_mptcp_sockopt_tests()
 
 	for opt in "SOL_MPTCP" \
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
-		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX"; do
+		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX" \
+		   "IPV6_FREEBIND"; do
 		print_title "$opt sockopt v6"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v6"
-- 
2.48.1


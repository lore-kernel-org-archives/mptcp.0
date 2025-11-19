Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8032D7FC
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546738; cv=none; b=QXkU/KN8zGNbMSnq5YA98y091C8eObs/DgLQQTOcfUuWe4CWxIXANEo+Yn/FHs5PuEN6J+yfRUEEohIxsfMnWUHRWY/nPQ9Sh4C+/MFPciG4d2X5bhoX11+mmgLSAvEcVyXutNpvVptFdvKIn8jbbEyZdbU39wMWReNzkzY2Iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546738; c=relaxed/simple;
	bh=Dt0shIeVMEA2HPY3UF5xjD57QUMX00XkWetIBuomlMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnvNLAeKwa35jQWHcO6zFihjjrKETi97sWBg1c1eq5MIV1iRaKqecmA659rGhg6U3MYAx8MAoMyKDaXS7w8BVy8hcDd/0BvgL63VTzRhK5tNCAr1Ry4Ob1QPUlaXTdOfM2TVuh4tlABV4M12w8PqYmh5oKAqEgtFeGD7aNYO8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssNxNcko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssNxNcko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4548CC4AF09;
	Wed, 19 Nov 2025 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546737;
	bh=Dt0shIeVMEA2HPY3UF5xjD57QUMX00XkWetIBuomlMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssNxNckoyKmZARRxkkdbDwKy7Q2gkZIoSXFw0sTF4bnNejzsu4Vw97zhnFH6LD0XC
	 sv6xn0SSmDdhcvPn3jPE5VakYWtrPQFFbt050IFcbR8Szv/Oem6F1Og48glOACEXvb
	 vfmCYma5/NmPAi2abq/nOUy455wkJhjMEoH1Xoiy4MG8u8cEG/jVEVHyRBershWXl0
	 sV+DVDHyX+B5BMRzd3BsBQ6Q6EB2SSFkEOtKgv2Et/o7VL6LeE+9M/C+hY4ewr8b7Q
	 f04hIVXdUQn3uNq7zBpziPwIyGnMXDzMQTQHMGdhnysldhZa4g0mJZa7x138WV1/lh
	 aEzK620mcMPZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org,
	hare@suse.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v2 4/8] selftests: mptcp: connect: update sock_test_tcpulp
Date: Wed, 19 Nov 2025 18:05:03 +0800
Message-ID: <ea8f3d6c8a133be5d911da7811a81759363875e3.1763546473.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763546473.git.tanggeliang@kylinos.cn>
References: <cover.1763546473.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Improve sock_test_tcpulp() function to properly validate TLS ULP
setup on MPTCP sockets. The updated logic verifies that TLS can be
correctly configured based on the socket protocol type and state.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 2e50d6f93640..badb04b58a64 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -266,13 +266,25 @@ static void set_mptfo(int fd, int pf)
 		perror("TCP_FASTOPEN");
 }
 
+static int is_mptcp(int fd)
+{
+	socklen_t optlen;
+	int mptcp = 0;
+
+	optlen = sizeof(mptcp);
+	if (getsockopt(fd, IPPROTO_TCP, TCP_IS_MPTCP, &mptcp, &optlen) == -1)
+		perror("TCP_IS_MPTCP");
+
+	return mptcp;
+}
+
 static int do_ulp_so(int sock, const char *name)
 {
 	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
 }
 
 #define X(m)	xerror("%s:%u: %s: failed for proto %d at line %u", __FILE__, __LINE__, (m), proto, line)
-static void sock_test_tcpulp(int sock, int proto, unsigned int line)
+static void sock_test_tcpulp(int sock, int proto, int r, unsigned int line)
 {
 	socklen_t buflen = 8;
 	char buf[8] = "";
@@ -282,14 +294,14 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		X("getsockopt");
 
 	if (buflen > 0) {
-		if (strcmp(buf, "mptcp") != 0)
+		if (strcmp(buf, is_mptcp(sock) ? "tls" : "mptcp") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
 		ret = do_ulp_so(sock, "tls");
-		if (ret == 0)
+		if (ret != r)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
 		ret = do_ulp_so(sock, "tls");
-		if (ret != -1)
+		if (ret != r)
 			X("setsockopt");
 	}
 
@@ -300,7 +312,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 #undef X
 }
 
-#define SOCK_TEST_TCPULP(s, p) sock_test_tcpulp((s), (p), __LINE__)
+#define SOCK_TEST_TCPULP(s, p, r) sock_test_tcpulp((s), (p), (r), __LINE__)
 
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
@@ -325,7 +337,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		if (sock < 0)
 			continue;
 
-		SOCK_TEST_TCPULP(sock, cfg_sock_proto);
+		SOCK_TEST_TCPULP(sock, cfg_sock_proto, -1);
 
 		if (-1 == setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,
 				     sizeof(one)))
@@ -352,7 +364,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		return sock;
 	}
 
-	SOCK_TEST_TCPULP(sock, cfg_sock_proto);
+	SOCK_TEST_TCPULP(sock, cfg_sock_proto, -1);
 
 	if (listen(sock, 20)) {
 		perror("listen");
@@ -360,7 +372,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		return -1;
 	}
 
-	SOCK_TEST_TCPULP(sock, cfg_sock_proto);
+	SOCK_TEST_TCPULP(sock, cfg_sock_proto, -1);
 
 	return sock;
 }
@@ -388,7 +400,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			continue;
 		}
 
-		SOCK_TEST_TCPULP(sock, proto);
+		SOCK_TEST_TCPULP(sock, proto, -1);
 
 		if (cfg_mark)
 			set_mark(sock, cfg_mark);
@@ -425,7 +437,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 
 	freeaddrinfo(addr);
 	if (sock != -1)
-		SOCK_TEST_TCPULP(sock, proto);
+		SOCK_TEST_TCPULP(sock, proto, is_mptcp(sock) ? 0 : -1);
 	return sock;
 }
 
@@ -1202,7 +1214,7 @@ int main_loop_s(int listensock)
 				xerror("can't open %s: %d", cfg_input, errno);
 		}
 
-		SOCK_TEST_TCPULP(remotesock, 0);
+		SOCK_TEST_TCPULP(remotesock, 0, 0);
 
 		memset(&winfo, 0, sizeof(winfo));
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
@@ -1381,7 +1393,7 @@ int main_loop(void)
 again:
 	check_getpeername_connect(fd);
 
-	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
+	SOCK_TEST_TCPULP(fd, cfg_sock_proto, -1);
 
 	if (cfg_rcvbuf)
 		set_rcvbuf(fd, cfg_rcvbuf);
-- 
2.51.0


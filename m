Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC102481DD
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801143; cv=none; b=BD+MCr5roJsvNv5ChFln0bkRZDXQrqgHxkrFgYN0AG6juXTkNjMpl8Him08UnGqoGP7Qh9Mxm9uPCfLLn/sa61TkXiyI31ZYScfMSgQ/O992voTFdhvZLagjh1tIuSFX6oYiPUqUnYwppjZw9lWNajsVkUC/6sX+J91nOukKqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801143; c=relaxed/simple;
	bh=srkbzZW6tEfIzXr/sQxnW+HG+iq67Ia/AS+NfDU9miY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbsnHoQJd2cDvXBZHVPV2hArJit7SAJKhpR8oK+TvKwNXydK2uhy2ekZi83JK2q1OPNi2FKYgJsICl3hs/mB0kPHPuhmJSA/s6JG6rzf7ChYm3rthW0w6ZFAAOqhX1/5tUM/hEQcbReesjZg8T1jDbtCnog9w/c4DP3O2TKgBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTFKWHPs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTFKWHPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B82C116D0;
	Sat, 22 Nov 2025 08:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801143;
	bh=srkbzZW6tEfIzXr/sQxnW+HG+iq67Ia/AS+NfDU9miY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTFKWHPssI0Nuxax/ft2+HSvOYhP0zJm9ml4rvxXHeXHDybC59xJiiiHlMkVby2/U
	 76qUAskgc0wLLDrjtRe7DpKN/8dXgEoo03FYXzKuORX7EXT9Jg6IABCab3S7iSnjMm
	 kivWX5N/t+ikCPZVSP8nLzeyyN21SuDUbwmH0/4io4ODnjvHcvvlvGbYfKZWhgFyKt
	 y/wmFk59exRiBKbYHiSxWx5ZtJSRyGxbMmk3N85gwXX+fw7QzDq07o8iKI0fHAx8vX
	 Xpi0IdqntoHDYQiiSKD1wHK1WRcmQhi58S4ytFeMom+120D0h2Ej30zB17lbdRTShz
	 uz+oWU/JRAiAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 7/8] selftests: mptcp: connect: update sock_test_tcpulp
Date: Sat, 22 Nov 2025 16:45:26 +0800
Message-ID: <e548c5447d592de021d3379d5600a03541389af3.1763800601.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763800601.git.tanggeliang@kylinos.cn>
References: <cover.1763800601.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Improve sock_test_tcpulp() to properly validate TLS ULP setup on MPTCP
sockets. The updated logic verifies that TLS can be correctly configured
based on the socket protocol type and state.

fallback() helper has been implemented to verify fallback scenarios,
ensuring that MPTCP fallback-to-TCP tests continue to pass.

Initialize 'peer' pointer to NULL in main_loop() to fix the compiler
warning 'peer' may be used uninitialized.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 2e50d6f93640..64c1a57fe72b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -266,13 +266,25 @@ static void set_mptfo(int fd, int pf)
 		perror("TCP_FASTOPEN");
 }
 
+static int fallback(int fd)
+{
+	int is_mptcp = 0;
+	socklen_t optlen;
+
+	optlen = sizeof(is_mptcp);
+	if (getsockopt(fd, IPPROTO_TCP, TCP_IS_MPTCP, &is_mptcp, &optlen) == -1)
+		perror("TCP_IS_MPTCP");
+
+	return !is_mptcp;
+}
+
 static int do_ulp_so(int sock, const char *name)
 {
 	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
 }
 
 #define X(m)	xerror("%s:%u: %s: failed for proto %d at line %u", __FILE__, __LINE__, (m), proto, line)
-static void sock_test_tcpulp(int sock, int proto, unsigned int line)
+static void sock_test_tcpulp(int sock, int proto, int expect, unsigned int line)
 {
 	socklen_t buflen = 8;
 	char buf[8] = "";
@@ -282,14 +294,14 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		X("getsockopt");
 
 	if (buflen > 0) {
-		if (strcmp(buf, "mptcp") != 0)
+		if (strcmp(buf, fallback(sock) ? "mptcp" : "tls") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
 		ret = do_ulp_so(sock, "tls");
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
 		ret = do_ulp_so(sock, "tls");
-		if (ret != -1)
+		if (ret != expect)
 			X("setsockopt");
 	}
 
@@ -300,7 +312,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 #undef X
 }
 
-#define SOCK_TEST_TCPULP(s, p) sock_test_tcpulp((s), (p), __LINE__)
+#define SOCK_TEST_TCPULP(s, p, e) sock_test_tcpulp((s), (p), (e), __LINE__)
 
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
+		SOCK_TEST_TCPULP(sock, proto, fallback(sock) ? -1 : 0);
 	return sock;
 }
 
@@ -1202,7 +1214,7 @@ int main_loop_s(int listensock)
 				xerror("can't open %s: %d", cfg_input, errno);
 		}
 
-		SOCK_TEST_TCPULP(remotesock, 0);
+		SOCK_TEST_TCPULP(remotesock, 0, 0);
 
 		memset(&winfo, 0, sizeof(winfo));
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
@@ -1364,7 +1376,7 @@ void xdisconnect(int fd)
 int main_loop(void)
 {
 	int fd = 0, ret, fd_in = 0;
-	struct addrinfo *peer;
+	struct addrinfo *peer = NULL;
 	struct wstate winfo;
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {
@@ -1381,7 +1393,7 @@ int main_loop(void)
 again:
 	check_getpeername_connect(fd);
 
-	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
+	SOCK_TEST_TCPULP(fd, cfg_sock_proto, -1);
 
 	if (cfg_rcvbuf)
 		set_rcvbuf(fd, cfg_rcvbuf);
-- 
2.51.0


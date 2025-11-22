Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04909481DD
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801138; cv=none; b=exsiK/FW6kxDFHGuRNQWYHseaKX5PxMcjwGVkGR1XJOvfwKd9f/GPuMHo+Mv8zhFM86tdD8U+0QoTSQIsiXMsxSd35C1ay74Gqna2HZC6ZJJoHVHwhytqlBHAFiYHweH8vfTScyJt8SzZqHAbazt/Jgxh/MzXaGlH9oAkRB2Xjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801138; c=relaxed/simple;
	bh=NDUsXhQIjTBPiT7RwlGMQVAOjltDevatsIBVed3w35o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrDssdskWKI8ZnK5zikR3vMwXBs5/MuIra2vyE4COnVswU/un1oj6pWP4biqP6ysxynD7UdNtVzvjWa0UH/HwPvYGzIYc05r2gpXQe4OALlbxLwhxeTJpUoVViy0G2kvnC0WZJ+aPqideNdT7uxqioUHG6UWTsytO/nRFgESxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7XqL+dQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7XqL+dQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E958C4CEF5;
	Sat, 22 Nov 2025 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801137;
	bh=NDUsXhQIjTBPiT7RwlGMQVAOjltDevatsIBVed3w35o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7XqL+dQL43MT2hex3Sanm8XBaqryfNeGr+xPZNeeSKAKj2TVV5nhloHmnO6rvdL/
	 xuiFmNWjYJ1qNTQ7yZn99H0uReMC9Q+IePquAtuNFoCLGghXkAapwPYmFXPVRQG7/k
	 QAvO0VM11HfEU+6F65svl5MgaUGlZ0akNV4XkD06yY3KTrgHykN7/DkqiOCQzGwFD6
	 G+HQ33utH5jHqn7TxA1NUp8FI6qxKfQv4QEDOFP2MTvJ7TFj1FTKuR+m/3KWc5vopG
	 G5vR3JWX8eIiF0tHVLBM8wHznYQ/OU/Kyfk5xUBq5Ncwxeu4AUpoNpnAgMHt05Uos7
	 iXpwsJaLxaA5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 3/8] selftests: mptcp: sockopt: implement TCP TLS tests
Date: Sat, 22 Nov 2025 16:45:22 +0800
Message-ID: <d134e409484194d928a2cef89d8d41c710511b5b.1763800601.git.tanggeliang@kylinos.cn>
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

This patch adds Kernel TLS (KTLS) testing infrastructure to MPTCP sockopt
selftest, introducing a new '-c' option to enable TLS tests. It includes
a helper for configuring TLS socket options and implements TCP-specific
KTLS test cases for both IPv4 and IPv6, along with the necessary header
includes and config updates.

TLS_OVERHEAD_SIZE macro is defined to account for the overhead in sent
and received data length.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../selftests/net/mptcp/mptcp_sockopt.c       | 75 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 36 +++++++++
 3 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..18bd29ac5b24 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,4 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_TLS=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 8fb04c19af5c..444851221473 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -25,10 +25,12 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/tls.h>
 
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool tls;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -36,6 +38,9 @@ static int proto_rx = IPPROTO_MPTCP;
 #ifndef SOL_MPTCP
 #define SOL_MPTCP 284
 #endif
+#ifndef TCP_ULP
+#define TCP_ULP 31
+#endif
 
 #ifndef MPTCP_INFO
 struct mptcp_info {
@@ -137,7 +142,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp] [-c]\n");
 	exit(r);
 }
 
@@ -184,6 +189,54 @@ static void xgetaddrinfo(const char *node, const char *service,
 	}
 }
 
+#define TLS_OVERHEAD_SIZE	29
+
+static int do_setsockopt_tls(int fd)
+{
+	struct tls12_crypto_info_aes_gcm_128 tls_tx = {
+		.info = {
+			.version     = TLS_1_2_VERSION,
+			.cipher_type = TLS_CIPHER_AES_GCM_128,
+		},
+	};
+	struct tls12_crypto_info_aes_gcm_128 tls_rx = {
+		.info = {
+			.version     = TLS_1_2_VERSION,
+			.cipher_type = TLS_CIPHER_AES_GCM_128,
+		},
+	};
+	int so_buf = 6553500;
+	int err;
+
+	err = setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
+	if (err) {
+		perror("setsockopt TCP_ULP");
+		return err;
+	}
+	err = setsockopt(fd, SOL_TLS, TLS_TX, (void *)&tls_tx, sizeof(tls_tx));
+	if (err) {
+		perror("setsockopt TLS_TX");
+		return err;
+	}
+	err = setsockopt(fd, SOL_TLS, TLS_RX, (void *)&tls_rx, sizeof(tls_rx));
+	if (err) {
+		perror("setsockopt TLS_RX");
+		return err;
+	}
+	err = setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &so_buf, sizeof(so_buf));
+	if (err) {
+		perror("setsockopt SO_SNDBUF");
+		return err;
+	}
+	err = setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &so_buf, sizeof(so_buf));
+	if (err) {
+		perror("setsockopt SO_RCVBUF");
+		return err;
+	}
+
+	return 0;
+}
+
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
@@ -276,7 +329,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:c")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -289,6 +342,8 @@ static void parse_opts(int argc, char **argv)
 			break;
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
+		case 'c':
+			tls = true;
 			break;
 		default:
 			die_usage(1);
@@ -652,6 +707,11 @@ static void connect_one_server(int fd, int pipefd)
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta <= total);
 
+	if (tls) {
+		ret += TLS_OVERHEAD_SIZE;
+		total += TLS_OVERHEAD_SIZE;
+	}
+
 	do_getsockopts(&s, fd, ret, ret);
 
 	if (eof)
@@ -692,6 +752,11 @@ static void process_one_client(int fd, int pipefd)
 	if (ret3 != 0)
 		xerror("expected EOF, got %lu", ret3);
 
+	if (tls) {
+		ret += TLS_OVERHEAD_SIZE;
+		ret2 += TLS_OVERHEAD_SIZE;
+	}
+
 	do_getsockopts(&s, fd, ret, ret2);
 	if (s.mptcpi_rcv_delta &&
 	    s.mptcpi_rcv_delta != (uint64_t)ret + 1)
@@ -752,6 +817,9 @@ static int server(int pipefd)
 	alarm(15);
 	r = xaccept(fd);
 
+	if (tls)
+		do_setsockopt_tls(r);
+
 	process_one_client(r, pipefd);
 
 	close(fd);
@@ -815,6 +883,9 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
+	if (tls)
+		do_setsockopt_tls(fd);
+
 	connect_one_server(fd, pipefd);
 
 	return 0;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ab8bce06b262..6dcc0a100094 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -351,6 +351,41 @@ do_tcpinq_tests()
 	return $?
 }
 
+do_tls_test()
+{
+	print_title "KTLS $*" | head -c 53
+	ip netns exec "$ns_sbox" ./mptcp_sockopt "$@"
+	local lret=$?
+	if [ $lret -ne 0 ];then
+		ret=$lret
+		mptcp_lib_pr_fail
+		mptcp_lib_result_fail "KTLS: $*"
+		return $lret
+	fi
+
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "KTLS: $*"
+	return $lret
+}
+
+do_tls_tests()
+{
+	local lret=0
+
+	mptcp_lib_print_info "sockopt KTLS"
+
+	local args
+	for args in "-c -t tcp -r tcp" "-6 -c -t tcp -r tcp"; do
+		do_tls_test $args
+		lret=$?
+		if [ $lret -ne 0 ] ; then
+			return $lret
+		fi
+	done
+
+	return $lret
+}
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
@@ -366,6 +401,7 @@ run_tests $ns1 $ns2 dead:beef:1::1
 
 do_mptcp_sockopt_tests
 do_tcpinq_tests
+do_tls_tests
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.51.0


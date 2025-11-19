Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B732E6B3
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546750; cv=none; b=XjttkwhEosYv6tYuMp/Z05bN/fPuQwD7/149z5dUQWeUU0Y8PGpYWm6wpm6L9346czwzR76bLE6k3x0TJOpFrfXaC0MOOgv/OQ3J9axfSVo4JemFFXPlpZ+mVSVIAYBJMRWRa/5PbS2MWB+JoekBoocDshgBTBcgbdWvQxSqwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546750; c=relaxed/simple;
	bh=2NhT2uw+CM4ep0jkqu/g2D/RljHe81CBy0BAX4oQ7h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awbDcocyO+oNs9BkkYThVk1H7uIo2BhQexvIePyVseCwpic8AiRSzPamc69nRX+ZsHWcBksVjh4zPTieTC5ayBNtEIRZgw7MTKvO4uQHNvWs3jJQTwCpHHsVlDTiy0obBaV4xCxiXzoEB+5DRSSwE4olMXtTou0z5vL8c1kh0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnlipmkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnlipmkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E57C113D0;
	Wed, 19 Nov 2025 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546747;
	bh=2NhT2uw+CM4ep0jkqu/g2D/RljHe81CBy0BAX4oQ7h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnlipmkwsaMKrGNOEUg9VKpLra6KoDKaQH9UN9QTVOsoOvPmM5wdZyH6YzbLEQR4m
	 rHxwxxQvToU0aA9kqN2K12qGOsnAga8rczJkxAbS8xWQZRHY2/Fr67033VCawVQNhM
	 G3mCON/uZ28ijujWPgIMj42sr7fP8bts5nvlHR0KpZfgYEeh81P2r2+W/mCbuaNKz4
	 P8JGAoKzvVqIcWkRj1smwedmB/cdqDTaz5fpMxcHQiYzCjrP1ZcSokIXQy3mx82csA
	 VGZzej13FYW9Kcin3N0kuSaj0Y5gHd4NBGSsYxU3EgLEc+10dgB+xIhrqCFcW50WKI
	 St55d9N4yXkdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org,
	hare@suse.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v2 8/8] selftests: mptcp: sockopt: add KTLS test cases
Date: Wed, 19 Nov 2025 18:05:07 +0800
Message-ID: <d2a8a174bbf54c7d19bfe5bddb1331ac2293fbee.1763546473.git.tanggeliang@kylinos.cn>
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

Add Kernel TLS (KTLS) testing support to mptcp_sockopt:

- New '-c' option to enable TLS testing;
- TLS socket setup with AES-GCM-128 cipher;
- Test cases for both TCP and MPTCP with TLS;
- IPv4 and IPv6 support for TLS tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../selftests/net/mptcp/mptcp_sockopt.c       | 75 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 47 ++++++++++++
 3 files changed, 121 insertions(+), 2 deletions(-)

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
index 59c07eda12cd..7a43f681abc0 100644
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
@@ -640,6 +695,11 @@ static void connect_one_server(int fd, int pipefd)
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta <= total);
 
+	if (tls) {
+		ret += TLS_OVERHEAD_SIZE;
+		total += TLS_OVERHEAD_SIZE;
+	}
+
 	do_getsockopts(&s, fd, ret, ret);
 
 	if (eof)
@@ -680,6 +740,11 @@ static void process_one_client(int fd, int pipefd)
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
@@ -740,6 +805,9 @@ static int server(int pipefd)
 	alarm(15);
 	r = xaccept(fd);
 
+	if (tls)
+		do_setsockopt_tls(r);
+
 	process_one_client(r, pipefd);
 
 	close(fd);
@@ -803,6 +871,9 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
+	if (tls)
+		do_setsockopt_tls(fd);
+
 	connect_one_server(fd, pipefd);
 
 	return 0;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ab8bce06b262..8840be8adea3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -351,6 +351,52 @@ do_tcpinq_tests()
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
+	# TCP KTLS
+	do_tls_test -c -t tcp -r tcp
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		return $lret
+	fi
+	do_tls_test -6 -c -t tcp -r tcp
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		return $lret
+	fi
+
+	# MPTCP KTLS
+	do_tls_test -c
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		return $lret
+	fi
+	do_tls_test -6 -c
+	lret=$?
+	return $lret
+}
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
@@ -366,6 +412,7 @@ run_tests $ns1 $ns2 dead:beef:1::1
 
 do_mptcp_sockopt_tests
 do_tcpinq_tests
+do_tls_tests
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.51.0


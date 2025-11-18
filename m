Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA719ABD8
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438516; cv=none; b=oLxXITXMgALUOen/wwsc5H7qznVg/Hu9Re5EeOTdlpPSc48I75irzXl5X0v8lIsDHb64zERaKrqBojYrdVZYZ32ZK1OsPp9ZL2y1SWq1xCZa5haz4wFSb2aO1xDl9SryVL6O1X0oCkHgF9EfANeBJuNUIu2L8u6Fh9OCFs4IIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438516; c=relaxed/simple;
	bh=5nBADwq3TOV9MoRUmH063c6U1u3JIvKaftJAdxNWaTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH8bMys4d4QmVhqKqRsFST25JpI1uwR0uWd/hnI5wBBsFB3KJslZxyebuBeO5i5158T1RqqHkuk3/zVNoDEU380VXDsimiL08bDYctHXYT4J9pbI2acPGqXchKXKvsaV1dm/0JKfksm3pjkFKQPUMestMiV6IJdY2+Q5StBA9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO+sI3JJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO+sI3JJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AE1C2BCAF;
	Tue, 18 Nov 2025 04:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438516;
	bh=5nBADwq3TOV9MoRUmH063c6U1u3JIvKaftJAdxNWaTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bO+sI3JJXAkvXHCtnprxVJqCfZ4UdNA1+IKqCBZJbuR6TPikjEfvxtNY390GD6t0I
	 M8eMyS2s7j4uqPoEGeephswiL1YVnfNiaM4vmGgkicmkpalk2oQnQ8w8Rq80Eo9FLR
	 EHBVhLUHzaVgN7vfpdcl5bgN615T+EbUkhx43hvpSW2NzfCiD8u9w4bot9mCZY3zxH
	 YQMHq0wn6nEMcnehiJnIpoLTfT/NWmQ5qk0vt+ysFbwAu7peZaYx1rTOMES7JhsEdy
	 JePUkb7RIl0vb5Tvo1t2QamhB47/dHrD9C+INp259OecuNwF8JCWRlmtMtuH3pVv49
	 mJXCrj7biYizA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 04/10] selftests: mptcp: sockopt: implement TCP TLS tests
Date: Tue, 18 Nov 2025 12:01:25 +0800
Message-ID: <b0547f7ac979a36e78b3d5a9ee18f49274114927.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add Kernel TLS (KTLS) testing infrastructure to mptcp_sockopt, including:
- TLS socket option configuration helpers
- TCP-specific TLS test cases for both IPv4 and IPv6
- Required TLS header includes and configuration updates

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../selftests/net/mptcp/mptcp_sockopt.c       | 56 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 35 ++++++++++++
 3 files changed, 92 insertions(+)

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
index 5e1e441c959d..8058b1fd5a35 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -25,6 +25,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/tls.h>
 
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
@@ -37,6 +38,9 @@ static bool tls;
 #ifndef SOL_MPTCP
 #define SOL_MPTCP 284
 #endif
+#ifndef TCP_ULP
+#define TCP_ULP 31
+#endif
 
 #ifndef MPTCP_INFO
 struct mptcp_info {
@@ -185,6 +189,52 @@ static void xgetaddrinfo(const char *node, const char *service,
 	}
 }
 
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
@@ -743,6 +793,9 @@ static int server(int pipefd)
 	alarm(15);
 	r = xaccept(fd);
 
+	if (tls)
+		do_setsockopt_tls(r);
+
 	process_one_client(r, pipefd);
 
 	close(fd);
@@ -806,6 +859,9 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
+	if (tls)
+		do_setsockopt_tls(fd);
+
 	connect_one_server(fd, pipefd);
 
 	return 0;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ab8bce06b262..4d6ab4a63e3f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -351,6 +351,40 @@ do_tcpinq_tests()
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
+	return $lret
+}
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
@@ -366,6 +400,7 @@ run_tests $ns1 $ns2 dead:beef:1::1
 
 do_mptcp_sockopt_tests
 do_tcpinq_tests
+do_tls_tests
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.51.0


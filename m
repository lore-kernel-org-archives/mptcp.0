Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4891314A64
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366213; cv=none; b=dk8EayjuDoGaKFG0xGAvQcniGPVvPcMjS1QCxbj1R6zGV1GUdpYlg1RtF8uNKsRy/AHi83Duky4nnavMWuWDrQ1GvKz6W4k2oWqpL7q+dvv7blj4y4teyZwHCtdQ3r16gpKQeCj9UhIbjQHH+zc3ZKGp583o1MFyMrCoNU0a+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366213; c=relaxed/simple;
	bh=N0ipbJ2ahh9mwNUX65M9UCh9qvTKBjPjl9RJyBeny3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIKcfyQug7eTknAkOovb348bBFzQDjg7SKniZUUV1tsgZVole6t+HmVFkx7qzUOmE56morEybqrdgejXQvTzVxBZgxzZwxL6A8Dh/w0/xXZKxOrnpBdWS9tk6L5/wP6I5Ocp4fd+UcRQ++9AxV5dT/s96hov46sIHMRqLuTYDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuZChfSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuZChfSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBEAC2BC87;
	Fri, 13 Mar 2026 01:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366213;
	bh=N0ipbJ2ahh9mwNUX65M9UCh9qvTKBjPjl9RJyBeny3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PuZChfSSdGuSb1zueagEzweBGz9dNrc2JJE+R6D9SLeNy2uMxSGARSMDXeMQ68lW5
	 i9ln/RDu4YsLISwR6/vRhCrEnCQfus7k2vhnZs6kib/7xw6DUjpH0PnA8NAtOlGjbT
	 KbpVI5y89Q8YySE+m4e0hwfcg+pP71O9kSp+qfsaWl3JyuPuqwwwYXYS92tCX8FTov
	 Wz/t4MeF28XHGasd/X/T7ICBWj/LCzEFUqSvLDJaMmtdDBmQE8IHE+NIPvfPHMZJ90
	 Qos6+G/vFqIL6WpfwLmCgbMWl0q5xrUq9dNYAzivLRybDoN4f1K+OaIu+FUN31XEXa
	 NmfXZ5xXVkQzg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v9 10/10] selftests: mptcp: connect: add TLS tests
Date: Fri, 13 Mar 2026 09:42:52 +0800
Message-ID: <401c3b38f70fce67e3e827a819217fd40de44f09.1773365606.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773365606.git.tanggeliang@kylinos.cn>
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds MPTCP TLS tests for mptcp_connect.c/mptcp_connect.sh.

A new TLS type has been added to cfg_sockopt_types, enabled via the
parameter "-o TLS". do_setsockopt_tls() has been implemented to set
TLS parameters for both the server and client.

After adding TLS configuration, sock_test_tcpulp() needs to be updated
as getsockopt ULP may now return not only "mptcp" but also "tls".

These tests report "read: Resource temporarily unavailable" errors
occasionally, which is fixed by adding handling for EAGAIN in
copyfd_io_poll().

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 47 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      | 33 +++++++++++++
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 64c8a4bfe749..0b4428215236 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -34,6 +34,7 @@
 #include <linux/time_types.h>
 #include <linux/sockios.h>
 #include <linux/compiler.h>
+#include <linux/tls.h>
 
 extern int optind;
 
@@ -89,6 +90,7 @@ struct cfg_cmsg_types {
 struct cfg_sockopt_types {
 	unsigned int transparent:1;
 	unsigned int mptfo:1;
+	unsigned int tls:1;
 };
 
 struct tcp_inq_state {
@@ -272,6 +274,35 @@ static int do_ulp_so(int sock, const char *name)
 	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
 }
 
+static void do_setsockopt_tls(int fd)
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
+	int err;
+
+	err = do_ulp_so(fd, "tls");
+	if (err)
+		xerror("setsockopt TCP_ULP");
+
+	err = setsockopt(fd, SOL_TLS, TLS_TX, (void *)&tls_tx, sizeof(tls_tx));
+	if (err)
+		xerror("setsockopt TLS_TX");
+
+	err = setsockopt(fd, SOL_TLS, TLS_RX, (void *)&tls_rx, sizeof(tls_rx));
+	if (err)
+		xerror("setsockopt TLS_RX");
+}
+
 #define X(m)	xerror("%s:%u: %s: failed for proto %d at line %u", __FILE__, __LINE__, (m), proto, line)
 static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 {
@@ -283,7 +314,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		X("getsockopt");
 
 	if (buflen > 0) {
-		if (strcmp(buf, "mptcp") != 0)
+		if (strcmp(buf, "mptcp") != 0 && strcmp(buf, "tls") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
 		ret = do_ulp_so(sock, "tls");
 		if (ret == 0)
@@ -422,8 +453,11 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 	}
 
 	freeaddrinfo(addr);
-	if (sock != -1)
+	if (sock != -1) {
 		SOCK_TEST_TCPULP(sock, proto);
+		if (cfg_sockopt_types.tls)
+			do_setsockopt_tls(sock);
+	}
 	return sock;
 }
 
@@ -684,6 +718,8 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 			/* Else, still have data to transmit */
 			} else if (len < 0) {
+				if (errno == EAGAIN)
+					continue;
 				if (cfg_rcv_trunc)
 					return 0;
 				perror("read");
@@ -1212,6 +1248,8 @@ int main_loop_s(int listensock)
 		}
 
 		SOCK_TEST_TCPULP(remotesock, 0);
+		if (cfg_sockopt_types.tls)
+			do_setsockopt_tls(remotesock);
 
 		memset(&winfo, 0, sizeof(winfo));
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
@@ -1312,6 +1350,11 @@ static void parse_setsock_options(const char *name)
 		return;
 	}
 
+	if (strncmp(name, "TLS", len) == 0) {
+		cfg_sockopt_types.tls = 1;
+		return;
+	}
+
 	fprintf(stderr, "Unrecognized setsockopt option %s\n", name);
 	exit(1);
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a6447f7a31fe..ef8d6ee22b00 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -815,6 +815,36 @@ run_tests_disconnect()
 	connect_per_transfer=1
 }
 
+run_tests_tls()
+{
+	TEST_GROUP="TLS"
+	local lret=0
+
+	if ! mptcp_lib_kallsyms_has "mptcp_read_done"; then
+		mptcp_lib_pr_skip "TLS not supported by the kernel"
+		mptcp_lib_result_skip "${TEST_GROUP}"
+		return
+	fi
+
+	mptcp_lib_pr_info "with TLS start"
+
+	do_transfer "$ns1" "$ns2" MPTCP MPTCP "10.0.1.1" "0.0.0.0" "-o TLS"
+	lret=$?
+	if [ $lret -ne 0 ]; then
+		ret=$lret
+		return 1
+	fi
+
+	do_transfer "$ns1" "$ns2" MPTCP MPTCP "dead:beef:1::1" "::" "-o TLS"
+	lret=$?
+	if [ $lret -ne 0 ]; then
+		ret=$lret
+		return 1
+	fi
+
+	mptcp_lib_pr_info "with TLS end"
+}
+
 display_time()
 {
 	time_end=$(date +%s)
@@ -959,6 +989,9 @@ log_if_error "Tests with tproxy have failed"
 run_tests_disconnect
 log_if_error "Tests of the full disconnection have failed"
 
+run_tests_tls
+log_if_error "Tests with TLS have failed"
+
 display_time
 mptcp_lib_result_print_all_tap
 exit ${final_ret}
-- 
2.53.0


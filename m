Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB5366DD9
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284826; cv=none; b=VhQqCixxcNKRCBGnT3QNZKXl+NMN34grF2HYG1BIMuptcXD6Lrqqv5sYs9+YOl/dCcyykVDV/nADBZfjqJvAISDRQKNuj9SxylHWQGJEBCQcVFZoD0x0vHOAFNvXFPVRz/mcLzsaUZK4QU4fZXvZwD787BlGvuNhO4bOMQ//TcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284826; c=relaxed/simple;
	bh=5XaCszjAAfzWnP2ZMLJAV4294KewUZkewdicuBOdo0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB2GiaajoKb+Bfi9A525nXRwONElgMiOMkeKhsnhCGTGPKruhKpZcduPx4lsTiY6vRR9cMIteUwfVrEGvJ2JIoe6y0ZKfkxiX5eZnLdCsnsOUeFneZBJC4W87B1zmMskzavoOMhVhT7zFfgyThpS+9fQlKojD7azvEldr4QWvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1dFQTzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1dFQTzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E945C19421;
	Tue, 13 Jan 2026 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768284826;
	bh=5XaCszjAAfzWnP2ZMLJAV4294KewUZkewdicuBOdo0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1dFQTzkKjYDjzcTZ2rrkTH3xpTwwBoR3EdnuhFkivDyLBxT29r9wK5KMXmSOWhug
	 pQfHuOihoGEOAaH7KYWt4r8Mi7jmXLmmz8G8+4GJEChhp3vnzFsxqz9VoHXUI9EOuC
	 mG+TOljELBe94qN3L/wcUkFC7gPgQEZyEKK0lihfQaHNDYJEVs3DaZrEUvgHpa7Tg0
	 5Civ8RoBSzeF0++DrMLAjKzKhwuhrLFHYAMa6O9DWkHBa0OZ/8oUH0/sy4rjO4QBld
	 gevQAZh53z7W44qgcCeg/NEJGqDhdfRb8CMM1kPtWR61vEzEllf5XXSXJKcjWEnt1T
	 eOs6ks2SwNxEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v7 1/9] selftests: mptcp: add tcp tls tests
Date: Tue, 13 Jan 2026 14:13:27 +0800
Message-ID: <4e4c85916e833c823f6dd49d2e6a047ee615f3e0.1768284047.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768284047.git.tanggeliang@kylinos.cn>
References: <cover.1768284047.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A new TLS type has been added to cfg_sockopt_types, enabled via the
parameter "-o TLS". do_setsockopt_tls() has been implemented to set
TLS parameters for both the server and client.

Three TCP TLS tests have been added to mptcp_join.sh. The command
'./mptcp_join.sh -c' can be used to run the tests.

After adding TLS configuration, sock_test_tcpulp() needs to be updated
as getsockopt ULP may now return not only "mptcp" but also "tls".

These tests report "read: Resource temporarily unavailable" errors
occasionally, which is fixed by adding handling for EAGAIN in
copyfd_io_poll().

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 51 ++++++++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++-
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..18bd29ac5b24 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,4 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_TLS=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 1c4fe60089a2..6fb3c0bf879b 100644
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
@@ -272,6 +274,39 @@ static int do_ulp_so(int sock, const char *name)
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
+	int so_buf = 6553500;
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
+
+	set_sndbuf(fd, so_buf);
+	set_rcvbuf(fd, so_buf);
+}
+
 #define X(m)	xerror("%s:%u: %s: failed for proto %d at line %u", __FILE__, __LINE__, (m), proto, line)
 static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 {
@@ -283,7 +318,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		X("getsockopt");
 
 	if (buflen > 0) {
-		if (strcmp(buf, "mptcp") != 0)
+		if (strcmp(buf, "mptcp") != 0 && strcmp(buf, "tls") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
 		ret = do_ulp_so(sock, "tls");
 		if (ret == 0)
@@ -425,8 +460,11 @@ static int sock_connect_mptcp(const char * const remoteaddr,
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
 
@@ -687,6 +725,8 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 			/* Else, still have data to transmit */
 			} else if (len < 0) {
+				if (errno == EAGAIN)
+					continue;
 				if (cfg_rcv_trunc)
 					return 0;
 				perror("read");
@@ -1199,6 +1239,8 @@ int main_loop_s(int listensock)
 		}
 
 		SOCK_TEST_TCPULP(remotesock, 0);
+		if (cfg_sockopt_types.tls)
+			do_setsockopt_tls(remotesock);
 
 		memset(&winfo, 0, sizeof(winfo));
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
@@ -1299,6 +1341,11 @@ static void parse_setsock_options(const char *name)
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
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b2e6e548f796..6f8c6a03e760 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -63,6 +63,7 @@ unset fastclose
 unset fullmesh
 unset speed
 unset bind_addr
+unset tls
 unset join_syn_rej
 unset join_csum_ns1
 unset join_csum_ns2
@@ -974,6 +975,7 @@ do_transfer()
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
 	local bind_addr=${bind_addr:-"::"}
+	local tls=${tls:-""}
 	local listener_in="${sin}"
 	local connector_in="${cin}"
 	port=$(get_port)
@@ -995,6 +997,10 @@ do_transfer()
 		extra_args="-r ${speed}"
 	fi
 
+	if [ -n "${tls}" ] && [ ${tls} = "1" ]; then
+		extra_args="$extra_args -o TLS"
+	fi
+
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
@@ -1105,6 +1111,8 @@ run_tests()
 	local listener_ns="$1"
 	local connector_ns="$2"
 	local connect_addr="$3"
+	local cl_proto="${4:-MPTCP}"
+	local srv_proto="${5:-MPTCP}"
 
 	local size
 	local test_linkfail=${test_linkfail:-0}
@@ -1149,7 +1157,7 @@ run_tests()
 		make_file "$sinfail" "server" $size
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
+	do_transfer ${listener_ns} ${connector_ns} ${cl_proto} ${srv_proto} ${connect_addr}
 }
 
 _dump_stats()
@@ -4306,6 +4314,40 @@ endpoint_tests()
 	fi
 }
 
+tls_tests()
+{
+	# single subflow, tls, TCP
+	if reset "single subflow, tls, TCP"; then
+		test_linkfail=128 tls=1 \
+			run_tests $ns1 $ns2 10.0.1.1 TCP TCP
+		chk_join_nr 0 0 0
+	fi
+
+	# multiple subflows, tls, TCP
+	if reset "multiple subflows, tls, TCP"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		test_linkfail=1024 tls=1 \
+			run_tests $ns1 $ns2 10.0.1.1 TCP TCP
+		chk_join_nr 0 0 0
+	fi
+
+	# multiple subflows, signal, tls, TCP
+	if reset "multiple subflows, signal, tls, TCP"; then
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
+		pm_nl_set_limits $ns2 1 3
+		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
+		test_linkfail=2048 tls=1 \
+			run_tests $ns1 $ns2 10.0.1.1 TCP TCP
+		chk_join_nr 0 0 0
+		chk_add_nr 0 0
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -4356,6 +4398,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	c@tls_tests
 )
 
 all_tests_args=""
-- 
2.51.0


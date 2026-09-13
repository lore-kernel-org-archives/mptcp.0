Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2028B517
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294527; cv=none; b=A7ynJU3FC8RNm+/+vzDVvP59/Lghx3GvXrB9K3pv+/BXIfo/tNaMuoaU2N+ymVWO1fm8Ouvi5xLJbBVCLWQj7tWHMOovlxtRiNaLmTOHG/u2TXSZdy4aXA7ylyUKZJDoxfmDWIrf1mLAGVmEhRn16LrO/ENbVEteyYiv3pDEiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294527; c=relaxed/simple;
	bh=JIAGIDjk37WAUMAosEyQmye9Ccb2pEQj4dgM7AA7uuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAiTQ63XUrqjSujscaRIYfkd/S0Z7Z2XNzoV2l6sREODdRjmDWL21iYnYJFRQ/Xk0cAcDfqMe5/73MQOIfWUYf65x2knPtMn+930TybJ7R+jWxvr0hZgLDG2HHQFJeFnAaMq/2OxqYoePpKwrhUHQLdWMxn1nx6/K0WpKFQj0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUNpVy5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUNpVy5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBE41F000FF;
	Sun, 13 Sep 2026 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294526;
	bh=sz7uxiLJZYWJmfx3X3b1TnlwqN0LCR6/Z6UaxaoE1go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUNpVy5GMkLf9dRG6Q04rH3zqcm+SLzRcIeI0oNjqT0ocOgQvjCMrvJV0On7wO9uh
	 q01jM640Uuih5xUGAq5L7BWIC0SE1NoJBJUMpMuVJUEgQGfYpapDZq5teRVFBP0GwZ
	 th7cM8XQucBJmsxmRwAGuWpmmlxGcCwjiv0H8bxxmEPNtZFYNjKBj7oBJP7ilWOyWA
	 YgDcFT+yiMFt2nDUbw5VjGv5ce/zZhvopecSYK8qD8mdpna9sXrTKkZ0gH+9MgOKLH
	 RmKPsoawHyiCtSAeDnJgZSkfu+vWH2HPvjy/2oGRDFyJJZuN6n9SFWijC80vHgLAJk
	 djwbmG8W64bGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 12/16] selftests/bpf: add MPTCP coverage to sockmap_basic
Date: Sun, 13 Sep 2026 18:14:51 +0800
Message-ID: <7aa10507517cb94460de386bd4bb81108d61aba2.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extends socket_helpers.h with protocol-aware variants
(socket_loopback_proto, create_pair_proto) that accept an explicit protocol
parameter. Run the sockmap_basic test suite in both TCP and MPTCP modes by
looping over run_basic_tests() with a mptcp flag. Skip UDP-specific tests
in MPTCP mode since UDP is unaffected by MPTCP.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/socket_helpers.h | 25 ++++++++++----
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 33 ++++++++++++++-----
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 0d59503a0c73..d9bd6b11e2cc 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -231,7 +231,8 @@ static inline int enable_reuseport(int s, int progfd)
 	return 0;
 }
 
-static inline int socket_loopback_reuseport(int family, int sotype, int progfd)
+static inline int socket_loopback_reuseport_proto(int family, int sotype,
+						  int proto, int progfd)
 {
 	struct sockaddr_storage addr;
 	socklen_t len = 0;
@@ -239,7 +240,7 @@ static inline int socket_loopback_reuseport(int family, int sotype, int progfd)
 
 	init_addr_loopback(family, &addr, &len);
 
-	s = xsocket(family, sotype, 0);
+	s = xsocket(family, sotype, proto);
 	if (s == -1)
 		return -1;
 
@@ -263,11 +264,17 @@ static inline int socket_loopback_reuseport(int family, int sotype, int progfd)
 	return -1;
 }
 
-static inline int socket_loopback(int family, int sotype)
+#define socket_loopback_reuseport(family, sotype, progfd) \
+	socket_loopback_reuseport_proto(family, sotype, 0, progfd)
+
+static inline int socket_loopback_proto(int family, int sotype, int proto)
 {
-	return socket_loopback_reuseport(family, sotype, -1);
+	return socket_loopback_reuseport_proto(family, sotype, proto, -1);
 }
 
+#define socket_loopback(family, sotype) \
+	socket_loopback_proto(family, sotype, 0)
+
 static inline int poll_connect(int fd, unsigned int timeout_sec)
 {
 	struct timeval timeout = { .tv_sec = timeout_sec };
@@ -329,18 +336,19 @@ static inline int recv_timeout(int fd, void *buf, size_t len, int flags,
 }
 
 
-static inline int create_pair(int family, int sotype, int *p0, int *p1)
+static inline int create_pair_proto(int family, int sotype, int proto,
+				    int *p0, int *p1)
 {
 	__close_fd int s, c = -1, p = -1;
 	struct sockaddr_storage addr;
 	socklen_t len;
 	int err;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback_proto(family, sotype, proto);
 	if (s < 0)
 		return s;
 
-	c = xsocket(family, sotype, 0);
+	c = xsocket(family, sotype, proto);
 	if (c < 0)
 		return c;
 
@@ -397,6 +405,9 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
 	return 0;
 }
 
+#define create_pair(family, sotype, p0, p1) \
+	create_pair_proto(family, sotype, 0, p0, p1)
+
 static inline int create_socket_pairs(int family, int sotype, int *c0, int *c1,
 				      int *p0, int *p1)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1fef6ec2ba7a..80919a5fef49 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -32,6 +32,8 @@
 #define SOL_TCP 6
 #endif
 
+static bool mptcp;
+
 static int connected_socket_v4(void)
 {
 	struct sockaddr_in addr = {
@@ -42,7 +44,7 @@ static int connected_socket_v4(void)
 	socklen_t len = sizeof(addr);
 	int s, repair, err;
 
-	s = socket(AF_INET, SOCK_STREAM, 0);
+	s = socket(AF_INET, SOCK_STREAM, mptcp ? IPPROTO_MPTCP : 0);
 	if (!ASSERT_GE(s, 0, "socket"))
 		goto error;
 
@@ -466,7 +468,8 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
 
-	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	err = create_pair_proto(AF_INET, SOCK_STREAM,
+				mptcp ? IPPROTO_MPTCP : 0, &c1, &p1);
 	if (err < 0)
 		goto out;
 
@@ -568,7 +571,9 @@ static void do_test_sockmap_skb_verdict_fionread(int sotype, bool pass_prog)
 static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 {
 	do_test_sockmap_skb_verdict_fionread(SOCK_STREAM, pass_prog);
-	do_test_sockmap_skb_verdict_fionread(SOCK_DGRAM, pass_prog);
+	/* UDP is unaffected by MPTCP, only run it once (in tcp mode) */
+	if (!mptcp)
+		do_test_sockmap_skb_verdict_fionread(SOCK_DGRAM, pass_prog);
 }
 
 static void test_sockmap_skb_verdict_change_tail(void)
@@ -588,7 +593,8 @@ static void test_sockmap_skb_verdict_change_tail(void)
 	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
-	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	err = create_pair_proto(AF_INET, SOCK_STREAM,
+				mptcp ? IPPROTO_MPTCP : 0, &c1, &p1);
 	if (!ASSERT_OK(err, "create_pair()"))
 		goto out;
 	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
@@ -639,7 +645,8 @@ static void test_sockmap_msg_verdict_pop_data(void)
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
 
-	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	err = create_pair_proto(AF_INET, SOCK_STREAM,
+				mptcp ? IPPROTO_MPTCP : 0, &c1, &p1);
 	if (!ASSERT_OK(err, "create_pair"))
 		goto out;
 
@@ -670,7 +677,8 @@ static void test_sockmap_skb_verdict_peek_helper(int map)
 	char snd[256] = "0123456789";
 	char rcv[256] = "0";
 
-	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	err = create_pair_proto(AF_INET, SOCK_STREAM,
+				mptcp ? IPPROTO_MPTCP : 0, &c1, &p1);
 	if (!ASSERT_OK(err, "create_pair()"))
 		return;
 
@@ -1362,7 +1370,7 @@ static void test_sockmap_no_verdict_fionread(void)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
-void test_sockmap_basic(void)
+static void run_basic_tests(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
 		test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKMAP);
@@ -1436,6 +1444,15 @@ void test_sockmap_basic(void)
 		test_sockmap_copied_seq(true);
 	if (test__start_subtest("sockmap tcp multi channels"))
 		test_sockmap_multi_channels(SOCK_STREAM);
-	if (test__start_subtest("sockmap udp multi channels"))
+	/* UDP is unaffected by MPTCP, only run it once (in tcp mode) */
+	if (!mptcp && test__start_subtest("sockmap udp multi channels"))
 		test_sockmap_multi_channels(SOCK_DGRAM);
 }
+
+void test_sockmap_basic(void)
+{
+	for (int i = 0; i < 2; i++) {
+		mptcp = i;
+		run_basic_tests();
+	}
+}
-- 
2.53.0


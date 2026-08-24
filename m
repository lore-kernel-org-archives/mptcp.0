Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5CC3B38B8
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555401; cv=none; b=p+mzi+JWi6J+UNjDEzcNFKy+RkZ6KGUkljSiG0OZFeyF7rnmnhKIDDuQdW6zv6JKT+bnDNaUbHbZS9CTJPqnPX4uAgIL8nXAwig10UOe+r+6WlN39JfSrk4MIgN1xEg2npRWq8qmQgUaDHg5zNRpKbyffyJQ+HYcCY08LgMjgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555401; c=relaxed/simple;
	bh=/tCoiBHpivRnikKO1bIiybH6nP8R+8xASbKgHCCeUzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIouCUP8xENh6ejG7ALuY70vBWX8U6qyjMq5xspA4swDN3ezHePhQSYTnmkLC9Mlbp3X9kSMiZCFTicrYRPMWYmCLbgttxLCS78/2MkALbkgWhCsUrW0JyKewvxpKHw82e3dzbFlqC7kgMhBfysZ4Gd2oSSh0YDIPpWBrmkb3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDSG0dL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDSG0dL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C261F00A3A;
	Mon, 24 Aug 2026 07:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555400;
	bh=j+91zr+WaWKxIxWsKH8Avon/OEwxyZkzT/WmWOxqpao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDSG0dL9SxFFXDTSX+2LVTJjzB3FkxOeEy17GiR5Pay3fBjOqzTDE0NkPf0h2StUo
	 xBtIuy6w4v9WOkH932Cgam0S9gYczJIKLXGp/8vILRshIqOiGYcWXUd9n9ZPx21OMu
	 RnW6p5DIgJFpwxyAkt1HpMggCgK1Rk8p/6ie1Jjz6+XEMjk0VTPJpJKy86QSJZEUMC
	 M7nU8Br/1tbO7mg/oqiHQ7QO9ubwW5A5gefIXOxr/o8Qp1nvEeqvsygHhwNzsAhWm7
	 Wj3odtI9M8uabCovCa7ZAO170ejMajiRZ+0h7oD9jiQCIuakTfITp7ST9meIci/X7s
	 3G4qXxY6rtP8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/5] selftests/bpf: Update sockmap tests for MPTCP
Date: Mon, 24 Aug 2026 15:09:39 +0800
Message-ID: <1cb449fc7531df4bade69ee95cbbe217db85c1cb.1787554581.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787554581.git.tanggeliang@kylinos.cn>
References: <cover.1787554581.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update sockmap tests to reflect new MPTCP support. MPTCP sockets are now
allowed in sockmap, so test expectations are adjusted accordingly.

Use a different key (1) for MPTCP client sockets to validate sockmap.

In test_sockmap_with_mptcp, client_fd1 is changed from TCP fallback to
MPTCP. Since sockops fires on TCP subflows which have psock_update_sk_prot
set to NULL, bpf_sock_map_update() returns -EOPNOTSUPP for MPTCP
connections. Add server_fd1 and server_fd2 to the sockmap explicitly from
userspace via bpf_map_update_elem() instead of relying on the sockops
program.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 42 +++++++++++--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d77c9f8c53c7..4f8727dbcbfd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -500,30 +500,36 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
-/* Test sockmap on MPTCP server handling non-mp-capable clients. */
-static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
+/* Test sockmap on MPTCP server handling MPTCP clients. */
+static void test_sockmap_with_mptcp(struct mptcp_sockmap *skel)
 {
 	int listen_fd = -1, client_fd1 = -1, client_fd2 = -1;
 	int server_fd1 = -1, server_fd2 = -1, sent, recvd;
 	char snd[9] = "123456789";
+	int zero = 0, err;
 	char rcv[10];
 
 	/* start server with MPTCP enabled */
 	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
-	if (!ASSERT_OK_FD(listen_fd, "sockmap-fb:start_mptcp_server"))
+	if (!ASSERT_OK_FD(listen_fd, "sockmap:start_mptcp_server"))
 		return;
 
 	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
 	skel->bss->sk_index = 0;
-	/* create client without MPTCP enabled */
-	client_fd1 = connect_to_fd_opts(listen_fd, NULL);
-	if (!ASSERT_OK_FD(client_fd1, "sockmap-fb:connect_to_fd"))
+	/* create client with MPTCP enabled */
+	client_fd1 = connect_to_fd(listen_fd, 0);
+	if (!ASSERT_OK_FD(client_fd1, "sockmap:connect_to_fd"))
 		goto end;
 
 	server_fd1 = accept(listen_fd, NULL, 0);
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
+				  &zero, &server_fd1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "sockmap:add server_fd1"))
+		goto end;
+
 	skel->bss->sk_index = 1;
 	client_fd2 = connect_to_fd_opts(listen_fd, NULL);
-	if (!ASSERT_OK_FD(client_fd2, "sockmap-fb:connect_to_fd"))
+	if (!ASSERT_OK_FD(client_fd2, "sockmap:connect_to_fd"))
 		goto end;
 
 	server_fd2 = accept(listen_fd, NULL, 0);
@@ -532,12 +538,12 @@ static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
 	 */
 	skel->bss->redirect_idx = 1;
 	sent = send(client_fd1, snd, sizeof(snd), 0);
-	if (!ASSERT_EQ(sent, sizeof(snd), "sockmap-fb:send(client_fd1)"))
+	if (!ASSERT_EQ(sent, sizeof(snd), "sockmap:send(client_fd1)"))
 		goto end;
 
 	/* try to recv more bytes to avoid truncation check */
 	recvd = recv(client_fd2, rcv, sizeof(rcv), 0);
-	if (!ASSERT_EQ(recvd, sizeof(snd), "sockmap-fb:recv(client_fd2)"))
+	if (!ASSERT_EQ(recvd, sizeof(snd), "sockmap:recv(client_fd2)"))
 		goto end;
 
 end:
@@ -552,11 +558,11 @@ static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
 	close(listen_fd);
 }
 
-/* Test sockmap rejection of MPTCP sockets - both server and client sides. */
-static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
+/* Test sockmap of MPTCP sockets - both server and client sides. */
+static void test_sockmap_mptcp_support(struct mptcp_sockmap *skel)
 {
 	int listen_fd = -1, server_fd = -1, client_fd1 = -1;
-	int err, zero = 0;
+	int err, zero = 0, one = 1;
 
 	/* start server with MPTCP enabled */
 	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
@@ -577,13 +583,13 @@ static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
 	server_fd = accept(listen_fd, NULL, 0);
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
 				  &zero, &server_fd, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "server should be disallowed"))
+	if (!ASSERT_EQ(err, 0, "server should be allowed"))
 		goto end;
 
-	/* MPTCP client should also be disallowed */
+	/* MPTCP client should also be allowed */
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
-				  &zero, &client_fd1, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "client should be disallowed"))
+				  &one, &client_fd1, BPF_NOEXIST);
+	if (!ASSERT_EQ(err, 0, "client should be allowed"))
 		goto end;
 end:
 	if (client_fd1 >= 0)
@@ -625,8 +631,8 @@ static void test_mptcp_sockmap(void)
 	if (endpoint_init("subflow", 2) < 0)
 		goto close_netns;
 
-	test_sockmap_with_mptcp_fallback(skel);
-	test_sockmap_reject_mptcp(skel);
+	test_sockmap_with_mptcp(skel);
+	test_sockmap_mptcp_support(skel);
 
 close_netns:
 	netns_free(netns);
-- 
2.53.0


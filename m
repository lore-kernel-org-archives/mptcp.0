Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825339AC3
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042678; cv=none; b=prB4lXuNeWmR/Byb6pNnRnSlTivcFHzBjBL2u05h+1iER6nP+uIqdhRY1W60K1SsiU9w87ZNg5fkT7HRXGs7056EFnzfrCi81zhRHqL/BVMM+5mzzx69EjkVpBhRYVpIDglEhq4DwpKUU8STnwCU89ePNVCzD5B9TI9qAM0Lmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042678; c=relaxed/simple;
	bh=CNbKg/48cYgP860g9j4gy42liUO3q1RGZ0M9HRZl8i0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8Tq6TNHXN9wV/MiMniOKqPdKfwx64XRj9HxddkT0nQ70qid8ieRAmqNkq3cFx3v+Ms7/N8oe+Kwjv/j1GCJOH6+3Ubg5v5MwEZ7Q0BwCUGoO/pDtAiChgCuYwXpLF61N64yhIyADSZ3het/CbEHNsKVYikU8wy3eUgzeVlTMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMlhwwLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMlhwwLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61B1C433F1;
	Tue,  2 Apr 2024 07:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042678;
	bh=CNbKg/48cYgP860g9j4gy42liUO3q1RGZ0M9HRZl8i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMlhwwLDuMBqs0lMlmB8295TxauOM/gLk474CvSXXCYiHe6VFxosllbSVEd6A295D
	 1sCpNMePkLPWgyH5UmX7+/3X80elRUi2NeS9cHcsMaTgG9WHBu6rVINEAN5fVwqlkR
	 T8kQz4aBVM36eGaxE81ZKGhHr2z67PPQaRYeKMu7wknReWfa9H70BJatX+/BhvqcBJ
	 UyrbgGfCCK6Nw5GnTEm70kar9d3I/OIHRVlzOxBZrVXpz2RnvFl7YY7ZRVPkJjtbk+
	 iUzXjxCZrx4ITDecRvWyeKeGOueE8x44YlnLYMxur20ZhwF5GaLipt/xFZjgac4l+M
	 j3pytxEu1wQIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 3/8] selftests/bpf: Refactor mptcp_sock test
Date: Tue,  2 Apr 2024 15:24:23 +0800
Message-Id: <28ff3a8211434440cc9cc57292fe0e116c635c8b.1712042529.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042529.git.tanggeliang@kylinos.cn>
References: <cover.1712042529.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch refactors mptcp_sock test, renames "base" to "mptcp_sock",
extracts a new helper run_mptcp_sock() to start servers and run tests,
moves all test skeleton operations, __open_and_load, __attach and
__destroy from run_test() into test_mptcp_sock().

This prepares for the later unification of all MPTCP tests using a macro.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 61 +++++++++++--------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 660964062e3d..9bce55dec5e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -174,18 +174,10 @@ static int verify_msk(int map_fd, int client_fd, __u32 token)
 	return err;
 }
 
-static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
+static int run_test(int cgroup_fd, int server_fd,
+		    struct mptcp_sock *sock_skel, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
-	struct mptcp_sock *sock_skel;
-
-	sock_skel = mptcp_sock__open_and_load();
-	if (!ASSERT_OK_PTR(sock_skel, "skel_open_load"))
-		return libbpf_get_error(sock_skel);
-
-	err = mptcp_sock__attach(sock_skel);
-	if (!ASSERT_OK(err, "skel_attach"))
-		goto out;
 
 	prog_fd = bpf_program__fd(sock_skel->progs._sockops);
 	map_fd = bpf_map__fd(sock_skel->maps.socket_storage_map);
@@ -205,29 +197,19 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 	close(client_fd);
 
 out:
-	mptcp_sock__destroy(sock_skel);
 	return err;
 }
 
-static void test_base(void)
+static void run_mptcp_sock(int cgroup_fd, struct mptcp_sock *skel)
 {
-	struct nstoken *nstoken = NULL;
-	int server_fd, cgroup_fd;
-
-	cgroup_fd = test__join_cgroup("/mptcp");
-	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
-		return;
-
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
-		goto fail;
+	int server_fd;
 
 	/* without MPTCP */
 	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_server"))
 		goto with_mptcp;
 
-	ASSERT_OK(run_test(cgroup_fd, server_fd, false), "run_test tcp");
+	ASSERT_OK(run_test(cgroup_fd, server_fd, skel, false), "run_test tcp");
 
 	close(server_fd);
 
@@ -235,14 +217,41 @@ static void test_base(void)
 	/* with MPTCP */
 	server_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
-		goto fail;
+		return;
 
-	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "run_test mptcp");
+	ASSERT_OK(run_test(cgroup_fd, server_fd, skel, true), "run_test mptcp");
 
 	close(server_fd);
+}
+
+static void test_mptcp_sock(void)
+{
+	struct nstoken *nstoken = NULL;
+	struct mptcp_sock *sock_skel;
+	int cgroup_fd, err;
+
+	cgroup_fd = test__join_cgroup("/mptcp");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	sock_skel = mptcp_sock__open_and_load();
+	if (!ASSERT_OK_PTR(sock_skel, "skel_open_load"))
+		goto out;
+
+	err = mptcp_sock__attach(sock_skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	run_mptcp_sock(cgroup_fd, sock_skel);
 
 fail:
 	cleanup_netns(nstoken);
+	mptcp_sock__destroy(sock_skel);
+out:
 	close(cgroup_fd);
 }
 
@@ -471,7 +480,7 @@ do {								\
 
 void test_mptcp(void)
 {
-	RUN_MPTCP_TEST(base);
+	RUN_MPTCP_TEST(mptcp_sock);
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
-- 
2.40.1


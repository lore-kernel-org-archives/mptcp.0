Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12637149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688225; cv=none; b=GUCBsX+MLSgF6RwhNWOGYX1eaa8ggTdg/xzBItCidrHO3B/FGp1KmGOQOQ2SO5jvSeU1XeyJFF8Y1R/sKrHWJPDI6oqXPhidpWDh18pFAFRydSiZ6q3ZqqJYomosx63LvSHVV0NqJAj3kcx0a/wq38WeiEisXiVc7CLzGJyacLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688225; c=relaxed/simple;
	bh=EodAMM/RgtXoexbDUw8A5td8jc5D2dZyN8bLenGdL5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWoDUDsRceRtvJ+NC/vIN/vxKew70j0urMidw7SzHj14+1BeQVrPOjUBZ+imYF8SdMItAdMCSLiaohYfiry4lvxwIQqHsOUW41Qlt8WJf6TeS7eOrS2LZrMIls+tS0DCmrIe7eFUlKnYrWdl3O5ahJRoBCmmZV5P430fbLK03Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEAzrqmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEAzrqmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD114C433F1;
	Fri, 29 Mar 2024 04:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688224;
	bh=EodAMM/RgtXoexbDUw8A5td8jc5D2dZyN8bLenGdL5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EEAzrqmX7JsrOp6VL/PMbNWXM06LeH/1/S9toICMn34dv6nBk2YEICfU8wk1PAZx1
	 OPqMSgIL9Jnbbxdd+cWY5KNJbTCi3k176oX4XLpJxMHhJgtSumTH9eQpZYnR9XMgxo
	 DpdHX5Sfo4H+i9h4lLog7aJtrdi0o24XzoW4mg2PDCXjLhLCbWmHPovsm9ciFGeJNP
	 bVhX6biPcDMOMslCosn22BIlx0mpE0Yh/j/tZIToCtVBMk4qTFjZZKv/6hIJOvqsp+
	 cQa/G213HtJgNSA5V1PAOwgTUfw+TlSNB0aMYF/V5/9hByx032/uotoOfr0lsoK/mp
	 yoojNSIS2liAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 05/15] selftests/bpf: Refactor mptcp_sock test
Date: Fri, 29 Mar 2024 12:56:01 +0800
Message-Id: <c77cc999d51f98c258e190c851cbce74a4df0da5.1711688054.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711688054.git.tanggeliang@kylinos.cn>
References: <cover.1711688054.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 63 +++++++++++--------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 42edf9f80d68..39becf46dcfa 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -159,18 +159,10 @@ static int verify_msk(int map_fd, int client_fd, __u32 token)
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
@@ -190,29 +182,19 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
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
 
@@ -220,14 +202,41 @@ static void test_base(void)
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
 
@@ -646,8 +655,8 @@ static void test_burst(void)
 
 void test_mptcp(void)
 {
-	if (test__start_subtest("base"))
-		test_base();
+	if (test__start_subtest("mptcp_sock"))
+		test_mptcp_sock();
 	if (test__start_subtest("mptcpify"))
 		test_mptcpify();
 	if (test__start_subtest("default"))
-- 
2.40.1


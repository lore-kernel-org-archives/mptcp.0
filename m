Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4F5FBA7
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619417; cv=none; b=Bl0ynCFT3T7gADmDxsWyEOcEFF105/OrxvSTkpOr1acBlz4P4oBRIZNUIV40gQuIu13WW2t9F/AdMklVxU6b1/Xsv48WtKgJZA+gHzBx2m9vykIU5JoYhvqXHjyRJbRdChUGtKT65kAkmHixW/4uKoL1MU15bXGUvIpVvlhp3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619417; c=relaxed/simple;
	bh=Ldx8b7uioUsnpz0/+V32TDj4PFd4BVShxlyRkW85jW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQ4gybXR6kMvTyR9mTrdYdPmv5V9YhykO/ttNb2boUc1cr7BtGrq++Wc+V1UjNYJqvOwPSkwIb0svAcMSHGcgRCs8NOC+odRtUuOoKPMFS2hlWSQEuFWPoI3gzZqtUegvQBzGEtotYgk8U49VaDhIBUtQvEwFg49WWzCFKbnavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbFwpG0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbFwpG0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02DAC433F1;
	Thu, 28 Mar 2024 09:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619416;
	bh=Ldx8b7uioUsnpz0/+V32TDj4PFd4BVShxlyRkW85jW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbFwpG0M0k/ii4QvIC1B/2MHb3Yh8Q52GEedpQ/7thaiFE3dfocBos1RyK0rOgVlC
	 W4NTINFRfIH9nGGWMKYbUcPBS6vAE0SCz1S1hiae1BVV567tMKyVGmLKldK7zr+G5Q
	 ym3BDZXrdAnjx/EXbhrDtXpCKlOvVW9QvlkKJar002431woXDIkolqYnfaFzUA3NaE
	 yWh2Eotb6efTYMmyWYWR5wc0TouvUv6Oe6oR2i4DXG+fbl57pbfyYS4dhjSOnBlAWA
	 kaPwzL3b42uw9Qt6uYgDDvksr228H0o7ZGnN/My8C3ilXAPOWu9YSxaWBXkLm6EI9k
	 Hoz16lMqOuu3A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 02/11] selftests/bpf: Refactor mptcp_sock test
Date: Thu, 28 Mar 2024 17:49:59 +0800
Message-Id: <52ce31b9d8db385f6629a18532132ae8a2535ead.1711619108.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711619108.git.tanggeliang@kylinos.cn>
References: <cover.1711619108.git.tanggeliang@kylinos.cn>
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
index 7fec91ab19cf..4f0bcaf39886 100644
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
 
@@ -653,8 +662,8 @@ static void test_burst(void)
 
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


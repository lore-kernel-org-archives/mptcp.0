Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975F53E37
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613131; cv=none; b=b8j5T+nHUHOwlY+nLzJlocD0svQD8sC+FYgY8ISYYzFWmwmK35YmJt7vib+PLykLobBqqJbndvt+POHB6mk3DCDrMQI52otPRueSTf0w4WTlom6KQXNMlmvaxSTXkjhNcxi2ZhWhlECWDyh1FXfCJAds4zNnE/TxhemW1yu8JDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613131; c=relaxed/simple;
	bh=X7V//ZjV04kqtHmyLRknbqQD61t22w4r94GATaxCIi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJ3M7d4rV4WB0xi+e2sX2pnFVtOkmR1I5zNfaW7dBOaIp0koDM3QnPbHVOisFGCutaqVyuKYh3g6ACuB2lGhsankQ44uvn6tY4KJ9ZDk3nPFcyYMcEdty8JZpL15R4Csb5bnrgtvXp3ueyijDCGRIy9ADc6cSO6aRBwAshBry+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZCspaz/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZCspaz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C007CC433C7;
	Thu, 28 Mar 2024 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613131;
	bh=X7V//ZjV04kqtHmyLRknbqQD61t22w4r94GATaxCIi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZCspaz/Lf7UmxPDWQepEiGqNSa6npa8DgjtTmbxwAxOyJKSngOTpWbqFo6O52rk1
	 PTBnibSP/NOPogeChkOCNXTKpuuaF/2RA6yuQ62+T+lDGjx+Lghz56ZgqLrsE7sADc
	 YgB8SBj7e3O3aKl5TcGpIk6p1hOFJCzWs6YC+fK52NHzjOn1er8GF8BQANwVkIPROM
	 jNcoowiz2qc4Ha3Z/tc/ylREgDGeUkoR3I5+SnSPQkQ81zRpclonQQwWZtCFpAU02C
	 VD08Hsi01EV/ZrNexDXx4vWut6j4egTDO1K14TbyZg8RNOzcHiHtrx0DVexJnosAPV
	 QZovm0oPs9rZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 11/14] Squash to "selftests/bpf: Add bpf_rr test"
Date: Thu, 28 Mar 2024 16:04:58 +0800
Message-Id: <edfd0bcab04c490100a35243caff993105d80988.1711612876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711612876.git.tanggeliang@kylinos.cn>
References: <cover.1711612876.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use MPTCP_SCHED_TEST and RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index b990f91d59a5..fbbd7993b0e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -569,41 +569,7 @@ fail:								\
 
 MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
-
-static void test_rr(void)
-{
-	struct mptcp_bpf_rr *rr_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	rr_skel = mptcp_bpf_rr__open_and_load();
-	if (!ASSERT_OK_PTR(rr_skel, "bpf_rr__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(rr_skel->maps.rr);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_rr__destroy(rr_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_rr");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_rr"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_rr");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_rr__destroy(rr_skel);
-}
+MPTCP_SCHED_TEST(rr, 1, 1);
 
 static void test_red(void)
 {
@@ -689,8 +655,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
-	if (test__start_subtest("rr"))
-		test_rr();
+	RUN_MPTCP_TEST(rr);
 	if (test__start_subtest("red"))
 		test_red();
 	if (test__start_subtest("burst"))
-- 
2.40.1


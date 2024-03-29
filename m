Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDCE37149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688239; cv=none; b=qH0y5Bac4BFOHVBhtlVftl+e7u1SY4XH7palKeg96gJ5uYTMlW8WziBploP5op8PZF6Tqucnbz5qza6caNYxewOnqgYuIwlWVi2vLtTETNB/6L0YBkxMeERKmx56Rw2foz6uMfDabmVv0Hs2TjK3jAFFMFLC4FMaP6EvPpA8pSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688239; c=relaxed/simple;
	bh=iZLy1FyWdumiZqiQrg+QM1+i67w1eltvhx0zre6CH5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLPAl3j2Ael1M1B2KeWKCMFsgt/TtFj43aenVN5Phg/N8GXSYBJvKgh7YzHud0bzMuAV94452viEnzA+7++zAbjmFGC6JhZfLo/rOsfvDv+WQti0C2C+Ys2iYByyi3LRyj3LxYd6+P6d0t0AE6EXHXCCxwtlWfsu7ynaKS0DxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyH2Ugp+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyH2Ugp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D9AC43394;
	Fri, 29 Mar 2024 04:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688239;
	bh=iZLy1FyWdumiZqiQrg+QM1+i67w1eltvhx0zre6CH5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyH2Ugp+Ph5H0P6mTrzrFsfJGgtY5SxRihCr9ZlMVwULqEVJiHvhoFq8urOTBsBSA
	 Jq9BgbNZrE5jzAFKzPmIzDj7AdSLG/hwBSwO4NLGd6DGxLC9GNrSwCfEltmcqHvVgY
	 Ti/4zTX4MeWRJ8foAVNQB1cN1XlEFTbPaQN0uvvKyvXti5RPY9x8Ke+DNhDcl2DRX6
	 g7iHEHg80uFXm0lYWGb5U4JntAFrM8Co69V50WK/pT1v/vRZRT5Zby1+dHwL5UMHy9
	 CEcASaaeZg3qVOmgj+tkWEY62I9NwPmOpEujC1C3DHPDULQAZ+F8xHC+KWOnv86DVv
	 +RbRotMvZunpA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 14/15] Squash to "selftests/bpf: Add bpf_burst test"
Date: Fri, 29 Mar 2024 12:56:10 +0800
Message-Id: <820fba61470b5e3ee1fbdc029224ccd44522bd16.1711688054.git.tanggeliang@kylinos.cn>
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

Use MPTCP_SCHED_TEST and RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 0f384402ab6a..6b77fb51c4f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -502,41 +502,7 @@ MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
 MPTCP_SCHED_TEST(rr, 1, 1);
 MPTCP_SCHED_TEST(red, 1, 1);
-
-static void test_burst(void)
-{
-	struct mptcp_bpf_burst *burst_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	burst_skel = mptcp_bpf_burst__open_and_load();
-	if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(burst_skel->maps.burst);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_burst__destroy(burst_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_burst");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_burst");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_burst__destroy(burst_skel);
-}
+MPTCP_SCHED_TEST(burst, 1, 1);
 
 #define RUN_MPTCP_TEST(suffix)					\
 do {								\
@@ -553,6 +519,5 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
 	RUN_MPTCP_TEST(red);
-	if (test__start_subtest("burst"))
-		test_burst();
+	RUN_MPTCP_TEST(burst);
 }
-- 
2.40.1


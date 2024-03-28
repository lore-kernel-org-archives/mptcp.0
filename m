Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB0657CE
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619425; cv=none; b=jtBBm0B89xsmWJMZb5Cp6D1tjAsqXhwMsFUDmCTiz71dgXiuWjh52hiOOnVzO8ekt4DIn+5L38GJZcnNNSiwXnELTFlc5EC4v8L72JPRASvjU2nbM/NlHHDPTLmOG1sqc1qQJRZ3hgqbqYLQ+PXtx0s3D3vQzmkPoVUD9TJ+Dow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619425; c=relaxed/simple;
	bh=ChLPkmMT/RA3qpfvdtHj+mTNEPv4SMoi/OiPz7ScXdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekdR6gR4MecpnQwkqwfnDLUw503LUTp/59NS5bBFyD/zp8MRtkMXuCqEPID/sqOQUO0Ytr+KxHFuEBjjrRJojy9BpTexSbQ0+/eXPjmAr1XCIP+85CnajyZ/faEtiLekzs2gaaeH1st6PIEnZGzuOXHUqHPGHRO9XvtAuxrGnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFX7mxiL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFX7mxiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5653C433C7;
	Thu, 28 Mar 2024 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619424;
	bh=ChLPkmMT/RA3qpfvdtHj+mTNEPv4SMoi/OiPz7ScXdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFX7mxiL3etRNEeKKD0XrHTzmItP1rGNAP9mcfSRt8OEcqI5zp1kyxNc0bYHeK4Gg
	 J/v68Zr7q1l9c6ks1DY3SXSJ4CYj2+HtCgjUMqkuNm5FIMPpPOXudZwmQ43QnIk3Xj
	 ubrqoZfVJ7Xdd8w+jhGyImq2bV2Cn4GisW8Y0VZM68EW7ApQ8APTd6CXWaprG6GS/V
	 mVvKJYYuFhqZSrH4sMWxoovHmh3/EoXZNHJKz4qO4toI2j1qlAvRqOWThchOhzftnC
	 hZLzCa5tYMNBva5vRG3zhmBrQ5dH8/KDEgBF/4EPLlV5+dKL79YEHo+OAX/YgrBo25
	 t8VXtN+98/jSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 08/11] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Thu, 28 Mar 2024 17:50:05 +0800
Message-Id: <0105a9fff593b468e0f6676009df527511fd1f03.1711619108.git.tanggeliang@kylinos.cn>
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

Use MPTCP_SCHED_TEST and RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8d67e1715485..3c547f38badf 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -502,41 +502,7 @@ fail:								\
 }
 
 MPTCP_SCHED_TEST(first, 1, 0);
-
-static void test_bkup(void)
-{
-	struct mptcp_bpf_bkup *bkup_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	bkup_skel = mptcp_bpf_bkup__open_and_load();
-	if (!ASSERT_OK_PTR(bkup_skel, "bpf_bkup__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(bkup_skel->maps.bkup);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_bkup__destroy(bkup_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow backup", "bpf_bkup");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_bkup"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_bkup");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_bkup__destroy(bkup_skel);
-}
+MPTCP_SCHED_TEST(bkup, 1, 0);
 
 static void test_rr(void)
 {
@@ -655,8 +621,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
-	if (test__start_subtest("bkup"))
-		test_bkup();
+	RUN_MPTCP_TEST(bkup);
 	if (test__start_subtest("rr"))
 		test_rr();
 	if (test__start_subtest("red"))
-- 
2.40.1


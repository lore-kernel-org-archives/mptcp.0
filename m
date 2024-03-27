Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70661EEFD
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530135; cv=none; b=IC85pB3outQxQtFT2RiLY+avAeQQCrGTB4V0+sotfOWIC/j8iyqDYaFirwoLk5S95LjdJT5uXPo9rfEdh2c9UimNPf9UjBGSQAjNO0JQfM7cY/fpehR2Ya60WeOiFafjqSlNkNyKtmU1aQ8fDVXL4UMryacjv1GFGQ/QyoHHRmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530135; c=relaxed/simple;
	bh=duYDBXiKNHmzjjxLqarX3Z1TW568+L2U+ZqkY/JRoWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYKOwWw6+Et9MhKS4Gm3B2+xWdzFUov9py3B/qAxVoitkXOyBFMTf0/LPycQPfG1O6mjSaMpnBElRRR014vxCMgMALMHKhU8CtcAz81s3l+nD8r/E1hEWAgoFcSKfLEiMQuRgtxmEEiWa9fJHUwqvPrtsGH3Vt3UvAHwK6bMTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScUlnkFe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScUlnkFe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C46C433F1;
	Wed, 27 Mar 2024 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530135;
	bh=duYDBXiKNHmzjjxLqarX3Z1TW568+L2U+ZqkY/JRoWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScUlnkFeNTV4dOqUyhaLNFBNTiYwOAunOWZPn+UY5sG1GfBBuaxmkEYP0/pxmX6bz
	 i0/UkvmmjHUNDOhZVbK3Xas10hEoP6wdFRS+tXvYybNGj4PwImFFdd1fxKJypKWP9F
	 51K8+nhvjSI66xqWfYCAazX5ng77JWurCi5MigpfAnkvNwzgKzmyc99moy5qDSC6Vl
	 xaU+vU4TgAZLkq77358ZfpXJ0N3ury5HhJdJxVIPAQadFfG1ZMvlMPTqEA+/9KMmu0
	 wg94Ja+0RcvdGIrd5SOXVQAbSrKONA1a+/pz0yCBAAI3Pjezh+jP1hzEk51gmQTgJb
	 9EmkPpm3wBZJw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 09/11] Squash to "selftests/bpf: Add bpf_rr test"
Date: Wed, 27 Mar 2024 17:01:47 +0800
Message-Id: <4090340ecf4974c2f9936e5077a8d8d4141f78d7.1711529752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711529752.git.tanggeliang@kylinos.cn>
References: <cover.1711529752.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use SCHED_TEST and RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7ccc63ee763b..f7afb5e4b687 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -605,41 +605,7 @@ fail:								\
 
 SCHED_TEST(first, 0);
 SCHED_TEST(bkup, 0);
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
+SCHED_TEST(rr, 1);
 
 static void test_red(void)
 {
@@ -725,8 +691,7 @@ void test_mptcp(void)
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


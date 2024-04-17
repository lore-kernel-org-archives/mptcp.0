Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999B1851
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321557; cv=none; b=RyOdGgoUhfLWKDp9FC+laorzk5YhMG8BVYhDMdOHXH9DvgmTvyLYAAp/wV6xf/GTEb5VSI0BKu1hdR/g+X4RAXWoS6mY4Hwz4+fTWEPDBtvKY5fgFJG9ettDHCbexjtFVfmIT2fCYmvvMgb2LPYNRymqAwnSY9bfNvEKe13pzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321557; c=relaxed/simple;
	bh=CYvBcaz4Hucd9sxuqWqujKimRltU3jV6zOzlfnI8L9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acrCjWAC1xLJibO2rgAjcmDHp19kAAjGbC7DIrY99OaW7TsuBdw5cRgm5MndGZuELW6OMT8qSXdrpTtj2JkzS37ewHFcOpU4B4UDrL+YceLsNR7/AiPn4VtVezvLG8jAcULg53b/m86/zEhUiCi1uR7ozIhJ8AIbM/bCdfYwey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcKcGrLS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcKcGrLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D16C113CE;
	Wed, 17 Apr 2024 02:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321557;
	bh=CYvBcaz4Hucd9sxuqWqujKimRltU3jV6zOzlfnI8L9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcKcGrLS4qOTHDdsiOkPRF+168OSrZRVA5QZf5gZuhB1ohQusRtQDiZEVTgb9uazQ
	 ex2J5yUqWIDMbEvtL3+cSzjSD1v5FMWoQrLZSRUC+NXOCfrcYLWnjC2aQ76GRC2kz6
	 m1w5Y2XypQiam5V2VZ9nFl8gVId9tw3Y/+woA3AOIgu9lZIRIDR3KuDdQH47qVBlV9
	 UdMP0yiPg38cIPB4FY9dD99O1FK99YYNplUjSus/cJpwrSeq2rhyhMRo5expcK4wU+
	 /FH16IwGpreEeaGQUZSh++kQArVfNFVFAxSJHQBNYC5d05S2pAArUHX4MOqmeJ4+dk
	 SxxEwjmEYvvqw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 5/8] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Wed, 17 Apr 2024 10:38:51 +0800
Message-Id: <fc88fcb1ed4a26c6576d1b6d4c5035e98d7be460.1713321357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713321357.git.tanggeliang@kylinos.cn>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After squashing into this change, the patch "selftests/bpf: Add bpf_bkup
test" can be merged into the patch "selftests/bpf: Add bpf_bkup scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_bkup
scheduler, the arguments "1 0" means data has been only sent on the
first subflow ADDR1. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_bkup scheduler & test".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 504e00faf9e0..a49328648eca 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -539,41 +539,7 @@ static void test_##sched(void)					\
 }
 
 MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
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
+MPTCP_SCHED_TEST(bkup, WITH_DATA, WITHOUT_DATA);
 
 static void test_rr(void)
 {
@@ -692,8 +658,7 @@ void test_mptcp(void)
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


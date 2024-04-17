Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE741851
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321559; cv=none; b=oswrns+406rdsLzUPH5bYWSaLsQVew/c4QymU5uMZYOeLKnCEvF9lmrIFcfah2TBu9wp1ZybzvHXXDnyum6W3rSoWPuh+Vynp9RE+8gYkvP7d9t2RulHWFQeT9Dnt368DNnH4t1Xdypqq8D4x4++rawxQTGsh2qxfLQ3ht36erg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321559; c=relaxed/simple;
	bh=A5ugH1BJpRXacre85Wfd0jJ0NKzkMRYY3zBmD0b7tCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nS+00rzM2Qjs+adxpjpWlNf79/14nsAAr/Rl1UoliJvcBYkkOzqscKQuTb4jMjIrCEejotE2TF7rAYf8sXzi0s9dnoovuNJKTob4WRUkGTi5AJA9U3s1vqSoKj1M2EKpZ1xi4TNPooacypRirmkkDQnn4IC1r5iBrU6vzCqoP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpUlbOiF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpUlbOiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C11C3277B;
	Wed, 17 Apr 2024 02:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321559;
	bh=A5ugH1BJpRXacre85Wfd0jJ0NKzkMRYY3zBmD0b7tCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpUlbOiF4vHf3HY+wLgTwQA6Xtijm88+wY/roT7gOBp0YuyeQbR2M532F2ukzdGL8
	 FYwOJrzHinuVapUOkFMQjFTVxgIO2gWxQ8GG4PrMhf8ytItCEn21DAohiXPi8NJ8Q5
	 Eu9S6cGPHgnEapvq8Hz2+bTpzhBitC9r9eRZIQXhxIOEMyPR5ZEP17DlIer4WTBDN+
	 67cMd8y1boc43U4kzRFgBmOPz6MwiiwzVtsvKvoJ6SnflTpb2N0fB6K738JVVHWmdT
	 OeP14O5d2T0D+VslEI1L21tWq7hINgNf6GwGYaNh2z0AFAI7u0aNhzgDO18MS3Pw11
	 2BbfCw7GFXH9g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 6/8] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Wed, 17 Apr 2024 10:38:52 +0800
Message-Id: <039e6bd74d49229b2a87d002e0cf4606c4d09683.1713321357.git.tanggeliang@kylinos.cn>
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

After squashing into this change, the patch "selftests/bpf: Add bpf_rr
test" can be merged into the patch "selftests/bpf: Add bpf_rr scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_rr
scheduler, the arguments "1 1" means data has been sent on both
net devices. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_rr scheduler & test".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a49328648eca..6b2037ee32ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -540,41 +540,7 @@ static void test_##sched(void)					\
 
 MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(bkup, WITH_DATA, WITHOUT_DATA);
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
+MPTCP_SCHED_TEST(rr, WITH_DATA, WITH_DATA);
 
 static void test_red(void)
 {
@@ -659,8 +625,7 @@ void test_mptcp(void)
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


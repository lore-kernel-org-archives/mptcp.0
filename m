Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8086626
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235851; cv=none; b=JOze34hs0PKBTRDq5B3YtiGvtAU40yzaBpEefL4BFVbRXOnm3vdRPzOm9/TdNCVUDPLb0nGtfr7RwrJvITjDFU1FAi4W74JYVa5/eg+qVJQwLsNC9y0zVlnHKw6wI2t5h2un6dgfWmQfDFMKR7Fcil+qEfptudEbYCimSIXpp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235851; c=relaxed/simple;
	bh=CnASRoUYm+yP5M7K0g/JymC5f64LrApzb6D+5uRXoe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tRkmVD4y1NK8Xnqx4A4vl0iAPwry3cZ7r/LOONFw2sbiTfv/Ws+mHyiec2oOjVj4O0XPOKR1ly9p66eyssGmby9413GN7NBkNCQsyRpEdqwo48cVymc9daFBhnN9kRPjdQSj/5e5JN3WZjkPGHvLcqWYtEzm0wySmAh6+JjPJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+dLzjJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+dLzjJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D944AC433C7;
	Thu,  4 Apr 2024 13:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712235851;
	bh=CnASRoUYm+yP5M7K0g/JymC5f64LrApzb6D+5uRXoe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+dLzjJEajU2B/eEtFOK6w5YAkGxd4U/Fb9ZAQIXtj3fKBtmlU0LW2eplKRLixW5A
	 qbJJtjy5gfEQ+72/Q/veO6FivY/+K1DemQZ2/nGTogV+B36Lilt+sibMkKgsdS3Bm7
	 Iu1yeKKYkjaFivWFHY8zs0P/f+DiXeH3YAe0QrnAosMRsrbh4iaXe/Ip19wzrdpPwB
	 oO6HLxToMD+cLUj4s/+SukruI5DpE6E669cZ/hrj8dbNY4imYxDQnMgS2Hl1UC8l18
	 y1cdbcYG1hzSXsezuSFuCLHOjufauIW8GsZpxkzaCiJpy+SC7DJd7nQrjOpvRSff/X
	 wUj9tPhBWXwBQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 9/9] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu,  4 Apr 2024 21:03:11 +0800
Message-Id: <cf40cb56794b4740ad905cf2ef090e7b69e73014.1712235380.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712235379.git.tanggeliang@kylinos.cn>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After squashing into this change, the patch "selftests/bpf: Add bpf_burst
test" can be merged into the patch "selftests/bpf: Add bpf_burst scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_burst
scheduler, the arguments "1 1" means data has been sent on both net
devices. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_burst scheduler & test".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |  1 +
 2 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 57094bc5e67f..c68d5342fb3e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -532,41 +532,7 @@ MPTCP_SCHED_TEST(first, 1, 0);
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
@@ -583,6 +549,5 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
 	RUN_MPTCP_TEST(red);
-	if (test__start_subtest("burst"))
-		test_burst();
+	RUN_MPTCP_TEST(burst);
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index b3c811564866..6b79267562f1 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023, SUSE. */
+/* Copyright (c) 2024, Kylin Software */
 
 #include <linux/bpf.h>
 #include <limits.h>
-- 
2.40.1


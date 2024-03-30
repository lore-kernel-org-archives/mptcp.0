Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C921320B
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788665; cv=none; b=fw0pHpuIJai533avDcbQOl/fjOHKyEFF7eIcf0dlM6sYczl+V25TDYuPR6Vp67CEVBZS0Wxxx2p1BrBhRMby9VeibHuuOA2/rHTeCLgoykU3oKFZBOhpd+8TnX0gmLvJ0SVCyA8w6d0dkIIrQdOB47FD4CFRPm79phcsLI4RSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788665; c=relaxed/simple;
	bh=Mak82pO3I/3sJT4y6PFg2A/4TXdSe+EsarL0USWtafI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4wsZizTNHZzkUNrBY00RTSNtuyUcpvlC1NLXltM8BooSz8pb4q3mSCWS7R5gp+Z0wvIKmljkq/stGdEJChZgvMQmCzqydUhphJN8ZPsFf1gF5FlLLhvPxNb9MXJ1rjrag9wXtFAsGwCDf2o0t2TuoFRkaMBjfmP8/h9oYpwzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvdUFNCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvdUFNCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D201C433F1;
	Sat, 30 Mar 2024 08:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711788664;
	bh=Mak82pO3I/3sJT4y6PFg2A/4TXdSe+EsarL0USWtafI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lvdUFNClbtJJrI8veQtMlaAuptHaOfGR4HgZ/dqrhRnCDYRpcamrEQU67GQptXhqd
	 a7an0XVszOzSYECRprgQ8BOBXiYsgzsl6kPp5OxxBMGVKbZhtk13brvR1TGIbBeojT
	 RVtVenowDW+TAX23HPmlC150pL4Fz3oz1YW4GD+k9arX0PnHoxXCGjAuwfJFjDP5Br
	 tfjlxFVG1llEnxqB54XzeAuaXbwwn79QGu2U8B5kyChS9sofVATdDzA/8EGtVaMUn6
	 hjBTHMWOOR8JSUYG6P1rhpSO5kVx5SL33IQGUOt1lvwClbV/lTRUj0BeW8W+eDANQn
	 xxnpnNRFAcV3w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 8/8] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Sat, 30 Mar 2024 16:50:50 +0800
Message-Id: <5d3919677a5e8da16ebc5600ad7bc59b78b82d3f.1711788593.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711788593.git.tanggeliang@kylinos.cn>
References: <cover.1711788593.git.tanggeliang@kylinos.cn>
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
index 7a580a259c9a..8c778254c441 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -530,41 +530,7 @@ MPTCP_SCHED_TEST(first, 1, 0);
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
@@ -581,6 +547,5 @@ void test_mptcp(void)
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


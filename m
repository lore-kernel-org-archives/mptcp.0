Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5251717F7
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545287; cv=none; b=YhfkHIEh4sAePrlnNwJ0P/e4Q3KV3YcoLkyTbUpVIS+cyi/VHcnyNfh12AwzRzDssNxRdWt9HRLobUOSyirjNTT6OYhdyUEYROriXVxrXKPDbELRFv4h7Ckg1IxMHyQKg0QbiFMzY6C9rTDASH9ROvHHCulrvoy9/+mCUHkRl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545287; c=relaxed/simple;
	bh=yOL14Vdo7X8ZxAu1KKfl3/7J0KoOlM9nP0D6BLmtalM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/+dzPpSaxO5S1DF+DOVYDJzU5i2t1SfGj1MNebhk9FmZV+AGod7oaLaFt52UAeqYZztIP6uk0whx/fQsPaJSbPFtXxQsXJjjG49TTBjuwPGUZ5WvzTKCq1K4tiI2TzmfP3ubQjzZbu9XQPizYLG3QtwGr8u+kTZcV6a9PombMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufI+5ZBL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufI+5ZBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23430C43390;
	Mon,  8 Apr 2024 03:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545286;
	bh=yOL14Vdo7X8ZxAu1KKfl3/7J0KoOlM9nP0D6BLmtalM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufI+5ZBLPFWPcsAM+IVQnaqMVfFr+5cxKmbT+4HLz+EnzFs4c3XQNqhyg6VjPjtop
	 AVOExbDQ4smDtOFjbLMOJQ29Auiapu3vNv8XDSg7pYrmZ6yah3/IXhDHPevkUu/JqK
	 GdY2nM++8poNdlCnWdps2CtOJyKSDeannmhFyel4fLRNEAF01ZdQgNk1Ns1Aldg5Nm
	 rHLGFv93qG4SM5eK6HLKzLcSop3LksACLWcuIJcP1fVHX6WLzlKzgQOiEb2u/VuvZE
	 n6tofAxLYJngVSihMGwsTPIHXy1Ze4ojaFAFti1mk7j9BdGZwhQdfkKfjLLbRSuFLE
	 0Q0NRvLfjkR7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 8/9] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Mon,  8 Apr 2024 11:01:10 +0800
Message-Id: <955ab229517b07190804756bdc66096fe0a878b8.1712544986.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712544986.git.tanggeliang@kylinos.cn>
References: <cover.1712544986.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After squashing into this change, the patch "selftests/bpf: Add bpf_red
test" can be merged into the patch "selftests/bpf: Add bpf_red scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_red
scheduler, the arguments "1 1" means data has been sent on both
net devices. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_red scheduler & test".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  1 +
 2 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d7c6a0bec183..9f5c2297027c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -531,41 +531,7 @@ skel_destroy:							\
 MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(bkup, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(rr, WITH_DATA, WITH_DATA);
-
-static void test_red(void)
-{
-	struct mptcp_bpf_red *red_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	red_skel = mptcp_bpf_red__open_and_load();
-	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(red_skel->maps.red);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_red__destroy(red_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_red");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_red"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_red");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_red__destroy(red_skel);
-}
+MPTCP_SCHED_TEST(red, WITH_DATA, WITH_DATA);
 
 static void test_burst(void)
 {
@@ -616,8 +582,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
-	if (test__start_subtest("red"))
-		test_red();
+	RUN_MPTCP_TEST(red);
 	if (test__start_subtest("burst"))
 		test_burst();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index a3f3e5ca5278..62cba8f2d936 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, SUSE. */
+/* Copyright (c) 2024, Kylin Software */
 
 #include <linux/bpf.h>
 #include "bpf_tcp_helpers.h"
-- 
2.40.1


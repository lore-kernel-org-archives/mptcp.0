Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA25EDF
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545283; cv=none; b=WnRIOJMK/XV7PvlLwkAAf/iTxTat5Xd8XXAuOFvDOkSS6kIpBYCPhlWcDqAwYIYWw4tTsf3eTsywExLCTjOZNw2VFKQrmfgP0HMXkfxXcu7XfDW7nVd4rlMTj5dPtPSqtOhpWptB0N5R1ZPBglXiIP54yCpXCiR/R/NaIhTr4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545283; c=relaxed/simple;
	bh=j67Uk8KjympMise83BjIQlHfOFb8Q9Zns+RoAMCRRpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TD3NvniuvM8TXjAB2M9IaiwNJ7lzMb3XMmH9JQz0c3b3vKrYSLAewnv7iAlMsHFR8CYi4jiaTr4eFOCfXA++2OCwqOxhyofYuTwstSmbrNv0CegDIhDGwhNM7+z51fBXgnUJ2lIuogAk9kH8cdMtT2+diUM5+P5aw3UkUbMjDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNh7KQOf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNh7KQOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E64CC433F1;
	Mon,  8 Apr 2024 03:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545283;
	bh=j67Uk8KjympMise83BjIQlHfOFb8Q9Zns+RoAMCRRpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNh7KQOfZNOOf4lK50TaDr8nP+gVZQajw7jCOn0Yr01drSmMJMSw1eHSsg/j6RQY6
	 KTBixtilWQJIT4uch6nIedTnSAPHWxHmHLYbZx0XorGl3uGka1pXf8iWL6SDBj+NSA
	 zBlio6plHWpIVWVRTRfEHIZuhs+VDn/gfzJPDz80/lZqqEPRuOWp8BVVq1oX1pXQaQ
	 F6EDD40zD3c1CZCSldbXFiu+2j5dfwW/XlwvsojdV9b6tu5pgtpyYZnovvwzy32XHa
	 IkmLBAljM7XC/jcHudmuiRDdmEVn4Y9RkGN1GvIvyJld/3dzakfXqijYsL0IQJOEUD
	 kyjC7NoWHsT5A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 5/9] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Mon,  8 Apr 2024 11:01:07 +0800
Message-Id: <001889663976f22380ca7cfc34008b2c3ed38822.1712544986.git.tanggeliang@kylinos.cn>
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

After squashing into this change, the patch "selftests/bpf: Add bpf_first
test" can be merged into the patch "selftests/bpf: Add bpf_first scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_first
scheduler, the arguments "1 0" means data has been only sent on the
first subflow ADDR1. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_first scheduler & test".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +------------------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  1 +
 2 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 93819f0e76d7..9d01e4af790f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -528,40 +528,7 @@ skel_destroy:							\
 	mptcp_bpf_##sched##__destroy(skel);			\
 }
 
-static void test_first(void)
-{
-	struct mptcp_bpf_first *first_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	first_skel = mptcp_bpf_first__open_and_load();
-	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(first_skel->maps.first);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_first__destroy(first_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_first");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_first");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_first__destroy(first_skel);
-}
+MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
 
 static void test_bkup(void)
 {
@@ -714,8 +681,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(default);
-	if (test__start_subtest("first"))
-		test_first();
+	RUN_MPTCP_TEST(first);
 	if (test__start_subtest("bkup"))
 		test_bkup();
 	if (test__start_subtest("rr"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index 23a3e8e69e8f..2d067b25d60b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, SUSE. */
+/* Copyright (c) 2024, Kylin Software */
 
 #include <linux/bpf.h>
 #include "bpf_tcp_helpers.h"
-- 
2.40.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A717F7
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545284; cv=none; b=QK9krrpoURmtoy8poPOLKg52FdoOdNN4xuKRdFx7/I+qk5PhH24SXxlimAofejOAmmaXJ5F0MiLUqwCe6+kZ7dy79VckhnwrsdeIYtuZRtC562oeS05VcIsDU8XwQ5qumhp9p541btIrBIdlIXN8wO4q0rLUjxXBEhq7WFastCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545284; c=relaxed/simple;
	bh=f/7wXEIsmB9bNRioCj8OzUtpIGZh77aXNOmQIEESvUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGOxKSxQHuBl5YoEsoNAMzz1l1/EUZO4+4/rkJD7NkPIpZ+H+IwNfXL7oFmGT5ajBO4i3fMBI4dfh/muXOgTyIGluOMpN7Wv0UsratkodphDKr0NYu6/mxJcO3BBAUypKxzzhwdLFIzulP7yflgpIGMMpC+fqa/j9udEc2YPo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwowNIhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwowNIhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BA4C433C7;
	Mon,  8 Apr 2024 03:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545284;
	bh=f/7wXEIsmB9bNRioCj8OzUtpIGZh77aXNOmQIEESvUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwowNIhERb1Boh80/tfdid3Q+T41I5VeEMqTV3BjWN7iA4ibC4os//M7zwIIqDU0Y
	 G1VrrQSEwHBvYCfN/NRBbTTmDmHcTPYL4XmFaAGe8g3YtvnNZD8LqcvTfaeQGKVKNi
	 tJc0D4Oqqb3NIRCZTwqHCWTztVe+A3/YBO4z4pFYzxwl9OL85mqRlRf9paGrTV3Dfj
	 ku0mx97idF0IpYToH9p8CmUSMD5kzaMyA3vPG8P7bKDIQjn1knCnQlPqVBSKhzRfUo
	 0z2b5SXYoZhh2r3urlEeLM0tdTFZHfkVJVkevSw/SGDv/9ycOFlSUWaZ99uTPgpWiR
	 GCn8SX8yTdE0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 6/9] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Mon,  8 Apr 2024 11:01:08 +0800
Message-Id: <f3e11dfed40b8e6d9d6691a03eb585eca6809d3e.1712544986.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  1 +
 2 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 9d01e4af790f..f1a9faac3731 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -529,41 +529,7 @@ skel_destroy:							\
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
@@ -682,8 +648,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
-	if (test__start_subtest("bkup"))
-		test_bkup();
+	RUN_MPTCP_TEST(bkup);
 	if (test__start_subtest("rr"))
 		test_rr();
 	if (test__start_subtest("red"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index bfd4644dd592..486407a135c9 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, SUSE. */
+/* Copyright (c) 2024, Kylin Software */
 
 #include <linux/bpf.h>
 #include "bpf_tcp_helpers.h"
-- 
2.40.1


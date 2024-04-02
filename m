Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77018028
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034778; cv=none; b=dMIlNY8LgAgo4cStqYvo5vfTy8goDrfAiu01YMvyeNxyYAIY/ThPVkgV51AWagGzC/x9BY3u+Nmk9M16LUvQ79BFdozJnR1x+8u4LNt3D8t2rXIW1bXn8GY7/A7+yO7JqxDbWsHVN+E+PntHCWJzPrFa10iPJxFbUWlp05FQGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034778; c=relaxed/simple;
	bh=dQz1E3O+3jer0Rtxh4x18eYOv5QPE5OrlgNaymo6QZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laJ2bvQR7f48eCBYhHLw3FHv4HNjZaCk+anEJU+ncnhyeHFX+s4XjixvU//uWjaXMpZViYhTMfr5QA5BW663g5CKyOdFg81ANqtLSMzebN3EkMj8JqA1bYSwZNsDyu1BQAU1bxDG66HBNqikbLUn22WxJGJFTKTmrLaJlHsvBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNpP/HP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNpP/HP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB01C43394;
	Tue,  2 Apr 2024 05:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034778;
	bh=dQz1E3O+3jer0Rtxh4x18eYOv5QPE5OrlgNaymo6QZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNpP/HP69ez7PFOnPAfmps1P3I9ILcwwht0nAQN7FhuXR/VbPy85Tjq9tDVGEpN+b
	 vGlGcn/hIG+2A6sJT+JuK+yGo1NiCQ8IoxEhXnb6JqzEu134E63RxSUCnQTONMlvtU
	 M8H44mFsOOtjU6tZwTMLV/BWcznZ3q5BkbcSQ8M8oRaCcHzVxrlvm/oOInaKLqDy/3
	 ct03hxuAGRqh/cidjBBjYbbQfN+0dq3ynuaiWtlKcvFFBvPgfOfGIIQOLfSNay59lZ
	 aIQTqeVdmK1xhKfdOSZGwM4qZuuHWGLYfiyzNWsR+Z4jn3o3ANSezfZFZGQ2Gu+1Gq
	 n00XYaPmIcl7g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 10/11] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Tue,  2 Apr 2024 13:12:33 +0800
Message-Id: <b9e0f7ce68e3f2d0cb91cb43d3dadb967fa93fca.1712034575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712034575.git.tanggeliang@kylinos.cn>
References: <cover.1712034575.git.tanggeliang@kylinos.cn>
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
index 07ab9a1c6861..af21638080b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -541,41 +541,7 @@ skel_destroy:							\
 MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
 MPTCP_SCHED_TEST(rr, 1, 1);
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
+MPTCP_SCHED_TEST(red, 1, 1);
 
 static void test_burst(void)
 {
@@ -627,8 +593,7 @@ void test_mptcp(void)
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


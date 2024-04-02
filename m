Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A318035
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034777; cv=none; b=jRw2ZB/j3lQrCOBvs9xUnvPWg/yU0aBRXAXMdAALk0t6Sk0xfDN1WaZntEXu8y2NvqjSZC3dn2p8q6r+IkivlzC8TO47EbjM3xKp6KzfzqIpUVhcEK2m9ElWHsaY1r+DM/AEt7GURh3rHQQ5ymHgYID9X4bEsWWWH8nrZL9Dn1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034777; c=relaxed/simple;
	bh=0Vf9VkWxh4R6lHBa9AomHfd8QQ6K2TtCUB4qQyMkq8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVK4UzeExfPMsq8tdEwZykUFRJ70rFr6SxWVAmBdQDoXuEWBj+cZsHLhoUZ6pBEem5KXu0igS6kCXbk2AfkmebSX2NTRvavcHcwrFfk5VgIu0EUYC7CTMjmP8JKhfEYofkAKEWUdD44sgLYy88TOgn4jQuO4muFhuA5x4XlEFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtDs9TKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtDs9TKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EE8C43399;
	Tue,  2 Apr 2024 05:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034776;
	bh=0Vf9VkWxh4R6lHBa9AomHfd8QQ6K2TtCUB4qQyMkq8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtDs9TKzonRpbz1R9VEF9JFXdJF1M5L2BqLKgQNDNxYURZmbdsWsQkJDgi8rNCe2l
	 Gbba6aPJdGIRTqMH4oeQgWiCmVpIPv0JStV7Zd96UejeSScvaTGkzdiKUEX0sKQWVU
	 rxMbf4yH5SxkYMbBK/MzSCOLXJHs9nq/uysM2G53go9Ce97+IE0H7V8jftQcYL3STD
	 LAlxPeHuDjgTI2O6wjR9yCEPnxGrNKhyrMy8tAntj6tc26kmy3UPCiw3QyjmlAK+96
	 UxhbFpUMNqVm/kESWaTPQD1+v9+LBryB/26lyRkj3YJ5tMq9VuYUx9phOuuHatEQ1+
	 rafGwd9vt8PCw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 09/11] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Tue,  2 Apr 2024 13:12:32 +0800
Message-Id: <5531bee57beb3af0f188cb84042f8711575ba3c5.1712034575.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  1 +
 2 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 9bc0cb1212d6..07ab9a1c6861 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -540,41 +540,7 @@ skel_destroy:							\
 
 MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
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
+MPTCP_SCHED_TEST(rr, 1, 1);
 
 static void test_red(void)
 {
@@ -660,8 +626,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
-	if (test__start_subtest("rr"))
-		test_rr();
+	RUN_MPTCP_TEST(rr);
 	if (test__start_subtest("red"))
 		test_red();
 	if (test__start_subtest("burst"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 39b7e1cfbbd5..05621467fe48 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, SUSE. */
+/* Copyright (c) 2024, Kylin Software */
 
 #include <linux/bpf.h>
 #include "bpf_tcp_helpers.h"
-- 
2.40.1


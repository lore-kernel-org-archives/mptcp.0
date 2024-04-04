Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A486AE5
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235846; cv=none; b=a5Huk5J6LSzIIuUkFJFvNfhoI/U77+l3aAn5Q8B/W/VN9w6xAFHlgjeNecKSkIx5oMrA5VjlgoSwKiR1tM4Z09Hmrcpi6d9L1wAlwFRucHXmyuP66UQA2PV36MItg4MYm0TRTW0hvfo+d7k1CIRNiHzjNJpHc2VpTsJt3TfQ2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235846; c=relaxed/simple;
	bh=tMKIMdgHMr5YJxupBUO+B9ZaJKwLvVmDSj81W3cMZsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6yFEXG7oz0S/VWToqy3wPdxro8pd6XWzW7eMQSJ9goPU+U59b13A/mkojRdmGSLDI/zaIe7kVDW1Uerkzwcj94aGk4PoZWQqfuu5z42Jdd2BroJtAtsLkMS9OVyZrbku9egcq1rx5hZjhIdN7XWxk8vKkkHJnyff2lGLwkZsdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vETRwgvK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vETRwgvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CD1C433F1;
	Thu,  4 Apr 2024 13:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712235846;
	bh=tMKIMdgHMr5YJxupBUO+B9ZaJKwLvVmDSj81W3cMZsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vETRwgvKaIDyLhlto9u6jtW2IOVFChGPHRomT26LKb48xE9wVxQqzdZR51JDHK/Pp
	 yw1mRdLFc2EW9GFpKydzcKBgV7ivWevQUq6K9l8k/BRQixlpVrldt/wVtRdhhHDF/1
	 GKbPf7NHM/ZQzn5SRhCIg5SlKmRdWwA6pBxwGTnDqdXmDfULZzCtgdMxfaobX8Xbsm
	 P0woN8mm/KHiQ71OXVGTonFkG9aaY5sVqwGaxou+AVXXrOddo3bB0E4I1MKjbOtST8
	 qzzhOtTCQ3dJoJUIu5Y16zSrNfH8ShhrjhbWbuYrJAy+rWcdtz66D4m/XArQne2QQw
	 +YtXz5Rp+vcLA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 6/9] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Thu,  4 Apr 2024 21:03:08 +0800
Message-Id: <3484dc43621a26c9326967ce762bd159ad7d95a3.1712235380.git.tanggeliang@kylinos.cn>
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
index 9231ddfc6c90..cf6ee27b8b18 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -529,41 +529,7 @@ skel_destroy:							\
 }
 
 MPTCP_SCHED_TEST(first, 1, 0);
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
+MPTCP_SCHED_TEST(bkup, 1, 0);
 
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


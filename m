Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506C18050
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034775; cv=none; b=elE1h8H6zQfZ/pldEwilmxLS8o8wlj9+yFeSsQRnIfq65mGqE5Vcx1xvfFEGtVz0cvW7gudN7lT67y5iN8NEyxmKloiB53+iLi2NNC4P5BcLrQss2ORUq+gEgrHQjJPp4STnHJcDp1Im7tEgyMcGztfYgVCU6Liqlv1fT7PDRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034775; c=relaxed/simple;
	bh=KDbHTnIqQClarD1uFqu2p38jQ9iGt6u86cYVysK6PfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Px1+8W5zapGM52LlavWaQD5MhOgUZiQtik6JobYb1MdlQHBL3YeWn5mIns4d+uP6a3h7+2x+kAtKPSgtkrrLJ37DZGH6tXdNBcUjkVGkw+OyM9p1nDuelz8sN4y/umIIHfv3Xa0QmaDwWkDeC14llfGjJVOWpu2bM9tXqwkQ9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCFI1NFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCFI1NFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5346C433A6;
	Tue,  2 Apr 2024 05:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034775;
	bh=KDbHTnIqQClarD1uFqu2p38jQ9iGt6u86cYVysK6PfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCFI1NFfim6xrFJFkO89RuuTfMo6f8x+tp7VNR2QYn5BlpsT0Bl48OYGy3ySg9uyZ
	 SzRBzeOkvzLffJJ/JlkPozEkTBmglZE0xf/c06R2QhK3iObCjHD3X6gLtnoiCcSTdM
	 DeNZTysL5ZLzHI2l/kRa4ZpvkK34WEOjCvaCAYeHh0174Nhb7D8XHtMVdDAEgZIycN
	 qi6wbiizE4r4hyodwdNpQK6Wo/WDgZF/5fF4o4gdwHvU60UnV0iriyVO9zAA/qRZIg
	 HEFvOCs5QK/dMSXg0veZwI7MtccJ7CSI8l4Mjur8qx5YpRlt85Ya4WlrAluKs+BD+U
	 hvjn04F7XQhYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 08/11] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Tue,  2 Apr 2024 13:12:31 +0800
Message-Id: <55f63bc3fae6161630c2e449bcefddbde1bcc43e.1712034575.git.tanggeliang@kylinos.cn>
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
index bc46bd5ceb18..9bc0cb1212d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -539,41 +539,7 @@ skel_destroy:							\
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
@@ -693,8 +659,7 @@ void test_mptcp(void)
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


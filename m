Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CF10F1
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714745; cv=none; b=j/TcpP0CM7Sehafm5/OLNsbeE19Fkx+k62E1bgyA2wWIbNpAlIi1TQC3QXGsKwET3IY6SuUsKEuudYp1o/uhn/xWy1TNpotSIuFRgAko1Wc+eNcDi6KdrRXk5V4aPIU3Yp/HHX91rgUzYAc6tu+UZ2PylasPq0CHnalBANZIEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714745; c=relaxed/simple;
	bh=ZAIQk6iCtS74XJ29TO4jMkah6vOQVaJHSd1WdaeN47w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFq5p7msWWts6CwF0MOA5MPzpAEIl6R6H+SI+i5u+rv7QdOGg5dReDMxsQ719nXaBAcARBTjzobbd5IM9N8fJUX33RaFnST1h1RGqgfwZ27+GAgsvqhucww1yfn/ofLbNtxseca/aMceU4hkXn4KwP+6XEhambe3o4f8Mj58TP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK7Jrer7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK7Jrer7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA30C43390;
	Wed, 10 Apr 2024 02:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714744;
	bh=ZAIQk6iCtS74XJ29TO4jMkah6vOQVaJHSd1WdaeN47w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qK7Jrer750Zu8kGrNNanrqWBH/ZSIcQG6hHVXBBW14ltoOYX6lSOlVFVNbocZkqoq
	 fJdKiPyLDw5MaDku0PpAjQpI4gS/SE4FyHn+OT7Zeqox/xsjYBCXwC195CQkoPMgaP
	 v5OThWz9nRImQC8l7+qXTLjzulrvnnTGMyQDKFak6VczljivlxqqXxZDUYGKa13boX
	 h0ZrnMMXwGU0WoIvNX5nwpPZCJMcbFiUDH7gMB5srnjzx8nc0s3qg2fsAiSSWBalBu
	 vGZOUjhIaebEOvG44Hkoj079ALLbmnH6hk81TlS0o869GO1byYdnk9YTJq5SekceeV
	 7XR+GmNqMXlmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 6/9] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Wed, 10 Apr 2024 10:05:21 +0800
Message-Id: <7fd46d7a097794ae76fdad8d70ffa94a25d17501.1712714407.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712714407.git.tanggeliang@kylinos.cn>
References: <cover.1712714407.git.tanggeliang@kylinos.cn>
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
index d56a5aa0cf85..045b32cf8b22 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -531,41 +531,7 @@ skel_destroy:							\
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
@@ -684,8 +650,7 @@ void test_mptcp(void)
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


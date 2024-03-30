Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D6320B
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788664; cv=none; b=Gnfz2/KAPfaWMufCvzEpZMJx7EHCqFrd25WLUzcLisI/E4UAkgZJDwYzePcxRgBFGX//wO4rvlVqEXz3ZJegpRJK4Xy4/2Qr+AffXGi3cQ240tcaGMDa4ceHhrjhblk2l99SqvHJ2eUJWRdqZXtC6Zwd5x0l8QVFjpJv8/02kHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788664; c=relaxed/simple;
	bh=n91R6W6k6FRdXGOlHPPJk+2fmJwjWtsbZMUfjUp/j20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BtgPz1+PWrCoYPWRApVz9F28Qy0mkJMlp6KPfrYhjh5q7TGnveL6rEdaJkfTx01F8uA0P4eHjFqI98XtU/BZSoOu+ngNfKSZHf4eFi6YeOUF1lJkBuh/7mlLKWUjW5yrqArGA/mZ40ynI+wOsYxGRiIjs2lcPINErEG5Pr6vJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcY3Hxze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcY3Hxze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06BEC433C7;
	Sat, 30 Mar 2024 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711788663;
	bh=n91R6W6k6FRdXGOlHPPJk+2fmJwjWtsbZMUfjUp/j20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcY3HxzepF4hJ8BdQy37+3npoObAKK1ToFaMW1V8/dV0+u3gxXJkvpCNo5us+BlVr
	 ihtdYvg6ez+TBYfL8DL0iboiMEYMyyvfNqNZiZl1BGUYeRGXtmoQvrZICEiLzpW/FO
	 a6pbWqUze2jrp5f5JZXLHdFqHQAj/Rk/haQBP7TqHc5q0aucApZP1nPIIuPVjBMeho
	 Odahih1hFT0zAhbY5poqbXJR4mRAG/ltjqK2W4fEk1wZxOLMqnueaPdV0O5V0G6Gdm
	 Hu05PT0UJCpZUj2X9VoLArixj36g2C+K/JlOOdnOWv5UKbM7vwXlIN1KgqBXYzwPyP
	 Dr2LvvT3tQbCg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 7/8] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Sat, 30 Mar 2024 16:50:49 +0800
Message-Id: <8ca165618f4e5f11df06298c25d09215d63b6dd5.1711788593.git.tanggeliang@kylinos.cn>
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
index 693e77558850..7a580a259c9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -529,41 +529,7 @@ fail:								\
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
@@ -614,8 +580,7 @@ void test_mptcp(void)
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


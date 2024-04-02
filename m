Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE138DD2
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042172; cv=none; b=Z2OOoKmMSzO6FKW/guLoqoYQz5632epCTkww1j0dZzX3qZRS2KjIb1uZl5jBn1DNfBdqKG1kTI+sE76exf0Ocg1OrP/v6zjG1/Ua0QaxXHlLkJFJk0DW9OLgN7OXDKnuVL/dQX2I+iQUKG9fyznDMGdVOwOoLG+pRMUyx8+QzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042172; c=relaxed/simple;
	bh=HjzHXv6TFDzw7M8ZPXQRhsl70zcbGncq7gVgMp7DhII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIdq87uBCUlb7dGgFtFSA74PeRiM0LFEo94YH8MHZBu5e1TAkMNkUT54s5LcfWvsOV+KEn11dh1mAzJNEskvKzPrCKfnmRhhX5WAaAuyeIOUYVaxa+Q4cPi5bSKnAVXP5+KoK45P6UgCe1Zw5mRWHFtuToPHD48nGPeXqfFaMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P29dDOYQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P29dDOYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821A1C433F1;
	Tue,  2 Apr 2024 07:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042172;
	bh=HjzHXv6TFDzw7M8ZPXQRhsl70zcbGncq7gVgMp7DhII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P29dDOYQawUp+vO8Re0ZUA89gjLP319UCvx4lP9RTgb9GbTM6RJM1vga/coCdc+F4
	 ld4oQnzWUtTa7FpPGvH8Mp2q4MT/6IgIt29RPsH+J9ECMDnRgq14UCEsBSo9y1UwZN
	 BZ8V92sVje8yWD9blJ40CNN+zENLfxuE/ICfifJQk1jMMUoX0s7k10ANyoiwwoAvZV
	 e4qjRdxm9fHmM0u/odkZiP/ABnxV3YdY1tFpv3QsyIw8gimpvU3AzGk+7cyCdRGFy6
	 I5NSthkMQgQTLI3FNhanjmHmWIvMTLmbgyMAwWZM//h/hOywLI9gIW+23g06RE0gFT
	 Eff/Nb4bDtFlQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 07/10] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Tue,  2 Apr 2024 15:15:55 +0800
Message-Id: <60c20701612f1c466c34093c80d717a5b60ca979.1712042049.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042049.git.tanggeliang@kylinos.cn>
References: <cover.1712042049.git.tanggeliang@kylinos.cn>
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
index a6eb437b7a42..39f83a401c02 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -540,41 +540,7 @@ skel_destroy:							\
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
@@ -694,8 +660,7 @@ void test_mptcp(void)
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243E1364
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788662; cv=none; b=RbCNuxzjz6oLjIzk+Bgkv0rl3qpttaryCxPQvWpUfxJSWzyghND6NvBV8buwJemRjkYWiAr/YM3gt5zujb8bvLWBcm1jZeIULgwZdpGaTaH4IX7dmak5KfAgdZ4vH0Uz7a249RHaOvhsFBbqnY/JyagT2fCuZdaaG73JLOcg79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788662; c=relaxed/simple;
	bh=sR5Jn4KsYsDTT/Nn5B9MKmysvbj23znLpfZGr0MoqnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVsKAuTEqGlFbryknHkDjjxuDE//tX4hW60DocmYU2cR34ihWotDk+QEmW5sMmv08POll+qOxZO1YQM33+ZWxQR1Z62S2EpR+vb83cVpQzGvQTfDFVxIwvu9rJC2SfsrU4jF43w7ZzidYglx0iyVGgatiZjdH1/djr8A7YYatjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKM5T/b/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKM5T/b/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F877C433F1;
	Sat, 30 Mar 2024 08:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711788662;
	bh=sR5Jn4KsYsDTT/Nn5B9MKmysvbj23znLpfZGr0MoqnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKM5T/b/ldZ5X80rPjPGsOmJzHWLLCQVw8PnsXKsvbdu5aIyYJxSe4SxG7v32Juo2
	 s93/eyZDg7+Fj+gtiyn+s/nctkFnF3TtRvdO8HR5vOrtLHcXYOaakG5aMSihB9q9tQ
	 TzpOTRLnOpVh5LoHJB2f1XQwoO/Of0wcoEgDInd1JR2jeExWu2YKXMa+odrbrKQx8O
	 DycThvALKflpDo52cuFk9CvWjI72wMBPhNY9kXL37x79zJdFZ8RunxmJjamWEct1EO
	 2wNzQmrgbKTKwsDoNeKWTEVq3lNuks6aCsjJ8Xro5r8NoRzH3+HsGTPPWl29h6PZt+
	 7+rxvMafY3big==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 6/8] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Sat, 30 Mar 2024 16:50:48 +0800
Message-Id: <2853c378022b0fdefb0656f6e6d8349d74e01d09.1711788593.git.tanggeliang@kylinos.cn>
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
index d19dcec69edd..693e77558850 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -528,41 +528,7 @@ fail:								\
 
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
@@ -647,8 +613,7 @@ void test_mptcp(void)
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


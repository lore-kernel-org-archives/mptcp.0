Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C7EDF
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545285; cv=none; b=muWp9UwZU+okY72tOOMwXJA9JVU2Erk9/NL8rqjiBuP0XOmiYcxK5lCb/J9JkrCm6CpMcPftOe9h7VwGPuWixp7C4q3GOT5FMXhSuxHSgQVa78m4scQpSVMC7VKoX/rUHR3uwu0duO548zZrtsB0hAfQJTKqutXwUN0LHeg3Xcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545285; c=relaxed/simple;
	bh=1OMyUV3ltXv/IdJUHMiRxs42S8q82GdhvXGpj0u2Nlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FpyCvFoH1foMklGTtdEJFTgfu/RU4mMUE68da8jMN4KgPMkKtmJWVfo80XRD3rbFR9ZgIQQcPJCjyvof3VOEr9M/eKF+QSU5azE8pban8ia1VnuBPXhtup9NpVH9+IJH+FJCPXp8VKiMQfXmqr+Hp56PCXh26AQyO6qcKAIJ/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwpy9+m0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwpy9+m0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FCDC433F1;
	Mon,  8 Apr 2024 03:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545285;
	bh=1OMyUV3ltXv/IdJUHMiRxs42S8q82GdhvXGpj0u2Nlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hwpy9+m0cjaKcr4brdc0O7XhLrgZ5OceFbOs9cREpmig9AlWlmNgjL0ARNUYDSOzm
	 rydE3LJF4AVhT3htb8d9dOnFHCB8d/XToBdfpSdCIpvTNt2e07gC6VuPcrtg3E+J0P
	 LANossuLlS1zPJFWoDn+p+qJjXYHoqbfoHgZ+wniZ7UcVFqHezPm5czntHnNtCfaAH
	 h7kZyFkbULB8OmqpjQGqrWHX7rdu+mLK8S1bQnauRQTcbBHvvRsnRDgOJ9mEL9ysDn
	 sdK4mFb0KsDBNUe2HnBIpWKNRKl2cUIUJSCA9kCN4CSKpyxWbJYbgLAiRFTYrfiNls
	 7wPRZ91BtD8dA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 7/9] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Mon,  8 Apr 2024 11:01:09 +0800
Message-Id: <f0ee7d08a71135456892294614757b6a69d4ba3a.1712544986.git.tanggeliang@kylinos.cn>
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
index f1a9faac3731..d7c6a0bec183 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -530,41 +530,7 @@ skel_destroy:							\
 
 MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(bkup, WITH_DATA, WITHOUT_DATA);
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
+MPTCP_SCHED_TEST(rr, WITH_DATA, WITH_DATA);
 
 static void test_red(void)
 {
@@ -649,8 +615,7 @@ void test_mptcp(void)
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


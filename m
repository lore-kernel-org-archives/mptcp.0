Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00D839F8
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235844; cv=none; b=pC+b7XPfukTfmSt0DQCaeNDY3l9zHboX64vW3tLebe2vmyaK9uxJRtPAWkavYuXiuwwAjgDYTeedRdRNsxhg43jxvd97W1hoSrBwm14cCSXJCV2Fq9zU7PMgzWPGHVT2Kp7XTJyPFRuFIy05wafn7hlc1eWK2EEaA7UB5GfaZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235844; c=relaxed/simple;
	bh=ch+T5zhRkNSRD7YGbw2jGct8H6qCgLL0Q6gBVjyzoZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cOHO9AIC2F7o54CT6Qy6NF43DTxHkidDWMuARdZv77aDCPrCmkZlagIyfPq43dWrB3hhqURQID5nCwvt9jR4l/vNZurYdLoai6RAQq+/b1HOzppFbrvHzH8wQeky2BwUCiv8dGA4WIL0kMrs+BIR88YvMpFkrm/8uDdksENykRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GySyvL33; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GySyvL33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E55C433F1;
	Thu,  4 Apr 2024 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712235844;
	bh=ch+T5zhRkNSRD7YGbw2jGct8H6qCgLL0Q6gBVjyzoZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GySyvL33k9l78x0ftMfaySo3XoJzdVrmBkRrociLFPJnuWGybwSqyAnVeHh7bEZlG
	 zfLQoVCU0euBNQv5PQTR/mfJWNO7zJZxJHHMC0hvYLLlRCve0ICw0+ig/pykm1gqLI
	 kwnC3xd9h2tFQlxVnvqjI9iImuHijFMqBGRMpSElsOrjaDRpTsmzk5QvFEKRseJQOs
	 2S+vg11PkqF21PzgO8bWnPSHcwHBxTl3IZ77zquDFuihyvd3C1ZbDhCWAz60kZ2CWK
	 57QbZbjFXwzKG67WXXE3B8zXD3ss5WJloCSd7uVqI5m10yCBwQei4Ee9FyZW4Dpo7Q
	 d/ON0pedyH9YQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 5/9] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Thu,  4 Apr 2024 21:03:07 +0800
Message-Id: <41df81f7be327ac1c908761a3186bddbd10d9260.1712235380.git.tanggeliang@kylinos.cn>
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

After squashing into this change, the patch "selftests/bpf: Add bpf_first
test" can be merged into the patch "selftests/bpf: Add bpf_first scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_first
scheduler, the arguments "1 0" means data has been only sent on the
first subflow ADDR1. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_first scheduler & test".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +------------------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  1 +
 2 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8a6b09a97698..9231ddfc6c90 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -528,40 +528,7 @@ skel_destroy:							\
 	mptcp_bpf_##name##__destroy(skel);			\
 }
 
-static void test_first(void)
-{
-	struct mptcp_bpf_first *first_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	first_skel = mptcp_bpf_first__open_and_load();
-	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(first_skel->maps.first);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_first__destroy(first_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_first");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_first");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_first__destroy(first_skel);
-}
+MPTCP_SCHED_TEST(first, 1, 0);
 
 static void test_bkup(void)
 {
@@ -714,8 +681,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(default);
-	if (test__start_subtest("first"))
-		test_first();
+	RUN_MPTCP_TEST(first);
 	if (test__start_subtest("bkup"))
 		test_bkup();
 	if (test__start_subtest("rr"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index 23a3e8e69e8f..2d067b25d60b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, SUSE. */
+/* Copyright (c) 2024, Kylin Software */
 
 #include <linux/bpf.h>
 #include "bpf_tcp_helpers.h"
-- 
2.40.1


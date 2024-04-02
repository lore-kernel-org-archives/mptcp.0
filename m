Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD41383A4
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042171; cv=none; b=sITz8A7PaUFeri2H0UtdpEWfd3EnvAILM74T+zzNfiljQXCleL9n81bl3HNp/x+sofMW52pMdZ3A/khzBV1E4uiboliLVihuNCXj/1YHySGFeGc7W1rJLrwjD2Ez4GKOFs0ObbtL3XRzcNX1jhC7ZzHsWhP/lcZpQMoWWcJB/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042171; c=relaxed/simple;
	bh=HVv3SJtqu4xxghu/VMwv4ka8HYcUnKtJvorb6C70iHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=joT0dIU43yOWzTQPrPcD8pL3PNzjtPFZhvCAFuqLDmMLFWDNsRrL+kdFXeBjiELXe0+0fw7QqQl/3rYDKYXGzp94XNGkjSpjra4nNKpXslBf+23TBaWnDZ+642mZrK/HwaUcJDdO1kTOODis0Yyvc6Askn46EMd2JZaq2rbe0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu0JBT9S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu0JBT9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A4EC433F1;
	Tue,  2 Apr 2024 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042171;
	bh=HVv3SJtqu4xxghu/VMwv4ka8HYcUnKtJvorb6C70iHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mu0JBT9SDMmsuzFcYsyVqcciQnp5Qt7kcx1BI86ovZ+82Ht63+LF7Mh8wHagNqn0k
	 gtLqKMUxaNq6+qEweVdnFI0sEkIHSAS2rBrtS8+ywXKUQ1nEX3+iqDQtGS9bq/HqfL
	 Toq6cetfB9OSCcV3CEQJ3HNGuUB+k+qq02WcLVF16jhg3IWTH0f+QWSYDFm/ay7nM0
	 0KkX77zjFWiD2c2yOoMJ//YEjjkbuH2bTXIJ7a6kMHMv383PmS39NLDxd9E6+4sOyo
	 E/QjwA8kroa0nN9tqAehOhYd3zN3OTIpDD3EqDcg3G+EowOAX+k75E78eva08gn24n
	 /N3JXMP7AWUHw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 06/10] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Tue,  2 Apr 2024 15:15:54 +0800
Message-Id: <9431df434324d311105c4b05007e6955c62f09dc.1712042049.git.tanggeliang@kylinos.cn>
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
index 24e3b5a1134c..a6eb437b7a42 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -539,40 +539,7 @@ skel_destroy:							\
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
@@ -726,8 +693,7 @@ void test_mptcp(void)
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A691C0DDF
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788659; cv=none; b=YfPWLYM0AsBNiKUbYZbvSA91edesFt8J9vlf4cqLPfWJ1cOVQodWUl67jfmtMGT59IAQluEm3mTdSex4cj+QOmx8irPUgNO8kbpja4mGCkuHXdF3MlZFvGys6YD50tlWlJXBs2WGx8iJvFeUAAVr6x1g/qSXdrD+IXHo0MKYqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788659; c=relaxed/simple;
	bh=F9GNsHTtMtnGK4AYgQAeQNIvLK5genneNdm1AB88Dv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCiJxzpUwV/zofwkZTgFj3VvOp5WfbJ+sbVRjdhWuUNeVMY+gRhI1Mgi0dWVN4Bt6SNeb1HXFYgW2SnAtDK2v0RtZ5HW6ttpebR1n0jAGG+V3OVOCHvhqM9aYrvZCRQCvUgmISs/JQ69cz4vRxIOqz4yvVSi8mSxrIk0XXSaWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSpccSmg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSpccSmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D19C433C7;
	Sat, 30 Mar 2024 08:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711788659;
	bh=F9GNsHTtMtnGK4AYgQAeQNIvLK5genneNdm1AB88Dv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSpccSmgsi7Ju+qxGI7Ie3EyNjV7K7L3c5a9Ghh5cjSICjQxelUaYnKQku3neA1Q6
	 3ZIrDuqK4UjNGkgUdUZzORa1YmfjTkoK272IeVdXtM7YIrqoWHOqE1ihhASHG/QVmS
	 FMbJ6JRjjKbKp0BhAhk3hEJS5YOynrJFvIFx3RZGJKf1OQmgVQQXi126skL7Kcrzrd
	 mUTsleZrKHG9XfNI4//j5rYvuG95XCxNTm959AB3JgEaI1egSKQMsRgazo9lje54rs
	 4XbCFjsIk5HrVVFwtb+dRWJnfw6sSA+yG6YOl08jtMBmpTq4totG7TXRIhOn/GEorv
	 Y0IfvkJmB/eAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/8] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Sat, 30 Mar 2024 16:50:46 +0800
Message-Id: <713c1bbb9fb854a95a6605a9d9bc61465c17812d.1711788593.git.tanggeliang@kylinos.cn>
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
index d6653ce1fc36..4bd24bb3d141 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -526,40 +526,7 @@ fail:								\
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
@@ -712,8 +679,7 @@ void test_mptcp(void)
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


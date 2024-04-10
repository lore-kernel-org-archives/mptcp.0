Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197564C6B
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714750; cv=none; b=YWIG8jfKcQBbL6piUDQc5kJf7onljZU1gELcqJg4cLZ+WEf2exEv6ND0YpuZkSOjwe+QRj/gtYZqA48E9vMAf1X4P7Sai7b/VA0LTgngnq/tGpKwMvuCREwHYJxxOPopR4NBB+xadAG8IiONij6qtEPPw+2IRhQrnZe58pV8Mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714750; c=relaxed/simple;
	bh=6u6LHhLf/DsufPB4FzzW4G7YdKLjRhLAay+RuDj1NII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSgpodqb/7WOX82Ng/tvaO6RJ5MPiKALWIa3y6zYA7S2Nyyt/U93dUHpEGrHlBZp4KvW/tO1tQMnNI351Di0kT73v3ZNzuQ2bgkZcDYiG30qd81NMTiyifq2BoN2KsNgobPZw07ChJemLMh5lQBeoCxw0k+T+TjgfSfvNUYzsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOi8s4bl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOi8s4bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A6FC433F1;
	Wed, 10 Apr 2024 02:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714749;
	bh=6u6LHhLf/DsufPB4FzzW4G7YdKLjRhLAay+RuDj1NII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOi8s4blJF9fkSCVnRgqN4bnzXelLKWpapQiIQxAdpDGFLOy1P57WP4LHnFd82EGM
	 5Vv1n87hda3rZ8nvzD5WKOAu0jRy4Hc12AW/sbJnVeA5LLIzcPDixnzHqdh85B7MFG
	 cqwrRrfHCdbp0MmTUGuJd5GjNz93Z/Llei//ouAygP5gBMX6LFliWLJm8fhZFHNI6a
	 1jBHFf7vjfywpDZr1hkmcGnC237kkT7yHOnNALqbohkLJemEGSbxiEcQxGXhNsh9Oj
	 Rb8r7mbt0yBrcHuHf8085oDQVpY96y98K95UjKoGQUoYQxYoFzcOmIb4Rjzcp4RzOE
	 my46GGYc7SPFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 8/9] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Wed, 10 Apr 2024 10:05:23 +0800
Message-Id: <b3f081e16d25f5cd9f09f209c1a649c3329b372d.1712714407.git.tanggeliang@kylinos.cn>
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
index 492a8b5de64f..527cccd96ba5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -533,41 +533,7 @@ skel_destroy:							\
 MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(bkup, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(rr, WITH_DATA, WITH_DATA);
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
+MPTCP_SCHED_TEST(red, WITH_DATA, WITH_DATA);
 
 static void test_burst(void)
 {
@@ -618,8 +584,7 @@ void test_mptcp(void)
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


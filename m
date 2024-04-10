Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBD1C2E
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714743; cv=none; b=LL3Nyx4PTn+yFn1NqJxPi97ZUki2yw0zIynU0fJLkGkki+ub4gai3u7KW3lwVmJ60eqfz/CXTcB22MrBQNMspZInQsdu/P/34EBN+8wrnoVPuSfkxiskovQrlhvO9AlKCIVCjDaobzFjEUsS4SjlB1UrxtxqWw1E/D81/kfgQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714743; c=relaxed/simple;
	bh=R1k/TjZiktuMyom0BF8buj0Cl2SOpIQ+FATTdK0V4xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSo4ycSnxUjkeAi8nt/prFt8Km4iSKhwNiZLAbN/L4rzPSUs6Q9nvc9qEn+Nf4b1eFmFW/Uu4QOuPYf7ZFpbfcc8ewwTzXsrgg9lOEpUvOGbASp8TTcwq6SgsGf4a2IppMNwhfizWQ5bukVnoNADpTeVRmDH4GWSSVgFhOC6eDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/ZM3Few; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/ZM3Few"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BFBC433C7;
	Wed, 10 Apr 2024 02:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714743;
	bh=R1k/TjZiktuMyom0BF8buj0Cl2SOpIQ+FATTdK0V4xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/ZM3FewbGSIGvZX5lmzITmStJAQ2q9ORB0GV3FeGMT9eAJ7Es/DPDI9xbzudUD0t
	 HFOraE3haSVEOWWh9OcnE5t2X0qMiuIJx8m1eZ9V1MOrNtoOj6mM0dMhYDmti7oiNE
	 U7CRyLQZHjv/0lzdYsTziZNzZw0SGMDVBPdsr1U32luHMiTQtShR4gYMIsVmSGizkz
	 QiB6Bar7L0NmmdvmRn40z/XlMQdvSC5d+KQTBIpavbCVFWJaz130tfdksBAgxDXrgI
	 GiA7S6s+iHU1WKeLFkiTDnjo/fcHa/0odtyF1BYsSLq2x4N6jd7flW5iKC/m4vb/Pw
	 yBC2ZFf2wnoqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 5/9] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Wed, 10 Apr 2024 10:05:20 +0800
Message-Id: <3a8e8688d120d18525004dec7d214a901ce8f30c.1712714407.git.tanggeliang@kylinos.cn>
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
index 0144db1425ed..d56a5aa0cf85 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -530,40 +530,7 @@ skel_destroy:							\
 	mptcp_bpf_##sched##__destroy(skel);			\
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
+MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
 
 static void test_bkup(void)
 {
@@ -716,8 +683,7 @@ void test_mptcp(void)
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


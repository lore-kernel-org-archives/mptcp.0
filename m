Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5CEDF
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545288; cv=none; b=uE4f+267jAZuCrHHHhIZUdNfC3CwZ6fv/aCmNoJOvJBUyk+99CpFBdcaneHe0k/cUU8xS2aXuMQrDXQtC/Dy3j1A2+chPby614lZj7kKiN9nNod33MaiUoUawiOL5gcvOZC9Rb7DpolVX97JGsyvvwZgYr9FzIi3mv1OM0A9thM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545288; c=relaxed/simple;
	bh=xzdywZklgRrx4Ydgj2KXP12ZkigeH4TjbVzL9XpO3C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5S79slIZG7d8S8zAqNNUFYEZDuXqFKzRpJ+j1V7JAapJpw4IuEGWX9+9LWWxENXhgL/VI0FidgEWxZQJbyuKK3epWbsfrPnIYZiNc4w77XSK3YclmYY5KRph1Xywqrb6LFU5I0inz+dvudM94poe1BIuSJ8KACCAWoNobBJIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuB9sV8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuB9sV8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7145AC433C7;
	Mon,  8 Apr 2024 03:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545288;
	bh=xzdywZklgRrx4Ydgj2KXP12ZkigeH4TjbVzL9XpO3C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuB9sV8TApLD7UjOwQl2ebRdMac5OQ9ama2oYbNbuj3hNGXmyroZPZSITIg5puL9t
	 oOcel2eyOJrA1JC7zZutUG4q4PYHV3HRPUm20K/T/Jh/rERtLJ4bDjO3qguA8EFZqg
	 Smx83Gv13UwKP9s9cmPoSRdCCVq+lFYz1/4/nmLcLLXA1v44O6dMXBqZXPkFun/3QZ
	 AJtf0UKFV8lv4W887wH7/NUS+cb4Inb4EChnnxpnIQkfAqc1CH3O1/h56Tl0ddQBR9
	 mSAZiMLqYQzdrzpKhBfKm1RIHivVeAcGiU+1uSOtos2Cr4BiY7hhyja6+MAplljJiv
	 NYBJH2uGXcS/A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 9/9] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Mon,  8 Apr 2024 11:01:11 +0800
Message-Id: <18d024cfa06defd884af90ee2127190084186697.1712544986.git.tanggeliang@kylinos.cn>
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

After squashing into this change, the patch "selftests/bpf: Add bpf_burst
test" can be merged into the patch "selftests/bpf: Add bpf_burst scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_burst
scheduler, the arguments "1 1" means data has been sent on both net
devices. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_burst scheduler & test".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |  1 +
 2 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 9f5c2297027c..e8e4b8486511 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -532,41 +532,7 @@ MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(bkup, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(rr, WITH_DATA, WITH_DATA);
 MPTCP_SCHED_TEST(red, WITH_DATA, WITH_DATA);
-
-static void test_burst(void)
-{
-	struct mptcp_bpf_burst *burst_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	burst_skel = mptcp_bpf_burst__open_and_load();
-	if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(burst_skel->maps.burst);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_burst__destroy(burst_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_burst");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_burst");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_burst__destroy(burst_skel);
-}
+MPTCP_SCHED_TEST(burst, WITH_DATA, WITH_DATA);
 
 #define RUN_MPTCP_TEST(suffix)					\
 do {								\
@@ -583,6 +549,5 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
 	RUN_MPTCP_TEST(red);
-	if (test__start_subtest("burst"))
-		test_burst();
+	RUN_MPTCP_TEST(burst);
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index b3c811564866..6b79267562f1 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023, SUSE. */
+/* Copyright (c) 2024, Kylin Software */
 
 #include <linux/bpf.h>
 #include <limits.h>
-- 
2.40.1


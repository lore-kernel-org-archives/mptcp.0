Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A43A1A3
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042176; cv=none; b=HDWE9rnvhDA6ridgfgH5vfky5mZlQzf7grqlpTnE73S0EzuYRxbhbu+4pK3O1vQ9aXQlZAmSrBtOEaqJi3e0XigaX0ONraU1PBBZG0/8oRpDpm8rFiXta3f9FkhZf/bJO7QzRYZotqYXNA8mJwRmHQ7fVRS/jIU360/BfaTa9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042176; c=relaxed/simple;
	bh=hsz8xFeEpK9/3V82Q1b3ON110ZKrBa37/g7/ibKdx90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MH2HsKPdlWas7X/I3q2who/SQYqHEyoUXBlsgw6gYUUnJS+AT34p0FmSEE1JlOPysywXfM3C5XdUqCd3GxmOM9XUPaiDkerSO1dyn5S5RAq4DxGItey2/KlsP/5V5w1/0OFUeGvWqR9LOD7/iN+zLGUN2mEDM/F2PhiILpDqqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2lRKFAB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2lRKFAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B131C433C7;
	Tue,  2 Apr 2024 07:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042176;
	bh=hsz8xFeEpK9/3V82Q1b3ON110ZKrBa37/g7/ibKdx90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2lRKFABI7u9UDZ8FfNJ+J8Yv3QiTlbIKUMAm0qRZQivsJZbRJ4v2+n4dDgVxonl0
	 CWLuDiqb0Kep7bExP5AkG9fVB3iQZwXyJJelVlhKOLOWmw3rF5mhB+yasBy10I7weD
	 4OvtVnqMDZpEUgTMNuNp62l4vtH0V2jUr5QvbYUgNTjrH0RHvv3P2vNUdN/jegQc5/
	 i7V7TNR/PnNa/nQFXHpaxW2mYdKlWVZ+yDvxkynNfouwf7K5tstwfoWWXnRbyy2Wws
	 oqRGo15wMKg8rq47NrOx3j7NEPitYnFWlxcklt2e8zahL7HBKWK5pgJZuKTh9KU1tG
	 ubeyFN7+SHnfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 10/10] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Tue,  2 Apr 2024 15:15:58 +0800
Message-Id: <da9df6a879894d406834a51e313e795d379b4168.1712042049.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 40 +------------------
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |  1 +
 2 files changed, 3 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 110f37e4b159..400d329ef2a0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -543,42 +543,7 @@ MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
 MPTCP_SCHED_TEST(rr, 1, 1);
 MPTCP_SCHED_TEST(red, 1, 1);
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
-	set_nonblock(server_fd);
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
+MPTCP_SCHED_TEST(burst, 1, 1);
 
 #define RUN_MPTCP_TEST(suffix)					\
 do {								\
@@ -595,6 +560,5 @@ void test_mptcp(void)
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


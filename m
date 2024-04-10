Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847F1C2E
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714747; cv=none; b=Aj1xTMVznyV2RfEenAz68DkfKIU7wcvbBfbXsgGEp+66qbQ9vUsyUUmXcPvYEHONaPZ1qvMthE64TjrevexJe4De/fEnBarAK0sI0VvfmEVr701fQ2ni3KGh4soleMVysCTxCdJZAVfrIBAOGcmbPYP6ExQOA7hCzl2xN5IRltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714747; c=relaxed/simple;
	bh=rSPuxWshjk6KM3Zz244DIla3FEyuZckCwH3lN5b2Q0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D4Ciwwgk2DeWHHGPKYetYdTf+5qDmVE1MPZsZ89Y0tR5K+3qOpxDzNldsx/sr3Usg1fgLdz8n+bKWjuo+XrEPA9Bp2ZuuJr1S6JLjjIfPRPXq9Q9601aw5/lLnYIx0cAiTA66bPdQCM3z1pIfndYB1tqZYNqDQ1PgBH1RGyHlgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs+TUnT1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs+TUnT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB50C433F1;
	Wed, 10 Apr 2024 02:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714747;
	bh=rSPuxWshjk6KM3Zz244DIla3FEyuZckCwH3lN5b2Q0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zs+TUnT1tsb+9rwWNxw9b7vwP//ZKDg7KOBv/5UcztbNWg/M2eMmuzF5tMYJzpD9s
	 qcf2eB850blz/suifLL0eXkQMMlXGpLzoMiyYuShKSU15tVP4H28025q11tJi+MvBE
	 qdj7Vqo4gjYbRvbQz37uHQ7JgcoN8kd41V/ulLvJ5TrYS+gCO+FcoZGyAIAe7gQD9L
	 v2kBwrcfwzXj/3xISonGxmwX766RlDfslIqx3nbDdrgBu3pg8FgtktypQD+yDtMyyj
	 pAdFcm6tXz4eRcmqw7ncXZhhWP7POmEzP5dP16kErq5CzEMllsEVgc6w3lS+qJiOIl
	 EDYaGIzC4irng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 7/9] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Wed, 10 Apr 2024 10:05:22 +0800
Message-Id: <47fc82bd02706cb835e0cb3843b5f6665f329feb.1712714407.git.tanggeliang@kylinos.cn>
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
index 045b32cf8b22..492a8b5de64f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -532,41 +532,7 @@ skel_destroy:							\
 
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
@@ -651,8 +617,7 @@ void test_mptcp(void)
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


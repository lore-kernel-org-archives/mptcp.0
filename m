Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FAEA5F
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714751; cv=none; b=IBImtP2HZczYNRg7r6/UoNssqccI7wGjHn66k/Z4/00jz4ziYLBFzxX3exFLBruW464H2+IHQanm02dcdd4R4tgW7Wj7GRbg9BfV2r2t3CSY489JSKou774hPdp2PqRc6GE44mPnncaq5Jzs9G3YUg9+sYdc7/JoVpJFQGwHEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714751; c=relaxed/simple;
	bh=Uq3xW360H0tQgchd/clWWQ/Ovam8EMp2/3sBv/y3A6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cA2iKfgn7f0heUlsDyZt6+x5KR46swgPDTXWJCHSHB1xCHMWHa6E8oSDPlFCA0WMccGpuzNYiN2Rr7aCoDpv3d7oSlTnHVYaBe5TluRS0gyRkkOv3B1KQuTuiAIrfsaT50Lzguegt1/aGQTSSxiiDjOEbQS2Ym1m1E0tkdohdWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tazWV6pF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tazWV6pF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6E1C433C7;
	Wed, 10 Apr 2024 02:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714751;
	bh=Uq3xW360H0tQgchd/clWWQ/Ovam8EMp2/3sBv/y3A6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tazWV6pFr9fWZobR3TiBw7H2Wz5V/S4AUFrkapRM6AT6SoJm9D3d7APagJe2ob9jT
	 80WOXcFg0WHUW/93u5Lw6BoGPJ7uOe2/dRg8j0yAcJfXvENzj69gNJ5p2cSBui75a+
	 knRqxvSZqgfbuxui5rwLzWRxOSfMjgFyrSlCCicQQTVoSgEKbXCp0xMEIe+MFZlwKr
	 Ics3K6/PLDzAiMJMHTAlrEWBlABc7RW2FRo60YRfudIfH3HXkRiYfaCE9P8GreLZn9
	 hjM6quG4OXV0hdjsdl0W0JBq3YI2ATw3jgeaW5GQ8S3Fa8YcB6/34u+YEqSvSE7ZNd
	 6I7m13ZAgRhfA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 9/9] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Wed, 10 Apr 2024 10:05:24 +0800
Message-Id: <52afc901ea14abd60805b3686cde1ce01a093b5b.1712714407.git.tanggeliang@kylinos.cn>
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
index 527cccd96ba5..9a9964e41cba 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -534,41 +534,7 @@ MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
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
@@ -585,6 +551,5 @@ void test_mptcp(void)
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


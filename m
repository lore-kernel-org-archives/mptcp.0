Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3437149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688236; cv=none; b=be+ysTafwwtTEk2r72LyNqTsOZvoGK6jNAeslN5RIO1mNpYzhAwg3xn3ZlOP9q96dovWcdN188k0OdL9VZ/kA8284NSxGJTqzfiRQt6Wrj26PjorBPE4xVuV38u5f6zOCPpM1Kf0f1OssnuQLhJmbMLG0YFe24tg5ErvLqPxsOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688236; c=relaxed/simple;
	bh=Qy5+enWvBeq9lzSDq+2s0TnoWzkH5D4sI1k67J+5Rvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4jaR2zRXgI1n6L6S48m2ukAex3/o9MI9FHdpyirGypD9t8N9e3ydbCXT+hOyh5dnTQ2owQpVj/G5+LM7Y2Z0DEVinc2wkZRGCDMO6NzeoXsatK+Y2xPfWTyCaLU4lHmVn4NtoU4VF9p8kjiwiNsBPmZLRv3MCTTEp5ddnLMbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOPPKrVa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOPPKrVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9C2C433C7;
	Fri, 29 Mar 2024 04:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688236;
	bh=Qy5+enWvBeq9lzSDq+2s0TnoWzkH5D4sI1k67J+5Rvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOPPKrVaGo64X8MF8yX0xScFYbwpMa5xDqZq/fu589iiM8gXbY8DWOBvNoG+kPiLZ
	 EezyaqEQKLB9DyuRaHOW9WsiLsgA8+Q1ILC2j+y3PTcjswJZNWtro1RXqqxA+A5ELt
	 QlR6dsSzVwYactYHUpyfbTxItKOcdR3Yn6NAtpv3F/uy9PM9he3AMDUANbL7N7T+BN
	 RLsGX8xyCO4mOZTvvxeOJS23CAZ/WSgoVPgujGklM+eDf5L7wHVGkl2y2rwIDBGooM
	 yMNO9GdfAfP/dOoG1KEQJFh8uTiEoefiFqpnVjNnx1UWewCoDdhKsZSR5R+au5hfEB
	 hwwZj069t+jrQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 12/15] Squash to "selftests/bpf: Add bpf_rr test"
Date: Fri, 29 Mar 2024 12:56:08 +0800
Message-Id: <6341b48d075d122c2538b042cbd7357380ea73fc.1711688054.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711688054.git.tanggeliang@kylinos.cn>
References: <cover.1711688054.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use MPTCP_SCHED_TEST and RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 249177b4e3bd..ebde380ab334 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -500,41 +500,7 @@ fail:								\
 
 MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
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
+MPTCP_SCHED_TEST(rr, 1, 1);
 
 static void test_red(void)
 {
@@ -619,8 +585,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
-	if (test__start_subtest("rr"))
-		test_rr();
+	RUN_MPTCP_TEST(rr);
 	if (test__start_subtest("red"))
 		test_red();
 	if (test__start_subtest("burst"))
-- 
2.40.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46137149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688234; cv=none; b=j9DACgfQglSEiEiQrGdSKGAhVIMF0xhoK9u65pzhPnYCwzEEEgY831TUSEbIHPkBZGATh52QqKPbvePIgCGwWLanZLrAidL1GzyvAty4rxS5zMRWKpPYAAFZZtezU0OoDTFpczMk8GMIr37yRFSZx28LePj4EI1UQIpyKAzvPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688234; c=relaxed/simple;
	bh=piTKvKqHPPMjc8B5ZJb07t5a0TMQd31oVwXNlzqNr8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbWW0r4R6xBbsugd6d5B2VfZlvLROtDTSUi2DSi0MFrlsbrYN/ht85FJgE++oYSmyPVZRGNQqL4fWr8Olq0ST8W1K58HW9FLzXx/0p5KLPCDj00M53j+gBn2k6za4/usntDhaJlZZiH81AttUb++GSQvHbDYAMrt4HE2kg/GPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGX+7vdE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGX+7vdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C68C433F1;
	Fri, 29 Mar 2024 04:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688234;
	bh=piTKvKqHPPMjc8B5ZJb07t5a0TMQd31oVwXNlzqNr8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGX+7vdEIzc3y+jPqx9oPPRYLKWtug5eJI0ghfbs09XN9DKPojUrMVzW/X+FJjmBT
	 IzsnXMzPK7cdmO9et50+qFPmq7qsaGpoO74ixYeYmRvSr1/aLqwS+ofpEtqzgMYlz0
	 sXzksB5J89r4BaeS0VqvPpjddDj5GF4O3T5Zi86pNbj+S7J7IqDTBkOykFe6aFTqrm
	 we8HcGfDrEG3kC0BrSoMfz9R3lGgGwlP6YvEgSy6BEUz2c8lZelgNfAxh0wgf2FG3r
	 zvjetoCTkV1l/KwO80S1+xM2qZNAJaXgmEPrupnSXF1sJO/Ehlwd81EJelvX7Mjy1S
	 dAI5+JrM04PjA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 11/15] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Fri, 29 Mar 2024 12:56:07 +0800
Message-Id: <04bc41822bfa1f316b8351ef643c6f61b060cec3.1711688054.git.tanggeliang@kylinos.cn>
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
index 8697cf1a5c75..249177b4e3bd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -499,41 +499,7 @@ fail:								\
 }
 
 MPTCP_SCHED_TEST(first, 1, 0);
-
-static void test_bkup(void)
-{
-	struct mptcp_bpf_bkup *bkup_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	bkup_skel = mptcp_bpf_bkup__open_and_load();
-	if (!ASSERT_OK_PTR(bkup_skel, "bpf_bkup__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(bkup_skel->maps.bkup);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_bkup__destroy(bkup_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow backup", "bpf_bkup");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_bkup"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_bkup");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_bkup__destroy(bkup_skel);
-}
+MPTCP_SCHED_TEST(bkup, 1, 0);
 
 static void test_rr(void)
 {
@@ -652,8 +618,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
-	if (test__start_subtest("bkup"))
-		test_bkup();
+	RUN_MPTCP_TEST(bkup);
 	if (test__start_subtest("rr"))
 		test_rr();
 	if (test__start_subtest("red"))
-- 
2.40.1


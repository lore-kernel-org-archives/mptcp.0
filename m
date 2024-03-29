Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18EE37149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688237; cv=none; b=CyED0Pa7bd8+nyuSbi1yBif+AHkNK+D2zYBtoXmAiIL70pvNFve1+xo6EtjDwB1YvkSUtw05NGCMeL2jflkbcc9I4rihKrzoIfv6qtZ9BOMNxpZm/70UJCSRulX0j89OBy9vxTBSXg8JRHRAd+NYG+mUnrd/KCaZIFcBRDBteE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688237; c=relaxed/simple;
	bh=xwtE5QI+1+1IXV3kn73iqlzUnLK/IrdsS/KESh8LKBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFv4xuCdP+P41ByqUvf+BdANekl8nhEyAfAAS4lmGdX/fYpSt49RUt7d0fW4Q2EfQOtSOmAU/owkNMj19XWcrly68o/KJU9JBLUzbuL2UTogSKN/ziKV23RXxMigDatruY7QIIPoYSZgpPcsdiEj77XbAMnP5rpXx5eFefyJbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOHSPr9I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOHSPr9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3785C43399;
	Fri, 29 Mar 2024 04:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688237;
	bh=xwtE5QI+1+1IXV3kn73iqlzUnLK/IrdsS/KESh8LKBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOHSPr9IueMaDnFANXuDv2669GjHeXdwGhWcMv25OrPNF8FZnPQx5Pgb9uqgq+446
	 hJQkpp+4ZUQE/FZMcF68dRJfQtF5L72Q6/E/AuAX+KLVWzrUX/WMeS1a2BqX/t59Fi
	 NdSqy1LjuelRNFIqI/vIhdrEhFw82iGPj+k8yugtzCM1hDWcEyVSY1mw9SKHeoTXFZ
	 YoSsKTLQ+P+6Hb50J/YALKlp4pHhk2V7g+QXcBmKp5SnvQGi78hyXkW13s3JnITrqX
	 IPNoL/MrSY7w3KPg4QMw2zEK3HF7Yss/Ovmml1A+Ya3YBuLgrBH8m0gLUzHyNAh36m
	 XvbmikSenZMTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 13/15] Squash to "selftests/bpf: Add bpf_red test"
Date: Fri, 29 Mar 2024 12:56:09 +0800
Message-Id: <ceafdc44c5ce1fa9fe5ec40bb3e86006a959e053.1711688054.git.tanggeliang@kylinos.cn>
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
index ebde380ab334..0f384402ab6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -501,41 +501,7 @@ fail:								\
 MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
 MPTCP_SCHED_TEST(rr, 1, 1);
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
+MPTCP_SCHED_TEST(red, 1, 1);
 
 static void test_burst(void)
 {
@@ -586,8 +552,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
-	if (test__start_subtest("red"))
-		test_red();
+	RUN_MPTCP_TEST(red);
 	if (test__start_subtest("burst"))
 		test_burst();
 }
-- 
2.40.1


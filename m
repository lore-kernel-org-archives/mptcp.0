Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD91657BC
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619427; cv=none; b=t8fl6tt/hrl1pQqLrL2dP+B7WazjRfLzskytV43Xn6JRDJbFOP6ywHLqGySIbU0EtEyLSZZJibibKftgr/+Jr2asw+tGUtzCE2LXkEMuwvdFNUwkrra1vSxMzzZukFxosU3JnWgrj8MSe48OJEUZozkiFbXrWfZBjRz60qnjIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619427; c=relaxed/simple;
	bh=efrqjSuBs11nT2TILMg9ki/9CYwtC4+o7iVcPvfLKdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxRuAVCP92NTl9KZy30xbQn37O3WKJc8WzGt8feLKK2VS+3lBIRQXrZIZZ+JbiSsTpEqPYV0B3F5VzIgK+KgZkTt1dfuUVOJYY4Dj1gdCiLr8Z7PA9OyiiwNjPS323khlmqNKfnGtUa3OaUn4GJrA/JFg02GCYRJuTazPuDSKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/rQIvWo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/rQIvWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F99C433A6;
	Thu, 28 Mar 2024 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619427;
	bh=efrqjSuBs11nT2TILMg9ki/9CYwtC4+o7iVcPvfLKdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/rQIvWoTDXUhIc3nW6xskbRfIUK1iN9ZASJ9RcmZvAEB6KJ2xBXMywI4A236vYHU
	 y1/GXes5uEOrKw1vMIaw3MrCqIjDJuTeIdA2zPlKY1JsiqGqSXYNgl0s27CJp8YpCj
	 WNkXM/3T/T8y6AbeoZXG1B3VDBM9i1V/hyPd0KXcAYM+ILUZg2oCMr2/CJpDOfqIz3
	 ce8zmn0y6p4HhyEHGUnICG/H3sB3OtWRJv9uIu93MHHhN1E41u8iVJ6C3IKd7SpklS
	 frbIyEaTrSRcM5N0ve9blzEwW53erLGezWbR5h3GUeiW0tQNgRKDNmm2s+CnarA2H8
	 SSq3abUedQh5g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 10/11] Squash to "selftests/bpf: Add bpf_red test"
Date: Thu, 28 Mar 2024 17:50:07 +0800
Message-Id: <bb18e87b1917f4269e82164880153c174485e16e.1711619108.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711619108.git.tanggeliang@kylinos.cn>
References: <cover.1711619108.git.tanggeliang@kylinos.cn>
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
index 8f41007fc3b4..572b6e5caa32 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -504,41 +504,7 @@ fail:								\
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
@@ -589,8 +555,7 @@ void test_mptcp(void)
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


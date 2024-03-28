Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF053E37
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613130; cv=none; b=S7cboxS+UgV2dM9DHQqbGK1blzTOe0Rfmr7GoS93UDo3TahwhgA02DPyxnsFUsFKrAinKDE+VG1DPhSS8ivzu6Gp92N4RTc0SkVf2NMrpW8yRiPmcpdKN7T8oMm6F1yDyFq9fELW89LA9QIYNv1/errCjCSlpAwf5IBEzgw+4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613130; c=relaxed/simple;
	bh=tLpLm2ZbkG/3QZx7e4STtT97asgYfpmcf/BM9Ip6fjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=grjNCG+uEFXipAkouFUnFaDlEpZFfndQus1lh+SLYoOmDMK+9k+JGVzP5xCWbxotX8awB3BeRVTiTk9SmEiMWMF2NkzMG6ECXz89JJdOZ+HefiQnSpqXe+9srZF5idGnMmOP9TnfbrYttxF4uodwg7B4z999zu+824Fax6MsOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGJH4l3u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGJH4l3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7039CC43390;
	Thu, 28 Mar 2024 08:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613130;
	bh=tLpLm2ZbkG/3QZx7e4STtT97asgYfpmcf/BM9Ip6fjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGJH4l3ueL0ndLAg1KuoVa61l3xfL9WKkVm7wdgx1bOZ9lFjn0JA0IOl/m2LKu7oY
	 hOod6juworYAyhE65/nDMc5gkXmiSiv7T09uwMMhTRd0OpJsxNWXeSbn2U6Lni9DXn
	 bAs8/CPdpqnort6Fpu3DUzBvt0hArfC7qTfEM0FSNuvHx3ymImGJupoj13aWg0q60U
	 1reWxroDdOjIf9BtK7Qz5JYh4JeSwPHCA906hrlLMH/A1MetiolLXLdNG912Vepy6L
	 VpuInKLY9+TSb3DNfucNm6wfFwbY+Df8V28tNIVBB0Yn4ApJ1ao8CBCgo76zgNcAgF
	 bWD3Q1+Qb62YA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 10/14] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Thu, 28 Mar 2024 16:04:57 +0800
Message-Id: <add84a7f0b9120b1277d5bcdab96e9ed0442e500.1711612876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711612876.git.tanggeliang@kylinos.cn>
References: <cover.1711612876.git.tanggeliang@kylinos.cn>
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
index b334ab0d1df3..b990f91d59a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -568,41 +568,7 @@ fail:								\
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
@@ -722,8 +688,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(mptcp_subflow);
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


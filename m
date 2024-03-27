Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D23536138
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530134; cv=none; b=tGZh8AwaIFiZqk5GYM7CEjqIahv3nnKMWHQkMj0Vys5w6f2q5+5za39PDxNNVyg2uE+j71xidpc3Dqw7Tt2K7Up6QHBd2WClNF/6SCYw+RargVgiEOL78gSUvGcrIzmOYJMF3T7tUWkyF3x0aacbBZztAPh0VMfWFwzQpjjg1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530134; c=relaxed/simple;
	bh=q3t5lLU7GyJRfUArGS0LRF5osIoUerU+BunpUgOgv8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YdJnG0wFvgCjtpKv/li3x/CzMjxhVpkCEIJzk2/FiInslnnnZ/5OhWuSS3bsDS3rvdRzWF81EmKvXfvlUWf6RrquwbJZgVZFePUX9fbVscnYp6wQQfzlK/t22U2HNvMzQDdthPEUgVMwy/PtXlZ75EFuvwxmtuS89hoRjmQhQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO2A+F6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO2A+F6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81113C433C7;
	Wed, 27 Mar 2024 09:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530133;
	bh=q3t5lLU7GyJRfUArGS0LRF5osIoUerU+BunpUgOgv8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nO2A+F6rPwwmtDQnH+HcCcIE3NufU0e+N8ydJtOH1cYk6evCTR41512lok1rB4foM
	 blCi+gs1cB211kPGDc7M89c35wrACF84AAd4Y7sj2jdD5x8s7cua0GJsBexNCqYS82
	 4oS0Twne2z8FOUOtUdL28KSfEs6UMk7jHdo3Jtr6xT7WWDXpDn6LgGMyrNgD/9VFl2
	 EbLEda4aCaHnBxIixqIkD8rAWZUao3qQWPOhgb2otH1QJ+UzFNaMpSQKF5+jWix2Mm
	 bYrpSdvnhvOjK39GZ2b+WHoCzU+pheeYgqwqyPKGfcYTPN233R/FOe2YqxqTJlLsFE
	 aCnlGupD9xwxQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 08/11] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Wed, 27 Mar 2024 17:01:46 +0800
Message-Id: <ccc4e0e0f69b202a8b243b9d579ca8b2d93dae3f.1711529752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711529752.git.tanggeliang@kylinos.cn>
References: <cover.1711529752.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use SCHED_TEST and RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8d3e2ab9b16a..7ccc63ee763b 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -604,41 +604,7 @@ fail:								\
 }
 
 SCHED_TEST(first, 0);
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
+SCHED_TEST(bkup, 0);
 
 static void test_rr(void)
 {
@@ -758,8 +724,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(subflow);
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


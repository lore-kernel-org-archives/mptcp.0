Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3C1851
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321561; cv=none; b=gOPgB2GzacRk31n37AgwBIkSipBtpqkNzG4Ynqr8eMoSrgkYGJt9GsMyEVG4NZTHfbyEzbnnsS8BF5AIcgq1xCdZPfmFwGZJTs6LWeXgfhFDWzKKpfGi1/hQ4tegblD38+WK9E0B00jC6D8sb140Z6mTRAUcxH91mZYY+i8aXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321561; c=relaxed/simple;
	bh=hW+ZvU4mXhQyg4/gEJyDPRvo1bIYuq5e6n01KvK56LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWD/qZfOFJM9I3miqTXLMJLOurrVQDuMfFQ3d1gGZZfUIoE9oW9phKYWXYjC/sCeSPhOJ+MED0GFgT4GIcBrK51BPAQ4um2d844+L51DfVN/6kHaU11x2Ijb5s/MzRNCJSNoawJj6kCnZcqchNYeUEa8DJK0FqffEJEaG4/YYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIuf2NmQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIuf2NmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B458BC113CE;
	Wed, 17 Apr 2024 02:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321560;
	bh=hW+ZvU4mXhQyg4/gEJyDPRvo1bIYuq5e6n01KvK56LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIuf2NmQjTKcGJPQBnFwz3AzQO17dV03R5khfnaSLnmB2hMtvJlVWOugGFnhDOeEA
	 v/Ip4BVTKUFvEB7UWMfOas7NlKBuuLzHgA5u+GxNoexkp+Luo3Q56xx9vik+Vho+YB
	 ILPAGXdTuijk9VgT+BXguCcvtUKVQeFC0B3S92HKBGnoG5fBlPNRrrVIHAHJ3BSDvI
	 4XrWQqoayRzwGw4CuIaYYKBkd5ko3G5enxlzgcbALdW8P8TqkLCawdm8lZk+l3sKyZ
	 FnV5o2JnaWCj28ruNhv65omXJRkR+64/qK+xjzwL+N0v1qw958emzqg57rFKrjhCjS
	 AZ/NRHmaOMCmw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 7/8] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Wed, 17 Apr 2024 10:38:53 +0800
Message-Id: <1a2941648d9cdefca6086f8dcf8d5866dfd4d3f4.1713321357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713321357.git.tanggeliang@kylinos.cn>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After squashing into this change, the patch "selftests/bpf: Add bpf_red
test" can be merged into the patch "selftests/bpf: Add bpf_red scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_red
scheduler, the arguments "1 1" means data has been sent on both
net devices. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_red scheduler & test".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6b2037ee32ac..1609a0e1e799 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -541,41 +541,7 @@ static void test_##sched(void)					\
 MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(bkup, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(rr, WITH_DATA, WITH_DATA);
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
+MPTCP_SCHED_TEST(red, WITH_DATA, WITH_DATA);
 
 static void test_burst(void)
 {
@@ -626,8 +592,7 @@ void test_mptcp(void)
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


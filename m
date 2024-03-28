Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7454BC4
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613129; cv=none; b=EwOXE1PkudGR8Swj4jOaggigzPl3B14uazT1gaewrEgHcY/7IL3NBcVZQ2m2ntOylsGNkN9znRRIJ+qFU2Mr2EYOeDzFlv/+jTpF+sxRIGJ+UsEVd/stVlOAh5ZNA6X79cUrrnvlWKy5Q/7wzRx+DaH84IySns/HDSVIflN0ucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613129; c=relaxed/simple;
	bh=4leD43EY9gHl08Xu1r9sga7RVY/uKyOAyqGFS9/tWl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5eERdBZVzIlew+M+O0G9zoS4tnnGIQjgbJCXjYkFQIH5qn2r7Z+C4jQCSdtYs59T4hC6wDhXImykNSmM7cRKkkrAx77Q4AmguGpA3C7iLn2NjklDKsaIntfkTYcO8bud0iSMTbCEneXpB1J3DZK3ZzW6vZ4uxa6vG4oAp65CVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it8ei5MX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it8ei5MX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22484C433F1;
	Thu, 28 Mar 2024 08:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613128;
	bh=4leD43EY9gHl08Xu1r9sga7RVY/uKyOAyqGFS9/tWl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=it8ei5MXQnzhlQDsPe5kgUw6Lz5EZI/kN5RY4sPZOg6dNOMTAvowxzzhWmlTw4sMN
	 yEsYXQRvfMtKHBhFXO6HogxHIbMy7v/MM1eoMAaDLckLLWq06hWkMIA2gDrhNQJmVt
	 owMCgN/Qy8b9Nd699rW0mhRoQx3AthJptoqOEowKCaJX1d5PuwTXhhn1kPscrx3Vg1
	 QmZ4iajtPoWBLOTmC6WY8+xoPu9B1O3t4/mikVJ+WRNA/9QvcHMVEw20TSNNFTeONc
	 e9fsQwuPCNXMgkiBap9rWbTvMaMaoKU1lj9e2H2+M9d/Z9A/RCPubSv9t/novfEg8E
	 +bRN9fvwassIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 09/14] Squash to "selftests/bpf: Add bpf_first test"
Date: Thu, 28 Mar 2024 16:04:56 +0800
Message-Id: <b85eefc7354c0d4dd1d81700b0d59e3cb1acc585.1711612876.git.tanggeliang@kylinos.cn>
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

Add MPTCP_SCHED_TEST macro.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 66 +++++++++----------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f2e7a419330..b334ab0d1df3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -537,41 +537,38 @@ static void test_default(void)
 	cleanup_netns(nstoken);
 }
 
-static void test_first(void)
-{
-	struct mptcp_bpf_first *first_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	first_skel = mptcp_bpf_first__open_and_load();
-	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(first_skel->maps.first);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_first__destroy(first_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_first");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_first");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_first__destroy(first_skel);
+#define MPTCP_SCHED_TEST(name, addr1, addr2)			\
+static void test_##name(void)					\
+{								\
+	struct mptcp_bpf_##name *skel;				\
+	struct nstoken *nstoken;				\
+	struct bpf_link *link;					\
+	struct bpf_map *map;					\
+								\
+	skel = mptcp_bpf_##name##__open_and_load();		\
+	if (!ASSERT_OK_PTR(skel, "open_and_load:" #name))	\
+		return;						\
+								\
+	map = bpf_object__find_map_by_name(skel->obj, #name);	\
+	link = bpf_map__attach_struct_ops(map);			\
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops:" #name))	\
+		goto fail;					\
+								\
+	nstoken = sched_init("subflow", "bpf_" #name);		\
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:" #name))	\
+		goto out;					\
+								\
+	send_data_and_verify(#name, atoi(#addr1), atoi(#addr2));\
+								\
+	cleanup_netns(nstoken);					\
+out:								\
+	bpf_link__destroy(link);				\
+fail:								\
+	mptcp_bpf_##name##__destroy(skel);			\
 }
 
+MPTCP_SCHED_TEST(first, 1, 0);
+
 static void test_bkup(void)
 {
 	struct mptcp_bpf_bkup *bkup_skel;
@@ -724,8 +721,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(mptcp_subflow);
 	RUN_MPTCP_TEST(default);
-	if (test__start_subtest("first"))
-		test_first();
+	RUN_MPTCP_TEST(first);
 	if (test__start_subtest("bkup"))
 		test_bkup();
 	if (test__start_subtest("rr"))
-- 
2.40.1


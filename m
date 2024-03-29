Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7637149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688233; cv=none; b=jh/nFJoF/3/XMLyI20/2UA6azUXo3EuVKhzaxsXkD2vSul88Io8JevF4ImlLl5jJ3ZiPjKkKHaUDeTwLqGFWdcH3oyS/8v7vlIaycErnMmf3pulf64OES0BRQvO1r8PtNUI9rfyOCCEMoMH/YoI0PHMi3vjXvxWDjMI0LkL1WRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688233; c=relaxed/simple;
	bh=j69Suj5e1ypBz8xfAC6hiIvNiIzlWHKsQyKJJGnu9cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lb1TisywCGYXuLZD+4OGkagJNPipMOBwD9KdvJvFwzyliGJBiT1qjFKxfdtlYkwIIw12pVLUir4cfQigsn4gp+hnBwuZivjSLfWW+zONzwzfKFKLY+9H2KhIHg7g+fbGuj4f8RlRzsGJ8BcvU7CSrGca8Kqp33pt4Hz9krn9KPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuYtuq1W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuYtuq1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EB2C433C7;
	Fri, 29 Mar 2024 04:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688233;
	bh=j69Suj5e1ypBz8xfAC6hiIvNiIzlWHKsQyKJJGnu9cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuYtuq1Wh4/1htYQWfmE0jkcP6Rt4OK6gzpkaRcgrSr+Nohy0zSkZyfckYq/bkXj6
	 1n1ix3n1jM1E8YjZVD/uoOQ0djnmhtNrHhU7myv3ZbTpt1BwZAGRn1sAOqw4o1I7vl
	 txRQAak18s37AhZ8+64Bg21wE8SnK99MjZC3wAnF/+RJrPtF1iBQ+RQk1WHjRcKY7C
	 CRictvcWVJb2oc+fIimgxJ0yQlsU3LZN1oKHgFgMIa7pSFtFDuQur2EsMbYUKDqgs0
	 8rEhE1uex+FhWrDo22Y6y0QROnkPAVUaBfDrej/003qDxBuCME1OK8ajGbWmSVOmG6
	 Q8W8DMPKg6wtA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 10/15] Squash to "selftests/bpf: Add bpf_first test"
Date: Fri, 29 Mar 2024 12:56:06 +0800
Message-Id: <d2ef3ee4baf90fc69492e7c02876d1b354216417.1711688054.git.tanggeliang@kylinos.cn>
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

Add MPTCP_SCHED_TEST macro.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 66 +++++++++----------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cfe7a7b6ec48..8697cf1a5c75 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -468,41 +468,38 @@ static void test_default(void)
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
@@ -654,8 +651,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(mptcp_sock);
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(default);
-	if (test__start_subtest("first"))
-		test_first();
+	RUN_MPTCP_TEST(first);
 	if (test__start_subtest("bkup"))
 		test_bkup();
 	if (test__start_subtest("rr"))
-- 
2.40.1


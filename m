Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900D657BD
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619423; cv=none; b=GytgdNuVIJYU9J9h52zndGdAMsjCY4SUCW3SZ0wynJmV+8VMUNLbUtjbES8yxsWSaWc5aQWL9bU6E51UvMd0L9usJoT6kM5ww3eBwKYdGn82JXNPJPIwdbf6udxvdHAIBdRJ39dJYzg1/Xhcswmply6wgYVY3zPtE2QDVeA/+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619423; c=relaxed/simple;
	bh=rE3kLMSKytQcbT7iemT9EZmlOzw+mj9XNAepAF9xPG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvOD8SwCTsvD/Kddv6tnyic+BOrQqL5O0tb3q6EQ1x64USiD0bwjxVZPnQlhxx7CTg7cM0SrVX2Yxkj/Tvo9rm+L2waxX8nK7NUvtZ/vOET+TKpIsH9+eZbFjl0nsH9UCJa4dQy6pU4T/XFYZNFtS2J+Ctlqrt6/IZNtOw+Dsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd21y+YW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd21y+YW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AC4C43390;
	Thu, 28 Mar 2024 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619423;
	bh=rE3kLMSKytQcbT7iemT9EZmlOzw+mj9XNAepAF9xPG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hd21y+YW+VWNQYB6TwiJAFV+Jmr9VNYVVQc0m6bvDYI4MZkRb+O2ThcBDNLiJ3Uh4
	 tJ6tBlOFVQl3zVhcFIrLUZOC8eZv2cm4t1xdvfvI2hlrF/XJDZKoHqq7WGcCuUfIXp
	 JUFDL54ekMFR+Ml4sE3pOJpTBEeFj7/9knxmUVbJw+w+cDHvYZjKdJvZwDjs2QrHkE
	 edAh+V2RrsWx1LDvLCfRdhR6F6p4vGSEeTXsfQrYaLkeFRlmrReE03qLhO1j6TtjSI
	 aWfBYy9Vljei4uDd82gLXDeDt0aOVC8ySjDDkzAVfE81rOWVkqV4Dbe8+aDtZM4WTr
	 fRJjBFoucPtvA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 07/11] Squash to "selftests/bpf: Add bpf_first test"
Date: Thu, 28 Mar 2024 17:50:04 +0800
Message-Id: <8b620cda8ab8415806f96196c4dde1712367bd47.1711619108.git.tanggeliang@kylinos.cn>
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

Add MPTCP_SCHED_TEST macro.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 66 +++++++++----------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c400dbaccc10..8d67e1715485 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -471,41 +471,38 @@ static void test_default(void)
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
@@ -657,8 +654,7 @@ void test_mptcp(void)
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


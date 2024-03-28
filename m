Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC357334
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613134; cv=none; b=aJl61dxlTaGRoUvnkKEmUrErFxEnx+7z6m94mrgO+J1RmdAz1L3JhNEWCHgO6/y3Fj41+mDfjn4jt7LoZ2gjX2FEAz2ALnCjsmAFSMLtw65GcFLuklrM/C/+iMS2nIyzUXogj+fdplHTAoIjfZZ2rGTTfxKhRNEd0Ca/fWy3r/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613134; c=relaxed/simple;
	bh=pidRC0xSgPxpd7bzm6/Hb4EpOW6rELybZ8iRljbpRq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V8bqbet8ovPKvkZqGsjRLHo7dF07xXhH/YYKb7uEzmDMXX1RqpU4hMShPhSQgRLehROyHnRZ6FxQj1Y8hDTS3WPlbtgmrXiLHu+i8PqgKwvc7fdHv9gHdRQzc6fK+V2hYi2JEcPcHbZp6By604J1YBVxr5qoxeGVFNN4NgR6bwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZZplpAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZZplpAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692CEC433C7;
	Thu, 28 Mar 2024 08:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613134;
	bh=pidRC0xSgPxpd7bzm6/Hb4EpOW6rELybZ8iRljbpRq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZZplpAQ44eY2Xo87b1yNgAlTNgGIB+6U6CvD9Gx8z5OORWz8DQXeW3mp1pStt3y+
	 c0wRew0GQHNmvpyWqVFF6jGeily3I9XrU23340FlsmQTFRJV2Ipyc2Dl9kuC74ZRP0
	 rGrTGRTcKp0giUELIzw1142ZJKKys++n9bI/Q9hkJkmvp/nFK62pIcU2hlJeYcS175
	 SfvpAUuqKUwCBR3TNtP7Q6dj9BDx5Qea3K6BZT8q5YPGfkm1M3sG7OuvFUkV2JvEk3
	 WSz2oOuhSzRe/ZCURMfX8JEcGMrhXvXcf6iun4DGqXMepSbF6I88j2WOgxYfnnslhV
	 08YP1eHRE82wQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 13/14] Squash to "selftests/bpf: Add bpf_burst test"
Date: Thu, 28 Mar 2024 16:05:00 +0800
Message-Id: <7c3c0b349fbfbaa808e4d31bcec55e89a494e5db.1711612876.git.tanggeliang@kylinos.cn>
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

Now all ADDR_1, ADDR_2 and PORT_1 are replaced by ADDR1, ADDR2 and
PORT1, drop the definations of ADDR_1, ADDR_2, PORT_1.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index fd160fa04fb4..118b4698e1f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -571,41 +571,7 @@ MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
 MPTCP_SCHED_TEST(rr, 1, 1);
 MPTCP_SCHED_TEST(red, 1, 1);
-
-static void test_burst(void)
-{
-	struct mptcp_bpf_burst *burst_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	burst_skel = mptcp_bpf_burst__open_and_load();
-	if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(burst_skel->maps.burst);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_burst__destroy(burst_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_burst");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_burst");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_burst__destroy(burst_skel);
-}
+MPTCP_SCHED_TEST(burst, 1, 1);
 
 #define RUN_MPTCP_TEST(suffix)					\
 do {								\
@@ -623,6 +589,5 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
 	RUN_MPTCP_TEST(red);
-	if (test__start_subtest("burst"))
-		test_burst();
+	RUN_MPTCP_TEST(burst);
 }
-- 
2.40.1


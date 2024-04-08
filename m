Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBFC184D
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545279; cv=none; b=EPwEYBLhujQ/cHcV87ULUq8YuoHPhLlesPXYH5tCQQG3mUXmJWcSuIOPhbxbGBhSdI0PTgUq4cKd4moHiRLHw7jEFmqnhbLCysyco9aR3xy71ZsEfOJgSRI2SXUCOTpFXQUxJFCDP32La22zwIXdsCQIAOfL7OH9p6gfk/m/kb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545279; c=relaxed/simple;
	bh=S7AUp2qZf8k/T73vHb9lttnz3wUqv5fP9Bd7WLrerWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dEwi9NNrKT2vOTXUDyaQKMub1jxehyzTJGcMLih+wMyZiJljJ/esVHMZj2GHZcjt9P4/yZk+qM42mlT+JpgEuhAG8gTQU6RPBJgVEy4VwZAYEQVhPXsK0m2fMUf/ftKFB0vTdnvdMjfj7RJIs28iqAoG7wt7rmh8La319NunAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R62WpEM/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R62WpEM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36322C43390;
	Mon,  8 Apr 2024 03:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545279;
	bh=S7AUp2qZf8k/T73vHb9lttnz3wUqv5fP9Bd7WLrerWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R62WpEM/JBEYMNzqDdku3idbfBX7AOI151EQDIWDOwlTSp6C4NS0LNagP+9Fli5i1
	 Oi0l1nuCf8rhFJvnhYVXljMyCWpuEmtfLX2adspIxd013wG0zNdXdIHnV1h4bM3KVr
	 Fo/zrNa8geELxNhI/Q2ZJZEOMUUC3K+A5Ts85o3RAXMe2y2lbt/Z2fstp30EMPLvfY
	 AF6n/QCEzXnM5pwYj0RxXiYPx8wKn5m/REY1VQEmXaUWKfybnQHf7iJjrtzpYC1i7+
	 9AkRCG6m6k7WZ+inLPhn1xmlYuwF/c/ZpDo4syGepRDs237nRBohrjhXC0Ro6ZKf48
	 RLGbBHxkgB//w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 2/9] Squash to "selftests/bpf: Add bpf scheduler test" 1 verify
Date: Mon,  8 Apr 2024 11:01:04 +0800
Message-Id: <05269e97e219cc51b59173f05ab3a3b622a3ca1a.1712544986.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712544986.git.tanggeliang@kylinos.cn>
References: <cover.1712544986.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add send_data_and_verify helper to avoid duplicated code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 40 ++++++++++++++-----
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c29c81239603..5080e680fbe0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -457,23 +457,44 @@ static int has_bytes_sent(char *addr)
 	return system(cmd);
 }
 
-static void test_default(void)
+static void send_data_and_verify(char *sched, char *addr1, char *addr2)
 {
 	int server_fd, client_fd;
-	struct nstoken *nstoken;
 
-	nstoken = sched_init("subflow", "default");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
-		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (CHECK(server_fd < 0, sched, "start_mptcp_server: %d\n", errno))
+		return;
+
 	client_fd = connect_to_fd(server_fd, 0);
+	if (CHECK(client_fd < 0, sched, "connect_to_fd: %d\n", errno))
+		goto close_server;
 
-	send_data(server_fd, client_fd, "default");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+	send_data(server_fd, client_fd, sched);
+
+	if (!strcmp(addr1, "WITH_DATA"))
+		CHECK(has_bytes_sent(ADDR_1), sched, "should have bytes_sent on addr1\n");
+	else if (!strcmp(addr1, "WITHOUT_DATA"))
+		CHECK(!has_bytes_sent(ADDR_1), sched, "shouldn't have bytes_sent on addr1\n");
+	if (!strcmp(addr2, "WITH_DATA"))
+		CHECK(has_bytes_sent(ADDR_2), sched, "should have bytes_sent on addr2\n");
+	else if (!strcmp(addr2, "WITHOUT_DATA"))
+		CHECK(!has_bytes_sent(ADDR_2), sched, "shouldn't have bytes_sent on addr2\n");
 
 	close(client_fd);
+close_server:
 	close(server_fd);
+}
+
+static void test_default(void)
+{
+	struct nstoken *nstoken;
+
+	nstoken = sched_init("subflow", "default");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
+		goto fail;
+
+	send_data_and_verify("default", "WITH_DATA", "WITH_DATA");
+
 fail:
 	cleanup_netns(nstoken);
 }
@@ -663,8 +684,7 @@ void test_mptcp(void)
 {
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
-	if (test__start_subtest("default"))
-		test_default();
+	RUN_MPTCP_TEST(default);
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.40.1


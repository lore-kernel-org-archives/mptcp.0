Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546E127B40
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235840; cv=none; b=l6dLy0NX6JvjWJvsv2cs3dNBQSOMNo5nUASAiwRlxI3CShxTzPW8uytruwLJcNsAUxqpHatavco5dpck7PIJqZA9XjpphuSZvTp9godjmqr8+zKvnSsmEbzwM4pluvN2zChbzWck/sBgAYEwztbCE3G5ZdTYzQmKtCBR+CNgNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235840; c=relaxed/simple;
	bh=Oc2fud9rU8Lxpf+o18FuZPvALjPojBs4zMDfU3lEsSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INZ89RXikVEqaOd368oI+YjeLyVSZlUUd+E6tA/L3KpNsFxiLZooMLEnvONp0gqc0C5PW78nofvTUzb52EdfZnFPyMIwbnTur8XesJBPkQoVlwdvVLxjAm33ZftdpbkdZN7Y0XvKKwVdYeqwQ9ejbm1wR2GU2M35FIQ7TFdI8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLDaIIFv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLDaIIFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB93C43399;
	Thu,  4 Apr 2024 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712235839;
	bh=Oc2fud9rU8Lxpf+o18FuZPvALjPojBs4zMDfU3lEsSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLDaIIFvwsGbQtAo3msZnKP4PdCNKIbd8lARHYkr1kTkr/KG8alSkSeaHcz7e2vJ8
	 pdi3zx1P7Qu4f9FLISO57edYOkDtwur19qxdGKbLzL57Z/0hzHNznsJ8RRbUBIj1+7
	 7h48WyhPU6uylIWb513R+0iF6G5H0vS52YoRnzUXnL/YAwzzUaZypE5UAYo6QLjT62
	 P5ewb19vEWlPidwx0g7tR5D8bmOeyb2POr/EeITLsx2jAByPZtfVEuxz3vz9TYC+Ew
	 INYlARa1OeVfT+GdE70b8Z+wmbEC/PS5AVoKXcH95OvOOZIl1KP/nFJ+s4xwe2Fjhr
	 FHltemSmZ5TOQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 2/9] Squash to "selftests/bpf: Add bpf scheduler test" 1 verify
Date: Thu,  4 Apr 2024 21:03:04 +0800
Message-Id: <266c39f2ef6f77d139b0abb015b255a0dfb2307c.1712235379.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712235379.git.tanggeliang@kylinos.cn>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add send_data_and_verify helper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 40 ++++++++++++++-----
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c29c81239603..e1114745da63 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -457,23 +457,44 @@ static int has_bytes_sent(char *addr)
 	return system(cmd);
 }
 
-static void test_default(void)
+static void send_data_and_verify(char *msg, int addr1, int addr2)
 {
 	int server_fd, client_fd;
-	struct nstoken *nstoken;
 
-	nstoken = sched_init("subflow", "default");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
-		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_NEQ(server_fd, -1, "start_mptcp_server"))
+		return;
+
 	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_NEQ(client_fd, -1, "connect_to_fd"))
+		goto close_server;
 
-	send_data(server_fd, client_fd, "default");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+	send_data(server_fd, client_fd, msg);
+
+	if (addr1)
+		ASSERT_OK(has_bytes_sent(ADDR_1), "Should have bytes_sent on addr1");
+	else
+		ASSERT_GT(has_bytes_sent(ADDR_1), 0, "Shouldn't have bytes_sent on addr1");
+	if (addr2)
+		ASSERT_OK(has_bytes_sent(ADDR_2), "Should have bytes_sent on addr2");
+	else
+		ASSERT_GT(has_bytes_sent(ADDR_2), 0, "Shouldn't have bytes_sent on addr2");
 
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
+	send_data_and_verify("default", 1, 1);
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279638DD2
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042167; cv=none; b=iQc1E/I3UF2g28JVm+Sgjbik8RjckxvVRvN7xDqW47iD248QcK8bk/9Ky+yiB7glGR5TUEqiEN2vMNDwK26zudSw9Y89Ph54lQnhsEul7SJEYYwxvH7l11FYjztHQID4x8/wjz/WG57U6W8Bmk5Cc/ORnSnSVqDHwyjpusjw2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042167; c=relaxed/simple;
	bh=RH4KN2+5DJ1d8MBkcVtP10+jza6kUsMOWUgO5//xzQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrsPyC21f4HaiX+ZQGa3RN9aT51MjJgpZM34fO51oGxPvYfcf5kN1lSFVru442aTKynSdc8pAQkOR4VYZ2UHaHfQ5lsw0ay8gAJPJNxw2dE5rjup7UaOcb3EWMHonXT8/otMndkpxloQzUaDxEeUxyajZCjYIoxH8bFpp6OJNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbEvCqd6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbEvCqd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE9AC433C7;
	Tue,  2 Apr 2024 07:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042167;
	bh=RH4KN2+5DJ1d8MBkcVtP10+jza6kUsMOWUgO5//xzQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbEvCqd6qRDJflCqR1twNx2DHqC2su0dXY8gGhQMTJKxXqkcW5rWGb0QrViYyXPTM
	 5R7lFSCYXSszztgiOcmIiD93B0GGVsu01DB1KHH6Pi/3R2VUoURNn+FmWhiN6njf8A
	 GrzDa2/WwLZQ8/UDXi0vzFxDkdMDak2R7ukqrqWhYX5c+ATOxtj8qC2L3KmWhdb7Wc
	 NxiRnfQLTq1otEprPTtUjKsswdKk/Vfz8Dk9uQ25VCxJOMrbbOFMOsxHe50nJim+wj
	 x0t7DxG3oAQkrmfPM/sbha7ZD3q82qUyv+GpBPk4ZIpKQnm2BPVHKWD6R/1+EsTNCc
	 SZDt3quMGtOvQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 03/10] Squash to "selftests/bpf: Add bpf scheduler test" 2 verify
Date: Tue,  2 Apr 2024 15:15:51 +0800
Message-Id: <8d65c3542108e663b4c204cd3ea1945f97e350ff.1712042049.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042049.git.tanggeliang@kylinos.cn>
References: <cover.1712042049.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 44 ++++++++++++++-----
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index faa0dc37b78e..24cd0edc03fc 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -465,24 +465,47 @@ static int has_bytes_sent(char *addr)
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
 
-	set_nonblock(server_fd);
-	send_data(server_fd, client_fd, "default");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+	if (set_nonblock(server_fd))
+		goto close_server;
+
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
@@ -673,8 +696,7 @@ void test_mptcp(void)
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


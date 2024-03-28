Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2452F86
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613122; cv=none; b=YrQ+3OYkFu4eRzsYbSNmmOpzlTKGtTFh6EkNqe5rImTiP0eYgkwhxv/VOdMmby7+q5Ev315l5bJEqKc5Gx/WSDKq3Jzwj0rJJtjiH359FxArlaxBFh3pRvSjUrlM6u2LE9bwpHbMqd/AFcqTWdRPEjQsqZ/qGAEUOCIm/tEeej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613122; c=relaxed/simple;
	bh=mMydanxeS5cvc1mWabkhJdwudCcA5dQTfN9DAPHrNRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4xw9xwfbT4mJimbVLZ1gN4rS2zg/hab1lXG++ExYzA1Fzd216DmH3eVulL8cvqgAI4sZ/xYqpyTqiFA1Oc7/LEgI293Sml8tn0vNVEBvzlHUEB4eyDnjBCRgI4vzJZEJcwMqz9uAaJ/yzVY0nit61/6Twq0IxDvWf0ElePZbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJGGbEJN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJGGbEJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E095C433C7;
	Thu, 28 Mar 2024 08:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613122;
	bh=mMydanxeS5cvc1mWabkhJdwudCcA5dQTfN9DAPHrNRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJGGbEJNj8k3RtQKsP/XqWhu0B17eZyAtaxdutFOx/sUq2zQhqBMS7Sl/d3Bae+/Z
	 IbVxZUj3qP4Oko+IxHvfOnWzcxYYnF+ZinSNWXVrr5eXadW+5MRQdRiO60omH2B48Y
	 23L6ueV4Z9OxaasFKcqkLxzsXn8h1FU2lCzfPUn9ESUzxZanCXESKt8m1aSImCUvjB
	 2Tw4T3JdxaR8QJtu++Or4msHHzZXxpYc04Upi6IVqL1MSzJ+q2hUxe2ajPXCisumRz
	 IUABw86vKt9CW5/xcfj4ue3gvPFn2j6s1AiHZk1J7xvbbPQ7VG5+yCyykTNSeRRO4R
	 VyVrVm2RZvcoA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 04/14] selftests/bpf: Add MPTCP_BASE_TEST macro
Date: Thu, 28 Mar 2024 16:04:51 +0800
Message-Id: <0826f58a9667fa2a317345eaf7f60fd8fc8fa733.1711612876.git.tanggeliang@kylinos.cn>
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

This patch adds a macro MPTCP_BASE_TEST to unify all MPTCP tests.
test_mptcp_sock() can be replaced by MPTCP_BASE_TEST(mptcp_sock),
and test_mptcpify() can be replaced by MPTCP_BASE_TEST(mptcpify).

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 93 +++++++------------
 1 file changed, 33 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cc91acfa3e52..ac3886983ce1 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -209,37 +209,40 @@ static void run_mptcp_sock(int cgroup_fd, struct mptcp_sock *skel)
 	close(server_fd);
 }
 
-static void test_mptcp_sock(void)
-{
-	struct nstoken *nstoken = NULL;
-	struct mptcp_sock *sock_skel;
-	int cgroup_fd, err;
-
-	cgroup_fd = test__join_cgroup("/mptcp");
-	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
-		return;
-
-	sock_skel = mptcp_sock__open_and_load();
-	if (!ASSERT_OK_PTR(sock_skel, "skel_open_load"))
-		goto out;
-
-	err = mptcp_sock__attach(sock_skel);
-	if (!ASSERT_OK(err, "skel_attach"))
-		goto out;
-
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
-		goto fail;
-
-	run_mptcp_sock(cgroup_fd, sock_skel);
-
-fail:
-	cleanup_netns(nstoken);
-	mptcp_sock__destroy(sock_skel);
-out:
-	close(cgroup_fd);
+#define MPTCP_BASE_TEST(name)					\
+static void test_##name(void)					\
+{								\
+	struct nstoken *nstoken;				\
+	struct name *skel;					\
+	int cgroup_fd, err;					\
+								\
+	cgroup_fd = test__join_cgroup("/" #name);		\
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))	\
+		return;						\
+								\
+	skel = name##__open_and_load();				\
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))		\
+		goto out;					\
+								\
+	err = name##__attach(skel);				\
+	if (!ASSERT_OK(err, "skel_attach"))			\
+		goto out;					\
+								\
+	nstoken = create_netns();				\
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))		\
+		goto fail;					\
+								\
+	run_##name(cgroup_fd, skel);				\
+								\
+fail:								\
+	cleanup_netns(nstoken);					\
+	name##__destroy(skel);					\
+out:								\
+	close(cgroup_fd);					\
 }
 
+MPTCP_BASE_TEST(mptcp_sock);
+
 static void send_byte(int fd)
 {
 	char b = 0x55;
@@ -302,37 +305,7 @@ static void run_mptcpify(int cgroup_fd, struct mptcpify *skel)
 	close(server_fd);
 }
 
-static void test_mptcpify(void)
-{
-	struct nstoken *nstoken = NULL;
-	struct mptcpify *mptcpify_skel;
-	int cgroup_fd;
-	int err;
-
-	cgroup_fd = test__join_cgroup("/mptcpify");
-	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
-		return;
-
-	mptcpify_skel = mptcpify__open_and_load();
-	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
-		goto out;
-
-	err = mptcpify__attach(mptcpify_skel);
-	if (!ASSERT_OK(err, "skel_attach"))
-		goto out;
-
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
-		goto fail;
-
-	run_mptcpify(cgroup_fd, mptcpify_skel);
-
-fail:
-	cleanup_netns(nstoken);
-	mptcpify__destroy(mptcpify_skel);
-out:
-	close(cgroup_fd);
-}
+MPTCP_BASE_TEST(mptcpify);
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int stop, duration;
-- 
2.40.1


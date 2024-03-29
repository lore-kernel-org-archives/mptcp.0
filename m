Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC36381B8
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688228; cv=none; b=R9XQTB92DP1MSJDVnvmWU2LtfxAOcU1jNAGSGo+dQafJNb44pvMrcEMa1qGLp3fqvOBpqCPFrOUzlCAbuyz/mlbssgBMSIw1chcJ6Oc5eErow9Gg02lS71u14W4G8Otg/tnuGG8ZIappol4EaVNvjLKWuctki2GV+7FcSv0Abs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688228; c=relaxed/simple;
	bh=UgbeSmkE0aF0ONsdHQ+YWiy++0eoHIDRRz0T6CWypyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smarKBJq1FeiyLRrjR01Yp9pnf26JOOO+MqT64z6dVdpBF/fxDHBozkMKsRT4d7xZm4o85eZSCHWI+r2auVBjcTYWnpUyCWTWzfkRujf3qLUGIpW4GNRwh+jVLMDg/DsYnlVLlFMjnG9Ddqi9oLSTWvz5S73zTqqp5lpbVmHMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0nl0pI0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0nl0pI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EE0C433C7;
	Fri, 29 Mar 2024 04:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688228;
	bh=UgbeSmkE0aF0ONsdHQ+YWiy++0eoHIDRRz0T6CWypyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0nl0pI0X+KHM0ihn8DDbbJWnuHyclaDZw01hFTA+NltGXw92ykEhZgpJwyABQvTS
	 JZht/CLzXPtbT1pVNcAv8zC7g8SeRC5kWGr8YAj4lJTOvhuKG6fono9BONoo69OD78
	 Vp7vxoFZwq00N//T9J97G8nf9fN50CInG6uF14k6RCFLsd3Ncm77IQl8t0Ojh64M3f
	 NRdJy8FhXJWgpo+B32o/T7NVidMeBK7eSE0gEqDgMeLv7W9ZqZ3Kydkk/fKTY+E/78
	 mp/NPjOMqbfjZzlJfd4mNSX4GsCOkpLns6dl5dU/MyTs8d4M2YhpZ968BifE8e4PCT
	 we97RNc5gH+TA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 07/15] selftests/bpf: Add MPTCP_BASE_TEST macro
Date: Fri, 29 Mar 2024 12:56:03 +0800
Message-Id: <bf646b7844d947e95757cba7bfe0b4d5cb049179.1711688054.git.tanggeliang@kylinos.cn>
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

This patch adds a macro MPTCP_BASE_TEST to unify all MPTCP tests.
test_mptcp_sock() can be replaced by MPTCP_BASE_TEST(mptcp_sock),
and test_mptcpify() can be replaced by MPTCP_BASE_TEST(mptcpify).

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 93 +++++++------------
 1 file changed, 33 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8c897e626a2b..c6185217fef5 100644
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
 static int verify_mptcpify(int server_fd, int client_fd)
 {
 	struct __mptcp_info info;
@@ -295,37 +298,7 @@ static void run_mptcpify(int cgroup_fd, struct mptcpify *skel)
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E69F2C689
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042681; cv=none; b=UxclCUMfVysU0e8w3aJfMc/7a7ORpMpiOv4pT2EF/bJ7JQsGZOO62PlV/qbYOLvFTpDIZwH+BxNGDqEZKWmxdIUoeTLo94zvsHLr/9yavVQ+Sx1ZSad/xysBhcgBBgN+GR5U43gC2khwlpdz3VV7yFEjB26CegOI0XDctaT/T+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042681; c=relaxed/simple;
	bh=Q6+wPctNK0o2VvW5wDpdo4zVWpzhVway4GF7pt3FD1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpX6xaQ8YZXpwqr88VHLGcgeLcDpecVsU6cDX/uRpog/iHcl0kea2sZoGOdz76aYXYvqPpeBYIVnX5vmXeBmCFOjk8Cg5wEZY7GriUBXLqwnq8SHcyLFLaHg150TytuIHGJF3XHOuVjBxeKWdvh6jjGgI1sz6EOw2EufEy1gEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiOc4sh7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiOc4sh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A718C43399;
	Tue,  2 Apr 2024 07:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042681;
	bh=Q6+wPctNK0o2VvW5wDpdo4zVWpzhVway4GF7pt3FD1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiOc4sh7eSq7SYXk0JQyBwFBOaM6DOV83dGBCU5UWjM9secngltu6zjrUgTkQVdD9
	 uodi+xF3kepsyFmkCiuu30AGAGTlfO+hkf1pPcHRt1rLWhUEEII/GAgBzSfluZIHYv
	 ZLk4xFppkmC/ArJAVMkD6gPM7GyvdnM+aqBfmQ7WLzbmOpy89vuRMdCddHLfxEMUEn
	 krugd1TLcMXI/ZjFhJb8Ka5IqGyukf7mv9+N9jINLyq4ulZYFOEtBduVOi85xkPLD0
	 RTv54sjm432jYt8psZ/VnOPlxTybq2X5dA/xm9C+wi8b/XrtQoJn2p+KIuPtd6nqs7
	 A2HXR08+V/bXQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 5/8] selftests/bpf: Add MPTCP_BASE_TEST macro
Date: Tue,  2 Apr 2024 15:24:25 +0800
Message-Id: <30f9ba0f3b08b5be92653a9328007a16bbff8720.1712042529.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042529.git.tanggeliang@kylinos.cn>
References: <cover.1712042529.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 98 +++++++------------
 1 file changed, 35 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 50a932e3ad23..6043947f178c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -224,37 +224,6 @@ static void run_mptcp_sock(int cgroup_fd, struct mptcp_sock *skel)
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
-}
-
 static int verify_mptcpify(int server_fd, int client_fd)
 {
 	struct __mptcp_info info;
@@ -310,43 +279,46 @@ static void run_mptcpify(int cgroup_fd, struct mptcpify *skel)
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
-
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 #define ADDR_1	"10.0.1.1"
 #define ADDR_2	"10.0.1.2"
 #define PORT_1	10001
 
+#define MPTCP_BASE_TEST(name)					\
+static void test_##name(void)					\
+{								\
+	struct nstoken *nstoken;				\
+	int cgroup_fd, err;					\
+	struct name *skel;					\
+								\
+	cgroup_fd = test__join_cgroup("/" #name);		\
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup " #name))	\
+		return;						\
+								\
+	skel = name##__open_and_load();				\
+	if (!ASSERT_OK_PTR(skel, "skel_open_load " #name))	\
+		goto close_cgroup;				\
+								\
+	err = name##__attach(skel);				\
+	if (!ASSERT_OK(err, "skel_attach " #name))		\
+		goto skel_destroy;				\
+								\
+	nstoken = create_netns();				\
+	if (!ASSERT_OK_PTR(nstoken, "create_netns " #name))	\
+		goto skel_destroy;				\
+								\
+	run_##name(cgroup_fd, skel);				\
+								\
+	cleanup_netns(nstoken);					\
+skel_destroy:							\
+	name##__destroy(skel);					\
+close_cgroup:							\
+	close(cgroup_fd);					\
+}
+
+MPTCP_BASE_TEST(mptcp_sock);
+MPTCP_BASE_TEST(mptcpify);
+
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
-- 
2.40.1


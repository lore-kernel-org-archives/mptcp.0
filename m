Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19928EF
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467180; cv=none; b=Sej1PtaZ/sWj3Aj1zeG+YwfhF3YW5n+9xHzU+EbHRqAwqzD874PbzgTbPR5JVhQ5vKPuJW3CCRClrAGQnZ6Vs7g3xixoQT00Ng2eYAmF6kgXvcUSaI1g4Di4NkOClw87wAEIMAvpuJvj4HxrFkfaNCl/DxRAbuU8k6fBNrd+P2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467180; c=relaxed/simple;
	bh=oumnZN7lfeBZipt/q7v7JY9vEXkhK5S+dRHfm39SAWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJ2bUp8LCfy5U39Xs/iJiS+xToM9Fqc/QWuFTBWQVg8mQWP4xW88cRr7GmQMTpQen6qXm1HE2Z08YfyHb5or/MUU8XSp3O7+DmCckSNv3xks87sxyeEBYYfI8cZXk8Y0j5aXR2Z11VgE9OKm0t3SFzCOAx0QhfxjugmiwBgTPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzuKt8d6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzuKt8d6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2564DC4CECF;
	Wed,  9 Oct 2024 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728467180;
	bh=oumnZN7lfeBZipt/q7v7JY9vEXkhK5S+dRHfm39SAWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzuKt8d6P+GzuDXkrZiA0jEI6QjY1UzAn42P5ZD08aMJZi4Qconwh2T5KzZujrwQy
	 yZd3FfjrTyvjH/NvPuPfW5eCpiA+RIU+D2JeR331/EUYJGeFtYN1H13yyKrsHSWmsY
	 Ti683E5J+s5dPwdU6IiK9GraaxS8ZIBuIcWde0m/25j/kGpetxEVibxJCJLhuWshHX
	 iJSZmoPrQ9UkVZz6ELfQ/PGuDOa4iNM6cJBDTluqlDGRCTVP19mV5cwk9La2BTvKex
	 5xLbu9VzclVZbqjZ2HnqzpLmUqfxMkOD22ciyb/EUF4JH9lrmpq2z6YxWC4kpN9SaO
	 bf5u1IFOah3qA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 7/7] selftests/bpf: Add mptcp_subflow bpf_iter subtest
Date: Wed,  9 Oct 2024 17:45:49 +0800
Message-ID: <faec8ca119ef4fdefb28f44b8c699e38c3eb8daa.1728466623.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728466623.git.tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest named test_iters_subflow to load and verify the
newly added mptcp_subflow type bpf_iter example in test_mptcp. Use the
helper endpoint_init() to add 3 new subflow endpoints. Send a byte of
message to start the mptcp connection, a new helper recv_byte() is added
to receive this message. send_byte() is invoked again to trigger the ftrace
hook for mptcp_sched_get_send() after wait_for_new_subflows(). Check if
skel->bss->subflows equals 4 to verify whether the "fentry" program loops
fourth as expected.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 64b5ce25e1a1..589420f42845 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_iters_subflow.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -261,6 +262,19 @@ static void send_byte(int fd)
 	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
 }
 
+static int recv_byte(int fd)
+{
+	char buf[1];
+	ssize_t n;
+
+	n = recv(fd, buf, sizeof(buf), 0);
+	if (CHECK(n <= 0, "recv_byte", "recv")) {
+		log_err("failed/partial recv");
+		return -1;
+	}
+	return 0;
+}
+
 static int verify_mptcpify(int server_fd, int client_fd)
 {
 	struct __mptcp_info info;
@@ -501,6 +515,68 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
+static void run_iters_subflow(void)
+{
+	int server_fd, client_fd, accept_fd;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		goto close_server;
+
+	accept_fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_OK_FD(accept_fd, "accept"))
+		goto close_client;
+
+	send_byte(client_fd);
+	wait_for_new_subflows(client_fd);
+	recv_byte(accept_fd);
+	send_byte(client_fd);
+
+	close(accept_fd);
+close_client:
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_iters_subflow(void)
+{
+	struct mptcp_bpf_iters_subflow *skel;
+	struct nstoken *nstoken;
+	int subflows = 4;
+	int err;
+
+	skel = mptcp_bpf_iters_subflow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: iters_subflow"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = mptcp_bpf_iters_subflow__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach: iters_subflow"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns: iters_subflow"))
+		goto skel_destroy;
+
+	if (endpoint_init("subflow", subflows) < 0)
+		goto close_netns;
+
+	run_iters_subflow();
+
+	ASSERT_EQ(skel->bss->subflows, subflows, "subflows");
+
+close_netns:
+	cleanup_netns(nstoken);
+skel_destroy:
+	mptcp_bpf_iters_subflow__destroy(skel);
+}
+
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -682,6 +758,8 @@ void test_mptcp(void)
 		test_mptcpify();
 	if (test__start_subtest("subflow"))
 		test_subflow();
+	if (test__start_subtest("iters_subflow"))
+		test_iters_subflow();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.43.0


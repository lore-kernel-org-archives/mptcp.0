Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806182A1B8
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023791; cv=none; b=ATmdieJdIXRaKRPbggZUz9nj6qT67xFq9qHB5BymdaAKw3/2KyMZTuHgoPoRihZTYdLaPJMQDvFriuqedJ4amUQMnG5w8kxqa2BlhuFz3K6DY8lxHkFTbkVrcBVYko7oilveAXKhUvWrRZi3G+lR7+tkDbCVCsQmUJsfgbp64Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023791; c=relaxed/simple;
	bh=nTdXKO35pRYXkkantGCnoyP0uincnrXD0t5fxqzt93w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUucV46xaT2c/uvUjl0Pdu586jh0Bzr9Obv9tgLnOzG1cPj3ik++6b2PBFI7Di83mfc7hDkQBdxpKQ5x5MUTaIF30gvVAQJx9LzjjHQYimlY54+4FpLPLB2FH+Svd8yVf/Sk0PtyyH0UaZqx9UtnT6CWPGb7nOGHShOcAMGD02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9YGIuRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9YGIuRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9608C4CEC3;
	Wed, 11 Sep 2024 03:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726023791;
	bh=nTdXKO35pRYXkkantGCnoyP0uincnrXD0t5fxqzt93w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9YGIuRdrf/T5SucOgua7E4FtLRCVyK7n6AOoF7Kt0hlUOoN08Iwzd2xmFvqG+Sti
	 DzmhzdF99aHBTq5C66+0Q5flBerMwGxY23XUHISmuqheLzsByCjGQ4aFFETur/v5n0
	 PQORr7Y79tVdxbsiB8etWvyhzpgEFnjjlIIyfE6qQJU5ywkX84mS+qKXHSUfGnQHGj
	 YaiUBpyujw2rtfzmzyI5uYsATcNSHdiZrfWjKTUPqnQ7HefXMP85yzUZDG2oe5YiTt
	 o87gFvGsbCXJtPN5UgR8YkYBIMAdkzFXjhpHPNweif1qNnVjfntcLJj5bG+GKpWvHt
	 i3qG4XX3sClkw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/5] selftests/bpf: Add mptcp_subflow bpf_iter subtest
Date: Wed, 11 Sep 2024 11:02:57 +0800
Message-ID: <07fb62076430d7f79752f0d60259ad3f2f4902f6.1726023577.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726023577.git.tanggeliang@kylinos.cn>
References: <cover.1726023577.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest named test_bpf_iter to load and verify the newly
added mptcp_subflow type bpf_iter example in test_mptcp. Use endpoint_init()
to add a new subflow endpoint. A new helper recv_send() is invoked to trigger
the ftrace hook for mptcp_sched_get_send() after wait_for_new_subflows().
Check if skel->bss->iter equals 2 to verify whether the ftrace program loops
twice as expected.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a3e68bc6afa3..bb40c1f35918 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_iter.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -259,6 +260,34 @@ static void send_byte(int fd)
 	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
 }
 
+static int recv_send(int server_fd)
+{
+	char buf[1];
+	int ret, fd;
+	ssize_t n;
+
+	fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_OK_FD(fd, "accept"))
+		return -1;
+
+	n = recv(fd, buf, sizeof(buf), 0);
+	if (!ASSERT_GT(n, 0, "recv")) {
+		ret = -1;
+		goto close;
+	}
+
+	n = send(fd, buf, n, 0);
+	if (!ASSERT_GT(n, 0, "send")) {
+		ret = -1;
+		goto close;
+	}
+
+	ret = 0;
+close:
+	close(fd);
+	return ret;
+}
+
 static int verify_mptcpify(int server_fd, int client_fd)
 {
 	struct __mptcp_info info;
@@ -471,6 +500,60 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
+static void run_bpf_iter(void)
+{
+	int server_fd, client_fd;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		goto close_server;
+
+	send_byte(client_fd);
+	wait_for_new_subflows(client_fd);
+	recv_send(server_fd);
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_bpf_iter(void)
+{
+	struct mptcp_bpf_iter *skel;
+	struct nstoken *nstoken;
+	int err;
+
+	skel = mptcp_bpf_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_iter"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = mptcp_bpf_iter__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach: mptcp_iter"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_iter"))
+		goto skel_destroy;
+
+	if (endpoint_init("subflow") < 0)
+		goto close_netns;
+
+	run_bpf_iter();
+
+	ASSERT_EQ(skel->bss->iter, 2, "iter");
+
+close_netns:
+	cleanup_netns(nstoken);
+skel_destroy:
+	mptcp_bpf_iter__destroy(skel);
+}
+
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -652,6 +735,8 @@ void test_mptcp(void)
 		test_mptcpify();
 	if (test__start_subtest("subflow"))
 		test_subflow();
+	if (test__start_subtest("bpf_iter"))
+		test_bpf_iter();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.43.0


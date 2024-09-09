Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8DA125B9
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845823; cv=none; b=kHSzrgLS/3y0EWQxHPEciYCDkx1jJqPmGWMjaGeKYirXXisOsPGaE9gGy5jzLpeDRQW7rvHlmhH01xQqwUZ517/KKLiTCn62h2/PcVfu/zFvXLcrQCSYMKaLjSCOXQIaN7Z5IWwSQ771USKpqPioVoWT0mZtTjAICAdcJlUfN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845823; c=relaxed/simple;
	bh=f3t6MWz0aO+H6ULFGwOIbEMQGgnzS1hHj5xLwgrgTew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5uet/dms0/gYCeBIKWLHyGAZI6PG9c/GuG4F4OFkUVRxyMjOpbBrqXmU17oiu+BcPjzudyt+nvzQi9K0kL+FYhsQaenLLXL+VjZ1dJQjnY+liWSudl2/+O7rsdYc3uLXqG8yVwBfK79JkyIuOmIUXtDvPJ1CmVue/P4vg5oFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+aoZxkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+aoZxkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB713C4CEC3;
	Mon,  9 Sep 2024 01:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725845822;
	bh=f3t6MWz0aO+H6ULFGwOIbEMQGgnzS1hHj5xLwgrgTew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+aoZxkGS0DT1HCMZ5KnjpS2KogJoCycd3/cm4y+f8jm3pxpM+O1U9NqBI0GJ2sO7
	 hMQWe26JUDe4m7jziNXdrXOryJENNQT/3qKBT8hbjONWKQnv6V6zjixRJDNSvoptE7
	 lZfYmKZJ0XloJYK43Bk4dGavH2WGwBcAXl+WyqqCj8H2xdRNQ6bL7cyq1OydbExVsS
	 O/VoFRu9yeI6huRBu3OPTOkoh7C9MeoA1ZjWdQGQDnwrY1Gt8F7vlxuhuVyYe1MeDK
	 kXwHG4StYbZtWXg3kscHy1N8olT/lfEo6PrHRm4YdYedL+maDUSLEm/9tXPR2K2F/I
	 wF898yLIStRDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/4] selftests/bpf: Add mptcp_subflow bpf_iter subtest
Date: Mon,  9 Sep 2024 09:36:47 +0800
Message-ID: <7a10b2fcb5910bfbd6884421e165b0fc36416b3f.1725845619.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725845619.git.tanggeliang@kylinos.cn>
References: <cover.1725845619.git.tanggeliang@kylinos.cn>
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
index 93869c873cad..9217566446b1 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,6 +10,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_iter.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -258,6 +259,34 @@ static void send_byte(int fd)
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
@@ -470,6 +499,60 @@ static void test_subflow(void)
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
@@ -651,6 +734,8 @@ void test_mptcp(void)
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


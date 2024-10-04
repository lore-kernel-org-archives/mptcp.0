Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD429422
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046275; cv=none; b=nRCy2ik2AedBL3o22Ag3s41Cbl0/GSr0/TNidYCnTkPGgwJTFAUlYym6vop+4I+bYjWA/TzKoouaOgx0iNWBXgnj+PFQWDGueFKcJ5yk8nfhze1yXdD/GObAk7gDzXQsuZp6Q7e/a0ZSDIHONaQn3t0umvdQQVsrp4hXp6q8wIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046275; c=relaxed/simple;
	bh=AFbkfTXQEhD8dHj3RRFAxacukbj8ZyyDHGS+UDqVU3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqRl49kr6GhwusbDQjobOEUfx6w/an5qI/upaSD3L6YM9MK32NIR9NJt4VDYpXIUal9lNu7RJlO/5DHxw+++Vg63kz4oFMpHcXqhFJcgHD7wIMmu3CKyBBCdsxCnLElly/StbMFnIHpkII+CP8pCrF6BsF3BEdyEiqndzNBmMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTWSOIcV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTWSOIcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17913C4E694;
	Fri,  4 Oct 2024 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046274;
	bh=AFbkfTXQEhD8dHj3RRFAxacukbj8ZyyDHGS+UDqVU3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GTWSOIcVsMDrbcKXG73ngi1be8tk4AAOtio10Qy0vDS+c54+k53p0WznFndNrewzX
	 WGjH6GFzLnbvho2MAyjLEcx9LSw9A5enwtfj5VGR5CRiH3KcfTgmve2BUMX8fFQTSL
	 xbVoakZX3k9qeLVgbLrp0QqVoSJiDaeX/3TOnyAO+hAvVcqfkOZHwsZPPeQe6fLqFN
	 2UX+Yvs13cuDc14yPJyHL67Mxdim178xDG+6CX/fKSBL6CDRnTEjDfEpq1aOAdRtWp
	 OKJrViO7OYsZfo4iyzzu2QACiwQ3xMB8eaoSboDLo63lgKWrk8pcWMPNiaMaaUkZGt
	 rfBB8FX2+FgFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 7/7] selftests/bpf: Add mptcp_subflow bpf_iter subtest
Date: Fri,  4 Oct 2024 20:50:53 +0800
Message-ID: <2876161b43f9011a78f61afcafa1a608bb591cff.1728046021.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046021.git.tanggeliang@kylinos.cn>
References: <cover.1728046021.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest named test_bpf_iter to load and verify the newly
added mptcp_subflow type bpf_iter example in test_mptcp. Use the helper
endpoint_init() to add 3 new subflow endpoints. A new helper recv_byte()
is invoked to trigger the ftrace hook for mptcp_sched_get_send() after
wait_for_new_subflows(). Check if skel->bss->subflows equals 4 to verify
whether the "fentry" program loops fourth as expected.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 64b5ce25e1a1..233da5317e47 100644
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
 
+static void run_bpf_iter(void)
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
+static void test_bpf_iter(void)
+{
+	struct mptcp_bpf_iter *skel;
+	struct nstoken *nstoken;
+	int subflows = 4;
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
+	if (endpoint_init("subflow", subflows) < 0)
+		goto close_netns;
+
+	run_bpf_iter();
+
+	ASSERT_EQ(skel->bss->subflows, subflows, "subflows");
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
@@ -682,6 +758,8 @@ void test_mptcp(void)
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


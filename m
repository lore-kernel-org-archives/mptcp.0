Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62863192B8F
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243156; cv=none; b=F/faJ1opBccy9vZbVGOvwAMjX9iwZjReWY6BJmVzg7pdWGBOdo1YZUTw2Iod9lotdfHTseST5jlh4CauGZYEOpSUx5kpyqt7bfX54yU82YH5qusvHMaj+FkXvC4VJHYbcN0j9Tmn9J/LyfrwCz0OJoFW7EloaEmWWX9CftRbqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243156; c=relaxed/simple;
	bh=qfonZmUyNt66WPclW0OyhIm/yyZMahz/mU5dvT5O6TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdJoSoU06YxsdDk3ARcOPOsTOxzdOeAQRQzPYIuMpSlLbFmMGkLodOBG7CGIKX0UCZB13hNPIiztedR6B5fp6G1fDhbOQ3l+s2lhGPjm1vlOCjv/OnwFwM0PyAhvbJbGVp1kzW6xPXnDPXU2CA2oM2bKYltAsnZfchE046PLBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOf80DJB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOf80DJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85ABC4CEC3;
	Fri, 18 Oct 2024 09:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243156;
	bh=qfonZmUyNt66WPclW0OyhIm/yyZMahz/mU5dvT5O6TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOf80DJB30kQSlLrQKDi43o5Rnur2tS5T6BkAfj5w8FUhMUtR4MD7m/He2gHtpyj+
	 digI1bW+nNOjDJ3XZx/tHlCrdYfIlKmNjKrlMEPPKEZRwfod6Gg/qH+u8AHs8SvcBf
	 /1J80pbZjiQlTQZewTCTKldY4dffXzLcAvwFkJXjf4sj2DnIn/rxO+WwIvMzI9zV2k
	 2KuEKKExF12rFw7lup/34vHDfVFMff21ntPYFLLfErelE8fGjTccFr99Yh+4C5YbxA
	 PLU4T3jZtsCuOQn2fi97aPuBYws4cG/ixBM5sLuybkXBk9Gg2nJFB+OCq/fY+RLbKN
	 XBl2OTV3VHXeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 6/9] selftests/bpf: Add mptcp_subflow bpf_iter subtest
Date: Fri, 18 Oct 2024 17:18:08 +0800
Message-ID: <67cbbd7ff515dcc421605b24c14c734fd3263e42.1729242644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729242644.git.tanggeliang@kylinos.cn>
References: <cover.1729242644.git.tanggeliang@kylinos.cn>
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
message to start the mptcp connection, and wait for new subflows to be
added. getsockopt() is invoked to trigger the "cgroup/getsockopt" test
program "iters_subflow". Check if skel->bss->ids equals 10 to verify
whether this mptcp_subflow bpf_iter loops correctly as expected.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 02fdff87df2d..0f00eef7aef5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_iters.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -509,6 +510,72 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
+static void run_iters_subflow(void)
+{
+	int server_fd, client_fd;
+	char cc[TCP_CA_NAME_MAX];
+	socklen_t len;
+	int err;
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
+
+	len = sizeof(cc);
+	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)"))
+		ASSERT_STREQ(cc, "cubic", "cc");
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_iters_subflow(void)
+{
+	struct mptcp_bpf_iters *skel;
+	struct nstoken *nstoken;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/iters_subflow");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: iters_subflow"))
+		return;
+
+	skel = mptcp_bpf_iters__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: iters_subflow"))
+		goto close_cgroup;
+
+	skel->links.iters_subflow = bpf_program__attach_cgroup(skel->progs.iters_subflow,
+							       cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.iters_subflow, "attach getsockopt"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns: iters_subflow"))
+		goto skel_destroy;
+
+	if (endpoint_init("subflow", 4) < 0)
+		goto close_netns;
+
+	run_iters_subflow();
+
+	ASSERT_EQ(skel->bss->ids, 10, "subflow ids");
+
+close_netns:
+	cleanup_netns(nstoken);
+skel_destroy:
+	mptcp_bpf_iters__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
+
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -690,6 +757,8 @@ void test_mptcp(void)
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


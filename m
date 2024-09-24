Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF180C13
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169013; cv=none; b=h0p2Jy7wC2ApKF7ceBNBa6BwAftbI1vcPnmkppM4lfIGu/xuhS5Tfs/34aB0u5IAjtnnDE4b5AdXBQl9TOf2qoRlXeEelD2RqCOGpT9rxH+pix58PqNZrf8ZoOmgy+o26J8x7e+YBXq1hi+3Y2+iAVGZ3snGWJzaq6TQPTWCjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169013; c=relaxed/simple;
	bh=B7s0zwGCgU+HdlcKYACzKEwnf2YnbwVokt52vAuWwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=patEYYZyCfqsbTYhs3z8dNjsOD9cR6XISXJFr3w6kn75nKgR4vSXMSd1iif9wEKflru+Uy5ZhFLkrlQK2CiPYGtQ1eB7d5iVS4WP/voDsYyvBlCtszw7FMai9Bgr8fTRdkWVicH3XMcxzLs7dyUYyuUPun73dqxPW/IwqW2Brjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMAnKrqS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMAnKrqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF43C4CEC6;
	Tue, 24 Sep 2024 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169012;
	bh=B7s0zwGCgU+HdlcKYACzKEwnf2YnbwVokt52vAuWwXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMAnKrqS++mQDitqnloL1CcTiLr8gxERPOZGKZV+rbEwr/kuW/dXBLc/Him3h/R/4
	 IQvyEzGVDsUR0jbBfEPTdOM7WkOGxs0wtSniJOW3X3PVjg/3maSObCUTPdTF6PXOsS
	 g7DFEVHeiD1DpjpJhKj1znddrYOy3OA/WOH6lGSK5I2zomuKEeOxA+6ZSrVumZtWez
	 V4jsiDzTEIHdXZA/p+Q9zGE5y7iWpDwLMBQs9IN56UAvNVwYEuw8kSvBwGAiFuwB/3
	 caAOLCfOFIv72mHlkXi5gHKs0Mn7KopYvXCOFPx6MgKTrfTNdGHLzsyGC2mjfg0rIO
	 grvBVOKGejA2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 06/10] selftests/bpf: Add mptcp_subflow bpf_iter subtest
Date: Tue, 24 Sep 2024 17:09:50 +0800
Message-ID: <1bb28d77c41cd9f6eb1c23e447d3537f2025c31d.1727168628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
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
endpoint_init() to add 3 new subflow endpoints. getsockopt(TCP_CONGESTION)
is invoked to trigger the "cgroup/getsockopt" program after
wait_for_new_subflows(). Check if skel->bss->subflows equals 4 to verify
whether the "cgroup/getsockopt" program loops fourth as expected.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 076903680e75..29bd840422af 100644
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
@@ -501,6 +502,77 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
+static void run_bpf_iter(void)
+{
+	int server_fd, client_fd, err;
+	char new[TCP_CA_NAME_MAX];
+	char cc[TCP_CA_NAME_MAX];
+	socklen_t len;
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
+	len = sizeof(new);
+	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, new, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)")) {
+		get_msk_ca_name(cc);
+		ASSERT_STREQ(new, cc, "cc");
+	}
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
+	int subflows = 4;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcp_iter");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_iter"))
+		return;
+
+	skel = mptcp_bpf_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_iter"))
+		goto close_cgroup;
+
+	skel->bss->pid = getpid();
+
+	skel->links.mptcp_getsockopt = bpf_program__attach_cgroup(skel->progs.mptcp_getsockopt,
+								  cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.mptcp_getsockopt, "attach getsockopt"))
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
+close_cgroup:
+	close(cgroup_fd);
+}
+
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -682,6 +754,8 @@ void test_mptcp(void)
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


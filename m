Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E0182DD
	for <mptcp@lists.linux.dev>; Sun, 24 Mar 2024 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296132; cv=none; b=PvMpb8sTQqyMy/XFdct5K14Dz8/S40ihJoys8r+73tM22jkNyq337k4iJ2AV53lQSNnDEHWaa8lhbJiq+X9vDRFO5FSuLBYXRL6ZW2G/WlwyAASeNkxuYrfaCdl31GZJliGYPPGNLiDBonJP7t59YOiKgUdlBTFR6tb9w7YljCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296132; c=relaxed/simple;
	bh=P4v83NjbHKFWMQokx1xYbIn7v0jXPHosMxGDkvXcw04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7OKv1v5WAIHPPcwdxGNEeCFrapjU79GKEGty5Ag5974GvZ03x1AjIhpuN896tPDSf+oF78RZvp31QW1OziWol0fXZHr0h62MEyAiF3X/qQLDzLYJOmjsnQmfsQiUIpCCD894Yfc3zmCqI7FbxCnQb/0v8kEOUKSGBEZaImIQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxaJw5+v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxaJw5+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488A8C433C7;
	Sun, 24 Mar 2024 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711296131;
	bh=P4v83NjbHKFWMQokx1xYbIn7v0jXPHosMxGDkvXcw04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxaJw5+vtHC2yiwRG0yQRrXq36M3VltItaWYF8KX97UHJOAtPYS3w/U/JY52dIbm8
	 ioxkLgM8U2b1ORvDzi5VlK8JtCs2F9+jtyiRCrgPBBo/RZ/HuCoIe3pX9XlUqJsEJj
	 U/iz4JNZfX4TrkcfrA2m3s1N52pTd0X0BXsRmoMTexIZc3bYQfNSpY58Xg3HtrHwuI
	 FFL1lidQhUXoJ0jyZdPMeL2RhAeiM5PO4RJ+UodoQreAsKSNRCdo1tafMLrSw1p+5A
	 0uAhqV4OTo26apTHhzXOVh13zYg6qMz3wX7ddbuvGrEJNlYrjhm/9jhEwJi2UZNknr
	 TTiH0TGdzcUcA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/4] selftests/bpf: Add mptcp subflow subtest
Date: Mon, 25 Mar 2024 00:01:16 +0800
Message-Id: <a3c6d0041daaba5c3e4a2f726f34d6d8014d4198.1711296000.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711296000.git.tanggeliang@kylinos.cn>
References: <cover.1711296000.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest named test_subflow to load and verify the newly
added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
to add a new subflow endpoint. Add another helper has_in_subflow() to
verify the fwmark and congestion values set by mptcp_subflow prog using
setsockopts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7fec91ab19cf..7f3cd8baae25 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,6 +10,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
+#include "mptcp_subflow.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -328,6 +329,98 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
+#define ADDR_1	"10.0.1.1"
+#define ADDR_2	"10.0.1.2"
+#define PORT_1	10001
+
+static int endpoint_init(char *flags)
+{
+	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
+	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
+	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int _ss_search(char *src, char *dst, char *port, char *keyword)
+{
+	char cmd[128];
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
+		 NS_TEST, src, dst, port, PORT_1, keyword);
+	return system(cmd);
+}
+
+static int ss_search(char *src, char *keyword)
+{
+	return _ss_search(src, ADDR_1, "dport", keyword);
+}
+
+static void run_test_subflow(int cgroup_fd)
+{
+	int server_fd, client_fd, prog_fd, err;
+	struct mptcp_subflow *skel;
+
+	skel = mptcp_subflow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.mptcp_subflow);
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto cleanup;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+		goto cleanup;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
+		goto close_server;
+
+	send_byte(client_fd);
+
+	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
+	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
+	ASSERT_OK(ss_search(ADDR_1, "reno"), "ss_search reno");
+	ASSERT_OK(ss_search(ADDR_2, "cubic"), "ss_search cubic");
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+cleanup:
+	mptcp_subflow__destroy(skel);
+}
+
+void test_subflow(void)
+{
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcp_subflow");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+		goto fail;
+
+	run_test_subflow(cgroup_fd);
+
+fail:
+	cleanup_netns(nstoken);
+	close(cgroup_fd);
+}
+
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int stop, duration;
 
@@ -657,6 +750,8 @@ void test_mptcp(void)
 		test_base();
 	if (test__start_subtest("mptcpify"))
 		test_mptcpify();
+	if (test__start_subtest("subflow"))
+		test_subflow();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.40.1


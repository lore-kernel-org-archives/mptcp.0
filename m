Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1554BC4
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613126; cv=none; b=gviZS0VobRl4Yut8T5fvdR00/0c4gCGx9IhDthYtquYDjQMFRCI8qA4+T7h7b5i1/iH678/IVc5CX1J1guUAKzutERSI0P1O7gF6ooT4VK6kVc7yeY73JfmGoA3ZILs87wWSYH/yb+/+ZOBS/dg4MTT4vr7F4uym7IK4jR4UkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613126; c=relaxed/simple;
	bh=IrYIryteqhObj4kwCXdNWFssvAgd3yhcb+/DLz9cGyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKG8UpIBHo+/N9tS7KBi7Z07SpM6r6ByubusxTdAn9XeQFE+q/+zsp/66FVdjMhnJOoPUoOmkJmrfZGDsdVGNELkEQmoAmZrLBWeE5w5jduP94Xm6VLo2clofu5oIMKQLSrUdlG6iGTRFCyTiHlZjPh0M+1akI6MFg69OiP14I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7X+du/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7X+du/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77007C43390;
	Thu, 28 Mar 2024 08:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613126;
	bh=IrYIryteqhObj4kwCXdNWFssvAgd3yhcb+/DLz9cGyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7X+du/2S5Giax0/Sj1zAf6wdhUFnzUzB/xb1Xr1wcCB28bXG1JgqpjuBoN1Hoekb
	 oVrczFWFCW2O3QysUlvujRwIZpFVqoOgj8iQgpnvrne+z82+rHqX5+uL7+9BItAR/l
	 H9HVPgSkAJdnwoZvvqFqZSruCxr7YzrWht7IfncEDzG8JedbBxHRbYdFxh7uX+28FM
	 KW6M3waJOXOFbsTr1g0S2M1rxPLiNK+5lxwBefFfJMBLGhNVzUkY3GOOdcsoKnpJmw
	 1wFLPPrz51ZwLIMZfEcf2MOKBvehmrGltKHhfTesukudnz1X8cXThpJKGlg4liZbyV
	 5VVyrPPmo3Sfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 07/14] selftests/bpf: Add mptcp subflow subtest
Date: Thu, 28 Mar 2024 16:04:54 +0800
Message-Id: <6728386f2f446f15826a039d174763b8e2270ef1.1711612876.git.tanggeliang@kylinos.cn>
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

This patch adds a subtest named test_subflow to load and verify the newly
added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
to add a new subflow endpoint. Add another helper ss_search() to verify the
fwmark and congestion values set by mptcp_subflow prog using setsockopts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index b8ec11552e2c..69f989e6d930 100644
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
@@ -307,6 +308,77 @@ static void run_mptcpify(int cgroup_fd, struct mptcpify *skel)
 
 MPTCP_BASE_TEST(mptcpify);
 
+#define ADDR1	"10.0.1.1"
+#define ADDR2	"10.0.1.2"
+#define PORT1	10001
+
+static int endpoint_init(char *flags)
+{
+	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR1);
+	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR2);
+	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
+	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR2, flags);
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
+		 NS_TEST, src, dst, port, PORT1, keyword);
+	return system(cmd);
+}
+
+static int ss_search(char *src, char *keyword)
+{
+	return _ss_search(src, ADDR1, "dport", keyword);
+}
+
+static void run_mptcp_subflow(int cgroup_fd, struct mptcp_subflow *skel)
+{
+	int server_fd, client_fd, prog_fd, err;
+
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+		return;
+
+	err = mptcp_subflow__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.mptcp_subflow);
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (!ASSERT_OK(err, "prog_attach"))
+		return;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR1, PORT1, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
+		goto close_server;
+
+	send_byte(client_fd);
+
+	ASSERT_OK(ss_search(ADDR1, "fwmark:0x1"), "ss_search fwmark:0x1");
+	ASSERT_OK(ss_search(ADDR2, "fwmark:0x2"), "ss_search fwmark:0x2");
+	ASSERT_OK(ss_search(ADDR1, "reno"), "ss_search reno");
+	ASSERT_OK(ss_search(ADDR2, "cubic"), "ss_search cubic");
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+MPTCP_BASE_TEST(mptcp_subflow);
+
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int stop, duration;
 
@@ -640,6 +712,7 @@ void test_mptcp(void)
 {
 	RUN_MPTCP_TEST(mptcp_sock);
 	RUN_MPTCP_TEST(mptcpify);
+	RUN_MPTCP_TEST(mptcp_subflow);
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.40.1


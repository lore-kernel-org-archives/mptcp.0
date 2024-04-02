Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EA12C689
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042684; cv=none; b=jd6fH5FgbfXFraPeuums3V06RXbJkUUyjeZXCQAco0MabyPJ7ZQK6FVf6kkPAo5Ew1Nvupjr/wPpOsi9O1xAsh8QoI8MA/SnN4C0jmxS0AvqcP3yFnLdoCMU1dM02idjP/mK7Pik5QDuhnu6o1mz9W3K3WBytJGZsRCcEhrwGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042684; c=relaxed/simple;
	bh=hwDwgf1tr56QleJO866C8miHeThccz2p2cZY4excdOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEbIF2+fMaoVtu0sEj4EYPka3UfdQBXWkoPJpOZ6taELQ5ZvOJOVjolguuNvFgsludlyFBZrPqFSx3GSB+KZ99oqIG/q4z08nsdvkVEzJL2P+ThTeH+PlgkCvWY2G7f8JJWlJXpZPGwH4DDtFaZC+1NdW+iVkH5tXzvaFgXFlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB+8n/87; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB+8n/87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032A8C43399;
	Tue,  2 Apr 2024 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042683;
	bh=hwDwgf1tr56QleJO866C8miHeThccz2p2cZY4excdOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SB+8n/87eK14j1i+T5sgXwfm0DgwC2Hv0fyaHj97AxbwT0KCcVdtpzsgxjvYs1ahg
	 0W1sBfAhxPXEdj83gTZ42sEXeZyjT/uATJboT3d04NkZ8czYgdy821nJw3FUCl39eb
	 bxUJrxQ21menuShljwpiBCkEaxDn+ht8I+mULgu2DRriPuwjF/TncSAygZqKwuS22S
	 Yx1pCYAIIEX12WKhuPm7F9xNq3+5nzQ1DeYyV/9DB5wOYVXB2FrT9FYKLqsoD7GG5j
	 QeFjAZ7h7kNSdvuZQ8ig5tY/+yzPTzeSo6Zae2Madky024E2XlYRUASw/hhf0s4iR5
	 qdc6/+Jf3Wsdg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 7/8] selftests/bpf: Add mptcp subflow subtest
Date: Tue,  2 Apr 2024 15:24:27 +0800
Message-Id: <9d77d7eff53adeb03277d30f3e5cdab946718a26.1712042529.git.tanggeliang@kylinos.cn>
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

This patch adds a subtest named test_subflow to load and verify the newly
added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
to add a new subflow endpoint. Add another helper ss_search() to verify the
fwmark and congestion values set by mptcp_subflow prog using setsockopts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 79 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6043947f178c..8309ee97ac8c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
+#include "mptcp_subflow.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -16,6 +17,9 @@
 #include "mptcp_bpf_burst.skel.h"
 
 #define NS_TEST "mptcp_ns"
+#define ADDR_1	"10.0.1.1"
+#define ADDR_2	"10.0.1.2"
+#define PORT_1	10001
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -38,6 +42,8 @@
 #define TCP_CA_NAME_MAX	16
 #endif
 
+static const unsigned int total_bytes = 10 * 1024 * 1024;
+
 struct __mptcp_info {
 	__u8	mptcpi_subflows;
 	__u8	mptcpi_add_addr_signal;
@@ -279,10 +285,73 @@ static void run_mptcpify(int cgroup_fd, struct mptcpify *skel)
 	close(server_fd);
 }
 
-static const unsigned int total_bytes = 10 * 1024 * 1024;
-#define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
-#define PORT_1	10001
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
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
+		goto close_server;
+
+	if (set_nonblock(server_fd))
+		goto close_server;
+
+	send_recv_data(server_fd, client_fd, total_bytes);
+
+	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
+	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
+	ASSERT_OK(ss_search(ADDR_1, "reno"), "ss_search reno");
+	ASSERT_OK(ss_search(ADDR_2, "cubic"), "ss_search cubic");
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
 
 #define MPTCP_BASE_TEST(name)					\
 static void test_##name(void)					\
@@ -318,6 +387,7 @@ close_cgroup:							\
 
 MPTCP_BASE_TEST(mptcp_sock);
 MPTCP_BASE_TEST(mptcpify);
+MPTCP_BASE_TEST(mptcp_subflow);
 
 static struct nstoken *sched_init(char *flags, char *sched)
 {
@@ -451,6 +521,7 @@ void test_mptcp(void)
 {
 	RUN_MPTCP_TEST(mptcp_sock);
 	RUN_MPTCP_TEST(mptcpify);
+	RUN_MPTCP_TEST(mptcp_subflow);
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
-- 
2.40.1


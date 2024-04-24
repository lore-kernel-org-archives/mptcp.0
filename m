Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56B6FDC
	for <mptcp@lists.linux.dev>; Wed, 24 Apr 2024 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921247; cv=none; b=oYemebpfwl+zImSfeJSZq1VosEnn6MomaCWCSwePeNnMGbY7pv4sON2xOT/L6qqU09cE92OujIlNZa/1WgyCn8iyWsaZjMIzeYf7L1wuElGMJZJb0+TQt3Vxuwv0DMan1BGRz43e9EWAeBPKLvU3n7B3iOxtJLAh5nwivQnWUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921247; c=relaxed/simple;
	bh=saPuEURRKX6o7kpCmjg8tsSaVbulFLCfiDCi4m2z9RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDZT1E6Q6EXvVkGoUZY6uce0oVmJzv0AHaaRugONqiaB2ejGmmdnrY2NhKke9jSl3JNrP/QosNqJT+RT2XHTpUVFByI3Np/8TfZjLf+ZvORocSOyWEe6/Nak+FQTS8yt+VpkmsTyHS9G2y1SybpmUuqlKG+OVD29pBza3uFp0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh7wpQ1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh7wpQ1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45312C32783;
	Wed, 24 Apr 2024 01:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713921246;
	bh=saPuEURRKX6o7kpCmjg8tsSaVbulFLCfiDCi4m2z9RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uh7wpQ1JCPC8SRw9ZT94cLjVNH0UhEesAiM/6KZJgFBNDm0oiOM9xFGvV6lPQR52N
	 Uj+JyZ7E5f2Ya/ESsHVAqxQ9iWHdHFVOW5lzsi8k8P+nezY0PPwiF9GBVTz2WuEMyy
	 UXTVsQtB7hqZwL4IkPN/pBl1ZJ+lOPI2fiU9YXjUenPq6kxbuR1NRdUAVFCgGpzyoC
	 OsKdpUboyeJNnGxyRF7/23PvPkZ4ROzypBUeDTkrAwjClJ2dmtJzOPitWLTgGQpwth
	 cIIx8+7zre2yoYDydsdN2FHKubwLBM4VDbOk4qg4/PZ2QaY7PVdaPrj2fIXVOtL7J6
	 njh+QngLIbp5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 2/4] selftests/bpf: Add mptcp subflow subtest
Date: Wed, 24 Apr 2024 09:13:52 +0800
Message-Id: <ca52c059166d6f8c9c4074eaadcab52421b5480c.1713920939.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713920939.git.tanggeliang@kylinos.cn>
References: <cover.1713920939.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 118 +++++++++++++++++-
 1 file changed, 112 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d3cc3541dd4f..6d94cda6b97a 100644
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
 #define WITH_DATA	true
 #define WITHOUT_DATA	false
 
@@ -41,6 +45,9 @@
 #endif
 #define MPTCP_SCHED_NAME_MAX	16
 
+static const unsigned int total_bytes = 10 * 1024 * 1024;
+static int duration;
+
 struct __mptcp_info {
 	__u8	mptcpi_subflows;
 	__u8	mptcpi_add_addr_signal;
@@ -332,8 +339,110 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
-static const unsigned int total_bytes = 10 * 1024 * 1024;
-static int stop, duration;
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
+	int n;
+
+	n = snprintf(cmd, sizeof(cmd),
+		     "ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
+		     NS_TEST, src, dst, port, PORT_1, keyword);
+	if (n < 0 || n >= sizeof(cmd))
+		return -1;
+
+	return system(cmd);
+}
+
+static int ss_search(char *src, char *keyword)
+{
+	return _ss_search(src, ADDR_1, "dport", keyword);
+}
+
+static void run_subflow(char *new)
+{
+	int server_fd, client_fd, err;
+	char cc[TCP_CA_NAME_MAX];
+	socklen_t len = sizeof(cc);
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
+		goto fail;
+
+	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
+	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
+		goto fail;
+
+	send_byte(client_fd);
+
+	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
+	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
+	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
+	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
+
+	close(client_fd);
+fail:
+	close(server_fd);
+}
+
+static void test_subflow(void)
+{
+	int cgroup_fd, prog_fd, err;
+	struct mptcp_subflow *skel;
+	struct nstoken *nstoken;
+
+	cgroup_fd = test__join_cgroup("/mptcp_subflow");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
+		return;
+
+	skel = mptcp_subflow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_subflow"))
+		goto close_cgroup;
+
+	err = mptcp_subflow__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach: mptcp_subflow"))
+		goto skel_destroy;
+
+	prog_fd = bpf_program__fd(skel->progs.mptcp_subflow);
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (!ASSERT_OK(err, "prog_attach"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+		goto close_netns;
+
+	run_subflow(skel->data->cc);
+
+close_netns:
+	cleanup_netns(nstoken);
+skel_destroy:
+	mptcp_subflow__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
+
+static int stop;
 
 static void *server(void *arg)
 {
@@ -414,10 +523,6 @@ static void send_data(int lfd, int fd, char *msg)
 	      PTR_ERR(thread_ret));
 }
 
-#define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
-#define PORT_1	10001
-
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -558,6 +663,7 @@ void test_mptcp(void)
 {
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
+	RUN_MPTCP_TEST(subflow);
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
-- 
2.40.1


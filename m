Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741E224F2
	for <mptcp@lists.linux.dev>; Wed, 20 Mar 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938237; cv=none; b=doXarfXpKT2FJlfhbDLOzSha9Mj4mHahgNZCVKEpVn4nzaEj0qE4WetGpsQ2wPt/m3tObRPHQaLJLvoTLTk5s3Jy9TsldPbpFKf/nGGa+V27PCUduAuLHUVDRSCxZr2iv5yxhjZIX6M6aAOGDvG8hIV45w/61Wq+//X79aihsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938237; c=relaxed/simple;
	bh=qzM0q3mpGhtWcQfVgt/bq/p3Ha2LYVnozEpOaXJouAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gT2yQfr9YNK57cxJ7jCrrvHQ21OVFjonxwkyrPw2dZHs4A06EyU2H46guAQPda8T4D5yMYPoVRHfNZ1iTu26ZprsD4QTkUarYoT/G6lkHUljd8UPDpfhN5tVrvFLUz0XD9Gardt/3FXTT5wt2Kc25CrDwaxs8y/IY3wdNjZ/8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN0RrShh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN0RrShh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8485C43390;
	Wed, 20 Mar 2024 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710938236;
	bh=qzM0q3mpGhtWcQfVgt/bq/p3Ha2LYVnozEpOaXJouAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dN0RrShhHnsGXDGVaeGN0XQ5sJa5ootNxjYP6F61TovdHkVg0qcDTPtHXvJKF0hwd
	 U5IJjb9KvFy2eHRX3oNB9+u3P7C8FV1IZFnafx/0WbAzJbBzDqLJ9LCwBuEASH83aV
	 6r1qkxHmB5xe+1mxovNYa414GEHm25JGsHXlu5gAwvYkSQvZjZ8Qf2Za0xs8gqmaxd
	 KMTcdjPT8IVr89zXJL3V7dP+IuO27fipfe5l6dtXJJyU9ukcEN5LpvXhqj9b2biL2z
	 ozeQiMKNQYqGB4XICWDsEcFQZ4SdpCqcCQkEeRueruA5lb3lkuF6mUdh/QcZDRNX6s
	 x3PnQ5HoYeKGw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/4] selftests/bpf: Add mptcp subflow test
Date: Wed, 20 Mar 2024 20:37:04 +0800
Message-Id: <e59dc417c978b73e4702b1c1a760e4a0556c3e6f.1710938175.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710938175.git.tanggeliang@kylinos.cn>
References: <cover.1710938175.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest to load and varify mptcp subflow prog named
test_subflow in test_mptcp. Add a helper endpoint_init() to add a new
subflow endpoint. Add another helper has_in_subflow() to verify the
fwmark and congestion values set by mptcp_subflow prog using setsockopt.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4c180839ff1d..83efcdd7739d 100644
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
@@ -328,6 +329,93 @@ static void test_mptcpify(void)
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
+static int has_in_subflow(char *src, char *str)
+{
+	char cmd[128];
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -Menita src %s dst %s dport %d | grep -q '%s'",
+		 NS_TEST, src, ADDR_1, PORT_1, str);
+	return system(cmd);
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
+	ASSERT_OK(has_in_subflow(ADDR_1, "fwmark:0x1"), "has_in_subflow fwmark:0x1");
+	ASSERT_OK(has_in_subflow(ADDR_2, "fwmark:0x2"), "has_in_subflow fwmark:0x2");
+	ASSERT_OK(has_in_subflow(ADDR_1, "reno"), "has_in_subflow reno");
+	ASSERT_OK(has_in_subflow(ADDR_2, "cubic"), "has_in_subflow cubic");
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
+	cgroup_fd = test__join_cgroup("/sockopt_mptcp");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /sockopt_mptcp"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+		return;
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
 
@@ -661,6 +749,8 @@ void test_mptcp(void)
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


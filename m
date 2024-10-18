Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66020263D
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248737; cv=none; b=a2fIcXVYhhW/5mFrwdOXfwo6XRU9ExdSBsswS4tQvHNrG/mq3UCjKdEdSqKfGEEj25aptihTfhFFEfOIq9Oo1UFfBHtS4cE0gFeaDdRhmgVmuJrjLBYd1KWEfFwYRRmBZD7GXimzwwSOzQC4tU6Wa40qaDshwOmiIyWirvFTO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248737; c=relaxed/simple;
	bh=W1fF6zR56V1CSSFP+NlA8nMT8WbVcn9lIW0M935KqEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qo1PYLiZb2Arm15+0WrAPEPP/AeK2dAluGD34eqYRbHv2Dl1DcFSs0sy+FN6N1NruIuJax6JpZOLRbaMYHP6SfxLxo1VL9C/G4uUqOe9BX+Ts3/M5EFBPsRUCI4GAigo6Yk4Zvq47XdqQVn7dxMMhKz62J9K+DAq9FhVjeNYis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSYsizod; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSYsizod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD766C4CEC6;
	Fri, 18 Oct 2024 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729248737;
	bh=W1fF6zR56V1CSSFP+NlA8nMT8WbVcn9lIW0M935KqEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSYsizodF6jMlVr7OjrzfVca71nJ1GwAnS2523qTPNndbfQsw+9VGTOTbMabQzWTx
	 bi/SJkltHbeBjhjMDbPv/O3XFQagqQrrqSoh/HozClr9G5jzzaaeqFv1zL23ke0Az0
	 nKQ/0ZGjyoJ8oFWUMdAOYMCuKx4zWT4mMLAj0vWeibWtw9r+QejWQzU/NZYY4uMaXw
	 OpEK+Ji4dcxIv3EXl9O+D/1IUDtVhJgmVxYfZtH1zdD8DIFdTTtKwXt8Z6Db38MCoa
	 d7MPOx6gzu/dZmDmSajmO48kltdJu0FQ0Cowg6L4ZkGLGIqfykSkY4NhodidRSNl0g
	 pSZfvImpLqxgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/6] selftests/bpf: Add mptcp_address bpf_iter subtest
Date: Fri, 18 Oct 2024 18:51:58 +0800
Message-ID: <5a583f06e60dff7fef8bd918e2dd23e08dee7dcc.1729248083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729248083.git.tanggeliang@kylinos.cn>
References: <cover.1729248083.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest named test_iters_address to load and verify
the newly added mptcp_address type bpf_iter example in test_mptcp.

Since mptcp_address bpf_iter iterates over all address entries on the
local address list of userspace PM. A set of userspace PM helpers are
added.

Set pm_type and start "pm_nl_ctl events" command to save pm events into
the log file /tmp/bpf_userspace_pm_events in userspace_pm_init(). Kill
"pm_nl_ctl" command and remove the log file in userspace_pm_cleanup().
Parse the log file in userspace_pm_add_subflow() to get the token, sport
and dport values, then use "pm_nl_ctl csf" command to create a subflow.

Use the helper userspace_pm_add_subflow() to add 3 new subflow endpoints.
Send a byte of message to start the mptcp connection, and receive the
message.

getsockopt() is invoked to trigger the "cgroup/getsockopt" test program.
Check if skel->bss->ids equals 60 to verify whether the program loops
three times as expected.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 439dfee42ffd..a8f49041aaf1 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -29,6 +29,7 @@
 #define ADDR6_4	"dead:beef:4::1"
 #define PORT_1	10001
 #define PM_CTL		"./mptcp_pm_nl_ctl"
+#define PM_EVENTS	"/tmp/bpf_userspace_pm_events"
 #define WITH_DATA	true
 #define WITHOUT_DATA	false
 
@@ -54,6 +55,14 @@
 #endif
 #define MPTCP_SCHED_NAME_MAX	16
 
+enum mptcp_pm_type {
+	MPTCP_PM_TYPE_KERNEL = 0,
+	MPTCP_PM_TYPE_USERSPACE,
+
+	__MPTCP_PM_TYPE_NR,
+	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
+};
+
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int duration;
 
@@ -267,6 +276,19 @@ static void send_byte(int fd)
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
@@ -581,6 +603,159 @@ static void test_iters_subflow(void)
 	close(cgroup_fd);
 }
 
+static int userspace_pm_init(enum mptcp_pm_type pm_type)
+{
+	if (address_init())
+		goto fail;
+
+	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.pm_type=%u",
+	    NS_TEST, pm_type);
+	SYS(fail, "ip netns exec %s %s limits 4 4",
+	    NS_TEST, PM_CTL);
+	SYS(fail, "ip netns exec %s %s events >> %s 2>&1 &",
+	    NS_TEST, PM_CTL, PM_EVENTS);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static void userspace_pm_cleanup(void)
+{
+	SYS_NOFAIL("ip netns exec %s killall %s > /dev/null 2>&1",
+		   NS_TEST, PM_CTL);
+	SYS_NOFAIL("ip netns exec %s rm -rf %s", NS_TEST, PM_EVENTS);
+}
+
+static char *get_events_str(char *type)
+{
+	char buf[1024];
+	size_t len;
+	int fd;
+
+	fd = open(PM_EVENTS, O_RDONLY);
+	if (!ASSERT_OK_FD(fd, "failed to open pm events"))
+		return NULL;
+
+	len = read(fd, buf, sizeof(buf));
+	ASSERT_GT(len, 0, "failed to read pm events");
+
+	close(fd);
+
+	return strstr(buf, type);
+}
+
+static int userspace_pm_add_subflow(char *addr, __u8 id)
+{
+	bool ipv6 = strstr(addr, ":");
+	__u32 token, sport, dport;
+	char *str;
+	int n;
+
+	str = get_events_str("type:2");
+	if (!str)
+		return -1;
+
+	n = sscanf(strstr(str, "token"), "token:%u,", &token);
+	if (n != 1)
+		return -1;
+	n = sscanf(strstr(str, "sport"), "sport:%u,dport:%u,", &sport, &dport);
+	if (n != 2)
+		return -1;
+	str = ipv6 ? (strstr(addr, ".") ? "::ffff:"ADDR_1 : ADDR6_1) : ADDR_1;
+	SYS_NOFAIL("ip netns exec %s %s csf lip %s lid %u rip %s rport %u token %u",
+		   NS_TEST, PM_CTL, addr, id, str, dport, token);
+
+	return 0;
+}
+
+static void run_iters_address(void)
+{
+	int server_fd, client_fd, accept_fd;
+	char cc[TCP_CA_NAME_MAX];
+	socklen_t len;
+	int err;
+
+	server_fd = start_mptcp_server(AF_INET6, "::ffff:"ADDR_1, PORT_1, 0);
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
+	usleep(100000);
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+	usleep(100000);
+
+	err = userspace_pm_add_subflow("::ffff:"ADDR_2, 10);
+	err = err ?: userspace_pm_add_subflow("::ffff:"ADDR_3, 20);
+	err = err ?: userspace_pm_add_subflow("::ffff:"ADDR_4, 30);
+	if (!ASSERT_OK(err, "userspace_pm_add_subflow"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	len = sizeof(cc);
+	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)"))
+		ASSERT_STREQ(cc, "cubic", "cc");
+
+close_accept:
+	close(accept_fd);
+close_client:
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_iters_address(void)
+{
+	struct mptcp_bpf_iters *skel;
+	struct nstoken *nstoken;
+	int cgroup_fd;
+	int err;
+
+	cgroup_fd = test__join_cgroup("/iters_address");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: iters_address"))
+		return;
+
+	skel = mptcp_bpf_iters__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: iters_address"))
+		goto close_cgroup;
+
+	skel->links.iters_address = bpf_program__attach_cgroup(skel->progs.iters_address,
+							       cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.iters_address, "attach getsockopt"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto skel_destroy;
+
+	err = userspace_pm_init(MPTCP_PM_TYPE_USERSPACE);
+	if (!ASSERT_OK(err, "userspace_pm_init: iters_address"))
+		goto close_netns;
+
+	run_iters_address();
+
+	ASSERT_EQ(skel->bss->ids, 60, "address ids");
+
+	userspace_pm_cleanup();
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
@@ -764,6 +939,8 @@ void test_mptcp(void)
 		test_subflow();
 	if (test__start_subtest("iters_subflow"))
 		test_iters_subflow();
+	if (test__start_subtest("iters_address"))
+		test_iters_address();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.43.0


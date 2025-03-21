Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B834C85
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521770; cv=none; b=FFrustsxH1KE0Sx87/Kq0wWtaVIuj6q0VP0zYPigDqrC7h9Le1ozUQmCeuUBfSUO+sckSPlqp2IbW/bg42QmXDg3q4UT4xb+VwaQtFbPbNSxOhyYmJugv+hFThKb5ssFaNk2/ntaVHHoy5STI63tzYaPodRv4ShF0ww4C2hG9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521770; c=relaxed/simple;
	bh=EWRTRr+OefG+MebdqmMPkLi+vdY2MwAf0r+zOnOliZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiDx/+NF5tjBrFb76mU2qPFIFw/C+bbExo2Lo7CYLl7OI5uh2KjCBDotlT97aIrJfDrkZt+1g5uuAMweIeqo/J8zGabkwNlhDUPevqTNqSG1jym6M8Z8um7QbMm2fSWmfpDIQQaZAX5Qgy0zGO8/4ZtrUA0NvAHrEqS76OQLKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgxxH5Xr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgxxH5Xr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C002C4CEE7;
	Fri, 21 Mar 2025 01:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521770;
	bh=EWRTRr+OefG+MebdqmMPkLi+vdY2MwAf0r+zOnOliZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgxxH5Xrq9gZyhhBIFKpJCa1c3CJhE98aUmAhJKFxWcLzYv3lFiNLyupxDVtp84wo
	 3XGaJa/1uRVpKzIYozRfd2yTQFjEkRgfJuMD1Dl3yZMkcel13SAZhmXAgjR9/tZeMO
	 rISg6ZeJBM3b011FXj2DnWDPA64X8AVW8B8huDuVhI4qjTDMshSwhPvHR1qNCEsA7q
	 h+RnRPzfQctS3igrNPMAc6ARiTS6iPDvNCz8C16pACyfjUCNUwm8jUpPH8Rtd6tHTF
	 H940d8hWYWsifLsJ8C19/tDx0FTTPRGoqXNFUyv0J9JAqyiMoutpFoHTk2xIE0UAKj
	 MLoCQSbHjolBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 3/4] selftests/bpf: Add mptcp netlink pm subtest
Date: Fri, 21 Mar 2025 09:49:17 +0800
Message-ID: <64d988e6d362e91e764ff235e45b28ba5e39ff4e.1742521587.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742521587.git.tanggeliang@kylinos.cn>
References: <cover.1742521587.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To verify that the behavior of BPF path manager is the same as that of
netlink pm in the kernel, a netlink pm self-test has been added. BPF
path manager in the next commit will also use this test too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 236 ++++++++++++++++++
 1 file changed, 236 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7c51250e7161..5303cbf38a44 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -56,6 +56,12 @@
 #endif
 #define MPTCP_SCHED_NAME_MAX	16
 
+enum mptcp_pm_family {
+	IPV4 = 0,
+	IPV4MAPPED,
+	IPV6,
+};
+
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int duration;
 
@@ -562,6 +568,234 @@ static void test_iters_subflow(void)
 	close(cgroup_fd);
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
+static int netlink_pm_add_subflow(char *addr, __u8 id)
+{
+	return SYS_NOFAIL("ip -n %s mptcp endpoint add %s subflow id %u",
+			  NS_TEST, addr, id);
+}
+
+static int netlink_pm_rm_subflow(__u8 id)
+{
+	return SYS_NOFAIL("ip -n %s mptcp endpoint delete id %u",
+			  NS_TEST, id);
+}
+
+static int netlink_pm_add_addr(char *addr, __u8 id)
+{
+	return SYS_NOFAIL("ip -n %s mptcp endpoint add %s signal id %u",
+			  NS_TEST, addr, id);
+}
+
+static int netlink_pm_rm_addr(__u8 id)
+{
+	return SYS_NOFAIL("ip -n %s mptcp endpoint delete id %u",
+			  NS_TEST, id);
+}
+
+static int netlink_pm_rm_addr_id_0(char *addr)
+{
+	return SYS_NOFAIL("ip -n %s mptcp endpoint delete id 0 %s",
+			  NS_TEST, addr);
+}
+
+static int netlink_pm_set_flags(__u8 id, char *flags)
+{
+	return SYS_NOFAIL("ip -n %s mptcp endpoint change id %u %s",
+			  NS_TEST, id, flags);
+}
+
+static int netlink_pm_get_addr(__u8 id, char *output)
+{
+	char cmd[1024];
+	FILE *fp;
+
+	sprintf(cmd, "ip -n %s mptcp endpoint show id %u", NS_TEST, id);
+	fp = popen(cmd, "r");
+	if (!fp)
+		return -1;
+
+	bzero(output, BUFSIZ);
+	fread(output, 1, BUFSIZ, fp);
+	pclose(fp);
+
+	return 0;
+}
+
+static int netlink_pm_dump_addr(char *output)
+{
+	char cmd[1024];
+	FILE *fp;
+
+	sprintf(cmd, "ip -n %s mptcp endpoint show", NS_TEST);
+	fp = popen(cmd, "r");
+	if (!fp)
+		return -1;
+
+	bzero(output, BUFSIZ);
+	fread(output, 1, BUFSIZ, fp);
+	pclose(fp);
+
+	return 0;
+}
+
+static void run_netlink_pm(enum mptcp_pm_family family)
+{
+	bool ipv4mapped = (family == IPV4MAPPED);
+	bool ipv6 = (family == IPV6 || ipv4mapped);
+	int server_fd, client_fd, accept_fd;
+	char output[BUFSIZ], expect[1024];
+	char *addr;
+	int err;
+
+	addr = ipv6 ? (ipv4mapped ? "::ffff:"ADDR_1 : ADDR6_1) : ADDR_1;
+	server_fd = start_mptcp_server(ipv6 ? AF_INET6 : AF_INET, addr, PORT_1, 0);
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
+	usleep(200000); /* 0.2s */
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+	usleep(200000); /* 0.2s */
+
+	addr = ipv6 ? (ipv4mapped ? "::ffff:"ADDR_2 : ADDR6_2) : ADDR_2;
+	err = netlink_pm_add_subflow(addr, 100);
+	if (!ASSERT_OK(err, "netlink_pm_add_subflow 100"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	sprintf(expect, "%s id 100 subflow \n", addr);
+	err = netlink_pm_get_addr(100, output);
+	if (!ASSERT_OK(err, "netlink_pm_get_addr 100") ||
+	    !ASSERT_STRNEQ(output, expect, sizeof(expect), "get_addr"))
+		goto close_accept;
+
+	err = netlink_pm_set_flags(100, "backup");
+	if (!ASSERT_OK(err, "netlink_pm_set_flags backup"))
+		goto close_accept;
+
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+
+	sprintf(expect, "%s id 100 subflow backup \n", addr);
+	err = netlink_pm_get_addr(100, output);
+	if (!ASSERT_OK(err, "netlink_pm_get_addr 100") ||
+	    !ASSERT_STRNEQ(output, expect, sizeof(expect), "get_addr"))
+		goto close_accept;
+
+	err = netlink_pm_set_flags(100, "nobackup");
+	if (!ASSERT_OK(err, "netlink_pm_set_flags nobackup"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	sprintf(expect, "%s id 100 subflow \n", addr);
+	err = netlink_pm_get_addr(100, output);
+	if (!ASSERT_OK(err, "netlink_pm_get_addr 100") ||
+	    !ASSERT_STRNEQ(output, expect, sizeof(expect), "get_addr"))
+		goto close_accept;
+
+	err = netlink_pm_rm_subflow(100);
+	if (!ASSERT_OK(err, "netlink_pm_rm_subflow 100"))
+		goto close_accept;
+
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+
+	err = netlink_pm_dump_addr(output);
+	if (!ASSERT_OK(err, "netlink_pm_dump_addr") ||
+	    !ASSERT_STRNEQ(output, "", sizeof(output), "dump_addr"))
+		goto close_accept;
+
+	addr = ipv6 ? (ipv4mapped ? "::ffff:"ADDR_3 : ADDR6_3) : ADDR_3;
+	err = netlink_pm_add_addr(addr, 200);
+	if (!ASSERT_OK(err, "netlink_pm_add_addr 200"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	sprintf(expect, "%s id 200 signal \n", addr);
+	err = netlink_pm_dump_addr(output);
+	if (!ASSERT_OK(err, "netlink_pm_dump_addr") ||
+	    !ASSERT_STRNEQ(output, expect, sizeof(expect), "dump_addr"))
+		goto close_accept;
+
+	err = netlink_pm_rm_addr(200);
+	if (!ASSERT_OK(err, "netlink_pm_rm_addr 200"))
+		goto close_accept;
+
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+
+	err = netlink_pm_rm_addr_id_0(addr);
+	ASSERT_OK(err, "netlink_pm_rm_addr 0");
+
+close_accept:
+	close(accept_fd);
+close_client:
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static int pm_init(const char *pm_name)
+{
+	if (address_init())
+		goto fail;
+
+	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.path_manager=%s",
+	    NS_TEST, pm_name);
+	SYS(fail, "ip -n %s mptcp limits set add_addr_accepted 4 subflows 4",
+	    NS_TEST);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static void test_netlink_pm(void)
+{
+	struct netns_obj *netns;
+	int err;
+
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		return;
+
+	err = pm_init("kernel");
+	if (!ASSERT_OK(err, "pm_init: netlink pm"))
+		goto fail;
+
+	run_netlink_pm(IPV4MAPPED);
+
+fail:
+	netns_free(netns);
+}
+
 static int sched_init(char *flags, char *sched)
 {
 	if (endpoint_init(flags, 2) < 0)
@@ -756,6 +990,8 @@ void test_mptcp(void)
 		test_subflow();
 	if (test__start_subtest("iters_subflow"))
 		test_iters_subflow();
+	if (test__start_subtest("netlink_pm"))
+		test_netlink_pm();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.43.0


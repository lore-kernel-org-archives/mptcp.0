Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8C2B9B9
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925381; cv=none; b=q5T0tcpDt4RKdsHBtYN+rFofIglTpIx72D7Kr+HrzSAt4HHqioJ7TJQ9iigCK30/IsTTOBSBagDm7XSoYfUxXtgsb6Wz1HsOsrDB1IRq5DAk/cWo5x1djCTHyUELuuQ+gkU6J6FeDxJQ8TBgbCivZQS3Ikow2qsar0LQincIGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925381; c=relaxed/simple;
	bh=tCUPmZC8B4CYwZpaqxRTQNnL9SVCp8aQHUul6PyYCPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsW4ZpbRe4rAzFJ0kDqdE/QH/6WsO0S7m5npvfyEcA+MopX3fCvXr++DRc9uO0cHXCEajMFdH5iI/Lp2lSW1i4VE5a/P+mK8YqR8mlKqQ4HlDr8UauWZBhSBMueRlHsgnB1vM4QydZJ07Jp5099lMu0fuXDfNuiOAKjadhScQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgTXl0+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgTXl0+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7143CC4CED1;
	Fri,  7 Feb 2025 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738925380;
	bh=tCUPmZC8B4CYwZpaqxRTQNnL9SVCp8aQHUul6PyYCPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgTXl0+nhoBgIeuDA1PUzeBAU/OgqY/MD15Gh/GM2V8s9AMC2WyJzQ27YvXaHv486
	 EZxrlPW/JHOLiaD6JOYOlgo3lunl1z5O3DeevE3XWC2H57PQnOxGJPwLQMoGbMsnsI
	 Wy9HWwxBG6tzLT/NjKOjlcdUssWpW8jaa54oQogrjOE5WZiBMan+FNvZIBK7aKyGZA
	 PdzB6Q3CxyK9vtnU9G5zmundKjKZTDeCGjPHZ2a3hVYmoTvyQaZajfUsPmxPaB2BiT
	 91GH90gZ2jWo0XrQE7dnSmvpgYeU2kf5wtwBey9fAeS05+TnF42Zv6hYb/ZWLET1jj
	 JEoXw7Fe2wXFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 3/5] selftests/bpf: Add mptcp userspace pm subtest
Date: Fri,  7 Feb 2025 18:49:26 +0800
Message-ID: <816bc05971406156c8f805a0176c4f4d877d05d5.1738924875.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738924875.git.tanggeliang@kylinos.cn>
References: <cover.1738924875.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To verify that the behavior of BPF path manager is the same as that of
userspace pm in the kernel, a userspace pm self-test has been added.
BPF path manager in the next commit will also use this test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 3fff78781bac..cbe41bb39603 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -66,6 +66,12 @@ enum mptcp_pm_type {
 	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
 };
 
+enum mptcp_pm_family {
+	IPV4 = 0,
+	IPV4MAPPED,
+	IPV6,
+};
+
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int duration;
 
@@ -779,6 +785,158 @@ static void test_iters_address(void)
 	close(cgroup_fd);
 }
 
+static int userspace_pm_add_addr(__u32 token, char *addr, __u8 id)
+{
+	return SYS_NOFAIL("ip netns exec %s %s ann %s id %u token %u",
+			  NS_TEST, PM_CTL, addr, id, token);
+}
+
+static int userspace_pm_rm_addr(__u32 token, __u8 id)
+{
+	return SYS_NOFAIL("ip netns exec %s %s rem id %u token %u",
+			  NS_TEST, PM_CTL, id, token);
+}
+
+static int userspace_pm_rm_subflow(__u32 token, char *addr, __u8 id)
+{
+	bool ipv6 = strstr(addr, ":");
+	char line[1024], *str;
+	__u32 sport, dport;
+
+	if (userspace_pm_get_events_line("type:10", line))
+		return -1;
+
+	str = strstr(line, "sport");
+	if (!str || sscanf(str, "sport:%u,dport:%u,", &sport, &dport) != 2) {
+		log_err("rm_subflow error, str=%s\n", str);
+		return -1;
+	}
+
+	str = ipv6 ? (strstr(addr, ".") ? "::ffff:"ADDR_1 : ADDR6_1) : ADDR_1;
+	return SYS_NOFAIL("ip netns exec %s %s dsf lip %s lport %u rip %s rport %u token %u",
+			  NS_TEST, PM_CTL, addr, sport, str, dport, token);
+}
+
+static int userspace_pm_set_flags(__u32 token, char *addr, char *flags)
+{
+	bool ipv6 = strstr(addr, ":");
+	char line[1024], *str;
+	__u32 sport, dport;
+
+	if (userspace_pm_get_events_line("type:10", line))
+		return -1;
+
+	str = strstr(line, "sport");
+	if (!str || sscanf(str, "sport:%u,dport:%u,", &sport, &dport) != 2) {
+		log_err("set_flags error, str=%s\n", str);
+		return -1;
+	}
+
+	str = ipv6 ? (strstr(addr, ".") ? "::ffff:"ADDR_1 : ADDR6_1) : ADDR_1;
+	return SYS_NOFAIL("ip netns exec %s %s set %s port %u rip %s rport %u flags %s token %u",
+			  NS_TEST, PM_CTL, addr, sport, str, dport, flags, token);
+}
+
+static void run_userspace_pm(enum mptcp_pm_family family)
+{
+	bool ipv4mapped = (family == IPV4MAPPED);
+	bool ipv6 = (family == IPV6 || ipv4mapped);
+	int server_fd, client_fd, accept_fd;
+	__u32 token;
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
+	token = userspace_pm_get_token(client_fd);
+	if (!token)
+		goto close_client;
+	recv_byte(accept_fd);
+	usleep(200000); /* 0.2s */
+
+	addr = ipv6 ? (ipv4mapped ? "::ffff:"ADDR_2 : ADDR6_2) : ADDR_2;
+	err = userspace_pm_add_subflow(token, addr, 100);
+	if (!ASSERT_OK(err, "userspace_pm_add_subflow 100"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	err = userspace_pm_set_flags(token, addr, "backup");
+	if (!ASSERT_OK(err, "userspace_pm_set_flags backup"))
+		goto close_accept;
+
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+
+	err = userspace_pm_set_flags(token, addr, "nobackup");
+	if (!ASSERT_OK(err, "userspace_pm_set_flags nobackup"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	err = userspace_pm_rm_subflow(token, addr, 100);
+	if (!ASSERT_OK(err, "userspace_pm_rm_subflow 100"))
+		goto close_accept;
+
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+
+	addr = ipv6 ? (ipv4mapped ? "::ffff:"ADDR_3 : ADDR6_3) : ADDR_3;
+	err = userspace_pm_add_addr(token, addr, 200);
+	if (!ASSERT_OK(err, "userspace_pm_add_addr 200"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	err = userspace_pm_rm_addr(token, 200);
+	if (!ASSERT_OK(err, "userspace_pm_rm_addr 200"))
+		goto close_accept;
+
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+
+close_accept:
+	close(accept_fd);
+close_client:
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_userspace_pm(void)
+{
+	struct netns_obj *netns;
+	int err;
+
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		return;
+
+	err = userspace_pm_init(MPTCP_PM_TYPE_USERSPACE);
+	if (!ASSERT_OK(err, "userspace_pm_init: userspace pm"))
+		goto fail;
+
+	run_userspace_pm(IPV4MAPPED);
+
+	userspace_pm_cleanup();
+fail:
+	netns_free(netns);
+}
+
 static struct netns_obj *sched_init(char *flags, char *sched)
 {
 	struct netns_obj *netns;
@@ -974,6 +1132,8 @@ void test_mptcp(void)
 		test_iters_subflow();
 	if (test__start_subtest("iters_address"))
 		test_iters_address();
+	if (test__start_subtest("userspace_pm"))
+		test_userspace_pm();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.43.0


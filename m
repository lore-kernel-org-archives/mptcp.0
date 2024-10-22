Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBBD1957FC
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588549; cv=none; b=o+dKvLrcFaWcb8M5ASvWN+hRMTt5p1qhYcym5YA/xfqyqm9PONdYFRxZnG8hK459bR5YTZVdN9byHhl9rTgUEs6CH9xF9qYAlSG186OyA9Kr0pWDDH5hprYi8JCTpK8cGYo90qoh5IjkGnlzOl48+xIuhdmipIWrYeg+f2cx/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588549; c=relaxed/simple;
	bh=LioRyH8CdYpUVC3HSONHAXUYzQE06SDLizYFC/Q0WOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJgCt2kDgMqEPaJLA1qRZPMOxZ7NyjAEIIoIKVUqsrbzwQdPJNli+u82j5G7o94YeT1cbesqfNjD1R54p0M88kSWaFWNnSUpak/B2UWlJrwLnDx9fZ2B5KvxIKu5B+g3Vt+jWTKHFrn7/EYWRPU656i4Z3dbJDsOGEqYWW0uEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO9F/AEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO9F/AEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3841C4AF0B;
	Tue, 22 Oct 2024 09:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588549;
	bh=LioRyH8CdYpUVC3HSONHAXUYzQE06SDLizYFC/Q0WOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AO9F/AEOApUw7Odq7Mp2pLqZsI7uk/YJd3yQ4bpB6KGtDfCsMq2e3vHTZ1K9wPzqw
	 ZVcPX8C7V3+K9DWi2wNEfx+f3kZnyIz6XZ9a7snmr0B6VM0FlVfnd9+1I6id3sQuac
	 Kq6zpAZA+PQLZNnk0nubeDN+wjDwlI6QDhfoPHk4fDkKHmUdou/1plXppmdlItPUlm
	 O+D5oZHwT8pi7zwrXkN0YgtUI3yuJjyj2y2ZUEVTohV9C5a/EnhA3ZmdItGz9n+Fb8
	 lCwXg1YCKIHwvuqF8Rrk8rZhkmihxbMxicBJ5hPm5F0S1es545dm6zGaZkYKxQPRWE
	 da716p+mamHYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 35/36] selftests/bpf: Add mptcp userspace pm subtest
Date: Tue, 22 Oct 2024 17:14:43 +0800
Message-ID: <17c3d24db37a40a78342240e93758d2c949dee05.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 244 ++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 73bfd177dc04..2e8f4e458430 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -66,6 +66,12 @@ enum mptcp_pm_type {
 	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
 };
 
+enum mptcp_pm_family {
+	IPV4 = 0,
+	IPV6,
+	IPV4MAPPED,
+};
+
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int duration;
 
@@ -797,6 +803,242 @@ static void test_iters_address(void)
 	close(cgroup_fd);
 }
 
+static int userspace_pm_add_addr(__u32 token, char *addr, __u8 id)
+{
+	return SYS_NOFAIL("ip netns exec %s %s ann %s id %u token %u",
+			  NS_TEST, PM_CTL, addr, id, token);
+}
+
+static int userspace_pm_get_addr(__u32 token, __u8 id, char *output)
+{
+	char cmd[1024];
+	FILE *fp;
+
+	sprintf(cmd, "ip netns exec %s %s get %u token %u",
+		NS_TEST, PM_CTL, id, token);
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
+static int userspace_pm_dump_addr(__u32 token, char *output)
+{
+	char cmd[1024];
+	FILE *fp;
+
+	sprintf(cmd, "ip netns exec %s %s dump token %u",
+		NS_TEST, PM_CTL, token);
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
+static int userspace_pm_rm_addr(__u32 token, __u8 id)
+{
+	return SYS_NOFAIL("ip netns exec %s %s rem id %u token %u",
+			  NS_TEST, PM_CTL, id, token);
+}
+
+static void run_userspace_pm(enum mptcp_pm_family family)
+{
+	bool ipv6 = (family == IPV6 || family == IPV4MAPPED);
+	bool ipv4mapped = (family == IPV4MAPPED);
+	int server_fd, client_fd, accept_fd;
+	char output[BUFSIZ], expect[1024];
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
+	sprintf(expect, "id 100 flags subflow %s\n", addr);
+	err = userspace_pm_get_addr(token, 100, output);
+	if (!ASSERT_OK(err, "userspace_pm_get_addr 100") ||
+	    !ASSERT_STRNEQ(output, expect, sizeof(expect), "get_addr"))
+		goto close_accept;
+
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+
+	err = userspace_pm_set_flags(token, addr, "backup");
+	if (!ASSERT_OK(err, "userspace_pm_set_flags backup"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	sprintf(expect, "id 100 flags subflow,backup %s\n", addr);
+	err = userspace_pm_get_addr(token, 100, output);
+	if (!ASSERT_OK(err, "userspace_pm_get_addr 100") ||
+	    !ASSERT_STRNEQ(output, expect, sizeof(expect), "get_addr"))
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
+	sprintf(expect, "id 100 flags subflow %s\n", addr);
+	err = userspace_pm_get_addr(token, 100, output);
+	if (!ASSERT_OK(err, "userspace_pm_get_addr 100") ||
+	    !ASSERT_STRNEQ(output, expect, sizeof(expect), "get_addr"))
+		goto close_accept;
+
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+
+	err = userspace_pm_rm_subflow(token, addr, 100);
+	if (!ASSERT_OK(err, "userspace_pm_rm_subflow 100"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	err = userspace_pm_dump_addr(token, output);
+	if (!ASSERT_OK(err, "userspace_pm_dump_addr") ||
+	    !ASSERT_STRNEQ(output, "", sizeof(output), "dump_addr"))
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
+	sprintf(expect, "id 200 flags signal %s\n", addr);
+	err = userspace_pm_dump_addr(token, output);
+	if (!ASSERT_OK(err, "userspace_pm_dump_addr") ||
+	    !ASSERT_STRNEQ(output, expect, sizeof(expect), "dump_addr"))
+		goto close_accept;
+
+	send_byte(client_fd);
+	recv_byte(accept_fd);
+
+	err = userspace_pm_rm_addr(token, 200);
+	if (!ASSERT_OK(err, "userspace_pm_rm_addr 200"))
+		goto close_accept;
+
+	send_byte(accept_fd);
+	recv_byte(client_fd);
+
+	err = userspace_pm_rm_addr(token, 0);
+	ASSERT_OK(err, "userspace_pm_rm_addr 0");
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
+	struct nstoken *nstoken;
+	int err;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		return;
+
+	err = userspace_pm_init(MPTCP_PM_TYPE_USERSPACE);
+	if (!ASSERT_OK(err, "userspace_pm_init: userspace pm"))
+		goto fail;
+
+	run_userspace_pm(IPV4);
+
+	userspace_pm_cleanup();
+fail:
+	cleanup_netns(nstoken);
+}
+
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -982,6 +1224,8 @@ void test_mptcp(void)
 		test_iters_subflow();
 	if (test__start_subtest("iters_address"))
 		test_iters_address();
+	if (test__start_subtest("userspace_pm"))
+		test_userspace_pm();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.45.2


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CAE374D1
	for <mptcp@lists.linux.dev>; Fri, 30 Aug 2024 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000945; cv=none; b=st10j06DNwnwXIs9BIrB/pfdGhl/+U5vFo0Pkx/VgOH/xrgF7CwL88zZOF7JIjtvbI+LN+VDSl/YoZtGk/FGhBjLizrKvzx9oHvcGcY004Lq8TtVei+0NyR1nkDY4fDT1uFVUywrGZ67/2GTfTBcwjYXmZYkY5CNkmiP3/ceLQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000945; c=relaxed/simple;
	bh=WQUOivnus5pQDSF5A5ALacDHfB37HG9FZxBZIj4lPdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+i01aV4Rm72xjV7ubB6bmiflpTzfm/vajCUOE+lYkzlfWzSz4GRWYD0Afv+G4gTVWUBBs2hBiG3TER+r8Qz2m+rj/NZBsyJmrecsyymG/TaFPDkQPU727mkOkyDXCRmcwRTtIpP/h6yWlZ5u7nuKuX1eQ33nLhz662KrIxXTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRon3fvG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRon3fvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2598C4CEC2;
	Fri, 30 Aug 2024 06:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000945;
	bh=WQUOivnus5pQDSF5A5ALacDHfB37HG9FZxBZIj4lPdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRon3fvGVbd9A/KzKSM4a0xJrxnp//RkgGWNo1B+kAYnuHIxy9/YfI50/u9Z9bTfl
	 msi894eOxHGa8D8zAShtJW6mXQz/GdEQTz9wMt4pVVV54K5yBXz2sjLmAaK4Ln2f/1
	 N7cCTgiNchA1j0w20e6ljAfkRiKKUNKSNElOQNpVMNLPY4nz+lU2Z9AmlfHMlhG9jy
	 zolTMXc4GNjFCyfoZcOyEltv0HemwC0oEDTgHnwhs+o+24vJJcdfGtZCvsBhZzDKdO
	 WTEJnvNHF1dAqUfy0JNOCU1CH8AvOjiogtzEKjrWF0LaQ+BA3Slx2mjd3AeubHOGY7
	 TYcyHDR6lfqHw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 3/4] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Fri, 30 Aug 2024 14:55:32 +0800
Message-ID: <3ddd55ba936f0fa4872cdf4044d0f5ff58a48052.1725000687.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725000687.git.tanggeliang@kylinos.cn>
References: <cover.1725000687.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop ss_search() from run_subflow().

Use the "cgroup/getsockopt" way to inspect the subflows.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 57 ++++++++++++-------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 73adc58cd776..6085aaf61b27 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -368,21 +368,29 @@ static int endpoint_init(char *flags)
 	return -1;
 }
 
-static int _ss_search(char *src, char *dst, char *port, char *keyword)
+static void wait_for_new_subflows(int fd)
 {
-	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
-			  NS_TEST, src, dst, port, PORT_1, keyword);
-}
+	socklen_t len;
+	u8 subflows;
+	int err, i;
 
-static int ss_search(char *src, char *keyword)
-{
-	return _ss_search(src, ADDR_1, "dport", keyword);
+	len = sizeof(subflows);
+	/* Wait max 1 sec for new subflows to be created */
+	for (i = 0; i < 10; i++) {
+		err = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &subflows, &len);
+		if (!err && subflows > 0)
+			break;
+
+		sleep(0.1);
+	}
 }
 
-static void run_subflow(char *new)
+static void run_subflow(void)
 {
 	int server_fd, client_fd, err;
+	char new[TCP_CA_NAME_MAX];
 	char cc[TCP_CA_NAME_MAX];
+	unsigned int mark;
 	socklen_t len;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
@@ -393,19 +401,21 @@ static void run_subflow(char *new)
 	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
 		goto close_server;
 
-	len = sizeof(cc);
-	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
-	if (!ASSERT_OK(err, "getsockopt(server_fd, TCP_CONGESTION)"))
-		goto close_client;
-
 	send_byte(client_fd);
+	wait_for_new_subflows(client_fd);
+
+	len = sizeof(mark);
+	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)"))
+		ASSERT_EQ(mark, 0, "mark");
+
+	len = sizeof(new);
+	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, new, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)")) {
+		get_msk_ca_name(cc);
+		ASSERT_STREQ(new, cc, "cc");
+	}
 
-	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
-	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
-	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
-	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
-
-close_client:
 	close(client_fd);
 close_server:
 	close(server_fd);
@@ -416,6 +426,7 @@ static void test_subflow(void)
 	int cgroup_fd, prog_fd, err;
 	struct mptcp_subflow *skel;
 	struct nstoken *nstoken;
+	struct bpf_link *link;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
@@ -441,8 +452,14 @@ static void test_subflow(void)
 	if (endpoint_init("subflow") < 0)
 		goto close_netns;
 
-	run_subflow(skel->data->cc);
+	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
+					  cgroup_fd);
+	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
+		goto close_netns;
+
+	run_subflow();
 
+	bpf_link__destroy(link);
 close_netns:
 	cleanup_netns(nstoken);
 skel_destroy:
-- 
2.43.0


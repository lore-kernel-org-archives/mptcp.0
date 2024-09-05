Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103C946F
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503235; cv=none; b=iQocgw87wvyx3gSpKDz++uzFez//1LgENoK8MM1WIChE5W+F2SZ0m/Zk6QJUw1MhrM1u9ZrXBRwy21/FqWC8kUpn7kyMzUGSTpb1hR+TwAGfDW8lbQwdFggCgEULrEIokpr+1e8LkXMbPM3vWedEBigOFhJI4Aj9G++n/AC1Cjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503235; c=relaxed/simple;
	bh=FKp2AXTZvWfFb74Lr6WOnMOvIGbHhaa+mrQAjNVYvh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWf3xZjpYGblOCYPtA8XlP1uskitB7SXiyYRodMdTR1W+UiNTrvrRiApVwVXkQ3Gu6nZ8hd3KIMxIZSsZPXGnqi7cROAW1eJ48HwrA4qxMbiY6WOJy52Py/ydJ49JYkBBIft0HUxTAYyln4IqQEZxd/w/fwEW2fbk2IjByCTnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiLO/cR8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiLO/cR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC9DC4CEC6;
	Thu,  5 Sep 2024 02:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725503235;
	bh=FKp2AXTZvWfFb74Lr6WOnMOvIGbHhaa+mrQAjNVYvh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiLO/cR8eUrDNjH9plmZHs+UGs8zc6HsrK+MQ33k7aZNOuEazmGml8627dApkexaW
	 qQW7nfzaWyeccOKcN3LShEmt6XAmuaGkXMuvCSEYH21bVfai/lwdzoaQYksgGRgIF+
	 EF2uwmoHcF2TxY4nsnSxmoYG20u1iDBXNpSDsssG1pWOuUDfsY98cBTwtFvMpmCoKb
	 +xIcgu4tBElZ+E9H0hUnY2qmeX95JrjeNpw8+Mlc3EKL3lTRt0xprqSqvTqazyF62e
	 YLPjw5xthw9icWQKQTQlr7yB82mwF2RpjN3/cvLkiKvKR8xN8l9/Azs6ej9yA2vL6f
	 ot9wg2oc7uP1Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 3/4] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Thu,  5 Sep 2024 10:26:58 +0800
Message-ID: <d82efba7e785538f49637fee806f9674e6b01a93.1725502822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725502822.git.tanggeliang@kylinos.cn>
References: <cover.1725502822.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 55 ++++++++++++++-----
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 73adc58cd776..29d3d6abc6c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -374,15 +374,29 @@ static int _ss_search(char *src, char *dst, char *port, char *keyword)
 			  NS_TEST, src, dst, port, PORT_1, keyword);
 }
 
-static int ss_search(char *src, char *keyword)
+static void wait_for_new_subflows(int fd)
 {
-	return _ss_search(src, ADDR_1, "dport", keyword);
+	socklen_t len;
+	u8 subflows;
+	int err, i;
+
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
@@ -393,19 +407,21 @@ static void run_subflow(char *new)
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
@@ -416,6 +432,7 @@ static void test_subflow(void)
 	int cgroup_fd, prog_fd, err;
 	struct mptcp_subflow *skel;
 	struct nstoken *nstoken;
+	struct bpf_link *link;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
@@ -425,6 +442,8 @@ static void test_subflow(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_subflow"))
 		goto close_cgroup;
 
+	skel->bss->pid = getpid();
+
 	err = mptcp_subflow__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach: mptcp_subflow"))
 		goto skel_destroy;
@@ -441,8 +460,14 @@ static void test_subflow(void)
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


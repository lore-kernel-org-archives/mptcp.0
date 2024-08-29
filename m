Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4D4A18
	for <mptcp@lists.linux.dev>; Thu, 29 Aug 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900018; cv=none; b=uWp/zY3Ue3neqrOv/Nd3iE682dOBUMCNSnOVPC5giE23LgRcqoBLxXCAf56tdXqepbtVe+tqjxOvD0wE2+ze+7B/027X6Ia0PjaN1Fv/FqjszRjkPRk5DxQinIrJQK6IbKVL8YhjgvEWbPc8Niu3GHHPUUR50yaInrvETS1sydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900018; c=relaxed/simple;
	bh=L5ZeMYrmrXYvy+ez4+qN85mxL1CltHXpzEVAvPXG/HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPq6aNvYHmOTX8iC0A8g43MEcbtvLpt2oWHX94dlc5q0C5t7mQMksbLeTjpc7rt9VQw9mD6ymBpgKsM2ZwS1PFxHClN0d0E5kla5uefEXkCFaypImaifi42QJJa3M1kepmvz1NHZqtrglnqCdtPBQR4nKicVqJiKw8d8wULnn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4eyfAQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4eyfAQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B81C4CEC2;
	Thu, 29 Aug 2024 02:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724900018;
	bh=L5ZeMYrmrXYvy+ez4+qN85mxL1CltHXpzEVAvPXG/HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4eyfAQ01rPYOsRkP/lODYiU83puDHQbOvXiK0p5103irDvl2Kt3GE+qcxy56ju8l
	 7DJfqo6bSBueTXD/Vf1Q05OWOKUR8hRYZty0zptKkSXcpe7oPKN0OT1psUABETsG9+
	 Ty7BCwOlF1oTv20+sqM8vDQEqoscp2THXj8LLhb3ESM5dL67o3z+U4VYgrGerEi/WV
	 0HIMqm+5wVynJd3KAfz7DU5rh52tYHAw8I1TzB3tThiwagMK2nkQQjhHPpI2V5K9uf
	 73APMwW+P2AG92OohJYd33KUDhrSJ/lJkNOA4a6Z6yqccfzxVzEwLliqqHmaK7/Pp8
	 qr8vhZah1Zujg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/3] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Thu, 29 Aug 2024 10:53:26 +0800
Message-ID: <5cbf9b5c1ec58619e78f713f87ede6805d7c264d.1724899785.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724899785.git.tanggeliang@kylinos.cn>
References: <cover.1724899785.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 52 +++++++++++--------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 73adc58cd776..85883515c67b 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -368,22 +368,13 @@ static int endpoint_init(char *flags)
 	return -1;
 }
 
-static int _ss_search(char *src, char *dst, char *port, char *keyword)
-{
-	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
-			  NS_TEST, src, dst, port, PORT_1, keyword);
-}
-
-static int ss_search(char *src, char *keyword)
-{
-	return _ss_search(src, ADDR_1, "dport", keyword);
-}
-
 static void run_subflow(char *new)
 {
-	int server_fd, client_fd, err;
+	int server_fd, client_fd, err, i;
 	char cc[TCP_CA_NAME_MAX];
+	unsigned int mark;
 	socklen_t len;
+	u8 subflows;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
@@ -393,17 +384,29 @@ static void run_subflow(char *new)
 	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
 		goto close_server;
 
-	len = sizeof(cc);
-	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
-	if (!ASSERT_OK(err, "getsockopt(server_fd, TCP_CONGESTION)"))
-		goto close_client;
-
 	send_byte(client_fd);
 
-	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
-	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
-	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
-	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
+	len = sizeof(subflows);
+	/* Wait max 1 sec for new subflows to be created */
+	for (i = 0; i < 10; i++) {
+		err = getsockopt(client_fd, SOL_MPTCP, MPTCP_INFO, &subflows, &len);
+		if (!err && subflows > 0)
+			break;
+
+		sleep(0.1);
+	}
+
+	len = sizeof(mark);
+	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
+	if (!ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)"))
+		goto close_client;
+	ASSERT_EQ(mark, 0, "mark");
+
+	len = sizeof(cc);
+	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
+	if (!ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)"))
+		goto close_client;
+	ASSERT_STREQ(cc, new, "cc");
 
 close_client:
 	close(client_fd);
@@ -416,6 +419,7 @@ static void test_subflow(void)
 	int cgroup_fd, prog_fd, err;
 	struct mptcp_subflow *skel;
 	struct nstoken *nstoken;
+	struct bpf_link *link;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
@@ -441,6 +445,11 @@ static void test_subflow(void)
 	if (endpoint_init("subflow") < 0)
 		goto close_netns;
 
+	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
+					  cgroup_fd);
+	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
+		goto close_netns;
+
 	run_subflow(skel->data->cc);
 
 close_netns:
@@ -448,6 +457,7 @@ static void test_subflow(void)
 skel_destroy:
 	mptcp_subflow__destroy(skel);
 close_cgroup:
+	bpf_link__destroy(link);
 	close(cgroup_fd);
 }
 
-- 
2.43.0


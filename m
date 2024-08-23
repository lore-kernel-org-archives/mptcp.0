Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7A9457
	for <mptcp@lists.linux.dev>; Fri, 23 Aug 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415593; cv=none; b=LZDDK5p/ovdEd+J24gJPJaWmuHemh2is+N9izyvu6XOGcbPsZMKapKVpzLrOMdiH3OGQInjiCJbtTsc5J1yZ3chacQpNOokOQjYNz7KX0eM6IqQXHkqBIlCVXTUJ8IVTJBTnmcYMfnamUSkDS7ZE7yG/j31Fze+FXgSKS52uMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415593; c=relaxed/simple;
	bh=dShtpQH9VzYZAkcj7Wvr74tsBBhLr/BUtoZ4Tfp9Jbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiKRwBVwJGh0iHMW72pMeAlwfOxf1Wu3Pvt2F8qKlVxHV1T4HASZLeIiek0oUO2Nrln3G6oFHoYxxYY2g7KAUOIZyaKjnMr52G2WXRuV5okfn6RciqJR+iFHQu8EeLlGpuMnuzr4urTcbCzSFT+uCu//9bpDdcyufEz599VOOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfS4S5rF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfS4S5rF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AB4C4AF09;
	Fri, 23 Aug 2024 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724415592;
	bh=dShtpQH9VzYZAkcj7Wvr74tsBBhLr/BUtoZ4Tfp9Jbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WfS4S5rF73A4GaOUxYcsRYeDwY45vKTJIlYS9629n6T7jJIsZPObJ1IKVt/mLK4Ih
	 kXjyfKUkcnPaIpuHiV+iwIoQ7tKqgZ2JJHkV7OfjhDVSrp+rkMr2RyL9t4kylQMXbJ
	 EuGSINnaXvrJg0WL6b+PQXjY4+RpXFh+mUZMqYx5ZZYm5kvCy8z+hyc9NlXyu5e4au
	 dKcTbLkTJbl3qCFp3Foc3p6IWzu30aSg86gbrDzDml3zBpqIPfJ45UbgHM0g/g+PYD
	 eScYLnQ3/BNYaXtniNMSwWs97RX/CvCpKf5J6Wc4H0L8o2ZF/bJQj/LnQUxPE2Xo/8
	 kUkkxtcyqxgbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/3] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Fri, 23 Aug 2024 20:19:41 +0800
Message-ID: <ac6c7b2338205693434883a34256eddfd7605985.1724415435.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724415435.git.tanggeliang@kylinos.cn>
References: <cover.1724415435.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop ss_search() from run_subflow().

Now ss_search() are only used by bpf_sched tests. It will be dropped
in next step.

Use the "cgroup/getsockopt" way to inspect the subflows.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 57 ++++++++++++-------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 73adc58cd776..ce464b1e0802 100644
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
@@ -393,17 +384,26 @@ static void run_subflow(char *new)
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
+	if (!ASSERT_OK(err || mark != 2, "getsockopt(client_fd, SO_MARK)"))
+		goto close_client;
+
+	len = sizeof(cc);
+	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
+	ASSERT_OK(err || strcmp(cc, new), "getsockopt(client_fd, TCP_CONGESTION)");
 
 close_client:
 	close(client_fd);
@@ -416,6 +416,7 @@ static void test_subflow(void)
 	int cgroup_fd, prog_fd, err;
 	struct mptcp_subflow *skel;
 	struct nstoken *nstoken;
+	struct bpf_link *link;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
@@ -441,6 +442,11 @@ static void test_subflow(void)
 	if (endpoint_init("subflow") < 0)
 		goto close_netns;
 
+	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
+					  cgroup_fd);
+	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
+		goto close_netns;
+
 	run_subflow(skel->data->cc);
 
 close_netns:
@@ -449,6 +455,7 @@ static void test_subflow(void)
 	mptcp_subflow__destroy(skel);
 close_cgroup:
 	close(cgroup_fd);
+	bpf_link__destroy(link);
 }
 
 static struct nstoken *sched_init(char *flags, char *sched)
@@ -470,9 +477,15 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	return NULL;
 }
 
+static int ss_search(char *src, char *dst, char *port, char *keyword)
+{
+	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
+			  NS_TEST, src, dst, port, PORT_1, keyword);
+}
+
 static int has_bytes_sent(char *dst)
 {
-	return _ss_search(ADDR_1, dst, "sport", "bytes_sent:");
+	return ss_search(ADDR_1, dst, "sport", "bytes_sent:");
 }
 
 static void send_data_and_verify(char *sched, bool addr1, bool addr2)
-- 
2.43.0


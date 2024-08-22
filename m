Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D816F271
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318583; cv=none; b=ZZx7KJrUc+2XOn/03gEl1i2wUscD4PcXm529isRS4jx5oqdY0w0Enfz9g4QEamj1NHPZks7Synpd73HNwgu0RcP63ggFWlpDorYKznVUASgeQH97cobybLcxA+m+vCrtL7loIm0ct2eU0UXZS9C07Rq6HzNGmqkDxjhL3TD1hSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318583; c=relaxed/simple;
	bh=3YBsv84w4lrU4OmbMelhgmMuJXJl6kxTL5qbkP/gLBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adm/R2vpXiIqFncFi3vItbNIz6R/jP6kg1cnQxCfsLcK+/IajVrAbZncF1mLSG0GqLZxYD9Ypdnv069V+fx57wSONI1F3cx4z9tqzaQtlI7wTy7UQ8J1LowKxPRK5EmdW1JE5Z9JsPeFg2yvZV7TyIkMVDfUOVuAt+aZCpVPoA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY5eLBg4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY5eLBg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A56C4AF09;
	Thu, 22 Aug 2024 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724318583;
	bh=3YBsv84w4lrU4OmbMelhgmMuJXJl6kxTL5qbkP/gLBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aY5eLBg4vwkw5wJvqKQyp8W/ATr6Y2t95+3oDaiaVPsVtpqeI9EW4L2+unyJfomKm
	 fKNXyLg5QaM60yr+L+VDo/YfdPKDsyL4rKq9A9piF3FZYnDgiQ0KzAqZPoW6fav0K7
	 MnF5KZ2fH6yW/Lq5kc9SbuNrkymnIeRA27R+Uvabfx3DxZy2YcwMj6z5ez6TTUfBCx
	 xQuho08cHTrGWAf4Y074tmGIgdNiSFilPDmMLlIsMjtt51d4bZVzrV6UVKVGj/8IBc
	 9qMSoU/IVnXz84vhgJnlsHSg87a8Oun0Nsn6krzFtZU45xtFxxEO0IdV7pdswL4vBt
	 X1ciInzBWsv/w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/2] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Thu, 22 Aug 2024 17:22:50 +0800
Message-ID: <c5da123e1bdcbeb093ef98469700eb88343295e9.1724318341.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724318341.git.tanggeliang@kylinos.cn>
References: <cover.1724318341.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++--------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 73adc58cd776..d4c5209fbfaf 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -368,22 +368,9 @@ static int endpoint_init(char *flags)
 	return -1;
 }
 
-static int _ss_search(char *src, char *dst, char *port, char *keyword)
+static void run_subflow(void)
 {
-	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
-			  NS_TEST, src, dst, port, PORT_1, keyword);
-}
-
-static int ss_search(char *src, char *keyword)
-{
-	return _ss_search(src, ADDR_1, "dport", keyword);
-}
-
-static void run_subflow(char *new)
-{
-	int server_fd, client_fd, err;
-	char cc[TCP_CA_NAME_MAX];
-	socklen_t len;
+	int server_fd, client_fd;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
@@ -393,19 +380,8 @@ static void run_subflow(char *new)
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
-
-close_client:
 	close(client_fd);
 close_server:
 	close(server_fd);
@@ -441,7 +417,7 @@ static void test_subflow(void)
 	if (endpoint_init("subflow") < 0)
 		goto close_netns;
 
-	run_subflow(skel->data->cc);
+	run_subflow();
 
 close_netns:
 	cleanup_netns(nstoken);
@@ -470,9 +446,15 @@ static struct nstoken *sched_init(char *flags, char *sched)
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542E224F2
	for <mptcp@lists.linux.dev>; Wed, 20 Mar 2024 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938238; cv=none; b=aDeythrzQfa3m//Cqbj8DTQBNO8pOPgesgiseDqEYTiaIMQBkBZ7v65NzZD2JGnbTDIQBPyO+bfa6c/YkcyW0vnYvVP/bLX8pTjbj4RRRavc2FRH4Esgyz/VGp+yy770/XQc8vlQGdREI49XAtACTiugUFT/Suj++Rfd40isfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938238; c=relaxed/simple;
	bh=gF7JB0MhzhiJ48W2moLFy/LWsBJyaDNlIeMtTOMkgxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nVgmY38/oSUdaw6QV+iMTBQTNYseBpPSATSImffKigfQxzq3yAYPrcPR4fQ+nZWYiYc54S34rRSu5VMXYCMxDbqs0i/pt+0x2ERNyXKXxaxtTy2mPVdqus9LgxapvawKEqKS21YbXDAwFRsb8Td1q0JAi5HULwoTEV2IFJbNQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIABZ5Sz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIABZ5Sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD2C433C7;
	Wed, 20 Mar 2024 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710938238;
	bh=gF7JB0MhzhiJ48W2moLFy/LWsBJyaDNlIeMtTOMkgxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cIABZ5SzzJodgY0keMkqdvTYot5mLKy6yq3PMX9WHzQSa5kj/C2r9XffLYrHMnSpd
	 iCiCXf5c/xccnPPLN9z02be75X1DHxIkwivGJ9p9LEucvnv284Fj84++gA8W3oNPfm
	 L/YbjG0O9skBB5g731snOXY7idsFLMqPr/z15u1NN6Q/8K7bkZeTXPH74Wbp4EABIf
	 X3DKIJunXU0O0GeRcQDqGlDD4ROxS9ttsn16BNw5j1iqsIYOCWmxfv6emtlsgRfR2G
	 ldUqZi8wNc/8T/ieQsE2LOQ46V8y/zd85iWovjaT7t8rCjmBksKhfLybh+ydjN5QIv
	 ROlbsvzbMCDUA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/4] Squash to "selftests/bpf: Add bpf scheduler test" cleanup
Date: Wed, 20 Mar 2024 20:37:05 +0800
Message-Id: <8ef700f197305cebffc35197163fb6fe476fc50c.1710938175.git.tanggeliang@kylinos.cn>
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

Some cleanups.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 83efcdd7739d..62d4d4a09ebf 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -417,7 +417,7 @@ void test_subflow(void)
 }
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
-static int stop, duration;
+static int stop;
 
 static void *server(void *arg)
 {
@@ -476,11 +476,12 @@ static void send_data(int lfd, int fd, char *msg)
 	int err;
 
 	WRITE_ONCE(stop, 0);
+
 	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
 		return;
 
 	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
-	if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
+	if (!ASSERT_OK(err, "pthread_create"))
 		return;
 
 	/* recv total_bytes */
@@ -513,10 +514,6 @@ static void send_data(int lfd, int fd, char *msg)
 		printf("FAIL:pthread_join thread_ret:%ld\n", PTR_ERR(thread_ret));
 }
 
-#define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
-#define PORT_1	10001
-
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -525,12 +522,9 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
-	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
-	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
-	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
-	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
-	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+		goto fail;
+
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
 
 	return nstoken;
@@ -538,12 +532,13 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	return NULL;
 }
 
-static int has_bytes_sent(char *addr)
+static int has_bytes_sent(char *dst)
 {
 	char cmd[128];
 
-	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it src %s sport %d dst %s | %s",
-		 NS_TEST, ADDR_1, PORT_1, addr, "grep -q bytes_sent:");
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -it src %s sport %d dst %s | %s",
+		 NS_TEST, ADDR_1, PORT_1, dst, "grep -q bytes_sent:");
 	return system(cmd);
 }
 
-- 
2.40.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B540651B3
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619422; cv=none; b=TwPE5JPaqTBKUPHUcI2PP9f8yS+ZiXWCITsroYXH6u/GRieuScKG34oJPKvV6ImrE04haXqNGyH4YGATDhcmPQnIJADmzXr4iR6hdAUW5SSjsrz0A/DpKPKqJYopc60kfTaz9EJm2mGJYWQIDwe5t0DYtsV9NfzjU4TTfK068Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619422; c=relaxed/simple;
	bh=nL3qLXvdwR7DIDvPS0okmAQ89oB/hm8t/VruSlgHWAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bs9btHixZe/Po913YZSg8qxcu/uAM9yh5+Y2HAdw1wN1fIIGe7KocSIgCVW90b4KPNFk0YIPz2S76hoOBAP+w36U0nLX1OZG0BFT5toohauSjAN5TdUdS36dOTvBVp2VMTK6bczPq+ZHnNJ/OB+zQWY2I6jlGsMwJ5O84DEScrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjOZKHBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjOZKHBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A029C433F1;
	Thu, 28 Mar 2024 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619421;
	bh=nL3qLXvdwR7DIDvPS0okmAQ89oB/hm8t/VruSlgHWAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjOZKHBogNv+hIY4EF+lJBfXWv8wIXWmNu+7ARt9oJFm75/N3FEzzzQILjqt4fGNL
	 /fBuJJ8wnobvZRLWuI0tdJ+Jh7Y/Vj/MWCRsYn2eErJp1djSY9qDjQQXwiznxHLg+N
	 5SKwMzmMFCX+yt6Yuu2pAoMZOIPMt823HuqF9G2RLGtV9SPAqkKcCAOPbknkLxMac6
	 DqsoxdCPY8dPYMTP6xSZccHI6m/cdApAMVlVPNqdokvI26tWuMX5F6/NS9R/isgI01
	 CeRcTEgax0MbLFR0gM4QgU/+qQlIgHC0uNwOKYr4n/w2C3Fxi4yS2dTfQpUofjvmDH
	 /zezNDnANQAQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 06/11] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Thu, 28 Mar 2024 17:50:03 +0800
Message-Id: <019954800390c88a5cbcefe4ce2b438b75419763.1711619108.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711619108.git.tanggeliang@kylinos.cn>
References: <cover.1711619108.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some cleanups.

Use ASSERT_EQ and ASSERT_OK like below commit:

selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca

Use newly added endpoint_init and _ss_search helpers.

Add send_data_and_verify helper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 63 ++++++++++++-------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index b8ec11552e2c..c400dbaccc10 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,7 +5,6 @@
 #include <linux/const.h>
 #include <netinet/in.h>
 #include <test_progs.h>
-#include <time.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
@@ -308,7 +307,7 @@ static void run_mptcpify(int cgroup_fd, struct mptcpify *skel)
 MPTCP_BASE_TEST(mptcpify);
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
-static int stop, duration;
+static int stop;
 
 static void *server(void *arg)
 {
@@ -341,8 +340,7 @@ static void *server(void *arg)
 		bytes += nr_sent;
 	}
 
-	CHECK(bytes != total_bytes, "send", "%zd != %u nr_sent:%zd errno:%d\n",
-	      bytes, total_bytes, nr_sent, errno);
+	ASSERT_EQ(bytes, total_bytes, "send");
 
 done:
 	if (fd >= 0)
@@ -365,11 +363,12 @@ static void send_data(int lfd, int fd, char *msg)
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
@@ -387,17 +386,13 @@ static void send_data(int lfd, int fd, char *msg)
 		return;
 
 	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
-
-	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
-	      bytes, total_bytes, nr_recv, errno);
-
 	printf("%s: %u ms\n", msg, delta_ms);
 
-	WRITE_ONCE(stop, 1);
+	ASSERT_EQ(bytes, total_bytes, "recv");
 
+	WRITE_ONCE(stop, 1);
 	pthread_join(srv_thread, &thread_ret);
-	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
-	      PTR_ERR(thread_ret));
+	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
 }
 
 #define ADDR_1	"10.0.1.1"
@@ -425,32 +420,53 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	return NULL;
 }
 
-static int has_bytes_sent(char *addr)
+static int has_bytes_sent(char *dst)
 {
 	char cmd[128];
 
 	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it src %s sport %d dst %s | %s",
-		 NS_TEST, ADDR_1, PORT_1, addr, "grep -q bytes_sent:");
+		 NS_TEST, ADDR_1, PORT_1, dst, "grep -q bytes_sent:");
 	return system(cmd);
 }
 
-static void test_default(void)
+static void send_data_and_verify(char *msg, int addr1, int addr2)
 {
 	int server_fd, client_fd;
-	struct nstoken *nstoken;
 
-	nstoken = sched_init("subflow", "default");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
-		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_NEQ(server_fd, -1, "start_mptcp_server"))
+		return;
+
 	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_NEQ(client_fd, -1, "connect_to_fd")) {
+		close(server_fd);
+		return;
+	}
 
-	send_data(server_fd, client_fd, "default");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+	send_data(server_fd, client_fd, msg);
+	if (addr1)
+		ASSERT_OK(has_bytes_sent(ADDR_1), "Should have bytes_sent on addr1");
+	else
+		ASSERT_GT(has_bytes_sent(ADDR_1), 0, "Shouldn't have bytes_sent on addr1");
+	if (addr2)
+		ASSERT_OK(has_bytes_sent(ADDR_2), "Should have bytes_sent on addr2");
+	else
+		ASSERT_GT(has_bytes_sent(ADDR_2), 0, "Shouldn't have bytes_sent on addr2");
 
 	close(client_fd);
 	close(server_fd);
+}
+
+static void test_default(void)
+{
+	struct nstoken *nstoken;
+
+	nstoken = sched_init("subflow", "default");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
+		goto fail;
+
+	send_data_and_verify("default", 1, 1);
+
 fail:
 	cleanup_netns(nstoken);
 }
@@ -640,8 +656,7 @@ void test_mptcp(void)
 {
 	RUN_MPTCP_TEST(mptcp_sock);
 	RUN_MPTCP_TEST(mptcpify);
-	if (test__start_subtest("default"))
-		test_default();
+	RUN_MPTCP_TEST(default);
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.40.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78B54BC4
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613128; cv=none; b=U3JYv4sV7oEOPoOAURi8o5d3Jurl6JRzA5dIgePI/Eu9t70KLwhePXvABHyS/UUBzK+J0R/t3Ns1mFadzRi+DLfZWgfUk34fciiUX1yCL0vaBHlSW+Y+P3sQGYLuIPGPo/fEwXXer6qRz2ZqwMsVP0wkzqXVsWnzkEASD5nXNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613128; c=relaxed/simple;
	bh=e8njyXUUWS/L8WHy0VCHW1+ftqfMAsx5RVQqE94R6JM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TgqEEf1jL5zbI+10MebQEvj20U+F0zYwqPDHXnXmMoytKE6t9t/twFgsjQ6UBFyjA2KY0UK5/o2i1nvCzD0ReiIuORyjox2F+aypdpl3pOLMKO7NwF/pYii2MzQgZU2sT/LKY5iyff4xUVoi5UT+sJRTP7LPCLO18680KX6kO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuYWfOu1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuYWfOu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F7FC433C7;
	Thu, 28 Mar 2024 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613127;
	bh=e8njyXUUWS/L8WHy0VCHW1+ftqfMAsx5RVQqE94R6JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuYWfOu1uioYOKhtqlYtzjULsXw0JLzr39/+/8xx8FqbjBIAOMNRDPkB8WDdTy7PP
	 1Rk7tLNa/MxGDWujk/VpbJsPerkOwjXszceuDaOz/JuDpGyHze6C8S2gZv0vaLk1C4
	 UOem0kGTm4qwGU9F5gYHR1oWGESMzLlf1/0naTrKnt4jZBoXpK9toBOUfrNHKB1S3b
	 VwSmOdBxykFMAw6OIRZLsNi5a8YtGxWFrGzMXz4I0zsRyX7NbRJQpJLzziVbjQvP9C
	 uIG3nPmdEqibnt9EvqVsYQhG7ek6uUEfKV5N2e/JCJYH9Aaw7ajtm4HqQ6fRWrFeO2
	 iK6oj22xC1VjA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 08/14] Squash to "selftests/bpf: Add bpf scheduler test" - cleanups
Date: Thu, 28 Mar 2024 16:04:55 +0800
Message-Id: <532bd8367396a76c3b2c280240dfa50b7b677263.1711612876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711612876.git.tanggeliang@kylinos.cn>
References: <cover.1711612876.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 75 +++++++++++--------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 69f989e6d930..7f2e7a419330 100644
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
@@ -380,7 +379,7 @@ static void run_mptcp_subflow(int cgroup_fd, struct mptcp_subflow *skel)
 MPTCP_BASE_TEST(mptcp_subflow);
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
-static int stop, duration;
+static int stop;
 
 static void *server(void *arg)
 {
@@ -413,8 +412,7 @@ static void *server(void *arg)
 		bytes += nr_sent;
 	}
 
-	CHECK(bytes != total_bytes, "send", "%zd != %u nr_sent:%zd errno:%d\n",
-	      bytes, total_bytes, nr_sent, errno);
+	ASSERT_EQ(bytes, total_bytes, "send");
 
 done:
 	if (fd >= 0)
@@ -437,11 +435,12 @@ static void send_data(int lfd, int fd, char *msg)
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
@@ -459,17 +458,13 @@ static void send_data(int lfd, int fd, char *msg)
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
@@ -482,47 +477,62 @@ static struct nstoken *sched_init(char *flags, char *sched)
 
 	nstoken = create_netns();
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		return NULL;
+
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
 		goto fail;
 
-	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
-	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
-	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
-	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
-	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
 
 	return nstoken;
 fail:
+	cleanup_netns(nstoken);
 	return NULL;
 }
 
-static int has_bytes_sent(char *addr)
+static int has_bytes_sent(char *dst)
 {
-	char cmd[128];
+	return _ss_search(ADDR1, dst, "sport", "bytes_sent:");
+}
 
-	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it src %s sport %d dst %s | %s",
-		 NS_TEST, ADDR_1, PORT_1, addr, "grep -q bytes_sent:");
-	return system(cmd);
+static void send_data_and_verify(char *msg, int addr1, int addr2)
+{
+	int server_fd, client_fd;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR1, PORT1, 0);
+	if (!ASSERT_NEQ(server_fd, -1, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_NEQ(client_fd, -1, "connect_to_fd")) {
+		close(server_fd);
+		return;
+	}
+
+	send_data(server_fd, client_fd, msg);
+	if (addr1)
+		ASSERT_OK(has_bytes_sent(ADDR1), "Should have bytes_sent on addr1");
+	else
+		ASSERT_GT(has_bytes_sent(ADDR1), 0, "Shouldn't have bytes_sent on addr1");
+	if (addr2)
+		ASSERT_OK(has_bytes_sent(ADDR2), "Should have bytes_sent on addr2");
+	else
+		ASSERT_GT(has_bytes_sent(ADDR2), 0, "Shouldn't have bytes_sent on addr2");
+
+	close(client_fd);
+	close(server_fd);
 }
 
 static void test_default(void)
 {
-	int server_fd, client_fd;
 	struct nstoken *nstoken;
 
 	nstoken = sched_init("subflow", "default");
 	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
 		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd, "default");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+	send_data_and_verify("default", 1, 1);
 
-	close(client_fd);
-	close(server_fd);
 fail:
 	cleanup_netns(nstoken);
 }
@@ -713,8 +723,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(mptcp_sock);
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(mptcp_subflow);
-	if (test__start_subtest("default"))
-		test_default();
+	RUN_MPTCP_TEST(default);
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.40.1


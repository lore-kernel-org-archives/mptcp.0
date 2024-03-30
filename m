Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B631C0DDF
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788657; cv=none; b=jjF+QKwV61JJC/B5q+GU8Q7HixuStQruc/s0UsZtLp3LZeK7fs9P7xf2fBs1mIQyTwvWgqr24B0YfJrRuIQ0uOudXejqJlS0eK1tcD/B568gJJ0kIgU3jl6c2l/LwfgsWPuhLD12Rxa2GMtGlvVmvkznLg39fSL2g93O6YARjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788657; c=relaxed/simple;
	bh=fqKtXBH4sWV6YmGzh8I75sTpSRD+9aWlP8ZBuzfOYGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRVo81VZlBqyjd79XhgypaNIK0B+SZNml9MlE+bNHQhGqTqtRC0BTJfrMiq3D6UHV5vYjrIU8JMqKTCkrx6gwJqUOtvUArvPRm/wFBgVkbshiIiJPuIjHSYmDUBFsWBiAqhmo8dZ//JYfDypEgWcOhbG9Ck2u5dEWcvmmNtm3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/G135qe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/G135qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07404C43394;
	Sat, 30 Mar 2024 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711788656;
	bh=fqKtXBH4sWV6YmGzh8I75sTpSRD+9aWlP8ZBuzfOYGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/G135qeuODNdlFR5O3YZ/908WSViyp+x0GqCyIhLXx8NDbSb+OrtE5B8sajaK5k6
	 9iXxI5r/1B9D0wag9MgmVhCL5GS1iK7TGegDjqOnhUczYxxWL1XNbXZsw3SSRWq7QC
	 U6PewJECnXV/MykXLreRNtgnxEXVxrhWQBBsFozhrBYB4hgNQifr1EkPHD2VAt31mF
	 ds9giUfuftuqE2LcjRbO+wmMJ8hLHj3hTNuJ+GL1AxF0UD8N4AVZqvpmkTxRuuR0M4
	 vBSqKE3zs6/MxSOfrND7B9+RE37i9CwZc8g4NPPti0Z8obnC9v49gyhga3ZO4Ot1/U
	 bEnoni3YCMytA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/8] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Sat, 30 Mar 2024 16:50:44 +0800
Message-Id: <9ce2cc060a35a795debde87af58b77651728de22.1711788593.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711788593.git.tanggeliang@kylinos.cn>
References: <cover.1711788593.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some cleanups, add send_data_and_verify helper, use newly added
RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 69 ++++++++++++-------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8088608f6b28..856e06ad3246 100644
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
@@ -378,16 +377,12 @@ static void *server(void *arg)
 static void send_data(int lfd, int fd, char *msg)
 {
 	ssize_t nr_recv = 0, bytes = 0;
-	struct timespec start, end;
-	unsigned int delta_ms;
 	pthread_t srv_thread;
 	void *thread_ret;
 	char batch[1500];
 	int err;
 
 	WRITE_ONCE(stop, 0);
-	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
-		return;
 
 	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
 	if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
@@ -404,18 +399,10 @@ static void send_data(int lfd, int fd, char *msg)
 		bytes += nr_recv;
 	}
 
-	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
-		return;
-
-	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
-
 	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
 	      bytes, total_bytes, nr_recv, errno);
 
-	printf("%s: %u ms\n", msg, delta_ms);
-
 	WRITE_ONCE(stop, 1);
-
 	pthread_join(srv_thread, &thread_ret);
 	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
 	      PTR_ERR(thread_ret));
@@ -446,32 +433,65 @@ static struct nstoken *sched_init(char *flags, char *sched)
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
+	struct timespec start, end;
 	int server_fd, client_fd;
-	struct nstoken *nstoken;
+	unsigned int delta_ms;
 
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
+	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
+		return;
+
+	send_data(server_fd, client_fd, msg);
+
+	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
+		return;
+
+	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
+	printf("%s: %u ms\n", msg, delta_ms);
+
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
@@ -661,8 +681,7 @@ void test_mptcp(void)
 {
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
-	if (test__start_subtest("default"))
-		test_default();
+	RUN_MPTCP_TEST(default);
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.40.1


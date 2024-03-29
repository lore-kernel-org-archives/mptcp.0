Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4681381B8
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688231; cv=none; b=IR8J9WstSUcLX8e8blXGfG2PB+jrReLPrk15a41O++2Cw95zRWBbfKwoqLuvDSQejsSIz166i+sQ1WkodGqRDtR4SctWNH6JwGQu3NZSCCVcgSr16Skl7rofdDmKaFQqeI5zVnGF8ZrvNPUy5EiLZgeKP+bWz+ZzQw6/+gN42O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688231; c=relaxed/simple;
	bh=9jmHEpLAkCtkJ2nuqcJjBgT7d2vZieO4rteTSngUDBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQy6B/0UtSihJ0SKQIzs4XUjgwLkzoVq9EKRmb2G5pMfdg+ie8jOauZs4dmcVPAtHJihHsPCskXX35U9oHd/J4BF9t6kDDMef9ddGV0QSMdq0hSbxSQqQqcpUf+Pf3CT+4IQwinFrTV2xjVfA02mm0wcsax9u9zU5dqJb6DDGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBFNbqnJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBFNbqnJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956ADC433C7;
	Fri, 29 Mar 2024 04:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688231;
	bh=9jmHEpLAkCtkJ2nuqcJjBgT7d2vZieO4rteTSngUDBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBFNbqnJZg5SvGEYGSEITK97v9mmfVE8fYHd6iE2rjThu8C8VuXaX16NeA6VK/BlS
	 cdv/7LJOKkRu9MJoXYIcXF4lFFGIpCa7VIqZ1zWYrjbRRSZW/aqNvCNbH0swkL0EW0
	 3IUMGVPwK2jPCuoQ4oswlp+5RdZBrnZjKyOUAktmKKngJgcG2UNOpCjnkdSN6JLPEI
	 RSLBKA6+vBgUqnINCAlFjmPXGHAbAYDZO812s7qCsx6uxZyOhY0C9ostwqifygdIdR
	 fjS1d1wnaf6Eaq+zi2WCa1z/DQYzAtL77eNf0efFqgl+dkm5PUQMIStVUNIOy+XFl8
	 VCC+7R4p0tsQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 09/15] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Fri, 29 Mar 2024 12:56:05 +0800
Message-Id: <5e5d95c77f7d6f2c73e661d200ff7b8a54e59a6e.1711688054.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711688054.git.tanggeliang@kylinos.cn>
References: <cover.1711688054.git.tanggeliang@kylinos.cn>
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
index a1a39289b7c9..cfe7a7b6ec48 100644
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
@@ -350,16 +349,12 @@ static void *server(void *arg)
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
@@ -376,18 +371,10 @@ static void send_data(int lfd, int fd, char *msg)
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
@@ -418,32 +405,65 @@ static struct nstoken *sched_init(char *flags, char *sched)
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
@@ -633,8 +653,7 @@ void test_mptcp(void)
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


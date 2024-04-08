Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E317F7
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545280; cv=none; b=Z+fUlp2ZAn6yEAx0lw+6mA//r/SOH/8DxYWqij40ZYZ+Yg19sy1AAYOWUvSThAZKbYShskpvVWZrSVPQRPyOe5hKQSHAo3xI9XEk1z9ieTrda9WjtIa9LNOMPkrUVUJbMdHnJb5+Jss8tqV9P3AWrNHO8rWsQhq6yJfBRiwf3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545280; c=relaxed/simple;
	bh=xekquGCfYqzdmpOy+gdC4kEQJl6x4R1SJ4uRaTMfsyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHI9Y3DI80HRndSE+hUUGWMJagrviMWOPSINP4YzWP+W/Egw64dTGhxYRmhBARxmiGfXrZEVAHUfL497/HA8/UZA9GZGf8AlXkp7eXXUTHkX8JpM+M9A7g4tkHJen8he40Pgm+YsMyPZK17aes5VQ9TL3fKSDoy1rHaLUpQ8J8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o36cKsUL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o36cKsUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C51C433C7;
	Mon,  8 Apr 2024 03:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545280;
	bh=xekquGCfYqzdmpOy+gdC4kEQJl6x4R1SJ4uRaTMfsyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o36cKsULBEdGHKJ6ZbuTMs3dnDXEVJMY5yBswOg2Lhuzi0AWGn2SHF6jTs3/wlhE/
	 CXIfPh5+WyzLWMIpqkJC4HlU3KBrFtmlCjA6mDg16hj5+11k2YeUlF8kzal6QDpfso
	 CAfAJvIlMVJqJKJ0GYKe3vWYmhGPjqos5oAzgosqtQj3KH+AQLHw0qXvNwpnqQC6Q7
	 izpE0WVt3C89NVvcZi39tfTfRey++wEqfQOBRfjtWq7R8axknfJbGMyQzSwl8B17a7
	 16l8HqIOepPptUdflyhAFQbzzY2RTLxD11gKnET5eFqvClMtIFI2Ws2XRp4tiv83is
	 W3RJRQZI8YsSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 3/9] Squash to "selftests/bpf: Add bpf scheduler test" 2 time
Date: Mon,  8 Apr 2024 11:01:05 +0800
Message-Id: <7fc2ba157a9d9a944d93868e64aecf727430c34d.1712544986.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712544986.git.tanggeliang@kylinos.cn>
References: <cover.1712544986.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Move time related code from send_data into send_data_and_verify. Then
send_data can be exported into network_helpers.h as a public function,
reused by mptcp.c and bpf_tcp_ca.c.

Drop duplicate '#include <time.h>', it's included in test_progs.h
already.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 5080e680fbe0..aa95bb41d5ea 100644
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
@@ -380,16 +379,12 @@ static void *server(void *arg)
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
@@ -406,16 +401,9 @@ static void send_data(int lfd, int fd, char *msg)
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
 
 	pthread_join(srv_thread, &thread_ret);
@@ -459,7 +447,9 @@ static int has_bytes_sent(char *addr)
 
 static void send_data_and_verify(char *sched, char *addr1, char *addr2)
 {
+	struct timespec start, end;
 	int server_fd, client_fd;
+	unsigned int delta_ms;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (CHECK(server_fd < 0, sched, "start_mptcp_server: %d\n", errno))
@@ -469,8 +459,17 @@ static void send_data_and_verify(char *sched, char *addr1, char *addr2)
 	if (CHECK(client_fd < 0, sched, "connect_to_fd: %d\n", errno))
 		goto close_server;
 
+	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
+		goto close_server;
+
 	send_data(server_fd, client_fd, sched);
 
+	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
+		goto close_server;
+
+	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
+	printf("%s: %u ms\n", sched, delta_ms);
+
 	if (!strcmp(addr1, "WITH_DATA"))
 		CHECK(has_bytes_sent(ADDR_1), sched, "should have bytes_sent on addr1\n");
 	else if (!strcmp(addr1, "WITHOUT_DATA"))
-- 
2.40.1


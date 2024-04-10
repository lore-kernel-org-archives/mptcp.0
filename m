Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E44C94
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714740; cv=none; b=InhAGwoj8dB6TJnjfRd14jxoCzWaKTfmgmj9hCKMmYOjbVVRQAFR/UdcZu+vHSlpRG6uIDRtbb4+JCZ2NBrUSxADFN2dIaMq7knUU6Z10CuU2eQ77Si6ldTdQYjn0VV4OPrlueSKn0R5nRL++g4vSfY94qQ7J1Xbh2ZSKkg+yqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714740; c=relaxed/simple;
	bh=kIFFB+2J6GKTcwgvvfZCjVkLDnUOCIbpueaLx5Hj8Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYyFUWnff5ykmR3J1B4S0xWLyU6oMbcJlXqqqx1l2OTxNJlkwymjvNiY381Hda6izVkfVAacVsfGQTW7in6DfHjBxVYOV9h0eVA8F2/FZfn4fh+RsyCHpj5O2HckiM6IoO3tyd5QsIrTpDSszbK1szhEr+LlR6DzCK60/sd1v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n53LmHYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n53LmHYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A82FC433C7;
	Wed, 10 Apr 2024 02:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714739;
	bh=kIFFB+2J6GKTcwgvvfZCjVkLDnUOCIbpueaLx5Hj8Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n53LmHYKM18CEB5NqeBp58QycJAFPaD/+1wiu0IYK1IrJHQ/Kgj4SKq0chKOJfHm4
	 PUeiHCSlwJYEuSv8zhrG66O1KI/29/ZR6EOMnCUzSce5VakgrSuOYFCZBrK8irVbsh
	 fwu531AJxKpGaQ8I6AWv9mCLj0BhHgrQ7DC1+p91FaXO5G+dSyyiyS80B+pGtOMbIQ
	 7DNF65NRAKcQR4uNGNTOEQvqvhzRKziaJUGQMoNLL/GVlvTnIpv5tjTIu8G+BZOGBv
	 vjH44kOjI/kh8rp8Tyw3JcX1bWT8xAtxbMmG/PlmuMN4Ub5zSeZaqsM6zubByErgI+
	 Q52xsU2FRauaA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 3/9] Squash to "selftests/bpf: Add bpf scheduler test" 2 time
Date: Wed, 10 Apr 2024 10:05:18 +0800
Message-Id: <836c5ca6464344de45743fe439facad5ecf83d65.1712714407.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712714407.git.tanggeliang@kylinos.cn>
References: <cover.1712714407.git.tanggeliang@kylinos.cn>
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
index 2e1ba03f0398..e8df18c28961 100644
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
@@ -382,16 +381,12 @@ static void *server(void *arg)
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
@@ -408,16 +403,9 @@ static void send_data(int lfd, int fd, char *msg)
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
@@ -461,7 +449,9 @@ static int has_bytes_sent(char *addr)
 
 static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 {
+	struct timespec start, end;
 	int server_fd, client_fd;
+	unsigned int delta_ms;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (CHECK(server_fd < 0, sched, "start_mptcp_server: %d\n", errno))
@@ -471,8 +461,17 @@ static void send_data_and_verify(char *sched, bool addr1, bool addr2)
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
 	if (addr1)
 		CHECK(has_bytes_sent(ADDR_1), sched, "should have bytes_sent on addr1\n");
 	else
-- 
2.40.1


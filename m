Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9C1851
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321554; cv=none; b=uhURh5jJq3eled8k1eQ0QqMVywLGCwAQeYV5A7VyGKLsyubrKWV7s7kJ7st8iaKczqZY4c6/o5hKnoNu+DMPWNvLzKwdOkTO9yftnkuW8G6HeR+Zw7/Kc9SBDziG345YznmnJHpzUUdNceozKozjm/wk5IX977AjLlRlLEWq1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321554; c=relaxed/simple;
	bh=wzEW4W8RNHFrWIbQ857q+NGf7095QKzktcYmuQe++Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQgbGma4fxMptbwDfbRJDLQ9bABYOfDBkDNdi2y2V6L4+5oWfsn2k6xsMLMxRA4Qo0i8sQ4g/5hI5dl18s7lq+JRxnfjXkKxFkXVKzciMQnbgnJhf1yNeZOYgPUTqy/el6aiCEP568LKGE3LIGdQtdwnSuC76ayOFjrm2v24dqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWx7RyYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWx7RyYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA44C113CE;
	Wed, 17 Apr 2024 02:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321554;
	bh=wzEW4W8RNHFrWIbQ857q+NGf7095QKzktcYmuQe++Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWx7RyYHUGICSUlTMdGvv7sQh1fFoaHVNZ+PTUUID+t0tmPnKZ7P8enUg7voNZsCQ
	 hROxQ5MktJsTHWdPpebxkZA6m2xhYprLZK8b1nlA4Mbl7ZFXh2G1qQMbqxoOxU/zHG
	 XHC6yX/gDfy893ayTLkgzfS00qxMshSOg2zNzKf8s4968lY/WlZY/A9NnS57sY+xa1
	 MCVj4KUKN9lWsquwv2WYccBX8+gxPMCxqLuDB4Z3E4CjJrtEOc9ViV+KbWttgSUs+t
	 YkOrOOvRY/URaKxhn01DfA6aRNEKK/SfQ2vO7l5RLQ6p08nqqZ+90b0QSAnd6B/5VZ
	 4uvNZ4IvxDLOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 3/8] Squash to "selftests/bpf: Add bpf scheduler test" 2 time
Date: Wed, 17 Apr 2024 10:38:49 +0800
Message-Id: <d67ba53775755dbaa7441ed6cab263b3250a6d49.1713321357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713321357.git.tanggeliang@kylinos.cn>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
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
index d7ce28fd7809..1979c685ee24 100644
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
 		goto fail;
 
+	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
+		goto fail;
+
 	send_data(server_fd, client_fd, sched);
 
+	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
+		goto fail;
+
+	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
+	printf("%s: %u ms\n", sched, delta_ms);
+
 	if (addr1)
 		CHECK(has_bytes_sent(ADDR_1), sched, "should have bytes_sent on addr1\n");
 	else
-- 
2.40.1


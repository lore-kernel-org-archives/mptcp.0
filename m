Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADD383A4
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042168; cv=none; b=q88wPZs8wpM4w/oWCRsDfG9C660CXwEohyLn2LoHhGJJFYn4UuKCijOdrIAszLx+/KMpTnilySuNrrLi1U2xOZTuJvwxLPmuPAkgzRU7CUe6A2V7XZSTXKjX/yXrvyrI5GSOoosdq8Yri3kXTWGD+SzO1C5DxQ4MNEXX6qVuBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042168; c=relaxed/simple;
	bh=ZAyLvZIU1n3LL8wbE2KNAB6b9UVIxS+pNoxnwe1ZMQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HjGm0Y6zofz3LBY5znl/TstGwrkR8z7wZ6EwaJ7GUPFeDHvktddizQyR+iY1C0J1oe8o8OAVGgajlTDwFS63Dljuxt/vUyKY5RdxHJ/cyhtAsyPTPjR5rLv82WoANCH2sM+p3nSYC++DovLDQB7ylP5R51/yGFxIya95y6a9PrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJcu5sgt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJcu5sgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA86C43390;
	Tue,  2 Apr 2024 07:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042168;
	bh=ZAyLvZIU1n3LL8wbE2KNAB6b9UVIxS+pNoxnwe1ZMQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJcu5sgt6SMaeQeiiv2jeL+80yuUPdpm61y9KJrFtr4obe5Yb4QyH2X3FW1Qjfczr
	 AdbjkwvbZKFpNRMkNI58lZA/bUlVoXzAVPTlVerWlPoqlHlB9ZPni5dpCPU755a18L
	 VRsd7kJ7ewoJ3pD2raqj5qiCgevXZaXuTHRKCNP0bfV973WNNOyUIBjoDx6NyKTVvC
	 2JLCrGMbjWDP1gVyEw21MoCmyoVd7t6nxjLycPJ0sS1gfuQRzNjsNTYFX5kGWmj3OS
	 pCASsqOFQjFcgzTrF5TlVpC6AQuMhLXAYpUcrvNYMv1Zkw0IYu207MNQRnrZvX9ps2
	 /LjDAkNaXD1KQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 04/10] Squash to "selftests/bpf: Add bpf scheduler test" 3 time
Date: Tue,  2 Apr 2024 15:15:52 +0800
Message-Id: <4b6384814f6284623a1aea48f5db4567505f77a0.1712042049.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042049.git.tanggeliang@kylinos.cn>
References: <cover.1712042049.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Move time related code into send_data_and_verify.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 24cd0edc03fc..31808da47ab6 100644
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
@@ -388,16 +387,12 @@ static void *server(void *arg)
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
@@ -414,16 +409,9 @@ static void send_data(int lfd, int fd, char *msg)
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
@@ -467,7 +455,9 @@ static int has_bytes_sent(char *addr)
 
 static void send_data_and_verify(char *msg, int addr1, int addr2)
 {
+	struct timespec start, end;
 	int server_fd, client_fd;
+	unsigned int delta_ms;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (!ASSERT_NEQ(server_fd, -1, "start_mptcp_server"))
@@ -480,8 +470,17 @@ static void send_data_and_verify(char *msg, int addr1, int addr2)
 	if (set_nonblock(server_fd))
 		goto close_server;
 
+	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
+		goto close_server;
+
 	send_data(server_fd, client_fd, msg);
 
+	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
+		goto close_server;
+
+	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
+	printf("%s: %u ms\n", msg, delta_ms);
+
 	if (addr1)
 		ASSERT_OK(has_bytes_sent(ADDR_1), "Should have bytes_sent on addr1");
 	else
-- 
2.40.1


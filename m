Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37472E401
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235841; cv=none; b=qyTy51vKxJRC4B0FUhzaSg7y/p6VIvML7c0HMuJ8lrST158c8Vk9OL/x9n5w/VAqLEGcIcCdyz++8ocK06WOG/b0Ty6hCghxVwC3rHiIU8cQQ/iwJ0y91QxSu/SLgSSRtcjZP2DtKl6qkMspN8AxtgwsB6vMOoFCPPZ3EL1LTZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235841; c=relaxed/simple;
	bh=sezLIDX0bdiFVcHkiT8sFjxLTaVRxc2YALFSv56/4QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lny6qPsQa8U+bXkiZaHFMWTfmmWFtMpLOuASbIwP3C8IOjH4RiUTjuHJIsIzAgo9UWKGTJdwuZmbDlwfTAn7NhPVf2h0m4WLRhekQmi7fScGwg2WC7S5in7N4IC2z4xJu9tp5J0/EaQY0x1pX5sMUZ6iKjzb/lMhbvPdD+qbif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVoIIzrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVoIIzrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922E5C433B2;
	Thu,  4 Apr 2024 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712235841;
	bh=sezLIDX0bdiFVcHkiT8sFjxLTaVRxc2YALFSv56/4QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVoIIzrY5KvOVF7M5C0XgQ0/aEm6EuqBi/yRhSJnclpHoEGNDIE033Ft37Lb4+77l
	 fJ0SuZEGOYRNE6WEDiS+D4M8moF6cT1edjuVM5l1KcRwQjbH7uI+Z0blggSYGBrjfT
	 Bu1iiVgcJaB4XA4EgEDL5L2oCwgTXXTk+fEWTABmKkIrnvotGN05KjqBLv9araSGRL
	 4/cPhsN3t/WAZPzy534p6rSbdiK+q4D5rGCLtKpzIe49DqB2SRlljEO5oiOS52DNHF
	 ITYaqgmeUCwU/zAF53AYIdaf1kpmIAtODtHj6Y2Cs/8/kXwLAKWc5zFGKjaGcz1HS9
	 I9V1g5eDlrnPQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 3/9] Squash to "selftests/bpf: Add bpf scheduler test" 2 time
Date: Thu,  4 Apr 2024 21:03:05 +0800
Message-Id: <b023adbf246022ec4b987c276f5848c438d882b0.1712235379.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712235379.git.tanggeliang@kylinos.cn>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
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
index e1114745da63..ffcd5ebe38b9 100644
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
 
 static void send_data_and_verify(char *msg, int addr1, int addr2)
 {
+	struct timespec start, end;
 	int server_fd, client_fd;
+	unsigned int delta_ms;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (!ASSERT_NEQ(server_fd, -1, "start_mptcp_server"))
@@ -469,8 +459,17 @@ static void send_data_and_verify(char *msg, int addr1, int addr2)
 	if (!ASSERT_NEQ(client_fd, -1, "connect_to_fd"))
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


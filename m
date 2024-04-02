Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4018035
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034770; cv=none; b=Rv2FkYKJ/HY+y2gMlLGDN1XYbC5lS5nNbPZIkYIs/xZ64H0bs3XoKawacaBDQlpfOZn/I9FSMA/nlGguaOEZsy9ZgTvD+ibiSDK3jXiZADSbStnmiaBhJ8dbkuGYtxiosciYvP4QI2kuc/AypBDj0V9qNeuDRxz4zyJ9oNF78B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034770; c=relaxed/simple;
	bh=5R+qeikgnpj7UOrMn0rzG9sYyixCJqSM5C9rgM5Yu0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKl0XCOi6MIRSI26+mHvGZhtR00OCDRceR38i+/xMaLf3D2v6ffru3kdB8zh1edQx2fNBaasMqV7ZSgmm3USowhda8aq0SsZJq22kLNjtLPWVOWceHxRpaaJKyNNDa+sLWqES5my6bX1DixFMhXHJPEa5PmUpoV0CM5BfgxAZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT+dxS2z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT+dxS2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1D4C433F1;
	Tue,  2 Apr 2024 05:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034770;
	bh=5R+qeikgnpj7UOrMn0rzG9sYyixCJqSM5C9rgM5Yu0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oT+dxS2zjQwOE7lY56pt0CJfcEFlmwCxmLbvVyliQE64YUhMsbGTGhZNn9qR/x/HS
	 rgu3WEVQrPYCYK3yCMBujadOv49eTzFy0WQbOqFdExai00yoLqqgzxhKQM7a/GFOnX
	 guKUZR/WLtHT4NrOBw16IKXzmMaO2LsmoWI2UFh3FR/VkgaDP9JiAixkmOAxb+vv6T
	 z1f3ddzntRqAErppcCui6H1S7qAmk2F0SL5cxgEhHKY1tmS+WI/yteZffNQxArtMKS
	 W8Xt8uQPhohpQGyhdSeNrem8z1fr10KUESSk1euZH14VeBQHCuxgTytxIYD0c2j/kS
	 vbFnfgtL6z74g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 04/11] Squash to "selftests/bpf: Add bpf scheduler test" 3 time
Date: Tue,  2 Apr 2024 13:12:27 +0800
Message-Id: <84995e5d5803d1e93f1fb62191ebe99a5a37cb53.1712034575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712034575.git.tanggeliang@kylinos.cn>
References: <cover.1712034575.git.tanggeliang@kylinos.cn>
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
index df105cd23c28..ba1f803a8748 100644
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


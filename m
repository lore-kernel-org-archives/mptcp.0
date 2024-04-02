Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68DD18035
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034771; cv=none; b=P9MT2RnENv09s2NVDds7XGrHfGJHrA9ax7XH9cJVnj2RpSb8TMyZNO6QHFiBIjS5b3y+dYLwGo+7+dWsGP+1egY5tjDZH8YRzaU+yyaMtEexk5bh74Lm5JdJlkXKVcDB/pzwXii/CbpuOGR1kapnA3HvWkQGzdW2cnw2WpsuQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034771; c=relaxed/simple;
	bh=TKnYlpiqIPj+KGa/NdS1bEJfuFmXhuL/E7DH9qfHBUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lbgUnrh5Y+ifiOA+n4GGEFOAaHeMC/jB87r3NSVGUa4UKsQS1ziKWuU3xFI8pDmlFNRyW9e1N1w3PqVbLA1No2xa/9Y/Rhz0+cfG7/IyRtYCPKZ11GP2P1oaJk4bslU3R6iu22emsTP1h9ViKGskdLQ6ZGu1CNb+NqL9nvO3oG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDafgFoD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDafgFoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB52C433F1;
	Tue,  2 Apr 2024 05:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034771;
	bh=TKnYlpiqIPj+KGa/NdS1bEJfuFmXhuL/E7DH9qfHBUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDafgFoDeT4PQXxTuFqpJX5qtIN2P63UarplsapqDhzuBEly9cjSbs+4eUkfO1vO0
	 ImGDCYqGS2qm+hyFLt9WCv03Vaq0q5Np6x4R7uQB66hHWKOaZhyG9vhH5ynrIbEs8u
	 /WeDSCuXEv8oPtKDjyd8QbqtDC5fXI8+CpqIP4165eWLzsD99lUB1njpvTIg/OZ/BC
	 babnQreSClYiSzg7FnoiZGIQXZdBy8Ixuzq3FaSzurJ1RWaaHtx1sTj7qTOdFQ4hq0
	 g8hBFVusM2QtgUOGIi7+uAwB9EowE4FRITV/jI/awSVb9/q68vu4Jrp14GpUxKZEEE
	 7LOXkHgF7D9CQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 05/11] Squash to "selftests/bpf: Add bpf scheduler test" 4 cleanup
Date: Tue,  2 Apr 2024 13:12:28 +0800
Message-Id: <c6f53241bf4fbc5eabe4a04109da04bab9f14532.1712034575.git.tanggeliang@kylinos.cn>
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

Some cleanups, and use newly added RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ba1f803a8748..1268479281fc 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -16,6 +16,9 @@
 #include "mptcp_bpf_burst.skel.h"
 
 #define NS_TEST "mptcp_ns"
+#define ADDR_1	"10.0.1.1"
+#define ADDR_2	"10.0.1.2"
+#define PORT_1	10001
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -38,6 +41,8 @@
 #define TCP_CA_NAME_MAX	16
 #endif
 
+static const unsigned int total_bytes = 10 * 1024 * 1024;
+
 struct __mptcp_info {
 	__u8	mptcpi_subflows;
 	__u8	mptcpi_add_addr_signal;
@@ -337,7 +342,6 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
-static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int stop, duration;
 
 static void *server(void *arg)
@@ -413,16 +417,11 @@ static void send_data(int lfd, int fd, char *msg)
 	      bytes, total_bytes, nr_recv, errno);
 
 	WRITE_ONCE(stop, 1);
-
 	pthread_join(srv_thread, &thread_ret);
 	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
 	      PTR_ERR(thread_ret));
 }
 
-#define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
-#define PORT_1	10001
-
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -444,12 +443,12 @@ static struct nstoken *sched_init(char *flags, char *sched)
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
 
@@ -695,8 +694,7 @@ void test_mptcp(void)
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


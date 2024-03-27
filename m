Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819F364AE
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530128; cv=none; b=LEunZh5NzxE8JOIxg4JJvtN8mzjvSnRlUk6kuT8acjY/W9oSZJJZSg9P4PDUczp7E6q8DEPxyJ//5Y2Ue/fV9cbJDdADkJXG0CAAI0aYbeQdzFwAm8PStkZuB5noN9WP8JGcVCLx6+sPmNUNrWUMJYYVhKaZuUa0eYW/JPfgLzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530128; c=relaxed/simple;
	bh=58VQ4LZ3uadnyq+ERKQ3Tbhadm4sbhkxo8C/mxcvUH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tx+H8HgKLj6OuLhvI1XAK75ksCjJ+AzwWPrnI2wBxToWpp7HkC2QwO0p9ZVKOIZajV8xaRvKkPi0bcToiwpb8gOFer+Ct5OMdFMaI/iNBmD5yeKU2NLpUExO6UYqUnedY5T4JhREpJ2Mqp8EGZJVCQDFfd7DdDcojhrUD2RTQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaWsIV6M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaWsIV6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011D0C433C7;
	Wed, 27 Mar 2024 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530128;
	bh=58VQ4LZ3uadnyq+ERKQ3Tbhadm4sbhkxo8C/mxcvUH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qaWsIV6Mts31dKCJJoMUfKDwT0x4ADSAx8Uw1W/iEJysF6OqzYTEGGXp6D1yW1Efn
	 T7zu4Orp2Ye5XFMKrrNoAg9fufxW2pk2RwSyNsfqpUmu+PXc2Xnhr1ndFD+3YUaE6r
	 AnkZMDQE6/NqIxdm0Bj2DHiJNmrxAVGYzS/gVudaGrNTqsmMEQIz+F9+QkpzZvBMi2
	 ovh4JVyTihrw9hJIvF2nstz6L7PEv95H6RxUR3wibvWAd+DVC+amQKMQuo2Y7RRMxZ
	 a5dfJ++2zCgtQj34CxTDFOxtjAegmYWmRZBqxX5pD2ubI+4MBXMWGIThIOyG3nhGi9
	 uurx3JtKGk9tw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 05/11] Squash to "selftests/bpf: Add bpf scheduler test" - cleanups
Date: Wed, 27 Mar 2024 17:01:43 +0800
Message-Id: <b3d59e60727a99983f6d060d7a540e455e845195.1711529752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711529752.git.tanggeliang@kylinos.cn>
References: <cover.1711529752.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 43 ++++++-------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 0aa250897ff9..64c5f6404784 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -422,7 +422,7 @@ void test_subflow(void)
 }
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
-static int stop, duration;
+static int stop;
 
 static void *server(void *arg)
 {
@@ -455,8 +455,7 @@ static void *server(void *arg)
 		bytes += nr_sent;
 	}
 
-	CHECK(bytes != total_bytes, "send", "%zd != %u nr_sent:%zd errno:%d\n",
-	      bytes, total_bytes, nr_sent, errno);
+	ASSERT_EQ(bytes, total_bytes, "send");
 
 done:
 	if (fd >= 0)
@@ -479,11 +478,12 @@ static void send_data(int lfd, int fd, char *msg)
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
@@ -501,51 +501,37 @@ static void send_data(int lfd, int fd, char *msg)
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
 
-#define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
-#define PORT_1	10001
-
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
 
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
-
-	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it src %s sport %d dst %s | %s",
-		 NS_TEST, ADDR_1, PORT_1, addr, "grep -q bytes_sent:");
-	return system(cmd);
+	return _ss_search(ADDR_1, dst, "sport", "bytes_sent:");
 }
 
 static void test_default(void)
@@ -755,8 +741,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(subflow);
-	if (test__start_subtest("default"))
-		test_default();
+	RUN_MPTCP_TEST(default);
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.40.1


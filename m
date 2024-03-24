Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788E182DD
	for <mptcp@lists.linux.dev>; Sun, 24 Mar 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296133; cv=none; b=IPE2tyWrSNdDGyEQAMpglkz2rSjNGVN1gWCPgcM3bpeDdwOEhBFl1Wq5wph3MNcywNaY7ERKC+sD+DWFetSOPlQimkVmfdI7tKQMJf6uM0pTCWdzYAuveOXeX+daj4oiBBnglPxwfyo2DFHhtTTXN5Ib8/ImIJR54TXpbHkTwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296133; c=relaxed/simple;
	bh=QSKAu6WB0FhEaszRe4DjpARP4sWiXtUCBoRCJ/hQClQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZhqKIl3uWILnUBYY3YTzzUIGTaOdDg4Qrzfq+4JKfp30Z2MeZAx40pFL5DIf5Jiv67GNWF3Yuo0fVNJ75BWcPh7ecL98W63aIBY7eJxlU1dOBpcseSM+v9s52J3Z4i4s3MnmjJ6QARO0HoJdf+NlHv6TTxdwsVUYLSVTusQjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezdb4fJz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezdb4fJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571BCC43390;
	Sun, 24 Mar 2024 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711296133;
	bh=QSKAu6WB0FhEaszRe4DjpARP4sWiXtUCBoRCJ/hQClQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ezdb4fJzHCYOGDw5ve0J0FTOdyaKyFOiyWKiL4TIiSCaBfj5J90STETkq9HEo33jm
	 UroZ+1lTq3IVv4geeRxec7Mj61SufQm5n09JaXLuIL3NXEtMjVCZSTZ5I5gCy0hMO+
	 tvNFYIUIGhrrWA5Zez0seSFgLisZT2PlP1m+4NT7a3IHWjfJ8Vg/+Gve7P6R/+rBL2
	 4DYLWSJcmx0vxfDKZi5vzbJW5Bhv0yLujZqrGCFk95Vty3yViaOv4/7kprRtmuZB5t
	 0ryJ2yqY3GGZGieifVpdMMaMaiCz9VfWYQ7FAn2WHl9xRMdEb1exHa9OtWe8+OJrxD
	 9TI4aSNj08sAQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/4] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Mon, 25 Mar 2024 00:01:17 +0800
Message-Id: <79386fb1f182cf31f950940f7593c97cf9f01272.1711296000.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711296000.git.tanggeliang@kylinos.cn>
References: <cover.1711296000.git.tanggeliang@kylinos.cn>
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

b0e2a0395312 selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca

Use newly added endpoint_init and _ss_search helpers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 ++++++-------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f3cd8baae25..21308b9e776f 100644
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
@@ -501,23 +501,15 @@ static void send_data(int lfd, int fd, char *msg)
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
@@ -526,12 +518,9 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
-	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
-	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
-	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
-	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
-	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+		goto fail;
+
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
 
 	return nstoken;
@@ -539,13 +528,9 @@ static struct nstoken *sched_init(char *flags, char *sched)
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
-- 
2.40.1


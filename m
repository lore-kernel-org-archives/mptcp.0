Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD56FC5
	for <mptcp@lists.linux.dev>; Thu, 21 Mar 2024 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992571; cv=none; b=TxxXwDgJMlPVm05st8Xm/deQ+bpyU8sLCK259Hu5z5Eki+hEYz2IdvD+WXtDflaJBj9G6gyeDKK3VLD+Ai+LFym2W1VWY7HSxgSEzdYb15/8QUDdCv7+JiFky7toZK5Dam1THDxjAUkHHgJtX44fOWJhljZLki/22AzTVK0y9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992571; c=relaxed/simple;
	bh=NauVFc0CbNEfJGF3k/qZ/F70kwGHRbzNtua05IqPcBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kg7S53ub6x6XLiXuqh4ffHQ33/PSAtjCTb8UfNTRZ4l0wnwm6TRjtqfRmwNnBJVmJi2uLCZj/UavRQX+sVMoiwm4uMZRd9k+1/H0pp1JqD4l6vplNonDhyNAs4otRJyV+8m3l4sAx5j+hxwxgRh+8olu2iMjTwbRkEPYNTf4k4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMaIh+1I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMaIh+1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C697C433F1;
	Thu, 21 Mar 2024 03:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710992570;
	bh=NauVFc0CbNEfJGF3k/qZ/F70kwGHRbzNtua05IqPcBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MMaIh+1I58VFIEd5GkZP+J7D6Uci7AjR3XL/WSi247Y3dYqb0JABrP1jqdIxPU+NF
	 dXEUHMTBae2H2AlnblAehebBahX+uFDOw85BuFfn4oMddF5gsKTrQ60YiFgX+weRuO
	 wE686+nWKV8OM/ux/GM2ekvpCEbyijdaBswPT47N2yQoXjMBP2YveIjOG/naseOa5C
	 LQD0sgun771leVfrIfIr8EdHGuEgbl3dc5BhtNhUfsTz0lGse1zXMiFlTdn/zMgvz3
	 zh+UxET5d6Pfj22DBZFm32ekK/w+I6ChFFGYnRrZS/a36lTtSiE2BR3jLzKTdo88YT
	 x5OkmLO06fdHw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/4] Squash to "selftests/bpf: Add bpf scheduler test" cleanup
Date: Thu, 21 Mar 2024 11:42:40 +0800
Message-Id: <4b725f4dfcfa27145458900dfb1ab16e9816d1af.1710992399.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710992399.git.tanggeliang@kylinos.cn>
References: <cover.1710992399.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some cleanups.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c6ce23b73d06..861f70dfe68f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -417,7 +417,7 @@ void test_subflow(void)
 }
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
-static int stop, duration;
+static int stop;
 
 static void *server(void *arg)
 {
@@ -476,11 +476,12 @@ static void send_data(int lfd, int fd, char *msg)
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
@@ -513,10 +514,6 @@ static void send_data(int lfd, int fd, char *msg)
 		printf("FAIL:pthread_join thread_ret:%ld\n", PTR_ERR(thread_ret));
 }
 
-#define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
-#define PORT_1	10001
-
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -525,12 +522,9 @@ static struct nstoken *sched_init(char *flags, char *sched)
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
@@ -538,12 +532,13 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	return NULL;
 }
 
-static int has_bytes_sent(char *addr)
+static int has_bytes_sent(char *dst)
 {
 	char cmd[128];
 
-	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it src %s sport %d dst %s | %s",
-		 NS_TEST, ADDR_1, PORT_1, addr, "grep -q bytes_sent:");
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -it src %s sport %d dst %s | %s",
+		 NS_TEST, ADDR_1, PORT_1, dst, "grep -q bytes_sent:");
 	return system(cmd);
 }
 
-- 
2.40.1


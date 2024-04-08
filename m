Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64542535DC
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572028; cv=none; b=ZmJqBS6zbQ9tpjN+Ou13J9HhCsQxDb/Sstx1F7/WBLtrRz9BSp7/zIHSrWC2phdVOshXs2NQDkPthOpiyS6TY2ruIksejDIkpsMbxLrRkVqzHrC+mjn1fMJM2SyfBzFRIyBqeJSHHT0PXr5Ly7ODZx4Uz2xOV1NhTaY7FkRz4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572028; c=relaxed/simple;
	bh=nkus8dnae1fNstJ4CzyCHAugs4wg39Y9hZ2fTlVjDFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gB6Hd9XA/8gyhxgVEigP22OK5IPH7OSGgEKE5njODfV34QVYuCraYWyVtmdO/TTLS7PHV0ssqBW6oOAbPlP/xJ2k6quz9hZM7cWQcHrAhlsFdd6OBDL+padWGA8kUtjJdOR0zEydcj6K9MM9V02l+A+IC2vViuK3aXkFVU8BzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB47S4AY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB47S4AY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9C3C433F1;
	Mon,  8 Apr 2024 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712572027;
	bh=nkus8dnae1fNstJ4CzyCHAugs4wg39Y9hZ2fTlVjDFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kB47S4AYQ++vpo7Zrrw25WacQIhy08E2XkAQMRgfK7opF4ndbprnyXXo3s9krXCZj
	 81ugzw0eYoz3TyAUwsrIy3K+Fz66WabgNEB6Z2uqQZj6iXZCUabafE3SzpAnQj+Og0
	 y+Qga9aV8FLLWp0dlP7tpYEFHXwZMvaHKdOmG6DI6lSaQjRrykPtPaxWng0r0urGvZ
	 SfrKt+Vo9mFabW39KkGn7XVmZnXv+OrG2OLk4cRx5xoXOy0kDSYF8FoFNHiBQPonNg
	 3lZd8Age1aN7RSR4wJVS0uuqwMptjm73WXP8uoy9mLTgOfNwDKu+To2U2iA/7fqSdQ
	 SVfnS0wZ8yOfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 5/5] Squash to "selftests/bpf: Add bpf scheduler test" 4
Date: Mon,  8 Apr 2024 18:26:52 +0800
Message-Id: <25c8e149eadba2b1cb9bdee282bd12a52da6ad8b.1712571740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712571740.git.tanggeliang@kylinos.cn>
References: <cover.1712571740.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use endpoint_init, _ss_search, set_nonblock and send_recv_data, drop
send_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 104 ++----------------
 1 file changed, 10 insertions(+), 94 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index e7e256a233db..319531ffc500 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -343,87 +343,6 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
-static int stop;
-
-static void *server(void *arg)
-{
-	int lfd = (int)(long)arg, err = 0, fd;
-	ssize_t nr_sent = 0, bytes = 0;
-	char batch[1500];
-
-	fd = accept(lfd, NULL, NULL);
-	while (fd == -1) {
-		if (errno == EINTR)
-			continue;
-		err = -errno;
-		goto done;
-	}
-
-	if (settimeo(fd, 0)) {
-		err = -errno;
-		goto done;
-	}
-
-	while (bytes < total_bytes && !READ_ONCE(stop)) {
-		nr_sent = send(fd, &batch,
-			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_sent == -1 && errno == EINTR)
-			continue;
-		if (nr_sent == -1) {
-			err = -errno;
-			break;
-		}
-		bytes += nr_sent;
-	}
-
-	CHECK(bytes != total_bytes, "send", "%zd != %u nr_sent:%zd errno:%d\n",
-	      bytes, total_bytes, nr_sent, errno);
-
-done:
-	if (fd >= 0)
-		close(fd);
-	if (err) {
-		WRITE_ONCE(stop, 1);
-		return ERR_PTR(err);
-	}
-	return NULL;
-}
-
-static void send_data(int lfd, int fd, char *msg)
-{
-	ssize_t nr_recv = 0, bytes = 0;
-	pthread_t srv_thread;
-	void *thread_ret;
-	char batch[1500];
-	int err;
-
-	WRITE_ONCE(stop, 0);
-
-	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
-	if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
-		return;
-
-	/* recv total_bytes */
-	while (bytes < total_bytes && !READ_ONCE(stop)) {
-		nr_recv = recv(fd, &batch,
-			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_recv == -1 && errno == EINTR)
-			continue;
-		if (nr_recv == -1)
-			break;
-		bytes += nr_recv;
-	}
-
-	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
-	      bytes, total_bytes, nr_recv, errno);
-
-	WRITE_ONCE(stop, 1);
-
-	pthread_join(srv_thread, &thread_ret);
-	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
-	      PTR_ERR(thread_ret));
-}
-
 static int endpoint_init(char *flags)
 {
 	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
@@ -532,28 +451,22 @@ static struct nstoken *sched_init(char *flags, char *sched)
 
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
 
 static void send_data_and_verify(char *sched, char *addr1, char *addr2)
@@ -570,10 +483,13 @@ static void send_data_and_verify(char *sched, char *addr1, char *addr2)
 	if (CHECK(client_fd < 0, sched, "connect_to_fd: %d\n", errno))
 		goto close_server;
 
+	if (set_nonblock(server_fd))
+		goto close_server;
+
 	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
 		goto close_server;
 
-	send_data(server_fd, client_fd, sched);
+	send_recv_data(server_fd, client_fd, total_bytes);
 
 	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
 		goto close_server;
-- 
2.40.1


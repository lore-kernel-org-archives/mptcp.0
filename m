Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E67F7EB
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654807; cv=none; b=Nfw8Ax4Iggddx0QdkHO7huiY60F/6lZMgG9Mnwr8LgI8HEsTZeYQx0BgTD0HS94wFk17klBTu46zE4Hcy0jCtV7FubskdYRR+hYRLhoFO/0931lBkj0wSBCQ9R9VHRDRAbWlk/N8CZbspLzgDVqf5bYJk4lAbAp1FrK4eNNYm1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654807; c=relaxed/simple;
	bh=Os6ANadVm4pM+RTDmV3IUdinAcetK2+xoQzdESzMy0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RS33cpgYstiNMOa2rXzWOVWaMoyh4m3Gcq/t+q3NrPGJPf5rVS90gZ30C6yPDAvEcAsQ0Jw10hYcvZfHoJG3cDy50aFZwrFhj1mSbsYpGuOaon73RyEnK62+4esyDUmsXju4dqh+rIGyx6XTptLIFl9V3xr2SfMxZ4Ux8K02YMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtzHHEG7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtzHHEG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EB2C113CC;
	Thu,  2 May 2024 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714654807;
	bh=Os6ANadVm4pM+RTDmV3IUdinAcetK2+xoQzdESzMy0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=rtzHHEG7bC9AXgR8vQRUCyB8RjHYJFb5p22/vWDfwXPs/iy3O7Qk0qxCUXQEmAryh
	 aeMgCHw5efkC4tfWi19zCzOJKCjxK9JUezqDXSzh97O6uWflpe8UXN07WA6q955p1k
	 O9v0ZJ4IUsj6A22HQZFTVl3X2gt0hqB/1XETxoZOv/QVeLjReQOGXYnRO+3Q+mAq23
	 uH153kmHdhCWRvFUC5Ljwok932wL4eqpB0wa/B96dVOVqYnnETzsUnlfc1nmzwZDuI
	 UizsrbGCYxwFb847NfAZxpPq3eTWg5jsv1Rh8NrPaaOS9ZMMC4zAqMs4nZiu6mhJEE
	 ZWVSzvhUN9fVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf scheduler test" - drop send_data
Date: Thu,  2 May 2024 20:59:23 +0800
Message-ID: <b0ae79b3c2e446dd0f5ac09470db661d51575227.1714654747.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop send_data, using send_recv_data instead.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 85 +------------------
 1 file changed, 4 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 88bc96bfd594..6a07160b5ac9 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -46,7 +46,7 @@
 #define MPTCP_SCHED_NAME_MAX	16
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
-static int stop, duration;
+static int duration;
 
 struct __mptcp_info {
 	__u8	mptcpi_subflows;
@@ -465,85 +465,6 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
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
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -585,7 +506,9 @@ static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
 		goto fail;
 
-	send_data(server_fd, client_fd, sched);
+	if (!ASSERT_OK(send_recv_data(server_fd, client_fd, total_bytes),
+		       "send_recv_data"))
+		goto fail;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
 		goto fail;
-- 
2.43.0


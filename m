Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C463A1C5
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042676; cv=none; b=gB5Dwbyyba1x+J2mUPpMafo7HCHqaACekH/rxpjUwfno1LqA8Inj1ZG/hFj+t8WeUHmrDj5ETVeqyaZAEhVdjqeOWaW3UQwYwV60gJxULj/hycedlbNb1lqEDzOoUXcApBUuiCuXz04w7B6hmdJkPdmg80KfyhLg9NaKpZ4MxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042676; c=relaxed/simple;
	bh=imqx3zbk+fCgvlrMXkofoQ235vHpxLpmoivxLAoXqX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yglqdtf6zIHexO37RXvUgbmEbXSkvcYN8fpyzawYaIoDHA4KdNdmOl4Z3KArjh39b87E0PLV94gpv/lkRC3apUti6PCWA6VW38YWCPJkjc+7tCtbeY9L0WFmvgtX75jXDykGit8cgw0hUPh5jEpE/C09dBVWfvW1lbB//NxOrXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYKfys3D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYKfys3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1932AC433F1;
	Tue,  2 Apr 2024 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042675;
	bh=imqx3zbk+fCgvlrMXkofoQ235vHpxLpmoivxLAoXqX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYKfys3DjzpPGmNUQaNBbnXswdgkHPgxHecNPZJ5Vm+RrMeo97B7LwXSxhczgg1Gv
	 wtduhz9/qrjhdGEMZjqH/B0h8RxEVhcURPHUzIqAfGDqGbjL+CfH5EI1lTDJTg5MeI
	 bNQLUgutmYJbdLEZER9iDkOtWSI1VPw+Mzw8jeFwQBUYP0dijmwjh7Xct4QRQomehn
	 F6oHFN7WqJkHRTHYQsM6VjB37l4nIQyAVBTHDstEmkAlczDnQs9QiuMiM1PJYu66+Q
	 fZHdVvj1N47WlIchd0ftWv6GYD/Pi7M6MYaqCxKLDReIwnfBsuhVW2zzWqBMHK6XsI
	 cowOFkT8NtIOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 1/8] Squash to "selftests/bpf: Add bpf scheduler test" 4 send_data
Date: Tue,  2 Apr 2024 15:24:21 +0800
Message-Id: <d1ec95d9c2fbebe706b60b8f3b476b5ea87b914d.1712042529.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042529.git.tanggeliang@kylinos.cn>
References: <cover.1712042529.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop send_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 83 +------------------
 1 file changed, 1 insertion(+), 82 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 81cde7a0a26d..88899ff02a70 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -331,87 +331,6 @@ static void test_mptcpify(void)
 }
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
-static int stop, duration;
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
 #define ADDR_1	"10.0.1.1"
 #define ADDR_2	"10.0.1.2"
 #define PORT_1	10001
@@ -466,7 +385,7 @@ static void send_data_and_verify(char *msg, int addr1, int addr2)
 	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
 		goto close_server;
 
-	send_data(server_fd, client_fd, msg);
+	send_recv_data(server_fd, client_fd, total_bytes);
 
 	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
 		goto close_server;
-- 
2.40.1


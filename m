Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6937149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688241; cv=none; b=XNwd3t2n3o69O/+fLEYfTLtPLpZ1M1qFLW8Wtze92GB1bjqlffLhspenih1M1RuHnrg3YYhiUskGAC6OCQ5AkG0GYoMvcUGX956/L9C2jo7tHLkC86EPumvSR8PBSwBVEnYFieLU655idmW7m2ga5UZAVc9PJ0cJ7vPKr/kj328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688241; c=relaxed/simple;
	bh=ZBlHt37oHd1X4/TpLnmrg+DcuQpPzvrifWxBhKxXHZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fV2OsEvPmV+ryoNiMJmHOgqpzfXnyruRRmP0EkCyNMURuGDO6hczxAgEnxfrl2uJlEBQwuITs+6te0W++aKVdp6ZQF0hs6HG0uDcUUMIeAQjmeVIXiaGAg/70THod4EaIy6E4mqV6OQOpyXo4Xb5s6UFYOQu1cgD01pQFHT3upM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucc0PO60; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucc0PO60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E830CC433F1;
	Fri, 29 Mar 2024 04:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688240;
	bh=ZBlHt37oHd1X4/TpLnmrg+DcuQpPzvrifWxBhKxXHZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucc0PO60SWw0Cts/UkohBKPDdbHq2JISYeflDQq5ByJ8bcWHI5ItlGwWHEf83hH7m
	 Lj+zvUOTHtKMl5GwxCepL6Bse0HUNO3BdLhY3LkHs9EF5cV9Y5Ik4Kr0E1IWzEqYk1
	 YtXXGl4b1jY2vcv5wHJnIzs0qkE7197bjxkpl3YIFcxLEDxLAiKxsH0yYRg6effhpg
	 kUbCf7GVOiyGPcX3khPW449faBjzBM1VGNdY+aFrJlPsy9aPrKHkAOFvn+y2aYOev0
	 yyYw3Uf0RHjXlF7ebKpTQ3yAxglQIv5nfDY9lF6MDSpi4KLSUsEN41hFo/PUgChf0D
	 wyZhwKyAftagg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 15/15] Squash to "selftests/bpf: Add bpf scheduler test" 2
Date: Fri, 29 Mar 2024 12:56:11 +0800
Message-Id: <444a1f6d61fc86bde74fe93cf3f19605994b4632.1711688054.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711688054.git.tanggeliang@kylinos.cn>
References: <cover.1711688054.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

send_data isn't invoked anywhere, can be dropped now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 83 +------------------
 1 file changed, 1 insertion(+), 82 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6b77fb51c4f5..34fe79f34eb9 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -299,87 +299,6 @@ static void run_mptcpify(int cgroup_fd, struct mptcpify *skel)
 
 MPTCP_BASE_TEST(mptcpify);
 
-static const unsigned int total_bytes = 10 * 1024 * 1024;
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
-		if (nr_sent == -1 && (errno == EINTR || errno == EAGAIN))
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
-		if (nr_recv == -1 && (errno == EINTR || errno == EAGAIN))
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
-	pthread_join(srv_thread, &thread_ret);
-	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
-	      PTR_ERR(thread_ret));
-}
-
 #define ADDR_1	"10.0.1.1"
 #define ADDR_2	"10.0.1.2"
 #define PORT_1	10001
@@ -433,7 +352,7 @@ static void send_data_and_verify(char *msg, int addr1, int addr2)
 	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
 		return;
 
-	send_data(server_fd, client_fd, msg);
+	send_recv_data(server_fd, client_fd);
 
 	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
 		return;
-- 
2.40.1


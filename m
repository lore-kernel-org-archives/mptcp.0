Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111F35836F
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738833; cv=none; b=TGPRsnZr3oxVaJAEt9lLdO/ZlXOHMOsj78F2LJrVlyA0vXT95nkUt4yTieHK+TcFQ/lXO9Xz6ANlz/WHy831m+zWzFPOl72hpe5CQHwSkiUsvV0J2La0nw0uDyRqSrF5DkIKLp52aYAPsugJxJvYBblDnZ11EBS7mHLq+IP+CqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738833; c=relaxed/simple;
	bh=wz2TPddIX2ais3ZwMSM2O0EVMElNivilhxtgca2EIvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2k88xNdmRCKjRGl9qLRy/+bXA0MgXQs6tL6ShqQhHwmpUTnsl4n7nvWVnrhxb6zBYCIidQkKiBzqUYeRlQT09dkUPtCvz3V8k+69y4ooiwhLmm2KEHnbgdXciKW3xumtyXkugm67dNJL0OJmlB9nK/cLKVbPpZ9wQ3RmO9LnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD4pxD4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD4pxD4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4B9C4CEF7;
	Tue, 17 Mar 2026 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738833;
	bh=wz2TPddIX2ais3ZwMSM2O0EVMElNivilhxtgca2EIvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lD4pxD4uAnoUNs0v4OmnhQqK8EpxI2Wf9CRrYb+pBJffP255FdDZnbNqd2OS9nGa2
	 BXu9X9laqgyCjWUkChhp34/B13HCteh2e8qnqov0/agJX5h+E/fQs+fElC9smFEeMt
	 u9LDjCIP1fqfCHZQwAvcpac+2KZyIua4Dfpt3XxK7sglJLzl3O3mp5y0L0WYfSH86f
	 2IvoBhPn+wZahyE4jirB7ZnPEpPVmhjBzaX83r8ok60JCAetPv6StE0HTkV7S/OnNM
	 vGmMrHzzTtkZiOh/ELSej7JTgTW5/HFryTf2LwUHv/0bxrasvFMdnC0/zsqYgN68jU
	 PZurt0+s7f7iQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 12/14] selftests: tls: adjust timeouts and data for MPTCP
Date: Tue, 17 Mar 2026 17:12:48 +0800
Message-ID: <d3c9f3c76ae733acf8d9e0ea770d541fad82d73e.1773737371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP requires longer timeouts in poll/epoll tests due to subflow
establishment delays and slower state transitions. Increase timeout
values to prevent false failures.

Double the data size in nonblocking test to accommodate MPTCP's
multi-subflow behavior and ensure sufficient data for testing.

In shutdown_reuse tests, add a delay after shutdown to ensure sockets
transition to TCPF_CLOSE before bind() reuse.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 539a2bbea103..24ed6deb40fd 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1293,6 +1293,7 @@ TEST_F(tls, bidir)
 
 TEST_F(tls, pollin)
 {
+	int timeout = variant->mptcp ? 100 : 20;
 	char const *test_str = "test_poll";
 	struct pollfd fd = { 0, 0, 0 };
 	char buf[10];
@@ -1302,11 +1303,11 @@ TEST_F(tls, pollin)
 	fd.fd = self->cfd;
 	fd.events = POLLIN;
 
-	EXPECT_EQ(poll(&fd, 1, 20), 1);
+	EXPECT_EQ(poll(&fd, 1, timeout), 1);
 	EXPECT_EQ(fd.revents & POLLIN, 1);
 	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_WAITALL), send_len);
 	/* Test timing out */
-	EXPECT_EQ(poll(&fd, 1, 20), 0);
+	EXPECT_EQ(poll(&fd, 1, timeout), 0);
 }
 
 TEST_F(tls, poll_wait)
@@ -1398,6 +1399,9 @@ TEST_F(tls, nonblocking)
 	int flags;
 	int res;
 
+	if (variant->mptcp)
+		data *= 2;
+
 	flags = fcntl(self->fd, F_GETFL, 0);
 	fcntl(self->fd, F_SETFL, flags | O_NONBLOCK);
 	fcntl(self->cfd, F_SETFL, flags | O_NONBLOCK);
@@ -1677,6 +1681,9 @@ TEST_F(tls, shutdown_reuse)
 	shutdown(self->cfd, SHUT_RDWR);
 	close(self->cfd);
 
+	if (variant->mptcp)
+		usleep(500000);
+
 	addr.sin_family = AF_INET;
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
@@ -2725,6 +2732,7 @@ TEST_F(tls_err, timeo)
 
 TEST_F(tls_err, poll_partial_rec)
 {
+	int timeout = variant->mptcp ? 100 : 1;
 	struct pollfd pfd = { };
 	ssize_t rec_len;
 	char rec[256];
@@ -2735,7 +2743,7 @@ TEST_F(tls_err, poll_partial_rec)
 
 	pfd.fd = self->cfd2;
 	pfd.events = POLLIN;
-	EXPECT_EQ(poll(&pfd, 1, 1), 0);
+	EXPECT_EQ(poll(&pfd, 1, timeout), 0);
 
 	memrnd(buf, sizeof(buf));
 	EXPECT_EQ(send(self->fd, buf, sizeof(buf), 0), sizeof(buf));
@@ -2747,18 +2755,19 @@ TEST_F(tls_err, poll_partial_rec)
 	/* ... no full record should mean no POLLIN */
 	pfd.fd = self->cfd2;
 	pfd.events = POLLIN;
-	EXPECT_EQ(poll(&pfd, 1, 1), 0);
+	EXPECT_EQ(poll(&pfd, 1, timeout), 0);
 	/* Now write the rest, and it should all pop out of the other end. */
 	EXPECT_EQ(send(self->fd2, rec + 100, rec_len - 100, 0), rec_len - 100);
 	pfd.fd = self->cfd2;
 	pfd.events = POLLIN;
-	EXPECT_EQ(poll(&pfd, 1, 1), 1);
+	EXPECT_EQ(poll(&pfd, 1, timeout), 1);
 	EXPECT_EQ(recv(self->cfd2, rec, sizeof(rec), 0), sizeof(buf));
 	EXPECT_EQ(memcmp(buf, rec, sizeof(buf)), 0);
 }
 
 TEST_F(tls_err, epoll_partial_rec)
 {
+	int timeout = variant->mptcp ? 100 : 0;
 	struct epoll_event ev, events[10];
 	ssize_t rec_len;
 	char rec[256];
@@ -2776,7 +2785,7 @@ TEST_F(tls_err, epoll_partial_rec)
 	ev.data.fd = self->cfd2;
 	ASSERT_GE(epoll_ctl(epollfd, EPOLL_CTL_ADD, self->cfd2, &ev), 0);
 
-	EXPECT_EQ(epoll_wait(epollfd, events, 10, 0), 0);
+	EXPECT_EQ(epoll_wait(epollfd, events, 10, timeout), 0);
 
 	memrnd(buf, sizeof(buf));
 	EXPECT_EQ(send(self->fd, buf, sizeof(buf), 0), sizeof(buf));
@@ -2786,10 +2795,10 @@ TEST_F(tls_err, epoll_partial_rec)
 	/* Write 100B, not the full record ... */
 	EXPECT_EQ(send(self->fd2, rec, 100, 0), 100);
 	/* ... no full record should mean no POLLIN */
-	EXPECT_EQ(epoll_wait(epollfd, events, 10, 0), 0);
+	EXPECT_EQ(epoll_wait(epollfd, events, 10, timeout), 0);
 	/* Now write the rest, and it should all pop out of the other end. */
 	EXPECT_EQ(send(self->fd2, rec + 100, rec_len - 100, 0), rec_len - 100);
-	EXPECT_EQ(epoll_wait(epollfd, events, 10, 0), 1);
+	EXPECT_EQ(epoll_wait(epollfd, events, 10, timeout), 1);
 	EXPECT_EQ(recv(self->cfd2, rec, sizeof(rec), 0), sizeof(buf));
 	EXPECT_EQ(memcmp(buf, rec, sizeof(buf)), 0);
 
@@ -2798,6 +2807,7 @@ TEST_F(tls_err, epoll_partial_rec)
 
 TEST_F(tls_err, poll_partial_rec_async)
 {
+	int timeout = variant->mptcp ? 100 : 20;
 	struct pollfd pfd = { };
 	char token = '\0';
 	ssize_t rec_len;
@@ -2841,13 +2851,13 @@ TEST_F(tls_err, poll_partial_rec_async)
 		/* Child should sleep in poll(), never get a wake */
 		pfd.fd = self->cfd2;
 		pfd.events = POLLIN;
-		EXPECT_EQ(poll(&pfd, 1, 20), 0);
+		EXPECT_EQ(poll(&pfd, 1, timeout), 0);
 
 		EXPECT_EQ(write(p[1], &token, 1), 1); /* Barrier #1 */
 
 		pfd.fd = self->cfd2;
 		pfd.events = POLLIN;
-		EXPECT_EQ(poll(&pfd, 1, 20), 1);
+		EXPECT_EQ(poll(&pfd, 1, timeout), 1);
 
 		exit(!__test_passed(_metadata));
 	}
-- 
2.53.0


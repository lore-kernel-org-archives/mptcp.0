Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2937149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688223; cv=none; b=O6vacgBm/DvVxGnwdz1apr7vELLU0c0mowt6XMWGC+qMQvHZZiMx0QZdy2nDboruYVGnacAh5OwHltKKfuftYc3VBCGxN0Dc6Liqy7dht0WewgLu4+G3Y9H8W5jSZknhztv5LON0qGEBCUa9sMA+SGq2Wz3CCojaDhhQd4udYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688223; c=relaxed/simple;
	bh=/U50KzZmUbjGW49E8adc6RqDTvnDgvDHPaDuLAYIefI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8iQ88IdUfyY+Zi2HcQL2z1PS64ZgG/2aP3nqX1ENHu7eYsg9Wq++Ml356/a89BEuxJ3UtxFOI+oiMUjkloNi9HQZwS1nPI379uH1Q/7/RTq74JsZqGWn4kiztySVBDfHDn06CD90BjcexxpEMqw1SwMkOMNhGyaql6X74SdDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3DCh6DT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3DCh6DT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B539C43390;
	Fri, 29 Mar 2024 04:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688223;
	bh=/U50KzZmUbjGW49E8adc6RqDTvnDgvDHPaDuLAYIefI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3DCh6DT40CTOg4LHndfTZ95AOmWjp3CNB/cioWByrBIPCGLItKoHm2g53M4Te13F
	 NUomr6N2xVu3J/ozfxVgbaZUHAzgt3tV+3otsxZyauUIckhYDFCZ4Cqpn8jtbH/6Np
	 XabEeS+/cx8nFUSLnKAH2+AsTZXxde3WQPalDB8E1fZjcnVIEvjta8j289ENT1M1rZ
	 42IRIV9iEoNjXDk7qmtMUvYnOMw7G/prj5mjtfAnJx+b54hqEHcnMNBntHxdBvvF9n
	 aiqDoAg01W9Av4fUDZw3LgwbaNzYZHbUjyOGYbT7BLdEpvSt6izJBVE7t+L4vHdl9q
	 DirieE32rmUrg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 04/15] selftests/bpf: Export send_recv_data helper
Date: Fri, 29 Mar 2024 12:56:00 +0800
Message-Id: <00c86df51704c59885b9795cf0cfe5a72b18fdc7.1711688054.git.tanggeliang@kylinos.cn>
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

This patch extracts the code to send and receive data into a new
helper named send_recv_data() in network_helpers.c and export it
in network_helpers.h. Then it can be used for all BPF selftests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 78 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 72 +----------------
 3 files changed, 80 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 8dea4160bfee..9e8e2d34f76f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -504,3 +504,81 @@ void send_single_byte(int fd)
 
 	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
 }
+
+static const unsigned int total_bytes = 10 * 1024 * 1024;
+static int stop;
+
+static void *server(void *arg)
+{
+	int lfd = (int)(long)arg, err = 0, fd;
+	ssize_t nr_sent = 0, bytes = 0;
+	char batch[1500];
+
+	fd = accept(lfd, NULL, NULL);
+	while (fd == -1) {
+		if (errno == EINTR)
+			continue;
+		err = -errno;
+		goto done;
+	}
+
+	if (settimeo(fd, 0)) {
+		err = -errno;
+		goto done;
+	}
+
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_sent = send(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_sent == -1 && (errno == EINTR || errno == EAGAIN))
+			continue;
+		if (nr_sent == -1) {
+			err = -errno;
+			break;
+		}
+		bytes += nr_sent;
+	}
+
+	ASSERT_EQ(bytes, total_bytes, "send");
+
+done:
+	if (fd >= 0)
+		close(fd);
+	if (err) {
+		WRITE_ONCE(stop, 1);
+		return ERR_PTR(err);
+	}
+	return NULL;
+}
+
+void send_recv_data(int lfd, int fd)
+{
+	ssize_t nr_recv = 0, bytes = 0;
+	pthread_t srv_thread;
+	void *thread_ret;
+	char batch[1500];
+	int err;
+
+	WRITE_ONCE(stop, 0);
+
+	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
+	if (!ASSERT_OK(err, "pthread_create"))
+		return;
+
+	/* recv total_bytes */
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_recv = recv(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_recv == -1 && (errno == EINTR || errno == EAGAIN))
+			continue;
+		if (nr_recv == -1)
+			break;
+		bytes += nr_recv;
+	}
+
+	ASSERT_EQ(bytes, total_bytes, "recv");
+
+	WRITE_ONCE(stop, 1);
+	pthread_join(srv_thread, &thread_ret);
+	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index b3c2238772c8..ad8dfca5296f 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -72,6 +72,7 @@ struct nstoken;
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
 void send_single_byte(int fd);
+void send_recv_data(int lfd, int fd);
 
 static __u16 csum_fold(__u32 csum)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 885c8b4e21a4..55f4f54f9b5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -18,9 +18,7 @@
 #define ENOTSUPP 524
 #endif
 
-static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int expected_stg = 0xeB9F;
-static int stop;
 
 static int settcpca(int fd, const char *tcp_ca)
 {
@@ -33,60 +31,11 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
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
-		if (nr_sent == -1 && (errno == EINTR || errno == EAGAIN))
-			continue;
-		if (nr_sent == -1) {
-			err = -errno;
-			break;
-		}
-		bytes += nr_sent;
-	}
-
-	ASSERT_EQ(bytes, total_bytes, "send");
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
 static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 {
-	ssize_t nr_recv = 0, bytes = 0;
 	int lfd = -1, fd = -1;
-	pthread_t srv_thread;
-	void *thread_ret;
-	char batch[1500];
 	int err;
 
-	WRITE_ONCE(stop, 0);
-
 	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
@@ -122,26 +71,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 			goto done;
 	}
 
-	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
-	if (!ASSERT_OK(err, "pthread_create"))
-		goto done;
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
-	ASSERT_EQ(bytes, total_bytes, "recv");
-
-	WRITE_ONCE(stop, 1);
-	pthread_join(srv_thread, &thread_ret);
-	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
+	send_recv_data(lfd, fd);
 
 done:
 	close(lfd);
-- 
2.40.1


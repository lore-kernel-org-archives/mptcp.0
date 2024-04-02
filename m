Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266A21A0A;
	Tue,  2 Apr 2024 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039933; cv=none; b=cEy7GYuoXSxlio3L/etB2VDh6n+L5VLVMwrsgA0ijspCoJvadCqUoN6qae7jQzlJGwSRSzPCTs7Dc98sjqT3jg9/SZ8pjsdIPPfPU4zTGQX7EKBSjE/yrmY003oauqdFXhs490kVt+QRpwiK4jqQBmlY/5FFkJKHcAUFoQaoPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039933; c=relaxed/simple;
	bh=gDO0ySm+aPvuaH3juYLP75gA9qg7zi1y8ibqElMC7zM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eq+fWM36RKu9RpQMApmVXIGZbPVSNIizNlcRyvxRDDI/STp42+20vhQAZ6WxQJGTspOhXkAOrlnWUuQtNRGl+WoDKjeQfYCVVwl9bRfTY0W+CliJQB+MIl0yiWHHYcEdJHw/zashAlYdgfboPhI8gonZP1ek/Hb/1LIU9d1WKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbE/Ax32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbE/Ax32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2E3C43394;
	Tue,  2 Apr 2024 06:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712039933;
	bh=gDO0ySm+aPvuaH3juYLP75gA9qg7zi1y8ibqElMC7zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbE/Ax32f/SPzYnbw1pjssU+7OgWmq4GZG1M27XzoMruSRsFelSvINKz1ypagPuYy
	 7DYYucbBAekYH1UsS8nUakg75MIYiSBSiLqQEtZQBRR5CMIbuSv7XIn/G/PqXMtDZ1
	 rGWLM63zEydrYxdHGXjgf97ggHu8Pbj7G9BAnHDSS2ejp5ydUyUClGS1YHxMidje9W
	 zw6vN+wvvx4pr0z5mhXIUgNFWoWE5/LCqa+mAkJqfYWpO8K8vE34IwIVLxrMh5gpqq
	 ge36xmeMzvlxhPMUuU0UKxP21YuwoXYML7ubQkn3JKFYusyi7c4E8exdBd/MhM/CEh
	 vsRxJH6Qux3HA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add struct send_recv_arg
Date: Tue,  2 Apr 2024 14:38:28 +0800
Message-Id: <80fef8c1de78c12c150193e9c435ac71a8c0ad89.1712039441.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712039441.git.tanggeliang@kylinos.cn>
References: <cover.1712039441.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Avoid setting total_bytes and stop as global variables, this patch adds
a new struct named send_recv_arg to pass arguments between threads. Put
these two variables together with fd into this struct and pass it to
server thread, so that server thread can access these two variables without
setting them as global ones.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 077b107130f6..a1f0a2b06489 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -21,7 +21,6 @@
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int expected_stg = 0xeB9F;
-static int stop;
 
 static int settcpca(int fd, const char *tcp_ca)
 {
@@ -34,13 +33,20 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
+struct send_recv_arg {
+	int		fd;
+	uint32_t	bytes;
+	int		stop;
+};
+
 static void *server(void *arg)
 {
-	int lfd = (int)(long)arg, err = 0, fd;
+	struct send_recv_arg *a = (struct send_recv_arg *)arg;
 	ssize_t nr_sent = 0, bytes = 0;
 	char batch[1500];
+	int err = 0, fd;
 
-	fd = accept(lfd, NULL, NULL);
+	fd = accept(a->fd, NULL, NULL);
 	while (fd == -1) {
 		if (errno == EINTR)
 			continue;
@@ -53,9 +59,9 @@ static void *server(void *arg)
 		goto done;
 	}
 
-	while (bytes < total_bytes && !READ_ONCE(stop)) {
+	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
 		nr_sent = send(fd, &batch,
-			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+			       MIN(a->bytes - bytes, sizeof(batch)), 0);
 		if (nr_sent == -1 && errno == EINTR)
 			continue;
 		if (nr_sent == -1) {
@@ -65,13 +71,13 @@ static void *server(void *arg)
 		bytes += nr_sent;
 	}
 
-	ASSERT_EQ(bytes, total_bytes, "send");
+	ASSERT_EQ(bytes, a->bytes, "send");
 
 done:
 	if (fd >= 0)
 		close(fd);
 	if (err) {
-		WRITE_ONCE(stop, 1);
+		WRITE_ONCE(a->stop, 1);
 		return ERR_PTR(err);
 	}
 	return NULL;
@@ -80,18 +86,23 @@ static void *server(void *arg)
 static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 {
 	ssize_t nr_recv = 0, bytes = 0;
+	struct send_recv_arg arg = {
+		.bytes	= total_bytes,
+	};
 	int lfd = -1, fd = -1;
 	pthread_t srv_thread;
 	void *thread_ret;
 	char batch[1500];
 	int err;
 
-	WRITE_ONCE(stop, 0);
+	WRITE_ONCE(arg.stop, 0);
 
 	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
+	arg.fd = lfd;
+
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (!ASSERT_NEQ(fd, -1, "socket")) {
 		close(lfd);
@@ -123,12 +134,12 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 			goto done;
 	}
 
-	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
+	err = pthread_create(&srv_thread, NULL, server, (void *)&arg);
 	if (!ASSERT_OK(err, "pthread_create"))
 		goto done;
 
 	/* recv total_bytes */
-	while (bytes < total_bytes && !READ_ONCE(stop)) {
+	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
 		nr_recv = recv(fd, &batch,
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_recv == -1 && errno == EINTR)
@@ -140,7 +151,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 
 	ASSERT_EQ(bytes, total_bytes, "recv");
 
-	WRITE_ONCE(stop, 1);
+	WRITE_ONCE(arg.stop, 1);
 	pthread_join(srv_thread, &thread_ret);
 	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
 
-- 
2.40.1


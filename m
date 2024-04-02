Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1824A04;
	Tue,  2 Apr 2024 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039938; cv=none; b=n68qTvVwibVTyQVnN4NKzGAfqwaowyf4zuNm7H1I3a+z12MhD0kBbMc9DaVMsAo8EDtU9I4rPL9z35LSXcTA1zGhXOgGKZEVBHHLJSF++eze7gIyi1ExV0dhmdWhNzIxaYh/2YUqxzEffXRkn5+nccn4BnBejAVTpFBuagr603I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039938; c=relaxed/simple;
	bh=dQ6UzsnbxvYjXDXrHLCAD2HM5t7PTpJkoPIVrOnan6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYLK7JwVDP5ZcFHKjS9IxAXsJMHceFrIadaEwq5crycP7Qj7DEdIU6xTUl9QsgiNF/TK/bYfORs/m8IV43IDtX0+KvMuVqxpd+ZmDvu2B8qWySD5wqAFfVM2sMHw40vRyiNfZ/7z12/xd10Zcmzs8MVeM1JQDiu4KfdHlCKN9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dau+pp5+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dau+pp5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCEDC433B2;
	Tue,  2 Apr 2024 06:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712039937;
	bh=dQ6UzsnbxvYjXDXrHLCAD2HM5t7PTpJkoPIVrOnan6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dau+pp5+acUl7vsQR72taWG/nzG4xii9ij+JwTB2Bm+E40wVMH4Z/lRO/Ee1dHOxE
	 NyXqE/eCR/UNUHM50n6qyNnVFSH/yRR9Phek3ysmNDpYIwC5SpOygCkpigzXzMtbok
	 EJylaJrN0JXe1PQAbgipTFti11M5VP1kpEsKP4qKrCcsPvZW/MxqgoXLfbj920PmJG
	 GX1OowDz/YrqE1tO4MGR9rfif/CER2Zvl4sddJq+5zNhdHmde6f1Tr5v5ZzgY209Pp
	 1r8spvKr4WL4vo5gI22ckK7jcsSbYTa7ud/K5Jm1joGNaZTZXMWTKirmTIvKP9+Mjb
	 Yi69d9/IjO0HQ==
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Export send_recv_data helper
Date: Tue,  2 Apr 2024 14:38:29 +0800
Message-Id: <5a1d3a5e2e5318c237a390f8480b51471ed7a488.1712039441.git.tanggeliang@kylinos.cn>
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

This patch extracts the code to send and receive data into a new
helper named send_recv_data() in network_helpers.c and export it
in network_helpers.h.

This helper will be used for MPTCP BPF selftests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 86 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 82 +-----------------
 3 files changed, 88 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index f2f8f7388d7c..9878d8072e7f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -506,3 +506,89 @@ int send_byte(int fd)
 		return -1;
 	return 0;
 }
+
+struct send_recv_arg {
+	int		fd;
+	uint32_t	bytes;
+	int		stop;
+};
+
+static void *send_recv_server(void *arg)
+{
+	struct send_recv_arg *a = (struct send_recv_arg *)arg;
+	ssize_t nr_sent = 0, bytes = 0;
+	char batch[1500];
+	int err = 0, fd;
+
+	fd = accept(a->fd, NULL, NULL);
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
+	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
+		nr_sent = send(fd, &batch,
+			       MIN(a->bytes - bytes, sizeof(batch)), 0);
+		if (nr_sent == -1 && errno == EINTR)
+			continue;
+		if (nr_sent == -1) {
+			err = -errno;
+			break;
+		}
+		bytes += nr_sent;
+	}
+
+	ASSERT_EQ(bytes, a->bytes, "send");
+
+done:
+	if (fd >= 0)
+		close(fd);
+	if (err) {
+		WRITE_ONCE(a->stop, 1);
+		return ERR_PTR(err);
+	}
+	return NULL;
+}
+
+void send_recv_data(int lfd, int fd, uint32_t total_bytes)
+{
+	ssize_t nr_recv = 0, bytes = 0;
+	struct send_recv_arg arg = {
+		.fd	= lfd,
+		.bytes	= total_bytes,
+	};
+	pthread_t srv_thread;
+	void *thread_ret;
+	char batch[1500];
+	int err;
+
+	WRITE_ONCE(arg.stop, 0);
+
+	err = pthread_create(&srv_thread, NULL, send_recv_server, (void *)&arg);
+	if (!ASSERT_OK(err, "pthread_create"))
+		return;
+
+	/* recv total_bytes */
+	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
+		nr_recv = recv(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_recv == -1 && errno == EINTR)
+			continue;
+		if (nr_recv == -1)
+			break;
+		bytes += nr_recv;
+	}
+
+	ASSERT_EQ(bytes, total_bytes, "recv");
+
+	WRITE_ONCE(arg.stop, 1);
+	pthread_join(srv_thread, &thread_ret);
+	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index d7ee2857093c..e66ed7b68c4d 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -72,6 +72,7 @@ struct nstoken;
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
 int send_byte(int fd);
+void send_recv_data(int lfd, int fd, uint32_t total_bytes);
 
 static __u16 csum_fold(__u32 csum)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index a1f0a2b06489..3f822100c2b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -33,76 +33,15 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
-struct send_recv_arg {
-	int		fd;
-	uint32_t	bytes;
-	int		stop;
-};
-
-static void *server(void *arg)
-{
-	struct send_recv_arg *a = (struct send_recv_arg *)arg;
-	ssize_t nr_sent = 0, bytes = 0;
-	char batch[1500];
-	int err = 0, fd;
-
-	fd = accept(a->fd, NULL, NULL);
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
-	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
-		nr_sent = send(fd, &batch,
-			       MIN(a->bytes - bytes, sizeof(batch)), 0);
-		if (nr_sent == -1 && errno == EINTR)
-			continue;
-		if (nr_sent == -1) {
-			err = -errno;
-			break;
-		}
-		bytes += nr_sent;
-	}
-
-	ASSERT_EQ(bytes, a->bytes, "send");
-
-done:
-	if (fd >= 0)
-		close(fd);
-	if (err) {
-		WRITE_ONCE(a->stop, 1);
-		return ERR_PTR(err);
-	}
-	return NULL;
-}
-
 static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 {
-	ssize_t nr_recv = 0, bytes = 0;
-	struct send_recv_arg arg = {
-		.bytes	= total_bytes,
-	};
 	int lfd = -1, fd = -1;
-	pthread_t srv_thread;
-	void *thread_ret;
-	char batch[1500];
 	int err;
 
-	WRITE_ONCE(arg.stop, 0);
-
 	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
-	arg.fd = lfd;
-
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (!ASSERT_NEQ(fd, -1, "socket")) {
 		close(lfd);
@@ -134,26 +73,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 			goto done;
 	}
 
-	err = pthread_create(&srv_thread, NULL, server, (void *)&arg);
-	if (!ASSERT_OK(err, "pthread_create"))
-		goto done;
-
-	/* recv total_bytes */
-	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
-		nr_recv = recv(fd, &batch,
-			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_recv == -1 && errno == EINTR)
-			continue;
-		if (nr_recv == -1)
-			break;
-		bytes += nr_recv;
-	}
-
-	ASSERT_EQ(bytes, total_bytes, "recv");
-
-	WRITE_ONCE(arg.stop, 1);
-	pthread_join(srv_thread, &thread_ret);
-	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
+	send_recv_data(lfd, fd, total_bytes);
 
 done:
 	close(lfd);
-- 
2.40.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173FC12EBC5;
	Mon, 25 Mar 2024 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711344505; cv=none; b=tnULCwPqcrxUT2xdweGVB1ZUMtGMPTxzvDlvQtsa+ATpEraViqDYIs0ortFzcSm89c7bC4vdvVrHJ/+kkMUemrjrSfkZQVvHhi3qVUi2ZbwsBz7/aKPaTOUO/Ite46hjz+O1bkQeQA3HDXHxg7f7TLCP0M1oSzrgSw7MBFuKGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711344505; c=relaxed/simple;
	bh=bs0JfZVK/aN1+hpKTWB7rxnBB7XfX24fEF7rMO6xYMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bM9wHMrZKNLqvHIRRYQbUCcpe/IrnjuAQggO60QKJZeTKCtqJhSCTDIhBGYhXYJPHR07+/J8rICoDgnnKoM8YjpciO8TPvAdoq1sQTVhfFSXI0ea4q4Hp197TdyWXV4IawbboGnXtQtn/CQAwpeXq6mQiN1680XTwox0vSPBssQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MosNkcHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MosNkcHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F0AC433C7;
	Mon, 25 Mar 2024 05:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711344504;
	bh=bs0JfZVK/aN1+hpKTWB7rxnBB7XfX24fEF7rMO6xYMQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MosNkcHFoO0hkLqxiLpw5/C2xcMM5HuXN7gMriIt6QPGmIMvZbkI7H2Wd1L4RTX81
	 KJBAbZT3TYvKf5xAz/soOXb4hLYOq0LlpBP5C1JHi7ylTWOser7qYe2A+m62sQeTS+
	 jTWLqnLmghN1onP2VMrGIfRsj1pC2PGfuPCfnNeB/fzYKHCzQeONmzNSrkjtM5HOZ/
	 GoelWEhSmf8t6vWnxNFBgQc9lN90tt07baoBxzTslIWCH/5zympirCAopfFdLMeJFK
	 /ytUyjHVI5DMhC0W3J/BSuZtApexYbkdODnLiWzKzNc7UAJG8FZYIgZBhyYhdKPon5
	 jgEIUVu3q4fbA==
From: Geliang Tang <geliang@kernel.org>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
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
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v2] selftests/bpf: Use start_server and connect_fd_to_fd
Date: Mon, 25 Mar 2024 13:28:09 +0800
Message-ID: <686400b5c4eefdb930048df57cc513dbd6e94fa1.1711343483.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20240325052809.sUfo_rHpGhkX8Z6Pt9o1ONgTkGz9PowCQV1cUcfXLF4@z>

From: Geliang Tang <tanggeliang@kylinos.cn>

To simplify the code, use BPF selftests helpers start_server() and
connect_fd_to_fd() in bpf_tcp_ca.c instead of open-coding. These helpers
are defined in network_helpers.c, and exported in network_helpers.h,
which is already included in bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - use connect_fd_to_fd too.
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 24 +++----------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index a88e6e07e4f5..3da3030c9365 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -78,18 +78,16 @@ static void *server(void *arg)
 
 static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 {
-	struct sockaddr_in6 sa6 = {};
 	ssize_t nr_recv = 0, bytes = 0;
 	int lfd = -1, fd = -1;
 	pthread_t srv_thread;
-	socklen_t addrlen = sizeof(sa6);
 	void *thread_ret;
 	char batch[1500];
 	int err;
 
 	WRITE_ONCE(stop, 0);
 
-	lfd = socket(AF_INET6, SOCK_STREAM, 0);
+	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
@@ -99,23 +97,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 		return;
 	}
 
-	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca) ||
-	    settimeo(lfd, 0) || settimeo(fd, 0))
-		goto done;
-
-	/* bind, listen and start server thread to accept */
-	sa6.sin6_family = AF_INET6;
-	sa6.sin6_addr = in6addr_loopback;
-	err = bind(lfd, (struct sockaddr *)&sa6, addrlen);
-	if (!ASSERT_NEQ(err, -1, "bind"))
-		goto done;
-
-	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
-	if (!ASSERT_NEQ(err, -1, "getsockname"))
-		goto done;
-
-	err = listen(lfd, 1);
-	if (!ASSERT_NEQ(err, -1, "listen"))
+	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca))
 		goto done;
 
 	if (sk_stg_map) {
@@ -126,7 +108,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	}
 
 	/* connect to server */
-	err = connect(fd, (struct sockaddr *)&sa6, addrlen);
+	err = connect_fd_to_fd(fd, lfd, 0);
 	if (!ASSERT_NEQ(err, -1, "connect"))
 		goto done;
 
-- 
2.40.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708092FAC05
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200593; cv=none; b=ts5N70VNwHsgW7WqodW2/sm3QgHsXr47iXLfo7o4Tr6jfBkhxKqrMr0FKGARZMrHC7P0d29E/lwaDmwRfPYuCr4RhqhfjtL0SY1whBO3MZRMvbwcmNCAmAgqce0tDDpY4C7Orjsbh9FfAaCk9V+Rjlbfjmw0OyQh7xeD+Cyc9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200593; c=relaxed/simple;
	bh=ohugORkyhjAOiOavastc6HDoCmIIZrTHiG6dT9vAAMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+/m1mfvp4c/chhPP1wOhTchgiCSgzLB0XgKVd0hl2lNvaUff8bMWvxKF1SOqlZbPf4C0dNFG6XcAnpJidjkZPBpjXeLgTMyh/Y9Rdrqy2+UKgs3/Z14NnW7sn/Z0LQnxlwxnaRtMIpIWPIOqhN+Bx1CXlfXds8js83Fn1Nu0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE9lX5sf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE9lX5sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F76FC4CEF4;
	Tue, 26 Aug 2025 09:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200593;
	bh=ohugORkyhjAOiOavastc6HDoCmIIZrTHiG6dT9vAAMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LE9lX5sf5MjQJFSrf40G7IEEpBhzD03h+7xAPc4WfrY5Dlcl4cIZJ1HinrCXXosxK
	 N/xq6598r+g327w6IqlMh78+6pfUQONFaQcAzTdQu28aa5+10ZVgZ8xccK/YOS1t8w
	 ZnKmlHaDmelbptywaLspU2ogTFGTjpazyS3ck1i58fS62P/ur/s+yy55WGhQgwdhXL
	 o5jXjnAelnhh32FlgkINktvWkYPHEW1EnoumtmryGvbRFHqVsOgIy2jWNjngYPBLY1
	 mEKEZqDvzdYkPpHhJgeOOS9QDrRW6D03KwjIU2zv9+ZtV2PNZdONND7OF/wdvO58gz
	 DUqZnKX2C4cEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 05/14] selftests: mptcp: sockopt: use unix socket instead of pipe
Date: Tue, 26 Aug 2025 17:29:29 +0800
Message-ID: <cce176f3f42883d5a173a39e103d480226c53669.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replaces pipe-based synchronization with Unix domain socket pairs
(SOCK_DGRAM) for better bidirectional communication reliability
between server and client processes.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 366e4aa4df0b..add29bdda9e5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -593,7 +593,7 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
-static void connect_one_server(int fd, int pipefd)
+static void connect_one_server(int fd, int unixfd)
 {
 	char buf[4096], buf2[4096];
 	size_t len, i, total;
@@ -618,9 +618,9 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, 0, 0);
 
 	/* un-block server */
-	ret = read(pipefd, buf2, 4);
+	ret = read(unixfd, buf2, 4);
 	assert(ret == 4);
-	close(pipefd);
+	close(unixfd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
@@ -662,7 +662,7 @@ static void connect_one_server(int fd, int pipefd)
 	close(fd);
 }
 
-static void process_one_client(int fd, int pipefd)
+static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, ret2, ret3;
 	struct so_state s;
@@ -671,7 +671,7 @@ static void process_one_client(int fd, int pipefd)
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
-	ret = write(pipefd, "xmit", 4);
+	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
 	ret = read(fd, buf, sizeof(buf));
@@ -736,7 +736,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int unixfd)
 {
 	int fd = -1, r;
 
@@ -752,13 +752,13 @@ static int server(int pipefd)
 		break;
 	}
 
-	r = write(pipefd, "conn", 4);
+	r = write(unixfd, "conn", 4);
 	assert(r == 4);
 
 	alarm(15);
 	r = xaccept(fd);
 
-	process_one_client(r, pipefd);
+	process_one_client(r, unixfd);
 
 	return 0;
 }
@@ -801,7 +801,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int unixfd)
 {
 	int fd = -1;
 
@@ -820,7 +820,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, unixfd);
 
 	return 0;
 }
@@ -867,31 +867,31 @@ int main(int argc, char *argv[])
 {
 	int e1, e2, wstatus;
 	pid_t s, c, ret;
-	int pipefds[2];
+	int unixfds[2];
 
 	parse_opts(argc, argv);
 
 	init_rng();
 
-	e1 = pipe(pipefds);
+	e1 = socketpair(AF_UNIX, SOCK_DGRAM, 0, unixfds);
 	if (e1 < 0)
-		die_perror("pipe");
+		die_perror("socketpair");
 
 	s = xfork();
 	if (s == 0)
-		return server(pipefds[1]);
+		return server(unixfds[1]);
 
-	close(pipefds[1]);
+	close(unixfds[1]);
 
 	/* wait until server bound a socket */
-	e1 = read(pipefds[0], &e1, 4);
+	e1 = read(unixfds[0], &e1, 4);
 	assert(e1 == 4);
 
 	c = xfork();
 	if (c == 0)
-		return client(pipefds[0]);
+		return client(unixfds[0]);
 
-	close(pipefds[0]);
+	close(unixfds[0]);
 
 	ret = waitpid(s, &wstatus, 0);
 	if (ret == -1)
-- 
2.48.1


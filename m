Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B72248881
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083769; cv=none; b=RXXNfFiXd+ye1Rda8RpuWbQew7ckf8TdWtKRQdQ2SX0eoocSs9ROnCVNY24pgFJI21EGikDQUknOhCBR7dUWVLmptQ32b6lt3lXddiazfl7Go+7taTz3pUicr7sHCxa4OZIuvCkYRQcLUmF/LeeXGv9VigqtUegPPJYDHSYaGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083769; c=relaxed/simple;
	bh=S3a1OARrDas6fbSlstjjELQ24nWVsxDZSfkj/IGXM4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8GUONCbmwJyZra776VNtRHQee12jD6IYoSgD3O0zxLTGoozq3qSmA5r1vEdlJkJCNl3+IDFeX2SRiUMSKLBlajFVHY1PHVqM29aARynvkLZmR3GWCU6YluwU0xj8RSIkeHeBYFLgs4yeksb0fm4k8J7p3ena64i4jK/qRApvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcU1v2wY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcU1v2wY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83B01F00A3A;
	Wed, 15 Jul 2026 02:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083768;
	bh=65SCwgUdDvotPc41dNhwI7w4Z/1WL86afzhWt/fhGfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dcU1v2wY56uDYzAPoL3Vm4E1nFNWhitTAV6eAZiv2o2G93Y3pWrvHButTIsJGCs2S
	 2byyDbaUUNMYZXMtZKcCxS00f8AnlfeypEp4ZkRSScoi+ak134eJ+SfAsQ81AnGdgO
	 o098dlhpUEM62jcTSHa2cJDx9HHvhsjenFYEfrHohmsvKOBhBR+CzM/nu49dBQugDs
	 FsMeL0UoDNOygu56mjPz0blJtnUhkISPaVhmT64Mq9VnEAoV17drzBVdM0JkMaiLO8
	 9w5c6Kmfi+vxEHj+T59FZ7jJid13nLk8PqKH5PPzjYZkeC4Ls0AqNVLHwn+WRfLECW
	 otG3cWV4FRVww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 07/11] selftests: mptcp: sockopt: use unix socket instead of pipe
Date: Wed, 15 Jul 2026 10:48:53 +0800
Message-ID: <b94e6102780a17626a8ffc041af5f12ba5574065.1784082850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784082850.git.tanggeliang@kylinos.cn>
References: <cover.1784082850.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replace the pipe() with socketpair(AF_UNIX, SOCK_STREAM) for
inter-process communication. This prepares for upcoming patches that
will require bidirectional communication and reliable EOF behavior,
which a pipe does not fully support.

Use SOCK_STREAM over SOCK_DGRAM (used in the original mptcp_inq.c)
to reliably detect peer closure via EOF, avoiding indefinite hangs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b40ec54cb134..0d1426c11581 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -597,7 +597,7 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
-static void connect_one_server(int fd, int pipefd)
+static void connect_one_server(int fd, int unixfd)
 {
 	char buf[4096], buf2[4096];
 	size_t len, i, total;
@@ -622,9 +622,9 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, 0, 0);
 
 	/* un-block server */
-	ret = read(pipefd, buf2, 4);
+	ret = read(unixfd, buf2, 4);
 	assert(ret == 4);
-	close(pipefd);
+	close(unixfd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
@@ -677,7 +677,7 @@ static void check_stat_equal(const char *name, uint64_t actual,
 	       name, actual, expected, (int64_t)(actual - expected));
 }
 
-static void process_one_client(int fd, int pipefd)
+static void process_one_client(int fd, int unixfd)
 {
 	struct so_state s;
 	char buf[4096];
@@ -687,7 +687,7 @@ static void process_one_client(int fd, int pipefd)
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
-	ret = write(pipefd, "xmit", 4);
+	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
 	ret = read(fd, buf, sizeof(buf));
@@ -753,7 +753,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int unixfd)
 {
 	int fd = -1, r;
 
@@ -769,13 +769,13 @@ static int server(int pipefd)
 		break;
 	}
 
-	r = write(pipefd, "conn", 4);
+	r = write(unixfd, "conn", 4);
 	assert(r == 4);
 
 	alarm(15);
 	r = xaccept(fd);
 
-	process_one_client(r, pipefd);
+	process_one_client(r, unixfd);
 
 	close(fd);
 	return 0;
@@ -819,7 +819,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int unixfd)
 {
 	int fd = -1;
 
@@ -838,7 +838,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, unixfd);
 
 	return 0;
 }
@@ -894,35 +894,35 @@ int main(int argc, char *argv[])
 {
 	int e1, e2, wstatus;
 	pid_t s, c, ret;
-	int pipefds[2];
+	int unixfds[2];
 
 	parse_opts(argc, argv);
 
 	init_rng();
 
-	e1 = pipe(pipefds);
+	e1 = socketpair(AF_UNIX, SOCK_STREAM, 0, unixfds);
 	if (e1 < 0)
-		die_perror("pipe");
+		die_perror("socketpair");
 
 	s = xfork();
 	if (s == 0) {
-		close(pipefds[0]);
-		ret = server(pipefds[1]);
-		close(pipefds[1]);
+		close(unixfds[0]);
+		ret = server(unixfds[1]);
+		close(unixfds[1]);
 		return ret;
 	}
 
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
2.53.0


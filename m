Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCDE311C20
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686848; cv=none; b=RTvXv22IUgLMCu0pVXxiLzuGM4JMiE2YZFsv6Bh53MOOfQht57Xd8V/tqw9uJaRbQhyeRodq+0vVRrje/ZTjVsH1dm3dt5wVDROpE5bp3VDZ7rU7DtHs42fCAf5kB3uIviM9iUsZMcSrc3o/J4U8S249dlpbT640Mh/6nU1DMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686848; c=relaxed/simple;
	bh=FSmeiYgy7sMMXKU8zq/GyW3nKNSOEsJ6UV9HL0mgQKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRtWOlQHCensVxWNjHblmaoXLxKOlYjhVeRSmLo5Ci9IhkNU3u3345u4ryoRYJT4A+M7jKi8/X7Q0uZqjHsjQc3dCIXJNtVI/+hsgbwZubS8445zzFfNoJEhrjX2IfVHfmTZRXzapzyHzkGC611ahHOJVuos8p8QscvfbDWTn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERDhcyGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERDhcyGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62FBC4CEFA;
	Fri, 12 Sep 2025 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686848;
	bh=FSmeiYgy7sMMXKU8zq/GyW3nKNSOEsJ6UV9HL0mgQKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERDhcyGrbDaTWvta7yf5kyECYEzFBGW249ZUzTiD8PWcfuUhM7ROIxNgweYCJsJ1a
	 eA7unt3C+V7h7JjvhVTYCWJA4Zb59qXDljwjn2jANy8HCExVfuJC3Nlc24Nt3/5vEJ
	 8MYi1SxN8ge8uS15/T1TpuMzG777VDzFNvzsupZjNkexZ1WqjvNk/rocXJhAs79M/O
	 zWRLPtQFGzBbTdv8nOxoMnToj6cGZopPI+NEK3I8il0eTHc2Ao3GeqbrGj3QOM5pgV
	 L62OGP9emQgBkA8nqsRs6SpdHokhY5n0L9zDwqFtshP+FHO5/KTaEukQ1arqbwVcHu
	 yUSxmQqVbYZUA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/9] selftests: mptcp: sockopt: rename pipefd to ipcfd
Date: Fri, 12 Sep 2025 22:19:51 +0800
Message-ID: <9f9c9d888be62d21942aafc50ddd0eec1fba971d.1757686538.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757686538.git.tanggeliang@kylinos.cn>
References: <cover.1757686538.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Rename pipefd to ipcfd to better reflect its generalized purpose since
it now handles both pipes and Unix domain sockets. This naming improves
code clarity for IPC channel handling.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 96d636005cb2..776a017577ce 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -590,7 +590,7 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
-static void connect_one_server(int fd, int pipefd)
+static void connect_one_server(int fd, int ipcfd)
 {
 	char buf[4096], buf2[4096];
 	size_t len, i, total;
@@ -615,9 +615,9 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, 0, 0);
 
 	/* un-block server */
-	ret = read(pipefd, buf2, 4);
+	ret = read(ipcfd, buf2, 4);
 	assert(ret == 4);
-	close(pipefd);
+	close(ipcfd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
@@ -659,7 +659,7 @@ static void connect_one_server(int fd, int pipefd)
 	close(fd);
 }
 
-static void process_one_client(int fd, int pipefd)
+static void process_one_client(int fd, int ipcfd)
 {
 	ssize_t ret, ret2, ret3;
 	struct so_state s;
@@ -668,7 +668,7 @@ static void process_one_client(int fd, int pipefd)
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
-	ret = write(pipefd, "xmit", 4);
+	ret = write(ipcfd, "xmit", 4);
 	assert(ret == 4);
 
 	ret = read(fd, buf, sizeof(buf));
@@ -726,7 +726,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int ipcfd)
 {
 	int fd = -1, r;
 
@@ -742,13 +742,13 @@ static int server(int pipefd)
 		break;
 	}
 
-	r = write(pipefd, "conn", 4);
+	r = write(ipcfd, "conn", 4);
 	assert(r == 4);
 
 	alarm(15);
 	r = xaccept(fd);
 
-	process_one_client(r, pipefd);
+	process_one_client(r, ipcfd);
 
 	close(fd);
 	return 0;
@@ -792,7 +792,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int ipcfd)
 {
 	int fd = -1;
 
@@ -811,7 +811,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, ipcfd);
 
 	return 0;
 }
@@ -858,35 +858,36 @@ int main(int argc, char *argv[])
 {
 	int e1, e2, wstatus;
 	pid_t s, c, ret;
-	int pipefds[2];
+	int ipcfds[2];
 
 	parse_opts(argc, argv);
 
 	init_rng();
 
-	e1 = pipe(pipefds);
+	e1 = inq ? socketpair(AF_UNIX, SOCK_DGRAM, 0, ipcfds) :
+		   pipe(ipcfds);
 	if (e1 < 0)
 		die_perror("pipe");
 
 	s = xfork();
 	if (s == 0) {
-		close(pipefds[0]);
-		ret = server(pipefds[1]);
-		close(pipefds[1]);
+		close(ipcfds[0]);
+		ret = server(ipcfds[1]);
+		close(ipcfds[1]);
 		return ret;
 	}
 
-	close(pipefds[1]);
+	close(ipcfds[1]);
 
 	/* wait until server bound a socket */
-	e1 = read(pipefds[0], &e1, 4);
+	e1 = read(ipcfds[0], &e1, 4);
 	assert(e1 == 4);
 
 	c = xfork();
 	if (c == 0)
-		return client(pipefds[0]);
+		return client(ipcfds[0]);
 
-	close(pipefds[0]);
+	close(ipcfds[0]);
 
 	ret = waitpid(s, &wstatus, 0);
 	if (ret == -1)
-- 
2.48.1


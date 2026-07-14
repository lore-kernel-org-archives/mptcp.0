Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151233655C0
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994961; cv=none; b=OQqChzyT8aGBzdrYlFgv+PBDxc6fE2gvU4m8WfdMGHc6FXx1XVXditXdrfK7gNdBUQkjW7NnmdoM5zja+bE61yom+vJeFepfeu7rZwPytQXcDcMEddFAXkSVzM6ipApJX+1gvwWxdALk+quPfYxTEL1F9piG6R7H7PrDszSYMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994961; c=relaxed/simple;
	bh=PQG2+RYvEuYVEusU5ghWIhKMd3gObQT59O+pC0+kiQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nP2hlRKLzywj2DadriRr+vcMoYJoIp4PmApx8VhLE3CPOSwxpLzKDpwAEPM+7kWJZ2gU2iWszPJSrMlGXaRPoK831xwsRHDPuun/sLKE8t1/FroU1bB1neFMfmAI0tuux+b64UNiVDLtDFnG7Avq2ndro25eefG0ipICi+wvZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl0C7yzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl0C7yzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8974E1F000E9;
	Tue, 14 Jul 2026 02:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994959;
	bh=xENSgfz4sXSBBuvgWRNv/zBxxsghBkRIwFcg3dj/ahY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hl0C7yzRoaDpgBOAnFxaBAhDlndyL5WaQEDn8unvEm8Id8xIimpabIMNgyTXuMtNs
	 zTp5MB/gG1yJ5w46/WEfqy2sJrPQH0F5UxbXy3WuswZAn5BxK6QjjOEj7fouvzQWUd
	 o8woGyBKJL5abTGWAYpFTQnxk77e7I5UFp/jrSmmUOBCqU7OXZK62wMDndmgcMEceZ
	 AZ4+FiMxLgAiArDb10ciMulgaXBMvsbAXfxZo7S5hQhTGYD9ZexceR8jnA/4ayeIwq
	 7cu9a3xSjHtWfpHXUZSi9o84i5HOtiZoSw3SZGGHCpSafpq6Z/alxWlsx4hV3esYa8
	 EeGnla08HkksA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 08/13] selftests: mptcp: sockopt: use unix socket instead of pipe
Date: Tue, 14 Jul 2026 10:08:53 +0800
Message-ID: <ff1a75f49200db000a145418dee35e72d3519e55.1783994494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
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
index 0a80d505dc4c..e4fc9f12f164 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -598,7 +598,7 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
-static void connect_one_server(int fd, int pipefd)
+static void connect_one_server(int fd, int unixfd)
 {
 	char buf[4096], buf2[4096];
 	size_t len, i, total;
@@ -623,9 +623,9 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, 0, 0);
 
 	/* un-block server */
-	ret = read(pipefd, buf2, 4);
+	ret = read(unixfd, buf2, 4);
 	assert(ret == 4);
-	close(pipefd);
+	close(unixfd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
@@ -668,7 +668,7 @@ static void connect_one_server(int fd, int pipefd)
 	close(fd);
 }
 
-static void process_one_client(int fd, int pipefd)
+static void process_one_client(int fd, int unixfd)
 {
 	struct so_state s;
 	char buf[4096];
@@ -678,7 +678,7 @@ static void process_one_client(int fd, int pipefd)
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
-	ret = write(pipefd, "xmit", 4);
+	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
 	ret = read(fd, buf, sizeof(buf));
@@ -751,7 +751,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int unixfd)
 {
 	int fd = -1, r;
 
@@ -767,13 +767,13 @@ static int server(int pipefd)
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
@@ -817,7 +817,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int unixfd)
 {
 	int fd = -1;
 
@@ -836,7 +836,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, unixfd);
 
 	return 0;
 }
@@ -885,35 +885,35 @@ int main(int argc, char *argv[])
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


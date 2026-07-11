Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2B255F2C
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741478; cv=none; b=TtSvqsbUMqUZPdopce17cGTqH1CBtYYLNvzkaR1qCeRbh0cQ5CG8BihUn0+ChckuvRuf+dPezwwz1EkWI2ZL6hoBbFYdDgUh1PiliRAEMbocLGPzuSMZ9iygM+9gJoCjWQ270gDby636/oUn6Siplfk0FY/sJNae8X+KsB8chUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741478; c=relaxed/simple;
	bh=BM3I5ZRAyf2yZugjzpptujdMvDemR9or2PZ2qB4uQYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfPp5GsmqRFtPImieLfhdEmhZ0dcu/85giXSr/bzmZ1+1jbznuGCuiw2RsRXwfjDLh0S8o7CDPVqXgT73usRCsWn+Yv2TjsnqO6FXVkztmETY5HSKe1QdyaQQjakcohrQfgQmYMkXZx1kpdrn2HBUaNCC/szRWc3DYpMBgtCeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j85ypj5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j85ypj5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7FF1F000E9;
	Sat, 11 Jul 2026 03:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741476;
	bh=iMPJqOZOQutlEF798KXDe0VIsyr/gaAwxu5fW73BVO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j85ypj5JPp/DTt29ES5vjnebWqduOXNsLnUBv1dW7yR3rdfFDiq3jbauv6XFv5mK6
	 7kGe4TY6JIXhgZ4e5JLv23pxegIXz1sKlkaaChqdt1QyW8gOuWkG/sboB6Y5YeQnAG
	 mpLq8STuUeoPwJNYLCL9zQE2YbZLtc4NeyVNoCxsjIc9iJ+oAvJk4N+RXPtdFVjQsE
	 1k8R10Jo9aDiLvLnm7td7XuL06cogDweEbccCwWOs4IwFXT+gU5s8shu2sJ6AIgt89
	 ShLGfYFt8b6rdLpgYSp+DgCs+1pIjgVqFRyXUBQHNNsuUE3i+wiXByHc00JttIwSiO
	 60MB+jxvBDZJA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 06/14] selftests: mptcp: sockopt: use unix socket instead of pipe
Date: Sat, 11 Jul 2026 11:43:34 +0800
Message-ID: <907de77e6d5449d48258c77150806921fccb9cac.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replace pipe-based synchronization with Unix domain socket pairs
(SOCK_STREAM) for bidirectional communication between the server and
client processes. Pipes only support one-way flow, which required the
code to open and close the pipe file descriptor at awkward points; a
SOCK_STREAM socketpair gives a clean two-way channel.

These IPC helpers are reused from mptcp_inq.c (which used SOCK_DGRAM);
switching to SOCK_STREAM is correct here because the existing protocol
exchanges fixed-size, byte-aligned control records rather than discrete
datagrams.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ba251a4b0599..28dc825b9d48 100644
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
 
@@ -667,7 +667,7 @@ static void connect_one_server(int fd, int pipefd)
 	close(fd);
 }
 
-static void process_one_client(int fd, int pipefd)
+static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, r, w;
 	struct so_state s;
@@ -676,7 +676,7 @@ static void process_one_client(int fd, int pipefd)
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
-	ret = write(pipefd, "xmit", 4);
+	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
 	ret = read(fd, buf, sizeof(buf));
@@ -749,7 +749,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int unixfd)
 {
 	int fd = -1, r;
 
@@ -765,13 +765,13 @@ static int server(int pipefd)
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
@@ -815,7 +815,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int unixfd)
 {
 	int fd = -1;
 
@@ -834,7 +834,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, unixfd);
 
 	return 0;
 }
@@ -890,35 +890,35 @@ int main(int argc, char *argv[])
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


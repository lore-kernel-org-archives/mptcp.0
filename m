Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3A29405
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381348; cv=none; b=JhUK157jIeWZYHsNX+GuIxdFHUVutxkDSWBdNvMdtAdnbMPar+JKY+MTyNGbJXHaR2iJ0qz17mDFZ/fZoK4AE4OkMZuAO20LnzdNzfTx0R/Xzk0az2C2qRIoTtTk7uLgT56G5HWthqRhWDy74fXdA01lP9IPt5LrYkUELgx47xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381348; c=relaxed/simple;
	bh=NfT3QskjHJdRXyO5b6yD4mlEV8Y3YuzIfE3tDHtLDlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bdg+k02GCI2C6IisaqPe65qJnMNckgM6wdgdn4E/1cho7ptxsvacSmfoMKLeZ1l6NsCpNAwMnRSGzkIiZu/8EwLWLbtt5slWsPLUKRZzRCXNr+ExyrcHgb4jQmpf8nGMVI33NRx9D7ZOkEwx8Emih392exFPL5srhGYduAf7Rzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiZzcgyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiZzcgyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336E11F000E9;
	Thu, 30 Jul 2026 03:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381347;
	bh=MmCVn9gEnu49A79yU4KfxoLAJsjaWD1hoCzJwSi9MYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iiZzcgyby9+31V81YZxUlnYxNdG8WmhuC6jDb3jiWZ61Yv4i1EbDS1zz0pKNwMvDw
	 ceSE+4Xuy66jE/1ptDxOycLotBk+UvhL5jcXgPQBzi//HvJ/4M/o27xXQxLH+MZQ3H
	 an8+NsshIULj81PKmNhCPt62cCoyjPz3GP4MRmLQW0EqIidSs6W2lIEsaVzTxdEEBK
	 SM1yLT3tmydcQrP7CywDoo4ENDeiNFZ5osv0yY75MXJwN+hEtTNtHgcCDuZ2cfI6mh
	 k58/08wzvwtM3OaOLasoZwkURaaEEf9dqW1aaN8FbiMf+jFw/fG7ILmQYzwQDVms5Z
	 clKOH9GzIxBBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 08/12] selftests: mptcp: sockopt: use unix socket instead of pipe
Date: Thu, 30 Jul 2026 11:15:19 +0800
Message-ID: <d906ee784d437cdccc5429d57a49ad580080cd06.1785380422.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785380422.git.tanggeliang@kylinos.cn>
References: <cover.1785380422.git.tanggeliang@kylinos.cn>
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
index 1d98b8d2b4a6..e404aecc7115 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -618,7 +618,7 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
-static void connect_one_server(int fd, int pipefd)
+static void connect_one_server(int fd, int unixfd)
 {
 	char buf[4096], buf2[4096];
 	size_t len, i, total;
@@ -643,9 +643,9 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, 0, 0);
 
 	/* un-block server */
-	ret = read(pipefd, buf2, 4);
+	ret = read(unixfd, buf2, 4);
 	assert(ret == 4);
-	close(pipefd);
+	close(unixfd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
@@ -698,7 +698,7 @@ static void check_stat_equal(const char *name, uint64_t actual,
 	       name, actual, expected, (int64_t)(actual - expected));
 }
 
-static void process_one_client(int fd, int pipefd)
+static void process_one_client(int fd, int unixfd)
 {
 	struct so_state s;
 	char buf[4096];
@@ -708,7 +708,7 @@ static void process_one_client(int fd, int pipefd)
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
-	ret = write(pipefd, "xmit", 4);
+	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
 	ret = read(fd, buf, sizeof(buf));
@@ -774,7 +774,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int unixfd)
 {
 	int fd = -1, r;
 
@@ -790,13 +790,13 @@ static int server(int pipefd)
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
@@ -840,7 +840,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int unixfd)
 {
 	int fd = -1;
 
@@ -859,7 +859,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, unixfd);
 
 	return 0;
 }
@@ -915,35 +915,35 @@ int main(int argc, char *argv[])
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


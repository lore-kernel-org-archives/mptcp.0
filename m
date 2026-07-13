Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4686314B9A
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913160; cv=none; b=JvEPP3CDzCg5d/oKOdtMPZA5scffE39vJTxArFJbFwzBkp4EdZKFr6GZqYx7OgEelhz7ye8O0DcoVIR55iDPy+HuiaM7GNDqvhFl9MW5uDT5mUPk2lXbtNh2wJPZmMrMHM8YTpilmSwPbYHmlfFmwSBNFEP5DuEozxviSMUeRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913160; c=relaxed/simple;
	bh=5rAYe1P//CzlRtIgjwmBEjpHiExJ3Aq48A6bDKb/VrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPNEdqA6TUoLQUUfYj5KQMq/uRtj1Pp7i4nOTj+w2Oe32IUiyO3kD0r09efelm7jwmT7a/CryC/nM1C68j2qAaJNnSdYIftGqaOl+3k/oifibDBc7zDcdml+FfQu/4LLnD7/Ff7DV3x07skbIhPhBjPwf7g0V9EBull4E/wh0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYjWHXcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYjWHXcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A3B1F00A3A;
	Mon, 13 Jul 2026 03:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913159;
	bh=E7pYQsF7wRGzdyZoF4JYNXE7YsNbstPbbewyB5z2iUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYjWHXcqhUaYPD652weprCOhd+5UhmprwKBq6Hyfja5RXGR1E1+MhTudIHxOsHqFE
	 YwvT4pHrpxZ+JYbD1Hl8If3YyOrXhoMgBIKk7+4JlGlQBXQjLR1clmxsdGyyNFgKAu
	 MlcTLyTy+onzXPDBTXEIGjhz9ypR8ttcHAXw4Ag1z/0/5nlMFmVtiCKMss2go4N2BQ
	 2pSObj0rkunBxmALBgxHuS4oM72duURf50wsPKpamk4WJZG8sxlEnArmGebbD8RBOq
	 9Wv8pdCsC+tGN5co/vzKufqVevUVefFfgPFmDO3A2H5k4X4ySci8NptvKAHxRuhvjZ
	 TuQTOyh6Cwxgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 07/12] selftests: mptcp: sockopt: use unix socket instead of pipe
Date: Mon, 13 Jul 2026 11:25:31 +0800
Message-ID: <064cf238b25b454f129c9f72fbb78b11b3ab3e08.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913010.git.tanggeliang@kylinos.cn>
References: <cover.1783913010.git.tanggeliang@kylinos.cn>
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
index 5c9a63ed6703..c7605ce5b9e1 100644
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
 	ssize_t ret, r, w;
 	struct so_state s;
@@ -677,7 +677,7 @@ static void process_one_client(int fd, int pipefd)
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
-	ret = write(pipefd, "xmit", 4);
+	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
 	ret = read(fd, buf, sizeof(buf));
@@ -750,7 +750,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int unixfd)
 {
 	int fd = -1, r;
 
@@ -766,13 +766,13 @@ static int server(int pipefd)
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
@@ -816,7 +816,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int unixfd)
 {
 	int fd = -1;
 
@@ -835,7 +835,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, unixfd);
 
 	return 0;
 }
@@ -884,35 +884,35 @@ int main(int argc, char *argv[])
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


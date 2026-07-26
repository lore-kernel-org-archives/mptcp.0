Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDE379C40
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054634; cv=none; b=tDzMiJ3oUyz7NMWJ4dzxtsQrxx9RsnEcEW5aKp7j1kj8nyYThCWMdnLZtjW2S7nYoIyueR6c+16vc7elLfLmaby610De78qs9GxsC1Drn+eiRcGFoUsca+XutCBJl0YpZ4CK+pGaWoAu+tUiQ7pZCMKKVCX2PWxWUgcZTpQj8UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054634; c=relaxed/simple;
	bh=syTE8YiHPoq9pl4r+l8K1A6VcAirUVVeUrYbhuR4rGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECdYZgHOY5JTlajXpnRIBBLGCSnDOVQ38FoTGIErSUwGGyg2JtSmB/L/CQfjrIJMhfRl4GADDyEysVCkzobvoMx/uV9QqkDUTvamzNG99q/S+QNnJx8JAI/9ANGeQW1qNTpafKTaubiSAykmtwcXOa4rQ2WTsyCAx+xfVLMcS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH6t69G6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH6t69G6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E6D1F00A3E;
	Sun, 26 Jul 2026 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054632;
	bh=AUGXXK5KzeBhvWH4m0Wu0RDS1VLzFCRWCFGjrqkk2bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hH6t69G6R7GzFuCzotz+gfdiSkwkj87gVXrJjqAhGzfKAmA++/SVnDFDRqm1QniCj
	 KekvMtUG6W6dUyGEGnZBDUw91U0qQ1ZFuyNd5Vge0jcwB2084ibMK5OX9xXFxvG5Kk
	 f8eX8H4E4Kn53YIZB3eNu7t29b6MmPGYGoC3l4WjqDPOfJTFQVPiAp4xahF/Me0F45
	 iqqq71ipMlyQAwoYFYqueKDqQu5McxjxNNqghdgNsMdtG3K2qWecCuyPTvU6aLheaS
	 TAfNxivxOKz+MNeDDHEjjrC40ZCPjLh5QENkW8/Urwr8n51oLejEJJGAnat5P3LmiF
	 LtvFittQRu2pA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 08/12] selftests: mptcp: sockopt: use unix socket instead of pipe
Date: Sun, 26 Jul 2026 16:30:13 +0800
Message-ID: <24d59971d01e59e6a73c83f48915c219f5ed8d72.1785054129.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054129.git.tanggeliang@kylinos.cn>
References: <cover.1785054129.git.tanggeliang@kylinos.cn>
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
index b1b39c9c3fae..53687d1464a3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -609,7 +609,7 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
-static void connect_one_server(int fd, int pipefd)
+static void connect_one_server(int fd, int unixfd)
 {
 	char buf[4096], buf2[4096];
 	size_t len, i, total;
@@ -634,9 +634,9 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, 0, 0);
 
 	/* un-block server */
-	ret = read(pipefd, buf2, 4);
+	ret = read(unixfd, buf2, 4);
 	assert(ret == 4);
-	close(pipefd);
+	close(unixfd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
@@ -689,7 +689,7 @@ static void check_stat_equal(const char *name, uint64_t actual,
 	       name, actual, expected, (int64_t)(actual - expected));
 }
 
-static void process_one_client(int fd, int pipefd)
+static void process_one_client(int fd, int unixfd)
 {
 	struct so_state s;
 	char buf[4096];
@@ -699,7 +699,7 @@ static void process_one_client(int fd, int pipefd)
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
-	ret = write(pipefd, "xmit", 4);
+	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
 	ret = read(fd, buf, sizeof(buf));
@@ -765,7 +765,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int unixfd)
 {
 	int fd = -1, r;
 
@@ -781,13 +781,13 @@ static int server(int pipefd)
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
@@ -831,7 +831,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int unixfd)
 {
 	int fd = -1;
 
@@ -850,7 +850,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, unixfd);
 
 	return 0;
 }
@@ -906,35 +906,35 @@ int main(int argc, char *argv[])
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


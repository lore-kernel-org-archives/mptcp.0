Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF227EC99
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664229; cv=none; b=VmQopYluACCBtL0c84U4UQJvNXWBfhD8WNYHhIxVhrBepPpXVlmZo1ySzzEyr6iAP8bGJPMSsoiW2EIne7awVmsjig84DZdCv3fp9S/9Pjp7rBuP703mnYmq6+hWOC6T6dej6Q7TQBHYnbjRPbLIifh6Nx8yRbMOB5r9BDDWq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664229; c=relaxed/simple;
	bh=uH5IsOGqB/TeTg472gUZ7YqPPLrNj4Du2o/rbVqbz2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qew5uLL1UZUmj+qXf20vQcWBv/ZUaaII2MHPEJZ63fMn9e2kh+i4O6omEw132DkRRYN9h9Dl8EA4P6maFBfq+kf3rRZ+uahSfzjUNZx21DJGYoFY/ucyTZXw4nSfiKl7cC324qEFbzNJpQTB73H4F9SmosO0T6FpauW8AyyP3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1A4thBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1A4thBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C86C4CEED;
	Fri,  8 Aug 2025 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664229;
	bh=uH5IsOGqB/TeTg472gUZ7YqPPLrNj4Du2o/rbVqbz2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1A4thBNQLO+w7iot9gU05vBIKAC4SOs2VtMgbvT6A8zYF109/bXGvnQtTkWxaSGX
	 g3JA22YP3ewTxR9Ud+84gpKzWrAiHkc92IPsGGhRzdCQCOXED3V2dq5P9Tw4lmL0dE
	 BxcOZj6RjyPe1E2JLSLR8VMczF8fRlebYkNVqigVbnxFM8/pdy9fe8O3CM0wwGox0p
	 cx7xceoFYfz+96OHMexiI4ORfxjVJE+y/xidETXgiKMWifqW+bYMwh9fUq4ObIJJ+r
	 6L+UxnRtQdPgtrvAB8T6qL5wElfyAA/zYQ5VzWpWJGgd6GDbEjzSGLgLeKk5x0xJo6
	 6ohdLidgI1wFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/9] selftests: mptcp: sockopt: rename pipefd to ipcfd
Date: Fri,  8 Aug 2025 22:42:50 +0800
Message-ID: <18bae4cc7582165c767eb4f17f42913a5eecc3f9.1754664106.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754664106.git.tanggeliang@kylinos.cn>
References: <cover.1754664106.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ce5d6b8c2d32..79370df1d89d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -738,7 +738,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int ipcfd)
 {
 	int fd = -1, r;
 
@@ -754,13 +754,13 @@ static int server(int pipefd)
 		break;
 	}
 
-	r = write(pipefd, "conn", 4);
+	r = write(ipcfd, "conn", 4);
 	assert(r == 4);
 
 	alarm(15);
 	r = xaccept(fd);
 
-	process_one_client(r, pipefd);
+	process_one_client(r, ipcfd);
 
 	return 0;
 }
@@ -803,7 +803,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int ipcfd)
 {
 	int fd = -1;
 
@@ -822,7 +822,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, ipcfd);
 
 	return 0;
 }
@@ -869,31 +869,32 @@ int main(int argc, char *argv[])
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
 	if (s == 0)
-		return server(pipefds[1]);
+		return server(ipcfds[1]);
 
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


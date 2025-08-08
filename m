Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86C83CC7
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621126; cv=none; b=Xri3ANv0WsWV/LbkKVVdpQgw7mayFX2BsghU7DLd6ql04v0Luf3aeJFSUtPc+ebtoem6AMF41hyUqbkBvE0vYtOTS3sTvdkB8jksjJxRapPz1OUS+cqJP4rwc/yahiTEUxa+PMF8QvwD9sBenm8sdDhrDBo3j6nkIATDLxolCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621126; c=relaxed/simple;
	bh=BTIoI8T1orRCkdAfASX32D0EECBLQsnOa3P/iDP/Zl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqvMyw6uq7Jt6oK2fbP9hJdmlI0aFD7McvxyDFa0Sh8OxuFYevVPSxmviKl7493lsiveIxyF1jGvfZAE9o8MUqF0HHCYrWF8ie69TiXL9+XEND+vqPyebVVKIL1TfkbXfSL1IgCqG3W1TdOpZ383854Msz9merLgXNj9deHP4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnPFraHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnPFraHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A74CC4CEF1;
	Fri,  8 Aug 2025 02:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754621125;
	bh=BTIoI8T1orRCkdAfASX32D0EECBLQsnOa3P/iDP/Zl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PnPFraHupArGKz294uWxcyvlkuYnKhqMmNr6wJGS4crgffXMFVcGJkAR+nt+S89b/
	 1/N5NyURXEx4/h/6tiasAhMYDDK2GOMCR/PJtP7K/k7VNffvWC0xJRm5n6hojhqRFg
	 r6O/IzG47UVcg+L0CTSrc4rYmprdsMV4uUvOZ8LYE4bFX55vT7mY57lQHPxH0/auQp
	 OWHZcnNcwWN9yfmUcKsa9vcAneYTfYt+i3STbKzrQIGC+GnzLJ+wYVjehkw27M5Xes
	 b7p5csfAF+PlgqbxIoogKz9FRzjcBMmnpOYCB9alZGQK8IVcmSXD52/veQEEOmAs8s
	 G1kk6tCJC8PYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/8] selftests: mptcp: sockopt: rename pipefd to ipcfd
Date: Fri,  8 Aug 2025 10:45:05 +0800
Message-ID: <653a76c5131b687a850996f962d1173e95e2c601.1754620968.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754620968.git.tanggeliang@kylinos.cn>
References: <cover.1754620968.git.tanggeliang@kylinos.cn>
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
index 9558c68a62e7..f767caa55a0a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -722,7 +722,7 @@ static int xaccept(int s)
 	return fd;
 }
 
-static int server(int pipefd)
+static int server(int ipcfd)
 {
 	int fd = -1, r;
 
@@ -738,13 +738,13 @@ static int server(int pipefd)
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
@@ -787,7 +787,7 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
-static int client(int pipefd)
+static int client(int ipcfd)
 {
 	int fd = -1;
 
@@ -806,7 +806,7 @@ static int client(int pipefd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, pipefd);
+	connect_one_server(fd, ipcfd);
 
 	return 0;
 }
@@ -853,31 +853,32 @@ int main(int argc, char *argv[])
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


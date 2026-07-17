Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA533EB17
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263840; cv=none; b=Y4ID7y0lXSz3DhwLXDHJsD5l+rzm+CRUDcPT+vh5PzH1iac/BK5UPo2c29pDvnh+XzS7LB27cg4xppNogIDxSWx9IUlaCvFkWSa86yoW49sfsCQpMLmRAP0L3tD1VHEyKtaC9f6HJILmaJbArTkw0OgVgTSqMaznakKLt+HpqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263840; c=relaxed/simple;
	bh=UAs6bWwyV9obFSxq/FcQOtkWPk0s7DpBnrVWnbpXH0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC0YYl9FJSG5bhFkKy5QgQ5WzwxveM0JHqhUpJHsP8A3svbwMiw/ATubsq312KLr4ltkO9hCAgDmFcQ2+t5bgWQW4RWmwM4PBIm5ZcYUrhGam0bejssYCcrEBGY1R2G9BJDvAGvImTTiuftvAG3+re4rYU4j0BE1JRcZJrSY84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQTYslMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQTYslMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F7B1F00A3A;
	Fri, 17 Jul 2026 04:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784263839;
	bh=Bv23OPW1cVKs9PuIclXtil0uF2x7X+yo+LxmpK8gxR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQTYslMnmsiP8yskWiR3DgAyPA5Y4nquMWNnwmeoS+goo+N3FLdgVV3+ek9DtXDah
	 Zj8ORiwps8W2Psqfgj1uL48+eQvH6brmpvO/6sicb6Nn+8WfaOGrNDXxHYaeFOoPae
	 NxFwufnzmqWsLCRVVGcAgNhLkdvbU+rwg6ktTxRro3+UmkM8MzWr4Q/0oHbzD0QA9E
	 TOu2XGUaa94aG/x4XtywzdHgQfRhgJpYTr7MWGXk32gxKYV9H5AIu+LZkzS7ovxvlk
	 BBnG6UhEVwKkIVYsloClKcleTRR33q0TkTEJ+WJ3VuSpNakycIHXf7uqRE5Fd9ymcp
	 y7YmM3oIXnJgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 9/9] selftests: mptcp: connect: close listensock deterministically
Date: Fri, 17 Jul 2026 12:50:18 +0800
Message-ID: <9644df2640dec25a8b5de1176a70d828c66dfa1a.1784260668.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784260668.git.tanggeliang@kylinos.cn>
References: <cover.1784260668.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In main_loop_s(), listensock was closed nondeterministically inside
maybe_close() during the accept loop, and error paths closed it without
tracking, leading to double-close or leaks across repeated iterations
(via goto again).

Fix by making maybe_close() return a bool indicating whether it closed
the fd, and track that per iteration. Funnel poll/accept error paths
through a single 'goto out' label and close the socket there only
if not already closed. Reset 'closed' at the 'again:' label so each
iteration starts with a fresh tracking state. This ensures exactly one
close per iteration in all cases.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index f6ebdc5bf745..b04c99605518 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1323,12 +1323,15 @@ static void check_getpeername_connect(int fd)
 			cfg_host, a, cfg_port, b);
 }
 
-static void maybe_close(int fd)
+static bool maybe_close(int fd)
 {
 	unsigned int r = rand();
 
-	if (!(cfg_join || cfg_remove || cfg_repeat > 1) && (r & 1))
+	if (!(cfg_join || cfg_remove || cfg_repeat > 1) && (r & 1)) {
 		close(fd);
+		return true;
+	}
+	return false;
 }
 
 int main_loop_s(int listensock)
@@ -1338,27 +1341,30 @@ int main_loop_s(int listensock)
 	struct pollfd polls;
 	socklen_t salen;
 	int remotesock;
+	bool closed;
 	int err = 0;
 	int fd = 0;
 
 again:
+	closed = false;
 	polls.fd = listensock;
 	polls.events = POLLIN;
 
 	switch (poll(&polls, 1, poll_timeout)) {
 	case -1:
 		perror("poll");
-		return 1;
+		err = 1;
+		goto out;
 	case 0:
 		fprintf(stderr, "%s: timed out\n", __func__);
-		close(listensock);
-		return 2;
+		err = 2;
+		goto out;
 	}
 
 	salen = sizeof(ss);
 	remotesock = accept(listensock, (struct sockaddr *)&ss, &salen);
 	if (remotesock >= 0) {
-		maybe_close(listensock);
+		closed = maybe_close(listensock);
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
@@ -1374,7 +1380,8 @@ int main_loop_s(int listensock)
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
 	} else {
 		perror("accept");
-		return 1;
+		err = 1;
+		goto out;
 	}
 
 	if (cfg_input)
@@ -1383,6 +1390,9 @@ int main_loop_s(int listensock)
 	if (!err && --cfg_repeat > 0)
 		goto again;
 
+out:
+	if (!closed)
+		close(listensock);
 	return err;
 }
 
-- 
2.53.0


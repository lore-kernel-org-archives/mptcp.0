Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0B37E5F0
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188306; cv=none; b=uAvkjkRIlLZjQXF/P6nohmaAs7NsrBuDFl38AMqeXdfm0gjDnJK6PXoiMjLCsb6pl7GdcMUyuE8VtRHzK3GBNFscpoKwDK6UTAzfbqCAar0PPpXzSqU3V0FMN7IrOQGofPXhJlxNGv3YqSUCUuLMaaB7FbibvNJ1Jo3cQJeSPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188306; c=relaxed/simple;
	bh=ArGaO6Nd0VCgzOhNyf5ODXZjnVVDgCK/gL3OWJSwYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0hNwIvDdvjgapXyzv9H8qNQGp70IvZJttq2/f91CeaDVI7mAOnJKfXIbi73BKtQPFz/P0eI/HGzpOIowxTMr/4n6tdMhNg6o/AZYSIH0VHocG0P7T6u9m+glRI38ZYlcsgJi8vS0GbVWTMgaF6w4Q2MRz8zkcUOD+gjgtRGZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D556b6Ah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D556b6Ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EAE1F00A3A;
	Thu, 16 Jul 2026 07:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188299;
	bh=peGeavKcX289X/VdRJvGIygJtG+sqaS8k9rKgQ96W7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D556b6AhRsrYKz92Wz/zeEX69OtGYMhz08lQC32yL7+Zkl3EXR7KVaWDfWK85aotE
	 Q5QswWcBg4EEV4H2cOh4uMmP3ZpOQwV0MjEB8Cujp4tsb0aC6MWcPUFEbGxDtm2kCs
	 ImyfVoNuqRSsvdHepL3NlDelwu+ip8OaeoFO8BD/ktyD64lGbvCFbnofCN7jyeH94e
	 UqXooNN7tUtuf/zek5P1VALslwImOZzR4zharLvZ1u1NqDFVKrIEpcs0WgqvSC7Vj9
	 1yX00dIni7JuM4gxhlE3CuLjcZoQTmEYpnY9kMz/vxRcTgR3M+lo6ak7kDeyqL28kR
	 eOM/kTZ7PeYRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 10/10] selftests: mptcp: connect: close listensock deterministically
Date: Thu, 16 Jul 2026 15:50:49 +0800
Message-ID: <da3cedeb4a318a50c81dc5522bcc335234db3591.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
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
index 63eb6e4dd4a7..1394ecaf56d3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1340,12 +1340,15 @@ static void check_getpeername_connect(int fd)
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
@@ -1355,27 +1358,30 @@ int main_loop_s(int listensock)
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
 
@@ -1391,7 +1397,8 @@ int main_loop_s(int listensock)
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
 	} else {
 		perror("accept");
-		return 1;
+		err = 1;
+		goto out;
 	}
 
 	if (cfg_input)
@@ -1400,6 +1407,9 @@ int main_loop_s(int listensock)
 	if (!err && --cfg_repeat > 0)
 		goto again;
 
+out:
+	if (!closed)
+		close(listensock);
 	return err;
 }
 
-- 
2.53.0


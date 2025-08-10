Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11238FA3
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838205; cv=none; b=ARRPc2y/f6bIu0OmKQKAN6Y7VHiV7NapVI4YJrnOgE16C5hvcGSjUDW9nRjGbnWFOmFx4yIXxUeFOnkO61d4kGH//Yd4Nz7QQ2Cjpl1GipooGpgE6LhGLpZ3/Y3RUyYBqCjWitokGbjTMh83ouXzIMSRBB6QjvBb25D3Tqb9KrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838205; c=relaxed/simple;
	bh=IdP1/0uoCn7T2M0wHaYAVrCQE4QTUWCEl9HRoTR0gm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soZ6icQ8kap/aNEkn3tcFTPf46rtxOHWowzrThSzW8QB30iYqQtT4T+A6h02Bzej6qZewsERKBUVN8Xnkf//QbwfNF7+c4qpOie+ihpT6tHdl8tE6mqSnrTE51qQo4Lu0eaQ+wZ4WIx6wn3KZxSW4BGwI7jR5jiOBzOi2qgxIDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zop2drz4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zop2drz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808CDC4CEF6;
	Sun, 10 Aug 2025 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838205;
	bh=IdP1/0uoCn7T2M0wHaYAVrCQE4QTUWCEl9HRoTR0gm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zop2drz4sMd0kl3SCmu7ZLAYSFTtKHl/88s8LPxt8uTfiqfN2NSc/iwQeVaLFEECA
	 rkoLXVooqrTQj246Q5nkY7DZQWCPnmTKCMbB1fHaoyfjVVb4ZroxT8vWmn+ZudMNfM
	 xjzn6HvaVGhySxthnmxBV54Gf2URaDd6NbFPGusEoiFPXDDbzQqkAopLu6BLgwSFpn
	 sV/9WBU3E82jwjkJwd7zQZL8W4MKPCAjAmmnhOboaRNFnOZ6L2i4C12QQaLQYf71Kn
	 Q0kjpOhkJYN3wWc5MYi6wpEM3HCEtQs8nNlCFpNTgYLmBvNwR22pzgl81oe2shRQII
	 jLiRLhHQnr9RQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 7/8] selftests: mptcp: sockopt: handle MD5 in connection processing
Date: Sun, 10 Aug 2025 23:02:26 +0800
Message-ID: <32204198e538e6d0cf978d459351e498ade0be21.1754837808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754837808.git.tanggeliang@kylinos.cn>
References: <cover.1754837808.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Adjust connection handling to accommodate MD5-enabled connections:
1. Skip getsockopt checks during MD5 tests
2. Relax rcv_delta validation for MD5 connections
3. Add proper conditional checks for MD5 test scenarios

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 72c1f6016e97..6a9240b01ea7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -648,6 +648,9 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
+	if (md5)
+		return;
+
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
@@ -723,7 +726,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	if (s.mptcpi_rcv_delta)
+		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
@@ -868,7 +872,8 @@ static void process_one_client(int fd, int pipefd)
 		xerror("expected EOF, got %lu", ret3);
 
 	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+	if (s.mptcpi_rcv_delta &&
+	    s.mptcpi_rcv_delta != (uint64_t)ret + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
 
 	/* be nice when running on top of older kernel */
-- 
2.48.1


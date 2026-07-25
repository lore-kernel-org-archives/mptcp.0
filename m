Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254E2D238F
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983400; cv=none; b=NIjxKn06JNzHtXVAoMZXblyA5B9dO+1OO/MayriLwO/LXD21DXxi15+KuRuU997QZARmoxt7YxlaIYoOkmIg67BtnEWZrGi4zBcAHUyj1Mzh1cksiIT2ll4bo5O5NGzRBIovXIMrWgE8mGl3Qeny+0VA4i+BjCN03/wxwpRWTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983400; c=relaxed/simple;
	bh=26dU1/H3nL+dpsmK+TSFP0UedQ8jE3mvlFwMUZJ5n5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHDFLMpdfmuti0u3ZmwnXltLHiW6nP+vHmxKzAjxbFMfI12piJMIf1g+Yo/1wlKp3HVzvt+EBxiUQ5B737Qw88K/gO0j/uwPfPeIn7FWCDzoxYs+CMmCf2zcb3Ek7dqeyguXbgSr2ZIXJHj+ywyNEotYZNaShfxvkPsdT3Z6zXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+4nsd2L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+4nsd2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F931F000E9;
	Sat, 25 Jul 2026 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983399;
	bh=q4FVgup+LfyS08a5rb1ybF15EMps4hJeWwfT34m39E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+4nsd2LmG8D5y1W8K7Yb2u2TushzLDo1UtnhFxJyub2yKe+ULjIIoZlE28eHlKNy
	 sf5ZxNSY0CQwmA6kdfDUPHmMKpEPRnU69KqRSJ4cyl2vZsiFSX6wpwgPshcV0I17kG
	 zbJZakxId7ax5h9WgjXcMivyCNwCeM5zUvKkiuYtXHmyUaJP6pDpKALbkcgomj/wIt
	 Vbq1zGCNZJCXMdczV8bgLZzbnPXGI9g51urxTJO9dphF0Q9lKXfHfXVH8QCP/J6GCC
	 TegeOZbLgKn1UXcu6BzzrcmRtilcolQw42H9EhcRUONeicd5uyxzPQSPFusOgkD9f5
	 wsM07D/WsT2bQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 05/12] selftests: mptcp: sockopt: add is_mptcp_socket
Date: Sat, 25 Jul 2026 20:42:26 +0800
Message-ID: <1cabcccda429f38934b83a053c75f4f14340774f.1784981974.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784981974.git.tanggeliang@kylinos.cn>
References: <cover.1784981974.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a small is_mptcp_socket() helper that issues getsockopt(TCP_IS_MPTCP)
and returns whether the fd belongs to an MPTCP socket.

Use it to gate the MPTCP-specific assertions: skip do_getsockopts()
entirely for plain TCP sockets, and skip the mptcpi_rcv_delta checks in
connect_one_server()/process_one_client() when the socket is not an
MPTCP socket.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 9e1d84af5268..51e5e33d1db5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -557,8 +557,23 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 	assert(!memcmp(&sfinfo->addrs, &s->addrs, sizeof(struct mptcp_subflow_addrs)));
 }
 
+static int is_mptcp_socket(int fd)
+{
+	int is_mptcp = 0;
+	socklen_t optlen;
+
+	optlen = sizeof(is_mptcp);
+	if (getsockopt(fd, IPPROTO_TCP, TCP_IS_MPTCP, &is_mptcp, &optlen) == -1)
+		perror("TCP_IS_MPTCP");
+
+	return is_mptcp;
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
+	if (!is_mptcp_socket(fd))
+		return;
+
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
@@ -634,7 +649,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	if (is_mptcp_socket(fd))
+		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
@@ -683,8 +699,9 @@ static void process_one_client(int fd, int pipefd)
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-	check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
-			 (uint64_t)r + 1); /* +1 for FIN */
+	if (is_mptcp_socket(fd))
+		check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
+				 (uint64_t)r + 1); /* +1 for FIN */
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
-- 
2.53.0


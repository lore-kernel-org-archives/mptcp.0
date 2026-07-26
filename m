Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D2270552
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054629; cv=none; b=BQ6vZufkJhX3ZAUUdrhyC73GqbTcc8TAvl3AWE8kgLzCMIN9PD3eOo5d6uxsPwWaa2srIN/NHLHTDzfUKHOBfL8+siqX8Mw7XPwRH2EMom07wxMuLUpXmB6hUsFfc7LkRU3SlSQEQE9FcjTyKv+ezVlkOTTTOEY+p4D2cvzwoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054629; c=relaxed/simple;
	bh=Ib7XYkm0dMxHmtl0Aq2mTT2Tov+g7aMvwaMvHDvCs0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwNcrWmF9QojuPs2xiD9Tzxs26tl87VlX0+aXJ4OLVWYdapckQV6bWogNicM2885b2rcWPTva2xOZZMKoRWbJAgllWY1en85Fm5y4pFLvOiiT/1vzJ3wLg8WsHaMgcd6aLCs1+aUOxocj1oYAoK5hNRwW52vAkmtAr72iv0xnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoykBEYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoykBEYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3D91F00A3E;
	Sun, 26 Jul 2026 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054628;
	bh=81a85aiMFWA+HNBMxInHMwDsZ0pEY8T2+dr0W0x5GUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OoykBEYlymHJnR2O6HSBjBizbftZIJ6nU7iAwUej6/dzHTECTmfrtiub79zo7/pll
	 YUeLVQGaCSS+wfuAGkWYIe6prWewB7DvSr6/xlNGSiy2AgecCczXqDof/ecz1OF1RG
	 cYFm4OTWRrNTBm49EM3QKyRU1QYoiOeplrHE9bcBbxoA20wU8Zd0rm5m4qMK5wsKen
	 KsrPRmjBIbxXXE29/lppNT1zBAPCY9cAF70tQZKguUIfu88zU7VgEloKN7GdTyaE8t
	 dIfc6xH3Wsit38WK86WIds1c5E/S7frAvUTu5RH7yCGcayxtsDCudSQdlxRkbxsMYK
	 ozayF2upFassA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 05/12] selftests: mptcp: sockopt: add is_mptcp_socket helper
Date: Sun, 26 Jul 2026 16:30:10 +0800
Message-ID: <9eca715549e6b7622c02942055dfffde7a72b21c.1785054129.git.tanggeliang@kylinos.cn>
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

Add a small is_mptcp_socket() helper that issues getsockopt(TCP_IS_MPTCP)
and returns whether the fd belongs to an MPTCP socket.

Use it to gate the MPTCP-specific assertions: skip do_getsockopts()
entirely for plain TCP or fallback MPTCP sockets, and skip mptcpi_rcv_delta
checks in connect_one_server()/process_one_client() when the socket is not
an MPTCP socket.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 3a7fcef5aa54..7e3a28863cbf 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -557,8 +557,23 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 	assert(!memcmp(&sfinfo->addrs, &s->addrs, sizeof(struct mptcp_subflow_addrs)));
 }
 
+static int is_mptcp_socket(int fd)
+{
+	int is_mptcp = -1;
+	socklen_t optlen;
+
+	optlen = sizeof(is_mptcp);
+	if (getsockopt(fd, IPPROTO_TCP, TCP_IS_MPTCP, &is_mptcp, &optlen) == -1)
+		die_perror("getsockopt TCP_IS_MPTCP");
+
+	return is_mptcp;
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
+	if (is_mptcp_socket(fd) <= 0)
+		return;
+
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
@@ -634,7 +649,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	if (is_mptcp_socket(fd) > 0)
+		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
@@ -683,8 +699,9 @@ static void process_one_client(int fd, int pipefd)
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-	check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
-			 (uint64_t)r + 1); /* +1 for FIN */
+	if (is_mptcp_socket(fd) > 0)
+		check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
+				 (uint64_t)r + 1); /* +1 for FIN */
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
-- 
2.53.0


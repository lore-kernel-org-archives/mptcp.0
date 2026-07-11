Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48CF273D6D
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741481; cv=none; b=YcJZLAl4wotkYZ10micvqV8sV5EMrkhUTaxlaYMVZ07OUzQSz0j28uQEKUIUdLRgweozLe5HRdR+wss4cgQX3QSsgC3C4XatDgNV2bC7bTE1jj4bt+q13kcf9esqqPTSg3shrkZQfGjap8wXyn3/WDdDyRZygzNGkv7cORHcfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741481; c=relaxed/simple;
	bh=k03hOgfRBu3BZferhRwLFTzIi7p8xAZmK9y2pqgdWA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkjwBGY9IDXgnrnxJ/14qhgnwbnR5VhsmIlYLTTYUY9++wnUffIq8IH1enSdBUh3aES8GV8knWdzRG4+ksxMWaoojrHKQf/nHzy+HZzSTUP3qxe/ODuGurkcWZMTaxzo2nnR+vQwVd2Z/XlPKpbBKQff3BrjYQOUEsyR5tbr4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVVlfS30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVVlfS30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4531F000E9;
	Sat, 11 Jul 2026 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741479;
	bh=0uPEwC3BLErqkVZoqZHPUrhW59oHtTApJl9SuU71bOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVVlfS30dpLBx/Ai/YsgEG4lCLaDDXoQhT/ewhiifUNY1Rd/14Fp6zR20aBHVWkk4
	 J8MC3N1mFzewRmm0gzHmLBL8xU+/5h8fWWj+Soz/dwTRamcgZLJlEOn0HVwjQQ+IQf
	 p+gaGHfLipPnElx71PpHYQucY7iDGTuCnmTIa0Zos9l91BleQOx3cnW6we0L5Bysei
	 FxTw8MTOwRQH6fgW2MP+h3EsoKCOtjgRKuW1CMu1yIfX1QsvbA6mJgSPPKIDgeaS+5
	 3tATyGe2PkrsH3DC/N4cbel5EL9yzUjY3/Bea009ZZF51MGloAtWk+v7p/hwevsgu7
	 X0RvaYe3OQWHQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 08/14] selftests: mptcp: sockopt: pass echo length over unixfd
Date: Sat, 11 Jul 2026 11:43:36 +0800
Message-ID: <da9f50c1a20e3876bed8b16e38a337a954ef91ce.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Pass 'len' from the client to the server over the unixfd control channel so
that the client knows the server's payload size in advance for the FIONREAD
loop and TCP_CM_INQ validation in subsequent patches.

Also keep the unixfd open for the second write by moving 'close(unixfd)' to
the end of connect_one_server().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 96259f81240a..181eae9de136 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -624,10 +624,12 @@ static void connect_one_server(int fd, int unixfd)
 	/* un-block server */
 	ret = read(unixfd, buf2, 4);
 	assert(ret == 4);
-	close(unixfd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
+	ret = write(unixfd, &len, sizeof(len));
+	assert(ret == (ssize_t)sizeof(len));
+
 	ret = write(fd, buf, len);
 	if (ret < 0)
 		die_perror("write");
@@ -665,12 +667,14 @@ static void connect_one_server(int fd, int unixfd)
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
+	close(unixfd);
 }
 
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, r, w;
 	struct so_state s;
+	size_t expect_len;
 	char buf[4096];
 
 	memset(&s, 0, sizeof(s));
@@ -679,6 +683,12 @@ static void process_one_client(int fd, int unixfd)
 	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
+	ret = read(unixfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	if (expect_len > sizeof(buf))
+		xerror("expect len %zu exceeds buffer size", expect_len);
+
 	ret = read(fd, buf, sizeof(buf));
 	if (ret < 0)
 		die_perror("read");
-- 
2.53.0


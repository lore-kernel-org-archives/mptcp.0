Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E678527703
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054626; cv=none; b=uyZUeOzPdJw99FMEnVdbUALgjWnE6AGlmNR4kyloAU9ypuER1Bmk+WjtHEGln+pArPVMLOlVpqgLaAJqXlZQnJq9afN/aWFZ8oFzFUiJhjByvoXk9/xFzzjj2u6Fvt3EQ9EsfOMEmaJhXZ/4VT4hFI4tymUnDgKkIlPYn+Qmz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054626; c=relaxed/simple;
	bh=+7WgKNSlrugYDiZ5+80t0H5Hlr3KXOlbLNCsPwqHfYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k88uI75i1fUJfsmfDiWaW0u7ojFpCTHXMdFDxlycPVtY2PvfVPaO5bUvkhU2nB+gIFInC0he05dmwp28Yq02ZT1Nk+e/q0p5Zpg1rX8KEEJ3hM2MduggIYywwe/EVVneJdIFxWPvMGrRlOOXDbAcp71Eci1ZW96KV0v8G3evSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9W8wL4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9W8wL4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3101F00A3A;
	Sun, 26 Jul 2026 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054624;
	bh=xLhJCXWMpWarH0jIkywBa5ypIEKygvKthsKGETUyyZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N9W8wL4xb8ys4YFokh2IXueW9ZRlI9SywWldm7N3KWtZ/SZxE4WUlRKc1w0yAXWIS
	 k8mW1yeRfc+kjADOXw4rWvlO+h3BJYf2t4ItQMg7736gKO4oU9jogyLgkdiOlwugza
	 01UWruU086ljAWyMO2jMWZ9jeQJVQ1DGTwauNzH20PKAi/hqm/vweZ+caMzUJP7QHy
	 EcwNXKOzITJ+DgSTcMrUfPcxruyljq8y9DnAoGDckJt3nonBxUSASCk5+V3Iz+IgvH
	 ycdsD5zuYd9Bc3I6WPLAONftYfW/JaZ2fZAsjyy6D7mPujrBHhBz8fmsrkJqNbQfR7
	 tl75GhmCJs3lA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 02/12] selftests: mptcp: sockopt: use exact length in connect_one_server
Date: Sun, 26 Jul 2026 16:30:07 +0800
Message-ID: <d873589eda8f425a1bcc1aa4603eb01ade47ea99.1785054129.git.tanggeliang@kylinos.cn>
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

Use the exact remaining length ('len - total') when reading the echoed data
from the socket, instead of the full buffer size.

This silences a false positive -Wstringop-overflow warning from GCC, as the
compiler can now prove that the destination buffer is large enough for the
specified read size.

connect_one_server() passes per-chunk 'ret' to do_getsockopts() instead of
cumulative 'total', causing mismatches when the echo is fragmented. Fix by
passing 'total' to match the semantics used in process_one_client().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 6c3d896d4a1b..469384823dc6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -609,7 +609,7 @@ static void connect_one_server(int fd, int pipefd)
 
 	total = 0;
 	do {
-		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		ret = read(fd, buf2 + total, len - total);
 		if (ret < 0)
 			die_perror("read");
 		if (ret == 0) {
@@ -629,7 +629,7 @@ static void connect_one_server(int fd, int pipefd)
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta <= total);
 
-	do_getsockopts(&s, fd, ret, ret);
+	do_getsockopts(&s, fd, total, total);
 
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
-- 
2.53.0


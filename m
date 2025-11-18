Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB119ABD8
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438526; cv=none; b=dUllG/fzOdw50Y9jcM34zViu2HaWiLibom30dSd2u5iPF/Qm6ISp7AJ6Q/RKvknboO0c6eZi/M9+bp1j0GrOnihchfrbqSEIkOoGGyDZNfuunBIpwonUPHLlhxQzwkMUvUkH7ciEvgY5lFhXBp/sqv/1+eVvcVrgHv6dgYDu2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438526; c=relaxed/simple;
	bh=NMrKwUzuSHwymPMcdQe3r5gTkA0dPPZWkr4RVkP0Sdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ27gkdqttLh3aTHtzwWqLLURfUgnqQRBiloEYlWKLYb3Y9jXC+3UFr/w3KSb3fW0HJq/tNJDdgdJYDCnbqG6hqXsFg5QNm563olTsC8WOSgwmBHfaCT0JYRT6qfJyup8dVvkkTRi/Bm/IH1rg1ud7fxl62d63cMCXWIBErYwxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqy/Kzeu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqy/Kzeu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0165C19421;
	Tue, 18 Nov 2025 04:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438525;
	bh=NMrKwUzuSHwymPMcdQe3r5gTkA0dPPZWkr4RVkP0Sdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqy/KzeuRisaiIfI0I6BBadPgQkP1xMQn/d+3yFdA0zkJ7KFHTJWjU/ogEiyvKizT
	 91PL/NbWqiXan+Ytt+1d5rPVu+P0ULaO2B94rtbaw5HQAY/4agStwsfED4iI59Aksn
	 z27c/m2T6Rxaw08LtZ5V+BZ8olCYpCqJf93la6ymFUiOKE8B9WQlcrNFSkcjCCtLeY
	 5F3pL+KJtI8Xzk6nHZiJZPsJIzWN1/lnpWnYYQWOV2JtQ2B/wly2S3rfJfTrTiiFZ1
	 0QvO77F8yfJMycjyqnfmXUic+G007SPNBuEk2YAE7VI2T01X6FkPImmNo+QgOBQguQ
	 zxSKxbjMGRmYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 09/10] selftests: mptcp: connect: fix uninitialized variable warning
Date: Tue, 18 Nov 2025 12:01:30 +0800
Message-ID: <59284f02f42b31dbb2999eea2fbbeb1c2f9b4225.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Initialize 'peer' addrinfo pointer to NULL in main_loop() to resolve
compiler warning about potential use of uninitialized variable when
handling repeated connection attempts.

  CC       mptcp_connect
mptcp_connect.c: In function 'main_loop':
mptcp_connect.c:1415:37: warning: 'peer' may be used uninitialized [-Wmaybe-uninitialized]
 1415 |                 if (connect(fd, peer->ai_addr, peer->ai_addrlen))
      |                                 ~~~~^~~~~~~~~
mptcp_connect.c:1368:26: note: 'peer' was declared here
 1368 |         struct addrinfo *peer;
      |                          ^~~~

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index e43874610297..bd46639edc92 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1365,7 +1365,7 @@ void xdisconnect(int fd)
 int main_loop(void)
 {
 	int fd = 0, ret, fd_in = 0;
-	struct addrinfo *peer;
+	struct addrinfo *peer = NULL;
 	struct wstate winfo;
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {
@@ -1405,7 +1405,7 @@ int main_loop(void)
 
 	if (cfg_truncate > 0) {
 		shutdown(fd, SHUT_WR);
-	} else if (--cfg_repeat > 0) {
+	} else if (--cfg_repeat > 0 && peer) {
 		xdisconnect(fd);
 
 		/* the socket could be unblocking at this point, we need the
-- 
2.51.0


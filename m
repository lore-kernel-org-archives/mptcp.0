Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBD2AD00
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355614; cv=none; b=kR3wzd5DIxFuPuQJfVLw7HID4jnzYM1AUlcB0dJLulYD7bev6msiceKsLyawPfwJdOvG5DpwIrPDwXbtaRUVSTn/DgA7xftAZV6qHdZKbLI4PDJel6gjc9ysn3Kg7vqX+4Sm3gys1Xy0S4gsDlEUOeAKaQYlcXa6knnKC7Ny9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355614; c=relaxed/simple;
	bh=3hDwuTR8xG9ubpfQJR1LO51dqkUBO/bvUg4ZmISjIXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/2eWzFj5xcx2CQQCjyEgtk76LBMksoFZUabqPv5y9hjeJVKfEaf0h7DQdCibMYtaH3aiQsUTdv7AbQhfWRakb+rFRNKeoa4FK+X0MC5sbMZ6Wg4GouiQf54e2LYaSJyEsV1uyPPNYXEqyIdewlO5fqFaqHvObzT52XFa3zTQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbYvxzQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbYvxzQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19B8C4CEEA;
	Wed, 19 Mar 2025 03:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742355613;
	bh=3hDwuTR8xG9ubpfQJR1LO51dqkUBO/bvUg4ZmISjIXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbYvxzQ4UmL3cgivdoPWmGJJJ62baJhgg7311GcrvvdY0GgV8FU8ohc9WosnUuLO/
	 ckAU3vGlk93iE5diVnjiH4sQvqXBkbADTCszXvHwt4MT+uYCoSGEPH9o+N4dHYq3fq
	 bPHAdolT0b26lho2PPhZSk7tYTE4z/+ZL4R18aSd5aV284WT3xXvR4PfstS7f2hbSj
	 BlUUY9D67mWLcKkL+L27pt2mz5Hd6YtTpleSjgqrCIqbuprn+kyOJLu9ok6MTuowgw
	 gwAU4fIm/OWNALetFu8DgSPIsxATxWpv6c795ggWkHPKFpkOH2npM47kh/kclC0luA
	 sB37skXd+U7EA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Cong Liu <liucong2@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] selftests: mptcp: open cfg_input once in main_loop
Date: Wed, 19 Mar 2025 11:39:55 +0800
Message-ID: <58fcd84cd7eae33eb7ff2d87415109c5324a0c4d.1742355162.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742355162.git.tanggeliang@kylinos.cn>
References: <cover.1742355162.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

cfg_input is opened twice regardless of whether cfg_sockopt_types.mptfo
is configured. This can be simplified to open it once at the beginning
of main_loop() and close it at the end, because no need to repeatedly
open and close cfg_input during cfg_repeat.

Co-developed-by: Cong Liu <liucong2@kylinos.cn>
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 893dc36b12f6..5301062a5f3b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1268,7 +1268,7 @@ int main_loop(void)
 	struct addrinfo *peer;
 	struct wstate winfo;
 
-	if (cfg_input && cfg_sockopt_types.mptfo) {
+	if (cfg_input) {
 		fd_in = open(cfg_input, O_RDONLY);
 		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
@@ -1291,12 +1291,6 @@ int main_loop(void)
 	if (cfg_cmsg_types.cmsg_enabled)
 		apply_cmsg_types(fd, &cfg_cmsg_types);
 
-	if (cfg_input && !cfg_sockopt_types.mptfo) {
-		fd_in = open(cfg_input, O_RDONLY);
-		if (fd_in < 0)
-			xerror("can't open %s:%d", cfg_input, errno);
-	}
-
 	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
 	if (ret)
 		return ret;
@@ -1312,14 +1306,14 @@ int main_loop(void)
 		set_nonblock(fd, false);
 		if (connect(fd, peer->ai_addr, peer->ai_addrlen))
 			xerror("can't reconnect: %d", errno);
-		if (cfg_input)
-			close(fd_in);
 		memset(&winfo, 0, sizeof(winfo));
 		goto again;
 	} else {
 		close(fd);
 	}
 
+	if (cfg_input)
+		close(fd_in);
 	return 0;
 }
 
-- 
2.43.0


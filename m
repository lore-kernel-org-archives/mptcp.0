Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2238FA3
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838198; cv=none; b=ZcE3XyNK+Cj9B0isa2IE2521R9KkikWKgXRmENW9KW3otKmOTjQVSJQRI7mNgXFunlDHI1HMOIQitMtAA+SGDLiCTK1Ae7YGB8IiAhvi7oUIgR/v3tt7q2++TO6ZsBaOq5QPZ8UhjuV+y+oTHDWm0acB0UXe1+kF1foCzVuz8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838198; c=relaxed/simple;
	bh=2RWkibFRv4k7ArkkNp+t5JBWEgPp3HmLYO2YSR+MhIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6DNbNWaF0Jy1fzwbhCFqfQIrb9gIDJTjyEU84juc3wjuEeJhmkgZxExhwNb0VdQi4MbTe+UsrjbB+ErUu2MDh/fRLRwbmgXqQJAX4fJe30eKlOlFbR9hLjuQA1205DKwSbayq+qLLSBAJlM77M+CbvtZcNgArpK0FnWK1wjkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwhyPfK8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwhyPfK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74058C4CEF6;
	Sun, 10 Aug 2025 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838198;
	bh=2RWkibFRv4k7ArkkNp+t5JBWEgPp3HmLYO2YSR+MhIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwhyPfK8/7x+iO5CoKU56LUfUxHD18D6WVllPrd08LgaOMVTOKH/rdYVJ4C5D1g+B
	 yDXS7z105be/WvvpkI+mTDpk1Q21WT85zs4hZVdOKHk5TP20slmUypDN4v6/xFe8fB
	 HX7630BM71AG5HBPCCou7dNupkreFAQ1pCUMXuB6YwTqEcvXbWpafImWKr9ECKcfIM
	 cWDfvlcWEFXPpkpyjzxJMUj9YWkOg5utt4+SiboZRobKshzKR9iRpkt5AQ0EwExHGX
	 jUhob9WSwd+sXb3S+iaV7uOMISTUKHPfZPTf9YebyeSTPCXKzx2cTBy7mYIAN/ZzGQ
	 koubd+hqR/1Rw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/8] selftests: mptcp: sockopt: set REUSEADDR opt helper
Date: Sun, 10 Aug 2025 23:02:22 +0800
Message-ID: <ba6269ad9d74a7bdcb78503db0f24588003731d2.1754837808.git.tanggeliang@kylinos.cn>
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

Add a helper do_setsockopt_reuseaddr() to set the SO_REUSEADDR socket
option. This improves code readability and reusability.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 063ecdafb336..c27a2f3ea274 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -188,6 +188,15 @@ static void xgetaddrinfo(const char *node, const char *service,
 	}
 }
 
+static void do_setsockopt_reuseaddr(int fd)
+{
+	int one = 1;
+
+	if (-1 == setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one,
+			     sizeof(one)))
+		perror("setsockopt(SO_REUSEADDR)");
+}
+
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
@@ -201,7 +210,6 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	hints.ai_family = pf;
 
 	struct addrinfo *a, *addr;
-	int one = 1;
 
 	xgetaddrinfo(listenaddr, port, &hints, &addr);
 	hints.ai_family = pf;
@@ -211,9 +219,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		if (sock < 0)
 			continue;
 
-		if (-1 == setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,
-				     sizeof(one)))
-			perror("setsockopt");
+		do_setsockopt_reuseaddr(sock);
 
 		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
-- 
2.48.1


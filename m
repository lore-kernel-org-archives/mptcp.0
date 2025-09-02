Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466A25394A
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777211; cv=none; b=e1GLADpQMT8fTIopt8VvYbYIrDlpykRS6As14XE4b+g0EEgZVrI0JChOHDQsLWJrFtCykTFQ4EmJH9d2vINJoH1onANmeusQnHB/XsO038Cyan1vXv4kiR2UKU5Rz48uonFuObUHfE3ziosTXXpY3F3Vc8K4HOPKjTiRKw8RE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777211; c=relaxed/simple;
	bh=FxynJ4BmPAKBYdhzubMkFbBK8XiDDcobTgN6lZ2/MGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtGm3/Ki2RaG0UyEnArwCNYETT6ply5iCZCxP7DUN8Iveyw/0qPQhn/M53xYiASBGLNZJ374FuXSvE5bq/g5g+CXLIu8QdpeRYHKcEJFnTFuESUmz2zgWHyL/yzp1PDSpi/SA2SfldTkUFUD3ZeVAmy/Jxb3fp/0Mix4jLFLsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkNtiS3i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkNtiS3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E37C4CEF4;
	Tue,  2 Sep 2025 01:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756777210;
	bh=FxynJ4BmPAKBYdhzubMkFbBK8XiDDcobTgN6lZ2/MGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkNtiS3iYPiz+GQUO69i/mVbNqWKmuEcLkhyzB6NqkTAqsJIvD0gxoj+pROZ/VN2w
	 dct1PzVqqAiivpgNUmLVlttfVZjQ6+nRanWuG2yI0oJYPhjcehd5Zb+D9rNMhN28s0
	 /bInsDhxc4rSR/bZYFez6r9vNUPEWPsUD9hyi7hdAxbaNIJ8PmUIj3zmQggFOLtJn4
	 JuWZS1DyjnQxJaylthQiiZ7gFIirM6PnvRnwF6ivFqUCMx9OFx0EXrf6Iyl+9nB4No
	 fepTIAzLgk5peRGuM8bTnHnCgPvJHhiJQody3GMTZqLQ25+KCG7V4HLzOdUNzJgq+d
	 hbJe+5UQpqbWg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 1/3] selftests: mptcp: close server file descriptor
Date: Tue,  2 Sep 2025 09:38:34 +0800
Message-ID: <8e614206c3e57d7d87e983f8f8c157387052a595.1756776801.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756776801.git.tanggeliang@kylinos.cn>
References: <cover.1756776801.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The server file descriptor ('fd') is opened in server() but never closed.
While accepted connections are properly closed in process_one_client(),
the main listening socket remains open, causing a resource leak.

This patch ensures the server fd is properly closed after processing
clients, bringing the sockopt and inq test cases in line with proper
resource cleanup practices.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Fixes: b51880568f20 ("selftests: mptcp: add inq test case")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 1 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index f3bcaa48df8f..40f2a1b24763 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -502,6 +502,7 @@ static int server(int unixfd)
 
 	process_one_client(r, unixfd);
 
+	close(fd);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e934dd26a59d..b44b6c9b0550 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -722,6 +722,7 @@ static int server(int pipefd)
 
 	process_one_client(r, pipefd);
 
+	close(fd);
 	return 0;
 }
 
-- 
2.48.1


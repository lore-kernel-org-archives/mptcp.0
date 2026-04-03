Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81C2248A5
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227980; cv=none; b=F20yxvSiPnuzz9VZERFI2+uRAsT7yLuWG9adeHL61dg6l5TFp4wYzfG+etjG7JRYkCotAswfbLOoYBQPNNURSeuSsK1+tb7pS/wlp+wVqrUP2m5WmXey/hfZpcgeuhjHzIdNJfEz/bf9KHPXRAe/pmIl1VtnsMYdblAHUcSO/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227980; c=relaxed/simple;
	bh=R5QTa+UMnwEotML4wVygilpV5Ox1rdyBp9tddMx9YDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF32unbZ/SXKfvC+29nMZI5BbCwmFZD37NGJN34Q+PmrboevGpQbaKZzEm9B5XAjJNuV1S9+85EFCH/WzpqxiOqzUEsTGomwBiwDbMk8hwtMVTNN/+AgmG0bRLPsf5/xGBLBCJDqTVq4K5BY/q9yExnidrJZHTY+4oQho+1iz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx2r+ITT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx2r+ITT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADBBC19421;
	Fri,  3 Apr 2026 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227980;
	bh=R5QTa+UMnwEotML4wVygilpV5Ox1rdyBp9tddMx9YDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mx2r+ITTcWWN8IQjuGy09rcMCTmD1sqj5nHs/Y6GU3Tjejjtn8zQAirte+MDHR6BH
	 dGtjmMMn4jMcdzHk0JkadAgWRYbZyW0YFB3CdIe4dAEjb6YVeVt/+/MMzQqysQNE9u
	 mYTxXnLrnDneZYpFCnZEsrzMVJOmCOAT0NJHBGHIyTJO3n8E47rQKz7HZpODkIK4pQ
	 sjEmT8yb+7QlKcpbpHzB9LDkQHGy0t5WUhRj/WnBlLehxdM50rGKIS8pWOPjZo4E5C
	 Hz3hcx1TMrqGH1N6A6UdMlcF1Am4iQdPJb4jg4bH0zRqGwWIR6TF/IT+bS9U6lUY4M
	 6lMRdpYs30OUw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 10/16] selftests: mptcp: connect: use espintcp for ulp test
Date: Fri,  3 Apr 2026 22:51:28 +0800
Message-ID: <d313ac5ffd14b1f438d67ac88cc85a841a80cac8.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
name, "espintcp", is set instead in this patch.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..0d4a944c4269 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -289,7 +289,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret != -1)
 			X("setsockopt");
 	}
-- 
2.51.0


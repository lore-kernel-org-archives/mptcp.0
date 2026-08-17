Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3292472AF
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939043; cv=none; b=Oi9hI+e3ghHKilIKK91wJ16qyIgHQkL4wJQncFoCnCKIsy3tYQGLvXfhZaX3Sd+5Szr2Wtkp3a1bm4Pk6XRkx+rt03FXxnX6XyRhkpSSi8o40gZ+pulgr6ClVlOzD0VjYPQ8P5QnzX9dJkZKEg9So8u7C7wrlrapHqMdQFkxJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939043; c=relaxed/simple;
	bh=Lo/luMwGvhUXzB0lM5mpPl2mhqNVI54+T8/eMm3zDA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIAnxlwU7V5AMyugC35TYvmCI7YbNKRGv+w46sM57uxpxlLMWRnKS7DdaIvLuc+SUpo+bysAJ1HwTk5T2X8Gj6v+vWyr07MT205P1tJr7eZihbXbdYrVyQqzb9A8m8S6eDFe2ehGgrGO7hamvTh84cMQx84md8CUbRlH3+a5XLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDX92n+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDX92n+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F23F1F000E9;
	Mon, 17 Aug 2026 03:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786939041;
	bh=vO8H1WhN7OHYWalQwbdJxYUxmWafoBJbqxlYf63qE8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDX92n+1fkfQM98hijyrR2qvTqr3T6F303Wd+Ro9vQM/FhP9gJMzOwUwfZ7pfecPV
	 py9sfupRAVY/4FWqLw3dMyCDG+G1gT3ztYR1KCQh9JzoPNr6UKTcVyClxNVZqjpmip
	 GTlXAW1JgPSxOaDBax/biJazwn47kZG6rIh/43S7vesdwqK+kn89BGn5c2QXhV8TtF
	 BuGknIlQ0BQUw9pKlxPJqSnvRJYz5YHLeKJtagEvDLrhM1RpkC0xLOv2Wyjp75+ODn
	 X9epadpgPpq14hnHCostPCmEuEtcIozI2FkAMCa+rUdhotHTaQ8tlZ7Sgui1dkxVDT
	 74ippNEcZ2o0A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 1/6] mptcp: handle TCP_MAXSEG getsockopt in common case
Date: Mon, 17 Aug 2026 11:57:08 +0800
Message-ID: <fbf34cdd5aa97b93248b37df2c5ca541d1b23af6.1786938892.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786938892.git.tanggeliang@kylinos.cn>
References: <cover.1786938892.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Move TCP_MAXSEG from a tail-clause into the common case alongside other
"first subflow only" options (TCP_FASTOPEN_*), making the dispatch logic
more uniform.

No behavioural change.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80c..2c1eaf66202a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1499,6 +1499,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
+	case TCP_MAXSEG:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
@@ -1523,9 +1524,6 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
-	case TCP_MAXSEG:
-		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
-						      optval, optlen);
 	}
 	return -EOPNOTSUPP;
 }
-- 
2.53.0


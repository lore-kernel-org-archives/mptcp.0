Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8429210F59
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754136113; cv=none; b=qS8o0bWWI3ScazJPUN1Nzav4dEASjxwDoNOKYGVFaCn/QvRzcGOIt5ujGNnWjMqlZTI5dwxDAwAeI6iMqeX/6WUIjI52GZq0xpvs01+2MLnNTjdBtRsiBhycPi8EQjnUtcMNNeHPeDG1IMLn8w54LDmcRSvTJ6lZp2KORGi7viw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754136113; c=relaxed/simple;
	bh=KQ9GNW1jz9Jsjdw9OHviR3jdnQ+R1po+uLn95QKvQUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcVSpGEg7GOU0UNnMlAWlR5hpEvxUgKA1PIsSgVgoOtZ1WgJoKZCV+fIovlHojOQtXLsZnARw+U7eawNb/GeRgSNk92LRM0PCu9RqBKASgnEXGqOLgR7c7ehf6roGxLOU4nk9HPK05UzT+olsYmS9/ejfnIuA9rpzqdmLW+BDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GagGBaYL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GagGBaYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12EEC4CEF7;
	Sat,  2 Aug 2025 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754136113;
	bh=KQ9GNW1jz9Jsjdw9OHviR3jdnQ+R1po+uLn95QKvQUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GagGBaYLoriRgTxYFuLt/w6trLJkiWjSfe9jrPiLrz3MOfzPnrjmm2cKi1QEJ65fj
	 15wDy257CZyc2qe/UPjcqtmC4Xg0QUYgsqLfaH7TNbMF3VHDBcMTEfSa4PNi4RMn9L
	 wPtatdn0d4ss9RV5WWAcl7P9eWnXRN0OZivPjSlrytrKs4Oa8wktF0Fnfdu1eLSjHy
	 85CKUg/ps0q/OS8qN0XMNT08S+Y4p6/QaoR7g8GeanYDUFiDORR3Rseka/eqq5vyjd
	 RBfKhxMfiIQWGbskIYMDzZCsJx3eFcIpO1St4u6wQLn8yBv9yzkMISaqvx8pngeOpT
	 UaPeaM1AGbQDg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/2] mptcp: Handle TCP_MAXSEG getsockopt in common case
Date: Sat,  2 Aug 2025 20:01:44 +0800
Message-ID: <d7fdf11c2e8291af590bbd74c77e6547dd8db018.1754135958.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754135958.git.tanggeliang@kylinos.cn>
References: <cover.1754135958.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch simplifies MPTCP's TCP_MAXSEG getsockopt handling by moving it
to the common case where other TCP options are processed. Previously it
was handled separately after the main switch statement.

The change:

 - Moves TCP_MAXSEG case into the main switch block
 - Removes redundant separate handling
 - Maintains identical functionality

This improves code consistency without altering behavior.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2c267aff95be..b264185b810d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1404,6 +1404,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
+	case TCP_MAXSEG:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
@@ -1428,9 +1429,6 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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
2.48.1


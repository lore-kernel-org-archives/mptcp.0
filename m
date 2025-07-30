Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60561F1921
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860176; cv=none; b=fNEGuTGjm/wt/3o5B9yW/Pm13iLey/K+uH/UupPY57a4feBTNvmzKysJ2AdUdTOjiz7G79ZgFGc+Ep+tg2TcJ50SOCe/fm4l3SkZGM4eSGbdlGHAfnH9lySh5/kf/rg2tXa/vMOT+wbTBvIkl5pnseN3GeVQ9TYwOAyaPgdQG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860176; c=relaxed/simple;
	bh=KQ9GNW1jz9Jsjdw9OHviR3jdnQ+R1po+uLn95QKvQUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJvUpQd2YKjQS5sYPk+Gjuon/JWpUPm3HinuA8c4OjVk0ZhmNIsHR1MYeb80JBu9pgZPgmtTLHcq3Kmf25dBe9u5MNoP0EHvLtMwvkNxfUhj5bvLD/dGEYgeJCdEKY17GQtmUh2ugPeonXgg0Ovp+fGdhhdyMap1fzd/H0ypp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBqhYTAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBqhYTAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F280EC4CEF5;
	Wed, 30 Jul 2025 07:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753860175;
	bh=KQ9GNW1jz9Jsjdw9OHviR3jdnQ+R1po+uLn95QKvQUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBqhYTAAZ1PwSOWQ9AcNGoAaDVJB4+ZPQ3TEAfpzQ8DFg6bwTzuZmPs0wP36tvM2d
	 bPTmKfLdfLr4k5KKAV1gkP/uDNPbs3mRGVL6craLR6Olt6tn00ykdQ44pPzUzb5mCU
	 mnatUm3cx8vyVUL+gOsI3AnWtstQ/JzncAvlM13fNGSsHicNqI8yI3NAKaDaqZ7qYf
	 1Xgh+DZa6qRZl812b3vKAPqCQCLzniiCSlfwQTMm9/Yz/NTVNmR92uhj2hTKpVCcpX
	 Ica2aGsGaMo6ALR0E5Z1+1oZWanBWv6vl2ykl+PbTlUrxRxlbdRA8WSJkdBq/zedZG
	 R5UMFhPjpnT4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] mptcp: Handle TCP_MAXSEG getsockopt in common case
Date: Wed, 30 Jul 2025 15:22:43 +0800
Message-ID: <059fe90b08b29763da2836a39d2dea8d04d0aa74.1753859907.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1753859907.git.tanggeliang@kylinos.cn>
References: <cover.1753859907.git.tanggeliang@kylinos.cn>
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


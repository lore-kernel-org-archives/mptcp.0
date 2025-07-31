Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98717323D
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946878; cv=none; b=NC3LbWxthU09P3zOTWTXK9Gz07TVgJRrZrSl+yr6JHieFpwUmRHwFXAoR61XXoXpOLfPSWi4PqAKo3dfA4BooFqKiURutVe18p1SmnyBqzXAqxE4Qz6lJhbgt6aNauZtz7Yug+0eU6OuFYbM3BkMASqf1A1DArBI9FJAKASVCqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946878; c=relaxed/simple;
	bh=KQ9GNW1jz9Jsjdw9OHviR3jdnQ+R1po+uLn95QKvQUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXR2hm2/0rLLdAsCerif15jybde+gyvVV5PiRM0PZKP4ufxRJgZbf7/wgTyFYBC+wA7EH7on7C28aKTraev/De8bFRxjhgsCFXYmu43mEujWfrqoB2i4iKEYOLLuNPE75JZdWQZ1WzMUXAhv6yG45dYPbt2RmSvNn11VmLnM+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki4ADnwG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki4ADnwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E379DC4CEF5;
	Thu, 31 Jul 2025 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753946878;
	bh=KQ9GNW1jz9Jsjdw9OHviR3jdnQ+R1po+uLn95QKvQUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ki4ADnwGo6mh5G6tc59WnMvOQe1tPjEmeekTtja1BwAdq7619roTuAg9Owv8jSGyd
	 1RcSa93nDBnvAIFG6G3aldXjlDgJ6vN3FtsPZ9iYK3d6sXC+Pb0O1L5JYleR9mO6su
	 rvxOgElLMEJz/9dQ0ji6xS3/uSd5HfRqmF+TCtiFTtCgZ3WzCif17PPdcwBqg0Ub2x
	 rb4VVGHFiEeRiO0a6lismcKK7EOjENS8+tAGklpjgOnokQhgtTz0w1RDjDnqQpe8p4
	 2l0tX40yP0Q0VFu+v1lPnG1eKQVdnMQT2c15RXUl54I9Ldf/Md7agdXX6w2Ubsby9Z
	 CvfIdL8+/1VPQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] mptcp: Handle TCP_MAXSEG getsockopt in common case
Date: Thu, 31 Jul 2025 15:27:47 +0800
Message-ID: <4cdaa38a5e61b57e2df63322fe73243e7a7a5145.1753946671.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1753946671.git.tanggeliang@kylinos.cn>
References: <cover.1753946671.git.tanggeliang@kylinos.cn>
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


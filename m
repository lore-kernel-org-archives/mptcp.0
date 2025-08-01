Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8019D8AC
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091785; cv=none; b=mUWgMnUf9nfUSeVOYp1cj8ZmIbhfmCb9VrRQGKtveyxxwtYGYHMkyTWrloNn/5aCTq8KcnRSz3bcldnVtf6TzhjqdcPBSnTDTzUjSO1TVvMByEUV9YnmvLgRTDq5tDdHRgXQ5EH44OxanwBLy76Yo/qz636S1oG7VTkmUkJszFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091785; c=relaxed/simple;
	bh=WyDc3Hj+h4HqhYBLDgWgq0Otxru1uuFf7/HiLr+jGR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU2sCwQzT5A1WBfKiFTp/y5ypf5l+RnDi1q8BZqge9INbmV4AFp/3dUL9yMJcRTvJkZXjyRp1fli+emLM8POt/IUsPJb+QZ6ZLi5cZkvP3Tgacd+q6vxje5JnGUgxJ9g/NmcH53J5/V1a5m9JuZMQi+/XTziwiRJL7e/tzJhfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjFLMjRD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjFLMjRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32661C4CEF6;
	Fri,  1 Aug 2025 23:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754091785;
	bh=WyDc3Hj+h4HqhYBLDgWgq0Otxru1uuFf7/HiLr+jGR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjFLMjRDQmRVSXP8qHCyM8G3l2FvcacSBKS0SHv8pZpsIkyDBChF/HkY+aa0CExaO
	 WHF9v5x+I+u25fbX9zpEJaKqSZnsCnqyWkp6crAF2QZ0N4vYj/nNT2QSJoCdTlgteY
	 AUvQklPP94u2s0GglwSihwRcfje1tjSZaGPf0gtBTk8eqVyTe23tA06hLELpqpa/K8
	 68r47NWjh1ehKhOHPK5ARRFZFdmpEiy48ABP3Kex11R8rNPzwTJ1g3LoT/b887QP3r
	 LVbPlhQSX79lYi56zkHPrE1HFvAgEBbc4iu7yEMRqZPNBTAd1+zfbz40MHKwrEOIBt
	 FCNUtTAhkRLww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/2] mptcp: Handle TCP_MAXSEG getsockopt in common case
Date: Sat,  2 Aug 2025 07:42:55 +0800
Message-ID: <c0cf9e143aea0199c4a1f44c11c1e4baa04e335c.1754091681.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754091681.git.tanggeliang@kylinos.cn>
References: <cover.1754091681.git.tanggeliang@kylinos.cn>
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
index f5213c4fa8e4..006849741813 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1433,6 +1433,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
+	case TCP_MAXSEG:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
@@ -1457,9 +1458,6 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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


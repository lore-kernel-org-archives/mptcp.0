Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850C38FA3
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838195; cv=none; b=rv7YAzQMrTf95bF5Q/QHA+7awEYYcM6j335u1w8foINfYU9Poqil/0BxT2EGPwlNkKWFcWb3cnbmGoVWYZ67evQbre/z9s/4RTzdnnQIiEv0IfISjZam3LJdzDriOHw/aNn18AQGKKWOirkSJiB2GPEkXQuP502E03cMzEg5B6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838195; c=relaxed/simple;
	bh=uiD4XFys9d2Id0VCvqIXBBmcmKtNR0mPaY0WLhq6BSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZtnwrvL3C67FNy86vDhzQOxd/OXLeGuiHEBC5XCf5bdtKLr1aXKQ8Thr1QZoFhqEkCB3heahQ3mSLaDTkjnWmm7fVN1s5rDnpKyzm7jS2arDpDRXhdKQT1o8BUc1SupVlMgpXCZlYgHC34c2K3z1tsM2Se1xEtBEvXY2tJ4jAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTiCHLbB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTiCHLbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B4CC4CEEB;
	Sun, 10 Aug 2025 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838194;
	bh=uiD4XFys9d2Id0VCvqIXBBmcmKtNR0mPaY0WLhq6BSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTiCHLbBNsdS83R5wecHGuRxTuzacm7r4rNNHgQU+SoAz6On2WwfDZ1pkleBGY3qw
	 OK2Itl9phwzghq6IFrrxK6RdtmQvGSa/GGvMed4Ex8293iHVHrOat1+Ljpnw0N+s3G
	 V9o2m6Q96jMgpPCRBvE2M80InTqFXdY2u3K/D3EciD+SUASex2TSZBEQOAO3jYeYkC
	 VQ0HECU+vOFb+/lravRzZGt62fz1sy738iBWn8EWkms5q6Z2e4d43nAH++TBwwpL0s
	 dQ7fREdTysU8SBeiURY47NKxCEek0Y16Ij9KzHWl5tpXAYlDX6GgeNO8Me+1txrsz7
	 t8IIIc40X5bKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 1/8] mptcp: handle TCP_MAXSEG getsockopt in common case
Date: Sun, 10 Aug 2025 23:02:20 +0800
Message-ID: <076bb01cfb7c2a13c2d34acc2f81b862a9386aaa.1754837808.git.tanggeliang@kylinos.cn>
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

This patch simplifies MPTCP's TCP_MAXSEG getsockopt handling by moving it
to the common case where other TCP options are processed. Previously it
was handled separately after the main switch statement.

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


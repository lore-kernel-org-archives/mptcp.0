Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18402FBDE6
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334979; cv=none; b=FGanaoOi8g43e+13E+s0Nv6D27x2buCA8z2dFOiRzBl0W7OCckvis2VLVQ448NsUfMV9/xAfNwp82qTrEJ1V8T41lFpYyzcEgfCQ66BUJZ1Gd+enVx0ja3lq35vCiVYff8ISQl5vgenKt/92HeA+On981NWxvmFCo7IxsKhNH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334979; c=relaxed/simple;
	bh=rjkpNJIyxvm1zJRfVSf4V4t5diTXhl+huq2nEip5Hp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFzkn6HX88MYeUNXRYjJE9ChpFEvb4hjMVPVd+dPhJt/W7Y3qPar8sZM8402xLgBxJ6Is+z4Z+B2qmV2t8uPxC9HrhLsoO/bPo8X3Ai0C0rx5sCbZgSeYba7y3LQrdOI/Q8WzXqVeJiQuaH3BExRbv++quPtmaWOuUwovvnIoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laZBwGGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laZBwGGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F15C4CEF8;
	Wed,  5 Nov 2025 09:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334979;
	bh=rjkpNJIyxvm1zJRfVSf4V4t5diTXhl+huq2nEip5Hp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laZBwGGN103QOhu09ZCBd4g32W+DkDeEWwG/h+5wGWooA5sGsoDugMjIq4JCmhGS3
	 Ke1L24oZhPkGhSdKHTVNL1ZqcRSgVzVMfjbTDKWd2JqxkCYGewfO9fSOZ+/Zt05BIu
	 00Sq2650GjMhh5+HhdhrX03XebX84Io/iLh/TVhvc+NYzcoHaLr4jJLqx9HCAbKZ3c
	 b7Xx5CKdm9MyY2fJoI+ST+r8k/WLUHCPUeKAtGdYxd18Ba7UopGdQ/no0Uq3fL9csO
	 Bv6+3xr1ZF4Nk9JtJVjnsG9BANRDbaYFuigyJ0YBSzMDBlvjWWWFc/OsnFPRozRXc/
	 HXOwQdPSsMA3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 2/7] mptcp: handle TCP_MAXSEG getsockopt in common case
Date: Wed,  5 Nov 2025 17:29:25 +0800
Message-ID: <5984338e785588a8dd4f79b3a1d9a815bcd72bae.1762334694.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762334694.git.tanggeliang@kylinos.cn>
References: <cover.1762334694.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Move TCP_MAXSEG getsockopt handling to the common switch statement
for consistency with other TCP options.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..e2d1b4b6b3b2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1408,6 +1408,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
+	case TCP_MAXSEG:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
@@ -1432,9 +1433,6 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259432DAFA9
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188297; cv=none; b=i34cXHtuiKap3OjJmbajEdpO7/GaoQpl0O9bRPTW1+ramYNG7OViRIDppLiA6qJPAXc7GFkBQlkN/Oh8DKOMnFSFw0fWXaLu20Oo6HhO14DZMDbj8ZbDcpWMTOjZJX2ybttlT6PxUEHvSphBgKd5Lo8kHVktRCD6FPLfvfu13JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188297; c=relaxed/simple;
	bh=h0KHbTdRLXfAQDlm+Mzn4sOSwJyxsp1fPSLu/6K0DEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwcGS+edsD36ipxZpEmfysq713TDof+hoAo/bNsPhN4HIYCCQeXn2suI0G67RgBmCaPkZ2Y8xB3Q746QdrK/2ot2x/Nnz6h7kFTrITHYpjYAxYFWiThhO9/ClNkulRK7afD+HFocBcopGSMtneijZI2rp1JmZ8tyJjFu12Pu0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiB3Rb49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiB3Rb49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC4C1F00A3A;
	Thu, 16 Jul 2026 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188295;
	bh=1aL2W8PM3bCKMiZfqkj5j62ROsq0aloJ4VBeqLorDFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IiB3Rb49senw6bTCgRsunEY2u4XdzS4gVt3AHZkZfkV5f4CyZdczHbTUHxPtW35AG
	 ROmM3yT1Ax7RBM8AfM/uiuDisKEbDRC8tm1+9xPqYfrJ0ts4GDP1Mft+ReXVu02c7i
	 c8bro76kB62iBXTTCH8H87ecOv6cRFNKXLmouj97Zn51U6+fxVw/JyC1+bb3rv7Llw
	 f0cCZAHwTisHyg6E1xZYGn/CdBFZ8vTQ2Jsj6xBXfZ38BN4P24LS4twGaH/r8fmKPx
	 dJW/nnsIhJJjZcbh02GRpLQX9ZnGNARNQl12A+FEyXV+ufYywNtSt/zJ+6iaRUKwk8
	 lolDUQJYUDSgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 07/10] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Thu, 16 Jul 2026 15:50:46 +0800
Message-ID: <1653984889e352b7f366f26a8fe4145cc94ddaa7.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

SO_ZEROCOPY is currently rejected by MPTCP setsockopt with
-EOPNOTSUPP, even though the matching MSG_ZEROCOPY path in
mptcp_sendmsg() is wired up. As a result MSG_ZEROCOPY silently
falls back to a copy on MPTCP sockets because the opt-in flag
is never set.

Expose SO_ZEROCOPY through the SOL_SOCKET setsockopt dispatcher.
The new mptcp_setsockopt_sol_socket_zerocopy() helper validates
that val is 0 or 1 (matching standard TCP sk_setsockopt) and flips
SOCK_ZEROCOPY on the msk only. mptcp_sendmsg() consults the same
flag directly, so opt-in is honoured on every data path without
any cross-socket propagation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..abcc7d4452b4 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -175,6 +175,19 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	return 0;
 }
 
+static int mptcp_setsockopt_sol_socket_zerocopy(struct mptcp_sock *msk, int val)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	lock_sock(sk);
+	sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 					   sockptr_t optval,
 					   unsigned int optlen)
@@ -203,6 +216,8 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
 		return mptcp_setsockopt_sol_socket_tstamp(msk, optname, val);
+	case SO_ZEROCOPY:
+		return mptcp_setsockopt_sol_socket_zerocopy(msk, val);
 	}
 
 	return -ENOPROTOOPT;
@@ -342,6 +357,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
+	case SO_ZEROCOPY:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval,
 						       optlen);
 	case SO_TIMESTAMPING_OLD:
@@ -387,7 +403,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
 	 * but likely needs careful design
 	 *
-	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
 	 * SO_TXTIME is currently unsupported
 	 */
 
-- 
2.53.0


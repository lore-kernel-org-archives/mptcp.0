Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35FC304BDF
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263835; cv=none; b=XALjFS2mOOobHMaLNOA3LFjSn7Tb3FjP5gBpGvslFNEvbUC2v4kuil8cAPaZisS9ljQZVqsjJddtWbD+qc/v5NPPkmC5Q7YNPeYsUoc1NJlvCKDidnJuKmD99ZW7sT05oMWa2lTxii+oxV0fHvfuwZemopGs3TV1AoiURzA/CVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263835; c=relaxed/simple;
	bh=h0KHbTdRLXfAQDlm+Mzn4sOSwJyxsp1fPSLu/6K0DEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLE4a/4ac4TNO+FV/xehwZqlBnLMYvPTIrOg9vYfgvirJYjqGHQuIki1n0olbelSHsiXEPmSgitYOYxAKKbzqMez+vo+54yYiC1qodHna4mkmJC1yBv6KmyksLzEJ0F53bn3AXz0DvME6MvAakV20MkBBJcR443K+BH2V8yHjs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgFXP2Qx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgFXP2Qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8131F000E9;
	Fri, 17 Jul 2026 04:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784263834;
	bh=1aL2W8PM3bCKMiZfqkj5j62ROsq0aloJ4VBeqLorDFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JgFXP2Qx0yVpA3ypvdIRGp7mTpv+7jY5dX45abHglDr3Vr5w45mil58zJ1QsE1Rxf
	 fe+R4BpHQOewnly89QWEKwYT3/jHmybhdYyTp5rnqAcZIfznQrFpHXnEcGVXndoEth
	 n4T4NgsQrX52IkR4wH6iE2hkdvVJkGJABII5uoQydBJUFoUnTmyMa9NjLIjnyRUtrY
	 GKujl/5UPGt6n3bIT9fZm/k2RXpibwhoZQRoZcFdKkXM0SA8xdP5wBOtiQg8355HC9
	 gcnTWRLrpA+WAO/ntaV/CUvU1tQX3Ac7rScbuciSxYSWK2cL7pxPeHr3W/dOPNfUCF
	 RhtkHTui1n2PA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 6/9] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Fri, 17 Jul 2026 12:50:15 +0800
Message-ID: <79f078803ba0cb4e22eb6e4494aa993bfedd5145.1784260668.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784260668.git.tanggeliang@kylinos.cn>
References: <cover.1784260668.git.tanggeliang@kylinos.cn>
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


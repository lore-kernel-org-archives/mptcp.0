Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422005;
	b=RI/L8LRCMqqf2MADjn4UCmpr5rrjbQvgYns6qc76xsQINIUmXKYR0fYwsaQEgL742log
	 cgI2mQJBIQy8eyx1++AfiCEOe49/T5aYlZOukfyvOAtyneby1kXaKsYqmS/VygGwlie+C
	 Z+oR7xKzxxQr0sv3h3ypWMNSWSEUif6qWf3rJlDTTuqGCVpEhMBNbG2XNv5e9S2A2pF39
	 6PjEjNEp71lbMgNiFu74ILdehvTwYMTYmgVJShZDDsqdvfAuBPytQ2pmR+gIRX2xEDhmy
	 swR0cqxwGf49gwsWAT+DKWkxbhQ6Pe2wQzyJ86e0FHe1foNCHuN8smXNJGr5jsUcl8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422005;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wJnO1zl+bnWWFUDrDrewBG36oD9XJTWEl5gjcUha2xs=;
	b=JC39sqqzF94Jcj7mB6ok37WpSuWsou5oOrBz1QPi5v/orQyzJ/8rCnM10BIa0byyBki3
	 QAcJCTgQq3s/Y/+1um6fq+tr23qcZLZhqk19iAVZUZzu+4QQytWHgsRjxEAUKkN+SaVHW
	 SDibdyDewf1wdAbBSmLKJVZgsoWOdW8MlMDnHUPIuVkRGJXR39AhBBn4UFcbqrJ2nKqcE
	 1R+Vp4hrZPedCX9qCn4ObCOJiQPhWtbGcxM44NWSpD+iV4jHEbziC0+HsbyRNTpLfDtw1
	 WoVHTAXosyksDeA5EzB4iLFmn0mic8jx1M2Om0fP3/v2TVCngekcZEyKiiRHNuEzeKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUVmBjAQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DE606A334
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUVmBjAQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580D41F000CF
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422004;
	bh=wJnO1zl+bnWWFUDrDrewBG36oD9XJTWEl5gjcUha2xs=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=NUVmBjAQkuL777wT/cPz1ez4fPUBW/AePexMTmQBTELaB0plFz+m6Sxv5EPX7J7ZQ
	 w2pHE8LrH0KdsdVGuvWhV93Qf8vD1Uw9WZZcMtNQbdzWouKyvMJr487TNcp1P0cZKs
	 3iCmRfk/lh5XNJlhR3ZXzjxiWl4JBcYKL+eBNwV/eJ5Hy1NHo2lNNw5BRTjdMTE/QA
	 D2ZG0uTotwU1pyyBt5czxZUVjBsg6jsszj/v7d4zCDMdyWjCHKvP/qO6VKytD9MBIV
	 TT+CskKlUEaplm9laL5E9nafQ9hbMtegE9kdRSX5Znvlw4ynGk5Id+ZQ5vcaeirxMd
	 6YR+2M3N0+P/A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 5/7] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Mon, 23 Nov 2026 16:19:48 +0800
Message-ID: <154898fde8a9acdf6562d2adda67ebfe3ddd7246.1795421388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
index 922f6ae5c80c..889c17da3f77 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -184,6 +184,19 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
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
@@ -212,6 +225,8 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
 		return mptcp_setsockopt_sol_socket_tstamp(msk, optname, val);
+	case SO_ZEROCOPY:
+		return mptcp_setsockopt_sol_socket_zerocopy(msk, val);
 	}
 
 	return -ENOPROTOOPT;
@@ -351,6 +366,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
+	case SO_ZEROCOPY:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval,
 						       optlen);
 	case SO_TIMESTAMPING_OLD:
@@ -396,7 +412,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
 	 * but likely needs careful design
 	 *
-	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
 	 * SO_TXTIME is currently unsupported
 	 */
 
-- 
2.55.0


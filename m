Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349260;
	b=IDwkgzb+nCn6kJiu0vPouk+KjKw+LUmIWkricSpAZqQ2d7F7Ed1d94HJg2Wp6diC/yoM
	 5XSA6165yg6mw23AVs9UhrXdjR5sQnDNadojtj2XCEdYtK62kHAKlc3HxL7BGF4bjmaxh
	 TY4FZXm01qXQK7eBzMs1PSCCX/cxFfpYQ+0WlnVae6dMw76pMjdHjqrh/X9cL/d9wu066
	 ASAsJD1CUJCdc4AWhPJUnUSy4NJU6jrcMiPOA0b8URTgb6IscJMr0ppk8iJoLwh4RTCDG
	 AVQDimymbWSWkIUaJgnndg0urkiL9eyFZlrO011QUEL9J/Q0U9zbZcOOXEQWIXVcECg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349260;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O7lf08FVe4tZkEXfWK3D8/W3/EafIGa+KgJjFCnkhRc=;
	b=kwyO7m0sRChyzHJ2+X8+2NYiSOzEECYUIk3MIEG7AQkoyWOEsM/dB9GEPaN6uMU9qY8b
	 mravznj3i2ilKgGkGkWFQcjcpEn3lC7JehTQNVoVETKAxjwM12dpsYb6p94oZn8xmRcUJ
	 gJJsXrRTWD4baBs7RuwhY2sGzJxvuI8r2l5kkmWsq0SdNJtvDMpzDDSeXRQgoWHI822BX
	 cSts1RetRqyqcT/OB+9F7FulnHu0PsWE307sg88GvFD9FjWdlG9G3ywBdc0i0RIfKULy5
	 9URXQ9kj5caZNGbAQsszqzJQMC3gb4gF15kkmOciQgH9IWCWZzQ9qPANKoeXlgnn5Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgvbTyKC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4F606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgvbTyKC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EE41F000D4
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795349260;
	bh=O7lf08FVe4tZkEXfWK3D8/W3/EafIGa+KgJjFCnkhRc=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=hgvbTyKC/D+zxpWS8JLfRI6Ha+sND89YQQgMqSQFfwUmxi4U2ELmSyo6+3TyfW0ai
	 kns0GcE4fSe3gtsnAERJ4IBedGN7dk3t+pBCGVigvCyhdIezqbMAjSG2hS0Js0fZyi
	 AqH355pwJKJbxBOGdyy41LP9lILleDSiMgmb9MbNwhn+109u56Z4zFO2XK35rZXtML
	 E0Ile3D1K96GFEN5xP/GwGD96cW2WrDpJ+QbhpUPAZdESFVPnOKIQXTo1pkmp7N4cb
	 D2RhZsT6TpXkf2dgLsq3MHxIhV+y74Vu61ZFdY4BzZjyX11yF5EwaR24Iy0RqZXuJy
	 DYmpE/ilpdIcg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 4/4] mptcp: add mptcp_inq() for SIOCINQ
Date: Sun, 22 Nov 2026 20:07:29 +0800
Message-ID: <66c8d6fa77da5d076888ad6199f1699bf513fa28.1795348666.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795348666.git.tanggeliang@kylinos.cn>
References: <cover.1795348666.git.tanggeliang@kylinos.cn>
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

Add mptcp_inq() to compute readable bytes at the MPTCP level using
mptcp_data_avail() (bytes_received - bytes_consumed). It returns 0 during
handshake (TCPF_SYN_SENT/TCPF_SYN_RECV), INT_MAX when avail >= INT_MAX,
otherwise the actual byte count.

Unlike mptcp_inq_hint(), mptcp_inq() does not include the FIN byte. Switch
SIOCINQ from mptcp_inq_hint() to mptcp_inq() so that FIONREAD reports N
(not N+1) when N bytes are unread with DATA_FIN pending, matching TCP's
tcp_ioctl() which subtracts the FIN byte.

Fixes: 644807e3e462 ("mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls")
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 846b6ab9d6eb..b2fc0dcc6849 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4182,6 +4182,21 @@ static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
 	return (int)delta;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 avail;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	avail = mptcp_data_avail(msk);
+	if (avail >= INT_MAX)
+		return INT_MAX;
+
+	return (unsigned int)avail;
+}
+
 static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -4195,7 +4210,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 		lock_sock(sk);
 		if (mptcp_move_skbs(sk))
 			mptcp_cleanup_rbuf(msk, 0);
-		*karg = mptcp_inq_hint(sk);
+		*karg = mptcp_inq(sk);
 		release_sock(sk);
 		break;
 	case SIOCOUTQ:
-- 
2.55.0


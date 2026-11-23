Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397245;
	b=zfXUGKcqXDsijbTfxv7UIml2PLJ9uSXCMAhS+yxtRZkBmEjKrxDsBWbPuEjnajeqoe2Q
	 VUZsWccOtu+Wn/fCnbjuPyhMU2zEzUy+lVZfuYbbH6BKUY5xmmsSzo25D7efeCYTBm+tf
	 GpB3ouZeo2KDWw7stlQMbELHRd9LQvGjVT/WArgoLDBniMUcREukYBzUQCFnkuytDWJVf
	 njzOVaS2/uMctyXqeBp+6PV7g0iSVn3hoUfUlebSNl3f7L0ln0FAdGiLQ1Q7PquKA/5+Z
	 P73Ma7+uuSbM6nBee1y76XuMEsHgAJxMn+rnV/xsO6OohJlPevzExHNwqT2Dp/avC5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397245;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QYu5rudP0nEQpDCGvNfolyUgaqKjmp077t/sT3Y/48Q=;
	b=e5mDpIUKuuGeEwcrUMNRRQRPCIrqTnsqAbZ7ojVvswnCRIev8i4GYOUqnwJJPN8zoYa+
	 H1VW/vufkJy0GobfL58ESgifbqr1uNi5vBGRjC8uz2fCnX6gB32WD0C/NJjlwl6TmkFGK
	 8Qi47ke2fwH2o9Xjgn8k/+57k9vRwB320VFylrtou1ETU/e6oz96b8twIEE1szKswT72z
	 nJzzqBL8X65wfGt75O7doX6yenKoTr8gKzWNyIkUoosOkVz7tkZz9cCijZ6a7PFtTiIYV
	 dIYpSnGPM18G6oRbHlJIOn6qefCYyAfwy+Jo4P+5wzHSqtRKf11iaUdflRIDJeFXqEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNJgpw9o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27B606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNJgpw9o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1C11F000D3
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397245;
	bh=QYu5rudP0nEQpDCGvNfolyUgaqKjmp077t/sT3Y/48Q=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=dNJgpw9ogb5VO2EJlkzj8+jvkcv/fGUZ9z6PvfangqYMwMg/0gaBK+DdA/sPBUX0k
	 Lykr4JNGNny+2NIQss2aQji9P/ShM1xBCzdZLjhasoQDds2+X43gk9vZSJbBywc5cH
	 WFcYbvD62MkLfV8uAA8DXJ84x+IIwdiXzxQuyhZcdfzhJjdjlOumotZDZHZzPXrRNV
	 TOGQOeoaQfh729pnXy0tyZDU6HaQtD/SEfRnTc9YLG7AHVVQhKsRxzghtEeRd/iVxe
	 D8NDZ2Q/gkwbbHiO+EEcxY38dLBW4iOWnmnbe0BmaAvF1K06UaHK745cseoHwrE+1i
	 V5PRKrcREhamQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 4/4] mptcp: add mptcp_inq() for SIOCINQ
Date: Mon, 23 Nov 2026 09:27:14 +0800
Message-ID: <bb8866b3e5b103dab9102d27d13cf1c91556f707.1795396910.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795396910.git.tanggeliang@kylinos.cn>
References: <cover.1795396910.git.tanggeliang@kylinos.cn>
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
index 543be0856742..c7cdd88e9d60 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4181,6 +4181,21 @@ static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
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
@@ -4194,7 +4209,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
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


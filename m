Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864118;
	b=CRuN0JcmO7q+a33AToIgbi8t+mvd5ik4DfUu4EWd0Wf31wznSWabHnN4okwT+Fc8bKE1
	 pcSyhiEqJclnD2ZB/DdOlwv2NUtIpsSx0057Ncg13Kw0r/TBTBiQfj7tB4qDqoDpg0pRS
	 pUQ2sCcsluiJahjRGP8bViBhWr0BNSwToVBqexJ+gRNc/q3Xn41/4Ep9rYMn/J76eXrkg
	 eLpiqQUGpjG20VmdH7qzjOhZ3jtN5PD3S0qiIxA6KbGfn3MJJgtpFam5nuGCDKnkUjjuJ
	 F13+BbzYtog6SUMxndCSI6y/Yu0EWvC9uRKRX34+UsEoZjDccWkDokqEPDZqNjD3VRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j4rRLAFP9h2I1qIV31IGpa+9ELgRYnDoWGMgjIv/QZ4=;
	b=FMAI44dvCh1/igvfTx7GNKI9VNF5w9dF9Mo7UaEn+/ORnhlZQ1c+vRKIioICe9hu5rq3
	 +RIpxp/Fx/mMr/LVdavqxDtnojh65PJCMsVoemlrfP3Uo975CHNSimi4Stbl44oH+EMNj
	 L5bQYbTVzoRBriE+2NdpwIRT8Ku0TgH3PBVbtIDs2MV5j1rN/rc1AGi5Tb6v0y5LA/o+H
	 rBzapuWbi0D8/gix30MmY8TVjDrD8PE5PvsNRCeO1etbmZdRzd+/kgc6jdapbdOeg5At1
	 tsUAnC0OpopSr5/YB413BPtIUvn1NGTXjry24pf52bZlr7OV7IqDDXwCxgeO3BmDl3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwRLglJ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A9606A331
	for <mptcp@lists.linux.dev>; Sat, 28 Nov 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwRLglJ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33E01F00898;
	Sat, 28 Nov 2026 11:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795864118;
	bh=j4rRLAFP9h2I1qIV31IGpa+9ELgRYnDoWGMgjIv/QZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JwRLglJ98pp6vyrLqVPH0iYpO9gB3LaGG7tpGVw5J967ooxqS8YJOfUvDpDMX5nUc
	 B5zrXnM+J4DbQ8H7119o1tmeSp/0t7DhuiYVjdDbbeowyJRn8jsRgug6OFkF23rKHR
	 qVVmCBZ/PnwTPJfg9xtshFcDcD80Hwwf0SlYHHRDSMb7UM00YhtZtwOj2vL00AjE8/
	 gp81Gs8z9zseuVL9+jRvkFbNOnz7VjKtAbXlIF0AnbWdZ5/iN9EXo45sK/sWjkRkFP
	 f3uzGlJM0L1EUZp+heFs+MY5WiGb7CwzaeYYGJKXyIIebtsgkouU+wfgMIa06KBVp0
	 Xk69Jm7+28XGg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-net v4 4/4] mptcp: add mptcp_inq() for SIOCINQ
Date: Sat, 28 Nov 2026 19:08:06 +0800
Message-ID: <0ecb22867c7323dec7b22479791b75359ac5e209.1795863454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795863454.git.tanggeliang@kylinos.cn>
References: <cover.1795863454.git.tanggeliang@kylinos.cn>
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
index 7d090ada5ebd..bc61ac827c12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4568,6 +4568,21 @@ static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
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
@@ -4581,7 +4596,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
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


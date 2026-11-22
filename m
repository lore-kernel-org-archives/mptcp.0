Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318681;
	b=wcvj5KUh2H8F02J+uJJAHGMoLUMGPglkTTacvMuRag2+FRGXxuUJKHgk0/i49cwrwgCB
	 9+OvFqkDU+0zctzKVYM3y20DJi6FxTxZtYJtvO37G4RK07dz3fHLIzm/FsMAy+ci3u8Sl
	 WP9g1GMk6Kx5XpqSjnYixbiisxxfontEIxjZMd9S9QcyebCVvxq9PNMlqNEWpSb0r7HfP
	 HstnaZBjRKjakgF9Fz93iiLKb0EzNwRf/vV2HAFLvzgdsB4luubqgxwXmGyHGgVK3V/vy
	 HtevdEGeZLw3N0rRiBQdmwVEwPvf1Qpc/wluIGsUxcY/rdm7vzA8QNegK5edaCAt3EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318681;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hbRMCbRUw0y3xuL3f7djlVPtb53zmNNriI9kYHvqss0=;
	b=pkzHkxOT/+mivZOSMJiBj73bZ0Zuu8PA503WbqMJPTykrXZRpl73P2WKTcN+bUWvxS78
	 mBmV05YnLQpqHaNbog7QTzFglhSbGRi6R/ZVuAQhzNpqSd7shBDzM1WbIjCMzx9PWgo+X
	 14f9+k3r2GyzO/CthPh1UMlZ0n/00k9XRTMUCVKOKQAii0Fq06InkUKQdJgDzc/R6Pd9b
	 zsmYuipChemkukaliEgVhu+1YhYNm88pCXQTtfgW4+Mj82whDkSRbAWf7aCOFaH0hAYm1
	 /5vRpM5Iw1OEedokciLuXO9SnddcQdtHNLuwTMPdRnO7tRqUmI+SfdNuGQnIRqjOzFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h37WH3sF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE85C606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h37WH3sF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827C71F000C4
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318681;
	bh=hbRMCbRUw0y3xuL3f7djlVPtb53zmNNriI9kYHvqss0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=h37WH3sFoo40c7JtVDRjhytqnsLz1MvFmQtNmRk0/ZPg5QztNdRyiE1LVemcxhTts
	 ASKaqXoJCvinPrvskfMVBam2ftsRZgv6XzXogdK1dcqblj/OW91pgLBFGxycYq4Dw6
	 A7ldeC0hmZf/zVIonZ8W6ECZ2xnopLWG3KZVg9VBnAP3NdeeALqt/8S/D2ou8WLGl6
	 dQWGagLLSOypjfnq738iM5ZpAUIJCDaXPUkjeW4OJh5WbjLiDyjjLbfS+PmUksIwcL
	 TobaH/wvlnYJ1+3FQPmoNHPmuPYGnhw3L9g0KrOQXwPT/n+3NbM3axNOODsFjJN9lG
	 Aw1bsjBNoy0hw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 4/4] mptcp: add mptcp_inq() for SIOCINQ
Date: Sun, 22 Nov 2026 11:37:49 +0800
Message-ID: <a4c3a15bcbae6bd38488a805e2b1183654cf8692.1795318567.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795318567.git.tanggeliang@kylinos.cn>
References: <cover.1795318567.git.tanggeliang@kylinos.cn>
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
index ca660afae071..1ecd5a85be5b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4185,6 +4185,21 @@ static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
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
@@ -4198,7 +4213,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
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


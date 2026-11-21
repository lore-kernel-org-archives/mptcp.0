Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254189;
	b=FpqEuRiBGIl8GdqBqD+PBG9+GHp86EoOaD7VYpxIiUOn8/pMrbkMiQaxCnjWMQfSIvQd
	 cO+yTWJFftC5koPEIMtQmzbNHmaKgR+Sktd/Gr0rWHHNNO6w9rXmKzIOIU2m0cTOQtAHs
	 Mkl6IYE3757hmARmwvJxKbfBLn0SBcIYUCi/2fzLUVS/Oaf7MQG5tc4Jy/P8AmCAmsQtf
	 TKHlDS92Oophs/gA8U+5W9P9gaEatkLxPOt5bR7ktJRasAiHdwRr6QCCjj5y8CKYanMTO
	 pzgTM4CjmU7yK5k+4kvoFsmb9daaH7IrM5nfwC27jR2w+LYtwTf6Bcs5QOdGZkDXt2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254189;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4UuzmxKgvHlfJkZ2GKl/zYApxcrbpPRELOpRuxCkj24=;
	b=IWy34ZquoNyYHIj9ngUY9TIWNqwMkb2bXFwl2/ZGVlyJfLb9Nx6/iG2JsLToo4wTzjF0
	 wNEjO7BSCV95yX/6ZqZLmxaMfzhwTTmWqL+FDiZF6+e0Ucj1goN8irbw9CWqP9W6RhTGO
	 5h7repImVaDiR8o3syHwYsmoneOstn5dTcnLvw0Ii5ZLWPw8tlbRo9yf0/jr+Obf2ueN4
	 E5cK11rLTUT03Qe/qB1FAk5AWpQNY3Dwbr+Nzu5RhjKtzhDwCs3TpjFnnNzim7qcLztfK
	 l6r5cswIuQxa/cj/PN+aPUVu/yi+vSVT79eGFQ+dh9NWj+AZsDgyaRDPl+TwgocIRGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Le2vwXZs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF77606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Le2vwXZs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8F51F000C0;
	Sat, 21 Nov 2026 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254189;
	bh=4UuzmxKgvHlfJkZ2GKl/zYApxcrbpPRELOpRuxCkj24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Le2vwXZslp7B/rU2Y9QBga1XlXyPM+3MZfVGwMJiTCVBftKiZ8cQ1adD1YuKQ4p+K
	 PR0XsvKN7Yciy080gQJVm//Sv1dHgfnVxL6SVjaIVaf2B3g0dl+Y2XMosuOGWuli9q
	 afpAgjDLtre8dwj8vM1lon7q/3TPoalD2VskLJrEczJvAFmhu+sPSQCepYqNpN70DP
	 7bqUm9UmC6gxVkORxmGTTQVaKr/nzaoqyvt2tSJEFF73GNrVce5BhELPREl6nv7sPL
	 YUC5t/fSr3tNlNmhHzq5+22ydZrNTE76+6qe0XQ07ezalzJjiLW736zKMemG8y48QF
	 v/Jl55BnBp/ag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:55 +0100
Subject: [PATCH mptcp-net v2 57/62] mptcp: order write_seq and DATA_FIN
 flag for fallback
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-57-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KsR+SG+0NuEh7ICGPD7FwEJMBMvC5IXRHK5R/oWMyz8=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGsBZ3Oi0CW4h1JwhmsiNiBpxgQnf8DwVpT532pUnR8yGD/nw
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmsBZ3MACgkQfCLwwvNHCpcfYgD8DcDx
 aHJ7YMwkArS16f2FgYo1fSVLmIptoKPZhJKmUCUBAIzULFMDtIfVgu9MUg86a89LD07v7YH6+TY
 wxub5DaoH
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_try_fallback() can run in BH, without the msk socket lock. Since
the commit mentioned below, it reads write_seq after
snd_data_fin_enable, not to send a FIN before new data. But
__mptcp_wr_shutdown() sets these two fields without ordering them: on a
weakly ordered CPU, mptcp_try_fallback() could see the flag with the old
write_seq, and send a FIN before the last byte of data.

Use a release/acquire pair, to read the new write_seq with the flag.

This issue has been found by Clashiko, while reviewing the commit
mentioned below. It is theoretical: it has not been reproduced, and it
needs a shutdown racing with a fallback, with exactly one byte not sent
yet. Still, it is fine to fix it like that, without real impact: the
release/acquire pair is cheap -- plain accesses on x86 -- with the
release done once at shutdown time, and the acquire only when falling
back.

Fixes: d0e88ecfae68 ("mptcp: don't send a FIN before the pending data on fallback")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Clashiko
---
 net/mptcp/protocol.c | 3 ++-
 net/mptcp/protocol.h | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cc438ae46089..174ffd0d3e68 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3666,7 +3666,8 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 
 	/* will be ignored by fallback sockets */
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
-	WRITE_ONCE(msk->snd_data_fin_enable, 1);
+	/* pairs with the acquire in mptcp_try_fallback() */
+	smp_store_release(&msk->snd_data_fin_enable, 1);
 
 	mptcp_check_send_data_fin(sk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cdd0a7e8296..be57804f1bb3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1364,8 +1364,10 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 	if (!__mptcp_try_fallback(msk, fb_mib))
 		return false;
 
-	/* no FIN before new data: see mptcp_check_send_data_fin() */
-	if (READ_ONCE(msk->snd_data_fin_enable) &&
+	/* no FIN before new data: see mptcp_check_send_data_fin(), and the
+	 * release in __mptcp_wr_shutdown()
+	 */
+	if (smp_load_acquire(&msk->snd_data_fin_enable) &&
 	    !before64(READ_ONCE(msk->snd_nxt) + 1, READ_ONCE(msk->write_seq)) &&
 	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;

-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557712;
	b=z86pJQJg7rmpuKugQvesUZuhr6xo5QGMGE2mUFsSVZZVp/0pH6dp/s6K1Dg7H3YuQUHZ
	 wL0wVbOo+OQSNhuw/LbWNUhcSjtAarH2VI54aD6bhpEV2VOy6YDf142qHhYmA+Ch3op2B
	 sFEGkTsE1KLEJ2V/jyFVuRCEujHSobmwXVbB3I1yoG2ztTnPs577T92Jfbj45cjADkG6a
	 yRvSwRw5IvYcOUg+MMEydysGAYp89GKviWTDtyxNYLdrLi9GnsSmzHyfZnhm6eX2xehFu
	 s+fPewWXp4JwCruxO2tZCPRhc5MYJhGU9fCaekI+Mpsv5V3IXjgSuProYMMwo9J6TiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557712;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xJ76myPlAylgMT1avbb8/C31thGCQd6FTIA1l3hh1gM=;
	b=Slb3fd4bU9Gu3nI99u+jMpEn1zjmaH4mW1EK5bFP4sej9ivNuTw+ucCgOWJZYRzczwK3
	 TZN2NnM8WRfe95hR+S95r8TqFuFaa9LeeqMBvmZy+V7Ty7Apr3470LctbarIJwrtdmxD6
	 3l+wWpY3M8PT0L5t06C5kSXPcejuPzVMjD6O66pYPH/4/ZuI6bZaNNV2iF69QeUselpkB
	 W6gOr1N7bQ5ploJWm0H9QkuL5lIWJn+he0f52pY+BqoQ7IWV1j+hQvzIz0YBWHKvwXq+F
	 0AWdTu6m6EZBvJrZUzafN5m4ienVGguPJNyVo5YbGmMmznlQqAdrco3Mj8fmZG5V9Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzUqVIM2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128F606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzUqVIM2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DA81F000C0;
	Tue, 24 Nov 2026 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557712;
	bh=xJ76myPlAylgMT1avbb8/C31thGCQd6FTIA1l3hh1gM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WzUqVIM2wwdqJ5CxvTxV335s1VaOy/lZwEUWOrV+CfnaPw8Wmkn5Y83AhT67W+BB9
	 73WxmJ35Gs9yfl1XYpBYWlpvyOzoYHa15Ri9foBAyyouABYsnX/863cB5JW6LmioBw
	 qyIdJc79qvH7f7gHyVj7TkYBg4Tor73TQWafeof/e4PoaH5UA2DhPjjXgfVAOtckQ1
	 FIZUIBn0Sirk8KEty6iGYSplkoZ2/ysJzEecv1igvjyn/RBJtv495Bz9dTXWCPDtti
	 0oMzA7+gwZ4awwsZNCUUCHIdy7uDORz/9v3117LUsChM7GLpoXXwZJ9NTjfSFpJAK1
	 AxvjOzENmThFQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 23:00:01 +0100
Subject: [PATCH mptcp-net v3 44/50] mptcp: order write_seq and DATA_FIN
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-44-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S8DtQhGYBbNNO/6GEaGZhFu6/M4/fbrcPiqfvlFEMiU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOIVKr3XmhXi3PLpxJvz1Br9JAo4OfwXfnTW8xjNzT
 kSc52z9jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImkfWP4Z3FgQds2sdhq4a03
 ubjljy5fwV8fnr+jI6w2bn78vqyLzAz/TF8kzeW9opdpG1C9MSTsN8vmVfP/7tizeUPc0hvKV3l
 MmAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_try_fallback() can run in BH, without the msk socket lock. Since
the commit mentioned below, it reads write_seq after
snd_data_fin_enable, not to send a FIN before new data. But it reads the
flag without ordering it with write_seq: on a weakly ordered CPU,
mptcp_try_fallback() could see the flag with the old write_seq, and send
a FIN before the last byte of data.

Read the flag with an acquire, pairing with the release used by
__mptcp_wr_shutdown() since the previous commit, to read the new
write_seq with the flag.

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
v3: only the acquire, the release being in the new previous commit,
    fixing an older issue
---
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/protocol.h | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e0f39931493e..f361cd40a8e4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3694,7 +3694,9 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 
 	/* will be ignored by fallback sockets */
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
-	/* pairs with the acquire in mptcp_data_fin_enabled() */
+	/* pairs with the acquires in mptcp_data_fin_enabled() and
+	 * mptcp_try_fallback()
+	 */
 	smp_store_release(&msk->snd_data_fin_enable, 1);
 
 	mptcp_check_send_data_fin(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a9daa047203c..59ddf3dafeba 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1365,8 +1365,10 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0C3F1AD7
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151790; cv=none; b=tPtMnQfwbl6eK9A9xGfkgeAuaNU7EcRnLQ73bkh6FIKR67pPX7NKhfiOPKrM08eiSZt1WdTvOOcDR9g3qScbEgiFz9B8grdWMlapm05DsiWxmdsCbnK+cfV66IBQVmOQodFP8/rNWvg6J0F3nU2Ng4enmE8MTbgPFttKQ3sOuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151790; c=relaxed/simple;
	bh=vRoXiBR4d/+nWQBWjFeIDTZY5GiuYbnWMuE7lyAlz0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0pWSpiuAh7IHWIYA6nSuhGasQY2LNMgltTJEkhPqmtKIwpv+GW0VFPOlacrJc2g5BL8rBpuXbDCOeU44LnTpeKaNbU75EEAX7q5bYIZcD7TyOgqdqPA3NWpToFVkwhPBKHS8NOX0F9BUjUfScReIlRLLKDYmKDDfW9hnlOY1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1dsI0Rr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1dsI0Rr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BCC1F000E9;
	Mon, 27 Jul 2026 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785151788;
	bh=7hJ5GPi815MX/iylDVo0keGB06RD65fz8uydIxo/qSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1dsI0RrJ1mcWDDJ91sSiTF04KIHNtNQ6ElzGuJRckYbOq0gN/wxkjOjgRmJY1vuI
	 Ozu46/jnHdNzQ9SEt75PskLyeGk9poZ96HVHSE7Ws3beYTIiZ1O7UxIMVaX+IICEFv
	 rPCifUV0OVxSE6EDwfZaDK4KKnE6YaOuL/J3oSqCMSqV7UXcxUg/f1qf2ZnGrsnxyJ
	 8gbFkUroa+pZN81AMVpUVjDgT/v/UEVkxTp2ni14RRGlQfRvXxoWl44gyfLjy4e8Oa
	 zI/hpIyWHtxMi7MeEdbHWUOsRYEy9by6+6CZ5Vpl7cDTicT2hYeVFrLIyUytuqMBuZ
	 hYSRmUmC4Wjzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/6] mptcp: defer sk_data_ready to the worker
Date: Mon, 27 Jul 2026 19:29:21 +0800
Message-ID: <5ab5630bc288d5af26ecacfcf29c7fe35f1fd670.1785150300.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785150300.git.tanggeliang@kylinos.cn>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When MPTCP carries TLS, the data path runs under mptcp_data_lock().
Reaching sk->sk_data_ready(sk) synchronously ends up at
tls_strp_check_rcv() -> mptcp_recv_skb() -> mptcp_move_skbs(), which
calls mptcp_data_lock() on the same sk and recurses on sk_lock.slock.

Fix this by deferring sk->sk_data_ready(sk) to mptcp_worker() via a
new MPTCP_WORK_DATA_READY bit, re-using the existing
mptcp_schedule_work()/mptcp_cancel_work() infrastructure. The wakeup
bit is consumed after the SOCK_DEAD && TCP_CLOSE destroy branch, so a
socket that reaches the destroy path drops the pending wakeup rather
than running it post-free.

No new work_struct, workqueue or cancel path is introduced; only a new
flag bit and the corresponding set_bit()/test_and_clear_bit() in the
mptcp_worker() body.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 9 +++++++--
 net/mptcp/protocol.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 09b888ff33c7..be139718ed15 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1085,8 +1085,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	mptcp_rcv_rtt_update(msk, subflow);
 	if (!sock_owned_by_user(sk)) {
 		/* Wake-up the reader only for in-sequence data */
-		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
-			sk->sk_data_ready(sk);
+		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk)) {
+			set_bit(MPTCP_WORK_DATA_READY, &msk->flags);
+			mptcp_schedule_work(sk);
+		}
 	} else {
 		__mptcp_move_skbs_from_subflow(msk, ssk, false);
 	}
@@ -3223,6 +3225,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_DATA_READY, &msk->flags))
+		sk->sk_data_ready(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8b16b0a4eb9f..7ba8b78ac6e4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -115,6 +115,7 @@
 #define MPTCP_WORK_RTX		1
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
+#define MPTCP_WORK_DATA_READY	4
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
-- 
2.53.0


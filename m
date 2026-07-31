Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0442DFFA;
	Fri, 31 Jul 2026 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507891; cv=none; b=MwCEnnXKrEvxLdfGBRsQ5f6AlwYPMiMn4SEVL2ffbbiKKwBtBzPJuvGBKSKCBgEnPna/DMQTICJgynCTMI4efvskkqyuu27QBoj3t0HF4OHV/Nybk29EIi0jCqHrpN6ZV64hJf9yC/iutSe5MR3Igk4R472Dn4RWG2HxcF804o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507891; c=relaxed/simple;
	bh=+RqkXn1fraP6cVhzylmca3p6JDvhLR0jInwTN075Ip4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhARAa/WvjeCkRWWgmX8Cww3wruMG+b4MoHsbiX32hUXbtlFInWwE8GvhUpemlDet934eAF5kst7mwsa84o4pezVciMnlu1VCzpln+3TSY/JyKYzvWcPP0RpZYer443EG76kiRkxhXa8zQFftI8pjvo0PcTiA84kbR206HHLZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM7z3dA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM7z3dA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFAD1F000E9;
	Fri, 31 Jul 2026 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507889;
	bh=5+GFzuFgZQNxbrz5hLonyNttgqfCDeTaSqr0K2b4YtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aM7z3dA5AefnbSjnQzj2ji/x10YDUM3fbxUtUUDoJjGpOIGgE1OlZnKuQ/xNVTJv2
	 ksAroKFkohu2nt0PRF74ErCLOcaziBbiomabpGOQm30/PU1R0T2+tEGdho3kZK3qCA
	 Dch/KfMx6o5ym2G9uLFnehCkm/MkDubcX4Wtr/p7ger0xGclnWDc7gdBC5Dnz9iyvA
	 86nTUt9vk17REOxp9gdXa0hIWp6PLh8i5ZTibWYQEIEU0m977bKLqtPnoab/dpvhCG
	 QIZs+T+8anwqXWBU1Uo1qgvarL2dQ99vHXHg5ZLN6HiBwhwdNxJO7sZhHhpccgQN7H
	 eihne0u5eOOkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 16:24:18 +0200
Subject: [PATCH net-next v2 2/5] mptcp: let the retrans scheduler do its
 job
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-net-next-mptcp-oooq-pruning-v2-2-24838164fa21@kernel.org>
References: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
In-Reply-To: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6309; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kPuyETNsuPEY+YBx+aLERj0Xbk9Jfu2rb6IkdWMvqvM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyNqi90dMS+fP8Q1zW2hwF1bfzzkbqawdlfy2QlzL7f
 3p1MO/LjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIk82MLwvybk2NVVl1jOzU/i
 ZZuQ+UVNpn5WWKfzzCuPdXda7rumv4fhDx/jHYfzTbrP95+crNoWzM++IH3FWSmV2PCADVsmmJ3
 YxgMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Currently the MPTCP core enforces that when MPTCP-level retrans timer
fires, at most a single dfrag is retransmitted. In some corner-cases, it
may be necessary to retransmit multiple dfrags, and the MPTCP socket
will need to wait multiple retrans timeout to accomplish that.

Remove the mentioned constraint, allowing to transmit multiple dfrags
per retrans period, as long as the scheduler keeps selecting subflows
for retransmissions and pending data is available in the rtx queue.
The default scheduler will transmit a dfrag per available subflow.

Tested-by: Gang Yan <yangang@kylinos.cn>
Tested-by: Geliang Tang <geliang@kernel.org>
Acked-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 119 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 87 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 290d14e2fa5b..72b1fa3ca71c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1136,13 +1136,6 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
 	mptcp_write_space(sk);
 }
 
-static void mptcp_clean_una_wakeup(struct sock *sk)
-{
-	mptcp_data_lock(sk);
-	__mptcp_clean_una_wakeup(sk);
-	mptcp_data_unlock(sk);
-}
-
 static void mptcp_enter_memory_pressure(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2785,8 +2778,12 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	sk_error_report(sk);
 }
 
-/* Retransmit the specified data fragment on all the selected subflows. */
-static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
+/*
+ * Retransmit the specified data fragment on all the selected subflows,
+ * starting from the specified sequence
+ */
+static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag,
+				u64 sent_seq)
 {
 	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2796,6 +2793,7 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled)) {
+			u16 offset = sent_seq - dfrag->data_seq;
 			u16 copied = 0;
 
 			mptcp_subflow_set_scheduled(subflow, false);
@@ -2805,7 +2803,7 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 			lock_sock(ssk);
 
 			/* limit retransmission to the bytes already sent on some subflows */
-			info.sent = 0;
+			info.sent = offset;
 			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
 								    dfrag->already_sent;
 
@@ -2851,14 +2849,88 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_data_frag *dfrag;
+	bool need_retrans;
+	u64 retrans_seq;
 	int err, len;
 
-	mptcp_clean_una_wakeup(sk);
-
-	/* first check ssk: need to kick "stale" logic */
-	err = mptcp_sched_get_retrans(msk);
+	mptcp_data_lock(sk);
+	__mptcp_clean_una_wakeup(sk);
+	retrans_seq = msk->snd_una;
 	dfrag = mptcp_rtx_head(sk);
-	if (!dfrag) {
+	need_retrans = !!dfrag;
+	mptcp_data_unlock(sk);
+	if (!dfrag)
+		goto check_data_fin;
+
+	for (;;) {
+		bool already_retrans;
+		u64 sent_seq;
+
+		/* The default scheduler will kick "stale" logic, that in
+		 * turn can process incoming acks and clean the RTX queue;
+		 * ensure that the current dfrag will still be around
+		 * afterwards.
+		 */
+		get_page(dfrag->page);
+		err = mptcp_sched_get_retrans(msk);
+		if (err) {
+			put_page(dfrag->page);
+			break;
+		}
+
+		/* Incoming acks can have moved retrans sequence after
+		 * the current dfrag, if so try to start again from RTX head.
+		 */
+		mptcp_data_lock(sk);
+		already_retrans = !before64(msk->snd_una, dfrag->data_seq +
+					    dfrag->already_sent);
+		put_page(dfrag->page);
+		if (already_retrans) {
+			__mptcp_clean_una_wakeup(sk);
+			retrans_seq = msk->snd_una;
+			dfrag = mptcp_rtx_head(sk);
+			need_retrans = !!dfrag;
+		} else if (after64(msk->snd_una, retrans_seq)) {
+			retrans_seq = msk->snd_una;
+		}
+		mptcp_data_unlock(sk);
+
+		/* `already_sent` can be 0 for `dfrag` belonging to the RTX
+		 *  queue due to __mptcp_retransmit_pending_data().
+		 */
+		if (!dfrag || !dfrag->already_sent)
+			break;
+
+		/* Can fail only in case of fallback. */
+		len = __mptcp_push_retrans(sk, dfrag, retrans_seq);
+		if (len < 0)
+			goto clear_scheduled;
+
+		retrans_seq += len;
+		msk->bytes_retrans += len;
+		dfrag->already_sent = max_t(u16, dfrag->already_sent,
+					    retrans_seq - dfrag->data_seq);
+
+		/* With csum enabled retransmission can send new data. */
+		sent_seq = dfrag->already_sent + dfrag->data_seq;
+		if (after64(sent_seq, msk->snd_nxt))
+			WRITE_ONCE(msk->snd_nxt, sent_seq);
+
+		/* Attempt the next fragment only if the current one is
+		 * completely retransmitted.
+		 */
+		if (before64(retrans_seq, dfrag->data_seq + dfrag->data_len))
+			break;
+
+		dfrag = list_is_last(&dfrag->list, &msk->rtx_queue) ?
+				NULL : list_next_entry(dfrag, list);
+		if (!dfrag)
+			break;
+	}
+
+	/* Attempt data-fin retransmission only when the RTX queue is empty. */
+	if (!need_retrans) {
+check_data_fin:
 		if (mptcp_data_fin_enabled(msk)) {
 			struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -2866,30 +2938,13 @@ static void __mptcp_retrans(struct sock *sk)
 				   icsk->icsk_retransmits + 1);
 			mptcp_set_datafin_timeout(sk);
 			mptcp_send_ack(msk);
-
 			goto reset_timer;
 		}
 
 		if (!mptcp_send_head(sk))
 			goto clear_scheduled;
-
-		goto reset_timer;
 	}
 
-	if (err)
-		goto reset_timer;
-
-	len = __mptcp_push_retrans(sk, dfrag);
-	if (len < 0)
-		goto clear_scheduled;
-
-	msk->bytes_retrans += len;
-	dfrag->already_sent = max(dfrag->already_sent, len);
-
-	/* With csum enabled retransmission can send new data. */
-	if (after64(dfrag->already_sent + dfrag->data_seq, msk->snd_nxt))
-		WRITE_ONCE(msk->snd_nxt, dfrag->already_sent + dfrag->data_seq);
-
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 

-- 
2.53.0


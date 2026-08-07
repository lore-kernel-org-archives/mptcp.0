Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943326ED3E;
	Fri,  7 Aug 2026 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110647; cv=none; b=dUztHCOVcTMK+q94b3Z77fsl4d/HqY/kwFfREVQ/k8KRBIjahAoh6WC/fj1hg7y/Ca2J+1nmrGZZexaV48lJJdEDpDxZUflmQOTevt5vzRWEX2kt9jEjluhGv76l5/OaZobqnTYFIC8hDEiN+r5wPODhM/wt3F2YBBaON9uuM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110647; c=relaxed/simple;
	bh=xaWz6CyMMKxzOd0Swe/VxKb9+yYIgz2OvTEbTi2CkpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMPTlSrSScb5fTolRpvzGwJj6Gtrb0cQUhnVpbdwTGT3SAz9tRr9blrzL2OPjr4w/DuLDhPmlF72A1AgJtK9MwuUHXb0ooiVr/sc97lO5IikE9m9ld44HJqjrUroNvB41umbY5qviJ4zj5XNwgLAPNKiyrbcmLcT4QrY9PEUqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqa1GSRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqa1GSRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112631F00ADE;
	Fri,  7 Aug 2026 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110633;
	bh=X07P8JJsNfMLTWtLg406EQpUen9p5lYWpitcQ6F19C8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mqa1GSRrRXDHPZk/cY8AYORnqG+6cQf9+bwtpQ/8dQKSObtgqKFwmjUzYySOixyrZ
	 toZcxkaq+1q3HAfqzkjQ6xU370Lu1VbOARkgMz3dbnNbO+MI39qoH2L4J91VzTij7D
	 xIIeMbd8dYkcHglbWMZjRHezeELdf0v8CfrMv5aBu9LhsXw0uaHv4dxFot2yIqU/EH
	 XCoiMx5j8HbMBcEXRH7ow9Wg0+pmLZbgTY58TNqS3bdKAwu7R9GGmm2Y9Kj3lwno9z
	 s3TuT2bCBblX5dX3psdU5MqG5be4GyNjiXvAHxJYscCwBg1vWBUIqZXs1ZfTc53mGE
	 KbsGtuPgamhYQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 15:49:03 +0200
Subject: [PATCH net-next v3 3/7] mptcp: let the retrans scheduler do its
 job
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-net-next-mptcp-oooq-pruning-v3-3-dbc1eb853cc3@kernel.org>
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
In-Reply-To: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6071; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7M+rqCWJUFFm+ZsElpBS0Crbt8K0xeAdxFY7DIckIT0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKH83RczZeFn6U64btKc6m8Ely77t2bJgWfWja5fz6b
 2rPamtDOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACby6T0jwymeL3UCO8RX73T9
 cWaSFZ+r7Ek+y/19Tr7tM+9LroxgM2L4K/hPaPt+nsi8HczX74m3KzVe6jXs7BC5KJn55N2vdCM
 BDgA=
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
v3:
 - Many cleanups, since the stale logic is invoked only once outside
   the main loop.
---
 net/mptcp/protocol.c | 106 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 88167edc6598..09cd3c1f3cdb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1142,13 +1142,6 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
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
@@ -2790,8 +2783,12 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2801,6 +2798,7 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled)) {
+			u16 offset = sent_seq - dfrag->data_seq;
 			u16 copied = 0;
 
 			mptcp_subflow_set_scheduled(subflow, false);
@@ -2810,7 +2808,7 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 			lock_sock(ssk);
 
 			/* limit retransmission to the bytes already sent on some subflows */
-			info.sent = 0;
+			info.sent = offset;
 			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
 								    dfrag->already_sent;
 
@@ -2856,15 +2854,78 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_data_frag *dfrag;
+	u64 retrans_seq, sent_seq;
+	bool need_retrans;
 	int err, len;
 
 	mptcp_pm_chk_stale(msk);
 
-	mptcp_clean_una_wakeup(sk);
-
-	err = mptcp_sched_get_retrans(msk);
+	/* Get an updated and consistent rtx queue status. */
+	mptcp_data_lock(sk);
+	__mptcp_clean_una_wakeup(sk);
+	retrans_seq = msk->snd_una;
 	dfrag = mptcp_rtx_head(sk);
-	if (!dfrag) {
+	need_retrans = !!dfrag;
+	mptcp_data_unlock(sk);
+
+	for (;;) {
+		bool already_acked;
+
+		err = mptcp_sched_get_retrans(msk);
+		if (err)
+			break;
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
+		/* With csum enabled, retransmission can send new data. */
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
+
+		/* Incoming acks can move snd_una after the current dfrag
+		 * across loop iterations, if so start again from RTX head.
+		 */
+		mptcp_data_lock(sk);
+		already_acked = !before64(msk->snd_una, dfrag->data_seq +
+					  dfrag->already_sent);
+		if (already_acked) {
+			__mptcp_clean_una_wakeup(sk);
+			retrans_seq = msk->snd_una;
+			dfrag = mptcp_rtx_head(sk);
+			need_retrans = !!dfrag;
+		} else if (after64(msk->snd_una, retrans_seq)) {
+			retrans_seq = msk->snd_una;
+		}
+		mptcp_data_unlock(sk);
+	}
+
+	/* Attempt data-fin retransmission only when the RTX queue is empty. */
+	if (!need_retrans) {
 		if (mptcp_data_fin_enabled(msk)) {
 			struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -2872,30 +2933,13 @@ static void __mptcp_retrans(struct sock *sk)
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


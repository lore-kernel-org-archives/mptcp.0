Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B07C3C1413
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051493; cv=none; b=JAEe95NlaYPZQ69Ir8tGJ/t+Tzf2w5XJIR6Zf87OTM0xt7cH7xocmn6eaBDqQkCWQNaZhLioORtqzlPoS+IvNNy8qohwyJiHoHmD3g0K3hL5wUgxVhiuOsRedkEhTnmhGu6ENQ6Z7OfFjqzIQOdK7Gor5oUyLbUhb2sa8h3xcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051493; c=relaxed/simple;
	bh=RpOwwfwa3cLRMp+IegdeWs295SkedN5Sq07ztIGzztU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=X+X9Q61Z7vqXGnAD8pPwK9t0tbyUVf7Ip4VL7E3OY5D7VqtNiTr01D84l8GDwPPKMENHQxshGN8IRdICln28LnTwMsT51sueD3Wk3Cs7yQmr+OmCwZIKBBZ8FPkCCkY/j59fyeUD6NzdhMf2U25qWaRTlS99d2S9/1nU5P60CGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCWioy6E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCWioy6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780051491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whqzQlGcU623K1X7WjTsTJhi9OloiCONFW7uUD604pQ=;
	b=PCWioy6Eo/uitBxnmDtkyDcryNe3iLTFuaMVJgl8YeCEAEWguVbM6H9RaotGrmjiFsZgCw
	If3bMKF7D0VHDqadz4zc9Pc1UcjR9vYSXVNpOhAMQZ5znm5ZpTnsYY4Evt42K9PuTMOfMh
	zd7zCRmf5F3JS273Pv/JgouCXMPOqt0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-kK6eyssOMWeTGtqBPWuHbQ-1; Fri,
 29 May 2026 06:44:50 -0400
X-MC-Unique: kK6eyssOMWeTGtqBPWuHbQ-1
X-Mimecast-MFC-AGG-ID: kK6eyssOMWeTGtqBPWuHbQ_1780051489
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F87819560AA
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DD6B19560A3
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v10 mptcp-next 3/3] mptcp: let the retrans scheduler do its job.
Date: Fri, 29 May 2026 12:44:31 +0200
Message-ID: <199d3b27cc1f092a1bca686963103f922d0d27cd.1780049797.git.pabeni@redhat.com>
In-Reply-To: <cover.1780049797.git.pabeni@redhat.com>
References: <cover.1780049797.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n5aV_BJpBlowyJijws7yWWIdv0mlmmyalX2Bo2nHbZU_1780051489
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently the MPTCP core enforces that when MPTCP-level retrans timer
fires, at most a single dfrag is retransmitted. If some corner-cases it
may be necessary retransmit multiple dfrags, and the MPTCP socket will
need to wait multiple retrans timeout to accomplish that.

Remove the mentioned constraint, allowing to transmit multiple dfrags per
retrans period, as long as the scheduler keeps selecting subflows for
retransmissions and pending data is available in the rtx queue.
The default scheduler will transmit a dfrag per available subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v9 -> v10:
  - simpler handling for data-fin rtx

v7 -> v8
  - fix corner-case retrans_seq update

v4 -> v5:
  - fixed already_sent update

v3 -> v4:
  - avoid quadratic behavior, fix retrans_seq update
  - fix rtx timer re-schedule miss

v2 -> v3:
  - fix infinite loop issue (should address tls tests failures)

v1 -> v2:
  - fix retrans sequence update (sashiko)

Note:
 - sashiko may see issues when dfrag = mptcp_rtx_head(sk) != NULL and
   dfrag->already_sent == 0. That condition should not possible: if
   mptcp_rtx_head() is not NULL there should be some data already
   sent.
 - sashiko may see missing data-fin rtx when the initial `dfrag` is
   not NULL. data-fin RTX is NOT needed in such scenario.
---
 net/mptcp/protocol.c | 119 +++++++++++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 51756800edc2..7fe618e22d1b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1201,13 +1201,6 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
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
@@ -2830,8 +2823,12 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2841,6 +2838,7 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled)) {
+			u16 offset = sent_seq - dfrag->data_seq;
 			u16 copied = 0;
 
 			mptcp_subflow_set_scheduled(subflow, false);
@@ -2850,9 +2848,12 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 			lock_sock(ssk);
 
 			/* limit retransmission to the bytes already sent on some subflows */
-			info.sent = 0;
+			info.sent = offset;
 			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
 								    dfrag->already_sent;
+			DEBUG_NET_WARN_ON_ONCE(!before64(sent_seq,
+							 dfrag->data_seq +
+							 info.limit));
 
 			/*
 			 * make the whole retrans decision, xmit, disallow
@@ -2896,14 +2897,85 @@ static void __mptcp_retrans(struct sock *sk)
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
+		already_retrans = !dfrag->already_sent ||
+				  !before64(msk->snd_una, dfrag->data_seq +
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
+		if (!dfrag)
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
+		if (!dfrag || !dfrag->already_sent)
+			break;
+	}
+
+	/* Attempt data-fin retransmission only when the RTX queue is empty. */
+	if (!need_retrans) {
+check_data_fin:
 		if (mptcp_data_fin_enabled(msk)) {
 			struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -2911,30 +2983,13 @@ static void __mptcp_retrans(struct sock *sk)
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
2.54.0


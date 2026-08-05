Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8634570C4
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946650; cv=none; b=kerW9DuoCqMFZKqLVcmjmP3Jq4pQn75NK9BtdKpUd4S5wwUYJ94mH/HiNRrD+HznX6nTCgkRpertYevzoi1wIoh/7/LCQBNMlDTjzpl+TMqTXCeqoe799qLDCqHfP2dEOdm+UPELYJPRIMEszpgLkhAaN3QWxA3+tUEuPE6ypiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946650; c=relaxed/simple;
	bh=uBXP3rPIFBhIV7Dj3UlgcIdK0p2nMnf5IXNW8M+JQEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=J6n+4O7SG/uL9FYCW4RG0ukI2GVtY3DXKXtJO9KJJU1kn6zYiua+xdvEfzsZ/X19TfOTNMHGS2ABHonqyWYQJ2WNtvI4tdf0Jez8rzg0jlcamy2cTyrZYvTrb2fqRfmAfxeEmYN18NdHe0l8Q4GOruLDUeKsLIenNN26omc2zZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6NEKVDm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6NEKVDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785946647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk+r6NPUTF0pbIKUxv/ssTi13kPjUehtrHZVUKrrSzg=;
	b=c6NEKVDm2E5HEQAagDX2pU3oyvVuq/iPnj+/SoZ3CcoQvygVqY8xoNN3PREvu9XDqxCjlJ
	Sn7vNJSY3kQMQb9oTsALU24MGnKyukj9BRAyxtKWN7Mq1HPvbF0EPVK0tkhkGLx00DG2Us
	bmCvXYb5BwypGeLc6tSL1XCHf4E6UYA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-Ifhc8HQsM5uHyWxJdI8DVA-1; Wed,
 05 Aug 2026 12:17:26 -0400
X-MC-Unique: Ifhc8HQsM5uHyWxJdI8DVA-1
X-Mimecast-MFC-AGG-ID: Ifhc8HQsM5uHyWxJdI8DVA_1785946645
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59C581956041
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C491180049F
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/7] mptcp: let the retrans scheduler do its job
Date: Wed,  5 Aug 2026 18:17:10 +0200
Message-ID: <362268703ac205e887e5bbc50f92f9099792a3d8.1785943854.git.pabeni@redhat.com>
In-Reply-To: <cover.1785943854.git.pabeni@redhat.com>
References: <cover.1785943854.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xtSlI0-NGQWb8sb6YEMIGDns_mKYh12ek9C6OT_nwWg_1785946645
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

Tested-by: Gang Yan <yangang@kylinos.cn>
Tested-by: Geliang Tang <geliang@kernel.org>
Acked-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v<n> -> v<n+1>:
  - many cleanups, since the stale logic is invoked only once outside
    the main loop
---
 net/mptcp/protocol.c | 88 ++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 88167edc6598..4099ca915f70 100644
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
 
@@ -2856,15 +2854,60 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_data_frag *dfrag;
+	u64 retrans_seq, sent_seq;
+	bool need_retrans;
 	int err, len;
 
 	mptcp_pm_chk_stale(msk);
 
-	mptcp_clean_una_wakeup(sk);
+	for (;;) {
+		/* Get an updated and consistent rtx queue status. */
+		mptcp_data_lock(sk);
+		__mptcp_clean_una_wakeup(sk);
+		retrans_seq = msk->snd_una;
+		dfrag = mptcp_rtx_head(sk);
+		need_retrans = !!dfrag;
+		mptcp_data_unlock(sk);
+
+		err = mptcp_sched_get_retrans(msk);
+		if (err)
+			break;
 
-	err = mptcp_sched_get_retrans(msk);
-	dfrag = mptcp_rtx_head(sk);
-	if (!dfrag) {
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
+	}
+
+	/* Attempt data-fin retransmission only when the RTX queue is empty. */
+	if (!need_retrans) {
 		if (mptcp_data_fin_enabled(msk)) {
 			struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -2872,30 +2915,13 @@ static void __mptcp_retrans(struct sock *sk)
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
2.55.0


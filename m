Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971943672A5
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878793; cv=none; b=j1SnMwTtznJrC7FF+yowrzRi8qnUs8RLtWj3yB6xXb9B/9U2Gv05pm9+SkhW9tI+/DRbcabRt3y5F8YFoLBSxknx60R7ls7HwiaRoTmYTidVEfUq8FMziAOspjEF0DLO9ZyS58HPXioVT5swH4P8hasIiEjqLe3SS0N+4vPv8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878793; c=relaxed/simple;
	bh=Lpu15/VfjcIKu1wH4b6hqHLc/k7f44wSUyzhCndF5H0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=B03YGHkf+M84SXklHPIL6WJJHTMaZyAvAKPYFE4aAUHA4dO4Q7vveTzhsvvZxewpqCc/BOwgKb6C5v/duORZBsVmIRJFY70MFKwOX5SpxMIs7ljJIQC0tR+dc017I146pm48uRegfR3Znbh9c6da56a72SPXmlM4bTphg57NbHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrTjYEF0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrTjYEF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779878790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N49mGoK39nxDoRa859djFTKOB1o/NBpw/CBBDpyDpJE=;
	b=BrTjYEF0Dc3jIZoxeE3D4rGiuiWB7Pn1u0WYyTyYhebSbhGt+EwVmx8Z3NZY75P9EKFMV5
	ws8X74l/hPsMPJ8Ioo/7n9e1bl5ofbWcTpuOpqjvJLvSUbwfPnstLJdoRSe6/pQPn1I+5n
	7uF4VaNhJlfYErgkCf1m/jV4a/zclNc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-4Nku0ghgNFKX3BbTLwyqBg-1; Wed,
 27 May 2026 06:46:29 -0400
X-MC-Unique: 4Nku0ghgNFKX3BbTLwyqBg-1
X-Mimecast-MFC-AGG-ID: 4Nku0ghgNFKX3BbTLwyqBg_1779878788
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7269C18005B5
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A88CE19560AB
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v9 mptcp-next 6/6] mptcp: let the retrans scheduler do its job.
Date: Wed, 27 May 2026 12:45:36 +0200
Message-ID: <f16e4cf87d041b650be81e6e0f072c3abfeeb29b.1779876523.git.pabeni@redhat.com>
In-Reply-To: <cover.1779876523.git.pabeni@redhat.com>
References: <cover.1779876523.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nedoVJu_9HGMFSOhvCX05Ee_ABdUulruBwqgPcGaj3k_1779878788
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
 - sashiko see issues when dfrag = mptcp_rtx_head(sk) != NULL and
   dfrag->already_sent == 0. That condition should not possible: if
   mptcp_rtx_head() is not NULL there should be some data already
   sent.
---
 net/mptcp/protocol.c | 117 +++++++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e21ace787a32..51509c062768 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1199,13 +1199,6 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
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
@@ -2828,8 +2821,12 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2839,6 +2836,7 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled)) {
+			u16 offset = sent_seq - dfrag->data_seq;
 			u16 copied = 0;
 
 			mptcp_subflow_set_scheduled(subflow, false);
@@ -2848,9 +2846,12 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
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
@@ -2894,45 +2895,97 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_data_frag *dfrag;
+	bool retransmitted = false;
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
+	mptcp_data_unlock(sk);
+	if (!dfrag)
+		goto check_data_fin;
+
+	for (;;) {
+		bool already_retrans;
+		u64 sent_seq;
+
+		/* The scheduler may clean the RTX queue. */
+		get_page(dfrag->page);
+
+		/* The default scheduler will kick "stale" logic. */
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
+		} else if (after64(msk->snd_una, retrans_seq)) {
+			retrans_seq = msk->snd_una;
+		}
+		mptcp_data_unlock(sk);
+		if (!dfrag)
+			break;
+
+		len = __mptcp_push_retrans(sk, dfrag, retrans_seq);
+		if (len < 0)
+			goto clear_scheduled;
+
+		retransmitted = true;
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
+	/* Data fin retransmission needed only if no data retransmission took
+	 * place, and RTX queue is empty.
+	 */
+check_data_fin:
 	if (!dfrag) {
-		if (mptcp_data_fin_enabled(msk)) {
+		if (!retransmitted && mptcp_data_fin_enabled(msk)) {
 			struct inet_connection_sock *icsk = inet_csk(sk);
 
 			WRITE_ONCE(icsk->icsk_retransmits,
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


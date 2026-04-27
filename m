Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B313ECBC3
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319550; cv=none; b=VkIXe47c90DAptKokZ/u+/oJEpBu5MBqoAijFQxC8hTf7uNRFdoSSoEZ8vvCaK2GZRNR6GfXMJDaH6zJhrjr2TQKuGjB0fwgiWYMaox5j7CD2K8P5XWKsATRR8jKJbNIAOtwtuZk6dg+2D/ZUfvjjRZNdVfkJPcyHW9xEgy54es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319550; c=relaxed/simple;
	bh=Vd9qBXPRaiKNerJzIHd6b7mFYw5CP7GqmnqKFmhFcmY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aq1i5s545QSO8gVZnqrIcfT8529vT83Fcmwmkm+/P4mXQCRGquCxReQdjfUqnYCKo0UDQZrXrkPGbwkQ2JJTHg6ICGJwYx7QiVTyNzAJnaK2UVo066jW+rVCb8K2Sc3n2lFob+GoOrBR0tAf02zFPkkwK0ymyv5/5tOnyfLMn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRrEmq8R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRrEmq8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xl4II/IQ4CCFA8AYAQmdS5PV4JEqtOSTwLOeEwEcidY=;
	b=gRrEmq8RZ9xPaR0Y79/vD5WqPIWxNLquss3Vp5QnXnVHTDh35L0H9RBRiX0R+bMwz/UGTs
	qA8RKt/gJIHocg+Wtzb4XBhhhKHrlj+DRaAKYhUbAK8P/fNesZ8x7XrPxKUV1hoCOe+vHx
	54IRi1Q5OkSwIZ5LeyMwZ/9roKWyafU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-0TmzMMBdNUKHQWBUIExzlQ-1; Mon,
 27 Apr 2026 15:52:27 -0400
X-MC-Unique: 0TmzMMBdNUKHQWBUIExzlQ-1
X-Mimecast-MFC-AGG-ID: 0TmzMMBdNUKHQWBUIExzlQ_1777319546
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A4C6180049F
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94FDC300070A
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 10/10] mptcp: let the retrans scheduler do its job.
Date: Mon, 27 Apr 2026 21:52:08 +0200
Message-ID: <988764c7973b89d5105876aebb04098f855b7535.1777318959.git.pabeni@redhat.com>
In-Reply-To: <cover.1777318959.git.pabeni@redhat.com>
References: <cover.1777318959.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RSiy5y_9f9FxOSH3jd4LZCvCHNX9fZOXkfkZJ_UZ_FY_1777319546
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
v1 -> v2:
  - fix retrans sequence update (sashiko)
---
 net/mptcp/protocol.c | 82 ++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 64991a5ee206..a4b2d664af80 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1219,13 +1219,6 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
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
@@ -2840,7 +2833,10 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	sk_error_report(sk);
 }
 
-/* Retransmit the specified data fragment on all the selected subflows. */
+/*
+ * Retransmit the specified data fragment on all the selected subflows,
+ * starting from the specified sequence
+ */
 static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 {
 	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
@@ -2906,42 +2902,60 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_data_frag *dfrag;
+	u64 retrans_seq;
 	int err, len;
 
-	mptcp_clean_una_wakeup(sk);
-
-	/* first check ssk: need to kick "stale" logic */
-	err = mptcp_sched_get_retrans(msk);
-	dfrag = mptcp_rtx_head(sk);
-	if (!dfrag) {
-		if (mptcp_data_fin_enabled(msk)) {
-			struct inet_connection_sock *icsk = inet_csk(sk);
+	mptcp_data_lock(sk);
+	__mptcp_clean_una_wakeup(sk);
+	retrans_seq = msk->snd_una;
+	mptcp_data_unlock(sk);
 
-			WRITE_ONCE(icsk->icsk_retransmits,
-				   icsk->icsk_retransmits + 1);
-			mptcp_set_datafin_timeout(sk);
-			mptcp_send_ack(msk);
+	for (;;) {
+		/* first check ssk: need to kick "stale" logic */
+		err = mptcp_sched_get_retrans(msk);
+		dfrag = mptcp_rtx_head(sk);
+		if (!dfrag) {
+			if (mptcp_data_fin_enabled(msk)) {
+				struct inet_connection_sock *icsk;
+
+				icsk = inet_csk(sk);
+				WRITE_ONCE(icsk->icsk_retransmits,
+					   icsk->icsk_retransmits + 1);
+				mptcp_set_datafin_timeout(sk);
+				mptcp_send_ack(msk);
+				break;
+			}
 
-			goto reset_timer;
+			if (!mptcp_send_head(sk))
+				goto clear_scheduled;
+			break;
 		}
 
-		if (!mptcp_send_head(sk))
-			goto clear_scheduled;
-
-		goto reset_timer;
-	}
+		if (err)
+			break;
 
-	if (err)
-		goto reset_timer;
+		/* Skip the data already retransmitted in this run */
+		while (dfrag && !before64(retrans_seq, dfrag->data_seq +
+					  dfrag->data_len))
+			dfrag = list_is_last(&dfrag->list, &msk->rtx_queue) ?
+				NULL : list_next_entry(dfrag, list);
+		if (!dfrag || !dfrag->already_sent)
+			break;
 
-	len = __mptcp_push_retrans(sk, dfrag);
-	if (len < 0)
-		goto clear_scheduled;
+		len = __mptcp_push_retrans(sk, dfrag);
+		if (len < 0)
+			goto clear_scheduled;
 
-	msk->bytes_retrans += len;
-	dfrag->already_sent = max(dfrag->already_sent, len);
+		retrans_seq += len;
+		msk->bytes_retrans += len;
+		dfrag->already_sent = max(dfrag->already_sent, len);
 
-reset_timer:
+		/* Attempt the next fragment only if the current one is
+		 * completely retransmitted
+		 */
+		if (dfrag->already_sent < dfrag->data_len)
+			break;
+	}
 	mptcp_check_and_set_pending(sk);
 
 	if (!mptcp_rtx_timer_pending(sk))
-- 
2.53.0


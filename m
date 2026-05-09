Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60D35B63D
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312971; cv=none; b=MEtzcXKOxxcNs6G/9n+v25GCwoAi967BzrPvd8fLkGKCBjDwIw/3aWmORdkOnqWJeobhHFz/fzeTc/cDsihKLQSHbxY0qvSBiTyamUNEn/eTlPpNd3TmWjR9wHuXg7T/xS91XPRakw5A6w7W1aOldnE981uxVNzRtQ37J0ewL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312971; c=relaxed/simple;
	bh=AuPFjFvnEVi5+DDWRQ6TzJpXahWw7LopJnEYK+Rus6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Wl61KLyhKhiUBovvJ/LlUxNzPnWflioAxFS+DXxqhWFapELihT22RZGHB8jSlZSmu1yMYAUSESTbNDZ1W6uhy90CEsOZbF9st5PWjQLFgd12BjGz/baUmd9HiR8hnmqHilrJoqxbB4jGoGDcWzh9vg5uwzal/c0kJ88HSggeDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmCyw8Or; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmCyw8Or"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778312968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMkB4UhAE0gUiWxy8sTzjgf8YZZvO6CR+ZulXny0WiQ=;
	b=HmCyw8OrmvGI9EIWtlCr3PnSk6uuVdOPqlViIel/Qi+3bL7KRvZRW90ZykRgm8ly+kcv7d
	Jmb6ItSO3EfZHQhF+/j2i/hqu558Yfd4QQRq5QZ7Unn7tfAlHpMGRNUoaCSoyHkp+Iu1vK
	O9vq3DEbQYipr74OWP0Z8VMIfZz9li4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-XjwICCGgO5KCLUe20fLATg-1; Sat,
 09 May 2026 03:49:26 -0400
X-MC-Unique: XjwICCGgO5KCLUe20fLATg-1
X-Mimecast-MFC-AGG-ID: XjwICCGgO5KCLUe20fLATg_1778312965
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2E271956080;
	Sat,  9 May 2026 07:49:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AEB431800374;
	Sat,  9 May 2026 07:49:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 12/12] mptcp: let the retrans scheduler do its job.
Date: Sat,  9 May 2026 09:48:32 +0200
Message-ID: <12423a1b9db777fc5326d9e623a5d28bb72fe8b2.1778312843.git.pabeni@redhat.com>
In-Reply-To: <cover.1778312843.git.pabeni@redhat.com>
References: <cover.1778312843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yKM4bD6wcpL6aNn-GduZ7W5nF10xlI9gLkrEkCYsGe8_1778312965
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
v3 -> v4:
  - avoid quadratic behavior, fix retrans_seq update
  - fix rtx timer re-schedule miss

v2 -> v3:
  - fix infinite loop issue (should address tls tests failures)

v1 -> v2:
  - fix retrans sequence update (sashiko)
---
 net/mptcp/protocol.c | 104 +++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fd4b5eb40383..067143efdd8e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1231,13 +1231,6 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
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
@@ -2847,8 +2840,12 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2858,6 +2855,7 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled)) {
+			u16 offset = sent_seq - dfrag->data_seq;
 			u16 copied = 0;
 
 			mptcp_subflow_set_scheduled(subflow, false);
@@ -2867,9 +2865,12 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
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
@@ -2913,41 +2914,88 @@ static void __mptcp_retrans(struct sock *sk)
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
+		dfrag->already_sent = max(dfrag->already_sent, len);
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
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 
-- 
2.54.0


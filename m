Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F773A7D63
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027655; cv=none; b=Kcc7/zHl8GkiQ75+UWJ1hfo3r3N/AP84mpoISAZPR4TJpOkBO69XDaJ2twYe1gCXAGdLB97s9dUib6rrgFW1Ti50j2g1/H9OlQMMLKXC2EPjhGiefAR7Bc/r3UjMm9/H556+EuBnfD8/GYODgxDNi2U7tykfFSn3siEPQVyVDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027655; c=relaxed/simple;
	bh=CfXnFV2gWYtYPY3Y6u87PP/gkx9Y5/XR94iNmm4nsq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=C/OqcZipkJ4pJagZdkQQVwo+ejaW5idnHa27iAEbMVy0V/RaQqVduCAdDjr762zpuKZ0SVnh23sKp9nk0tLwqTSgVz1rBIs/qm1pZHkxJy7vquDKqGRPS+GyqvpiMKv7+nmA+CqMbgQC7e0JQIcoBgAifqBi22xg4Dm9gYYeBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQO/1GgL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQO/1GgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVrl7LFcKKV5ZILij7dtHipIB4Kag9M7QWs1/PVcYP0=;
	b=LQO/1GgLAH5EgxFE4T9HmG7VZBx2G1Nxkk06gAgdK+5m4/tudmPTlGcm74xYbsr+xbAEV/
	TV2H7eTJYv0sks3v22dlDkUSuSDaCSYVnQ4njjZ7UdfL6SodHrJS1yBm2kd/jeRVO6vMFg
	X+qzN+CCOTifQpEXWH9o+kub7YRyMG8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-FEjUEBdxPtaFv5qcZFX7wg-1; Thu,
 06 Aug 2026 10:47:26 -0400
X-MC-Unique: FEjUEBdxPtaFv5qcZFX7wg-1
X-Mimecast-MFC-AGG-ID: FEjUEBdxPtaFv5qcZFX7wg_1786027646
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBF161956088
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B4F9195DF92
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 3/7] mptcp: let the retrans scheduler do its job
Date: Thu,  6 Aug 2026 16:45:24 +0200
Message-ID: <440b3bfee3d81da9d153856fe4c11049cae82066.1786026372.git.pabeni@redhat.com>
In-Reply-To: <cover.1786026372.git.pabeni@redhat.com>
References: <cover.1786026372.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _eYWJ_JUqp6y5frwiRcKCzKSVqPFe-La0x9SWLmXefk_1786027646
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
v2:
  - do not restart from first frag at each loop iteration

v<n> -> v<n+1>:
  - many cleanups, since the stale logic is invoked only once outside
    the main loop
---
 net/mptcp/protocol.c | 106 ++++++++++++++++++++++++++++++-------------
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
2.55.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162363DBD50
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039780; cv=none; b=WNMlAV4vfKmRBQvM7lb26lTSm4hYRvDWCGa0KvAi9SU24ieceKaZ/n/jEZiewx8ISLetJFYvTL5pxEWGFaSfdCmmpeEnBiWLtdRnPqYDhb23E8wcGRRQcFwlP8GRNbKkmbNqOsxtoOSPMBMWP3jHVmKpvfq9ULBSP1lD4c2QU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039780; c=relaxed/simple;
	bh=i1Fa5EmGbH7EGvtNEdYzFZHhtdFE35cRLXLdb96WxFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=uI86FKdDEE5hUTzvR6BwN7+RVx6MKTEuLFtD5GxQR22Tjw/O5Sjs9ucCkRSr+hxxRpMTnWVhcBrQiYFNICryzC4oLecFBNnhCirJMKD0V0geZ9VolDxhDQ+adxrsCbozyQPN1AgBCVyxOgZ8gIFKqBOT5ZUGEvSIus//nh7lob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbKxBXbz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbKxBXbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777039776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGCsxIhe8yzdJJsBasL8bHKr4NJv/XP6/OOeFBxzLHE=;
	b=IbKxBXbzBI9w/TjuJxSlzxPH6aXMwLde1fPAZjckKx+N6KPiV0cv2jFQGAFEpsQWmQ1GRX
	+UYwdkpn7JKS3Xj8tjo38DCjNByBTddEb3TmVsHVaIPY1ipl3RRp8JL+ddwRh/Hin1QNwb
	cPpX9lPFtE/za/F/lWz/qGfrMNkP/e8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-TC7s6AdLNCqUhTMrmdH93A-1; Fri,
 24 Apr 2026 10:09:30 -0400
X-MC-Unique: TC7s6AdLNCqUhTMrmdH93A-1
X-Mimecast-MFC-AGG-ID: TC7s6AdLNCqUhTMrmdH93A_1777039768
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91B1F1935317;
	Fri, 24 Apr 2026 14:09:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D80E7300757C;
	Fri, 24 Apr 2026 14:09:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [PATCH mptcp-next v1 9/9] mptcp: let the retrans scheduler do its job.
Date: Fri, 24 Apr 2026 16:08:42 +0200
Message-ID: <b42256d8267f46246aad4faf825d02be782bfa2b.1777038888.git.pabeni@redhat.com>
In-Reply-To: <cover.1777038888.git.pabeni@redhat.com>
References: <cover.1777038888.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KuN_WjHde2Lf9rzISp1HEqjks8ynE1aKBBEe-K5D8tw_1777039768
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
 net/mptcp/protocol.c | 84 +++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 093c50a43bcb..da84bf5410da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1187,13 +1187,6 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
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
@@ -2820,8 +2813,12 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	sk_error_report(sk);
 }
 
-/* Retransmit the specified data fragment on all the selected subflows. */
-static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
+/*
+ * Retransmit the specified data fragment on all the selected subflows,
+ * starting from the specified sequence
+ */
+static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag,
+				u64 retrans_seq)
 {
 	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2840,7 +2837,7 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 			lock_sock(ssk);
 
 			/* limit retransmission to the bytes already sent on some subflows */
-			info.sent = 0;
+			info.sent = retrans_seq - dfrag->data_seq;
 			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
 								    dfrag->already_sent;
 
@@ -2886,42 +2883,55 @@ static void __mptcp_retrans(struct sock *sk)
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
+				struct inet_connection_sock *icsk = inet_csk(sk);
+
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
-
-	if (err)
-		goto reset_timer;
+		if (err)
+			break;
 
-	len = __mptcp_push_retrans(sk, dfrag);
-	if (len < 0)
-		goto clear_scheduled;
+		/* Skip the data already retransmitted in this run */
+		while (dfrag && !before64(retrans_seq, dfrag->data_seq +
+					  dfrag->already_sent))
+			dfrag = list_is_last(&dfrag->list, &msk->rtx_queue) ? NULL :
+				list_next_entry(dfrag, list);
+		if (!dfrag || !dfrag->already_sent)
+			break;
 
-	msk->bytes_retrans += len;
-	dfrag->already_sent = max(dfrag->already_sent, len);
+		len = __mptcp_push_retrans(sk, dfrag, retrans_seq);
+		if (len < 0)
+			goto clear_scheduled;
+		if (!len)
+			break;
 
-reset_timer:
+		retrans_seq += len;
+		msk->bytes_retrans += len;
+		dfrag->already_sent = max(dfrag->already_sent, len);
+	}
 	mptcp_check_and_set_pending(sk);
 
 	if (!mptcp_rtx_timer_pending(sk))
-- 
2.53.0


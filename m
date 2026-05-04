Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB43E0220
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909241; cv=none; b=LERlihjLcW19+o14Pjkm53WqHfLvFxdWdJcfuNYZcIw9pB1KRQ/UM/EcZNqXArNs42M2w71vj+HeNmrnGwc8gJACvc0xHz8jnb4b45XSCsrLZccNpfRwt8ZvOMtZNfrVq6vPj7SHQ0f8K7FXaC0YlK+yDEun/J0Bza7q/m9UtLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909241; c=relaxed/simple;
	bh=lBLgg514H0pWEgioBFSiT/ROfw5V88SGqL5mmcO2BEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=r+kLlTIu91QSQyE6vakFleyGW3QXVrqjS8v/4/2T0SyOCNFz80wkM1mYp6tlcZGUryzCn7+UbxEGFIgohJh7VY5oxR9qHsMrMEnGhaTsbnqc9PoRxqm/nvZe/3BXr9rHvASrMutTAZABhByjiXHZxvMT+fL4i8H7Xgu2b5KA7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOCAU/Wv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOCAU/Wv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777909239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YO/cM6iifmq2P8TNLiRT+PrI8AShge/uMWNW2UlNWBE=;
	b=WOCAU/WvDHLPQY1v3B+hVFXoGxJhvJklhKOGicH0T5NKHUisKaSdiUXo45jmP1FLWUMZid
	bRnCgQNV2RWeGUU2+XkxPEG83/7ilkverxKp/rQ117ICvxv26QAwibru0Dn0Uye3S4uS2B
	4g8HNrsI1bjebTfrqjtDLH3V/lyhx7Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-b7ldnkILPXmJ-galpK_30w-1; Mon,
 04 May 2026 11:40:35 -0400
X-MC-Unique: b7ldnkILPXmJ-galpK_30w-1
X-Mimecast-MFC-AGG-ID: b7ldnkILPXmJ-galpK_30w_1777909234
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDC471956046;
	Mon,  4 May 2026 15:40:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A056719560B1;
	Mon,  4 May 2026 15:40:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v3 mptcp-next 10/10] mptcp: let the retrans scheduler do its job.
Date: Mon,  4 May 2026 17:40:05 +0200
Message-ID: <f1aee4d02ef4ff1e8303a16fa65154c0619d3425.1777908248.git.pabeni@redhat.com>
In-Reply-To: <cover.1777908248.git.pabeni@redhat.com>
References: <cover.1777908248.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OiJ_yQmToqCtV4JmmFv4c6breiWs4YaX6qIRmQNnpw4_1777909234
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
v2 -> v3:
  - fix infinite loop issue (should address tls tests failures)

v1 -> v2:
  - fix retrans sequence update (sashiko)
---
 net/mptcp/protocol.c | 82 ++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 47ad0d776a12..032711f9b9dc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1217,13 +1217,6 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
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
@@ -2838,7 +2831,10 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2904,42 +2900,60 @@ static void __mptcp_retrans(struct sock *sk)
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
+		 * completely retransmitted.
+		 */
+		if (len < dfrag->data_len)
+			break;
+	}
 	mptcp_check_and_set_pending(sk);
 
 	if (!mptcp_rtx_timer_pending(sk))
-- 
2.54.0


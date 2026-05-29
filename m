Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81B3C454F
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051493; cv=none; b=daUOXshOQtPXtTd2c9TXNW/aKrbp1BvWa6COAFZ6+E3B2QVxu/NNM0ylcA4DBwWShXSPNY4cmWX0K9tQsHeiEftoZFUyCn0SVGIsehFcHqBaZI/x5u8n1mFxCP/pVrf8Rl+wpWvZBK8VMMfPqbg31TMwGRgizbzktsEcyyUVG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051493; c=relaxed/simple;
	bh=tLIoZ0X+8OVh+2FxIO0d/v/7KUopjB+LKXZ95YApcWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=U74MQGHy3io7daT0W9hJ0X0IAUbI0cBdR1/v6vZ7taaFpQZI2S77idcY6S68eS7/026a1/eMGMS3tXPPq2feNlW0Dkj1gOToCPpGPQ9y+aalPx4C0C1zw25OKeE97f0gcat7K+YqT7Jx2Vkl967bItlxCHAlwZv7M4hAbzyiKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhmJxhgL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhmJxhgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780051491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfYrL32wqJfYkOGUtZju/LDH7ze1uekDno+OFGYpcFo=;
	b=HhmJxhgL/JkxxpUjFPBCXzTbVtKPCC+OfaQ3VJqsI/0Z0xATcb1vbUKNL+Nt6HqB9TJ7HR
	cBYrNnrnRx8Qfrn3PrxB8WtDSi1SHI3m6rZaDKRpmnRrRtDjvT4r+dCuDedMuvyDfhS1yk
	aSG0DhvMB/LcNEvH2F3Cs8J74YdaGZk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-ckbv2W2jOfWW-HOANOksUg-1; Fri,
 29 May 2026 06:44:48 -0400
X-MC-Unique: ckbv2W2jOfWW-HOANOksUg-1
X-Mimecast-MFC-AGG-ID: ckbv2W2jOfWW-HOANOksUg_1780051487
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDFBD1800359
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F9EE19560A3
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v10 mptcp-next 2/3] mptcp: move the retrans loop to a separate helper
Date: Fri, 29 May 2026 12:44:30 +0200
Message-ID: <5d88f8b6cf46c0afd2ccd31332faf3a57dc5dff3.1780049797.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: _fd7fvAuZVeFw4isi3aK9WR0atVyYa3fUnK2KE7UK-k_1780051487
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is a cleanup in order to make the next patch simpler.
No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 74 +++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 03234e8cc26c..51756800edc2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2830,41 +2830,14 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	sk_error_report(sk);
 }
 
-static void __mptcp_retrans(struct sock *sk)
+/* Retransmit the specified data fragment on all the selected subflows. */
+static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 {
 	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
-	int ret, err;
-	u16 len = 0;
-
-	mptcp_clean_una_wakeup(sk);
-
-	/* first check ssk: need to kick "stale" logic */
-	err = mptcp_sched_get_retrans(msk);
-	dfrag = mptcp_rtx_head(sk);
-	if (!dfrag) {
-		if (mptcp_data_fin_enabled(msk)) {
-			struct inet_connection_sock *icsk = inet_csk(sk);
-
-			WRITE_ONCE(icsk->icsk_retransmits,
-				   icsk->icsk_retransmits + 1);
-			mptcp_set_datafin_timeout(sk);
-			mptcp_send_ack(msk);
-
-			goto reset_timer;
-		}
-
-		if (!mptcp_send_head(sk))
-			goto clear_scheduled;
-
-		goto reset_timer;
-	}
-
-	if (err)
-		goto reset_timer;
+	int ret, len = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled)) {
@@ -2892,7 +2865,7 @@ static void __mptcp_retrans(struct sock *sk)
 			    !msk->allow_subflows) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
-				goto clear_scheduled;
+				return -1;
 			}
 
 			while (info.sent < info.limit) {
@@ -2915,6 +2888,45 @@ static void __mptcp_retrans(struct sock *sk)
 			release_sock(ssk);
 		}
 	}
+	return len;
+}
+
+static void __mptcp_retrans(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_data_frag *dfrag;
+	int err, len;
+
+	mptcp_clean_una_wakeup(sk);
+
+	/* first check ssk: need to kick "stale" logic */
+	err = mptcp_sched_get_retrans(msk);
+	dfrag = mptcp_rtx_head(sk);
+	if (!dfrag) {
+		if (mptcp_data_fin_enabled(msk)) {
+			struct inet_connection_sock *icsk = inet_csk(sk);
+
+			WRITE_ONCE(icsk->icsk_retransmits,
+				   icsk->icsk_retransmits + 1);
+			mptcp_set_datafin_timeout(sk);
+			mptcp_send_ack(msk);
+
+			goto reset_timer;
+		}
+
+		if (!mptcp_send_head(sk))
+			goto clear_scheduled;
+
+		goto reset_timer;
+	}
+
+	if (err)
+		goto reset_timer;
+
+	len = __mptcp_push_retrans(sk, dfrag);
+	if (len < 0)
+		goto clear_scheduled;
 
 	msk->bytes_retrans += len;
 	dfrag->already_sent = max(dfrag->already_sent, len);
-- 
2.54.0


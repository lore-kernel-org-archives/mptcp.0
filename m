Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B391ADC83
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909236; cv=none; b=PlOEyuMu3ah3IlIJHevwE41BacdJbhxd30DdhcwTgOkD9I9PYOljdk1Ev2pKd+NJRpJLLms215xkIGfsX0MwbyCKLyZL5FnLbjzYzXC+vM/TRMY3KcBzPLU9zfOE4qBDlO1mDsvzWkInDZcFUNGXU2VlfkZQ15JJtzABqa84yuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909236; c=relaxed/simple;
	bh=nLxBi+Y5NiCY4rTJb7yHBWPT079eupLE2iKpJTI0Zvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VFK20J6fMlNJ306f68Ub5IBi7pL9tEHf2XkPgNWVLqAs1OqY3hWHYkcdcd8sIP3tLxjvZ4Lwb+nRpVdhqU/twsJp/uGu3Fq7PMyviniJfpxEOXka7gnLqrcXlIIPvQXv5s3GBT+trf/WtbABg47LzuEFrJ/lVljLs+edS7bKhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeUZFfdV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeUZFfdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777909234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtjuzcD9jRegl3docGQhCv264aAqXVj4zqr2kCgHhvg=;
	b=NeUZFfdVF6S+Sq5k4HfvazwufG4q1STvI4qdVA/9aFG+mo4AVsDMVvSDycPWRMw/mZePSB
	YS9RAlW0gq8n3zdoViw4GklPjMjNwLHTgkxkRZ6xBa3GjlxoreD/wVFXVvqITkk0LD6vKy
	nKeO5AVRuHBnEJgVrTYlgPI7HM2GyRI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-ROKYSYUrMx-o06b0bEaCww-1; Mon,
 04 May 2026 11:40:33 -0400
X-MC-Unique: ROKYSYUrMx-o06b0bEaCww-1
X-Mimecast-MFC-AGG-ID: ROKYSYUrMx-o06b0bEaCww_1777909232
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DA5B195608F;
	Mon,  4 May 2026 15:40:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E532719560A6;
	Mon,  4 May 2026 15:40:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v3 mptcp-next 09/10] mptcp: move the retrans loop to a separate helper
Date: Mon,  4 May 2026 17:40:04 +0200
Message-ID: <6365656b52c65ad2d445769732ad6a9575db23c1.1777908248.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: mWilTV8sqa2VpVHbLa10-ELHpJQt9P1DiPKpg50tp_U_1777909232
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
index 2db6d076ce48..47ad0d776a12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2838,41 +2838,14 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2900,7 +2873,7 @@ static void __mptcp_retrans(struct sock *sk)
 			    !msk->allow_subflows) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
-				goto clear_scheduled;
+				return -1;
 			}
 
 			while (info.sent < info.limit) {
@@ -2923,6 +2896,45 @@ static void __mptcp_retrans(struct sock *sk)
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


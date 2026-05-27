Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4F3F167C
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878794; cv=none; b=C4hPr8hmlRrES3Ng7H5v9fwxHQCt7Be62uFjhEolq4gs939LEeNJEmoI6cVzj+VGaZIwA4sKweelT29MDXF4OAupP9xvRsawB1VTMF+Afw4kj2u6UOd+P0iqNKEPTMJo6mDGReCFgkA980m1FXbTryZbOPPM8nNqdA/3VK16VpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878794; c=relaxed/simple;
	bh=+2eHdt5xo3PxyAt1lRSd8jHkovb1kBrGbnzBirL4hIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OvUfiREnfAEiE/oZwU1Bca30oMSiP7RQ8egpZySWIgYEwGJ0N6H4DbKG1ADrmdZuxxbgTYQDVf1CggXXkK2z7m9HmLrze7ECsZCNDj7CMyI+g43+OIXkPbL8xbK+wKZQF+HucgH7y+1X9WfxsgnVHoRlz6YAeEHkc09HE62gQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQ9PQ5Gn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ9PQ5Gn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779878789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxUzqrkXgztsAtDvzCQ0yinO3IxUwiR5GcLa9GW9GhU=;
	b=DQ9PQ5GnwkU/iGuyuADPBS2bfwpMMlQL/1iHfgPkX/0knrskkJK9yIPRyodvuH6qjg6gGQ
	eAATJC2Y+c9LC9NMkGkniMpLJ4Z9b+A9dyfCwA70xgFEGuumY3Oi8QrXmhm5R2yh05jAEH
	x3qvJkXfGPNR8kO39M0kM5DLocSHZRs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-_wISqaL4PwWWO_TZ0t1NXg-1; Wed,
 27 May 2026 06:46:28 -0400
X-MC-Unique: _wISqaL4PwWWO_TZ0t1NXg-1
X-Mimecast-MFC-AGG-ID: _wISqaL4PwWWO_TZ0t1NXg_1779878787
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33803180047F
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 567A019560AB
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v9 mptcp-next 5/6] mptcp: move the retrans loop to a separate helper
Date: Wed, 27 May 2026 12:45:35 +0200
Message-ID: <863c4d94afef82be90c91a9fe17a402aa76f2d06.1779876523.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: VuLu6Xr-HupUiswsiY9hPjusLDDIOIbLYODjfwxzoJU_1779878787
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
index 29cb10c02ed8..e21ace787a32 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2828,41 +2828,14 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2890,7 +2863,7 @@ static void __mptcp_retrans(struct sock *sk)
 			    !msk->allow_subflows) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
-				goto clear_scheduled;
+				return -1;
 			}
 
 			while (info.sent < info.limit) {
@@ -2913,6 +2886,45 @@ static void __mptcp_retrans(struct sock *sk)
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


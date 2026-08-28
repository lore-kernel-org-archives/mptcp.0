Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176940BCD4
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912303; cv=none; b=bHxYxH/0ZSzSv4yn4j/4dcsZC/4gnwmpyRRXNV1COkszatN6MmclRgYPutXxlFGMsXsHj0Q5+s9xwvdmXppi4ogB9WlMBwYlXBRCyhN6THocduPZC71c9WDFnQLC+d0mrPtyqmDMK9N+FBRTN0xMNkzImMNlbJfCJAkXXUlftUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912303; c=relaxed/simple;
	bh=BjW9VQ11NnowZovp2lrhRcsaSj4FRziEM7/tWxlmVLk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jNWMOZStWXdoJFmo3yzEvH6C2u4xIwuQX1Jm7GghPQOsUIBcVxUB4wU1kHI/YM2+Vy2tgfNrdqAvaYOsG1Z/dSR6sGwqHsG+nwaCJ13UBRaCmpxkUfbVNnGefNL9Th21oXsnxQ/FLO2IBujEjZiPZ4sUKsrY9y04TgzLRtf0C04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMMhfo1b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMMhfo1b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787912299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZK1iz8HqIHe2tu0lgBEKE1OskBVA0+cHAy0MGvD7zps=;
	b=YMMhfo1ba8peUiX9XabFk3l0VHmXdCvmn+Cl59QaPH+AEU19WfVGmhVPokpxOoZ4KCdtYm
	D2gxd78NPQ+tpLpthIUgBTfbfBavDUGuJcjiWOTpbIS4PMb+rqOcYqeWW+zFaK2iUsDX5h
	DCubN5vt8s39ztRzeyrHmjuCLZQpebk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-9c-ZcAhaM9uRxZLHU3Ux3Q-1; Fri,
 28 Aug 2026 06:18:17 -0400
X-MC-Unique: 9c-ZcAhaM9uRxZLHU3Ux3Q-1
X-Mimecast-MFC-AGG-ID: 9c-ZcAhaM9uRxZLHU3Ux3Q_1787912296
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C23711802648
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 10:18:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E2AD3000223
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 10:18:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 1/2] mptcp: prevent race between disconnect() and rtx
Date: Fri, 28 Aug 2026 12:17:13 +0200
Message-ID: <f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787911017.git.pabeni@redhat.com>
In-Reply-To: <cover.1787911017.git.pabeni@redhat.com>
References: <cover.1787911017.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZOW1ssMMQujF_FVO4q0JZEeD7pa9_zwLuvKTvhM-prE_1787912296
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Sashiko noted that the two event can race, leading to inconsistent
status. Prevent the race using the synchronous timer stop operation.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f22d64ab1c53..1e7e59d497c5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3625,6 +3625,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* We are on the fastopen error path. We can't call straight into the
@@ -3637,8 +3638,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	mptcp_set_state(sk, TCP_CLOSE);
 
-	mptcp_stop_rtx_timer(sk);
-	mptcp_stop_tout_timer(sk);
+	/* The later subflow close can not kick again the tout timer,
+	 * as the msk is already in closed status.
+	 */
+	msk->timer_ival = icsk->icsk_rto_min;
+	sk_stop_timer_sync(sk, &sk->mptcp_retransmit_timer);
+	icsk->icsk_mtup.probe_timestamp = 0;
+	sk_stop_timer_sync(sk, &icsk->mptcp_tout_timer);
 
 	mptcp_pm_connection_closed(msk);
 
-- 
2.55.0


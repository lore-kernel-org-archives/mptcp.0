Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874C379C37
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739222; cv=none; b=e7t01KrGxgmUZYnMYIIk3WWDD7odndDgFRQkOv2+7QSLWYfnB5V5keHAZc1/YUIqXLaxCNZjOktTWnq6EGQv6vwj3ciUSQVFuHY/aDub2cDM0bgF1glyyx1KEoN04uyrY29cphbmme3DTosJbwhcbsJ8LKbXbOdTG+oKb+niH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739222; c=relaxed/simple;
	bh=BjW9VQ11NnowZovp2lrhRcsaSj4FRziEM7/tWxlmVLk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=qKsMG9bllJAqBgoAltpjepmMHF3zfeuNVyHnXdBEx9LdEgHacFf6eQIcfEnU28kbyUvYd0yU20cfMI5K9RNk64d4PYTd5gB92JUtgOXBgcO3NGrDs5KNGgi0vTJL2DY0kir6rcHMArlRuk1yezcdrvtHmuej6XnlXLUwoulVWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aoxd6o4Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aoxd6o4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787739219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZK1iz8HqIHe2tu0lgBEKE1OskBVA0+cHAy0MGvD7zps=;
	b=Aoxd6o4Q2bUdi6+N1334TNaAA+xKYIsrODFa5OtZAkuO3naZywHDfBxMQiIRgrcATnmVMx
	z+1p/VdoXguF/imDan312jd2zB1Bw7/JUY4g8qjDwd5vc7yXhAAN7iwZtchWoxdqIhbK/g
	2B+U3v/djN2+526G0N9DsymYXVemmZY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-SH5zz56gP1uN95IdDVZBjQ-1; Wed,
 26 Aug 2026 06:13:38 -0400
X-MC-Unique: SH5zz56gP1uN95IdDVZBjQ-1
X-Mimecast-MFC-AGG-ID: SH5zz56gP1uN95IdDVZBjQ_1787739217
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DCA219539BF
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:13:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.61])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9A7E434
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:13:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] mptcp: prevent race between disconnect() and rtx
Date: Wed, 26 Aug 2026 12:13:29 +0200
Message-ID: <f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787739122.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I01dAi3-Vtj1A-u8rquYpZ9oN8ibd0f35BjU7U5Gwpg_1787739217
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


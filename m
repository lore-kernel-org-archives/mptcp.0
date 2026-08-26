Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0334B35C68B
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760690; cv=none; b=YVd/9LFrBT3GDiRjS460+Ta08tnGyMKgbQK90nszFARp5043kqnU0JSvvQt/h0J5q8sPatMfxsGs2pp7yCsUiMmwRSgPAtlEtzueWl9Q9klYp8lnidkgwyy+Ac8PdLJ0jZMxOBXCd4Q25GCzh9JMPVIiqr/DANw3jj118Uw35V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760690; c=relaxed/simple;
	bh=BjW9VQ11NnowZovp2lrhRcsaSj4FRziEM7/tWxlmVLk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WQrAuny3TQXMcZbymECsjAxpMEQ/aiDWT+r/N7BwX2mLlbSMCcaF8tXymK6Zbtsdt6NY/X515E7CzYhyq900FQUNwCl5lLDX0xy/CEOQAgeX/4cdQ/TNEg3e8gJCfn+3MAsYMatR+HENxJtJUxpMxqIHiTljOstAy5EOR6Txzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLR3Rsg2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLR3Rsg2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787760687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZK1iz8HqIHe2tu0lgBEKE1OskBVA0+cHAy0MGvD7zps=;
	b=MLR3Rsg25Cjit/298B4cv5hOBNoxtSJGgfa/272YJOiw+jCkMzbQ/h2520htulzzhhBzwJ
	OmDwh+OtzYLrTsMd+qqazN4U7ChbwfdxuHGj7L07SCs6LdwmHOpu8bErIuEyuVieunKpjc
	L6v7SCb6XjUy9loCTqFXBeQ3MOmDtCQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-y5_5wfq5OMKCcUGRETLW8g-1; Wed,
 26 Aug 2026 12:11:25 -0400
X-MC-Unique: y5_5wfq5OMKCcUGRETLW8g-1
X-Mimecast-MFC-AGG-ID: y5_5wfq5OMKCcUGRETLW8g_1787760684
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A029195DE2A
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:11:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B78891800605
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:11:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 1/2] mptcp: prevent race between disconnect() and rtx
Date: Wed, 26 Aug 2026 18:10:59 +0200
Message-ID: <f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787760635.git.pabeni@redhat.com>
In-Reply-To: <cover.1787760635.git.pabeni@redhat.com>
References: <cover.1787760635.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bqEuMLRNU-7U5eLsx9L81JrE9r9D2hF72sFd524A-m4_1787760684
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


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDB480DC1
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946653; cv=none; b=PJezq36nD+RaQKesO4CKh13jzGC6FzTP8HW90E47fk+6nvYetcpoonGQTQprw9qG6TefVpOw5xXq9nFirzD2MViBv4ZE/EIV79bgwubvjq4XYBrGlRHw8lp0xbDGKFCuGgfsfvKQz7+BJtrCz5aNJzBZRr2SShFHaYVE/7yrxi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946653; c=relaxed/simple;
	bh=AcZ4SnIi4u9RWKC5Oohthp10msSvKptUBRjLp+h9dM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iS6gCw35tHp+zJwBX4pBEOVQBbCa+8faLuBZnavZnAk7R9JOOPqX5S6uKDc4HaDaG75NvqMvJS2EM/ai6V3ByCQnOiF43HAFsZ17xaCxf2gvUMuoTRb4do1nXOQAzwVoO6OqHX7IcfhcNptIvZXojr2FUtvNZZBfI07Mnr7EDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzZOghyr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzZOghyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785946651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qN/8Ca0DVCBGbG/aHqRsoCeETXP2Ko+yoq2PmoPniz0=;
	b=LzZOghyrhWDQ2WNjYSbd/o/aEeBF1n3TIsD+ahSaRtaJ6RaWC8Cf8AxFI6knO8T1MSghKN
	Yzo2z1UorO5QRD7XXlBIzYNj0giNhgoA54OlvJoHzK5cfFAnQc4wf2EN5xHmPdqdIl79VR
	c2dkfMF0JS+Ce/jjjDwETs4NBdJg7WY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-XTNZwptiOiOfhn7zEDkOzQ-1; Wed,
 05 Aug 2026 12:17:29 -0400
X-MC-Unique: XTNZwptiOiOfhn7zEDkOzQ-1
X-Mimecast-MFC-AGG-ID: XTNZwptiOiOfhn7zEDkOzQ_1785946648
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD8551800611
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DBEA1800598
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 5/7] mptcp: enforce hard limit on backlog flushing
Date: Wed,  5 Aug 2026 18:17:12 +0200
Message-ID: <f6cc4f18fbca8d2e83e4ddd8170b54f17b234841.1785943854.git.pabeni@redhat.com>
In-Reply-To: <cover.1785943854.git.pabeni@redhat.com>
References: <cover.1785943854.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gkKQTyK-LVu3UZSfAPIxyLuj-3cnQkppIe_7iij4-EY_1785946648
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently a wild producer could keep the backlog flushing operation
spinning for an unbound time.

Since the previous patch the amount of data present in the backlog is
hard-limited. Move the backlog len update at the end of the flush loop to
prevent it spinning forever.

Also, no need to splice back the remaining skbs list into the backlog, as
such list is always empty after each backlog processing loop.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d2303711c337..df1801699cce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2229,7 +2229,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool moved = false;
 
-	*delta = 0;
 	while (1) {
 		prefetch(skb->next);
 		list_del(&skb->list);
@@ -2266,20 +2265,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 	return true;
 }
 
-static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
-				  struct list_head *skbs)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
-	list_splice(skbs, &msk->backlog_list);
-}
-
 static bool mptcp_move_skbs(struct sock *sk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct list_head skbs;
 	bool enqueued = false;
-	u32 moved;
+	u32 moved = 0;
 
 	mptcp_data_lock(sk);
 	while (mptcp_can_spool_backlog(sk, &skbs)) {
@@ -2287,8 +2278,8 @@ static bool mptcp_move_skbs(struct sock *sk)
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
 
 		mptcp_data_lock(sk);
-		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
 	mptcp_data_unlock(sk);
 
 	if (enqueued && mptcp_epollin_ready(sk))
@@ -3729,12 +3720,12 @@ static void mptcp_release_cb(struct sock *sk)
 	__must_hold(&sk->sk_lock.slock)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 moved = 0;
 
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
 		struct list_head join_list, skbs;
 		bool spool_bl;
-		u32 moved;
 
 		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
 		if (!flags && !spool_bl)
@@ -3767,9 +3758,9 @@ static void mptcp_release_cb(struct sock *sk)
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
-		if (spool_bl)
-			mptcp_backlog_spooled(sk, moved, &skbs);
 	}
+	if (moved)
+		WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
 
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
-- 
2.55.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B403B5E19
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027654; cv=none; b=T/6Gh57jQS8hgNP9V/w4SU0A8ccjpfQPftCwYXNgv52EQHnspEcUNnTbW3EnleOVZug9ZI/+tsf91j4bdjXpbA5Gjuzsrjt8mSNsLXQU8O97lcT8rEMGaCiTMKP+POgfbQo8OhUn82/hhRCWnBWBfrTiAwqNIboucIKyN4jrAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027654; c=relaxed/simple;
	bh=aVgwuqL/YyFyIyKfhfaMaxQ1t6tx0VLkwZf3gOOGw4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FYd9Pr98cmqSk5nIq1BPO3qrtv+dEOKx9tRUsMzwbCUJerhUJLkf27qSQ5lmrSAYodjPkhlnFR6SljHLi6vEtNXcVq09tLflUDGV4o16wELp1FXG1/7qgtBu4d4n8ng2kwogNpADFNoGErnsOaJ44VfbZwEZ4fOFyW+ZfO/fArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EArbLvdT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EArbLvdT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kuCb+F5SAZceNMUon89F2o3Bm+bZrtl4giopBLbI84g=;
	b=EArbLvdTl+vCfciugB5to/81nMG0K8m6P2yza5b804AndJNsgsmo2+0ayFC4vUQIyYr/3W
	xA6mYJZmhUMQquuR+G5er+PBZDRg1d2U0Sf30JjtJINZgdmiixDBpKs+Wkfa6ONcclQDIe
	by8Gy/CunX7nbFY4uKemXIdSPPHgxcM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-jLLkyrt3NcmjkgQDkMYw_A-1; Thu,
 06 Aug 2026 10:47:30 -0400
X-MC-Unique: jLLkyrt3NcmjkgQDkMYw_A-1
X-Mimecast-MFC-AGG-ID: jLLkyrt3NcmjkgQDkMYw_A_1786027649
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BDA11956044
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E80A1956094
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 5/7] mptcp: enforce hard limit on backlog flushing
Date: Thu,  6 Aug 2026 16:45:26 +0200
Message-ID: <580549c43001f887cd093a78a34629d33f034a4c.1786026372.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: VtMDh6iFmp_NMHFqV4GjvczazlO1dN9PwzXFkxRnQbs_1786027649
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
index cfb77a32518a..d96fbdc34dbb 100644
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
@@ -3747,12 +3738,12 @@ static void mptcp_release_cb(struct sock *sk)
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
@@ -3785,9 +3776,9 @@ static void mptcp_release_cb(struct sock *sk)
 
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


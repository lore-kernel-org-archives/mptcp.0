Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34233F9A04
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210120; cv=none; b=hUC2Gk5ChYXrY/inMEZm8/J9qvaCWtT0O5x1SgEW5NXZNu+OqKpnjI3AA82ecSVpErlI8JiB+afdUzb145LvQzGJhltM5j15QRdyRmdCaG0d9gHFRfTXZrs+ok2lwIw8bD87yq/FLHikrv+oMZHpZHYFFH6zOHqwWcD3LLNIVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210120; c=relaxed/simple;
	bh=AiCKmnTuhad4YKXiiIPs5YqOryoajZqXcHeO3iCK9Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fuhyDlD2wB7KeOBhmOgT6UBGyC4ugP/GARKk4UXo3EC+QS72jehzFImyJwf3VmZOyWb0XWwopzfQqkAav3F32PfFVpgbb7UUvuK1XLlTgU0LxGZPzC6tADpZUBm6yWOB20J9eHUoIN42eK5BKsEGt9pBgneLqTjxujC68FDu2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdIMPpKv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdIMPpKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779210118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58LVag1jSIgoH5IULd9XEmzrf4yObCCTxrNqURZAXqM=;
	b=EdIMPpKvB7q2lQ2ISvu2aftqMl5hAlJBGaxGb3e9NFSi6MMM4kxqGXUVXX0lttPHQIiMTd
	UIWvoy8gekiC/OqsI836/msIc0vs5tZvG+QUrdHW2r+F8fSJxCGPWMxZ7ojn91iNbDl48J
	vTT2Im/XdX4spt+/o37LQZJbZr2h4ks=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-l-eSPM3ePcagusDuFCSl0Q-1; Tue,
 19 May 2026 13:01:54 -0400
X-MC-Unique: l-eSPM3ePcagusDuFCSl0Q-1
X-Mimecast-MFC-AGG-ID: l-eSPM3ePcagusDuFCSl0Q_1779210113
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EEF61956055;
	Tue, 19 May 2026 17:01:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96BBF18004A3;
	Tue, 19 May 2026 17:01:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v7 mptcp-next 3/7] mptcp: enforce hard limit on backlog flushing
Date: Tue, 19 May 2026 19:01:37 +0200
Message-ID: <b8c42d90313a33569edfea0d9709183b6d50a805.1779210016.git.pabeni@redhat.com>
In-Reply-To: <cover.1779210016.git.pabeni@redhat.com>
References: <cover.1779210016.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5LnKueQfib6HW108jYVVIT-t6oRmjam_isxHiec_9c8_1779210113
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
---
 net/mptcp/protocol.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e53abd1f814f..0e41596b6397 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2228,7 +2228,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool moved = false;
 
-	*delta = 0;
 	while (1) {
 		prefetch(skb->next);
 		list_del(&skb->list);
@@ -2265,20 +2264,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
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
@@ -2286,8 +2277,8 @@ static bool mptcp_move_skbs(struct sock *sk)
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
 
 		mptcp_data_lock(sk);
-		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
 	mptcp_data_unlock(sk);
 	if (enqueued && mptcp_epollin_ready(sk))
 		sk->sk_data_ready(sk);
@@ -3672,12 +3663,12 @@ static void mptcp_release_cb(struct sock *sk)
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
@@ -3710,9 +3701,9 @@ static void mptcp_release_cb(struct sock *sk)
 
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
2.54.0


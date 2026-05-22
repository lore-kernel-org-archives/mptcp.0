Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAF25A359
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486266; cv=none; b=mwFBswF9dYbUINmeWcdE6ctDMu5O/3S+N6Pdg4s/1NSFfbU+RzKX4CpkHaNt8RBg//6ucpX9+06BaBVVo2uaey/eSaR4drdT0NL7zxgLRwgMdAqrfRUoLyk6cqV5sZjrIRuguN7GjpXk/68Ax2dm9M4WwqTCIsERk01aBC313F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486266; c=relaxed/simple;
	bh=yXe8oe9zXHi+/FXJN23sAxhVk3EtK9wjENkr4g9PQx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Exu9fA8vrZ4DaxBmSxII+EuVCAJDQAsViS9uNEf7Mo/AtZlVhdL3L8VuXAWkuhefSAFnytGtG5IQSQ8eCf26nQfxb46/XCc0Od1Lotvj5rlmE9h/Dsy7QJdGzxX12HxUbKVYn+PEM6ZTe/Eqhbxe8vDLYJF/JA9C9s9l0cmHTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2TNY7JU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2TNY7JU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779486264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53U6O2iU4fV/wMSSQpJzcN5YR/QTazvSSRPrfJ/Pw3E=;
	b=V2TNY7JU8kIcYCpZ6wTlqKeB3lkJxG6uvvXA5BsWQOahcCz02DmqTulZG615U2pncvA0uW
	YceYGkhpKpJGipGiW2G37be2TYqjRc5FLX8mvalDz2u+lCbFg2J++ktMTd4gF8TmGt9uiA
	WfDwK9JOK//q7scoMVpYol0cUQhrpuk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676--6Qnox_sM8mh-2uC2ggDyw-1; Fri,
 22 May 2026 17:44:18 -0400
X-MC-Unique: -6Qnox_sM8mh-2uC2ggDyw-1
X-Mimecast-MFC-AGG-ID: -6Qnox_sM8mh-2uC2ggDyw_1779486257
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FAFF19560B5;
	Fri, 22 May 2026 21:44:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 247611800347;
	Fri, 22 May 2026 21:44:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v8 mptcp-next 6/9] mptcp: enforce hard limit on backlog flushing
Date: Fri, 22 May 2026 23:43:47 +0200
Message-ID: <bd01cfa9f5e7267d3dc77f5c5f8ab879897a9775.1779485511.git.pabeni@redhat.com>
In-Reply-To: <cover.1779485511.git.pabeni@redhat.com>
References: <cover.1779485511.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: adoCQlov3BRdVFINB4_5fHSs-vJR4B8-xeVtJyAItOs_1779486257
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
index 1d498c601145..03d6f8658467 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2230,7 +2230,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool moved = false;
 
-	*delta = 0;
 	while (1) {
 		prefetch(skb->next);
 		list_del(&skb->list);
@@ -2267,20 +2266,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
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
@@ -2288,8 +2279,8 @@ static bool mptcp_move_skbs(struct sock *sk)
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
 
 		mptcp_data_lock(sk);
-		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
 	mptcp_data_unlock(sk);
 	if (enqueued && mptcp_epollin_ready(sk))
 		sk->sk_data_ready(sk);
@@ -3678,12 +3669,12 @@ static void mptcp_release_cb(struct sock *sk)
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
@@ -3716,9 +3707,9 @@ static void mptcp_release_cb(struct sock *sk)
 
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


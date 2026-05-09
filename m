Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474637AA98
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312956; cv=none; b=KoACy6d48yaQOmJ9qnVR6CxJJUvkOw+PvR3bDT66kpUuYlncW79MPtP4VsD16rAi9FukWwxZRRcRs75fkdsVLQzTCNMb3JDtf00sZRqfX9c609xyTiKnCa+jVQmkyWylsRmFSMP0cY4DlllyZzNY7xXeNL4Dt5i4NcicwY+7aHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312956; c=relaxed/simple;
	bh=7MaERAeqcKTrEv10JN7EF2hxQUhjahhaOgEknPsDsfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HKLokiXxFbKO2ny6mRax5pGGuERUfXNqkVyEYze95TxcAzpZMB5nvGr9EWTsWh9y0aKkthINrgLxK1Sufj/YGd7LPy65B9TlJpZb2rMxq+6fIe4LmsH9hzseg8PkPfb8Cfp/PEWQJSy93ZCZ4bCx+qvh4gImvf6ruPvgn6Jq4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LY2SMUl2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY2SMUl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778312954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5Ed9P4jg0pggi3U+CHHwzBkVTw9luG4n8YLRCogm08=;
	b=LY2SMUl2pve7jYGj3lA/ddeN3mhpo9TRocYuXI7Ywvsrd9BX1U2iVy3+kSgnvegd4erMW9
	CxsRagsRJj/qgq/RI/C7Rghw5QUqN4BXqBGERFZC4KYPqI7zWGy9p6ReKCux/ebSi3moj9
	Dhsd1P6rN+RUQcl3t521blLkNem3WpI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-XDsXA-BTNRmM4DKQ-J_44Q-1; Sat,
 09 May 2026 03:49:13 -0400
X-MC-Unique: XDsXA-BTNRmM4DKQ-J_44Q-1
X-Mimecast-MFC-AGG-ID: XDsXA-BTNRmM4DKQ-J_44Q_1778312952
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24A0819560BB;
	Sat,  9 May 2026 07:49:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10C7318001EF;
	Sat,  9 May 2026 07:49:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 03/12] mptcp: enforce hard limit on backlog flushing
Date: Sat,  9 May 2026 09:48:23 +0200
Message-ID: <1b843778da0a0f5bab3833f5129c29993f70f126.1778312843.git.pabeni@redhat.com>
In-Reply-To: <cover.1778312843.git.pabeni@redhat.com>
References: <cover.1778312843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7AFcRzItdsEDGEY2NGcg4BCEfznhz47fhjDiTxcUoho_1778312952
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
index 492ee9ca9c77..b329d1dc4161 100644
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
 	return enqueued;
 }
@@ -3670,12 +3661,12 @@ static void mptcp_release_cb(struct sock *sk)
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
@@ -3708,9 +3699,9 @@ static void mptcp_release_cb(struct sock *sk)
 
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


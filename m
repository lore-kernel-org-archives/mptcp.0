Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DB17735
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2ATIuqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705331814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40IVMdXobO+Gs4HXo+JLXHijtGK669Uqy9VpZjnqPcs=;
	b=K2ATIuqCEJJTvz1vCYajZkoCPbOWQ1x8eY2vZK0PL8NzRwKLN2om4UMovjbuTvTnzoHlpr
	FY0KXkfotWhwJVHT6GqdXpCgwuehzW+cZHOrzfoLJe1Lu4OKUYFwEEpyB7EZpKph7UG/a0
	CsLC8/gqirM/uX31XMgvM4kmuAWDawc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-g60aTGb-Mcy_lg00juuICw-1; Mon, 15 Jan 2024 10:16:48 -0500
X-MC-Unique: g60aTGb-Mcy_lg00juuICw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1024811E9C
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 70E8E1C060B3
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/4] mptcp: drop the push_pending field
Date: Mon, 15 Jan 2024 16:16:30 +0100
Message-ID: <8363fd6542b179fdc30b42e78c922b0201c9f3fd.1705331716.git.pabeni@redhat.com>
In-Reply-To: <cover.1705331716.git.pabeni@redhat.com>
References: <cover.1705331716.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Such field is there to avoid acquiring the data lock in a few spots,
but if adds complexity to the already non trivial locking schema.

All the relevant call sites (mptcp-level reinjection, set socket optins),
are slow-path, drop such field in favor of 'cb_flags', adding the relevant
locking.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 12 ++++++------
 net/mptcp/protocol.h |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e570c7e2b18c..5129e1235cc5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1505,8 +1505,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 void mptcp_check_and_set_pending(struct sock *sk)
 {
-	if (mptcp_send_head(sk))
-		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
+	if (mptcp_send_head(sk)) {
+		mptcp_data_lock(sk);
+		mptcp_sk(sk)->cb_flags |= BIT(MPTCP_PUSH_PENDING);
+		mptcp_data_unlock(sk);
+	}
 }
 
 static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
@@ -3145,7 +3148,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
-	msk->push_pending = 0;
 	msk->recovery = false;
 	msk->can_ack = false;
 	msk->fully_established = false;
@@ -3333,8 +3335,7 @@ static void mptcp_release_cb(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	for (;;) {
-		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED) |
-				      msk->push_pending;
+		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
 		struct list_head join_list;
 
 		if (!flags)
@@ -3350,7 +3351,6 @@ static void mptcp_release_cb(struct sock *sk)
 		 *    datapath acquires the msk socket spinlock while helding
 		 *    the subflow socket lock
 		 */
-		msk->push_pending = 0;
 		msk->cb_flags &= ~flags;
 		spin_unlock_bh(&sk->sk_lock.slock);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f7b9c1b995df..ebb32b7563be 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -286,7 +286,6 @@ struct mptcp_sock {
 	int		rmem_released;
 	unsigned long	flags;
 	unsigned long	cb_flags;
-	unsigned long	push_pending;
 	bool		recovery;		/* closing subflow write queue reinjected */
 	bool		can_ack;
 	bool		fully_established;
-- 
2.43.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548517DB
	for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681256621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DrNVWIPb5Ynpl5ydo6gKX6vmxwV/sMCHRh7FcMdlbWc=;
	b=eJX95aEQvlQg3w/WHi59a7AIC9rQ0w/99x9YHh3t4qjlvxdj7eRHAzvMRQcolofnb7iVEt
	frjuud4GcYBbYoCv+RPdddyBrF+PkAIYQdIBngsVEGDQ/QsD3r6PopUzlKAAxi0Ny0ND/K
	efC620WAKwRCTpx/nx9JvcoJVN5lCcU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-8Y1-ewwxPVyJKF_Z3LYmuA-1; Tue, 11 Apr 2023 19:43:39 -0400
X-MC-Unique: 8Y1-ewwxPVyJKF_Z3LYmuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E21D1C05ABD;
	Tue, 11 Apr 2023 23:43:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E009447CD0;
	Tue, 11 Apr 2023 23:43:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net] Squash-to: "mptcp: fix accept vs worker race"
Date: Wed, 12 Apr 2023 01:43:30 +0200
Message-Id: <484c6fbff67a4587215d88e17f3a6688eb2c9ea1.1681256534.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The current patch has at least 2 issues:
- the first subflow context cleanup can race with
  the path manager: we should acquire the full ssk socket.
- such subflow can accept data while the msk is closed, leading
  to fwd memory corruption.

Address the issues moving the ssk cleanup into plain mptcp_close_ssk
and detaching the ssk from the msk before closing the latter: no
input data can land to the msk at that point.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 23 ++++++++++++++---------
 net/mptcp/subflow.c  | 19 +++++--------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 045570ebad96..4d1c099f4b29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2373,20 +2373,25 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool need_push, dispose_it;
 
-	/* If the first subflow moved to a close state, e.g. due to
-	 * incoming reset and we reach here before accept we need to be able
-	 * to deliver the msk to user-space.
-	 * Do nothing at the moment and take action at accept and/or listener
-	 * shutdown.
-	 * If instead such subflow has been destroyed, e.g. by inet_child_forget
-	 * do the kill
+	/* If the first subflow moved to a close state before accept, e.g. due
+	 * to an incoming reset, mptcp either:
+	 * - if either the subflow or the msk are dead, destroy the context
+	 *   (the subflow socket is deleted by inet_child_forget) and the msk
+	 * - otherwise do nothing at the moment and take action at accept and/or
+	 *   listener shutdown - user-space must be able to accept() the closed
+	 *   socket.
 	 */
 	if (msk->in_accept_queue && msk->first == ssk) {
-		if (!sock_flag(ssk, SOCK_DEAD))
+		if (!sock_flag(sk, SOCK_DEAD) && !sock_flag(ssk, SOCK_DEAD))
 			return;
 
-		/* ensure later check in mptcp_worker will dispose the msk */
+		/* ensure later check in mptcp_worker() will dispose the msk */
 		sock_set_flag(sk, SOCK_DEAD);
+		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+		mptcp_subflow_drop_ctx(ssk);
+		release_sock(ssk);
+		msk->first = NULL;
+		return;
 	}
 
 	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c6ae5ddd3bb0..38d43a15502b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -716,9 +716,11 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 		return;
 
 	list_del(&mptcp_subflow_ctx(ssk)->node);
-	subflow_ulp_fallback(ssk, ctx);
-	if (ctx->conn)
-		sock_put(ctx->conn);
+	if (inet_csk(ssk)->icsk_ulp_ops) {
+		subflow_ulp_fallback(ssk, ctx);
+		if (ctx->conn)
+			sock_put(ctx->conn);
+	}
 
 	kfree_rcu(ctx, rcu);
 }
@@ -1852,23 +1854,12 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 		sk = (struct sock *)msk;
 
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
-		ssk = msk->first;
 		next = msk->dl_next;
 		msk->dl_next = NULL;
 
 		__mptcp_unaccepted_force_close(sk);
 		release_sock(sk);
 
-		/* the first subflow is not touched by the above, as the msk
-		 * is still in the accept queue, see __mptcp_close_ssk,
-		 * we need to release only the ctx related resources, the
-		 * tcp socket will be destroyed by inet_csk_listen_stop()
-		 */
-		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
-		mptcp_subflow_drop_ctx(ssk);
-		release_sock(ssk);
-		sock_put(ssk);
-
 		/* lockdep will report a false positive ABBA deadlock
 		 * between cancel_work_sync and the listener socket.
 		 * The involved locks belong to different sockets WRT
-- 
2.39.2


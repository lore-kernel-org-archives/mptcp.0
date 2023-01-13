Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C1AD55
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673634076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crnLFwiuGnAVoBbhcD9j2SENj04mwlUFDL73n8KsthI=;
	b=HuYage9hCWM0evOLOc75VNYJthjhCVemYG6DKl8LCSt51DhhWUc7oPwPMo/cbbVMBMpNB3
	mf7stIN/iK2rMvgHvOWYW650nudP8nPpXnYL6q7p1PC2JVKRtSQ35r/MoUd9pJ520MNwBi
	gj84O5nKClPCy+W/h1aawOac7yEFUzQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-tBymzAojOHm_akWgJnL4DQ-1; Fri, 13 Jan 2023 13:21:06 -0500
X-MC-Unique: tBymzAojOHm_akWgJnL4DQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 988CE802D2A
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2595E4078903
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/9] mptcp: refactor passive socket initialization.
Date: Fri, 13 Jan 2023 19:20:48 +0100
Message-Id: <af1471c9fe3d89a88a62507657a20cc854c7dfa9.1673629755.git.pabeni@redhat.com>
In-Reply-To: <cover.1673629755.git.pabeni@redhat.com>
References: <cover.1673629755.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After commit 30e51b923e43 ("mptcp: fix unreleased socket in
accept queue") unaccepted msk sockets go throu complete
shutdown, we don't need anymore to delay inserting the first
subflow into the subflow lists.

The reference counting deserve some extra care, as __mptcp_close()
is unaware of the request socket linkage to the first subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Notes:
- this schema assumes that the TCP code will never drop
a request socket from the receive queue after the 3whs. I tried
to verify such assumption as strictily as I could, but more eyes
more then welcome!
- this will cause pktdrill failure for close_before_accept.pkt, because
the msk will become fully established before accept() - imho a
good thing - and send out add_addr earlier.

The pktdrill test change should be easier.
---
 net/mptcp/protocol.c | 17 -----------------
 net/mptcp/subflow.c  | 31 ++++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 003b44a79fce..d298d629b3b2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -825,7 +825,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_socket && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, sk->sk_socket);
 
-	mptcp_propagate_sndbuf((struct sock *)msk, ssk);
 	mptcp_sockopt_sync_locked(msk, ssk);
 	return true;
 }
@@ -3753,22 +3752,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 		lock_sock(newsk);
 
-		/* PM/worker can now acquire the first subflow socket
-		 * lock without racing with listener queue cleanup,
-		 * we can notify it, if needed.
-		 *
-		 * Even if remote has reset the initial subflow by now
-		 * the refcnt is still at least one.
-		 */
-		subflow = mptcp_subflow_ctx(msk->first);
-		list_add(&subflow->node, &msk->conn_list);
-		sock_hold(msk->first);
-		if (mptcp_is_fully_established(newsk))
-			mptcp_pm_fully_established(msk, msk->first, GFP_KERNEL);
-
-		mptcp_rcv_space_init(msk, msk->first);
-		mptcp_propagate_sndbuf(newsk, msk->first);
-
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ec54413fb31f..0b7e7a6606f5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -749,6 +749,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct mptcp_options_received mp_opt;
 	bool fallback, fallback_is_fatal;
 	struct sock *new_msk = NULL;
+	struct mptcp_sock *owner;
 	struct sock *child;
 
 	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
@@ -823,6 +824,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		ctx->setsockopt_seq = listener->setsockopt_seq;
 
 		if (ctx->mp_capable) {
+			owner = mptcp_sk(new_msk);
+
 			/* this can't race with mptcp_close(), as the msk is
 			 * not yet exposted to user-space
 			 */
@@ -831,14 +834,14 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			/* record the newly created socket as the first msk
 			 * subflow, but don't link it yet into conn_list
 			 */
-			WRITE_ONCE(mptcp_sk(new_msk)->first, child);
+			WRITE_ONCE(owner->first, child);
 
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */
 			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
-			mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
-			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
+			mptcp_pm_new_connection(owner, child, 1);
+			mptcp_token_accept(subflow_req, owner);
 			ctx->conn = new_msk;
 			new_msk = NULL;
 
@@ -846,15 +849,21 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			 * uses the correct data
 			 */
 			mptcp_copy_inaddrs(ctx->conn, child);
+			mptcp_propagate_sndbuf(ctx->conn, child);
+
+			mptcp_rcv_space_init(owner, child);
+			list_add(&ctx->node, &owner->conn_list);
+			sock_hold(child);
 
 			/* with OoO packets we can reach here without ingress
 			 * mpc option
 			 */
-			if (mp_opt.suboptions & OPTION_MPTCP_MPC_ACK)
+			if (mp_opt.suboptions & OPTION_MPTCP_MPC_ACK) {
 				mptcp_subflow_fully_established(ctx, &mp_opt);
+				mptcp_pm_fully_established(owner, child, GFP_ATOMIC);
+				ctx->pm_notified = 1;
+			}
 		} else if (ctx->mp_join) {
-			struct mptcp_sock *owner;
-
 			owner = subflow_req->msk;
 			if (!owner) {
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
@@ -1836,9 +1845,17 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 		sock_hold(sk);
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 		next = msk->dl_next;
-		msk->first = NULL;
 		msk->dl_next = NULL;
 
+		/* The upcoming mptcp_close is going to drop all the references
+		 * to the first subflow, ignoring that one of such reference is
+		 * owned by the request socket still in the accept queue and that
+		 * later inet_csk_listen_stop will drop it.
+		 * Acquire an extra reference here to avoid an UaF at that point.
+		 */
+		if (msk->first)
+			sock_hold(msk->first);
+
 		do_cancel_work = __mptcp_close(sk, 0);
 		release_sock(sk);
 		if (do_cancel_work) {
-- 
2.38.1


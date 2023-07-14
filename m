Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1211CB0
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/+CyuAFUsS2dG9VT2iSfjbZNq5NHronoP47JWA+POk=;
	b=g8S9jMR91L6MybNCt/Frigkitb95NPNoTJyfdRJykK0XB1bN4h02AEA7y58B+DIVjTiLFD
	sYVvg2KDLWU+uQWuuEeMvxJX/FJQNmTmRcTmbEfmuCeTUgbtm1paIhZZQDrxEx8+XBSDOU
	NyB1g1sjsaMFQVLVtx4wRz5D1OlMbJc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-0d6X0chAMfentq22topuIA-1; Fri, 14 Jul 2023 07:30:07 -0400
X-MC-Unique: 0d6X0chAMfentq22topuIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D82B5185A792
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66F5E2166B25
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 13/13] mptcp: get rid of msk->subflow
Date: Fri, 14 Jul 2023 13:29:44 +0200
Message-ID: <e0870b3de6c2d87f4b831ea5193d2c2bc5156b5a.1689334116.git.pabeni@redhat.com>
In-Reply-To: <cover.1689334116.git.pabeni@redhat.com>
References: <cover.1689334116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Such field is now unused just as a flag to control the first subflow
deletion at close() time. Introduce a new bit flag for that and finally
drop the mentioned field.

As an intended side effect, now the first subflow sock is not freed
before close() even for passive sockets. The msk has no open/active
subflows if the first one is closed and the subflow list is singular,
update accordingly the state check in mptcp_stream_accept().

Among other benefits, the subflow removal, reduces the amount of memory
used on the client side for each mptcp connection, allows passive sockets
to go through successful accept()/disconnect()/connect() and makes return
error code consistent for failing both passive and active sockets.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - drop unneeded msk->first check in mptcp_accept(), only data corruption
   could clear that

Side notes:
- syzkaller will be likely happy about the new code path to possibly
  exploit
- we could possibly avoid allocating the 'socket' struct at
  __mptcp_subflow_connect() time, but that will require more invasive
  helpers creation in inet core.
---
 net/mptcp/protocol.c | 25 ++++++-------------------
 net/mptcp/protocol.h | 13 ++++++-------
 2 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 47079c257e52..9f00a0288a0a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -91,7 +91,6 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 		return err;
 
 	WRITE_ONCE(msk->first, ssock->sk);
-	WRITE_ONCE(msk->subflow, ssock);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
@@ -101,6 +100,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	/* This is the first subflow, always with id 0 */
 	subflow->local_id_valid = 1;
 	mptcp_sock_graft(msk->first, sk->sk_socket);
+	iput(SOCK_INODE(ssock));
 
 	return 0;
 }
@@ -2263,14 +2263,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	return min_stale_count > 1 ? backup : NULL;
 }
 
-static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
-{
-	if (msk->subflow) {
-		iput(SOCK_INODE(msk->subflow));
-		WRITE_ONCE(msk->subflow, NULL);
-	}
-}
-
 bool __mptcp_retransmit_pending_data(struct sock *sk)
 {
 	struct mptcp_data_frag *cur, *rtx_head;
@@ -2349,7 +2341,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		goto out_release;
 	}
 
-	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
+	dispose_it = msk->free_first || ssk != msk->first;
 	if (dispose_it)
 		list_del(&subflow->node);
 
@@ -2370,7 +2362,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		 * disconnect should never fail
 		 */
 		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
-		msk->subflow->state = SS_UNCONNECTED;
 		mptcp_subflow_ctx_reset(subflow);
 		release_sock(ssk);
 
@@ -3147,7 +3138,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk = mptcp_sk(nsk);
 	msk->local_key = subflow_req->local_key;
 	msk->token = subflow_req->token;
-	WRITE_ONCE(msk->subflow, NULL);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
@@ -3282,10 +3272,8 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	/* clears msk->subflow, allowing the following to close
-	 * even the initial subflow
-	 */
-	mptcp_dispose_initial_subflow(msk);
+	/* allow the following to close even the initial subflow */
+	msk->free_first = 1;
 	mptcp_destroy_common(msk, 0);
 	sk_sockets_allocated_dec(sk);
 }
@@ -3824,11 +3812,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.
 		 */
-		if (msk->first &&
-		    unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
+		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
 			__mptcp_close_ssk(newsk, msk->first,
 					  mptcp_subflow_ctx(msk->first), 0);
-			if (unlikely(list_empty(&msk->conn_list)))
+			if (unlikely(list_is_singular(&msk->conn_list)))
 				inet_sk_state_store(newsk, TCP_CLOSE);
 		}
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c26587fd7d50..1b4457c44fe8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -297,7 +297,8 @@ struct mptcp_sock {
 			cork:1,
 			nodelay:1,
 			fastopening:1,
-			in_accept_queue:1;
+			in_accept_queue:1,
+			free_first:1;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
@@ -306,12 +307,10 @@ struct mptcp_sock {
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
 	struct list_head join_list;
-	struct socket	*subflow; /* outgoing connect/listener/!mp_capable
-				   * The mptcp ops can safely dereference, using suitable
-				   * ONCE annotation, the subflow outside the socket
-				   * lock as such sock is freed after close().
-				   */
-	struct sock	*first;
+	struct sock	*first; /* The mptcp ops can safely dereference, using suitable
+				 * ONCE annotation, the subflow outside the socket
+				 * lock as such sock is freed after close().
+				 */
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
 	struct {
-- 
2.41.0


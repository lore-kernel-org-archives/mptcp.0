Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6A211C
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684323345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXcjHjyjTB3JhQ0nyBFQULh4oPJQo+v4lc++HKXxfFo=;
	b=f4JiUES6uI+n+3vu7EWQ4LdEghXXmoHClWPEIkDD1ydnIXV1bQCJW676tMbO+UywTanRaH
	V6rJyRRXXTifaa9YkERQqntpW25i0ESZu/c3rvuc9Qbx70jSKrHbcTiRG86agIN5nxZeiT
	gJnGkQzODZcWf/wmzIFXua1X+otssOA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-HuaoqkNwMKi0YXxjGvOMAg-1; Wed, 17 May 2023 07:35:44 -0400
X-MC-Unique: HuaoqkNwMKi0YXxjGvOMAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7BEB185A78B;
	Wed, 17 May 2023 11:35:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3336B63F8F;
	Wed, 17 May 2023 11:35:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 1/4] mptcp: add annotations around msk->subflow accesses
Date: Wed, 17 May 2023 13:35:33 +0200
Message-Id: <f7829b4b6f107ca8602b10ae012b59b074229471.1684321532.git.pabeni@redhat.com>
In-Reply-To: <cover.1684321532.git.pabeni@redhat.com>
References: <cover.1684321532.git.pabeni@redhat.com>
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

The MPTCP can access the first subflow socket in a few spots
outside the socket lock scope. That is actually safe, as MPTCP
will delete the socket itself only after the msk sock close().

Still the such accesses causes a few KCSAN splats, as reported
by Christoph. Silence the harmless warning adding a few annotation
around the relevant accesses.

Fixes: 71ba088ce0aa ("mptcp: cleanup accept and poll")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/402
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 18 ++++++++++--------
 net/mptcp/protocol.h |  6 +++++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 93eac61e7ba7..b96b1191763a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -91,7 +91,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 		return err;
 
 	msk->first = ssock->sk;
-	msk->subflow = ssock;
+	WRITE_ONCE(msk->subflow, ssock);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
@@ -2309,7 +2309,7 @@ static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 {
 	if (msk->subflow) {
 		iput(SOCK_INODE(msk->subflow));
-		msk->subflow = NULL;
+		WRITE_ONCE(msk->subflow, NULL);
 	}
 }
 
@@ -3184,7 +3184,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk = mptcp_sk(nsk);
 	msk->local_key = subflow_req->local_key;
 	msk->token = subflow_req->token;
-	msk->subflow = NULL;
+	WRITE_ONCE(msk->subflow, NULL);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
@@ -3233,7 +3233,7 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 	struct socket *listener;
 	struct sock *newsk;
 
-	listener = msk->subflow;
+	listener = READ_ONCE(msk->subflow);
 	if (WARN_ON_ONCE(!listener)) {
 		*err = -EINVAL;
 		return NULL;
@@ -3784,10 +3784,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 	pr_debug("msk=%p", msk);
 
-	/* buggy applications can call accept on socket states other then LISTEN
+	/* Buggy applications can call accept on socket states other then LISTEN
 	 * but no need to allocate the first subflow just to error out.
 	 */
-	ssock = msk->subflow;
+	ssock = READ_ONCE(msk->subflow);
 	if (!ssock)
 		return -EINVAL;
 
@@ -3863,10 +3863,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	state = inet_sk_state_load(sk);
 	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
-		if (WARN_ON_ONCE(!msk->subflow || !msk->subflow->sk))
+		struct socket *ssock = READ_ONCE(msk->subflow);
+
+		if (WARN_ON_ONCE(!ssock || !ssock->sk))
 			return 0;
 
-		return inet_csk_listen_poll(msk->subflow->sk);
+		return inet_csk_listen_poll(ssock->sk);
 	}
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1e8effe395d8..552d7b06aaa9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -304,7 +304,11 @@ struct mptcp_sock {
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
 	struct list_head join_list;
-	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
+	struct socket	*subflow; /* outgoing connect/listener/!mp_capable
+				   * The mptcp ops can safely dereference, using suitable
+				   * ONCE annotation, the subflow outside the socket
+				   * lock as such sock is freed after close().
+				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
-- 
2.40.1


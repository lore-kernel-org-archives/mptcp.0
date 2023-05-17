Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B39168C9
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 11:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684323346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLDIy2xUKyzmEKJlhL6j+wFHnDWBJCqj63Dim57xp+Q=;
	b=SM/9KVQhaLoR+Rez5Sl4OvCmpb2Bbtmiea58fkBaSJXLBK4ydag2cPvWduPQLs3WYjyaNM
	7eHehlA/gHFR4p66YKlUZF+4tuIl8ZACIJdbYAjx1hATVqwqPRuJd9G2tshRLyCnAPLWLO
	sXXNfW+1gKrgQCHJNWlxSzYDBPeA/AU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-C5ylEF_rPHK5m_7dnN8zuA-1; Wed, 17 May 2023 07:35:45 -0400
X-MC-Unique: C5ylEF_rPHK5m_7dnN8zuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8A108037A8;
	Wed, 17 May 2023 11:35:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 18D2D63F5B;
	Wed, 17 May 2023 11:35:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 2/4] mptcp: consolidate passive msk socket initialization
Date: Wed, 17 May 2023 13:35:34 +0200
Message-Id: <e20a42028b3035cc227f0cafa654977a62fb6b77.1684321532.git.pabeni@redhat.com>
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

When the msk socket is cloned at MPC handshake time, a few
fields are initializated in a racy way outside mptcp_sk_clone()
and the msk socket lock.

The above is due historical reasons: before commit a88d0092b24b
("mptcp: simplify subflow_syn_recv_sock()") as the first subflow socket
carrying all the needed date was not available yet at msk creation
time

We can now refactor the code moving the missing initialization bit
under the socket lock, removing the init race and avoiding some
code duplication.

This will also simplify the next patch, as all msk->first write
access are now under the msk socket lock.

Fixes: 0397c6d85f9c ("mptcp: keep unaccepted MPC subflow into join list")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 33 +++++++++++++++++++++++++++------
 net/mptcp/protocol.h |  8 ++++----
 net/mptcp/subflow.c  | 28 +---------------------------
 3 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b96b1191763a..55db12cf7ccb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3163,9 +3163,10 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct sock *sk)
 }
 #endif
 
-struct sock *mptcp_sk_clone(const struct sock *sk,
-			    const struct mptcp_options_received *mp_opt,
-			    struct request_sock *req)
+struct sock *mptcp_sk_clone_init(const struct sock *sk,
+				 const struct mptcp_options_received *mp_opt,
+				 struct sock *ssk,
+				 struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
@@ -3198,10 +3199,30 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
-	/* will be fully established after successful MPC subflow creation */
-	inet_sk_state_store(nsk, TCP_SYN_RECV);
-
 	security_inet_csk_clone(nsk, req);
+
+	/* this can't race with mptcp_close(), as the msk is
+	 * not yet exposted to user-space
+	 */
+	inet_sk_state_store(nsk, TCP_ESTABLISHED);
+
+	/* The msk maintain a referece to each subflow in the connections list */
+	WRITE_ONCE(msk->first, ssk);
+	list_add(&mptcp_subflow_ctx(ssk)->node, &msk->conn_list);
+	sock_hold(ssk);
+
+	/* new mpc subflow takes ownership of the newly
+	 * created mptcp socket
+	 */
+	mptcp_token_accept(subflow_req, msk);
+
+	/* set msk addresses early to ensure mptcp_pm_get_local_id()
+	 * uses the correct data
+	 */
+	mptcp_copy_inaddrs(nsk, ssk);
+	mptcp_propagate_sndbuf(nsk, ssk);
+
+	mptcp_rcv_space_init(msk, ssk);
 	bh_unlock_sock(nsk);
 
 	/* note: the newly allocated socket refcount is 2 now */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 552d7b06aaa9..de94c01746dc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -618,7 +618,6 @@ int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
-void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     const struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
@@ -702,9 +701,10 @@ void __init mptcp_proto_init(void);
 int __init mptcp_proto_v6_init(void);
 #endif
 
-struct sock *mptcp_sk_clone(const struct sock *sk,
-			    const struct mptcp_options_received *mp_opt,
-			    struct request_sock *req);
+struct sock *mptcp_sk_clone_init(const struct sock *sk,
+				 const struct mptcp_options_received *mp_opt,
+				 struct sock *ssk,
+				 struct request_sock *req);
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 76952cf74fc0..63ac4dc621d4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -815,38 +815,12 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		ctx->setsockopt_seq = listener->setsockopt_seq;
 
 		if (ctx->mp_capable) {
-			ctx->conn = mptcp_sk_clone(listener->conn, &mp_opt, req);
+			ctx->conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
 			if (!ctx->conn)
 				goto fallback;
 
 			owner = mptcp_sk(ctx->conn);
-
-			/* this can't race with mptcp_close(), as the msk is
-			 * not yet exposted to user-space
-			 */
-			inet_sk_state_store(ctx->conn, TCP_ESTABLISHED);
-
-			/* record the newly created socket as the first msk
-			 * subflow, but don't link it yet into conn_list
-			 */
-			WRITE_ONCE(owner->first, child);
-
-			/* new mpc subflow takes ownership of the newly
-			 * created mptcp socket
-			 */
-			owner->setsockopt_seq = ctx->setsockopt_seq;
 			mptcp_pm_new_connection(owner, child, 1);
-			mptcp_token_accept(subflow_req, owner);
-
-			/* set msk addresses early to ensure mptcp_pm_get_local_id()
-			 * uses the correct data
-			 */
-			mptcp_copy_inaddrs(ctx->conn, child);
-			mptcp_propagate_sndbuf(ctx->conn, child);
-
-			mptcp_rcv_space_init(owner, child);
-			list_add(&ctx->node, &owner->conn_list);
-			sock_hold(child);
 
 			/* with OoO packets we can reach here without ingress
 			 * mpc option
-- 
2.40.1


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269E17735
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsrfrIZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705331812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQCbg/oNqEeYaUooFlP00kT3nA6fl5AFmLqsdJWwxK4=;
	b=HsrfrIZUAkMqH3kwUAyEUEqxNdiMrJ6DzYIskqnbN5TohWJHNMP3LqITl3BBkv3EWZIle3
	r+2Mm2+ukx+qTXY6eZpGVQKm9h/1nEV2viV7mGNr2cJYjnQChB5bDu3C3Pop+NvU7Oos63
	X9uMVLGR8yTpmi3xwpOmm6msNwd0wk0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-4ct-8JI0O--d0BB70KbW0Q-1; Mon,
 15 Jan 2024 10:16:50 -0500
X-MC-Unique: 4ct-8JI0O--d0BB70KbW0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33C733814586
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B73251C060B2
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 4/4] mptcp: corner case locking for rx path fields initialization
Date: Mon, 15 Jan 2024 16:16:33 +0100
Message-ID: <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
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

Most MPTCP-level related fields are under the mptcp data lock
protection, but are written one-off without such lock at MPC
complete time, both for the client and the server

Leverage the mptcp_propagate_state() infrastructure to move such
initialization under the proper lock client-wise.

The server side critical init steps are done by
mptcp_subflow_fully_established(): ensure the caller properly held the
relevant lock, and avoid acquiring the same lock in the nested scopes.

There are no real potential races, as write access to such fields
is implicitly serialized by the MPTCP state machine; the primary
goal is consistency.

Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  6 ++---
 net/mptcp/options.c  |  9 +++----
 net/mptcp/protocol.c |  9 ++++---
 net/mptcp/protocol.h |  9 +++----
 net/mptcp/subflow.c  | 56 +++++++++++++++++++++++++-------------------
 5 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 74698582a285..ad28da655f8b 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -59,13 +59,12 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_unlock(sk);
 }
 
-void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				   const struct mptcp_options_received *mp_opt)
+void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+				     const struct mptcp_options_received *mp_opt)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb;
 
-	mptcp_data_lock(sk);
 	skb = skb_peek_tail(&sk->sk_receive_queue);
 	if (skb) {
 		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
@@ -77,5 +76,4 @@ void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_
 	}
 
 	pr_debug("msk=%p ack_seq=%llx", msk, msk->ack_seq);
-	mptcp_data_unlock(sk);
 }
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d2527d189a79..e3e96a49f922 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -962,9 +962,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */
-		subflow->fully_established = 1;
-		WRITE_ONCE(msk->fully_established, true);
-		goto check_notify;
+		goto set_fully_established;
 	}
 
 	/* If the first established packet does not contain MP_CAPABLE + data
@@ -986,7 +984,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 set_fully_established:
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
-	mptcp_subflow_fully_established(subflow, mp_opt);
+
+	mptcp_data_lock((struct sock *)msk);
+	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
 	/* if the subflow is not already linked into the conn_list, we can't
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b7d1da7bcb50..70108854ec9b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3189,6 +3189,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
 
 	if (!nsk)
@@ -3229,7 +3230,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	/* The msk maintain a ref to each subflow in the connections list */
 	WRITE_ONCE(msk->first, ssk);
-	list_add(&mptcp_subflow_ctx(ssk)->node, &msk->conn_list);
+	subflow = mptcp_subflow_ctx(ssk);
+	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssk);
 
 	/* new mpc subflow takes ownership of the newly
@@ -3244,6 +3246,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
+
+	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
+		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	bh_unlock_sock(nsk);
 
 	/* note: the newly allocated socket refcount is 2 now */
@@ -3481,8 +3486,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
-	WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
-	WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 385aa92926d7..d442d876f465 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -622,8 +622,9 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
-void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt);
+void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
+				       struct mptcp_subflow_context *subflow,
+				       const struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
 void mptcp_check_and_set_pending(struct sock *sk);
 void __mptcp_push_pending(struct sock *sk, unsigned int flags);
@@ -957,8 +958,8 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				   const struct mptcp_options_received *mp_opt);
+void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fe5334cee477..52568227c229 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -441,20 +441,6 @@ void __mptcp_sync_state(struct sock *sk, int state)
 	}
 }
 
-static void mptcp_propagate_state(struct sock *sk, struct sock *ssk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	mptcp_data_lock(sk);
-	if (!sock_owned_by_user(sk)) {
-		__mptcp_sync_state(sk, ssk->sk_state);
-	} else {
-		msk->pending_state = ssk->sk_state;
-		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
-	}
-	mptcp_data_unlock(sk);
-}
-
 static void subflow_set_remote_key(struct mptcp_sock *msk,
 				   struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt)
@@ -476,6 +462,31 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
 
+static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
+				  struct mptcp_subflow_context *subflow,
+				  const struct mptcp_options_received *mp_opt)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_data_lock(sk);
+	if (mp_opt) {
+		/* Options are available only in the non fallback cases
+		 * avoid updating rx path fields otherwise
+		 */
+		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
+		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
+		subflow_set_remote_key(msk, subflow, mp_opt);
+	}
+
+	if (!sock_owned_by_user(sk)) {
+		__mptcp_sync_state(sk, ssk->sk_state);
+	} else {
+		msk->pending_state = ssk->sk_state;
+		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
+	}
+	mptcp_data_unlock(sk);
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -510,10 +521,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		if (mp_opt.deny_join_id0)
 			WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 		subflow->mp_capable = 1;
-		subflow_set_remote_key(msk, subflow, &mp_opt);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, &mp_opt);
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 
@@ -556,7 +566,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}
 	return;
 
@@ -741,17 +751,16 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 	kfree_rcu(ctx, rcu);
 }
 
-void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt)
+void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
+				       struct mptcp_subflow_context *subflow,
+				       const struct mptcp_options_received *mp_opt)
 {
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-
 	subflow_set_remote_key(msk, subflow, mp_opt);
 	subflow->fully_established = 1;
 	WRITE_ONCE(msk->fully_established, true);
 
 	if (subflow->is_mptfo)
-		mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
+		__mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
 }
 
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
@@ -844,7 +853,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			 * mpc option
 			 */
 			if (mp_opt.suboptions & OPTION_MPTCP_MPC_ACK) {
-				mptcp_subflow_fully_established(ctx, &mp_opt);
 				mptcp_pm_fully_established(owner, child);
 				ctx->pm_notified = 1;
 			}
@@ -1756,7 +1764,7 @@ static void subflow_state_change(struct sock *sk)
 		mptcp_do_fallback(sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}
 
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
-- 
2.43.0


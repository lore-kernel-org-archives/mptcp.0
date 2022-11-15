Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DC24F4F
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668534398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vxwyk9+Fi/o68/UB297JxvSm1tLe+5dfShCXv7r2/PM=;
	b=E8XDnDHgTI0ptm1r+Ui1ra04+eikqVkoCiHQkyP46YGq2VeY9/PsVMl50XjovEB6TNbLb2
	Qq7fzQ0PdAak9Y+jcXIZGZQflQ2LAgCAqPqGIMlttu85oT4Hm6doIz0pRDIqHERMXVyzSr
	owFhLTsLziZNpXIAs6mt9B+wlX/0z4c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-e-iLSZoFNgeQHtIGtQanjA-1; Tue, 15 Nov 2022 12:46:37 -0500
X-MC-Unique: e-iLSZoFNgeQHtIGtQanjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F12DE29AB402
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:46:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.149])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1AD2166B2B
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:46:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] mptcp: consolidate initial ack seq generation
Date: Tue, 15 Nov 2022 18:45:12 +0100
Message-Id: <24fb695383a7d5b0f063ccd18f419ceb264740e5.1668531722.git.pabeni@redhat.com>
In-Reply-To: <cover.1668531722.git.pabeni@redhat.com>
References: <cover.1668531722.git.pabeni@redhat.com>
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

Currently the initial ack sequence is generated on demand whenever
it's requested and the remote key is handy. The relevant code is
scattered in different places and can lead to multiple, unneeded,
crypto operations.

This change consolidate the ack sequence generation code in a single
helper, storing the sequence number at the subflow level.

The above additionally save a few conditional in fast-path and will
simplify the upcoming fast-open implementation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  |  5 ++--
 net/mptcp/protocol.c | 19 +--------------
 net/mptcp/protocol.h |  9 ++++---
 net/mptcp/subflow.c  | 57 +++++++++++++++++++++++++++-----------------
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 784a205e80da..ae076468fcb9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -953,8 +953,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		return subflow->mp_capable;
 	}
 
-	if (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo)) {
+	if (subflow->remote_key_valid &&
+	    (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
+	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 37876e06d4c4..00de7f4fce10 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3046,7 +3046,6 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
 	struct mptcp_sock *msk;
-	u64 ack_seq;
 
 	if (!nsk)
 		return NULL;
@@ -3072,15 +3071,6 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 
-	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
-		msk->can_ack = true;
-		msk->remote_key = mp_opt->sndr_key;
-		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
-		ack_seq++;
-		WRITE_ONCE(msk->ack_seq, ack_seq);
-		atomic64_set(&msk->rcv_wnd_sent, ack_seq);
-	}
-
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	/* will be fully established after successful MPC subflow creation */
 	inet_sk_state_store(nsk, TCP_SYN_RECV);
@@ -3353,7 +3343,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
 	struct sock *sk;
-	u64 ack_seq;
 
 	subflow = mptcp_subflow_ctx(ssk);
 	sk = subflow->conn;
@@ -3361,22 +3350,16 @@ void mptcp_finish_connect(struct sock *ssk)
 
 	pr_debug("msk=%p, token=%u", sk, subflow->token);
 
-	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
-	ack_seq++;
-	subflow->map_seq = ack_seq;
+	subflow->map_seq = subflow->iasn;
 	subflow->map_subflow_seq = 1;
 
 	/* the socket is not connected yet, no msk/subflow ops can access/race
 	 * accessing the field below
 	 */
-	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->local_key, subflow->local_key);
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
-	WRITE_ONCE(msk->ack_seq, ack_seq);
-	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
-	atomic64_set(&msk->rcv_wnd_sent, ack_seq);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6a09ab99a12d..b5abea3d1a9c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -467,7 +467,7 @@ struct mptcp_subflow_context {
 		send_fastclose : 1,
 		send_infinite_map : 1,
 		rx_eof : 1,
-		can_ack : 1,        /* only after processing the remote a key */
+		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		local_id_valid : 1, /* local_id is correctly initialized */
@@ -477,7 +477,10 @@ struct mptcp_subflow_context {
 	u64	thmac;
 	u32	local_nonce;
 	u32	remote_token;
-	u8	hmac[MPTCPOPT_HMAC_LEN];
+	union {
+		u8	hmac[MPTCPOPT_HMAC_LEN]; /* MPJ subflow only */
+		u64	iasn;	    /* initial ack sequence number, MPC subflows only */
+	};
 	u8	local_id;
 	u8	remote_id;
 	u8	reset_seen:1;
@@ -603,7 +606,7 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
 void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
-				     struct mptcp_options_received *mp_opt);
+				     const struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
 void mptcp_check_and_set_pending(struct sock *sk);
 void __mptcp_push_pending(struct sock *sk, unsigned int flags);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 437a283ba6ea..470e12ce0950 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -392,11 +392,33 @@ static void mptcp_set_connected(struct sock *sk)
 	mptcp_data_unlock(sk);
 }
 
+static void subflow_set_remote_key(struct mptcp_sock *msk,
+				   struct mptcp_subflow_context *subflow,
+				   const struct mptcp_options_received *mp_opt)
+{
+	/* active MPC subflow will reach here multiple times:
+	 * at subflow_finish_connect() time and at 4th ack time
+	 */
+	if (subflow->remote_key_valid)
+		return;
+
+	subflow->remote_key_valid = 1;
+	subflow->remote_key = mp_opt->sndr_key;
+	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
+	subflow->iasn++;
+
+	WRITE_ONCE(msk->remote_key, subflow->remote_key);
+	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	WRITE_ONCE(msk->can_ack, true);
+	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_options_received mp_opt;
 	struct sock *parent = subflow->conn;
+	struct mptcp_sock *msk;
 
 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 
@@ -404,6 +426,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	if (subflow->conn_finished)
 		return;
 
+	msk = mptcp_sk(parent);
 	mptcp_propagate_sndbuf(parent, sk);
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
@@ -416,19 +439,16 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			MPTCP_INC_STATS(sock_net(sk),
 					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 			mptcp_do_fallback(sk);
-			pr_fallback(mptcp_sk(subflow->conn));
+			pr_fallback(msk);
 			goto fallback;
 		}
 
 		if (mp_opt.suboptions & OPTION_MPTCP_CSUMREQD)
-			WRITE_ONCE(mptcp_sk(parent)->csum_enabled, true);
+			WRITE_ONCE(msk->csum_enabled, true);
 		if (mp_opt.deny_join_id0)
-			WRITE_ONCE(mptcp_sk(parent)->pm.remote_deny_join_id0, true);
+			WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 		subflow->mp_capable = 1;
-		subflow->can_ack = 1;
-		subflow->remote_key = mp_opt.sndr_key;
-		pr_debug("subflow=%p, remote_key=%llu", subflow,
-			 subflow->remote_key);
+		subflow_set_remote_key(msk, subflow, &mp_opt);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
 		mptcp_set_connected(parent);
@@ -466,7 +486,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
 
-		if (subflow_use_different_dport(mptcp_sk(parent), sk)) {
+		if (subflow_use_different_dport(msk, sk)) {
 			pr_debug("synack inet_dport=%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
@@ -474,7 +494,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
-		mptcp_rcv_space_init(mptcp_sk(parent), sk);
+		mptcp_rcv_space_init(msk, sk);
 		mptcp_set_connected(parent);
 	}
 	return;
@@ -637,13 +657,12 @@ static void subflow_drop_ctx(struct sock *ssk)
 }
 
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
-				     struct mptcp_options_received *mp_opt)
+				     const struct mptcp_options_received *mp_opt)
 {
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 
-	subflow->remote_key = mp_opt->sndr_key;
+	subflow_set_remote_key(msk, subflow, mp_opt);
 	subflow->fully_established = 1;
-	subflow->can_ack = 1;
 	WRITE_ONCE(msk->fully_established, true);
 }
 
@@ -1198,16 +1217,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		if (WARN_ON_ONCE(!skb))
 			goto no_data;
 
-		/* if msk lacks the remote key, this subflow must provide an
-		 * MP_CAPABLE-based mapping
-		 */
-		if (unlikely(!READ_ONCE(msk->can_ack))) {
-			if (!subflow->mpc_map)
-				goto fallback;
-			WRITE_ONCE(msk->remote_key, subflow->remote_key);
-			WRITE_ONCE(msk->ack_seq, subflow->map_seq);
-			WRITE_ONCE(msk->can_ack, true);
-		}
+		if (unlikely(!READ_ONCE(msk->can_ack)))
+			goto fallback;
 
 		old_ack = READ_ONCE(msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
@@ -1480,6 +1491,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 
 	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
 					     &flags, &ifindex);
+	subflow->remote_key_valid = 1;
 	subflow->remote_key = msk->remote_key;
 	subflow->local_key = msk->local_key;
 	subflow->token = msk->token;
@@ -1873,6 +1885,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
+		new_ctx->remote_key_valid = 1;
 		new_ctx->backup = subflow_req->backup;
 		new_ctx->remote_id = subflow_req->remote_id;
 		new_ctx->token = subflow_req->token;
-- 
2.38.1


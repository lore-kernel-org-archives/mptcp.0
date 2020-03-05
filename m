Content-Type: multipart/mixed; boundary="===============4487061309974824598=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH] mptcp: create msk early
Date: Thu, 05 Mar 2020 20:06:36 +0100
Message-ID: <ed7a14f7a0aa42acf8ef0a29fc966787fadd78f5.1583435184.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3886

--===============4487061309974824598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This closes a race between MPC subflow accept and additional MPJ
creation which leads to MPJ subflow being dropped with
MPTCP_MIB_JOINNOTOKEN despite carrying the correct token.
(also fixes some sporadic self-tests failures)

It also makes accept faster, as we only take a single spinlock
vs a spinlock and 2 socket locks.

Additional clean-up could be added in several places where we
currently check for subflow->conn -> after this patch we know
it's always valid.

Flip side: more memory allocated for the accept backlog.
I personally think that is acceptable -> we already allocate
more memory on the server.

Sharing as an early RFC to gather comments.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 81 ++++++++++++++++++++++----------------------
 net/mptcp/protocol.h |  4 +--
 net/mptcp/subflow.c  | 25 +++++++++++---
 net/mptcp/token.c    | 28 ++-------------
 4 files changed, 65 insertions(+), 73 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b3eb886b9488..132e74cc3fb6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1250,9 +1250,12 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struc=
t sock *sk)
 }
 #endif
 =

-static struct sock *mptcp_sk_clone_lock(const struct sock *sk)
+struct sock *mptcp_sk_clone(const struct sock *sk, struct request_sock *re=
q)
 {
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	struct sock *nsk =3D sk_clone_lock(sk, GFP_ATOMIC);
+	struct mptcp_sock *msk;
+	u64 ack_seq;
 =

 	if (!nsk)
 		return NULL;
@@ -1262,6 +1265,30 @@ static struct sock *mptcp_sk_clone_lock(const struct=
 sock *sk)
 		inet_sk(nsk)->pinet6 =3D mptcp_inet6_sk(nsk);
 #endif
 =

+	__mptcp_init_sock(nsk);
+
+	msk =3D mptcp_sk(nsk);
+	msk->local_key =3D subflow_req->local_key;
+	msk->token =3D subflow_req->token;
+	msk->subflow =3D NULL;
+
+	mptcp_token_new_accept(subflow_req->token, nsk);
+
+	mptcp_pm_new_connection(msk, 1);
+
+	msk->write_seq =3D subflow_req->idsn + 1;
+	atomic64_set(&msk->snd_una, msk->write_seq);
+	if (subflow_req->remote_key_valid) {
+		msk->can_ack =3D true;
+		msk->remote_key =3D subflow_req->remote_key;
+		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
+		ack_seq++;
+		msk->ack_seq =3D ack_seq;
+	}
+	bh_unlock_sock(nsk);
+
+	/* keep a single reference */
+	__sock_put(nsk);
 	return nsk;
 }
 =

@@ -1289,44 +1316,28 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
 		struct sock *ssk =3D newsk;
-		u64 ack_seq;
 =

 		subflow =3D mptcp_subflow_ctx(newsk);
-		lock_sock(sk);
+		new_mptcp_sock =3D subflow->conn;
 =

-		local_bh_disable();
-		new_mptcp_sock =3D mptcp_sk_clone_lock(sk);
-		if (!new_mptcp_sock) {
-			*err =3D -ENOBUFS;
-			local_bh_enable();
-			release_sock(sk);
-			mptcp_subflow_shutdown(newsk, SHUT_RDWR + 1);
-			tcp_close(newsk, 0);
-			return NULL;
+		/* is_mptcp should be false if subflow->conn is missing, see
+		 * subflow_syn_recv_sock()
+		 */
+		if (WARN_ON_ONCE(!new_mptcp_sock)) {
+			tcp_sk(newsk)->is_mptcp =3D 0;
+			return newsk;
 		}
 =

-		__mptcp_init_sock(new_mptcp_sock);
+		/* acquire the 2nd reference for the owning socket */
+		sock_hold(new_mptcp_sock);
 =

+		local_bh_disable();
+		bh_lock_sock(new_mptcp_sock);
 		msk =3D mptcp_sk(new_mptcp_sock);
-		msk->local_key =3D subflow->local_key;
-		msk->token =3D subflow->token;
-		msk->subflow =3D NULL;
 		msk->first =3D newsk;
 =

-		mptcp_token_update_accept(newsk, new_mptcp_sock);
-
-		mptcp_pm_new_connection(msk, 1);
-
-		msk->write_seq =3D subflow->idsn + 1;
-		atomic64_set(&msk->snd_una, msk->write_seq);
-		if (subflow->can_ack) {
-			msk->can_ack =3D true;
-			msk->remote_key =3D subflow->remote_key;
-			mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
-			ack_seq++;
-			msk->ack_seq =3D ack_seq;
-		}
 		newsk =3D new_mptcp_sock;
+
 		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
 =

@@ -1338,18 +1349,6 @@ static struct sock *mptcp_accept(struct sock *sk, in=
t flags, int *err,
 =

 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
 		local_bh_enable();
-		release_sock(sk);
-
-		/* the subflow can already receive packet, avoid racing with
-		 * the receive path and process the pending ones
-		 */
-		lock_sock(ssk);
-		subflow->rel_write_seq =3D 1;
-		subflow->tcp_sock =3D ssk;
-		subflow->conn =3D new_mptcp_sock;
-		if (unlikely(!skb_queue_empty(&ssk->sk_receive_queue)))
-			mptcp_subflow_data_available(ssk);
-		release_sock(ssk);
 	} else {
 		MPTCP_INC_STATS(sock_net(sk),
 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8f8c0672e7b6..84d3b447f0b0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -323,6 +323,7 @@ void mptcp_proto_init(void);
 int mptcp_proto_v6_init(void);
 #endif
 =

+struct sock *mptcp_sk_clone(const struct sock *sk, struct request_sock *re=
q);
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

@@ -335,8 +336,7 @@ void mptcp_subflow_eof(struct sock *sk);
 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
 int mptcp_token_new_connect(struct sock *sk);
-int mptcp_token_new_accept(u32 token);
-void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
+int mptcp_token_new_accept(u32 token, struct sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
 void mptcp_token_destroy(u32 token);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8fcee22d36a2..054b62d1b9f8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -344,6 +344,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct tcp_options_received opt_rx;
 	bool fallback_is_fatal =3D false;
+	struct sock *new_msk =3D NULL;
 	struct sock *child;
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
@@ -359,7 +360,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			 * out-of-order pkt, which will not carry the MP_CAPABLE
 			 * opt even on mptcp enabled paths
 			 */
-			goto create_child;
+			goto create_msk;
 		}
 =

 		opt_rx.mptcp.mp_capable =3D 0;
@@ -369,7 +370,14 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 			subflow_req->remote_key_valid =3D 1;
 		} else {
 			subflow_req->mp_capable =3D 0;
+			goto create_child;
 		}
+
+create_msk:
+		new_msk =3D mptcp_sk_clone(listener->conn, req);
+		if (!new_msk)
+			subflow_req->mp_capable =3D 0;
+
 	} else if (subflow_req->mp_join) {
 		fallback_is_fatal =3D true;
 		opt_rx.mptcp.mp_join =3D 0;
@@ -394,12 +402,15 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 		if (!ctx) {
 			if (fallback_is_fatal)
 				goto close_child;
-			return child;
+			goto out;
 		}
 =

 		if (ctx->mp_capable) {
-			if (mptcp_token_new_accept(ctx->token))
-				goto close_child;
+			/* new mpc subflow takes ownership of the newly
+			 * created mptcp socket
+			 */
+			ctx->conn =3D new_msk;
+			new_msk =3D NULL;
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
 =

@@ -415,6 +426,10 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 		}
 	}
 =

+out:
+	/* dispose of the left over mptcp master, if any */
+	if (new_msk)
+		sock_put(new_msk);
 	return child;
 =

 close_child:
@@ -1055,6 +1070,8 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
 	new_ctx->tcp_data_ready =3D old_ctx->tcp_data_ready;
 	new_ctx->tcp_state_change =3D old_ctx->tcp_state_change;
 	new_ctx->tcp_write_space =3D old_ctx->tcp_write_space;
+	new_ctx->rel_write_seq =3D 1;
+	new_ctx->tcp_sock =3D newsk;
 =

 	if (subflow_req->mp_capable) {
 		/* see comments in subflow_syn_recv_sock(), MPTCP connection
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 15cd71a33205..3178cfc951db 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -132,41 +132,17 @@ int mptcp_token_new_connect(struct sock *sk)
  * We don't have an mptcp socket yet at that point.
  * This is paired with mptcp_token_update_accept, called on accept().
  */
-int mptcp_token_new_accept(u32 token)
+int mptcp_token_new_accept(u32 token, struct sock *conn)
 {
 	int err;
 =

 	spin_lock_bh(&token_tree_lock);
-	err =3D radix_tree_insert(&token_tree, token, &token_used);
+	err =3D radix_tree_insert(&token_tree, token, conn);
 	spin_unlock_bh(&token_tree_lock);
 =

 	return err;
 }
 =

-/**
- * mptcp_token_update_accept - update token to map to mptcp socket
- * @conn: the new struct mptcp_sock
- * @sk: the initial subflow for this mptcp socket
- *
- * Called when the first mptcp socket is created on accept to
- * refresh the dummy mapping (done to reserve the token) with
- * the mptcp_socket structure that wasn't allocated before.
- */
-void mptcp_token_update_accept(struct sock *sk, struct sock *conn)
-{
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	void __rcu **slot;
-
-	spin_lock_bh(&token_tree_lock);
-	slot =3D radix_tree_lookup_slot(&token_tree, subflow->token);
-	WARN_ON_ONCE(!slot);
-	if (slot) {
-		WARN_ON_ONCE(rcu_access_pointer(*slot) !=3D &token_used);
-		radix_tree_replace_slot(&token_tree, slot, conn);
-	}
-	spin_unlock_bh(&token_tree_lock);
-}
-
 /**
  * mptcp_token_get_sock - retrieve mptcp connection sock using its token
  * @token - token of the mptcp connection to retrieve
-- =

2.21.1

--===============4487061309974824598==--

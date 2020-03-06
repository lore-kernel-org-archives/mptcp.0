Content-Type: multipart/mixed; boundary="===============2951793430338979918=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/2] mptcp: create msk early
Date: Fri, 06 Mar 2020 17:45:32 +0100
Message-ID: <7451680eff28d0ebbddba1562139840d5a86037c.1583511159.git.pabeni@redhat.com>
In-Reply-To: cover.1583511159.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3890

--===============2951793430338979918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change move the mptcp socket allocation from mptcp_accept() to
subflow_syn_recv_sock(), so that subflow->conn is now always set
for the non fallback scenario.

It allows cleaning up a bit mptcp_accept() reducing the additional
locking and will allow fourther cleanup in later patch

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 83 ++++++++++++++++++++++++--------------------
 net/mptcp/protocol.h |  4 +--
 net/mptcp/subflow.c  | 32 +++++++++++------
 net/mptcp/token.c    | 31 ++---------------
 4 files changed, 70 insertions(+), 80 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4c075a9f7ed0..b6a93f27f8a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -818,9 +818,12 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct =
sock *sk)
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
@@ -830,6 +833,36 @@ static struct sock *mptcp_sk_clone_lock(const struct s=
ock *sk)
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
+	if (unlikely(mptcp_token_new_accept(subflow_req->token, nsk))) {
+		bh_unlock_sock(nsk);
+
+		/* we can't call into mptcp_close() here - possible BH context
+		 * free the sock directly
+		 */
+		nsk->sk_prot->destroy(nsk);
+		sk_free(nsk);
+		return NULL;
+	}
+
+	msk->write_seq =3D subflow_req->idsn + 1;
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

@@ -857,40 +890,26 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
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
-			mptcp_subflow_shutdown(newsk, SHUT_RDWR + 1, 0, 0);
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
-		msk->write_seq =3D subflow->idsn + 1;
-		if (subflow->can_ack) {
-			msk->can_ack =3D true;
-			msk->remote_key =3D subflow->remote_key;
-			mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
-			ack_seq++;
-			msk->ack_seq =3D ack_seq;
-		}
 		newsk =3D new_mptcp_sock;
 		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
@@ -901,18 +920,6 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		inet_sk_state_store(new_mptcp_sock, TCP_SYN_RECV);
 		bh_unlock_sock(new_mptcp_sock);
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
 	}
 =

 	return newsk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 313558fa8185..9baf6fcba914 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -193,6 +193,7 @@ void mptcp_proto_init(void);
 int mptcp_proto_v6_init(void);
 #endif
 =

+struct sock *mptcp_sk_clone(const struct sock *sk, struct request_sock *re=
q);
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

@@ -202,8 +203,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk=
);
 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
 int mptcp_token_new_connect(struct sock *sk);
-int mptcp_token_new_accept(u32 token);
-void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
+int mptcp_token_new_accept(u32 token, struct sock *conn);
 void mptcp_token_destroy(u32 token);
 =

 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0de2a44bdaa0..047b088e4617 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -182,6 +182,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct tcp_options_received opt_rx;
+	struct sock *new_msk =3D NULL;
 	struct sock *child;
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
@@ -197,7 +198,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			 * out-of-order pkt, which will not carry the MP_CAPABLE
 			 * opt even on mptcp enabled paths
 			 */
-			goto create_child;
+			goto create_msk;
 		}
 =

 		opt_rx.mptcp.mp_capable =3D 0;
@@ -207,7 +208,13 @@ static struct sock *subflow_syn_recv_sock(const struct=
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
 	}
 =

 create_child:
@@ -221,22 +228,22 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 		 * handshake
 		 */
 		if (!ctx)
-			return child;
+			goto out;
 =

 		if (ctx->mp_capable) {
-			if (mptcp_token_new_accept(ctx->token))
-				goto close_child;
+			/* new mpc subflow takes ownership of the newly
+			 * created mptcp socket
+			 */
+			ctx->conn =3D new_msk;
+			new_msk =3D NULL;
 		}
 	}
 =

+out:
+	/* dispose of the left over mptcp master, if any */
+	if (unlikely(new_msk))
+		sock_put(new_msk);
 	return child;
-
-close_child:
-	pr_debug("closing child socket");
-	tcp_send_active_reset(child, GFP_ATOMIC);
-	inet_csk_prepare_forced_close(child);
-	tcp_done(child);
-	return NULL;
 }
 =

 static struct inet_connection_sock_af_ops subflow_specific;
@@ -793,6 +800,9 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	new_ctx->tcp_data_ready =3D old_ctx->tcp_data_ready;
 	new_ctx->tcp_state_change =3D old_ctx->tcp_state_change;
 	new_ctx->tcp_write_space =3D old_ctx->tcp_write_space;
+	new_ctx->rel_write_seq =3D 1;
+	new_ctx->tcp_sock =3D newsk;
+
 	new_ctx->mp_capable =3D 1;
 	new_ctx->fourth_ack =3D subflow_req->remote_key_valid;
 	new_ctx->can_ack =3D subflow_req->remote_key_valid;
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 84d887806090..b71b53c0ac8d 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -128,45 +128,18 @@ int mptcp_token_new_connect(struct sock *sk)
  *
  * Called when a SYN packet creates a new logical connection, i.e.
  * is not a join request.
- *
- * We don't have an mptcp socket yet at that point.
- * This is paired with mptcp_token_update_accept, called on accept().
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
  * mptcp_token_destroy_request - remove mptcp connection/token
  * @token - token of mptcp connection to remove
-- =

2.21.1

--===============2951793430338979918==--

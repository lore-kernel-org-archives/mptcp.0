Content-Type: multipart/mixed; boundary="===============9033635166808868177=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/4] Squash-to: "mptcp: refactor token container."
Date: Thu, 04 Jun 2020 19:40:03 +0200
Message-ID: <35d288ce3a8071984be52fbf680964b54869bd7e.1591291903.git.pabeni@redhat.com>
In-Reply-To: cover.1591291903.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4587

--===============9033635166808868177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Track the 'token avail' status via the token node 'pprev'
field, and use sk_hashed helper for msk socket.

Explicitly clear the token before each syscall potentially
re-creating it.

Move the token accept in the 'own_req' branch: mptcp_token_accept()
modifies the req socket and we can't do that if we don't own the
req socket.

Always insert at bucket head, to avoid unneeded traversal.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c |  6 +++---
 net/mptcp/protocol.h |  9 ++++++--
 net/mptcp/subflow.c  |  7 +++---
 net/mptcp/token.c    | 51 +++++++++++++++++++++++---------------------
 4 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5d7f4cd2c8e6..90e87727fde3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1445,8 +1445,6 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->token =3D subflow_req->token;
 	msk->subflow =3D NULL;
 =

-	mptcp_token_accept(subflow_req, msk);
-
 	msk->write_seq =3D subflow_req->idsn + 1;
 	atomic64_set(&msk->snd_una, msk->write_seq);
 	if (mp_opt->mp_capable) {
@@ -1532,7 +1530,7 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	mptcp_token_destroy(msk->token);
+	mptcp_token_destroy(msk);
 	if (msk->cached_ext)
 		__skb_ext_put(msk->cached_ext);
 =

@@ -1811,6 +1809,7 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
 		goto do_connect;
 	}
 =

+	mptcp_token_destroy(msk);
 	ssock =3D __mptcp_socket_create(msk, TCP_SYN_SENT);
 	if (IS_ERR(ssock)) {
 		err =3D PTR_ERR(ssock);
@@ -1887,6 +1886,7 @@ static int mptcp_listen(struct socket *sock, int back=
log)
 	pr_debug("msk=3D%p", msk);
 =

 	lock_sock(sock->sk);
+	mptcp_token_destroy(msk);
 	ssock =3D __mptcp_socket_create(msk, TCP_LISTEN);
 	if (IS_ERR(ssock)) {
 		err =3D PTR_ERR(ssock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0592fec3418b..6322c4e2d07c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -383,13 +383,18 @@ void mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 =

 void __init mptcp_token_init(void);
+static inline void mptcp_token_init_request(struct request_sock *req)
+{
+	mptcp_subflow_rsk(req)->token_node.pprev =3D NULL;
+}
+
 int mptcp_token_new_request(struct request_sock *req);
-void mptcp_token_destroy_request(u32 token);
+void mptcp_token_destroy_request(struct request_sock *req);
 int mptcp_token_new_connect(struct sock *sk);
 void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
-void mptcp_token_destroy(u32 token);
+void mptcp_token_destroy(struct mptcp_sock *msk);
 =

 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
 static inline void mptcp_crypto_key_gen_sha(u64 *key, u32 *token, u64 *ids=
n)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 10b4770a1419..fcb9ca9a9dce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -34,7 +34,7 @@ static int subflow_rebuild_header(struct sock *sk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	int local_id;
 =

-	if (subflow->request_mptcp && !subflow->token) {
+	if (subflow->request_mptcp && sk_unhashed(subflow->conn)) {
 		pr_debug("subflow=3D%p", sk);
 		if (mptcp_token_new_connect(sk)) {
 			subflow->mp_capable =3D 0;
@@ -69,8 +69,7 @@ static void subflow_req_destructor(struct request_sock *r=
eq)
 =

 	pr_debug("subflow_req=3D%p", subflow_req);
 =

-	if (subflow_req->mp_capable)
-		mptcp_token_destroy_request(subflow_req->token);
+	mptcp_token_destroy_request(req);
 	tcp_request_sock_ops.destructor(req);
 }
 =

@@ -133,6 +132,7 @@ static void subflow_init_req(struct request_sock *req,
 =

 	subflow_req->mp_capable =3D 0;
 	subflow_req->mp_join =3D 0;
+	mptcp_token_init_request(req);
 =

 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -509,6 +509,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			 */
 			new_msk->sk_destruct =3D mptcp_sock_destruct;
 			mptcp_pm_new_connection(mptcp_sk(new_msk), 1);
+			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
 			ctx->conn =3D new_msk;
 			new_msk =3D NULL;
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 8716745bcccd..8acea188323c 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -119,7 +119,7 @@ int mptcp_token_new_request(struct request_sock *req)
 		goto again;
 	}
 =

-	hlist_nulls_add_tail_rcu(&subflow_req->token_node, &bucket->req_chain);
+	hlist_nulls_add_head_rcu(&subflow_req->token_node, &bucket->req_chain);
 	bucket->chain_len++;
 	spin_unlock_bh(&bucket->lock);
 	return 0;
@@ -165,7 +165,7 @@ int mptcp_token_new_connect(struct sock *sk)
 	}
 =

 	WRITE_ONCE(msk->token, subflow->token);
-	__sk_nulls_add_node_tail_rcu((struct sock *)msk, &bucket->msk_chain);
+	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
 	bucket->chain_len++;
 	spin_unlock_bh(&bucket->lock);
 	return 0;
@@ -187,15 +187,12 @@ void mptcp_token_accept(struct mptcp_subflow_request_=
sock *req,
 =

 	bucket =3D token_bucket(req->token);
 	spin_lock_bh(&bucket->lock);
-	pos =3D __token_lookup_req(bucket, req->token);
 =

-	/* if we have a multiple CPUs racing on this req, we can legitly not
-	 * find anymore the req token, otherwise the lookup must return the
-	 * current req socket
-	 */
-	if (pos && !WARN_ON_ONCE(pos !=3D req))
-		hlist_nulls_del_rcu(&req->token_node);
-	__sk_nulls_add_node_tail_rcu((struct sock *)msk, &bucket->msk_chain);
+	/* pedantic lookup check for the moved token */
+	pos =3D __token_lookup_req(bucket, req->token);
+	if (!WARN_ON_ONCE(pos !=3D req))
+		hlist_nulls_del_init_rcu(&req->token_node);
+	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
 	spin_unlock_bh(&bucket->lock);
 }
 =

@@ -244,21 +241,24 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 =

 /**
  * mptcp_token_destroy_request - remove mptcp connection/token
- * @token: token of mptcp connection to remove
+ * @req: mptcp request socket dropping the token
  *
- * Remove not-yet-fully-established incoming connection identified
- * by @token.
+ * Remove the token associated to @req.
  */
-void mptcp_token_destroy_request(u32 token)
+void mptcp_token_destroy_request(struct request_sock *req)
 {
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	struct mptcp_subflow_request_sock *pos;
 	struct token_bucket *bucket;
 =

-	bucket =3D token_bucket(token);
+	if (hlist_nulls_unhashed(&subflow_req->token_node))
+		return;
+
+	bucket =3D token_bucket(subflow_req->token);
 	spin_lock_bh(&bucket->lock);
-	pos =3D __token_lookup_req(bucket, token);
-	if (pos) {
-		hlist_nulls_del_rcu(&pos->token_node);
+	pos =3D __token_lookup_req(bucket, subflow_req->token);
+	if (!WARN_ON_ONCE(pos !=3D subflow_req)) {
+		hlist_nulls_del_init_rcu(&pos->token_node);
 		bucket->chain_len--;
 	}
 	spin_unlock_bh(&bucket->lock);
@@ -266,19 +266,22 @@ void mptcp_token_destroy_request(u32 token)
 =

 /**
  * mptcp_token_destroy - remove mptcp connection/token
- * @token: token of mptcp connection to remove
+ * @msk: mptcp connection dropping the token
  *
- * Remove the connection identified by @token.
+ * Remove the token associated to @msk
  */
-void mptcp_token_destroy(u32 token)
+void mptcp_token_destroy(struct mptcp_sock *msk)
 {
 	struct token_bucket *bucket;
 	struct mptcp_sock *pos;
 =

-	bucket =3D token_bucket(token);
+	if (sk_unhashed((struct sock *)msk))
+		return;
+
+	bucket =3D token_bucket(msk->token);
 	spin_lock_bh(&bucket->lock);
-	pos =3D __token_lookup_msk(bucket, token);
-	if (pos) {
+	pos =3D __token_lookup_msk(bucket, msk->token);
+	if (!WARN_ON_ONCE(pos !=3D msk)) {
 		__sk_nulls_del_node_init_rcu((struct sock *)pos);
 		bucket->chain_len--;
 	}
-- =

2.21.3

--===============9033635166808868177==--

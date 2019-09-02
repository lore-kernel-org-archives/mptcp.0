Content-Type: multipart/mixed; boundary="===============6409668118368191372=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH MPTCP 2/2] mptcp: token: add mptcp prefixes to
 functions
Date: Mon, 02 Sep 2019 13:09:09 +0200
Message-ID: <20190902110909.3724-3-fw@strlen.de>
In-Reply-To: 20190902110909.3724-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1783

--===============6409668118368191372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

some functions are removed as they only have one caller.
Functions that did not need to access the token tree are placed in
the compilation unit where they are needed.

Also adds error handling -- adding an object to the radix tree
might require dynamic memory allocation, so insertions can fail.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 This is a squash of patches 2-9 of the earlier 'RFC v2' series.

 I've omitted the last patch of that series:
   [RFC v2 10/10] mptcp: token: rename token_release

 Because I think we can remove that function by making the ULP context
 use ctx->conn directly -- I'm currently working on that.

 I would not squash this patch for the time being.

 net/mptcp/pm.c       |   6 +-
 net/mptcp/protocol.c |   4 +-
 net/mptcp/protocol.h |  20 +--
 net/mptcp/subflow.c  | 133 +++++++++++++--
 net/mptcp/token.c    | 399 ++++++++++++++-----------------------------
 5 files changed, 254 insertions(+), 308 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bc07376a823b..57e13837ee22 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -13,7 +13,7 @@
 int pm_announce_addr(u32 token, sa_family_t family, u8 local_id,
 		     struct in_addr *addr)
 {
-	struct mptcp_sock *msk =3D mptcp_sk(token_lookup_get(token));
+	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 	int err =3D 0;
 =

 	if (!msk)
@@ -38,7 +38,7 @@ int pm_announce_addr(u32 token, sa_family_t family, u8 lo=
cal_id,
 =

 int pm_remove_addr(u32 token, u8 local_id)
 {
-	struct mptcp_sock *msk =3D mptcp_sk(token_lookup_get(token));
+	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 =

 	if (!msk)
 		return -EINVAL;
@@ -52,7 +52,7 @@ int pm_remove_addr(u32 token, u8 local_id)
 =

 int pm_create_subflow(u32 token, u8 remote_id)
 {
-	struct mptcp_sock *msk =3D mptcp_sk(token_lookup_get(token));
+	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 	struct sockaddr_in remote;
 	struct sockaddr_in local;
 	int err;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e05ba1c2b756..266a1028c9fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -697,7 +697,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
-		token_update_accept(new_sock->sk, new_mptcp_sock);
+		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

 		pm_new_connection(msk, 1);
@@ -733,7 +733,7 @@ static void mptcp_destroy(struct sock *sk)
 =

 	pr_debug("msk=3D%p", sk);
 =

-	token_destroy(msk->token);
+	mptcp_token_destroy(msk->token);
 }
 =

 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7c0b59ac1af5..bd7b3b107fe0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -229,20 +229,14 @@ void mptcp_get_options(const struct sk_buff *skb,
 void mptcp_finish_connect(struct sock *sk, int mp_capable);
 void mptcp_finish_join(struct sock *sk);
 =

-void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
-int token_join_request(struct request_sock *req, const struct sk_buff *skb=
);
-int token_join_response(struct sock *sk);
-int token_join_valid(struct request_sock *req,
-		     struct tcp_options_received *rx_opt);
-void token_destroy_request(u32 token);
-void token_new_connect(struct sock *sk);
-void token_new_subflow(struct sock *sk);
-void token_new_accept(struct sock *sk);
-int token_new_join(struct sock *sk);
-void token_update_accept(struct sock *sk, struct sock *conn);
-struct sock *token_lookup_get(u32 token);
+int mptcp_token_new_request(struct request_sock *req);
+void mptcp_token_destroy_request(u32 token);
+int mptcp_token_new_connect(struct sock *sk);
+int mptcp_token_new_accept(u32 token);
+void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
+struct mptcp_sock *mptcp_token_get_sock(u32 token);
 void token_release(u32 token);
-void token_destroy(u32 token);
+void mptcp_token_destroy(u32 token);
 =

 void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
 static inline void crypto_key_gen_sha1(u64 *key, u32 *token, u64 *idsn)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 327ee987861b..468f9b2aeb30 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -4,9 +4,12 @@
  * Copyright (c) 2017 - 2019, Intel Corporation.
  */
 =

+#define pr_fmt(fmt) "MPTCP: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <crypto/algapi.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -18,15 +21,23 @@
 static int subflow_rebuild_header(struct sock *sk)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
+	int err =3D 0;
 =

 	if (subflow->request_mptcp && !subflow->token) {
 		pr_debug("subflow=3D%p", sk);
-		token_new_connect(sk);
+		err =3D mptcp_token_new_connect(sk);
 	} else if (subflow->request_join && !subflow->local_nonce) {
 		pr_debug("subflow=3D%p", sk);
-		token_new_subflow(sk);
+		mptcp_token_get_sock(subflow->token);
+
+		do {
+			get_random_bytes(&subflow->local_nonce, sizeof(u32));
+		} while (!subflow->local_nonce);
 	}
 =

+	if (err)
+		return err;
+
 	return inet_sk_rebuild_header(sk);
 }
 =

@@ -37,10 +48,42 @@ static void subflow_req_destructor(struct request_sock =
*req)
 	pr_debug("subflow_req=3D%p", subflow_req);
 =

 	if (subflow_req->mp_capable)
-		token_destroy_request(subflow_req->token);
+		mptcp_token_destroy_request(subflow_req->token);
 	tcp_request_sock_ops.destructor(req);
 }
 =

+/* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
+static bool subflow_token_join_request(struct request_sock *req,
+				       const struct sk_buff *skb)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	u8 hmac[MPTCPOPT_HMAC_LEN];
+	struct mptcp_sock *msk;
+
+	msk =3D mptcp_token_get_sock(subflow_req->token);
+	if (!msk) {
+		pr_debug("subflow_req=3D%p, token=3D%u - not found\n",
+			 subflow_req, subflow_req->token);
+		return false;
+	}
+
+	if (pm_get_local_id(req, (struct sock *)msk, skb)) {
+		sock_put((struct sock *)msk);
+		return false;
+	}
+
+	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
+
+	crypto_hmac_sha1(msk->local_key, msk->remote_key,
+			 subflow_req->local_nonce, subflow_req->remote_nonce,
+			 (u32 *)hmac);
+
+	subflow_req->thmac =3D get_unaligned_be64(hmac);
+
+	sock_put((struct sock *)msk);
+	return true;
+}
+
 static void subflow_v4_init_req(struct request_sock *req,
 				const struct sock *sk_listener,
 				struct sk_buff *skb)
@@ -64,7 +107,12 @@ static void subflow_v4_init_req(struct request_sock *re=
q,
 		return;
 =

 	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
-		subflow_req->mp_capable =3D 1;
+		int err;
+
+		err =3D mptcp_token_new_request(req);
+		if (err =3D=3D 0)
+			subflow_req->mp_capable =3D 1;
+
 		if (rx_opt.mptcp.version >=3D listener->request_version)
 			subflow_req->version =3D listener->request_version;
 		else
@@ -73,8 +121,6 @@ static void subflow_v4_init_req(struct request_sock *req,
 		    listener->request_cksum)
 			subflow_req->checksum =3D 1;
 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
-		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
-		token_new_request(req, skb);
 		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
@@ -85,13 +131,32 @@ static void subflow_v4_init_req(struct request_sock *r=
eq,
 		subflow_req->remote_nonce =3D rx_opt.mptcp.nonce;
 		pr_debug("token=3D%u, remote_nonce=3D%u", subflow_req->token,
 			 subflow_req->remote_nonce);
-		if (token_join_request(req, skb)) {
+		if (!subflow_token_join_request(req, skb)) {
 			subflow_req->mp_join =3D 0;
 			// @@ need to trigger RST
 		}
 	}
 }
 =

+/* validate received truncated hmac and create hmac for third ACK */
+static bool subflow_thmac_valid(struct subflow_context *subflow)
+{
+	u8 hmac[MPTCPOPT_HMAC_LEN];
+	u64 thmac;
+
+	crypto_hmac_sha1(subflow->remote_key, subflow->local_key,
+			 subflow->remote_nonce, subflow->local_nonce,
+			 (u32 *)hmac);
+
+	thmac =3D get_unaligned_be64(hmac);
+	pr_debug("subflow=3D%p, token=3D%u, thmac=3D%llu, subflow->thmac=3D%llu\n=
",
+		 subflow, subflow->token,
+		 (unsigned long long)thmac,
+		 (unsigned long long)subflow->thmac);
+
+	return thmac =3D=3D subflow->thmac;
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
@@ -115,13 +180,18 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u",
 			 subflow_ctx(sk), subflow->thmac,
 			 subflow->remote_nonce);
-		if (token_join_response(sk)) {
+		if (!subflow_thmac_valid(subflow)) {
 			subflow->mp_join =3D 0;
 			// @@ need to trigger RST
-		} else {
-			mptcp_finish_join(sk);
-			subflow->conn_finished =3D 1;
+			return;
 		}
+
+		crypto_hmac_sha1(subflow->local_key, subflow->remote_key,
+				 subflow->local_nonce, subflow->remote_nonce,
+				 (u32 *)subflow->hmac);
+
+		mptcp_finish_join(sk);
+		subflow->conn_finished =3D 1;
 	}
 }
 =

@@ -146,6 +216,31 @@ static int subflow_conn_request(struct sock *sk, struc=
t sk_buff *skb)
 	return 0;
 }
 =

+/* validate hmac received in third ACK */
+static bool subflow_hmac_valid(const struct request_sock *req,
+			       const struct tcp_options_received *rx_opt)
+{
+	const struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	u8 hmac[MPTCPOPT_HMAC_LEN];
+	struct mptcp_sock *msk;
+	bool ret;
+
+	msk =3D mptcp_token_get_sock(subflow_req->token);
+	if (!msk)
+		return false;
+
+	crypto_hmac_sha1(msk->remote_key, msk->local_key,
+			 subflow_req->remote_nonce, subflow_req->local_nonce,
+			 (u32 *)hmac);
+
+	ret =3D true;
+	if (crypto_memneq(hmac, rx_opt->mptcp.hmac, sizeof(hmac)))
+		ret =3D false;
+
+	sock_put((struct sock *)msk);
+	return ret;
+}
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -164,7 +259,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	if (!subflow_req->mp_capable && subflow_req->mp_join) {
 		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
-		if (!opt_rx.mptcp.mp_join || token_join_valid(req, &opt_rx))
+		if (!opt_rx.mptcp.mp_join ||
+		    !subflow_hmac_valid(req, &opt_rx))
 			return NULL;
 	}
 =

@@ -177,12 +273,17 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 			goto close_child;
 =

 		if (ctx->mp_capable) {
-			token_new_accept(child);
+			if (mptcp_token_new_accept(ctx->token))
+				goto close_child;
 		} else if (ctx->mp_join) {
-			if (token_new_join(child))
+			struct mptcp_sock *owner;
+
+			owner =3D mptcp_token_get_sock(ctx->token);
+			if (!owner)
 				goto close_child;
-			else
-				mptcp_finish_join(child);
+
+			ctx->conn =3D (struct sock *)owner;
+			mptcp_finish_join(child);
 		}
 	}
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 19b63bd34315..5bd3d0c78d04 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -38,318 +38,157 @@ static RADIX_TREE(token_req_tree, GFP_ATOMIC);
 static DEFINE_SPINLOCK(token_tree_lock);
 static int token_used __read_mostly;
 =

-static bool find_req_token(u32 token)
-{
-	void *used;
-
-	pr_debug("token=3D%u", token);
-	used =3D radix_tree_lookup(&token_req_tree, token);
-	return used;
-}
-
-static bool find_token(u32 token)
-{
-	void *used;
-
-	pr_debug("token=3D%u", token);
-	used =3D radix_tree_lookup(&token_tree, token);
-	return used;
-}
-
 static struct sock *__token_lookup(u32 token)
 {
-	void *conn;
-
-	pr_debug("token=3D%u", token);
-	conn =3D radix_tree_lookup(&token_tree, token);
-	return (struct sock *)conn;
-}
-
-static void new_req_token(struct request_sock *req,
-			  const struct sk_buff *skb)
-{
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-
-	crypto_key_gen_sha1(&subflow_req->local_key, &subflow_req->token,
-			    &subflow_req->idsn);
-	pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu", subflow_req->local_=
key,
-		 subflow_req->token, subflow_req->idsn);
-}
-
-static void new_req_join(struct request_sock *req, struct sock *sk,
-			 const struct sk_buff *skb)
-{
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	u8 hmac[MPTCPOPT_HMAC_LEN];
-
-	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
-	crypto_hmac_sha1(msk->local_key, msk->remote_key,
-			 subflow_req->local_nonce, subflow_req->remote_nonce,
-			 (u32 *)hmac);
-
-	subflow_req->thmac =3D get_unaligned_be64(hmac);
-	pr_debug("local_nonce=3D%u, thmac=3D%llu", subflow_req->local_nonce,
-		 subflow_req->thmac);
-}
-
-static int new_rsp_join(struct sock *sk)
-{
-	struct subflow_context *subflow =3D subflow_ctx(sk);
-	u8 hmac[MPTCPOPT_HMAC_LEN];
-	u64 thmac;
-
-	crypto_hmac_sha1(subflow->remote_key, subflow->local_key,
-			 subflow->remote_nonce, subflow->local_nonce,
-			 (u32 *)hmac);
-
-	thmac =3D get_unaligned_be64(hmac);
-	pr_debug("thmac=3D%llu", thmac);
-	if (thmac !=3D subflow->thmac)
-		return -1;
-
-	crypto_hmac_sha1(subflow->local_key, subflow->remote_key,
-			 subflow->local_nonce, subflow->remote_nonce,
-			 (u32 *)subflow->hmac);
-
-	return 0;
-}
-
-static int new_join_valid(struct request_sock *req, struct sock *sk,
-			  struct tcp_options_received *rx_opt)
-{
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	u8 hmac[MPTCPOPT_HMAC_LEN];
-
-	crypto_hmac_sha1(msk->remote_key, msk->local_key,
-			 subflow_req->remote_nonce, subflow_req->local_nonce,
-			 (u32 *)hmac);
-
-	return memcmp(hmac, (char *)rx_opt->mptcp.hmac, MPTCPOPT_HMAC_LEN);
-}
-
-static void new_token(const struct sock *sk)
-{
-	struct subflow_context *subflow =3D subflow_ctx(sk);
-
-	crypto_key_gen_sha1(&subflow->local_key, &subflow->token,
-			    &subflow->idsn);
-	pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu", subflow->local_key,
-		 subflow->token, subflow->idsn);
-}
-
-static int insert_req_token(u32 token)
-{
-	void *used =3D &token_used;
-
-	pr_debug("token=3D%u", token);
-	return radix_tree_insert(&token_req_tree, token, used);
-}
-
-static int insert_token(u32 token, void *conn)
-{
-	void *used =3D &token_used;
-
-	if (conn)
-		used =3D conn;
-
-	pr_debug("token=3D%u, conn=3D%p", token, used);
-	return radix_tree_insert(&token_tree, token, used);
-}
-
-static void update_token(u32 token, void *conn)
-{
-	void **slot;
-
-	pr_debug("token=3D%u, conn=3D%p", token, conn);
-	slot =3D radix_tree_lookup_slot(&token_tree, token);
-	if (slot) {
-		if (*slot !=3D &token_used)
-			pr_err("slot ALREADY updated!");
-		*slot =3D conn;
-	} else {
-		pr_warn("token NOT FOUND!");
-	}
-}
-
-static void destroy_req_token(u32 token)
-{
-	void *cur;
-
-	cur =3D radix_tree_delete(&token_req_tree, token);
-	if (!cur)
-		pr_warn("token NOT FOUND!");
+	return radix_tree_lookup(&token_tree, token);
 }
 =

-static struct sock *destroy_token(u32 token)
-{
-	void *conn;
-
-	pr_debug("token=3D%u", token);
-	conn =3D radix_tree_delete(&token_tree, token);
-	if (conn && conn !=3D &token_used)
-		return (struct sock *)conn;
-	return NULL;
-}
-
-/* create new local key, idsn, and token for subflow_request */
-void token_new_request(struct request_sock *req,
-		       const struct sk_buff *skb)
+/**
+ * mptcp_token_new_request - create new key/idsn/token for subflow_request
+ * @req - the request socket
+ *
+ * This function is called when a new mptcp connection is coming in.
+ *
+ * It creates a unique token to identify the new mptcp connection,
+ * a secret local key and the initial data sequence number (idsn).
+ *
+ * Returns 0 on success.
+ */
+int mptcp_token_new_request(struct request_sock *req)
 {
 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	int err;
 =

 	pr_debug("subflow_req=3D%p", req);
 	while (1) {
-		new_req_token(req, skb);
+		u32 token;
+
+		crypto_key_gen_sha1(&subflow_req->local_key,
+				    &subflow_req->token,
+				    &subflow_req->idsn);
+		pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
+			 subflow_req->local_key,
+			 subflow_req->token, subflow_req->idsn);
+
+		token =3D subflow_req->token;
 		spin_lock_bh(&token_tree_lock);
-		if (!find_req_token(subflow_req->token) &&
-		    !find_token(subflow_req->token))
+		if (!radix_tree_lookup(&token_req_tree, token) &&
+		    !radix_tree_lookup(&token_tree, token))
 			break;
 		spin_unlock_bh(&token_tree_lock);
 	}
-	insert_req_token(subflow_req->token);
-	spin_unlock_bh(&token_tree_lock);
-}
 =

-/* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
-int token_join_request(struct request_sock *req, const struct sk_buff *skb)
-{
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-	struct sock *conn;
-
-	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
-	spin_lock_bh(&token_tree_lock);
-	conn =3D __token_lookup(subflow_req->token);
-	if (conn)
-		sock_hold(conn);
+	err =3D radix_tree_insert(&token_req_tree,
+				subflow_req->token, &token_used);
 	spin_unlock_bh(&token_tree_lock);
-
-	if (!conn)
-		return -1;
-
-	if (pm_get_local_id(req, conn, skb)) {
-		sock_put(conn);
-		return -1;
-	}
-
-	new_req_join(req, conn, skb);
-
-	sock_put(conn);
-	return 0;
+	return err;
 }
 =

-/* validate received truncated hmac and create hmac for third ACK */
-int token_join_response(struct sock *sk)
+/**
+ * mptcp_token_new_connect - create new key/idsn/token for subflow
+ * @sk - the socket that will initiate a connection
+ *
+ * This function is called when a new outgoing mptcp connection is
+ * initiated.
+ *
+ * It creates a unique token to identify the new mptcp connection,
+ * a secret local key and the initial data sequence number (idsn).
+ *
+ * On success, the mptcp connection can be found again using
+ * the computed token at a later time, this is needed to process
+ * join requests.
+ *
+ * returns 0 on success.
+ */
+int mptcp_token_new_connect(struct sock *sk)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
-
-	pr_debug("subflow=3D%p, token=3D%u", subflow, subflow->token);
-	return new_rsp_join(sk);
-}
-
-/* validate hmac received in third ACK */
-int token_join_valid(struct request_sock *req,
-		     struct tcp_options_received *rx_opt)
-{
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-	struct sock *conn;
+	struct sock *mptcp_sock =3D subflow->conn;
 	int err;
 =

-	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
-	spin_lock_bh(&token_tree_lock);
-	conn =3D __token_lookup(subflow_req->token);
-	if (conn)
-		sock_hold(conn);
-	spin_unlock_bh(&token_tree_lock);
-	if (!conn)
-		return -1;
+	pr_debug("subflow=3D%p", sk);
 =

-	err =3D new_join_valid(req, conn, rx_opt);
-	sock_put(conn);
-	return err;
-}
+	while (1) {
+		u32 token;
 =

-/* create new local key, idsn, and token for subflow */
-void token_new_connect(struct sock *sk)
-{
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+		crypto_key_gen_sha1(&subflow->local_key, &subflow->token,
+				    &subflow->idsn);
 =

-	pr_debug("subflow=3D%p", sk);
+		pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
+			 subflow->local_key,
+			 subflow->token, subflow->idsn);
 =

-	while (1) {
-		new_token(sk);
+		token =3D subflow->token;
 		spin_lock_bh(&token_tree_lock);
-		if (!find_req_token(subflow->token) &&
-		    !find_token(subflow->token))
+		if (!radix_tree_lookup(&token_req_tree, token) &&
+		    !radix_tree_lookup(&token_tree, token))
 			break;
 		spin_unlock_bh(&token_tree_lock);
 	}
-	insert_token(subflow->token, subflow->conn);
-	sock_hold(subflow->conn);
-	spin_unlock_bh(&token_tree_lock);
-}
-
-/* take reference to connection and create nonce for secondary subflow */
-void token_new_subflow(struct sock *sk)
-{
-	struct subflow_context *subflow =3D subflow_ctx(sk);
-	struct sock *conn;
-
-	pr_debug("subflow=3D%p", subflow);
-
-	spin_lock_bh(&token_tree_lock);
-	conn =3D __token_lookup(subflow->token);
-	if (conn)
-		sock_hold(conn);
+	err =3D radix_tree_insert(&token_tree, subflow->token, mptcp_sock);
+	if (err =3D=3D 0)
+		sock_hold(mptcp_sock);
 	spin_unlock_bh(&token_tree_lock);
 =

-	get_random_bytes(&subflow->local_nonce, sizeof(u32));
+	return err;
 }
 =

-void token_new_accept(struct sock *sk)
+/**
+ * mptcp_token_new_accept - insert token for later processing
+ * @token: the token to insert to the tree
+ *
+ * Called when a SYN packet creates a new logical connection, i.e.
+ * is not a join request.
+ *
+ * We don't have an mptcp socket yet at that point.
+ * This is paired with mptcp_token_update_accept, called on accept().
+ */
+int mptcp_token_new_accept(u32 token)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
-
-	pr_debug("subflow=3D%p", sk);
+	int err;
 =

 	spin_lock_bh(&token_tree_lock);
-	insert_token(subflow->token, NULL);
+	err =3D radix_tree_insert(&token_tree, token, &token_used);
 	spin_unlock_bh(&token_tree_lock);
-}
 =

-void token_update_accept(struct sock *sk, struct sock *conn)
-{
-	struct subflow_context *subflow =3D subflow_ctx(sk);
-
-	pr_debug("subflow=3D%p, conn=3D%p", sk, conn);
-
-	spin_lock_bh(&token_tree_lock);
-	update_token(subflow->token, conn);
-	sock_hold(conn);
-	spin_unlock_bh(&token_tree_lock);
+	return err;
 }
 =

-int token_new_join(struct sock *sk)
+/**
+ * mptcp_token_update_accept - update token to map to mptcp socket
+ * @conn: the new struct mptcp_sock
+ * @sk: the initial subflow for this mptcp socket
+ *
+ * Called when the first mptcp socket is created on accept to
+ * refresh the dummy mapping (done to reserve the token) with
+ * the mptcp_socket structure that wasn't allocated before.
+ */
+void mptcp_token_update_accept(struct sock *sk, struct sock *conn)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
-	struct sock *conn;
+	void __rcu **slot;
 =

 	spin_lock_bh(&token_tree_lock);
-	conn =3D __token_lookup(subflow->token);
-	if (conn)
+	slot =3D radix_tree_lookup_slot(&token_tree, subflow->token);
+	WARN_ON_ONCE(!slot);
+	if (slot) {
+		WARN_ON_ONCE(*slot !=3D &token_used);
+		*slot =3D conn;
 		sock_hold(conn);
+	}
 	spin_unlock_bh(&token_tree_lock);
-
-	if (!conn)
-		return -1;
-
-	subflow->conn =3D conn;
-
-	return 0;
 }
 =

-struct sock *token_lookup_get(u32 token)
+/**
+ * mptcp_token_get_sock - retrieve mptcp connection sock using its token
+ * @token - token of the mptcp connection to retrieve
+ *
+ * This function returns the mptcp connection structure with the given tok=
en.
+ * A reference count on the mptcp socket returned is taken.
+ *
+ * returns NULL if no connection with the given token value exists.
+ */
+struct mptcp_sock *mptcp_token_get_sock(u32 token)
 {
 	struct sock *conn;
 =

@@ -359,15 +198,20 @@ struct sock *token_lookup_get(u32 token)
 		sock_hold(conn);
 	spin_unlock_bh(&token_tree_lock);
 =

-	return conn;
+	return mptcp_sk(conn);
 }
 =

-void token_destroy_request(u32 token)
+/**
+ * mptcp_token_destroy_request - remove mptcp connection/token
+ * @token - token of mptcp connection to remove
+ *
+ * Remove not-yet-fully-established incoming connection identified
+ * by @token.
+ */
+void mptcp_token_destroy_request(u32 token)
 {
-	pr_debug("token=3D%u", token);
-
 	spin_lock_bh(&token_tree_lock);
-	destroy_req_token(token);
+	radix_tree_delete(&token_req_tree, token);
 	spin_unlock_bh(&token_tree_lock);
 }
 =

@@ -383,14 +227,21 @@ void token_release(u32 token)
 	spin_unlock_bh(&token_tree_lock);
 }
 =

-void token_destroy(u32 token)
+/**
+ * mptcp_token_destroy - remove mptcp connection/token
+ * @token - token of mptcp connection to remove
+ *
+ * Remove the connection identified by @token.
+ * If the connection isn't found, no action is taken.
+ */
+void mptcp_token_destroy(u32 token)
 {
 	struct sock *conn;
 =

-	pr_debug("token=3D%u", token);
 	spin_lock_bh(&token_tree_lock);
-	conn =3D destroy_token(token);
-	if (conn)
-		sock_put(conn);
+	conn =3D radix_tree_delete(&token_tree, token);
 	spin_unlock_bh(&token_tree_lock);
+
+	if (conn && (int *)conn !=3D &token_used)
+		sock_put(conn);
 }
-- =

2.21.0


--===============6409668118368191372==--

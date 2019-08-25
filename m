Content-Type: multipart/mixed; boundary="===============4860686144991792150=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 06/10] mptcp: token: fold helpers into token
 connect/request functions
Date: Sun, 25 Aug 2019 20:59:35 +0200
Message-ID: <20190825185939.21596-7-fw@strlen.de>
In-Reply-To: 20190825185939.21596-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1703

--===============4860686144991792150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This also adds error handling -- adding an object to the radix tree
might require dynamic memory allocation, so insertions can fail.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h |   4 +-
 net/mptcp/subflow.c  |  17 ++++--
 net/mptcp/token.c    | 126 ++++++++++++++++++++++---------------------
 3 files changed, 80 insertions(+), 67 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4754cf456759..2213ed7863fc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -225,13 +225,13 @@ void mptcp_get_options(const struct sk_buff *skb,
 void mptcp_finish_connect(struct sock *sk, int mp_capable);
 void mptcp_finish_join(struct sock *sk);
 =

-void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
+int mptcp_token_new_request(struct request_sock *req);
 bool mptcp_token_join_request(struct request_sock *req,
 			      const struct sk_buff *skb);
 bool mptcp_token_join_valid(const struct request_sock *req,
 			    const struct tcp_options_received *rx_opt);
 void token_destroy_request(u32 token);
-void token_new_connect(struct sock *sk);
+int mptcp_token_new_connect(struct sock *sk);
 void token_new_accept(struct sock *sk);
 void token_update_accept(struct sock *sk, struct sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e30bd54adb1b..a57bb6546261 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -18,10 +18,11 @@
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
 		mptcp_token_get_sock(subflow->token);
@@ -31,6 +32,9 @@ static int subflow_rebuild_header(struct sock *sk)
 		} while (!subflow->local_nonce);
 	}
 =

+	if (err)
+		return err;
+
 	return inet_sk_rebuild_header(sk);
 }
 =

@@ -68,7 +72,14 @@ static void subflow_v4_init_req(struct request_sock *req,
 		return;
 =

 	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
-		subflow_req->mp_capable =3D 1;
+		int err;
+
+		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
+
+		err =3D mptcp_token_new_request(req);
+		if (err =3D=3D 0)
+			subflow_req->mp_capable =3D 1;
+
 		if (rx_opt.mptcp.version >=3D listener->request_version)
 			subflow_req->version =3D listener->request_version;
 		else
@@ -77,8 +88,6 @@ static void subflow_v4_init_req(struct request_sock *req,
 		    listener->request_cksum)
 			subflow_req->checksum =3D 1;
 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
-		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
-		token_new_request(req, skb);
 		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index def65cac5e63..d3d898d3c57e 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -37,24 +37,6 @@ static RADIX_TREE(token_req_tree, GFP_ATOMIC);
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
 	void *conn;
@@ -64,35 +46,6 @@ static struct sock *__token_lookup(u32 token)
 	return (struct sock *)conn;
 }
 =

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
 static int insert_token(u32 token, void *conn)
 {
 	void *used =3D &token_used;
@@ -139,23 +92,46 @@ static struct sock *destroy_token(u32 token)
 	return NULL;
 }
 =

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
+		pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu",
+			 subflow_req->local_key,
+			 subflow_req->token,
+			 subflow_req->idsn);
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
+
+	err =3D radix_tree_insert(&token_req_tree,
+				subflow_req->token, &token_used);
 	spin_unlock_bh(&token_tree_lock);
+	return err;
 }
 =

 /**
@@ -251,24 +227,52 @@ bool mptcp_token_join_valid(const struct request_sock=
 *req,
 	return ret;
 }
 =

-/* create new local key, idsn, and token for subflow */
-void token_new_connect(struct sock *sk)
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
+	struct sock *mptcp_sock =3D subflow->conn;
+	int err;
 =

 	pr_debug("subflow=3D%p", sk);
 =

 	while (1) {
-		new_token(sk);
+		u32 token;
+
+		crypto_key_gen_sha1(&subflow->local_key, &subflow->token,
+				    &subflow->idsn);
+
+		pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu", subflow->local_key,
+			 subflow->token, subflow->idsn);
+
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
+	err =3D radix_tree_insert(&token_tree, subflow->token, mptcp_sock);
+	if (err =3D=3D 0)
+		sock_hold(mptcp_sock);
 	spin_unlock_bh(&token_tree_lock);
+
+	return err;
 }
 =

 void token_new_accept(struct sock *sk)
-- =

2.21.0


--===============4860686144991792150==--

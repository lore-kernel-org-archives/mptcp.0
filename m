Content-Type: multipart/mixed; boundary="===============9149856201149920890=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 05/10] mptcp: token: remove token_join_request
Date: Thu, 29 Aug 2019 11:06:54 +0200
Message-ID: <20190829090659.766-6-fw@strlen.de>
In-Reply-To: 20190829090659.766-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1747

--===============9149856201149920890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Place the function where needed, we can use existing helper to fetch
the mptcp sk.

v2: move the helper entirely (Peter)

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  | 34 +++++++++++++++++++++++++++++++++-
 net/mptcp/token.c    | 44 --------------------------------------------
 3 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5f33d3729bfd..8514c41e3a6b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -226,7 +226,6 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le);
 void mptcp_finish_join(struct sock *sk);
 =

 void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
-int token_join_request(struct request_sock *req, const struct sk_buff *skb=
);
 void token_destroy_request(u32 token);
 void token_new_connect(struct sock *sk);
 void token_new_accept(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f604e189126b..33bfee514350 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -48,6 +48,38 @@ static void subflow_req_destructor(struct request_sock *=
req)
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
@@ -92,7 +124,7 @@ static void subflow_v4_init_req(struct request_sock *req,
 		subflow_req->remote_nonce =3D rx_opt.mptcp.nonce;
 		pr_debug("token=3D%u, remote_nonce=3D%u", subflow_req->token,
 			 subflow_req->remote_nonce);
-		if (token_join_request(req, skb)) {
+		if (!subflow_token_join_request(req, skb)) {
 			subflow_req->mp_join =3D 0;
 			// @@ need to trigger RST
 		}
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 8de7d9d83e96..233034001561 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -76,23 +76,6 @@ static void new_req_token(struct request_sock *req,
 		 subflow_req->token, subflow_req->idsn);
 }
 =

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
 static void new_token(const struct sock *sk)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
@@ -176,33 +159,6 @@ void token_new_request(struct request_sock *req,
 	spin_unlock_bh(&token_tree_lock);
 }
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
-	spin_unlock_bh(&token_tree_lock);
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
-}
-
 /* create new local key, idsn, and token for subflow */
 void token_new_connect(struct sock *sk)
 {
-- =

2.21.0


--===============9149856201149920890==--

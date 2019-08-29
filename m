Content-Type: multipart/mixed; boundary="===============7053185705132604292=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 09/10] mptcp: token: rename the destroy_token helpers
Date: Thu, 29 Aug 2019 11:06:58 +0200
Message-ID: <20190829090659.766-10-fw@strlen.de>
In-Reply-To: 20190829090659.766-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1751

--===============7053185705132604292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

add mptcp prefix.

v2: fix typo and remove unneeded temporary variable (Matthieu)
    be sure to keep "conn !=3D &token_used" check (also Matthieu)

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/subflow.c  |  2 +-
 net/mptcp/token.c    | 56 +++++++++++++++++---------------------------
 4 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 20b04e3cf0a8..2a73fa4b0f01 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -704,7 +704,7 @@ static void mptcp_destroy(struct sock *sk)
 =

 	pr_debug("msk=3D%p, subflow=3D%p", sk, msk->subflow->sk);
 =

-	token_destroy(msk->token);
+	mptcp_token_destroy(msk->token);
 }
 =

 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f9267730c114..e8a060e23c8d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -226,13 +226,13 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able);
 void mptcp_finish_join(struct sock *sk);
 =

 int mptcp_token_new_request(struct request_sock *req);
-void token_destroy_request(u32 token);
+void mptcp_token_destroy_request(u32 token);
 int mptcp_token_new_connect(struct sock *sk);
 int mptcp_token_new_accept(u32 token);
 void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
 void token_release(u32 token);
-void token_destroy(u32 token);
+void mptcp_token_destroy(u32 token);
 =

 void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
 static inline void crypto_key_gen_sha1(u64 *key, u32 *token, u64 *idsn)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9d906709c216..b6059a4bb15b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -48,7 +48,7 @@ static void subflow_req_destructor(struct request_sock *r=
eq)
 	pr_debug("subflow_req=3D%p", subflow_req);
 =

 	if (subflow_req->mp_capable)
-		token_destroy_request(subflow_req->token);
+		mptcp_token_destroy_request(subflow_req->token);
 	tcp_request_sock_ops.destructor(req);
 }
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index c9645176fb88..5bd3d0c78d04 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -40,31 +40,7 @@ static int token_used __read_mostly;
 =

 static struct sock *__token_lookup(u32 token)
 {
-	void *conn;
-
-	pr_debug("token=3D%u", token);
-	conn =3D radix_tree_lookup(&token_tree, token);
-	return (struct sock *)conn;
-}
-
-static void destroy_req_token(u32 token)
-{
-	void *cur;
-
-	cur =3D radix_tree_delete(&token_req_tree, token);
-	if (!cur)
-		pr_warn("token NOT FOUND!");
-}
-
-static struct sock *destroy_token(u32 token)
-{
-	void *conn;
-
-	pr_debug("token=3D%u", token);
-	conn =3D radix_tree_delete(&token_tree, token);
-	if (conn && conn !=3D &token_used)
-		return (struct sock *)conn;
-	return NULL;
+	return radix_tree_lookup(&token_tree, token);
 }
 =

 /**
@@ -225,12 +201,17 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 	return mptcp_sk(conn);
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

@@ -246,14 +227,21 @@ void token_release(u32 token)
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


--===============7053185705132604292==--

Content-Type: multipart/mixed; boundary="===============1220133365151021071=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 07/10] mptcp: token: fold update_token into its
 caller
Date: Sun, 25 Aug 2019 20:59:36 +0200
Message-ID: <20190825185939.21596-8-fw@strlen.de>
In-Reply-To: 20190825185939.21596-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1704

--===============1220133365151021071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The calling function is very small, so just fold this.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  2 +-
 net/mptcp/token.c    | 36 ++++++++++++++++++------------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 847e5c3133ba..f900303a1531 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -668,7 +668,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
-		token_update_accept(new_sock->sk, new_mptcp_sock);
+		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

 		pm_new_connection(msk, 1);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2213ed7863fc..7db59830a02a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -233,7 +233,7 @@ bool mptcp_token_join_valid(const struct request_sock *=
req,
 void token_destroy_request(u32 token);
 int mptcp_token_new_connect(struct sock *sk);
 void token_new_accept(struct sock *sk);
-void token_update_accept(struct sock *sk, struct sock *conn);
+void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
 void token_release(u32 token);
 void token_destroy(u32 token);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index d3d898d3c57e..c0789643c71c 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -57,21 +57,6 @@ static int insert_token(u32 token, void *conn)
 	return radix_tree_insert(&token_tree, token, used);
 }
 =

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
 static void destroy_req_token(u32 token)
 {
 	void *cur;
@@ -286,15 +271,30 @@ void token_new_accept(struct sock *sk)
 	spin_unlock_bh(&token_tree_lock);
 }
 =

-void token_update_accept(struct sock *sk, struct sock *conn)
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
+	void **slot;
 =

 	pr_debug("subflow=3D%p, conn=3D%p", sk, conn);
 =

 	spin_lock_bh(&token_tree_lock);
-	update_token(subflow->token, conn);
-	sock_hold(conn);
+	slot =3D radix_tree_lookup_slot(&token_tree, subflow->token);
+	WARN_ON_ONCE(!slot);
+	if (slot) {
+		WARN_ON_ONCE(*slot !=3D &token_used);
+		*slot =3D conn;
+		sock_hold(conn);
+	}
 	spin_unlock_bh(&token_tree_lock);
 }
 =

-- =

2.21.0


--===============1220133365151021071==--

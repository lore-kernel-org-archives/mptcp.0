Content-Type: multipart/mixed; boundary="===============6981021952997743841=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: remove token_release
Date: Tue, 10 Sep 2019 17:53:47 +0200
Message-ID: <20190910155348.23244-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1813

--===============6981021952997743841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes token_release and gets rid of the extra sock_put/hold
calls in token.c.

Instead its the responsibility of the subflow to make sure that the master
mptcp socket (referenced via subflow_ctx->conn) can't go away and is
released once the subflow is being destroyed.

Also, switch mptcp_shutdown to sk_common_release to plug a reference leak,
this part is taken from Paolos early patch
"mptcp: fix mptcp socket cleanup", this proposal is an alternative.

Token destruction is moved to mptcp_close -- the rationale is that
we want to remove the token as soon as we know we can't accept any more
subflows.

NB: I suspect we eventually need to extend join operations to check
that the mptcp socket obtained from looking up has following properties:
 - nonzero refcount (refcount_inc_not_zero instead of sock_hold)
 - is still in established state.

 But at this time I feel its better to wait until we support DATA_FIN
 before worrying about this.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  9 ++-------
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  |  6 +++---
 net/mptcp/token.c    | 30 ++----------------------------
 4 files changed, 7 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 266a1028c9fd..d5b0c801e78f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -633,6 +633,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	struct subflow_context *subflow, *tmp;
 	struct socket *ssk =3D NULL;
 =

+	mptcp_token_destroy(msk->token);
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

 	lock_sock(sk);
@@ -652,9 +653,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 		sock_release(mptcp_subflow_tcp_socket(subflow));
 	}
 	release_sock(sk);
-
-	sock_orphan(sk);
-	sock_put(sk);
+	sk_common_release(sk);
 }
 =

 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
@@ -729,11 +728,7 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 =

 static void mptcp_destroy(struct sock *sk)
 {
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	pr_debug("msk=3D%p", sk);
-
-	mptcp_token_destroy(msk->token);
 }
 =

 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 49ac7c842a3c..38d3f5bdf926 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -235,7 +235,6 @@ int mptcp_token_new_connect(struct sock *sk);
 int mptcp_token_new_accept(u32 token);
 void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
-void token_release(u32 token);
 void mptcp_token_destroy(u32 token);
 =

 void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 468f9b2aeb30..a49cc5ed1b27 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -390,6 +390,7 @@ int subflow_create_socket(struct sock *sk, struct socke=
t **new_sock)
 	pr_debug("subflow=3D%p", subflow);
 =

 	*new_sock =3D sf;
+	sock_hold(sk);
 	subflow->conn =3D sk;
 =

 	return 0;
@@ -444,9 +445,8 @@ static void subflow_ulp_release(struct sock *sk)
 {
 	struct subflow_context *ctx =3D subflow_ctx(sk);
 =

-	pr_debug("subflow=3D%p", ctx);
-
-	token_release(ctx->token);
+	if (ctx->conn)
+		sock_put(ctx->conn);
 =

 	kfree(ctx);
 }
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 5bd3d0c78d04..f493ebb4c2d8 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -38,11 +38,6 @@ static RADIX_TREE(token_req_tree, GFP_ATOMIC);
 static DEFINE_SPINLOCK(token_tree_lock);
 static int token_used __read_mostly;
 =

-static struct sock *__token_lookup(u32 token)
-{
-	return radix_tree_lookup(&token_tree, token);
-}
-
 /**
  * mptcp_token_new_request - create new key/idsn/token for subflow_request
  * @req - the request socket
@@ -126,8 +121,6 @@ int mptcp_token_new_connect(struct sock *sk)
 		spin_unlock_bh(&token_tree_lock);
 	}
 	err =3D radix_tree_insert(&token_tree, subflow->token, mptcp_sock);
-	if (err =3D=3D 0)
-		sock_hold(mptcp_sock);
 	spin_unlock_bh(&token_tree_lock);
 =

 	return err;
@@ -174,7 +167,6 @@ void mptcp_token_update_accept(struct sock *sk, struct =
sock *conn)
 	if (slot) {
 		WARN_ON_ONCE(*slot !=3D &token_used);
 		*slot =3D conn;
-		sock_hold(conn);
 	}
 	spin_unlock_bh(&token_tree_lock);
 }
@@ -193,7 +185,7 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 	struct sock *conn;
 =

 	spin_lock_bh(&token_tree_lock);
-	conn =3D __token_lookup(token);
+	conn =3D radix_tree_lookup(&token_tree, token);
 	if (conn)
 		sock_hold(conn);
 	spin_unlock_bh(&token_tree_lock);
@@ -215,33 +207,15 @@ void mptcp_token_destroy_request(u32 token)
 	spin_unlock_bh(&token_tree_lock);
 }
 =

-void token_release(u32 token)
-{
-	struct sock *conn;
-
-	pr_debug("token=3D%u", token);
-	spin_lock_bh(&token_tree_lock);
-	conn =3D __token_lookup(token);
-	if (conn)
-		sock_put(conn);
-	spin_unlock_bh(&token_tree_lock);
-}
-
 /**
  * mptcp_token_destroy - remove mptcp connection/token
  * @token - token of mptcp connection to remove
  *
  * Remove the connection identified by @token.
- * If the connection isn't found, no action is taken.
  */
 void mptcp_token_destroy(u32 token)
 {
-	struct sock *conn;
-
 	spin_lock_bh(&token_tree_lock);
-	conn =3D radix_tree_delete(&token_tree, token);
+	radix_tree_delete(&token_tree, token);
 	spin_unlock_bh(&token_tree_lock);
-
-	if (conn && (int *)conn !=3D &token_used)
-		sock_put(conn);
 }
-- =

2.21.0


--===============6981021952997743841==--

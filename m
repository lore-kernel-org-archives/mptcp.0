Content-Type: multipart/mixed; boundary="===============2104445911153435148=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 08/10] mptcp: token: add error handling for
 token_new_accept
Date: Thu, 29 Aug 2019 11:06:57 +0200
Message-ID: <20190829090659.766-9-fw@strlen.de>
In-Reply-To: 20190829090659.766-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1750

--===============2104445911153435148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Insertion into radix tree might fail, so add error handling for this.

v2: elide a temporary 'ret' variable (Matthieu)

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  3 ++-
 net/mptcp/token.c    | 31 +++++++++++++++----------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0e3945e10a79..f9267730c114 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -228,7 +228,7 @@ void mptcp_finish_join(struct sock *sk);
 int mptcp_token_new_request(struct request_sock *req);
 void token_destroy_request(u32 token);
 int mptcp_token_new_connect(struct sock *sk);
-void token_new_accept(struct sock *sk);
+int mptcp_token_new_accept(u32 token);
 void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
 void token_release(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 16d5df54c533..9d906709c216 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -273,7 +273,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			goto close_child;
 =

 		if (ctx->mp_capable) {
-			token_new_accept(child);
+			if (mptcp_token_new_accept(ctx->token))
+				goto close_child;
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 555da89b3a4b..c9645176fb88 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -47,17 +47,6 @@ static struct sock *__token_lookup(u32 token)
 	return (struct sock *)conn;
 }
 =

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
 static void destroy_req_token(u32 token)
 {
 	void *cur;
@@ -168,15 +157,25 @@ int mptcp_token_new_connect(struct sock *sk)
 	return err;
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
+
+	return err;
 }
 =

 /**
-- =

2.21.0


--===============2104445911153435148==--

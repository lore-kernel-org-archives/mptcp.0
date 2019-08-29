Content-Type: multipart/mixed; boundary="===============0534692611353487363=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 10/10] mptcp: token: rename token_release
Date: Thu, 29 Aug 2019 11:06:59 +0200
Message-ID: <20190829090659.766-11-fw@strlen.de>
In-Reply-To: 20190829090659.766-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1752

--===============0534692611353487363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

avoid namespace pollution -- add an mptcp prefix.
Also, we can place the sock_put after we've released the token tree lock.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  3 +--
 net/mptcp/token.c    | 12 +++++++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e8a060e23c8d..bbb0c92274d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -231,7 +231,7 @@ int mptcp_token_new_connect(struct sock *sk);
 int mptcp_token_new_accept(u32 token);
 void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
-void token_release(u32 token);
+void mptcp_token_release(u32 token);
 void mptcp_token_destroy(u32 token);
 =

 void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b6059a4bb15b..a9a3bb9aef2d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -440,8 +440,7 @@ static void subflow_ulp_release(struct sock *sk)
 	struct subflow_context *ctx =3D subflow_ctx(sk);
 =

 	pr_debug("subflow=3D%p", ctx);
-
-	token_release(ctx->token);
+	mptcp_token_release(ctx->token);
 =

 	kfree(ctx);
 }
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 5bd3d0c78d04..2b1b571d49cd 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -215,16 +215,22 @@ void mptcp_token_destroy_request(u32 token)
 	spin_unlock_bh(&token_tree_lock);
 }
 =

-void token_release(u32 token)
+/**
+ * mptcp_token_release - put reference on token without withdrawing it
+ * @token - token of mptcp connection that the subflow is "leaving"
+ *
+ * This is used to close/remove a subflow without removing the
+ * mptcp connection from the token <-> mptcp_sk map.
+ */
+void mptcp_token_release(u32 token)
 {
 	struct sock *conn;
 =

-	pr_debug("token=3D%u", token);
 	spin_lock_bh(&token_tree_lock);
 	conn =3D __token_lookup(token);
+	spin_unlock_bh(&token_tree_lock);
 	if (conn)
 		sock_put(conn);
-	spin_unlock_bh(&token_tree_lock);
 }
 =

 /**
-- =

2.21.0


--===============0534692611353487363==--

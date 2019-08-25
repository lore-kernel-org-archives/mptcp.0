Content-Type: multipart/mixed; boundary="===============5856849439209165187=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 10/10] mptcp: token: rename token_release
Date: Sun, 25 Aug 2019 20:59:39 +0200
Message-ID: <20190825185939.21596-11-fw@strlen.de>
In-Reply-To: 20190825185939.21596-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1707

--===============5856849439209165187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

avoid namespace pollution -- add an mptcp prefix.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 3 +--
 net/mptcp/token.c    | 9 ++++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 94b06ec168ff..daeea2ec6fd5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -235,7 +235,7 @@ int mptcp_token_new_connect(struct sock *sk);
 int mptcp_token_new_accept(u32 token);
 void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
-void token_release(u32 token);
+void mptcp_token_release(u32 token);
 void mptcp_token_destroy(u32 token);
 =

 void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1cfd18e74486..fa244c0e6267 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -386,8 +386,7 @@ static void subflow_ulp_release(struct sock *sk)
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
index 3c1f43542e1e..c28b3c8b85a1 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -315,7 +315,14 @@ void mptcp_token_destroy_request(u32 token)
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

-- =

2.21.0


--===============5856849439209165187==--

Content-Type: multipart/mixed; boundary="===============5156235301215295857=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 08/10] mptcp: token: add error handling for
 token_new_accept
Date: Sun, 25 Aug 2019 20:59:37 +0200
Message-ID: <20190825185939.21596-9-fw@strlen.de>
In-Reply-To: 20190825185939.21596-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1705

--===============5156235301215295857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Insertion into radix tree might fail, so add error handling for this.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  5 ++++-
 net/mptcp/token.c    | 31 +++++++++++++++----------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7db59830a02a..a1e207db6703 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -232,7 +232,7 @@ bool mptcp_token_join_valid(const struct request_sock *=
req,
 			    const struct tcp_options_received *rx_opt);
 void token_destroy_request(u32 token);
 int mptcp_token_new_connect(struct sock *sk);
-void token_new_accept(struct sock *sk);
+int mptcp_token_new_accept(u32 token);
 void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
 void token_release(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a57bb6546261..85fb7a52e274 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -217,7 +217,10 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 			goto close_child;
 =

 		if (ctx->mp_capable) {
-			token_new_accept(child);
+			int ret =3D mptcp_token_new_accept(ctx->token);
+
+			if (ret)
+				goto close_child;
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index c0789643c71c..a0779fd0ae7c 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -46,17 +46,6 @@ static struct sock *__token_lookup(u32 token)
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
@@ -260,15 +249,25 @@ int mptcp_token_new_connect(struct sock *sk)
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


--===============5156235301215295857==--

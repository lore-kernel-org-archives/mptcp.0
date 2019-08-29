Content-Type: multipart/mixed; boundary="===============7655198024814819656=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 02/10] mptcp: token: remove two unneeded helpers
Date: Thu, 29 Aug 2019 11:06:51 +0200
Message-ID: <20190829090659.766-3-fw@strlen.de>
In-Reply-To: 20190829090659.766-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1744

--===============7655198024814819656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There were three flavours of almost the same function:

token_lookup_get, the base function that takes a token value and
looks up the mptcp socket associated with it.

token_new_subflow, same function, but will also set
subflow->local_nonce.

token_new_join, just like lookup_get, but assigns the
looked-up socket to subflow->conn.

This renames token_lookup_get to mptcp_token_get_sock to avoid
make it clear this belongs to mptcp namespace, and then
changes the callers of token_new_subflow to also init the nonce
and token_new_join to do the assignment in the caller.

v2: remove a stray WARN_ON (Matthieu)

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/pm.c       |  6 +++---
 net/mptcp/protocol.h |  4 +---
 net/mptcp/subflow.c  | 16 +++++++++++----
 net/mptcp/token.c    | 49 ++++++++++----------------------------------
 4 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c98b92512adf..a34b76d097f6 100644
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e97ac14115a2..1655283dbd6a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -232,11 +232,9 @@ int token_join_valid(struct request_sock *req,
 		     struct tcp_options_received *rx_opt);
 void token_destroy_request(u32 token);
 void token_new_connect(struct sock *sk);
-void token_new_subflow(struct sock *sk);
 void token_new_accept(struct sock *sk);
-int token_new_join(struct sock *sk);
 void token_update_accept(struct sock *sk, struct sock *conn);
-struct sock *token_lookup_get(u32 token);
+struct mptcp_sock *mptcp_token_get_sock(u32 token);
 void token_release(u32 token);
 void token_destroy(u32 token);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 27afc64d377f..fc507e091cf5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -24,7 +24,11 @@ static int subflow_rebuild_header(struct sock *sk)
 		token_new_connect(sk);
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

 	return inet_sk_rebuild_header(sk);
@@ -179,10 +183,14 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 		if (ctx->mp_capable) {
 			token_new_accept(child);
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
index 19b63bd34315..b63ce35c9ed3 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -290,23 +290,6 @@ void token_new_connect(struct sock *sk)
 	spin_unlock_bh(&token_tree_lock);
 }
 =

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
-	spin_unlock_bh(&token_tree_lock);
-
-	get_random_bytes(&subflow->local_nonce, sizeof(u32));
-}
-
 void token_new_accept(struct sock *sk)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
@@ -330,26 +313,16 @@ void token_update_accept(struct sock *sk, struct sock=
 *conn)
 	spin_unlock_bh(&token_tree_lock);
 }
 =

-int token_new_join(struct sock *sk)
-{
-	struct subflow_context *subflow =3D subflow_ctx(sk);
-	struct sock *conn;
-
-	spin_lock_bh(&token_tree_lock);
-	conn =3D __token_lookup(subflow->token);
-	if (conn)
-		sock_hold(conn);
-	spin_unlock_bh(&token_tree_lock);
-
-	if (!conn)
-		return -1;
-
-	subflow->conn =3D conn;
-
-	return 0;
-}
-
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

@@ -359,7 +332,7 @@ struct sock *token_lookup_get(u32 token)
 		sock_hold(conn);
 	spin_unlock_bh(&token_tree_lock);
 =

-	return conn;
+	return mptcp_sk(conn);
 }
 =

 void token_destroy_request(u32 token)
-- =

2.21.0


--===============7655198024814819656==--

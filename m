Content-Type: multipart/mixed; boundary="===============3748954672173730628=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 16/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:59 +0200
Message-ID: <20190615105259.15151-17-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1401

--===============3748954672173730628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - Prefer using the BIT macro
 - Unnecessary parentheses around 'X'
 - braces {} are not necessary for any arm of this statement
 - No space is necessary after a cast
 - please, no spaces at the start of a line
 - Comparison to NULL could be written "X" (4)
 - braces {} are not necessary for single statement blocks

What has not been fixed:

 - /

Fixes: 03f49d9db932 (mptcp: Add handling of incoming MP_JOIN requests)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  9 +++------
 net/mptcp/token.c    | 14 +++++++-------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 69e4be55d302..594134d39e1b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -37,7 +37,7 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6		20
 #define TCPOLEN_MPTCP_RM_ADDR		4
 =

-#define MPTCPOPT_BACKUP		(1 << 0)
+#define MPTCPOPT_BACKUP		BIT(0)
 #define MPTCPOPT_HMAC_LEN	20
 =

 /* MPTCP MP_CAPABLE flags */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9a475f83d446..c36d8d6e6f49 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -151,10 +151,8 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 	} else if (subflow_req->mp_join) {
 		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
-		if ((!opt_rx.mptcp.mp_join) ||
-		    (token_join_valid(req, &opt_rx))) {
+		if (!opt_rx.mptcp.mp_join || token_join_valid(req, &opt_rx))
 			return NULL;
-		}
 	}
 =

 	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);
@@ -168,11 +166,10 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 		if (ctx->mp_capable) {
 			token_new_accept(child);
 		} else if (ctx->mp_join) {
-			if (token_new_join(child)) {
+			if (token_new_join(child))
 				goto close_child;
-			} else {
+			else
 				mptcp_finish_join(ctx->conn, child);
-			}
 		}
 	}
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 16f0cad298a8..773e9fce86b6 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -61,7 +61,7 @@ static struct sock *lookup_token(u32 token)
 =

 	pr_debug("token=3D%u", token);
 	conn =3D radix_tree_lookup(&token_tree, token);
-	return (struct sock *) conn;
+	return (struct sock *)conn;
 }
 =

 static void new_req_token(struct request_sock *req,
@@ -139,7 +139,7 @@ static int new_join_valid(struct request_sock *req, str=
uct sock *sk,
 			 4, (u8 *)&subflow_req->local_nonce);
 =

 	return memcmp(hmac, (char *)rx_opt->mptcp.hmac, MPTCPOPT_HMAC_LEN);
- }
+}
 =

 static void new_token(const struct sock *sk)
 {
@@ -247,7 +247,7 @@ int token_join_request(struct request_sock *req, const =
struct sk_buff *skb)
 	spin_lock_bh(&token_tree_lock);
 	conn =3D lookup_token(subflow_req->token);
 	spin_unlock_bh(&token_tree_lock);
-	if (conn !=3D NULL) {
+	if (conn) {
 		// @@ get real local address id for this skb->saddr
 		subflow_req->local_id =3D 0;
 		new_req_join(req, conn, skb);
@@ -267,9 +267,9 @@ int token_join_valid(struct request_sock *req,
 	spin_lock_bh(&token_tree_lock);
 	conn =3D lookup_token(subflow_req->token);
 	spin_unlock_bh(&token_tree_lock);
-	if (conn !=3D NULL) {
+	if (conn)
 		return new_join_valid(req, conn, rx_opt);
-	}
+
 	return -1;
 }
 =

@@ -323,7 +323,7 @@ int token_new_join(struct sock *sk)
 =

 	spin_lock_bh(&token_tree_lock);
 	conn =3D lookup_token(subflow->token);
-	if (conn !=3D NULL) {
+	if (conn) {
 		sock_hold(conn);
 		spin_unlock_bh(&token_tree_lock);
 		subflow->conn =3D conn;
@@ -349,7 +349,7 @@ void token_release(u32 token)
 	pr_debug("token=3D%u", token);
 	spin_lock_bh(&token_tree_lock);
 	conn =3D lookup_token(token);
-	if (conn !=3D NULL)
+	if (conn)
 		sock_put(conn);
 	spin_unlock_bh(&token_tree_lock);
 }
-- =

2.20.1


--===============3748954672173730628==--

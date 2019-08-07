Content-Type: multipart/mixed; boundary="===============3575711776589385344=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] Rename lookup_token() to __token_lookup
Date: Wed, 07 Aug 2019 16:44:24 -0700
Message-ID: <20190807234426.13691-2-peter.krystad@linux.intel.com>
In-Reply-To: 20190807234426.13691-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1606

--===============3575711776589385344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Naming better aligns with token_lookup_get().

squashto: Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/token.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index b54f617d4c26..df7a35aa580e 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -54,7 +54,7 @@ static bool find_token(u32 token)
 	return used;
 }
 =

-static struct sock *lookup_token(u32 token)
+static struct sock *__token_lookup(u32 token)
 {
 	void *conn;
 =

@@ -221,7 +221,7 @@ int token_join_request(struct request_sock *req, const =
struct sk_buff *skb)
 =

 	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
 	spin_lock_bh(&token_tree_lock);
-	conn =3D lookup_token(subflow_req->token);
+	conn =3D __token_lookup(subflow_req->token);
 	if (conn)
 		sock_hold(conn);
 	spin_unlock_bh(&token_tree_lock);
@@ -259,7 +259,7 @@ int token_join_valid(struct request_sock *req,
 =

 	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
 	spin_lock_bh(&token_tree_lock);
-	conn =3D lookup_token(subflow_req->token);
+	conn =3D __token_lookup(subflow_req->token);
 	if (conn)
 		sock_hold(conn);
 	spin_unlock_bh(&token_tree_lock);
@@ -337,15 +337,17 @@ int token_new_join(struct sock *sk)
 	struct sock *conn;
 =

 	spin_lock_bh(&token_tree_lock);
-	conn =3D lookup_token(subflow->token);
-	if (conn) {
+	conn =3D __token_lookup(subflow->token);
+	if (conn)
 		sock_hold(conn);
-		spin_unlock_bh(&token_tree_lock);
-		subflow->conn =3D conn;
-		return 0;
-	}
 	spin_unlock_bh(&token_tree_lock);
-	return -1;
+
+	if (!conn)
+		return -1;
+
+	subflow->conn =3D conn;
+
+	return 0;
 }
 =

 struct sock *token_lookup_get(u32 token)
@@ -356,8 +358,8 @@ struct sock *token_lookup_get(u32 token)
 	conn =3D lookup_token(token);
 	if (conn)
 		sock_hold(conn);
-
 	spin_unlock_bh(&token_tree_lock);
+
 	return conn;
 }
 =

@@ -376,7 +378,7 @@ void token_release(u32 token)
 =

 	pr_debug("token=3D%u", token);
 	spin_lock_bh(&token_tree_lock);
-	conn =3D lookup_token(token);
+	conn =3D __token_lookup(token);
 	if (conn)
 		sock_put(conn);
 	spin_unlock_bh(&token_tree_lock);
-- =

2.17.2


--===============3575711776589385344==--

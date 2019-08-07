Content-Type: multipart/mixed; boundary="===============3321070761523692044=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 09/10] Use pm_get_local_id() to get the real local
 address id.
Date: Wed, 07 Aug 2019 15:44:33 -0700
Message-ID: <20190807224434.2829-10-peter.krystad@linux.intel.com>
In-Reply-To: 20190807224434.2829-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1601

--===============3321070761523692044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also, take reference to mptcp sock while using it

squashto: Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/token.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index d7cf40b40beb..80acb6c6657f 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -222,14 +222,22 @@ int token_join_request(struct request_sock *req, cons=
t struct sk_buff *skb)
 	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
 	spin_lock_bh(&token_tree_lock);
 	conn =3D lookup_token(subflow_req->token);
+	if (conn)
+		sock_hold(conn);
 	spin_unlock_bh(&token_tree_lock);
-	if (conn) {
-		// @@ get real local address id for this skb->saddr
-		subflow_req->local_id =3D 0;
-		new_req_join(req, conn, skb);
-		return 0;
+
+	if (!conn)
+		return -1;
+
+	if (pm_get_local_id(req, conn, skb)) {
+		sock_put(conn);
+		return -1;
 	}
-	return -1;
+
+	new_req_join(req, conn, skb);
+
+	sock_put(conn);
+	return 0;
 }
 =

 /* validate received truncated hmac and create hmac for third ACK */
@@ -247,15 +255,20 @@ int token_join_valid(struct request_sock *req,
 {
 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
 	struct sock *conn;
+	int err;
 =

 	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
 	spin_lock_bh(&token_tree_lock);
 	conn =3D lookup_token(subflow_req->token);
-	spin_unlock_bh(&token_tree_lock);
 	if (conn)
-		return new_join_valid(req, conn, rx_opt);
+		sock_hold(conn);
+	spin_unlock_bh(&token_tree_lock);
+	if (!conn)
+		return -1;
 =

-	return -1;
+	err =3D new_join_valid(req, conn, rx_opt);
+	sock_put(conn);
+	return err;
 }
 =

 /* create new local key, idsn, and token for subflow */
-- =

2.17.2


--===============3321070761523692044==--

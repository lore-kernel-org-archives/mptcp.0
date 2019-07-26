Content-Type: multipart/mixed; boundary="===============7429532561740699434=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 09/10] Use pm_get_local_id() to get the real local
 address id.
Date: Thu, 25 Jul 2019 18:58:26 -0700
Message-ID: <20190726015827.10637-10-peter.krystad@linux.intel.com>
In-Reply-To: 20190726015827.10637-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1564

--===============7429532561740699434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/token.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index b31d98ba5c0d..8e4da2d05f45 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -223,13 +223,15 @@ int token_join_request(struct request_sock *req, cons=
t struct sk_buff *skb)
 	spin_lock_bh(&token_tree_lock);
 	conn =3D lookup_token(subflow_req->token);
 	spin_unlock_bh(&token_tree_lock);
-	if (conn) {
-		// @@ get real local address id for this skb->saddr
-		subflow_req->local_id =3D 0;
-		new_req_join(req, conn, skb);
-		return 0;
-	}
-	return -1;
+	if (!conn)
+		return -1;
+
+	if (pm_get_local_id(req, conn, skb))
+		return -1;
+
+	new_req_join(req, conn, skb);
+
+	return 0;
 }
 =

 /* validate received truncated hmac and create hmac for third ACK */
-- =

2.17.2


--===============7429532561740699434==--

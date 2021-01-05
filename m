Content-Type: multipart/mixed; boundary="===============0586785078120635153=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v9 mptcp-next 3/9] mptcp: add a new helper
 subflow_req_create_thmac
Date: Tue, 05 Jan 2021 13:33:24 +0800
Message-ID: <166beca852ba7ce621d446b2dec20390c40d252a.1609820648.git.geliangtang@gmail.com>
In-Reply-To: c76eab6eb4af21880ca67709dbee4fe2a5f2cd78.1609820648.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7259

--===============0586785078120635153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new helper named subflow_req_create_thmac, which split
from subflow_token_join_request. It initialized subflow_req's local_nonce
and thmac fields, those are the more expensive to populate.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/subflow.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4bf0f83c4404..707afae8f61a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -61,10 +61,23 @@ static bool mptcp_can_accept_new_subflow(const struct m=
ptcp_sock *msk)
 }
 =

 /* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
+static void subflow_req_create_thmac(struct mptcp_subflow_request_sock *su=
bflow_req)
+{
+	struct mptcp_sock *msk =3D subflow_req->msk;
+	u8 hmac[SHA256_DIGEST_SIZE];
+
+	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
+
+	subflow_generate_hmac(msk->local_key, msk->remote_key,
+			      subflow_req->local_nonce,
+			      subflow_req->remote_nonce, hmac);
+
+	subflow_req->thmac =3D get_unaligned_be64(hmac);
+}
+
 static struct mptcp_sock *subflow_token_join_request(struct request_sock *=
req)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
-	u8 hmac[SHA256_DIGEST_SIZE];
 	struct mptcp_sock *msk;
 	int local_id;
 =

@@ -81,13 +94,6 @@ static struct mptcp_sock *subflow_token_join_request(str=
uct request_sock *req)
 	}
 	subflow_req->local_id =3D local_id;
 =

-	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
-
-	subflow_generate_hmac(msk->local_key, msk->remote_key,
-			      subflow_req->local_nonce,
-			      subflow_req->remote_nonce, hmac);
-
-	subflow_req->thmac =3D get_unaligned_be64(hmac);
 	return msk;
 }
 =

@@ -183,6 +189,8 @@ static int subflow_init_req(struct request_sock *req,
 		if (!subflow_req->msk)
 			return -EPERM;
 =

+		subflow_req_create_thmac(subflow_req);
+
 		if (unlikely(req->syncookie)) {
 			if (mptcp_can_accept_new_subflow(subflow_req->msk))
 				subflow_init_req_cookie_join_save(subflow_req, skb);
-- =

2.29.2

--===============0586785078120635153==--

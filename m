Content-Type: multipart/mixed; boundary="===============6225751381420306382=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v10 mptcp-next 2/9] mptcp: drop unused skb in
 subflow_token_join_request
Date: Thu, 14 Jan 2021 13:24:59 +0800
Message-ID: <7a41acee25033aa36629701ff6b0f51cac507a9e.1610598621.git.geliangtang@gmail.com>
In-Reply-To: c93951b54403b5174c37f239823ef77ca1e60989.1610598621.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7359

--===============6225751381420306382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch dropped the unused parameter skb in subflow_token_join_request.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/subflow.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 293a09125621..700a87ee39f1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -61,8 +61,7 @@ static bool mptcp_can_accept_new_subflow(const struct mpt=
cp_sock *msk)
 }
 =

 /* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
-static struct mptcp_sock *subflow_token_join_request(struct request_sock *=
req,
-						     const struct sk_buff *skb)
+static struct mptcp_sock *subflow_token_join_request(struct request_sock *=
req)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	u8 hmac[SHA256_DIGEST_SIZE];
@@ -178,7 +177,7 @@ static int subflow_init_req(struct request_sock *req,
 		subflow_req->remote_id =3D mp_opt.join_id;
 		subflow_req->token =3D mp_opt.token;
 		subflow_req->remote_nonce =3D mp_opt.nonce;
-		subflow_req->msk =3D subflow_token_join_request(req, skb);
+		subflow_req->msk =3D subflow_token_join_request(req);
 =

 		/* Can't fall back to TCP in this case. */
 		if (!subflow_req->msk)
-- =

2.29.2

--===============6225751381420306382==--

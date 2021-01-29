Content-Type: multipart/mixed; boundary="===============6109938031876175748=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 09/16] mptcp: add a new helper
 subflow_req_create_thmac
Date: Thu, 28 Jan 2021 17:11:08 -0800
Message-ID: <20210129011115.133953-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210129011115.133953-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7516

--===============6109938031876175748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch adds a new helper named subflow_req_create_thmac, which is
extracted from subflow_token_join_request. It initializes subflow_req's
local_nonce and thmac fields, those are the more expensive to populate.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/subflow.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2dcc0fb5a69e..94926ab74d48 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -64,10 +64,23 @@ static bool mptcp_can_accept_new_subflow(const struct m=
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

@@ -84,13 +97,6 @@ static struct mptcp_sock *subflow_token_join_request(str=
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

@@ -186,6 +192,8 @@ static int subflow_init_req(struct request_sock *req,
 		if (!subflow_req->msk)
 			return -EPERM;
 =

+		subflow_req_create_thmac(subflow_req);
+
 		if (unlikely(req->syncookie)) {
 			if (mptcp_can_accept_new_subflow(subflow_req->msk))
 				subflow_init_req_cookie_join_save(subflow_req, skb);
-- =

2.30.0

--===============6109938031876175748==--

Content-Type: multipart/mixed; boundary="===============5092124578944730510=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 08/16] mptcp: drop unused skb in
 subflow_token_join_request
Date: Thu, 28 Jan 2021 17:11:07 -0800
Message-ID: <20210129011115.133953-9-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210129011115.133953-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7513

--===============5092124578944730510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch drops the unused parameter skb in subflow_token_join_request.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/subflow.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 50a01546ac34..2dcc0fb5a69e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -64,8 +64,7 @@ static bool mptcp_can_accept_new_subflow(const struct mpt=
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
@@ -181,7 +180,7 @@ static int subflow_init_req(struct request_sock *req,
 		subflow_req->remote_id =3D mp_opt.join_id;
 		subflow_req->token =3D mp_opt.token;
 		subflow_req->remote_nonce =3D mp_opt.nonce;
-		subflow_req->msk =3D subflow_token_join_request(req, skb);
+		subflow_req->msk =3D subflow_token_join_request(req);
 =

 		/* Can't fall back to TCP in this case. */
 		if (!subflow_req->msk)
-- =

2.30.0

--===============5092124578944730510==--

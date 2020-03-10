Content-Type: multipart/mixed; boundary="===============0666256841197343796=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 4/5] mptcp: v1 ADD_ADDR changes: add
 subflow_generate_hmac()
Date: Tue, 10 Mar 2020 15:33:31 -0700
Message-ID: <20200310223332.3845-5-peter.krystad@linux.intel.com>
In-Reply-To: 20200310223332.3845-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3908

--===============0666256841197343796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add subflow_generate_hmac() to generate hmac from nonces.

squash-to: Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/subflow.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index de35c47e829f..dc7e0cc64659 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -48,6 +48,17 @@ static void subflow_req_destructor(struct request_sock *=
req)
 	tcp_request_sock_ops.destructor(req);
 }
 =

+static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonc=
e2,
+				  void *hmac)
+{
+	u8 msg[8];
+
+	put_unaligned_be32(nonce1, &msg[0]);
+	put_unaligned_be32(nonce2, &msg[4]);
+
+	mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
+}
+
 /* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
 static bool subflow_token_join_request(struct request_sock *req,
 				       const struct sk_buff *skb)
@@ -73,9 +84,9 @@ static bool subflow_token_join_request(struct request_soc=
k *req,
 =

 	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
 =

-	mptcp_crypto_hmac_sha(msk->local_key, msk->remote_key,
+	subflow_generate_hmac(msk->local_key, msk->remote_key,
 			      subflow_req->local_nonce,
-			      subflow_req->remote_nonce, (u32 *)hmac);
+			      subflow_req->remote_nonce, hmac);
 =

 	subflow_req->thmac =3D get_unaligned_be64(hmac);
 =

@@ -238,9 +249,9 @@ static bool subflow_hmac_valid(const struct request_soc=
k *req,
 	if (!msk)
 		return false;
 =

-	mptcp_crypto_hmac_sha(msk->remote_key, msk->local_key,
+	subflow_generate_hmac(msk->remote_key, msk->local_key,
 			      subflow_req->remote_nonce,
-			      subflow_req->local_nonce, (u32 *)hmac);
+			      subflow_req->local_nonce, hmac);
 =

 	ret =3D true;
 	if (crypto_memneq(hmac, rx_opt->mptcp.hmac, sizeof(hmac)))
-- =

2.17.2

--===============0666256841197343796==--

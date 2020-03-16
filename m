Content-Type: multipart/mixed; boundary="===============3640940837863371439=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v5 4/5] mptcp: v1 ADD_ADDR changes: add
 subflow_generate_hmac()
Date: Mon, 16 Mar 2020 11:39:10 -0700
Message-ID: <20200316183911.4347-5-peter.krystad@linux.intel.com>
In-Reply-To: 20200316183911.4347-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3962

--===============3640940837863371439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add subflow_generate_hmac() to generate hmac from nonces.

squash-to: Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h |  2 +-
 net/mptcp/subflow.c | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 4cf39e002a19..67f314907c60 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -94,11 +94,11 @@ struct mptcp_options_received {
 		family : 4,
 		echo : 1,
 		backup : 1;
-	u8	join_id;
 	u32	token;
 	u32	nonce;
 	u64	thmac;
 	u8	hmac[20];
+	u8	join_id;
 	u8	use_map:1,
 		dsn64:1,
 		data_fin:1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 574391d014ac..82060fb2433a 100644
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

--===============3640940837863371439==--

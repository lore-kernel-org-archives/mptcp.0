Content-Type: multipart/mixed; boundary="===============6547690829114737700=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: Re-factor mptcp_crypto_hmac_sha()
Date: Fri, 07 Feb 2020 17:39:29 -0800
Message-ID: <20200208013930.16640-2-peter.krystad@linux.intel.com>
In-Reply-To: 20200208013930.16640-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3602

--===============6547690829114737700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow it to take variable-length messages so that v1 ADD_ADDR
option processing may use it.

squashto: Add ADD_ADDR handling

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/crypto.c   | 14 ++++++++------
 net/mptcp/protocol.h |  3 +--
 net/mptcp/subflow.c  | 19 +++++++++++++++----
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 40d1bb18fd60..16d0b2b60b25 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -44,8 +44,7 @@ void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn)
 		*idsn =3D be64_to_cpu(*((__be64 *)&mptcp_hashed_key[6]));
 }
 =

-void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
-			   void *hmac)
+void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hma=
c)
 {
 	u8 input[SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE];
 	__be32 mptcp_hashed_key[SHA256_DIGEST_WORDS];
@@ -65,11 +64,10 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonc=
e1, u32 nonce2,
 	for (i =3D 0; i < 8; i++)
 		input[i + 8] ^=3D key2be[i];
 =

-	put_unaligned_be32(nonce1, &input[SHA256_BLOCK_SIZE]);
-	put_unaligned_be32(nonce2, &input[SHA256_BLOCK_SIZE + 4]);
+	memcpy(&input[SHA256_BLOCK_SIZE], msg, len);
 =

 	sha256_init(&state);
-	sha256_update(&state, input, SHA256_BLOCK_SIZE + 8);
+	sha256_update(&state, input, SHA256_BLOCK_SIZE + len);
 =

 	/* emit sha256(K1 || msg) on the second input block, so we can
 	 * reuse 'input' for the last hashing
@@ -125,6 +123,7 @@ static int __init test_mptcp_crypto(void)
 	char hmac[20], hmac_hex[41];
 	u32 nonce1, nonce2;
 	u64 key1, key2;
+	u8 msg[8];
 	int i, j;
 =

 	for (i =3D 0; i < ARRAY_SIZE(tests); ++i) {
@@ -134,7 +133,10 @@ static int __init test_mptcp_crypto(void)
 		nonce1 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[0]));
 		nonce2 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[4]));
 =

-		mptcp_crypto_hmac_sha(key1, key2, nonce1, nonce2, hmac);
+		put_unaligned_be32(nonce1, &msg[0]);
+		put_unaligned_be32(nonce2, &msg[4]);
+
+		mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
 		for (j =3D 0; j < 20; ++j)
 			sprintf(&hmac_hex[j << 1], "%02x", hmac[j] & 0xff);
 		hmac_hex[40] =3D 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3fbb33deb764..e10b24ba1636 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -339,8 +339,7 @@ static inline void mptcp_crypto_key_gen_sha(u64 *key, u=
32 *token, u64 *idsn)
 	mptcp_crypto_key_sha(*key, token, idsn);
 }
 =

-void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
-			   void *hash_out);
+void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hma=
c);
 =

 void mptcp_pm_init(void);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 547d5ffef070..8a41f6b661c9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -61,6 +61,17 @@ static void subflow_req_destructor(struct request_sock *=
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
+	mptcp_crypto_hmac_sha(key1, key2, msg, 8, (u32 *)hmac);
+}
+
 /* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
 static bool subflow_token_join_request(struct request_sock *req,
 				       const struct sk_buff *skb)
@@ -82,7 +93,7 @@ static bool subflow_token_join_request(struct request_soc=
k *req,
 =

 	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
 =

-	mptcp_crypto_hmac_sha(msk->local_key, msk->remote_key,
+	subflow_generate_hmac(msk->local_key, msk->remote_key,
 			      subflow_req->local_nonce,
 			      subflow_req->remote_nonce, (u32 *)hmac);
 =

@@ -180,7 +191,7 @@ static bool subflow_thmac_valid(struct mptcp_subflow_co=
ntext *subflow)
 	u8 hmac[MPTCPOPT_HMAC_LEN];
 	u64 thmac;
 =

-	mptcp_crypto_hmac_sha(subflow->remote_key, subflow->local_key,
+	subflow_generate_hmac(subflow->remote_key, subflow->local_key,
 			      subflow->remote_nonce, subflow->local_nonce,
 			      (u32 *)hmac);
 =

@@ -225,7 +236,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 			goto do_reset;
 		}
 =

-		mptcp_crypto_hmac_sha(subflow->local_key, subflow->remote_key,
+		subflow_generate_hmac(subflow->local_key, subflow->remote_key,
 				      subflow->local_nonce,
 				      subflow->remote_nonce,
 				      (u32 *)subflow->hmac);
@@ -305,7 +316,7 @@ static bool subflow_hmac_valid(const struct request_soc=
k *req,
 	if (!msk)
 		return false;
 =

-	mptcp_crypto_hmac_sha(msk->remote_key, msk->local_key,
+	subflow_generate_hmac(msk->remote_key, msk->local_key,
 			      subflow_req->remote_nonce,
 			      subflow_req->local_nonce, (u32 *)hmac);
 =

-- =

2.17.2

--===============6547690829114737700==--

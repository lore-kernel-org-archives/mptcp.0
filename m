Content-Type: multipart/mixed; boundary="===============1739528541328329644=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Prefix crypto routines with mptcp_
Date: Wed, 18 Sep 2019 13:49:26 -0700
Message-ID: <20190918204926.3427-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1880

--===============1739528541328329644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do not pollute crypto namespace.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/crypto.c   |  5 +++--
 net/mptcp/options.c  |  4 ++--
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h | 11 ++++++-----
 net/mptcp/subflow.c  | 27 ++++++++++++++-------------
 net/mptcp/token.c    | 10 +++++-----
 6 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 8b67b11e626c..a0e27aaa3503 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -26,7 +26,7 @@
 #include <linux/siphash.h>
 #include <asm/unaligned.h>
 =

-void crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
+void mptcp_crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
 {
 	u32 workspace[SHA_WORKSPACE_WORDS];
 	u32 mptcp_hashed_key[SHA_DIGEST_WORDS];
@@ -51,7 +51,8 @@ void crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
 		*idsn =3D ((u64)mptcp_hashed_key[3] << 32) + mptcp_hashed_key[4];
 }
 =

-void crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2, u32 *has=
h_out)
+void mptcp_crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
+			    u32 *hash_out)
 {
 	u32 workspace[SHA_WORKSPACE_WORDS];
 	u8 input[128]; /* 2 512-bit blocks */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b82557af3fae..892c824a01e3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -430,8 +430,8 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 		if (msk) {
 			opts->ext_copy.data_ack =3D msk->ack_seq;
 		} else {
-			crypto_key_sha1(subflow_ctx(sk)->remote_key, NULL,
-					&opts->ext_copy.data_ack);
+			mptcp_crypto_key_sha1(subflow_ctx(sk)->remote_key,
+					      NULL, &opts->ext_copy.data_ack);
 			opts->ext_copy.data_ack++;
 		}
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 80cd984d1e01..61aaad61034a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -702,7 +702,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 =

 		pm_new_connection(msk, 1);
 =

-		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
+		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
@@ -834,7 +834,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 =

 		pm_new_connection(msk, 0);
 =

-		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
+		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ac5f87495348..ef846bb5f1ad 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -237,8 +237,8 @@ void mptcp_token_update_accept(struct sock *sk, struct =
sock *conn);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
 void mptcp_token_destroy(u32 token);
 =

-void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
-static inline void crypto_key_gen_sha1(u64 *key, u32 *token, u64 *idsn)
+void mptcp_crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
+static inline void mptcp_crypto_key_gen_sha1(u64 *key, u32 *token, u64 *id=
sn)
 {
 	/* we might consider a faster version that computes the key as a
 	 * hash of some information available in the MPTCP socket. Use
@@ -247,10 +247,11 @@ static inline void crypto_key_gen_sha1(u64 *key, u32 =
*token, u64 *idsn)
 	 * the same time.
 	 */
 	get_random_bytes(key, sizeof(u64));
-	crypto_key_sha1(*key, token, idsn);
+	mptcp_crypto_key_sha1(*key, token, idsn);
 }
-void crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
-		      u32 *hash_out);
+
+void mptcp_crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
+			    u32 *hash_out);
 =

 void pm_new_connection(struct mptcp_sock *msk, int server_side);
 void pm_fully_established(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a49cc5ed1b27..f3d37ccdb9c4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -74,9 +74,9 @@ static bool subflow_token_join_request(struct request_soc=
k *req,
 =

 	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
 =

-	crypto_hmac_sha1(msk->local_key, msk->remote_key,
-			 subflow_req->local_nonce, subflow_req->remote_nonce,
-			 (u32 *)hmac);
+	mptcp_crypto_hmac_sha1(msk->local_key, msk->remote_key,
+			       subflow_req->local_nonce,
+			       subflow_req->remote_nonce, (u32 *)hmac);
 =

 	subflow_req->thmac =3D get_unaligned_be64(hmac);
 =

@@ -144,9 +144,9 @@ static bool subflow_thmac_valid(struct subflow_context =
*subflow)
 	u8 hmac[MPTCPOPT_HMAC_LEN];
 	u64 thmac;
 =

-	crypto_hmac_sha1(subflow->remote_key, subflow->local_key,
-			 subflow->remote_nonce, subflow->local_nonce,
-			 (u32 *)hmac);
+	mptcp_crypto_hmac_sha1(subflow->remote_key, subflow->local_key,
+			       subflow->remote_nonce, subflow->local_nonce,
+			       (u32 *)hmac);
 =

 	thmac =3D get_unaligned_be64(hmac);
 	pr_debug("subflow=3D%p, token=3D%u, thmac=3D%llu, subflow->thmac=3D%llu\n=
",
@@ -186,9 +186,10 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 			return;
 		}
 =

-		crypto_hmac_sha1(subflow->local_key, subflow->remote_key,
-				 subflow->local_nonce, subflow->remote_nonce,
-				 (u32 *)subflow->hmac);
+		mptcp_crypto_hmac_sha1(subflow->local_key, subflow->remote_key,
+				       subflow->local_nonce,
+				       subflow->remote_nonce,
+				       (u32 *)subflow->hmac);
 =

 		mptcp_finish_join(sk);
 		subflow->conn_finished =3D 1;
@@ -229,9 +230,9 @@ static bool subflow_hmac_valid(const struct request_soc=
k *req,
 	if (!msk)
 		return false;
 =

-	crypto_hmac_sha1(msk->remote_key, msk->local_key,
-			 subflow_req->remote_nonce, subflow_req->local_nonce,
-			 (u32 *)hmac);
+	mptcp_crypto_hmac_sha1(msk->remote_key, msk->local_key,
+			       subflow_req->remote_nonce,
+			       subflow_req->local_nonce, (u32 *)hmac);
 =

 	ret =3D true;
 	if (crypto_memneq(hmac, rx_opt->mptcp.hmac, sizeof(hmac)))
@@ -347,7 +348,7 @@ int subflow_connect(struct sock *sk, struct sockaddr_in=
 *local,
 	if (err)
 		goto failed;
 =

-	crypto_key_sha1(subflow->remote_key, &remote_token, NULL);
+	mptcp_crypto_key_sha1(subflow->remote_key, &remote_token, NULL);
 	pr_debug("msk=3D%p remote_token=3D%u", msk, remote_token);
 	subflow->remote_token =3D remote_token;
 	subflow->remote_id =3D remote_id;
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f493ebb4c2d8..f3e4a50414e3 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -58,9 +58,9 @@ int mptcp_token_new_request(struct request_sock *req)
 	while (1) {
 		u32 token;
 =

-		crypto_key_gen_sha1(&subflow_req->local_key,
-				    &subflow_req->token,
-				    &subflow_req->idsn);
+		mptcp_crypto_key_gen_sha1(&subflow_req->local_key,
+					  &subflow_req->token,
+					  &subflow_req->idsn);
 		pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
 			 subflow_req->local_key,
 			 subflow_req->token, subflow_req->idsn);
@@ -106,8 +106,8 @@ int mptcp_token_new_connect(struct sock *sk)
 	while (1) {
 		u32 token;
 =

-		crypto_key_gen_sha1(&subflow->local_key, &subflow->token,
-				    &subflow->idsn);
+		mptcp_crypto_key_gen_sha1(&subflow->local_key, &subflow->token,
+					  &subflow->idsn);
 =

 		pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
 			 subflow->local_key,
-- =

2.17.2


--===============1739528541328329644==--

Content-Type: multipart/mixed; boundary="===============3510587190009122556=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/4] crypto: refactor crypto helpers.
Date: Fri, 22 Nov 2019 15:26:10 +0100
Message-ID: <1a04bbf7787a4bb09acf4066ede6214bf53c400e.1574432261.git.pabeni@redhat.com>
In-Reply-To: cover.1574432261.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2661

--===============3510587190009122556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rename hash helpers from *_sha1 to *_sha.
Refactor the crypto code to make it easier transitioning to
crypto/sha.h primitives (and thus sha256).
Additionally, fix 2 buglets:
- mptcp_crypto_hmac_sha() computed uncorrect 'idsn' value on
  BE systems
- workspace should be clearer _after_ sha computation, to avoid
  leaking sensitive info

Squash-to: "mptcp: Add key generation and token tree"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/crypto.c   | 142 +++++++++++++++++++++----------------------
 net/mptcp/protocol.h |  10 +--
 net/mptcp/token.c    |  10 +--
 3 files changed, 78 insertions(+), 84 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 0d7b10939ba6..ccb9f7effdcd 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -22,107 +22,101 @@
 =

 #include <linux/kernel.h>
 #include <linux/cryptohash.h>
-#include <linux/random.h>
-#include <linux/siphash.h>
 #include <asm/unaligned.h>
 =

 #include "protocol.h"
 =

-void mptcp_crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
-{
+struct sha1_state {
 	u32 workspace[SHA_WORKSPACE_WORDS];
-	u32 mptcp_hashed_key[SHA_DIGEST_WORDS];
-	u8 input[64];
+	u32 digest[SHA_DIGEST_WORDS];
+	unsigned int count;
+};
 =

-	memset(workspace, 0, sizeof(workspace));
+static void sha1_init(struct sha1_state *state)
+{
+	sha_init(state->digest);
+	state->count =3D 0;
+}
 =

-	/* Initialize input with appropriate padding */
-	memset(&input[9], 0, sizeof(input) - 10); /* -10, because the last byte
-						   * is explicitly set too
-						   */
-	put_unaligned_be64(key, input);
-	input[8] =3D 0x80; /* Padding: First bit after message =3D 1 */
-	input[63] =3D 0x40; /* Padding: Length of the message =3D 64 bits */
+static void sha1_update(struct sha1_state *state, u8 *input)
+{
+	sha_transform(state->digest, input, state->workspace);
+	state->count +=3D SHA_MESSAGE_BYTES;
+}
 =

-	sha_init(mptcp_hashed_key);
-	sha_transform(mptcp_hashed_key, input, workspace);
+static void sha1_pad_final(struct sha1_state *state, u8 *input, unsigned l=
ength,
+			   __be32 *mptcp_hashed_key)
+{
+	int i;
+
+	input[length] =3D 0x80;
+	memset(&input[length + 1], 0, SHA_MESSAGE_BYTES - length - 9);
+	put_unaligned_be64((length + state->count) << 3,
+			   &input[SHA_MESSAGE_BYTES - 8]);
+
+	sha_transform(state->digest, input, state->workspace);
+	for (i =3D 0; i < SHA_DIGEST_WORDS; ++i)
+		put_unaligned_be32(state->digest[i], &mptcp_hashed_key[i]);
+
+	memzero_explicit(state->workspace, SHA_WORKSPACE_WORDS << 2);
+}
+
+void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn)
+{
+	__be32 mptcp_hashed_key[SHA_DIGEST_WORDS];
+	u8 input[SHA_MESSAGE_BYTES];
+	struct sha1_state state;
+
+	sha1_init(&state);
+	put_unaligned_be64(key, input);
+	sha1_pad_final(&state, input, 8, mptcp_hashed_key);
 =

 	if (token)
-		*token =3D mptcp_hashed_key[0];
+		*token =3D be32_to_cpu(mptcp_hashed_key[0]);
 	if (idsn)
-		*idsn =3D ((u64)mptcp_hashed_key[3] << 32) + mptcp_hashed_key[4];
+		*idsn =3D be64_to_cpu(*((__be64 *)&mptcp_hashed_key[3]));
 }
 =

-void mptcp_crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
+void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 			    u32 *hash_out)
 {
-	u32 workspace[SHA_WORKSPACE_WORDS];
-	u8 input[128]; /* 2 512-bit blocks */
+	u8 input[SHA_MESSAGE_BYTES * 2];
+	struct sha1_state state;
+	u8 key1be[8];
+	u8 key2be[8];
 	int i;
-	int index;
-	u8 key_1[8];
-	u8 key_2[8];
-	u8 nonce_1[4];
-	u8 nonce_2[4];
-
-	memset(workspace, 0, sizeof(workspace));
 =

-	put_unaligned_be64(key1, key_1);
-	put_unaligned_be64(key2, key_2);
-	put_unaligned_be32(nonce1, nonce_1);
-	put_unaligned_be32(nonce2, nonce_2);
+	put_unaligned_be64(key1, key1be);
+	put_unaligned_be64(key2, key2be);
 =

 	/* Generate key xored with ipad */
-	memset(input, 0x36, 64);
+	memset(input, 0x36, SHA_MESSAGE_BYTES);
 	for (i =3D 0; i < 8; i++)
-		input[i] ^=3D key_1[i];
+		input[i] ^=3D key1be[i];
 	for (i =3D 0; i < 8; i++)
-		input[i + 8] ^=3D key_2[i];
-
-	index =3D 64;
-	memcpy(&input[index], nonce_1, 4);
-	index =3D 68;
-	memcpy(&input[index], nonce_2, 4);
-	index =3D 72;
+		input[i + 8] ^=3D key2be[i];
 =

-	input[index] =3D 0x80; /* Padding: First bit after message =3D 1 */
-	memset(&input[index + 1], 0, (126 - index));
+	put_unaligned_be32(nonce1, &input[SHA_MESSAGE_BYTES]);
+	put_unaligned_be32(nonce2, &input[SHA_MESSAGE_BYTES + 4]);
 =

-	/* Padding: Length of the message =3D 512 + message length (bits) */
-	input[126] =3D 0x02;
-	input[127] =3D ((index - 64) * 8); /* Message length (bits) */
+	sha1_init(&state);
+	sha1_update(&state, input);
 =

-	sha_init(hash_out);
-	sha_transform(hash_out, input, workspace);
-	memset(workspace, 0, sizeof(workspace));
-
-	sha_transform(hash_out, &input[64], workspace);
-	memset(workspace, 0, sizeof(workspace));
-
-	for (i =3D 0; i < 5; i++)
-		hash_out[i] =3D (__force u32)cpu_to_be32(hash_out[i]);
+	/* emit sha256(K1 || msg) on the second input block, so we can
+	 * reuse 'input' for the last hashing
+	 */
+	sha1_pad_final(&state, &input[SHA_MESSAGE_BYTES], 8,
+		       (__force __be32 *)&input[SHA_MESSAGE_BYTES]);
 =

 	/* Prepare second part of hmac */
-	memset(input, 0x5C, 64);
+	memset(input, 0x5C, SHA_MESSAGE_BYTES);
 	for (i =3D 0; i < 8; i++)
-		input[i] ^=3D key_1[i];
+		input[i] ^=3D key1be[i];
 	for (i =3D 0; i < 8; i++)
-		input[i + 8] ^=3D key_2[i];
-
-	memcpy(&input[64], hash_out, 20);
-	input[84] =3D 0x80;
-	memset(&input[85], 0, 41);
-
-	/* Padding: Length of the message =3D 512 + 160 bits */
-	input[126] =3D 0x02;
-	input[127] =3D 0xA0;
-
-	sha_init(hash_out);
-	sha_transform(hash_out, input, workspace);
-	memset(workspace, 0, sizeof(workspace));
-
-	sha_transform(hash_out, &input[64], workspace);
+		input[i + 8] ^=3D key2be[i];
 =

-	for (i =3D 0; i < 5; i++)
-		hash_out[i] =3D (__force u32)cpu_to_be32(hash_out[i]);
+	sha1_init(&state);
+	sha1_update(&state, input);
+	sha1_pad_final(&state, &input[SHA_MESSAGE_BYTES], SHA_DIGEST_WORDS << 2,
+		      (__be32*)hash_out);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 171465ba3089..974d75a75f25 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -128,8 +128,8 @@ int mptcp_token_new_accept(u32 token);
 void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
 void mptcp_token_destroy(u32 token);
 =

-void mptcp_crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
-static inline void mptcp_crypto_key_gen_sha1(u64 *key, u32 *token, u64 *id=
sn)
+void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
+static inline void mptcp_crypto_key_gen_sha(u64 *key, u32 *token, u64 *ids=
n)
 {
 	/* we might consider a faster version that computes the key as a
 	 * hash of some information available in the MPTCP socket. Use
@@ -138,10 +138,10 @@ static inline void mptcp_crypto_key_gen_sha1(u64 *key=
, u32 *token, u64 *idsn)
 	 * the same time.
 	 */
 	get_random_bytes(key, sizeof(u64));
-	mptcp_crypto_key_sha1(*key, token, idsn);
+	mptcp_crypto_key_sha(*key, token, idsn);
 }
 =

-void mptcp_crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
-			    u32 *hash_out);
+void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
+			   u32 *hash_out);
 =

 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index ed6a92f0786c..84d887806090 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -57,9 +57,9 @@ int mptcp_token_new_request(struct request_sock *req)
 	while (1) {
 		u32 token;
 =

-		mptcp_crypto_key_gen_sha1(&subflow_req->local_key,
-					  &subflow_req->token,
-					  &subflow_req->idsn);
+		mptcp_crypto_key_gen_sha(&subflow_req->local_key,
+					 &subflow_req->token,
+					 &subflow_req->idsn);
 		pr_debug("req=3D%p local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
 			 req, subflow_req->local_key, subflow_req->token,
 			 subflow_req->idsn);
@@ -103,8 +103,8 @@ int mptcp_token_new_connect(struct sock *sk)
 	while (1) {
 		u32 token;
 =

-		mptcp_crypto_key_gen_sha1(&subflow->local_key, &subflow->token,
-					  &subflow->idsn);
+		mptcp_crypto_key_gen_sha(&subflow->local_key, &subflow->token,
+					 &subflow->idsn);
 =

 		pr_debug("ssk=3D%p, local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
 			 sk, subflow->local_key, subflow->token, subflow->idsn);
-- =

2.21.0

--===============3510587190009122556==--

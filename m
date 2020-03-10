Content-Type: multipart/mixed; boundary="===============5034705441939257598=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 2/5] mptcp: Re-factor mptcp_crypto_hmac_sha()
Date: Tue, 10 Mar 2020 15:33:29 -0700
Message-ID: <20200310223332.3845-3-peter.krystad@linux.intel.com>
In-Reply-To: 20200310223332.3845-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3907

--===============5034705441939257598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow it to take variable-length messages so that v1 ADD_ADDR
option processing may also use it.

squashto: Add ADD_ADDR handling

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/crypto.c   | 17 +++++++++++------
 net/mptcp/protocol.h |  3 +--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 40d1bb18fd60..c151628bd416 100644
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
@@ -55,6 +54,9 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonce1=
, u32 nonce2,
 	u8 key2be[8];
 	int i;
 =

+	if (WARN_ON_ONCE(len > SHA256_DIGEST_SIZE))
+		len =3D SHA256_DIGEST_SIZE;
+
 	put_unaligned_be64(key1, key1be);
 	put_unaligned_be64(key2, key2be);
 =

@@ -65,11 +67,10 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonc=
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
@@ -125,6 +126,7 @@ static int __init test_mptcp_crypto(void)
 	char hmac[20], hmac_hex[41];
 	u32 nonce1, nonce2;
 	u64 key1, key2;
+	u8 msg[8];
 	int i, j;
 =

 	for (i =3D 0; i < ARRAY_SIZE(tests); ++i) {
@@ -134,7 +136,10 @@ static int __init test_mptcp_crypto(void)
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
index a524ac55a575..39b36fe1c337 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -236,8 +236,7 @@ static inline void mptcp_crypto_key_gen_sha(u64 *key, u=
32 *token, u64 *idsn)
 	mptcp_crypto_key_sha(*key, token, idsn);
 }
 =

-void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
-			   void *hash_out);
+void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hma=
c);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
-- =

2.17.2

--===============5034705441939257598==--

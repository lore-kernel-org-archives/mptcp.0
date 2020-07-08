Content-Type: multipart/mixed; boundary="===============9027493759343680236=="
MIME-Version: 1.0
From: Eric Biggers <ebiggers at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/5] mptcp: use sha256() instead of open coding
Date: Wed, 08 Jul 2020 09:39:42 -0700
Message-ID: <20200708163943.52071-5-ebiggers@kernel.org>
In-Reply-To: 20200708163943.52071-1-ebiggers@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 4953

--===============9027493759343680236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Eric Biggers <ebiggers(a)google.com>

Now that there's a function that calculates the SHA-256 digest of a
buffer in one step, use it instead of sha256_init() + sha256_update() +
sha256_final().

Reviewed-by: Ard Biesheuvel <ardb(a)kernel.org>
Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Cc: mptcp(a)lists.01.org
Cc: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Eric Biggers <ebiggers(a)google.com>
---
 net/mptcp/crypto.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 3d980713a9e2..82bd2b54d741 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -32,11 +32,8 @@ void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn)
 {
 	__be32 mptcp_hashed_key[SHA256_DIGEST_WORDS];
 	__be64 input =3D cpu_to_be64(key);
-	struct sha256_state state;
 =

-	sha256_init(&state);
-	sha256_update(&state, (__force u8 *)&input, sizeof(input));
-	sha256_final(&state, (u8 *)mptcp_hashed_key);
+	sha256((__force u8 *)&input, sizeof(input), (u8 *)mptcp_hashed_key);
 =

 	if (token)
 		*token =3D be32_to_cpu(mptcp_hashed_key[0]);
@@ -47,7 +44,6 @@ void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn)
 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hma=
c)
 {
 	u8 input[SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE];
-	struct sha256_state state;
 	u8 key1be[8];
 	u8 key2be[8];
 	int i;
@@ -67,13 +63,10 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg,=
 int len, void *hmac)
 =

 	memcpy(&input[SHA256_BLOCK_SIZE], msg, len);
 =

-	sha256_init(&state);
-	sha256_update(&state, input, SHA256_BLOCK_SIZE + len);
-
 	/* emit sha256(K1 || msg) on the second input block, so we can
 	 * reuse 'input' for the last hashing
 	 */
-	sha256_final(&state, &input[SHA256_BLOCK_SIZE]);
+	sha256(input, SHA256_BLOCK_SIZE + len, &input[SHA256_BLOCK_SIZE]);
 =

 	/* Prepare second part of hmac */
 	memset(input, 0x5C, SHA256_BLOCK_SIZE);
@@ -82,9 +75,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, i=
nt len, void *hmac)
 	for (i =3D 0; i < 8; i++)
 		input[i + 8] ^=3D key2be[i];
 =

-	sha256_init(&state);
-	sha256_update(&state, input, SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE);
-	sha256_final(&state, (u8 *)hmac);
+	sha256(input, SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE, hmac);
 }
 =

 #ifdef CONFIG_MPTCP_HMAC_TEST
-- =

2.27.0

--===============9027493759343680236==--

Content-Type: multipart/mixed; boundary="===============0253761344145023460=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Mon, 02 Dec 2019 09:15:02 -0800
Message-ID: <20191202171504.88739-2-cpaasch@apple.com>
In-Reply-To: 20191202171504.88739-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2746

--===============0253761344145023460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

For simplicity's sake use directly sha256 primitives (and pull them
as a required build dep).
Add optional, boot-time self-tests for the hmac function.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/Kconfig    |  10 ++++
 net/mptcp/crypto.c   | 139 ++++++++++++++++++++++++++-----------------
 net/mptcp/options.c  |   9 ++-
 net/mptcp/protocol.h |   4 +-
 4 files changed, 103 insertions(+), 59 deletions(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index c1a99f07a4cd..5db56d2218c5 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -3,6 +3,7 @@ config MPTCP
 	bool "MPTCP: Multipath TCP"
 	depends on INET
 	select SKB_EXTENSIONS
+	select CRYPTO_LIB_SHA256
 	help
 	  Multipath TCP (MPTCP) connections send and receive data over multiple
 	  subflows in order to utilize multiple network paths. Each subflow
@@ -14,3 +15,12 @@ config MPTCP_IPV6
 	depends on MPTCP
 	select IPV6
 	default y
+
+config MPTCP_HMAC_TEST
+	bool "Tests for MPTCP HMAC implementation"
+	default n
+	help
+	  This option enable boot time self-test for the HMAC implementation
+	  used by the MPTCP code
+
+	  Say N if you are unsure.
diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index ccb9f7effdcd..68f1758b96c2 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -21,67 +21,36 @@
  */
 =

 #include <linux/kernel.h>
-#include <linux/cryptohash.h>
+#include <crypto/sha.h>
 #include <asm/unaligned.h>
 =

 #include "protocol.h"
 =

-struct sha1_state {
-	u32 workspace[SHA_WORKSPACE_WORDS];
-	u32 digest[SHA_DIGEST_WORDS];
-	unsigned int count;
-};
-
-static void sha1_init(struct sha1_state *state)
-{
-	sha_init(state->digest);
-	state->count =3D 0;
-}
-
-static void sha1_update(struct sha1_state *state, u8 *input)
-{
-	sha_transform(state->digest, input, state->workspace);
-	state->count +=3D SHA_MESSAGE_BYTES;
-}
-
-static void sha1_pad_final(struct sha1_state *state, u8 *input, unsigned l=
ength,
-			   __be32 *mptcp_hashed_key)
-{
-	int i;
-
-	input[length] =3D 0x80;
-	memset(&input[length + 1], 0, SHA_MESSAGE_BYTES - length - 9);
-	put_unaligned_be64((length + state->count) << 3,
-			   &input[SHA_MESSAGE_BYTES - 8]);
-
-	sha_transform(state->digest, input, state->workspace);
-	for (i =3D 0; i < SHA_DIGEST_WORDS; ++i)
-		put_unaligned_be32(state->digest[i], &mptcp_hashed_key[i]);
-
-	memzero_explicit(state->workspace, SHA_WORKSPACE_WORDS << 2);
-}
+#define SHA256_DIGEST_WORDS (SHA256_DIGEST_SIZE / 4)
 =

 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn)
 {
-	__be32 mptcp_hashed_key[SHA_DIGEST_WORDS];
-	u8 input[SHA_MESSAGE_BYTES];
-	struct sha1_state state;
+	__be32 mptcp_hashed_key[SHA256_DIGEST_WORDS];
+	__be64 input =3D cpu_to_be64(key);
+	struct sha256_state state;
 =

-	sha1_init(&state);
-	put_unaligned_be64(key, input);
-	sha1_pad_final(&state, input, 8, mptcp_hashed_key);
+	sha256_init(&state);
+	sha256_update(&state, (__force u8 *)&input, sizeof(input));
+	sha256_final(&state, (u8 *)mptcp_hashed_key);
 =

 	if (token)
 		*token =3D be32_to_cpu(mptcp_hashed_key[0]);
 	if (idsn)
-		*idsn =3D be64_to_cpu(*((__be64 *)&mptcp_hashed_key[3]));
+		*idsn =3D be64_to_cpu(*((__be64 *)&mptcp_hashed_key[6]));
 }
 =

 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
-			    u32 *hash_out)
+			   void *hmac)
 {
-	u8 input[SHA_MESSAGE_BYTES * 2];
-	struct sha1_state state;
+	u8 input[SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE];
+	__be32 mptcp_hashed_key[SHA256_DIGEST_WORDS];
+	__be32 *hash_out =3D (__force __be32 *)hmac;
+	struct sha256_state state;
 	u8 key1be[8];
 	u8 key2be[8];
 	int i;
@@ -96,17 +65,16 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonc=
e1, u32 nonce2,
 	for (i =3D 0; i < 8; i++)
 		input[i + 8] ^=3D key2be[i];
 =

-	put_unaligned_be32(nonce1, &input[SHA_MESSAGE_BYTES]);
-	put_unaligned_be32(nonce2, &input[SHA_MESSAGE_BYTES + 4]);
+	put_unaligned_be32(nonce1, &input[SHA256_BLOCK_SIZE]);
+	put_unaligned_be32(nonce2, &input[SHA256_BLOCK_SIZE + 4]);
 =

-	sha1_init(&state);
-	sha1_update(&state, input);
+	sha256_init(&state);
+	sha256_update(&state, input, SHA256_BLOCK_SIZE + 8);
 =

 	/* emit sha256(K1 || msg) on the second input block, so we can
 	 * reuse 'input' for the last hashing
 	 */
-	sha1_pad_final(&state, &input[SHA_MESSAGE_BYTES], 8,
-		       (__force __be32 *)&input[SHA_MESSAGE_BYTES]);
+	sha256_final(&state, &input[SHA256_BLOCK_SIZE]);
 =

 	/* Prepare second part of hmac */
 	memset(input, 0x5C, SHA_MESSAGE_BYTES);
@@ -115,8 +83,69 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonc=
e1, u32 nonce2,
 	for (i =3D 0; i < 8; i++)
 		input[i + 8] ^=3D key2be[i];
 =

-	sha1_init(&state);
-	sha1_update(&state, input);
-	sha1_pad_final(&state, &input[SHA_MESSAGE_BYTES], SHA_DIGEST_WORDS << 2,
-		      (__be32*)hash_out);
+	sha256_init(&state);
+	sha256_update(&state, input, SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE);
+	sha256_final(&state, (u8 *)mptcp_hashed_key);
+
+	/* takes only first 160 bits */
+	for (i =3D 0; i < 5; i++)
+		hash_out[i] =3D mptcp_hashed_key[i];
+}
+
+#ifdef CONFIG_MPTCP_HMAC_TEST
+struct test_cast {
+	char *key;
+	char *msg;
+	char *result;
+};
+
+/* we can't reuse RFC 4231 test vectors, as we have constraint on the
+ * input and key size, and we truncate the output.
+ */
+static struct test_cast tests[] =3D {
+	{
+		.key =3D "0b0b0b0b0b0b0b0b",
+		.msg =3D "48692054",
+		.result =3D "8385e24fb4235ac37556b6b886db106284a1da67",
+	},
+	{
+		.key =3D "aaaaaaaaaaaaaaaa",
+		.msg =3D "dddddddd",
+		.result =3D "2c5e219164ff1dca1c4a92318d847bb6b9d44492",
+	},
+	{
+		.key =3D "0102030405060708",
+		.msg =3D "cdcdcdcd",
+		.result =3D "e73b9ba9969969cefb04aa0d6df18ec2fcc075b6",
+	},
+};
+
+static void __init crypto_test(void)
+{
+	char hmac[20], hmac_hex[41];
+	u32 nonce1, nonce2;
+	u64 key1, key2;
+	int i, j;
+
+	for (i =3D 0; i < ARRAY_SIZE(tests); ++i) {
+		/* mptcp hmap will convert to be before computing the hmac */
+		key1 =3D be64_to_cpu(*((__be64 *)&tests[i].key[0]));
+		key2 =3D be64_to_cpu(*((__be64 *)&tests[i].key[8]));
+		nonce1 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[0]));
+		nonce2 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[4]));
+
+		mptcp_crypto_hmac_sha(key1, key2, nonce1, nonce2, hmac);
+		for (j =3D 0; j < 20; ++j)
+			sprintf(&hmac_hex[j << 1], "%02x", hmac[j] & 0xff);
+		hmac_hex[40] =3D 0;
+
+		if (memcmp(hmac_hex, tests[i].result, 40))
+			pr_err("test %d failed, got %s expected %s", i,
+			       hmac_hex, tests[i].result);
+		else
+			pr_info("test %d [ ok ]", i);
+	}
 }
+
+late_initcall(crypto_test);
+#endif
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2f014332cdef..1cb0bd687b6b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -9,6 +9,11 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+static bool mptcp_cap_flag_sha256(u8 flags)
+{
+	return (flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA256;
+}
+
 void mptcp_parse_option(const unsigned char *ptr, int opsize,
 			struct tcp_options_received *opt_rx)
 {
@@ -33,7 +38,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 			break;
 =

 		mp_opt->flags =3D *ptr++;
-		if (!((mp_opt->flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA1) =
||
+		if (!mptcp_cap_flag_sha256(mp_opt->flags) ||
 		    (mp_opt->flags & MPTCP_CAP_EXTENSIBILITY))
 			break;
 =

@@ -434,7 +439,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
 			       (MPTCPOPT_MP_CAPABLE << 12) |
 			       ((MPTCP_VERSION_MASK & 0) << 8) |
-			       MPTCP_CAP_HMAC_SHA1);
+			       MPTCP_CAP_HMAC_SHA256);
 		put_unaligned_be64(opts->sndr_key, ptr);
 		ptr +=3D 2;
 		if ((OPTION_MPTCP_MPC_SYNACK |
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 542aa9b67a60..dcdd3dcd19c6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -41,7 +41,7 @@
 #define MPTCP_VERSION_MASK	(0x0F)
 #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
 #define MPTCP_CAP_EXTENSIBILITY	BIT(6)
-#define MPTCP_CAP_HMAC_SHA1	BIT(0)
+#define MPTCP_CAP_HMAC_SHA256	BIT(0)
 #define MPTCP_CAP_FLAG_MASK	(0x3F)
 =

 /* MPTCP DSS flags */
@@ -201,7 +201,7 @@ static inline void mptcp_crypto_key_gen_sha(u64 *key, u=
32 *token, u64 *idsn)
 }
 =

 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
-			   u32 *hash_out);
+			   void *hash_out);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
-- =

2.23.0

--===============0253761344145023460==--

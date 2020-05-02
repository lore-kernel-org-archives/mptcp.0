Content-Type: multipart/mixed; boundary="===============8041642225143189190=="
MIME-Version: 1.0
From: Eric Biggers <ebiggers at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/7] mptcp: use SHA256_BLOCK_SIZE,
 not SHA_MESSAGE_BYTES
Date: Sat, 02 May 2020 11:24:21 -0700
Message-ID: <20200502182427.104383-2-ebiggers@kernel.org>
In-Reply-To: 20200502182427.104383-1-ebiggers@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 4299

--===============8041642225143189190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Eric Biggers <ebiggers(a)google.com>

In preparation for naming the SHA-1 stuff in <linux/cryptohash.h>
properly and moving it to a more appropriate header, fix the HMAC-SHA256
code in mptcp_crypto_hmac_sha() to use SHA256_BLOCK_SIZE instead of
"SHA_MESSAGE_BYTES" which is actually the SHA-1 block size.
(Fortunately these are both 64 bytes, so this wasn't a "real" bug...)

Cc: Paolo Abeni <pabeni(a)redhat.com>
Cc: mptcp(a)lists.01.org
Signed-off-by: Eric Biggers <ebiggers(a)google.com>
---
 net/mptcp/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index c151628bd4161a..81b06d875f9249 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -61,7 +61,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, i=
nt len, void *hmac)
 	put_unaligned_be64(key2, key2be);
 =

 	/* Generate key xored with ipad */
-	memset(input, 0x36, SHA_MESSAGE_BYTES);
+	memset(input, 0x36, SHA256_BLOCK_SIZE);
 	for (i =3D 0; i < 8; i++)
 		input[i] ^=3D key1be[i];
 	for (i =3D 0; i < 8; i++)
@@ -78,7 +78,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, i=
nt len, void *hmac)
 	sha256_final(&state, &input[SHA256_BLOCK_SIZE]);
 =

 	/* Prepare second part of hmac */
-	memset(input, 0x5C, SHA_MESSAGE_BYTES);
+	memset(input, 0x5C, SHA256_BLOCK_SIZE);
 	for (i =3D 0; i < 8; i++)
 		input[i] ^=3D key1be[i];
 	for (i =3D 0; i < 8; i++)
-- =

2.26.2

--===============8041642225143189190==--

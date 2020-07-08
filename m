Content-Type: multipart/mixed; boundary="===============6715866064195555805=="
MIME-Version: 1.0
From: Eric Biggers <ebiggers at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/5] crypto: lib/sha256 - add sha256() function
Date: Wed, 08 Jul 2020 09:39:40 -0700
Message-ID: <20200708163943.52071-3-ebiggers@kernel.org>
In-Reply-To: 20200708163943.52071-1-ebiggers@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 4952

--===============6715866064195555805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Eric Biggers <ebiggers(a)google.com>

Add a function sha256() which computes a SHA-256 digest in one step,
combining sha256_init() + sha256_update() + sha256_final().

This is similar to how we also have blake2s().

Reviewed-by: Ard Biesheuvel <ardb(a)kernel.org>
Tested-by: Hans de Goede <hdegoede(a)redhat.com>
Signed-off-by: Eric Biggers <ebiggers(a)google.com>
---
 include/crypto/sha.h |  1 +
 lib/crypto/sha256.c  | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/crypto/sha.h b/include/crypto/sha.h
index 10753ff71d46..4ff3da816630 100644
--- a/include/crypto/sha.h
+++ b/include/crypto/sha.h
@@ -147,6 +147,7 @@ static inline void sha256_init(struct sha256_state *sct=
x)
 }
 void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int=
 len);
 void sha256_final(struct sha256_state *sctx, u8 *out);
+void sha256(const u8 *data, unsigned int len, u8 *out);
 =

 static inline void sha224_init(struct sha256_state *sctx)
 {
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 2e621697c5c3..2321f6cb322f 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -280,4 +280,14 @@ void sha224_final(struct sha256_state *sctx, u8 *out)
 }
 EXPORT_SYMBOL(sha224_final);
 =

+void sha256(const u8 *data, unsigned int len, u8 *out)
+{
+	struct sha256_state sctx;
+
+	sha256_init(&sctx);
+	sha256_update(&sctx, data, len);
+	sha256_final(&sctx, out);
+}
+EXPORT_SYMBOL(sha256);
+
 MODULE_LICENSE("GPL");
-- =

2.27.0

--===============6715866064195555805==--

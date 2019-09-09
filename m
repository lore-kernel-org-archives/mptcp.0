Content-Type: multipart/mixed; boundary="===============2339640054113045880=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/4] crypto: include protocol.h to get function
 prototypes
Date: Tue, 10 Sep 2019 01:17:24 +0200
Message-ID: <20190909231725.4952-4-fw@strlen.de>
In-Reply-To: 20190909231725.4952-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1810

--===============2339640054113045880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

crypto.c:29:6: warning: symbol 'crypto_key_sha1' was not declared. Should i=
t be static?
crypto.c:54:6: warning: symbol 'crypto_hmac_sha1' was not declared. Should =
it be static?

squashto: mptcp: Add key generation and token tree

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/crypto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 8b67b11e626c..2cd988b9a312 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -26,6 +26,8 @@
 #include <linux/siphash.h>
 #include <asm/unaligned.h>
 =

+#include "protocol.h"
+
 void crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
 {
 	u32 workspace[SHA_WORKSPACE_WORDS];
-- =

2.21.0


--===============2339640054113045880==--

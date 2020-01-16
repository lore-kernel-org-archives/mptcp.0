Content-Type: multipart/mixed; boundary="===============4152982973692676121=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: move from sha1 (v0) to
 sha256 (v1)"
Date: Thu, 16 Jan 2020 11:12:06 +0100
Message-ID: <ba44d0a9f9045d296ebceb8ddbfd204bbac27a68.1579169521.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3373

--===============4152982973692676121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes the late_initcall signature, as reported by kbuildbot

Also rename the test function to be more consistent with other
in-kernel test-cases.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/crypto.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 68f1758b96c2..40d1bb18fd60 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -120,7 +120,7 @@ static struct test_cast tests[] =3D {
 	},
 };
 =

-static void __init crypto_test(void)
+static int __init test_mptcp_crypto(void)
 {
 	char hmac[20], hmac_hex[41];
 	u32 nonce1, nonce2;
@@ -145,7 +145,8 @@ static void __init crypto_test(void)
 		else
 			pr_info("test %d [ ok ]", i);
 	}
+	return 0;
 }
 =

-late_initcall(crypto_test);
+late_initcall(test_mptcp_crypto);
 #endif
-- =

2.21.0

--===============4152982973692676121==--

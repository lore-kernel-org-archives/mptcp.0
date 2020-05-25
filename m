Content-Type: multipart/mixed; boundary="===============8356637361672201964=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 3/4] mptcp: move crypto test to KUNIT
Date: Mon, 25 May 2020 19:35:18 +0200
Message-ID: <de37b0d40450afc63372a1eedb84deceda757a43.1590427813.git.pabeni@redhat.com>
In-Reply-To: cover.1590427813.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4497

--===============8356637361672201964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

currently MPTCP uses a custom hook to executed unit test at
boot time. Let's use the KUNIT framework instead.
Additionally move the relevant code to a separate file and
export the function needed by the test when self-tests
are build as a module.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - add SPDX line (Davide)
---
 net/mptcp/Kconfig       | 19 +++++++----
 net/mptcp/Makefile      |  3 ++
 net/mptcp/crypto.c      | 65 ++-----------------------------------
 net/mptcp/crypto_test.c | 72 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 68 deletions(-)
 create mode 100644 net/mptcp/crypto_test.c

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 26e2a8280656..3fa482d233a4 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -19,12 +19,19 @@ config MPTCP_IPV6
 	select IPV6
 	default y
 =

-config MPTCP_HMAC_TEST
-	bool "Tests for MPTCP HMAC implementation"
+endif
+
+config MPTCP_KUNIT_TESTS
+	tristate "This builds the MPTCP KUnit tests"
+	select MPTCP
+	depends on KUNIT
 	help
-	  This option enable boot time self-test for the HMAC implementation
-	  used by the MPTCP code
+	  Currently covers the MPTCP crypto helpers.
+	  Only useful for kernel devs running KUnit test harness and are not
+	  for inclusion into a production build.
 =

-	  Say N if you are unsure.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
 =

-endif
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index baa0640527c7..f9039804207b 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -3,3 +3,6 @@ obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
 	   mib.o pm_netlink.o
+
+mptcp_crypto_test-objs :=3D crypto_test.o
+obj-$(CONFIG_MPTCP_KUNIT_TESTS) +=3D mptcp_crypto_test.o
\ No newline at end of file
diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index c151628bd416..5c01cd459d28 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -93,65 +93,6 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, =
int len, void *hmac)
 		hash_out[i] =3D mptcp_hashed_key[i];
 }
 =

-#ifdef CONFIG_MPTCP_HMAC_TEST
-struct test_cast {
-	char *key;
-	char *msg;
-	char *result;
-};
-
-/* we can't reuse RFC 4231 test vectors, as we have constraint on the
- * input and key size, and we truncate the output.
- */
-static struct test_cast tests[] =3D {
-	{
-		.key =3D "0b0b0b0b0b0b0b0b",
-		.msg =3D "48692054",
-		.result =3D "8385e24fb4235ac37556b6b886db106284a1da67",
-	},
-	{
-		.key =3D "aaaaaaaaaaaaaaaa",
-		.msg =3D "dddddddd",
-		.result =3D "2c5e219164ff1dca1c4a92318d847bb6b9d44492",
-	},
-	{
-		.key =3D "0102030405060708",
-		.msg =3D "cdcdcdcd",
-		.result =3D "e73b9ba9969969cefb04aa0d6df18ec2fcc075b6",
-	},
-};
-
-static int __init test_mptcp_crypto(void)
-{
-	char hmac[20], hmac_hex[41];
-	u32 nonce1, nonce2;
-	u64 key1, key2;
-	u8 msg[8];
-	int i, j;
-
-	for (i =3D 0; i < ARRAY_SIZE(tests); ++i) {
-		/* mptcp hmap will convert to be before computing the hmac */
-		key1 =3D be64_to_cpu(*((__be64 *)&tests[i].key[0]));
-		key2 =3D be64_to_cpu(*((__be64 *)&tests[i].key[8]));
-		nonce1 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[0]));
-		nonce2 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[4]));
-
-		put_unaligned_be32(nonce1, &msg[0]);
-		put_unaligned_be32(nonce2, &msg[4]);
-
-		mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
-		for (j =3D 0; j < 20; ++j)
-			sprintf(&hmac_hex[j << 1], "%02x", hmac[j] & 0xff);
-		hmac_hex[40] =3D 0;
-
-		if (memcmp(hmac_hex, tests[i].result, 40))
-			pr_err("test %d failed, got %s expected %s", i,
-			       hmac_hex, tests[i].result);
-		else
-			pr_info("test %d [ ok ]", i);
-	}
-	return 0;
-}
-
-late_initcall(test_mptcp_crypto);
-#endif
+#if IS_MODULE(CONFIG_MPTCP_KUNIT_TESTS)
+EXPORT_SYMBOL_GPL(mptcp_crypto_hmac_sha);
+#endif
\ No newline at end of file
diff --git a/net/mptcp/crypto_test.c b/net/mptcp/crypto_test.c
new file mode 100644
index 000000000000..c8a02d4b9001
--- /dev/null
+++ b/net/mptcp/crypto_test.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+
+#include "protocol.h"
+
+struct test_case {
+	char *key;
+	char *msg;
+	char *result;
+};
+
+/* we can't reuse RFC 4231 test vectors, as we have constraint on the
+ * input and key size, and we truncate the output.
+ */
+static struct test_case tests[] =3D {
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
+static void mptcp_crypto_test_basic(struct kunit *test)
+{
+	char hmac[20], hmac_hex[41];
+	u32 nonce1, nonce2;
+	u64 key1, key2;
+	u8 msg[8];
+	int i, j;
+
+	for (i =3D 0; i < ARRAY_SIZE(tests); ++i) {
+		/* mptcp hmap will convert to be before computing the hmac */
+		key1 =3D be64_to_cpu(*((__be64 *)&tests[i].key[0]));
+		key2 =3D be64_to_cpu(*((__be64 *)&tests[i].key[8]));
+		nonce1 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[0]));
+		nonce2 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[4]));
+
+		put_unaligned_be32(nonce1, &msg[0]);
+		put_unaligned_be32(nonce2, &msg[4]);
+
+		mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
+		for (j =3D 0; j < 20; ++j)
+			sprintf(&hmac_hex[j << 1], "%02x", hmac[j] & 0xff);
+		hmac_hex[40] =3D 0;
+
+		KUNIT_EXPECT_STREQ(test, &hmac_hex[0], tests[i].result);
+	}
+}
+
+static struct kunit_case mptcp_crypto_test_cases[] =3D {
+	KUNIT_CASE(mptcp_crypto_test_basic),
+	{}
+};
+
+static struct kunit_suite mptcp_crypto_suite =3D {
+	.name =3D "mptcp-crypto",
+	.test_cases =3D mptcp_crypto_test_cases,
+};
+
+kunit_test_suite(mptcp_crypto_suite);
+
+MODULE_LICENSE("GPL");
-- =

2.21.3

--===============8356637361672201964==--

Content-Type: multipart/mixed; boundary="===============2825471247428757235=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Wed, 13 Nov 2019 13:03:33 +0100
Message-ID: <5c03bb048a837097d1846d00985c8215a9d62399.camel@redhat.com>
In-Reply-To: 956ad1cdcb16e6320c16c7ff429743250a4d5591.1573465037.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2504

--===============2825471247428757235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-11 at 10:41 +0100, Paolo Abeni wrote:
> For simplicity's sake use directly sha256 primitives (and pull
> them as a required build dep).
> While extracting the data from the hash results, take in account
> that sha256_final() swaps to be32.
> Also rename functions and macro accordingly and fix some checkpatch
> issue (long lines).

Note: the hmac changes are not trivial, and can't be trivially
validated vs RFC 4231 test vectors, as the code poses several
restriction on the input size.

I build the following ad-hoc test code (uses some of the rfc4231 test
vector, trimmed to fit the mptcp keys/nonces and got the expected
result from https://codebeautify.org/hmac-generator).

It can't be included in a self-tests, as it's all in-kernel. I don't
thing we want to include this kind of code, but any options welcome!

Paolo

---
diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 4066cfbc227e..2c73869178dc 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -89,3 +89,55 @@ void mptcp_crypto_hmac_sha256(u64 key1, u64 key2, u32 no=
nce1, u32 nonce2,
 	for (i =3D 0; i < 5; i++)
 		hash_out[i] =3D mptcp_hashed_key[i];
 }
+
+struct test_cast {
+	char *key;
+	char *msg;
+	char *result;
+};
+
+static struct test_cast tests[] =3D {
+	{
+		.key =3D "0b0b0b0b0b0b0b0b",
+		.msg =3D "48692054",
+		.result =3D "8385e24fb4235ac37556b6b886db106284a1da671699f46db1f235ec622=
dcafa",
+	},
+	{
+		.key =3D "aaaaaaaaaaaaaaaa",
+		.msg =3D "dddddddd",
+		.result =3D "2c5e219164ff1dca1c4a92318d847bb6b9d44492984e1eb71aff9022f71=
046e9",
+	},
+	{
+		.key =3D "0102030405060708",
+		.msg =3D "cdcdcdcd",
+		.result =3D "e73b9ba9969969cefb04aa0d6df18ec2fcc075b6f23b4d8c4da736a5dbb=
c6e7d",
+	},
+};
+
+void crypto_test(void);
+
+void crypto_test(void)
+{
+	char hmac[20], hmac_hex[40];
+	u32 nonce1, nonce2;
+	u64 key1, key2;
+	int i, j;
+
+	for (i=3D0; i < ARRAY_SIZE(tests); ++i) {
+		/* mptcp hmap will convert to beBE before computing the hmac */
+		key1 =3D be64_to_cpu(*((__be64*)&tests[i].key[0]));
+		key2 =3D be64_to_cpu(*((__be64*)&tests[i].key[8]));
+		nonce1 =3D be32_to_cpu(*((__be32*)&tests[i].msg[0]));
+		nonce2 =3D be32_to_cpu(*((__be32*)&tests[i].msg[4]));
+
+		mptcp_crypto_hmac_sha256(key1, key2, nonce1, nonce2, hmac);
+		for (j =3D 0; j < 20; ++j)
+			sprintf(&hmac_hex[j << 1], "%02x", hmac[j] & 0xff);
+
+		if (memcmp(hmac_hex, tests[i].result, 40))
+			pr_err("test %d failed, got %s expected %s", i,
+			       hmac_hex, tests[i].result);
+		else
+			pr_debug("test %d [ ok ]", i);
+	}
+}
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 8e39585d37f3..c91eb743c714 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -110,8 +110,11 @@ static struct pernet_operations mptcp_pernet_ops =3D {
 	.size =3D sizeof(struct mptcp_pernet),
 };
 =

+void crypto_test(void);
+
 void __init mptcp_init(void)
 {
+	crypto_test();
 	mptcp_proto_init();
 =

 	if (register_pernet_subsys(&mptcp_pernet_ops) < 0)




--===============2825471247428757235==--

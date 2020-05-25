Content-Type: multipart/mixed; boundary="===============1131997611866907348=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: move crypto test to KUNIT
Date: Mon, 25 May 2020 09:26:37 +0200
Message-ID: <15ed1aff118fea0f63e9068531e1d6940d399d9c.camel@redhat.com>
In-Reply-To: 791d0cdbda74f383e0a828b0bd83853c928f3a99.1590142022.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4470

--===============1131997611866907348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-05-22 at 12:10 +0200, Paolo Abeni wrote:
> currently MPTCP uses a custom hook to executed unit test at
> boot time. Let's use the KUNIT framework instead.
> Additionally move the relevant code to a separate file and
> export the function needed by the test when self-tests
> are build as a module.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/Kconfig       | 19 +++++++----
>  net/mptcp/Makefile      |  3 ++
>  net/mptcp/crypto.c      | 65 ++-----------------------------------
>  net/mptcp/crypto_test.c | 71 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 90 insertions(+), 68 deletions(-)
>  create mode 100644 net/mptcp/crypto_test.c
> =


[...]

> diff --git a/net/mptcp/crypto_test.c b/net/mptcp/crypto_test.c
> new file mode 100644
> index 000000000000..3a7c40f5e8f8
> --- /dev/null
> +++ b/net/mptcp/crypto_test.c
> @@ -0,0 +1,71 @@
> +#include <kunit/test.h>

Nit: I think we need a SPDX line here (or non-conventional users of
checkpatch might see a warning)

> +
> +#include "protocol.h"
> +
> +struct test_case {
> +	char *key;
> +	char *msg;
> +	char *result;
> +};
> +
> +/* we can't reuse RFC 4231 test vectors, as we have constraint on the
> + * input and key size, and we truncate the output.
> + */
> +static struct test_case tests[] =3D {
> +	{
> +		.key =3D "0b0b0b0b0b0b0b0b",
> +		.msg =3D "48692054",
> +		.result =3D "8385e24fb4235ac37556b6b886db106284a1da67",
> +	},
> +	{
> +		.key =3D "aaaaaaaaaaaaaaaa",
> +		.msg =3D "dddddddd",
> +		.result =3D "2c5e219164ff1dca1c4a92318d847bb6b9d44492",
> +	},
> +	{
> +		.key =3D "0102030405060708",
> +		.msg =3D "cdcdcdcd",
> +		.result =3D "e73b9ba9969969cefb04aa0d6df18ec2fcc075b6",
> +	},
> +};
> +
> +static void mptcp_crypto_test_basic(struct kunit *test)
> +{
> +	char hmac[20], hmac_hex[41];
> +	u32 nonce1, nonce2;
> +	u64 key1, key2;
> +	u8 msg[8];
> +	int i, j;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tests); ++i) {
> +		/* mptcp hmap will convert to be before computing the hmac */
> +		key1 =3D be64_to_cpu(*((__be64 *)&tests[i].key[0]));
> +		key2 =3D be64_to_cpu(*((__be64 *)&tests[i].key[8]));
> +		nonce1 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[0]));
> +		nonce2 =3D be32_to_cpu(*((__be32 *)&tests[i].msg[4]));
> +
> +		put_unaligned_be32(nonce1, &msg[0]);
> +		put_unaligned_be32(nonce2, &msg[4]);
> +
> +		mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
> +		for (j =3D 0; j < 20; ++j)
> +			sprintf(&hmac_hex[j << 1], "%02x", hmac[j] & 0xff);
> +		hmac_hex[40] =3D 0;
> +
> +		KUNIT_EXPECT_STREQ(test, &hmac_hex[0], tests[i].result);
> +	}
> +}
> +
> +static struct kunit_case mptcp_crypto_test_cases[] =3D {
> +	KUNIT_CASE(mptcp_crypto_test_basic),
> +	{}
> +};
> +
> +static struct kunit_suite mptcp_crypto_suite =3D {
> +	.name =3D "mptcp-crypto",
> +	.test_cases =3D mptcp_crypto_test_cases,
> +};
> +
> +kunit_test_suite(mptcp_crypto_suite);
> +
> +MODULE_LICENSE("GPL");


--===============1131997611866907348==--

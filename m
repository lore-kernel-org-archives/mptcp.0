Content-Type: multipart/mixed; boundary="===============5624148105006394001=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 4/4] mptcp: introduce token KUNIT self-tests
Date: Mon, 25 May 2020 09:27:58 +0200
Message-ID: <dcc2871af225e992dd90768b5e6f03cb0ca0325e.camel@redhat.com>
In-Reply-To: 51d35c6723bd74bef0e546914f246b3569e93b28.1590142022.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4471

--===============5624148105006394001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-05-22 at 12:10 +0200, Paolo Abeni wrote:
> Unit tests for the internal MPTCP token APIs, using KUNIT
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/Makefile     |   3 +-
>  net/mptcp/token.c      |   9 +++
>  net/mptcp/token_test.c | 138 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+), 1 deletion(-)
>  create mode 100644 net/mptcp/token_test.c

[...]

> diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
> new file mode 100644
> index 000000000000..9e385d2c9ff0
> --- /dev/null
> +++ b/net/mptcp/token_test.c
> @@ -0,0 +1,138 @@
> +#include <kunit/test.h>

same as patch 3/4: I think we need a SPDX line here (or non-conventional
users of checkpatch might see a warning)

> +
> +#include "protocol.h"
> +
> +static struct mptcp_subflow_request_sock *build_req_sock(struct kunit *t=
est)
> +{
> +	struct mptcp_subflow_request_sock *req;
> +
> +	req =3D kunit_kzalloc(test, sizeof(struct mptcp_subflow_request_sock),
> +			    GFP_USER);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, req);
> +	return req;
> +}
> +
> +static void mptcp_token_test_req_basic(struct kunit *test)
> +{
> +	struct mptcp_subflow_request_sock *req =3D build_req_sock(test);
> +	struct mptcp_sock *null_msk =3D NULL;
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			mptcp_token_new_request((struct request_sock *)req));
> +	KUNIT_EXPECT_NE(test, 0, (int)req->token);
> +	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(req->token));
> +
> +	/* cleanup */
> +	mptcp_token_destroy_request(req->token);
> +}
> +
> +static struct inet_connection_sock *build_icsk(struct kunit *test)
> +{
> +	struct inet_connection_sock *icsk;
> +
> +	icsk =3D kunit_kzalloc(test, sizeof(struct inet_connection_sock),
> +			     GFP_USER);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, icsk);
> +	return icsk;
> +}
> +
> +static struct mptcp_subflow_context *build_ctx(struct kunit *test)
> +{
> +	struct mptcp_subflow_context *ctx;
> +
> +	ctx =3D kunit_kzalloc(test, sizeof(struct mptcp_subflow_context),
> +			    GFP_USER);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ctx);
> +	return ctx;
> +}
> +
> +static struct mptcp_sock *build_msk(struct kunit *test)
> +{
> +	struct mptcp_sock *msk;
> +
> +	msk =3D kunit_kzalloc(test, sizeof(struct mptcp_sock), GFP_USER);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, msk);
> +	refcount_set(&((struct sock *)msk)->sk_refcnt, 1);
> +	return msk;
> +}
> +
> +static void mptcp_token_test_msk_basic(struct kunit *test)
> +{
> +	struct inet_connection_sock *icsk =3D build_icsk(test);
> +	struct mptcp_subflow_context *ctx =3D build_ctx(test);
> +	struct mptcp_sock *msk =3D build_msk(test);
> +	struct mptcp_sock *null_msk =3D NULL;
> +	struct sock *sk;
> +
> +	icsk->icsk_ulp_data =3D ctx;
> +	ctx->conn =3D (struct sock*)msk;
> +	sk =3D (struct sock*)msk;
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			mptcp_token_new_connect((struct sock *)icsk));
> +	KUNIT_EXPECT_NE(test, 0, (int)ctx->token);
> +	KUNIT_EXPECT_EQ(test, ctx->token, msk->token);
> +	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(ctx->token));
> +	KUNIT_EXPECT_EQ(test, 2, (int)refcount_read(&sk->sk_refcnt));
> +
> +	mptcp_token_destroy(ctx->token);
> +	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(ctx->token));
> +}
> +
> +static void mptcp_token_test_accept(struct kunit *test)
> +{
> +	struct mptcp_subflow_request_sock *req =3D build_req_sock(test);
> +	struct mptcp_sock *msk =3D build_msk(test);
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			mptcp_token_new_request((struct request_sock *)req));
> +	msk->token =3D req->token;
> +	mptcp_token_accept(req, msk);
> +	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(msk->token));
> +
> +	/* this is now a no-op */
> +	mptcp_token_destroy_request(req->token);
> +	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(msk->token));
> +
> +	/* cleanup */
> +	mptcp_token_destroy(msk->token);
> +}
> +
> +static void mptcp_token_test_destroyed(struct kunit *test)
> +{
> +	struct mptcp_subflow_request_sock *req =3D build_req_sock(test);
> +	struct mptcp_sock *msk =3D build_msk(test);
> +	struct mptcp_sock *null_msk =3D NULL;
> +	struct sock *sk;
> +
> +	sk =3D (struct sock*)msk;
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			mptcp_token_new_request((struct request_sock *)req));
> +	msk->token =3D req->token;
> +	mptcp_token_accept(req, msk);
> +
> +	/* simulate race on removal */
> +	refcount_set(&sk->sk_refcnt, 0);
> +	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(msk->token));
> +
> +	/* cleanup */
> +	mptcp_token_destroy(msk->token);
> +}
> +
> +static struct kunit_case mptcp_token_test_cases[] =3D {
> +	KUNIT_CASE(mptcp_token_test_req_basic),
> +	KUNIT_CASE(mptcp_token_test_msk_basic),
> +	KUNIT_CASE(mptcp_token_test_accept),
> +	KUNIT_CASE(mptcp_token_test_destroyed),
> +	{}
> +};
> +
> +static struct kunit_suite mptcp_token_suite =3D {
> +	.name =3D "mptcp-token",
> +	.test_cases =3D mptcp_token_test_cases,
> +};
> +
> +kunit_test_suite(mptcp_token_suite);
> +
> +MODULE_LICENSE("GPL");
> \ No newline at end of file


--===============5624148105006394001==--

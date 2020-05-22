Content-Type: multipart/mixed; boundary="===============6885911920499376177=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/4] mptcp: introduce token KUNIT self-tests
Date: Fri, 22 May 2020 12:10:13 +0200
Message-ID: <51d35c6723bd74bef0e546914f246b3569e93b28.1590142022.git.pabeni@redhat.com>
In-Reply-To: cover.1590142022.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4456

--===============6885911920499376177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unit tests for the internal MPTCP token APIs, using KUNIT

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/Makefile     |   3 +-
 net/mptcp/token.c      |   9 +++
 net/mptcp/token_test.c | 138 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/token_test.c

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index f9039804207b..c53f9b845523 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -5,4 +5,5 @@ mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.=
o ctrl.o pm.o diag.o \
 	   mib.o pm_netlink.o
 =

 mptcp_crypto_test-objs :=3D crypto_test.o
-obj-$(CONFIG_MPTCP_KUNIT_TESTS) +=3D mptcp_crypto_test.o
\ No newline at end of file
+mptcp_token_test-objs :=3D token_test.o
+obj-$(CONFIG_MPTCP_KUNIT_TESTS) +=3D mptcp_crypto_test.o mptcp_token_test.o
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index d4a4df3c7c42..8f67172b0c59 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -294,3 +294,12 @@ void __init mptcp_token_init(void)
 		spin_lock_init(&token_hash[i].lock);
 	}
 }
+
+#if IS_MODULE(CONFIG_MPTCP_KUNIT_TESTS)
+EXPORT_SYMBOL_GPL(mptcp_token_new_request);
+EXPORT_SYMBOL_GPL(mptcp_token_new_connect);
+EXPORT_SYMBOL_GPL(mptcp_token_accept);
+EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
+EXPORT_SYMBOL_GPL(mptcp_token_destroy_request);
+EXPORT_SYMBOL_GPL(mptcp_token_destroy);
+#endif
\ No newline at end of file
diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
new file mode 100644
index 000000000000..9e385d2c9ff0
--- /dev/null
+++ b/net/mptcp/token_test.c
@@ -0,0 +1,138 @@
+#include <kunit/test.h>
+
+#include "protocol.h"
+
+static struct mptcp_subflow_request_sock *build_req_sock(struct kunit *tes=
t)
+{
+	struct mptcp_subflow_request_sock *req;
+
+	req =3D kunit_kzalloc(test, sizeof(struct mptcp_subflow_request_sock),
+			    GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, req);
+	return req;
+}
+
+static void mptcp_token_test_req_basic(struct kunit *test)
+{
+	struct mptcp_subflow_request_sock *req =3D build_req_sock(test);
+	struct mptcp_sock *null_msk =3D NULL;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			mptcp_token_new_request((struct request_sock *)req));
+	KUNIT_EXPECT_NE(test, 0, (int)req->token);
+	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(req->token));
+
+	/* cleanup */
+	mptcp_token_destroy_request(req->token);
+}
+
+static struct inet_connection_sock *build_icsk(struct kunit *test)
+{
+	struct inet_connection_sock *icsk;
+
+	icsk =3D kunit_kzalloc(test, sizeof(struct inet_connection_sock),
+			     GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, icsk);
+	return icsk;
+}
+
+static struct mptcp_subflow_context *build_ctx(struct kunit *test)
+{
+	struct mptcp_subflow_context *ctx;
+
+	ctx =3D kunit_kzalloc(test, sizeof(struct mptcp_subflow_context),
+			    GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ctx);
+	return ctx;
+}
+
+static struct mptcp_sock *build_msk(struct kunit *test)
+{
+	struct mptcp_sock *msk;
+
+	msk =3D kunit_kzalloc(test, sizeof(struct mptcp_sock), GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, msk);
+	refcount_set(&((struct sock *)msk)->sk_refcnt, 1);
+	return msk;
+}
+
+static void mptcp_token_test_msk_basic(struct kunit *test)
+{
+	struct inet_connection_sock *icsk =3D build_icsk(test);
+	struct mptcp_subflow_context *ctx =3D build_ctx(test);
+	struct mptcp_sock *msk =3D build_msk(test);
+	struct mptcp_sock *null_msk =3D NULL;
+	struct sock *sk;
+
+	icsk->icsk_ulp_data =3D ctx;
+	ctx->conn =3D (struct sock*)msk;
+	sk =3D (struct sock*)msk;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			mptcp_token_new_connect((struct sock *)icsk));
+	KUNIT_EXPECT_NE(test, 0, (int)ctx->token);
+	KUNIT_EXPECT_EQ(test, ctx->token, msk->token);
+	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(ctx->token));
+	KUNIT_EXPECT_EQ(test, 2, (int)refcount_read(&sk->sk_refcnt));
+
+	mptcp_token_destroy(ctx->token);
+	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(ctx->token));
+}
+
+static void mptcp_token_test_accept(struct kunit *test)
+{
+	struct mptcp_subflow_request_sock *req =3D build_req_sock(test);
+	struct mptcp_sock *msk =3D build_msk(test);
+
+	KUNIT_ASSERT_EQ(test, 0,
+			mptcp_token_new_request((struct request_sock *)req));
+	msk->token =3D req->token;
+	mptcp_token_accept(req, msk);
+	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(msk->token));
+
+	/* this is now a no-op */
+	mptcp_token_destroy_request(req->token);
+	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(msk->token));
+
+	/* cleanup */
+	mptcp_token_destroy(msk->token);
+}
+
+static void mptcp_token_test_destroyed(struct kunit *test)
+{
+	struct mptcp_subflow_request_sock *req =3D build_req_sock(test);
+	struct mptcp_sock *msk =3D build_msk(test);
+	struct mptcp_sock *null_msk =3D NULL;
+	struct sock *sk;
+
+	sk =3D (struct sock*)msk;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			mptcp_token_new_request((struct request_sock *)req));
+	msk->token =3D req->token;
+	mptcp_token_accept(req, msk);
+
+	/* simulate race on removal */
+	refcount_set(&sk->sk_refcnt, 0);
+	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(msk->token));
+
+	/* cleanup */
+	mptcp_token_destroy(msk->token);
+}
+
+static struct kunit_case mptcp_token_test_cases[] =3D {
+	KUNIT_CASE(mptcp_token_test_req_basic),
+	KUNIT_CASE(mptcp_token_test_msk_basic),
+	KUNIT_CASE(mptcp_token_test_accept),
+	KUNIT_CASE(mptcp_token_test_destroyed),
+	{}
+};
+
+static struct kunit_suite mptcp_token_suite =3D {
+	.name =3D "mptcp-token",
+	.test_cases =3D mptcp_token_test_cases,
+};
+
+kunit_test_suite(mptcp_token_suite);
+
+MODULE_LICENSE("GPL");
\ No newline at end of file
-- =

2.21.3

--===============6885911920499376177==--

Content-Type: multipart/mixed; boundary="===============5443933547775981844=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/4] Squash-to: "mptcp: introduce token KUNIT
 self-tests"
Date: Thu, 04 Jun 2020 19:40:04 +0200
Message-ID: <b8f4e00209b41371f6d5d63f20ad04a8984d4887.1591291903.git.pabeni@redhat.com>
In-Reply-To: cover.1591291903.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4590

--===============5443933547775981844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update tests to APIs change

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/token_test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index 9e385d2c9ff0..c0f76b8b0ce0 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -9,6 +9,7 @@ static struct mptcp_subflow_request_sock *build_req_sock(st=
ruct kunit *test)
 	req =3D kunit_kzalloc(test, sizeof(struct mptcp_subflow_request_sock),
 			    GFP_USER);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, req);
+	mptcp_token_init_request((struct request_sock *)req);
 	return req;
 }
 =

@@ -23,7 +24,7 @@ static void mptcp_token_test_req_basic(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(req->token));
 =

 	/* cleanup */
-	mptcp_token_destroy_request(req->token);
+	mptcp_token_destroy_request((struct request_sock *)req);
 }
 =

 static struct inet_connection_sock *build_icsk(struct kunit *test)
@@ -75,7 +76,7 @@ static void mptcp_token_test_msk_basic(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(ctx->token));
 	KUNIT_EXPECT_EQ(test, 2, (int)refcount_read(&sk->sk_refcnt));
 =

-	mptcp_token_destroy(ctx->token);
+	mptcp_token_destroy(msk);
 	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(ctx->token));
 }
 =

@@ -91,11 +92,11 @@ static void mptcp_token_test_accept(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(msk->token));
 =

 	/* this is now a no-op */
-	mptcp_token_destroy_request(req->token);
+	mptcp_token_destroy_request((struct request_sock *)req);
 	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(msk->token));
 =

 	/* cleanup */
-	mptcp_token_destroy(msk->token);
+	mptcp_token_destroy(msk);
 }
 =

 static void mptcp_token_test_destroyed(struct kunit *test)
@@ -117,7 +118,7 @@ static void mptcp_token_test_destroyed(struct kunit *te=
st)
 	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(msk->token));
 =

 	/* cleanup */
-	mptcp_token_destroy(msk->token);
+	mptcp_token_destroy(msk);
 }
 =

 static struct kunit_case mptcp_token_test_cases[] =3D {
-- =

2.21.3

--===============5443933547775981844==--

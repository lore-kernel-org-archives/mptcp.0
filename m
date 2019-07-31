Content-Type: multipart/mixed; boundary="===============7239943585230727575=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] Remove unused variables, causes compile warnings
Date: Wed, 31 Jul 2019 09:42:48 -0700
Message-ID: <20190731164249.14383-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1569

--===============7239943585230727575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add key generation and token tree

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/token.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index d7d81bb2e1c2..2324a477d513 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -66,7 +66,6 @@ static struct sock *lookup_token(u32 token)
 static void new_req_token(struct request_sock *req,
 			  const struct sk_buff *skb)
 {
-	const struct inet_request_sock *ireq =3D inet_rsk(req);
 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
 =

 	crypto_key_gen_sha1(&subflow_req->local_key, &subflow_req->token,
@@ -132,7 +131,6 @@ static int new_join_valid(struct request_sock *req, str=
uct sock *sk,
 static void new_token(const struct sock *sk)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
-	const struct inet_sock *isk =3D inet_sk(sk);
 =

 	crypto_key_gen_sha1(&subflow->local_key, &subflow->token,
 			    &subflow->idsn);
-- =

2.17.2


--===============7239943585230727575==--

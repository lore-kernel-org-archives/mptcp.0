Content-Type: multipart/mixed; boundary="===============1071780824853949746=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 1/2] mptcp: cache msk on MP_JOIN init_req
Date: Wed, 17 Jun 2020 12:08:56 +0200
Message-ID: <3213f22a1fa85217032ba3de482f2209c63f2870.1592388398.git.pabeni@redhat.com>
In-Reply-To: cover.1592388398.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4717

--===============1071780824853949746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The msk ownership is transferred to the child socket at
3rd ack time, so that we avoid more lookups later. If the
request does not reach the 3rd ack, the MSK reference is
dropped at request sock release time.

As a side effect, fallback is now tracked by a NULL msk
reference instead of zeroed 'mp_join' field. This will
simplify the next patch.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 39 +++++++++++++++++----------------------
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index db56535dfc29..c6eeaf3e8dcb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -249,6 +249,7 @@ struct mptcp_subflow_request_sock {
 	u64	thmac;
 	u32	local_nonce;
 	u32	remote_nonce;
+	struct mptcp_sock	*msk;
 };
 =

 static inline struct mptcp_subflow_request_sock *
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bbdb74b8bc3c..4068bdb2523b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -69,6 +69,9 @@ static void subflow_req_destructor(struct request_sock *r=
eq)
 =

 	pr_debug("subflow_req=3D%p", subflow_req);
 =

+	if (subflow_req->msk)
+		sock_put((struct sock *)subflow_req->msk);
+
 	if (subflow_req->mp_capable)
 		mptcp_token_destroy_request(subflow_req->token);
 	tcp_request_sock_ops.destructor(req);
@@ -86,8 +89,8 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32=
 nonce1, u32 nonce2,
 }
 =

 /* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
-static bool subflow_token_join_request(struct request_sock *req,
-				       const struct sk_buff *skb)
+static struct mptcp_sock *subflow_token_join_request(struct request_sock *=
req,
+						     const struct sk_buff *skb)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	u8 hmac[SHA256_DIGEST_SIZE];
@@ -97,13 +100,13 @@ static bool subflow_token_join_request(struct request_=
sock *req,
 	msk =3D mptcp_token_get_sock(subflow_req->token);
 	if (!msk) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
-		return false;
+		return NULL;
 	}
 =

 	local_id =3D mptcp_pm_get_local_id(msk, (struct sock_common *)req);
 	if (local_id < 0) {
 		sock_put((struct sock *)msk);
-		return false;
+		return NULL;
 	}
 	subflow_req->local_id =3D local_id;
 =

@@ -114,9 +117,7 @@ static bool subflow_token_join_request(struct request_s=
ock *req,
 			      subflow_req->remote_nonce, hmac);
 =

 	subflow_req->thmac =3D get_unaligned_be64(hmac);
-
-	sock_put((struct sock *)msk);
-	return true;
+	return msk;
 }
 =

 static void subflow_init_req(struct request_sock *req,
@@ -133,6 +134,7 @@ static void subflow_init_req(struct request_sock *req,
 =

 	subflow_req->mp_capable =3D 0;
 	subflow_req->mp_join =3D 0;
+	subflow_req->msk =3D NULL;
 =

 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -166,12 +168,9 @@ static void subflow_init_req(struct request_sock *req,
 		subflow_req->remote_id =3D mp_opt.join_id;
 		subflow_req->token =3D mp_opt.token;
 		subflow_req->remote_nonce =3D mp_opt.nonce;
-		pr_debug("token=3D%u, remote_nonce=3D%u", subflow_req->token,
-			 subflow_req->remote_nonce);
-		if (!subflow_token_join_request(req, skb)) {
-			subflow_req->mp_join =3D 0;
-			// @@ need to trigger RST
-		}
+		subflow_req->msk =3D subflow_token_join_request(req, skb);
+		pr_debug("token=3D%u, remote_nonce=3D%u msk=3D%p", subflow_req->token,
+			 subflow_req->remote_nonce, subflow_req->msk);
 	}
 }
 =

@@ -354,10 +353,9 @@ static bool subflow_hmac_valid(const struct request_so=
ck *req,
 	const struct mptcp_subflow_request_sock *subflow_req;
 	u8 hmac[SHA256_DIGEST_SIZE];
 	struct mptcp_sock *msk;
-	bool ret;
 =

 	subflow_req =3D mptcp_subflow_rsk(req);
-	msk =3D mptcp_token_get_sock(subflow_req->token);
+	msk =3D subflow_req->msk;
 	if (!msk)
 		return false;
 =

@@ -365,12 +363,7 @@ static bool subflow_hmac_valid(const struct request_so=
ck *req,
 			      subflow_req->remote_nonce,
 			      subflow_req->local_nonce, hmac);
 =

-	ret =3D true;
-	if (crypto_memneq(hmac, mp_opt->hmac, MPTCPOPT_HMAC_LEN))
-		ret =3D false;
-
-	sock_put((struct sock *)msk);
-	return ret;
+	return !crypto_memneq(hmac, mp_opt->hmac, MPTCPOPT_HMAC_LEN);
 }
 =

 static void mptcp_sock_destruct(struct sock *sk)
@@ -522,10 +515,12 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
 =

-			owner =3D mptcp_token_get_sock(ctx->token);
+			owner =3D subflow_req->msk;
 			if (!owner)
 				goto dispose_child;
 =

+			/* move the msk reference ownership to the subflow */
+			subflow_req->msk =3D NULL;
 			ctx->conn =3D (struct sock *)owner;
 			if (!mptcp_finish_join(child))
 				goto dispose_child;
-- =

2.26.2

--===============1071780824853949746==--

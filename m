Content-Type: multipart/mixed; boundary="===============6912502336787064750=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: cache msk on MP_JOIN init_req
Date: Thu, 11 Jun 2020 19:20:56 +0200
Message-ID: <b8b0118dd20d1726889c6747682c7cbe7250d8bc.1591895765.git.pabeni@redhat.com>
In-Reply-To: cover.1591895765.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4652

--===============6912502336787064750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The msk ownership is transferred to the child socket at
3rd ack time, so that we avoid more lookups later. If the
request does not reach the 3rd ack, the MSK reference is
dropped at request sock release time.

This will simplify the next patches.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 38 ++++++++++++++++----------------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e4341b278464..169eccff4383 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -255,6 +255,7 @@ struct mptcp_subflow_request_sock {
 	u64	thmac;
 	u32	local_nonce;
 	u32	remote_nonce;
+	struct mptcp_sock	*msk;
 	struct hlist_nulls_node token_node;
 };
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d5935f3bfbd1..8367d93e2f5c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -35,6 +35,8 @@ static void subflow_req_destructor(struct request_sock *r=
eq)
 =

 	pr_debug("subflow_req=3D%p", subflow_req);
 =

+	if (subflow_req->msk)
+		sock_put((struct sock *)subflow_req->msk);
 	mptcp_token_destroy_request(req);
 	tcp_request_sock_ops.destructor(req);
 }
@@ -51,8 +53,8 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32=
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
@@ -62,13 +64,13 @@ static bool subflow_token_join_request(struct request_s=
ock *req,
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

@@ -79,9 +81,7 @@ static bool subflow_token_join_request(struct request_soc=
k *req,
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
@@ -98,6 +98,7 @@ static void subflow_init_req(struct request_sock *req,
 =

 	subflow_req->mp_capable =3D 0;
 	subflow_req->mp_join =3D 0;
+	subflow_req->msk =3D NULL;
 	mptcp_token_init_request(req);
 =

 #ifdef CONFIG_TCP_MD5SIG
@@ -132,12 +133,9 @@ static void subflow_init_req(struct request_sock *req,
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

@@ -317,10 +315,9 @@ static bool subflow_hmac_valid(const struct request_so=
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

@@ -328,12 +325,7 @@ static bool subflow_hmac_valid(const struct request_so=
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
@@ -486,10 +478,12 @@ static struct sock *subflow_syn_recv_sock(const struc=
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

2.21.3

--===============6912502336787064750==--

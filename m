Content-Type: multipart/mixed; boundary="===============8504522996306239232=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/3] mptcp: emit tcp reset when a join
 request fails
Date: Mon, 30 Nov 2020 16:36:31 +0100
Message-ID: <20201130153631.21872-4-fw@strlen.de>
In-Reply-To: 20201130153631.21872-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6991

--===============8504522996306239232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RFC 8684 says:
 If the token is unknown or the host wants to refuse subflow establishment
 (for example, due to a limit on the number of subflows it will permit),
 the receiver will send back a reset (RST) signal, analogous to an unknown
 port in TCP, containing an MP_TCPRST option (Section 3.6) with an
 "MPTCP specific error" reason code.

mptcp-next doesn't support MP_TCPRST yet, this can be added in another
change.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 47 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c55b8f176746..5a8005746bc8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -112,9 +112,14 @@ static int __subflow_init_req(struct request_sock *req=
, const struct sock *sk_li
 	return 0;
 }
 =

-static void subflow_init_req(struct request_sock *req,
-			     const struct sock *sk_listener,
-			     struct sk_buff *skb)
+/* Init mptcp request socket.
+ *
+ * Returns an error code if a JOIN has failed and a TCP reset
+ * should be sent.
+ */
+static int subflow_init_req(struct request_sock *req,
+			    const struct sock *sk_listener,
+			    struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
@@ -125,7 +130,7 @@ static void subflow_init_req(struct request_sock *req,
 =

 	ret =3D __subflow_init_req(req, sk_listener);
 	if (ret)
-		return;
+		return 0;
 =

 	mptcp_get_options(skb, &mp_opt);
 =

@@ -133,7 +138,7 @@ static void subflow_init_req(struct request_sock *req,
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
 =

 		if (mp_opt.mp_join)
-			return;
+			return 0;
 	} else if (mp_opt.mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
 	}
@@ -157,7 +162,7 @@ static void subflow_init_req(struct request_sock *req,
 			} else {
 				subflow_req->mp_capable =3D 1;
 			}
-			return;
+			return 0;
 		}
 =

 		err =3D mptcp_token_new_request(req);
@@ -175,7 +180,11 @@ static void subflow_init_req(struct request_sock *req,
 		subflow_req->remote_nonce =3D mp_opt.nonce;
 		subflow_req->msk =3D subflow_token_join_request(req, skb);
 =

-		if (unlikely(req->syncookie) && subflow_req->msk) {
+		/* Can't fall back to TCP in this case. */
+		if (!subflow_req->msk)
+			return -EPERM;
+
+		if (unlikely(req->syncookie)) {
 			if (mptcp_can_accept_new_subflow(subflow_req->msk))
 				subflow_init_req_cookie_join_save(subflow_req, skb);
 		}
@@ -183,6 +192,8 @@ static void subflow_init_req(struct request_sock *req,
 		pr_debug("token=3D%u, remote_nonce=3D%u msk=3D%p", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
+
+	return 0;
 }
 =

 int mptcp_subflow_init_cookie_req(struct request_sock *req,
@@ -234,6 +245,7 @@ static struct dst_entry *subflow_v4_route_req(const str=
uct sock *sk,
 					      struct request_sock *req)
 {
 	struct dst_entry *dst;
+	int err;
 =

 	tcp_rsk(req)->is_mptcp =3D 1;
 =

@@ -241,8 +253,14 @@ static struct dst_entry *subflow_v4_route_req(const st=
ruct sock *sk,
 	if (!dst)
 		return NULL;
 =

-	subflow_init_req(req, sk, skb);
-	return dst;
+	err =3D subflow_init_req(req, sk, skb);
+	if (err =3D=3D 0)
+		return dst;
+
+	dst_release(dst);
+	if (!req->syncookie)
+		tcp_request_sock_ops.send_reset(sk, skb);
+	return NULL;
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -252,6 +270,7 @@ static struct dst_entry *subflow_v6_route_req(const str=
uct sock *sk,
 					      struct request_sock *req)
 {
 	struct dst_entry *dst;
+	int err;
 =

 	tcp_rsk(req)->is_mptcp =3D 1;
 =

@@ -259,8 +278,14 @@ static struct dst_entry *subflow_v6_route_req(const st=
ruct sock *sk,
 	if (!dst)
 		return NULL;
 =

-	subflow_init_req(req, sk, skb);
-	return dst;
+	err =3D subflow_init_req(req, sk, skb);
+	if (err =3D=3D 0)
+		return dst;
+
+	dst_release(dst);
+	if (!req->syncookie)
+		tcp6_request_sock_ops.send_reset(sk, skb);
+	return NULL;
 }
 #endif
 =

-- =

2.26.2

--===============8504522996306239232==--

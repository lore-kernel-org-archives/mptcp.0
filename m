Content-Type: multipart/mixed; boundary="===============1294396144649090674=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net] mptcp: init mptcp request socket earlier
Date: Wed, 03 Feb 2021 17:28:11 +0100
Message-ID: <f512d230984510ab2ccbc4e778da4474bd2e1078.1612367293.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7610

--===============1294396144649090674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mptcp subflow route_req() callback performs the subflow
req initialization after the route_req() check. If the latter
fails, mptcp-specific bits of the current request sockets
are left uninitialized.

The above causes bad things at req socket disposal time, when
the mptcp resources are cleared.

This change addresses the issue by splitting subflow_init_req()
into the actual initialization and the mptcp-specific checks.
The initialization is moved before any possibly failing check.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Fixes: 7ea851d19b23 ("tcp: merge 'init_req' and 'route_req' functions")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Should fix issues/125 && 130. Even syzkaller would proof the
opposite, the problem described above looks real.
@Christoph: could you please... ? (additional free coffee for your
upcoming holiday in Tuscany ;)
---
 net/mptcp/subflow.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7a5518f751105..26129172f5acd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -100,7 +100,7 @@ static struct mptcp_sock *subflow_token_join_request(st=
ruct request_sock *req)
 	return msk;
 }
 =

-static int __subflow_init_req(struct request_sock *req, const struct sock =
*sk_listener)
+static void subflow_init_req(struct request_sock *req, const struct sock *=
sk_listener)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 =

@@ -108,16 +108,6 @@ static int __subflow_init_req(struct request_sock *req=
, const struct sock *sk_li
 	subflow_req->mp_join =3D 0;
 	subflow_req->msk =3D NULL;
 	mptcp_token_init_request(req);
-
-#ifdef CONFIG_TCP_MD5SIG
-	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
-	 * TCP option space.
-	 */
-	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
-		return -EINVAL;
-#endif
-
-	return 0;
 }
 =

 static bool subflow_use_different_sport(struct mptcp_sock *msk, const stru=
ct sock *sk)
@@ -130,9 +120,9 @@ static bool subflow_use_different_sport(struct mptcp_so=
ck *msk, const struct soc
  * Returns an error code if a JOIN has failed and a TCP reset
  * should be sent.
  */
-static int subflow_init_req(struct request_sock *req,
-			    const struct sock *sk_listener,
-			    struct sk_buff *skb)
+static int subflow_check_req(struct request_sock *req,
+			     const struct sock *sk_listener,
+			     struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
@@ -141,9 +131,13 @@ static int subflow_init_req(struct request_sock *req,
 =

 	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
 =

-	ret =3D __subflow_init_req(req, sk_listener);
-	if (ret)
-		return 0;
+#ifdef CONFIG_TCP_MD5SIG
+	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
+	 * TCP option space.
+	 */
+	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
+		return -EINVAL;
+#endif
 =

 	mptcp_get_options(skb, &mp_opt);
 =

@@ -236,10 +230,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock =
*req,
 	struct mptcp_options_received mp_opt;
 	int err;
 =

-	err =3D __subflow_init_req(req, sk_listener);
-	if (err)
-		return err;
-
+	subflow_init_req(req, sk_listener);
 	mptcp_get_options(skb, &mp_opt);
 =

 	if (mp_opt.mp_capable && mp_opt.mp_join)
@@ -279,12 +270,13 @@ static struct dst_entry *subflow_v4_route_req(const s=
truct sock *sk,
 	int err;
 =

 	tcp_rsk(req)->is_mptcp =3D 1;
+	subflow_init_req(req, sk);
 =

 	dst =3D tcp_request_sock_ipv4_ops.route_req(sk, skb, fl, req);
 	if (!dst)
 		return NULL;
 =

-	err =3D subflow_init_req(req, sk, skb);
+	err =3D subflow_check_req(req, sk, skb);
 	if (err =3D=3D 0)
 		return dst;
 =

@@ -304,12 +296,13 @@ static struct dst_entry *subflow_v6_route_req(const s=
truct sock *sk,
 	int err;
 =

 	tcp_rsk(req)->is_mptcp =3D 1;
+	subflow_init_req(req, sk);
 =

 	dst =3D tcp_request_sock_ipv6_ops.route_req(sk, skb, fl, req);
 	if (!dst)
 		return NULL;
 =

-	err =3D subflow_init_req(req, sk, skb);
+	err =3D subflow_check_req(req, sk, skb);
 	if (err =3D=3D 0)
 		return dst;
 =

-- =

2.26.2

--===============1294396144649090674==--

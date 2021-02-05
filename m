Content-Type: multipart/mixed; boundary="===============1172415978505453882=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net 2/5] mptcp: init mptcp request socket earlier
Date: Fri, 05 Feb 2021 17:55:11 +0100
Message-ID: <6c8e104ef13d000f55aeb58e995a34cda2617ca3.1612543972.git.pabeni@redhat.com>
In-Reply-To: cover.1612543972.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7652

--===============1172415978505453882==
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
v1 -> v2:
 - fixed compile warn, dropping unused variable, no need to additional
tests,
---
 net/mptcp/subflow.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 33279235cd32a..16c391ee8e0f8 100644
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
@@ -130,20 +120,23 @@ static bool subflow_use_different_sport(struct mptcp_=
sock *msk, const struct soc
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
 	struct mptcp_options_received mp_opt;
-	int ret;
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

@@ -236,10 +229,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock =
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
@@ -279,12 +269,13 @@ static struct dst_entry *subflow_v4_route_req(const s=
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

@@ -304,12 +295,13 @@ static struct dst_entry *subflow_v6_route_req(const s=
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

--===============1172415978505453882==--

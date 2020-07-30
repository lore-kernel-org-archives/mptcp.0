Content-Type: multipart/mixed; boundary="===============3109353776993875028=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC v3 03/10] mptcp: subflow: split subflow_init_req
Date: Thu, 30 Jul 2020 02:12:34 +0200
Message-ID: <20200730001241.3037-4-fw@strlen.de>
In-Reply-To: 20200730001241.3037-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5375

--===============3109353776993875028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When syncookie support is added, we will need to add a variant of
subflow_init_req() helper.  It will do almost same thing except
that it will not compute/add a token to the mptcp token tree.

To avoid excess copy&paste, this commit splits away part of the
code into a new helper, __subflow_init_req, that can then be re-used
from the 'no insert' function added in a followup change.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9feb87880d1c..091e305a81c8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -91,17 +91,9 @@ static struct mptcp_sock *subflow_token_join_request(str=
uct request_sock *req,
 	return msk;
 }
 =

-static void subflow_init_req(struct request_sock *req,
-			     const struct sock *sk_listener,
-			     struct sk_buff *skb)
+static int __subflow_init_req(struct request_sock *req, const struct sock =
*sk_listener)
 {
-	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
-	struct mptcp_options_received mp_opt;
-
-	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
-
-	mptcp_get_options(skb, &mp_opt);
 =

 	subflow_req->mp_capable =3D 0;
 	subflow_req->mp_join =3D 0;
@@ -113,9 +105,29 @@ static void subflow_init_req(struct request_sock *req,
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
-		return;
+		return -EINVAL;
 #endif
 =

+	return 0;
+}
+
+static void subflow_init_req(struct request_sock *req,
+			     const struct sock *sk_listener,
+			     struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
+	struct mptcp_options_received mp_opt;
+	int ret;
+
+	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
+
+	ret =3D __subflow_init_req(req, sk_listener);
+	if (ret)
+		return;
+
+	mptcp_get_options(skb, &mp_opt);
+
 	if (mp_opt.mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
 =

-- =

2.26.2

--===============3109353776993875028==--

Content-Type: multipart/mixed; boundary="===============8214536453565149018=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 mptcp-next 04/12] mptcp: subflow: split
 subflow_init_req into helpers
Date: Tue, 21 Jul 2020 22:36:34 +0200
Message-ID: <20200721203642.32753-5-fw@strlen.de>
In-Reply-To: 20200721203642.32753-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5150

--===============8214536453565149018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When syncookie support is added, we will need to add a variant of
subflow_init_req() helper.  It will do almost same thing except
that it will not compute/add a token to the mptcp token tree.

To avoid excess copy&paste, this commit splits away part of the
code into helpers that can then be re-used from the 'no insert'
function added in a followup change.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 49 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9526566ec153..800e7d472dcd 100644
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
@@ -113,18 +105,47 @@ static void subflow_init_req(struct request_sock *req,
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
-		return;
+		return -EINVAL;
 #endif
 =

-	if (mp_opt.mp_capable) {
+	return 0;
+}
+
+static int __subflow_check_options(const struct mptcp_options_received *mp=
_opt,
+				   struct request_sock *req)
+{
+	if (mp_opt->mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
 =

-		if (mp_opt.mp_join)
-			return;
-	} else if (mp_opt.mp_join) {
+		if (mp_opt->mp_join)
+			return -EINVAL;
+	} else if (mp_opt->mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
 	}
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
+	ret =3D __subflow_check_options(&mp_opt, req);
+	if (ret)
+		return;
+
 	if (mp_opt.mp_capable && listener->request_mptcp) {
 		int err, retries =3D 4;
 =

-- =

2.26.2

--===============8214536453565149018==--

Content-Type: multipart/mixed; boundary="===============0102198002840733413=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 04/10] mptcp: token: remove token_join_valid
Date: Thu, 29 Aug 2019 11:06:53 +0200
Message-ID: <20190829090659.766-5-fw@strlen.de>
In-Reply-To: 20190829090659.766-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1746

--===============0102198002840733413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This helper is only used once, we can just place it in subflow.c
and use the existing mptcp_token_get_sock() to fetch the mptcp
socket.

Also, prefer the crypto_mneq function rather than memcmp
which might reveal timing information when doing hmac compare.

v2: place it in subflow.c, rename to subflow_hmac_valid (Peter)

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h |  2 --
 net/mptcp/subflow.c  | 29 ++++++++++++++++++++++++++++-
 net/mptcp/token.c    | 36 ------------------------------------
 3 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 89bd68f85856..5f33d3729bfd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -227,8 +227,6 @@ void mptcp_finish_join(struct sock *sk);
 =

 void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
 int token_join_request(struct request_sock *req, const struct sk_buff *skb=
);
-int token_join_valid(struct request_sock *req,
-		     struct tcp_options_received *rx_opt);
 void token_destroy_request(u32 token);
 void token_new_connect(struct sock *sk);
 void token_new_accept(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8a8109466487..f604e189126b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <crypto/algapi.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -176,6 +177,31 @@ static int subflow_conn_request(struct sock *sk, struc=
t sk_buff *skb)
 	return 0;
 }
 =

+/* validate hmac received in third ACK */
+static bool subflow_hmac_valid(const struct request_sock *req,
+			       const struct tcp_options_received *rx_opt)
+{
+	const struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	u8 hmac[MPTCPOPT_HMAC_LEN];
+	struct mptcp_sock *msk;
+	bool ret;
+
+	msk =3D mptcp_token_get_sock(subflow_req->token);
+	if (!msk)
+		return false;
+
+	crypto_hmac_sha1(msk->remote_key, msk->local_key,
+			 subflow_req->remote_nonce, subflow_req->local_nonce,
+			 (u32 *)hmac);
+
+	ret =3D true;
+	if (crypto_memneq(hmac, rx_opt->mptcp.hmac, sizeof(hmac)))
+		ret =3D false;
+
+	sock_put((struct sock *)msk);
+	return ret;
+}
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -194,7 +220,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	if (!subflow_req->mp_capable && subflow_req->mp_join) {
 		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
-		if (!opt_rx.mptcp.mp_join || token_join_valid(req, &opt_rx))
+		if (!opt_rx.mptcp.mp_join ||
+		    !subflow_hmac_valid(req, &opt_rx))
 			return NULL;
 	}
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 3163832d8ebf..8de7d9d83e96 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -93,20 +93,6 @@ static void new_req_join(struct request_sock *req, struc=
t sock *sk,
 		 subflow_req->thmac);
 }
 =

-static int new_join_valid(struct request_sock *req, struct sock *sk,
-			  struct tcp_options_received *rx_opt)
-{
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	u8 hmac[MPTCPOPT_HMAC_LEN];
-
-	crypto_hmac_sha1(msk->remote_key, msk->local_key,
-			 subflow_req->remote_nonce, subflow_req->local_nonce,
-			 (u32 *)hmac);
-
-	return memcmp(hmac, (char *)rx_opt->mptcp.hmac, MPTCPOPT_HMAC_LEN);
-}
-
 static void new_token(const struct sock *sk)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
@@ -217,28 +203,6 @@ int token_join_request(struct request_sock *req, const=
 struct sk_buff *skb)
 	return 0;
 }
 =

-/* validate hmac received in third ACK */
-int token_join_valid(struct request_sock *req,
-		     struct tcp_options_received *rx_opt)
-{
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-	struct sock *conn;
-	int err;
-
-	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
-	spin_lock_bh(&token_tree_lock);
-	conn =3D __token_lookup(subflow_req->token);
-	if (conn)
-		sock_hold(conn);
-	spin_unlock_bh(&token_tree_lock);
-	if (!conn)
-		return -1;
-
-	err =3D new_join_valid(req, conn, rx_opt);
-	sock_put(conn);
-	return err;
-}
-
 /* create new local key, idsn, and token for subflow */
 void token_new_connect(struct sock *sk)
 {
-- =

2.21.0


--===============0102198002840733413==--

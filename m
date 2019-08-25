Content-Type: multipart/mixed; boundary="===============7511106921576953685=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 04/10] mptcp: token: fold new_join_valid into its
 caller
Date: Sun, 25 Aug 2019 20:59:33 +0200
Message-ID: <20190825185939.21596-5-fw@strlen.de>
In-Reply-To: 20190825185939.21596-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1701

--===============7511106921576953685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This helper is only used once.  Both this function and its
caller are reasonably small, so merge these two functions.

The function is renamed to have an mptcp prefix.

Also, prefer the crypto_mneq function rather than memcmp
which might reveal timing information when doing hmac compare.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/subflow.c  |  3 ++-
 net/mptcp/token.c    | 52 +++++++++++++++++++++++++-------------------
 3 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 89bd68f85856..19dcc49202ba 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -227,8 +227,8 @@ void mptcp_finish_join(struct sock *sk);
 =

 void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
 int token_join_request(struct request_sock *req, const struct sk_buff *skb=
);
-int token_join_valid(struct request_sock *req,
-		     struct tcp_options_received *rx_opt);
+bool mptcp_token_join_valid(const struct request_sock *req,
+			    const struct tcp_options_received *rx_opt);
 void token_destroy_request(u32 token);
 void token_new_connect(struct sock *sk);
 void token_new_accept(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 72ad9a324677..7e479c95e3e5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -194,7 +194,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	if (!subflow_req->mp_capable && subflow_req->mp_join) {
 		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
-		if (!opt_rx.mptcp.mp_join || token_join_valid(req, &opt_rx))
+		if (!opt_rx.mptcp.mp_join ||
+		    !mptcp_token_join_valid(req, &opt_rx))
 			return NULL;
 	}
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index fc0cbd76d7a1..946a53496d47 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -25,6 +25,7 @@
 #include <linux/radix-tree.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
+#include <crypto/algapi.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/protocol.h>
@@ -91,20 +92,6 @@ static void new_req_join(struct request_sock *req, struc=
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
@@ -215,13 +202,26 @@ int token_join_request(struct request_sock *req, cons=
t struct sk_buff *skb)
 	return 0;
 }
 =

-/* validate hmac received in third ACK */
-int token_join_valid(struct request_sock *req,
-		     struct tcp_options_received *rx_opt)
+/**
+ * mptcp_token_join_valid - validate hmac received in 3whs ACK
+ * @req - the request socket that received the ACK
+ * @rx_opt - the tcp options of this ACK
+ *
+ * This function is called when a new incoming connection is about
+ * to finish the TCP 3whs, and that connection indicates a join
+ * with an existing MPTCP flow.
+ *
+ * returns true if the mptcp token (connection we want to join)
+ * exists and its HMAC matches the value sent from the client.
+ */
+bool mptcp_token_join_valid(const struct request_sock *req,
+			    const struct tcp_options_received *rx_opt)
 {
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	const struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	u8 hmac[MPTCPOPT_HMAC_LEN];
+	struct mptcp_sock *msk;
 	struct sock *conn;
-	int err;
+	bool ret;
 =

 	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
 	spin_lock_bh(&token_tree_lock);
@@ -230,11 +230,19 @@ int token_join_valid(struct request_sock *req,
 		sock_hold(conn);
 	spin_unlock_bh(&token_tree_lock);
 	if (!conn)
-		return -1;
+		return false;
+
+	msk =3D mptcp_sk(conn);
+	crypto_hmac_sha1(msk->remote_key, msk->local_key,
+			 subflow_req->remote_nonce, subflow_req->local_nonce,
+			 (u32 *)hmac);
+
+	ret =3D true;
+	if (crypto_memneq(hmac, rx_opt->mptcp.hmac, sizeof(hmac)))
+		ret =3D false;
 =

-	err =3D new_join_valid(req, conn, rx_opt);
 	sock_put(conn);
-	return err;
+	return ret;
 }
 =

 /* create new local key, idsn, and token for subflow */
-- =

2.21.0


--===============7511106921576953685==--

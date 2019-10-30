Content-Type: multipart/mixed; boundary="===============5154131751113780811=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/6] mptcp: Re-factor subflow routines to be
 af-agnostic
Date: Wed, 30 Oct 2019 16:38:42 -0700
Message-ID: <20191030233844.4790-5-peter.krystad@linux.intel.com>
In-Reply-To: 20191030233844.4790-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2368

--===============5154131751113780811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Re-factor subflow_rebuild_header, init_req, conn_request,
syn_recv_sock, and finish_connect to separate af-specific
and functional parts.

squash unfortunately is complicated:
subflow_v4_finish_connect: Handle MP_CAPABLE options for outgoing...
subflow_v4_rebuild_header: Add key generation and token tree
subflow_v4_conn_request,
subflow_v4_syn_recv_sock,
subflow_v4_init_req: Create SUBFLOW socket for incoming connections

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/subflow.c | 76 +++++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 13e207458e0b..758b4b36644a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -25,7 +25,7 @@ static inline void SUBFLOW_REQ_INC_STATS(struct request_s=
ock *req,
 	MPTCP_INC_STATS(sock_net(req_to_sk(req)), field);
 }
 =

-static struct inet_connection_sock_af_ops subflow_specific;
+static struct inet_connection_sock_af_ops subflow_v4_specific;
 =

 static int subflow_rebuild_header(struct sock *sk)
 {
@@ -44,6 +44,14 @@ static int subflow_rebuild_header(struct sock *sk)
 		} while (!subflow->local_nonce);
 	}
 =

+	return err;
+}
+
+static int subflow_v4_rebuild_header(struct sock *sk)
+{
+	int err;
+
+	err =3D subflow_rebuild_header(sk);
 	if (err)
 		return err;
 =

@@ -92,19 +100,14 @@ static bool subflow_token_join_request(struct request_=
sock *req,
 	return true;
 }
 =

-static void subflow_v4_init_req(struct request_sock *req,
-				const struct sock *sk_listener,
-				struct sk_buff *skb)
+static void subflow_init_req(struct request_sock *req,
+			     const struct sock *sk_listener,
+			     struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	struct tcp_options_received rx_opt;
 =

-	tcp_rsk(req)->is_mptcp =3D 1;
-	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
-
-	tcp_request_sock_ipv4_ops.init_req(req, sk_listener, skb);
-
 	memset(&rx_opt.mptcp, 0, sizeof(rx_opt.mptcp));
 	mptcp_get_options(skb, &rx_opt);
 =

@@ -148,6 +151,17 @@ static void subflow_v4_init_req(struct request_sock *r=
eq,
 	}
 }
 =

+static void subflow_v4_init_req(struct request_sock *req,
+				const struct sock *sk_listener,
+				struct sk_buff *skb)
+{
+	tcp_rsk(req)->is_mptcp =3D 1;
+
+	tcp_request_sock_ipv4_ops.init_req(req, sk_listener, skb);
+
+	subflow_init_req(req, sk_listener, skb);
+}
+
 /* validate received truncated hmac and create hmac for third ACK */
 static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow)
 {
@@ -171,8 +185,6 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 =

-	ipv4_specific.sk_rx_dst_set(sk, skb);
-
 	if (!subflow->conn)
 		return;
 =

@@ -207,10 +219,18 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 	}
 }
 =

+static void subflow_v4_finish_connect(struct sock *sk,
+				      const struct sk_buff *skb)
+{
+	ipv4_specific.sk_rx_dst_set(sk, skb);
+
+	subflow_finish_connect(sk, skb);
+}
+
 static struct request_sock_ops subflow_request_sock_ops;
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
 =

-static int subflow_conn_request(struct sock *sk, struct sk_buff *skb)
+static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 =

@@ -259,7 +279,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 					  struct request_sock *req,
 					  struct dst_entry *dst,
 					  struct request_sock *req_unhash,
-					  bool *own_req)
+					  bool *own_req,
+					  const struct inet_connection_sock_af_ops *af_ops)
 {
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
 	struct mptcp_subflow_request_sock *subflow_req;
@@ -278,7 +299,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			return NULL;
 	}
 =

-	child =3D ipv4_specific.syn_recv_sock(sk, skb, req, dst, req_unhash,
+	child =3D af_ops->syn_recv_sock(sk, skb, req, dst, req_unhash,
 					    own_req);
 =

 	if (child && *own_req) {
@@ -312,6 +333,21 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 	return NULL;
 }
 =

+static struct sock *subflow_v4_syn_recv_sock(const struct sock *sk,
+					     struct sk_buff *skb,
+					     struct request_sock *req,
+					     struct dst_entry *dst,
+					     struct request_sock *req_unhash,
+					     bool *own_req)
+{
+	struct sock *child;
+
+	child =3D subflow_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req,
+				      &ipv4_specific);
+
+	return child;
+}
+
 enum mapping_status {
 	MAPPING_OK,
 	MAPPING_INVALID,
@@ -770,7 +806,7 @@ static int subflow_ulp_init(struct sock *sk)
 	pr_debug("subflow=3D%p", ctx);
 =

 	tp->is_mptcp =3D 1;
-	icsk->icsk_af_ops =3D &subflow_specific;
+	icsk->icsk_af_ops =3D &subflow_v4_specific;
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	sk->sk_data_ready =3D subflow_data_ready;
 	sk->sk_write_space =3D subflow_write_space;
@@ -862,11 +898,11 @@ void mptcp_subflow_init(void)
 	subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 	subflow_request_sock_ipv4_ops.init_req =3D subflow_v4_init_req;
 =

-	subflow_specific =3D ipv4_specific;
-	subflow_specific.conn_request =3D subflow_conn_request;
-	subflow_specific.syn_recv_sock =3D subflow_syn_recv_sock;
-	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
-	subflow_specific.rebuild_header =3D subflow_rebuild_header;
+	subflow_v4_specific =3D ipv4_specific;
+	subflow_v4_specific.conn_request =3D subflow_v4_conn_request;
+	subflow_v4_specific.syn_recv_sock =3D subflow_v4_syn_recv_sock;
+	subflow_v4_specific.sk_rx_dst_set =3D subflow_v4_finish_connect;
+	subflow_v4_specific.rebuild_header =3D subflow_v4_rebuild_header;
 =

 	mptcp_diag_subflow_init(&subflow_ulp_ops);
 =

-- =

2.17.2

--===============5154131751113780811==--

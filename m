Content-Type: multipart/mixed; boundary="===============8624495189946080110=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/6] mptcp: Reference icsk_af_ops routines through
 saved pointer
Date: Tue, 05 Nov 2019 20:41:28 -0800
Message-ID: <20191106044133.14418-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191106044133.14418-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2412

--===============8624495189946080110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Save a pointer to the original TCP address-family-specific routines
in the subflow context, which can then be called by the MPTCP versions
of the same routines.

This eliminates the need to directly reference inet_xxx routines, or
indirectly through the ipv4_specific struct. This approach will also
save a lot of cut-n-paste code for IPv6 support.

squashto:  Handle MP_CAPABLE options for outgoing connections
           (new ctx field and sk_rx_dst_set changes)
           Create SUBFLOW socket for incoming connections
           (conn_request and syn_recv_sock changes)
           Add key generation and token tree
           (subflow_rebuild_header changes)

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 56e1b8d097b3..7f783ca65f43 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -227,6 +227,7 @@ struct mptcp_subflow_context {
 =

 	struct	socket *tcp_sock;   /* underlying tcp_sock */
 	struct	sock *conn;	    /* parent mptcp_sock */
+	const	struct inet_connection_sock_af_ops *icsk_af_ops;
 	void	(*tcp_sk_data_ready)(struct sock *sk);
 	struct	rcu_head rcu;
 };
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 704dfc49f0d5..6aa02001a06d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -45,7 +45,7 @@ static int subflow_rebuild_header(struct sock *sk)
 	if (err)
 		return err;
 =

-	return inet_sk_rebuild_header(sk);
+	return subflow->icsk_af_ops->rebuild_header(sk);
 }
 =

 static void subflow_req_destructor(struct request_sock *req)
@@ -169,7 +169,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 =

-	inet_sk_rx_dst_set(sk, skb);
+	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 =

 	if (!subflow->conn)
 		return;
@@ -208,7 +208,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 static struct request_sock_ops subflow_request_sock_ops;
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
 =

-static int subflow_conn_request(struct sock *sk, struct sk_buff *skb)
+static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 =

@@ -276,7 +276,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			return NULL;
 	}
 =

-	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);
+	child =3D listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
+						     req_unhash, own_req);
 =

 	if (child && *own_req) {
 		struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(child);
@@ -768,6 +769,7 @@ static int subflow_ulp_init(struct sock *sk)
 	pr_debug("subflow=3D%p", ctx);
 =

 	tp->is_mptcp =3D 1;
+	ctx->icsk_af_ops =3D icsk->icsk_af_ops;
 	icsk->icsk_af_ops =3D &subflow_specific;
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	sk->sk_data_ready =3D subflow_data_ready;
@@ -805,6 +807,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 =

 	new_ctx->conn =3D NULL;
 	new_ctx->conn_finished =3D 1;
+	new_ctx->icsk_af_ops =3D old_ctx->icsk_af_ops;
 	new_ctx->tcp_sk_data_ready =3D old_ctx->tcp_sk_data_ready;
 =

 	if (subflow_req->mp_capable) {
@@ -861,7 +864,7 @@ void mptcp_subflow_init(void)
 	subflow_request_sock_ipv4_ops.init_req =3D subflow_v4_init_req;
 =

 	subflow_specific =3D ipv4_specific;
-	subflow_specific.conn_request =3D subflow_conn_request;
+	subflow_specific.conn_request =3D subflow_v4_conn_request;
 	subflow_specific.syn_recv_sock =3D subflow_syn_recv_sock;
 	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
 	subflow_specific.rebuild_header =3D subflow_rebuild_header;
-- =

2.17.2

--===============8624495189946080110==--

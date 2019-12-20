Content-Type: multipart/mixed; boundary="===============2081840201058304780=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/4] Squash-to: "mptcp: Implement MPTCP receive
 path"
Date: Fri, 20 Dec 2019 19:45:08 +0100
Message-ID: <1af7912c470c4e6c57432bdd5a8dcaf537178fd9.1576867317.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3234

--===============2081840201058304780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

deal with fallback: we must reset sk callback to the TCP one.
Use the cached ptr in the old ctx.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.h | 13 ++++++++++++-
 net/mptcp/subflow.c  | 11 ++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e4fce9f0ad65..7f3cc7952227 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -121,7 +121,10 @@ struct mptcp_subflow_context {
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
-	void	(*tcp_sk_data_ready)(struct sock *sk);
+	void	(*tcp_data_ready)(struct sock *sk);
+	void	(*tcp_state_change)(struct sock *sk);
+	void	(*tcp_write_space)(struct sock *sk);
+
 	struct	rcu_head rcu;
 };
 =

@@ -159,6 +162,14 @@ bool mptcp_subflow_data_available(struct sock *sk);
 void mptcp_subflow_init(void);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

+static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
+					      struct mptcp_subflow_context *ctx)
+{
+	sk->sk_data_ready =3D ctx->tcp_data_ready;
+	sk->sk_state_change =3D ctx->tcp_state_change;
+	sk->sk_write_space =3D ctx->tcp_write_space;
+}
+
 extern const struct inet_connection_sock_af_ops ipv4_specific;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 extern const struct inet_connection_sock_af_ops ipv6_specific;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 48bf0b1d8d28..3ac1764f276b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -504,7 +504,7 @@ static void subflow_data_ready(struct sock *sk)
 	struct sock *parent =3D subflow->conn;
 =

 	if (!parent || !subflow->mp_capable) {
-		subflow->tcp_sk_data_ready(sk);
+		subflow->tcp_data_ready(sk);
 =

 		if (parent)
 			parent->sk_data_ready(parent);
@@ -652,7 +652,9 @@ static int subflow_ulp_init(struct sock *sk)
 	if (sk->sk_family =3D=3D AF_INET6)
 		icsk->icsk_af_ops =3D &subflow_v6_specific;
 #endif
-	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
+	ctx->tcp_data_ready =3D sk->sk_data_ready;
+	ctx->tcp_state_change =3D sk->sk_state_change;
+	ctx->tcp_write_space =3D sk->sk_write_space;
 	sk->sk_data_ready =3D subflow_data_ready;
 	sk->sk_write_space =3D subflow_write_space;
 	sk->sk_state_change =3D subflow_state_change;
@@ -683,6 +685,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 =

 	if (!subflow_req->mp_capable ||
 	    (new_ctx =3D subflow_create_ctx(newsk, priority)) =3D=3D NULL) {
+		mptcp_subflow_tcp_fallback(newsk, old_ctx);
 		tcp_sk(newsk)->is_mptcp =3D 0;
 		return;
 	}
@@ -690,7 +693,9 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	new_ctx->conn =3D NULL;
 	new_ctx->conn_finished =3D 1;
 	new_ctx->icsk_af_ops =3D old_ctx->icsk_af_ops;
-	new_ctx->tcp_sk_data_ready =3D old_ctx->tcp_sk_data_ready;
+	new_ctx->tcp_data_ready =3D old_ctx->tcp_data_ready;
+	new_ctx->tcp_state_change =3D old_ctx->tcp_state_change;
+	new_ctx->tcp_write_space =3D old_ctx->tcp_write_space;
 	new_ctx->mp_capable =3D 1;
 	new_ctx->fourth_ack =3D 1;
 	new_ctx->remote_key =3D subflow_req->remote_key;
-- =

2.21.0

--===============2081840201058304780==--

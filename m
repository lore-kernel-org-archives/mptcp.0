Content-Type: multipart/mixed; boundary="===============3125141487422884739=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 5/7] Squash-to: "mptcp: Implement MPTCP receive
 path"
Date: Thu, 09 Jan 2020 17:41:36 +0100
Message-ID: <ae76dfbd78179883ddc1626a2de282fe1fef5c3d.1578586484.git.pabeni@redhat.com>
In-Reply-To: cover.1578586484.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3331

--===============3125141487422884739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

deal with fallback: we must reset sk callback to the TCP one.
Use the cached ptr in the old ctx.

RFC -> v1:
 - since mptcp_incoming_options() callers check for is_mptcp and
   the latter is always cleared on fallback, we can drop any additional
   check in mptcp_incoming_options()

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  |  4 ----
 net/mptcp/protocol.h | 15 ++++++++++++++-
 net/mptcp/subflow.c  | 19 ++++++++++++-------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9341c3269676..db224e050666 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -413,13 +413,9 @@ bool mptcp_synack_options(const struct request_sock *r=
eq, unsigned int *size,
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
 			    struct tcp_options_received *opt_rx)
 {
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_options_received *mp_opt;
 	struct mptcp_ext *mpext;
 =

-	if (!subflow->mp_capable)
-		return;
-
 	mp_opt =3D &opt_rx->mptcp;
 =

 	if (!mp_opt->dss)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e4fce9f0ad65..c6d8217e24d4 100644
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

@@ -159,6 +162,16 @@ bool mptcp_subflow_data_available(struct sock *sk);
 void mptcp_subflow_init(void);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

+static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
+					      struct mptcp_subflow_context *ctx)
+{
+	sk->sk_data_ready =3D ctx->tcp_data_ready;
+	sk->sk_state_change =3D ctx->tcp_state_change;
+	sk->sk_write_space =3D ctx->tcp_write_space;
+
+	inet_csk(sk)->icsk_af_ops =3D ctx->icsk_af_ops;
+}
+
 extern const struct inet_connection_sock_af_ops ipv4_specific;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 extern const struct inet_connection_sock_af_ops ipv6_specific;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4e00348ce54e..a1be17926248 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -507,7 +507,7 @@ static void subflow_data_ready(struct sock *sk)
 	struct sock *parent =3D subflow->conn;
 =

 	if (!parent || !subflow->mp_capable) {
-		subflow->tcp_sk_data_ready(sk);
+		subflow->tcp_data_ready(sk);
 =

 		if (parent)
 			parent->sk_data_ready(parent);
@@ -655,7 +655,9 @@ static int subflow_ulp_init(struct sock *sk)
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
@@ -676,10 +678,12 @@ static void subflow_ulp_release(struct sock *sk)
 	kfree_rcu(ctx, rcu);
 }
 =

-static void subflow_ulp_fallback(struct sock *sk)
+static void subflow_ulp_fallback(struct sock *sk,
+				 struct mptcp_subflow_context *old_ctx)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 =

+	mptcp_subflow_tcp_fallback(sk, old_ctx);
 	icsk->icsk_ulp_ops =3D NULL;
 	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
 	tcp_sk(sk)->is_mptcp =3D 0;
@@ -694,20 +698,21 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
 	struct mptcp_subflow_context *new_ctx;
 =

 	if (!subflow_req->mp_capable) {
-		subflow_ulp_fallback(newsk);
+		subflow_ulp_fallback(newsk, old_ctx);
 		return;
 	}
 =

 	new_ctx =3D subflow_create_ctx(newsk, priority);
 	if (new_ctx =3D=3D NULL) {
-		subflow_ulp_fallback(newsk);
+		subflow_ulp_fallback(newsk, old_ctx);
 		return;
 	}
 =

 	new_ctx->conn_finished =3D 1;
 	new_ctx->icsk_af_ops =3D old_ctx->icsk_af_ops;
-	new_ctx->tcp_sk_data_ready =3D old_ctx->tcp_sk_data_ready;
-
+	new_ctx->tcp_data_ready =3D old_ctx->tcp_data_ready;
+	new_ctx->tcp_state_change =3D old_ctx->tcp_state_change;
+	new_ctx->tcp_write_space =3D old_ctx->tcp_write_space;
 	new_ctx->mp_capable =3D 1;
 	new_ctx->fourth_ack =3D 1;
 	new_ctx->remote_key =3D subflow_req->remote_key;
-- =

2.21.0

--===============3125141487422884739==--

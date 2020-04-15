Content-Type: multipart/mixed; boundary="===============6415193611321920267=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 4/7] mptcp: avoid callback invocation when mptcp
 parent socket doesn't exist
Date: Wed, 15 Apr 2020 19:19:51 +0200
Message-ID: <20200415171954.15321-5-fw@strlen.de>
In-Reply-To: 20200415171954.15321-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4183

--===============6415193611321920267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We can crash with a NULL dereference in case a packet arrives on the new
socket before ctx->conn has been initialized.

When the new socket is cloned, it inherits the subflow callbacks
(sk_data_ready/state_change/write_space) from the listener socket.

To fix this, we either need to add ctx->conn =3D=3D NULL checks
in several places, or we need to reset the callbacks to the tcp
callbacks until ctx->conn is initialized.

Do the same on close: The parent MPTCP socket is not subject
to RCU freeing, so when ctx->conn reference is put, reset the sk
callbacks for the affected subflow to detach it from the mptcp
layer.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h | 10 ----------
 net/mptcp/subflow.c  | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 67448002a2d7..305e703e1fb3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -312,16 +312,6 @@ int __mptcp_subflow_connect(struct sock *sk, int ifind=
ex,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

-static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
-					      struct mptcp_subflow_context *ctx)
-{
-	sk->sk_data_ready =3D ctx->tcp_data_ready;
-	sk->sk_state_change =3D ctx->tcp_state_change;
-	sk->sk_write_space =3D ctx->tcp_write_space;
-
-	inet_csk(sk)->icsk_af_ops =3D ctx->icsk_af_ops;
-}
-
 extern const struct inet_connection_sock_af_ops ipv4_specific;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 extern const struct inet_connection_sock_af_ops ipv6_specific;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3a94f859347a..0bc1f5dd9999 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -22,6 +22,10 @@
 #include "protocol.h"
 #include "mib.h"
 =

+static void subflow_state_change(struct sock *sk);
+static void subflow_write_space(struct sock *sk);
+static void subflow_data_ready(struct sock *sk);
+
 static void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
 				  enum linux_mptcp_mib_field field)
 {
@@ -219,6 +223,29 @@ static bool subflow_thmac_valid(struct mptcp_subflow_c=
ontext *subflow)
 	return thmac =3D=3D subflow->thmac;
 }
 =

+static void mptcp_subflow_set_callbacks(struct sock *sk)
+{
+	smp_wmb();	/* callbacks rely on subflow->conn !=3D NULL */
+	sk->sk_data_ready =3D subflow_data_ready;
+	sk->sk_write_space =3D subflow_write_space;
+	sk->sk_state_change =3D subflow_state_change;
+}
+
+static void mptcp_subflow_reset_callbacks(struct sock *sk,
+					  const struct mptcp_subflow_context *ctx)
+{
+	sk->sk_data_ready =3D ctx->tcp_data_ready;
+	sk->sk_state_change =3D ctx->tcp_state_change;
+	sk->sk_write_space =3D ctx->tcp_write_space;
+}
+
+static void mptcp_subflow_tcp_fallback(struct sock *sk,
+				       const struct mptcp_subflow_context *ctx)
+{
+	mptcp_subflow_reset_callbacks(sk, ctx);
+	inet_csk(sk)->icsk_af_ops =3D ctx->icsk_af_ops;
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
@@ -454,6 +481,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			new_msk->sk_destruct =3D mptcp_sock_destruct;
 			mptcp_pm_new_connection(mptcp_sk(new_msk), 1);
 			ctx->conn =3D new_msk;
+			mptcp_subflow_set_callbacks(child);
 			new_msk =3D NULL;
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
@@ -463,6 +491,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 				goto close_child;
 =

 			ctx->conn =3D (struct sock *)owner;
+			mptcp_subflow_set_callbacks(child);
 			if (!mptcp_finish_join(child))
 				goto close_child;
 =

@@ -984,6 +1013,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struc=
t socket **new_sock)
 	*new_sock =3D sf;
 	sock_hold(sk);
 	subflow->conn =3D sk;
+	mptcp_subflow_set_callbacks(sf->sk);
 =

 	return 0;
 }
@@ -1074,9 +1104,6 @@ static int subflow_ulp_init(struct sock *sk)
 	ctx->tcp_data_ready =3D sk->sk_data_ready;
 	ctx->tcp_state_change =3D sk->sk_state_change;
 	ctx->tcp_write_space =3D sk->sk_write_space;
-	sk->sk_data_ready =3D subflow_data_ready;
-	sk->sk_write_space =3D subflow_write_space;
-	sk->sk_state_change =3D subflow_state_change;
 out:
 	return err;
 }
@@ -1088,6 +1115,7 @@ static void subflow_ulp_release(struct sock *sk)
 	if (!ctx)
 		return;
 =

+	mptcp_subflow_tcp_fallback(sk, ctx);
 	if (ctx->conn)
 		sock_put(ctx->conn);
 =

@@ -1125,6 +1153,9 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
 		return;
 	}
 =

+	/* don't call subflow callbacks before ctx->conn is set */
+	mptcp_subflow_reset_callbacks(newsk, old_ctx);
+
 	new_ctx->conn_finished =3D 1;
 	new_ctx->icsk_af_ops =3D old_ctx->icsk_af_ops;
 	new_ctx->tcp_data_ready =3D old_ctx->tcp_data_ready;
-- =

2.24.1

--===============6415193611321920267==--

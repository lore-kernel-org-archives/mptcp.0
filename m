Content-Type: multipart/mixed; boundary="===============4599497861303733274=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 5/9] mptcp: make msk established at remote
 key reception time
Date: Fri, 10 Jul 2020 19:22:14 +0200
Message-ID: <0e8f8cab00cf5d8f4b4513983933f7470cd7943f.1594401165.git.pabeni@redhat.com>
In-Reply-To: cover.1594401165.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4982

--===============4599497861303733274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently accepted msk sockets become established only after
accept() returns the new sk to user-space.

As MP_JOIN request are refused as per RFC spec on non
established socket, the above causes mp_join self-tests
instabilities.

This change make the msk entering the established status
as soon as it receives the peer's key. As that even
may happen in different places, factor out an helper to
handle remote key reception.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  |  4 +---
 net/mptcp/protocol.c |  1 -
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 19 +++++++++++++++----
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 19707c07efc1..018025ae9f36 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -724,9 +724,7 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 =

 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
-	subflow->fully_established =3D 1;
-	subflow->remote_key =3D mp_opt->sndr_key;
-	subflow->can_ack =3D 1;
+	mptcp_subflow_fully_established(subflow, mp_opt);
 =

 fully_established:
 	if (likely(subflow->pm_notified))
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 15358d676020..65d984f27fbb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1610,7 +1610,6 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		newsk =3D new_mptcp_sock;
 		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
-		inet_sk_state_store(newsk, TCP_ESTABLISHED);
 =

 		mptcp_rcv_space_init(msk, ssk);
 		bh_unlock_sock(new_mptcp_sock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e5baaef5ec89..08198b61b8a6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -342,6 +342,8 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow=
_context *subflow)
 }
 =

 int mptcp_is_enabled(struct net *net);
+void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
+				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0bdd57251da4..e79508655fa2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -387,6 +387,19 @@ static void subflow_drop_ctx(struct sock *ssk)
 	kfree_rcu(ctx, rcu);
 }
 =

+void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
+				     struct mptcp_options_received *mp_opt)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
+	subflow->remote_key =3D mp_opt->sndr_key;
+	subflow->fully_established =3D 1;
+	subflow->can_ack =3D 1;
+
+	inet_sk_state_store(subflow->conn, TCP_ESTABLISHED);
+	mptcp_pm_new_connection(msk, 1);
+}
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -470,7 +483,6 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			 * created mptcp socket
 			 */
 			new_msk->sk_destruct =3D mptcp_sock_destruct;
-			mptcp_pm_new_connection(mptcp_sk(new_msk), 1);
 			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
 			ctx->conn =3D new_msk;
 			new_msk =3D NULL;
@@ -478,9 +490,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			/* with OoO packets we can reach here without ingress
 			 * mpc option
 			 */
-			ctx->remote_key =3D mp_opt.sndr_key;
-			ctx->fully_established =3D mp_opt.mp_capable;
-			ctx->can_ack =3D mp_opt.mp_capable;
+			if (mp_opt.mp_capable)
+				mptcp_subflow_fully_established(ctx, &mp_opt);
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
 =

-- =

2.26.2

--===============4599497861303733274==--

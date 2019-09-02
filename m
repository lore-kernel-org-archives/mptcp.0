Content-Type: multipart/mixed; boundary="===============2700447603226937140=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC] net/mptcp: rcu-ify the subflow context
Date: Mon, 02 Sep 2019 17:24:39 +0200
Message-ID: <424f2707dffedc2a74abfb5d15bc0a1f6f01e477.1567437714.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1785

--===============2700447603226937140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

make sure to wait a grace period before freeing the subflow context. See
also net-next commit 72f21c741e86 ("net/tls: use RCU protection on
icsk->icsk_ulp_data")

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---

Notes:
    proposal: we can squash this in
    =

    commit d636603cad37 ("mptcp: Implement MPTCP receive path")
    =

    and the last hunk can go into
    =

    commit 0e0b608d46c5 ("mptcp: Associate MPTCP context with TCP socket")

 net/mptcp/protocol.h |  5 +++--
 net/mptcp/subflow.c  | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 991ad288b892..b201e1410219 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -197,13 +197,14 @@ struct subflow_context {
 	struct  sock *conn;        /* parent mptcp_sock */
 =

 	void	(*tcp_sk_data_ready)(struct sock *sk);
+	struct	rcu_head rcu;
 };
 =

 static inline struct subflow_context *subflow_ctx(const struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
-
-	return (struct subflow_context *)icsk->icsk_ulp_data;
+	/* Use RCU on icsk_ulp_data only for sock diag code */
+	return (__force struct subflow_context *)icsk->icsk_ulp_data;
 }
 =

 static inline struct socket *
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 327ee987861b..fb209dd44070 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -302,10 +302,9 @@ static struct subflow_context *subflow_create_ctx(stru=
ct sock *sk,
 	struct subflow_context *ctx;
 =

 	ctx =3D kzalloc(sizeof(*ctx), priority);
-	icsk->icsk_ulp_data =3D ctx;
-
 	if (!ctx)
 		return NULL;
+	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 =

 	pr_debug("subflow=3D%p", ctx);
 =

@@ -345,9 +344,10 @@ static void subflow_ulp_release(struct sock *sk)
 =

 	pr_debug("subflow=3D%p", ctx);
 =

+	if (!ctx)
+		return;
 	token_release(ctx->token);
-
-	kfree(ctx);
+	kfree_rcu(ctx, rcu);
 }
 =

 static void subflow_ulp_clone(const struct request_sock *req,
@@ -358,7 +358,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	struct subflow_context *old_ctx;
 	struct subflow_context *new_ctx;
 =

-	old_ctx =3D inet_csk(newsk)->icsk_ulp_data;
+	old_ctx =3D subflow_ctx(newsk);
 =

 	/* newsk->sk_socket is NULL at this point */
 	new_ctx =3D subflow_create_ctx(newsk, NULL, priority);
-- =

2.20.1


--===============2700447603226937140==--

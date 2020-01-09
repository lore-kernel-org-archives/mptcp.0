Content-Type: multipart/mixed; boundary="===============9196824429376663977=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/7] Squash-to: "mptcp: Handle MP_CAPABLE options
 for outgoing connections"
Date: Thu, 09 Jan 2020 17:41:32 +0100
Message-ID: <3483a572e27be85e6191ebf443e18e4017c404bc.1578586484.git.pabeni@redhat.com>
In-Reply-To: cover.1578586484.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3326

--===============9196824429376663977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After upstream feedback, I just noticed that we actually
don't clear the is_mptcp field on clone allocation failure.

Do that and additionally don't allocate at all the subflow if MPC handshake
failed.

Note: we need to update accordingly accept on later patch

v1  -> v2:
 - use sk_is_mptcp() in __mptcp_tcp_fallback() (Mat)

RFC -> v1:
 - avoid assign statement inside the if statement (Florian)
 - avoid rendundant  conn =3D NULL  (Mat)
 - clear ulp data on fallback, or to avoid double free at close
   time

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c |  2 +-
 net/mptcp/subflow.c  | 33 +++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8bb3ecf87ee5..9120f75659b5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -42,7 +42,7 @@ static struct socket *__mptcp_tcp_fallback(const struct m=
ptcp_sock *msk)
 =

 	sock_owned_by_me((const struct sock *)msk);
 =

-	if (!ssock || tcp_sk(ssock->sk)->is_mptcp)
+	if (!ssock || sk_is_mptcp(ssock->sk))
 		return NULL;
 =

 	return ssock;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b9aca17b0b91..cf4c05a6cfac 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -254,6 +254,15 @@ static void subflow_ulp_release(struct sock *sk)
 	kfree_rcu(ctx, rcu);
 }
 =

+static void subflow_ulp_fallback(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	icsk->icsk_ulp_ops =3D NULL;
+	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
+	tcp_sk(sk)->is_mptcp =3D 0;
+}
+
 static void subflow_ulp_clone(const struct request_sock *req,
 			      struct sock *newsk,
 			      const gfp_t priority)
@@ -262,23 +271,23 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
 	struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
 	struct mptcp_subflow_context *new_ctx;
 =

-	/* newsk->sk_socket is NULL at this point */
+	if (!subflow_req->mp_capable) {
+		subflow_ulp_fallback(newsk);
+		return;
+	}
+
 	new_ctx =3D subflow_create_ctx(newsk, priority);
-	if (!new_ctx)
+	if (new_ctx =3D=3D NULL) {
+		subflow_ulp_fallback(newsk);
 		return;
+	}
 =

-	new_ctx->conn =3D NULL;
 	new_ctx->conn_finished =3D 1;
 	new_ctx->icsk_af_ops =3D old_ctx->icsk_af_ops;
-
-	if (subflow_req->mp_capable) {
-		new_ctx->mp_capable =3D 1;
-		new_ctx->fourth_ack =3D 1;
-		new_ctx->remote_key =3D subflow_req->remote_key;
-		new_ctx->local_key =3D subflow_req->local_key;
-	} else {
-		tcp_sk(newsk)->is_mptcp =3D 0;
-	}
+	new_ctx->mp_capable =3D 1;
+	new_ctx->fourth_ack =3D 1;
+	new_ctx->remote_key =3D subflow_req->remote_key;
+	new_ctx->local_key =3D subflow_req->local_key;
 }
 =

 static struct tcp_ulp_ops subflow_ulp_ops __read_mostly =3D {
-- =

2.21.0

--===============9196824429376663977==--

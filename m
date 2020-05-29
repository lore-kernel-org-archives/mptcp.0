Content-Type: multipart/mixed; boundary="===============2891064621128978958=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: fix NULL ptr dereference in MP_JOIN
 error path
Date: Fri, 29 May 2020 17:49:18 +0200
Message-ID: <1fc1fd4512e4709d1fbeb7f008f38b273ee1d798.1590767183.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4556

--===============2891064621128978958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When token lookup on MP_JOIN 3rd ack fails, the server
socket closes with a reset the incoming child. Such socket
has the 'is_mptcp' flag set, but no msk socket associated
- due to the failed lookup.

While crafting the reset packet mptcp_established_options_mp()
will try to dereference the child's master socket, causing
a NULL ptr dereference.

This change addresses the issue with explicit fallback to
TCP in such error path.

Fixes: 729cd6436f35 ("mptcp: cope better with MP_JOIN failure")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f3c06b8af92d..493b98a0825c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -413,6 +413,20 @@ static void subflow_ulp_fallback(struct sock *sk,
 	tcp_sk(sk)->is_mptcp =3D 0;
 }
 =

+static void subflow_drop_ctx(struct sock *ssk)
+{
+	struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(ssk);
+
+	if (!ctx)
+		return;
+
+	subflow_ulp_fallback(ssk, ctx);
+	if (ctx->conn)
+		sock_put(ctx->conn);
+
+	kfree_rcu(ctx, rcu);
+}
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -485,10 +499,7 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 			if (fallback_is_fatal)
 				goto dispose_child;
 =

-			if (ctx) {
-				subflow_ulp_fallback(child, ctx);
-				kfree_rcu(ctx, rcu);
-			}
+			subflow_drop_ctx(child);
 			goto out;
 		}
 =

@@ -537,6 +548,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	return child;
 =

 dispose_child:
+	subflow_drop_ctx(child);
 	tcp_rsk(req)->drop_req =3D true;
 	tcp_send_active_reset(child, GFP_ATOMIC);
 	inet_csk_prepare_for_destroy_sock(child);
-- =

2.21.3

--===============2891064621128978958==--

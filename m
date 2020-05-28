Content-Type: multipart/mixed; boundary="===============8506431056604225990=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2] mptcp: fix NULL ptr dereference in MP_JOIN
 error path
Date: Thu, 28 May 2020 20:07:35 +0200
Message-ID: <b53d426cb3a43f7c545613b89d149c481ec78198.1590689211.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4545

--===============8506431056604225990==
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

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - dropped unneeded dbg messages
---
 net/mptcp/subflow.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0a01b6e8f2dc..5b06a5910aeb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -413,6 +413,17 @@ static void subflow_ulp_fallback(struct sock *sk,
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
+	kfree_rcu(ctx, rcu);
+}
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -485,10 +496,7 @@ static struct sock *subflow_syn_recv_sock(const struct=
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

@@ -537,6 +545,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
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

--===============8506431056604225990==--

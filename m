Content-Type: multipart/mixed; boundary="===============7926796246523030672=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix NULL ptr dereference in MP_JOIN error
 path
Date: Thu, 28 May 2020 15:27:02 +0200
Message-ID: <bcf99550bcfc085b29dad256455a9bc0a92798df.1590672384.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4525

--===============7926796246523030672==
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
 net/mptcp/subflow.c | 17 +++++++++++++----
 net/mptcp/token.c   | 10 +++++++---
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ae7bcdb7f990..55fced4f136d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -408,6 +408,17 @@ static void subflow_ulp_fallback(struct sock *sk,
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
@@ -480,10 +491,7 @@ static struct sock *subflow_syn_recv_sock(const struct=
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

@@ -532,6 +540,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	return child;
 =

 dispose_child:
+	subflow_drop_ctx(child);
 	tcp_rsk(req)->drop_req =3D true;
 	tcp_send_active_reset(child, GFP_ATOMIC);
 	inet_csk_prepare_for_destroy_sock(child);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index c0327ff5d1b7..d1068b51a45a 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -216,16 +216,20 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 		msk =3D mptcp_sk(sk);
 		if (READ_ONCE(msk->token) !=3D token)
 			continue;
-		if (!refcount_inc_not_zero(&sk->sk_refcnt))
+		if (!refcount_inc_not_zero(&sk->sk_refcnt)) {
+			pr_warn("token match %x but 0 rfcnt\n", token);
 			goto not_found;
-		if (READ_ONCE(msk->token) !=3D token) {
+		} if (READ_ONCE(msk->token) !=3D token) {
+			pr_warn("token mis-match %x:%x after get\n", READ_ONCE(msk->token), tok=
en);
 			sock_put(sk);
 			goto again;
 		}
 		goto found;
 	}
-	if (get_nulls_value(pos) !=3D (token & token_mask))
+	if (get_nulls_value(pos) !=3D (token & token_mask)) {
+		pr_warn("moved nulls %ld id %d\n", get_nulls_value(pos), token & token_m=
ask);
 		goto again;
+	}
 =

 not_found:
 	msk =3D NULL;
-- =

2.21.3

--===============7926796246523030672==--

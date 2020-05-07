Content-Type: multipart/mixed; boundary="===============7966041763773122099=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/2] mptcp: cope better with MP_JOIN failure
Date: Thu, 07 May 2020 16:30:24 +0200
Message-ID: <e435796acd5a522704419b5fe92a11d2eab4c322.1588861016.git.pabeni@redhat.com>
In-Reply-To: cover.1588861016.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4339

--===============7966041763773122099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, on MP_JOIN failure we reset the child
socket, but leave the request socket untouched.

tcp_check_req will deal with it according to the
'tcp_abort_on_overflow' sysctl value - by default the
req socket will stay alive.

The above leads to inconsistent behavior on MP JOIN
failure, and bad listener overflow accounting.

This patch addresses the issue leveraging the infrastructure
just introduced to ask the TCP stack to drop the req on
failure.

The child socket is not freed anymore by subflow_syn_recv_sock(),
instead it's moved to a dead state and will be disposed by the
next sock_put done by the TCP stack, so that listener overflow
accounting is not affected by MP JOIN failure.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0d735e5aeb0d..391e50a26d76 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -476,7 +476,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 		 */
 		if (!ctx || fallback) {
 			if (fallback_is_fatal)
-				goto close_child;
+				goto dispose_child;
 =

 			if (ctx) {
 				subflow_ulp_fallback(child, ctx);
@@ -506,11 +506,11 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 =

 			owner =3D mptcp_token_get_sock(ctx->token);
 			if (!owner)
-				goto close_child;
+				goto dispose_child;
 =

 			ctx->conn =3D (struct sock *)owner;
 			if (!mptcp_finish_join(child))
-				goto close_child;
+				goto dispose_child;
 =

 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 			tcp_sk(child)->drop_req =3D true;
@@ -530,11 +530,16 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 		      !mptcp_subflow_ctx(child)->conn));
 	return child;
 =

-close_child:
+dispose_child:
+	tcp_sk(child)->drop_req =3D true;
 	tcp_send_active_reset(child, GFP_ATOMIC);
-	inet_csk_prepare_forced_close(child);
+	sock_set_flag(child, SOCK_DEAD);
+	percpu_counter_inc(sk->sk_prot->orphan_count);
+	inet_sk(child)->inet_num =3D 0;
 	tcp_done(child);
-	return NULL;
+
+	/* The last reference will be released by child_process */
+	return child;
 }
 =

 static struct inet_connection_sock_af_ops subflow_specific;
-- =

2.21.1

--===============7966041763773122099==--

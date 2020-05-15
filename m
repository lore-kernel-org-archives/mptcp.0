Content-Type: multipart/mixed; boundary="===============3795237305283813271=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 3/3] mptcp: cope better with MP_JOIN
 failure
Date: Fri, 15 May 2020 19:22:17 +0200
Message-ID: <4dc2d07bafebc2dde162fe1dc1c25f0c4cb602e1.1589558049.git.pabeni@redhat.com>
In-Reply-To: cover.1589558049.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4396

--===============3795237305283813271==
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

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Reviewed-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/subflow.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5e03ed8ae899..3cf2eeea9d80 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -478,7 +478,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 		 */
 		if (!ctx || fallback) {
 			if (fallback_is_fatal)
-				goto close_child;
+				goto dispose_child;
 =

 			if (ctx) {
 				subflow_ulp_fallback(child, ctx);
@@ -507,11 +507,11 @@ static struct sock *subflow_syn_recv_sock(const struc=
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
 			tcp_rsk(req)->drop_req =3D true;
@@ -531,11 +531,14 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 		      !mptcp_subflow_ctx(child)->conn));
 	return child;
 =

-close_child:
+dispose_child:
+	tcp_rsk(req)->drop_req =3D true;
 	tcp_send_active_reset(child, GFP_ATOMIC);
-	inet_csk_prepare_forced_close(child);
+	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	return NULL;
+
+	/* The last child reference will be released by the caller */
+	return child;
 }
 =

 static struct inet_connection_sock_af_ops subflow_specific;
-- =

2.21.3

--===============3795237305283813271==--

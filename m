Content-Type: multipart/mixed; boundary="===============4971972872509947297=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 7/7] Squash-to: "mptcp: Add handling of incoming
 MP_JOIN requests"
Date: Thu, 09 Jan 2020 17:41:38 +0100
Message-ID: <b0dc34126d7db4ffada2db09ec8fdd6e945be394.1578586485.git.pabeni@redhat.com>
In-Reply-To: cover.1578586484.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3333

--===============4971972872509947297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ensure fallback is fatal for MP_JOIN, copying with
changes introduced by previous squash-to patches

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4e846b4e0b81..49d430479124 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -256,6 +256,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct tcp_options_received opt_rx;
+	bool fallback_is_fatal =3D false;
 	struct sock *child;
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
@@ -280,6 +281,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			subflow_req->mp_capable =3D 0;
 		}
 	} else if (subflow_req->mp_join) {
+		fallback_is_fatal =3D true;
 		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
 		if (!opt_rx.mptcp.mp_join ||
@@ -294,11 +296,14 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 	if (child && *own_req) {
 		struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(child);
 =

-		/* we have null ctx on TCP fallback, not fatal on MPC
-		 * handshake
+		/* we have null ctx on TCP fallback, which is fatal on
+		 * MPJ handshake
 		 */
-		if (!ctx)
+		if (!ctx) {
+			if (fallback_is_fatal)
+				goto close_child;
 			return child;
+		}
 =

 		if (ctx->mp_capable) {
 			if (mptcp_token_new_accept(ctx->token))
-- =

2.21.0

--===============4971972872509947297==--

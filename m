Content-Type: multipart/mixed; boundary="===============3034220752623399910=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/4] mptcp: init new_ctx->icsk_af_ops() in
 subflow_ulp_clone()
Date: Mon, 11 Nov 2019 12:29:01 +0100
Message-ID: <7b21ca56785decb50da4b6432009bf039add80fb.1573471458.git.pabeni@redhat.com>
In-Reply-To: cover.1573471403.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2462

--===============3034220752623399910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently inited in "mptcp: Add key generation and token tree",
causing transient build failure, move here for consistency
and fix build issue

Squash-to: "mptcp: Create SUBFLOW socket for incoming connections"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5c0594d09cc5..869010587df4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -212,6 +212,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 			      const gfp_t priority)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
+	struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
 	struct mptcp_subflow_context *new_ctx;
 =

 	/* newsk->sk_socket is NULL at this point */
@@ -221,6 +222,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 =

 	new_ctx->conn =3D NULL;
 	new_ctx->conn_finished =3D 1;
+	new_ctx->icsk_af_ops =3D old_ctx->icsk_af_ops;
 =

 	if (subflow_req->mp_capable) {
 		new_ctx->mp_capable =3D 1;
-- =

2.21.0

--===============3034220752623399910==--

Content-Type: multipart/mixed; boundary="===============6202253329104798435=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 1/4] mptcp: clear 'is_tcp' socket flag when the
 MP_CAPABLE handshake fails
Date: Tue, 10 Dec 2019 00:52:07 +0100
Message-ID: <8ff10214eb760d9ce40bba774eea93ef0318441c.1575934525.git.pabeni@redhat.com>
In-Reply-To: cover.1575934525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2849

--===============6202253329104798435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we don't have a single flag for 'mp capable handshake
failed', but we can clear the is_tcp flag to record such info.

This will make also processing for fallback socket almost as fast
as native ones, and will help cleaning 'fallback' fields usage
in later patches.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 3 +++
 net/mptcp/subflow.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bce5b6ad2829..9ed86e2187d5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -306,6 +306,8 @@ void mptcp_rcv_synsent(struct sock *sk)
 		subflow->mp_capable =3D 1;
 		subflow->can_ack =3D 1;
 		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
+	} else {
+		tcp_sk(sk)->is_mptcp =3D 0;
 	}
 }
 =

@@ -508,6 +510,7 @@ static bool check_fourth_ack(struct mptcp_subflow_conte=
xt *subflow,
 	 */
 	if (!mp_opt->mp_capable) {
 		subflow->mp_capable =3D 0;
+		tcp_sk(mptcp_subflow_tcp_sock(subflow))->is_mptcp =3D 0;
 		return false;
 	}
 	subflow->remote_key =3D mp_opt->sndr_key;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e276c9cbf0e8..3726fce5868a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -733,6 +733,8 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 		new_ctx->token =3D subflow_req->token;
 		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
 		new_ctx->idsn =3D subflow_req->idsn;
+	} else {
+		tcp_sk(newsk)->is_mptcp =3D 0;
 	}
 }
 =

-- =

2.21.0

--===============6202253329104798435==--

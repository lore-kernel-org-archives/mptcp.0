Content-Type: multipart/mixed; boundary="===============2919146962548524306=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/4] mptcp: use customary name for tcp_sock variable
Date: Mon, 11 Nov 2019 12:28:59 +0100
Message-ID: <11ddd259a602f020805abbc12ed400c22f69fed0.1573471424.git.pabeni@redhat.com>
In-Reply-To: cover.1573471403.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2460

--===============2919146962548524306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The variable is currently renamed in later patch
"mptcp: Handle MP_CAPABLE options for outgoing connections",
let's do it here instead

Squash-to: mptcp: Associate MPTCP context with TCP socket
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c1800f94437d..29d4d1cb284e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -63,8 +63,8 @@ static struct mptcp_subflow_context *subflow_create_ctx(s=
truct sock *sk,
 =

 static int subflow_ulp_init(struct sock *sk)
 {
-	struct tcp_sock *tsk =3D tcp_sk(sk);
 	struct mptcp_subflow_context *ctx;
+	struct tcp_sock *tp =3D tcp_sk(sk);
 	int err =3D 0;
 =

 	/* disallow attaching ULP to a socket unless it has been
@@ -83,7 +83,7 @@ static int subflow_ulp_init(struct sock *sk)
 =

 	pr_debug("subflow=3D%p", ctx);
 =

-	tsk->is_mptcp =3D 1;
+	tp->is_mptcp =3D 1;
 out:
 	return err;
 }
-- =

2.21.0

--===============2919146962548524306==--

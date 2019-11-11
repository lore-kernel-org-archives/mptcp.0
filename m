Content-Type: multipart/mixed; boundary="===============1780386579792086692=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/4] mptcp: init ctx->icsk_af_ops in subflow_ulp_init()
Date: Mon, 11 Nov 2019 12:29:00 +0100
Message-ID: <ffcc774eaf1f11ce57bbee484bed6d8116dc8585.1573471449.git.pabeni@redhat.com>
In-Reply-To: cover.1573471403.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2461

--===============1780386579792086692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently inited in "mptcp: Add key generation and token tree", better
move initializiation here, where we already init icsk->icsk_af_ops

Squash-to: "mptcp: Handle MP_CAPABLE options for outgoing connections"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 10ec2bcb9807..de10f7f9740c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -101,6 +101,7 @@ static int subflow_ulp_init(struct sock *sk)
 	pr_debug("subflow=3D%p", ctx);
 =

 	tp->is_mptcp =3D 1;
+	ctx->icsk_af_ops =3D icsk->icsk_af_ops;
 	icsk->icsk_af_ops =3D &subflow_specific;
 out:
 	return err;
-- =

2.21.0

--===============1780386579792086692==--

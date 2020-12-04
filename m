Content-Type: multipart/mixed; boundary="===============3347787998145125615=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: plug subflow context memory leak
Date: Fri, 04 Dec 2020 12:37:04 +0100
Message-ID: <8d57c51a359d2c3867b7a6712af4d431167ecb92.1607081800.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7046

--===============3347787998145125615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a MPTCP listener socket is closed with unaccepted
children pending, the ULP release callback will be invoked,
but nobody will call into __mptcp_close_ssk() on the
corresponding subflow.

As a consequence, at ULP release time, the 'disposable' flag
will be cleared and the subflow context memory will be leaked.

This change addresses the issue always freeing the context if
the subflow is still in the accept queue at ULP release time.

Additionally, this fixes an incorrect code reference in the
related comment.

Note: this fix leverages the changes introduced by the previous
commit.

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Note: I plan to push this upstream together with:

mptcp: link MPC subflow into msk only after accept

since this depends on the above changes, as note in the commit
message.

This closes for me at one of the splat reported in issues/108.
I could not reproduce the others. @Christoph could you please
give it a spin?
---
 net/mptcp/subflow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fe3bc73aa39d..2e111f039ecc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1334,9 +1334,10 @@ static void subflow_ulp_release(struct sock *ssk)
 	sk =3D ctx->conn;
 	if (sk) {
 		/* if the msk has been orphaned, keep the ctx
-		 * alive, will be freed by mptcp_done()
+		 * alive, will be freed by __mptcp_close_ssk(),
+		 * when the subflow is still unaccepted
 		 */
-		release =3D ctx->disposable;
+		release =3D ctx->disposable || list_empty(&ctx->node);
 		sock_put(sk);
 	}
 =

-- =

2.26.2

--===============3347787998145125615==--

Content-Type: multipart/mixed; boundary="===============8418683535465511335=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/3] mptcp: plug subflow context memory leak
Date: Wed, 09 Dec 2020 12:03:30 +0100
Message-ID: <ab23e78a6e23b159b7ae3a21b3cdae39f836a092.1607508810.git.pabeni@redhat.com>
In-Reply-To: cover.1607508810.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7098

--===============8418683535465511335==
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
Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9b5a966b0041..fefcaf497938 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1339,9 +1339,10 @@ static void subflow_ulp_release(struct sock *ssk)
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

--===============8418683535465511335==--

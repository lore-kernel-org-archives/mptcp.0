Content-Type: multipart/mixed; boundary="===============6488715968494909438=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix uninitialized value access
Date: Wed, 29 Apr 2020 12:50:37 +0200
Message-ID: <c2b96b3751ccf64357d2c6f0e7d23908dda8a601.1588157274.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4272

--===============6488715968494909438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tcp_v{4,6}_syn_recv_sock() set 'own_req' only when returning
a not NULL 'child', let's check 'own_req' only if child is
available to avoid an - unharmful - UBSAN splat.

Fixes: 20882e2cb904 ("mptcp: avoid flipping mp_capable field in syn_recv_so=
ck()")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f412e886aa9b..2fa319a36ea5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -522,7 +522,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	/* check for expected invariant - should never trigger, just help
 	 * catching eariler subtle bugs
 	 */
-	WARN_ON_ONCE(*own_req && child && tcp_sk(child)->is_mptcp &&
+	WARN_ON_ONCE(child && *own_req && tcp_sk(child)->is_mptcp &&
 		     (!mptcp_subflow_ctx(child) ||
 		      !mptcp_subflow_ctx(child)->conn));
 	return child;
-- =

2.21.1

--===============6488715968494909438==--

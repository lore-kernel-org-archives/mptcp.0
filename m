Content-Type: multipart/mixed; boundary="===============0728753104516720280=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2] mptcp: fix uninitialized value access
Date: Thu, 30 Apr 2020 15:03:22 +0200
Message-ID: <a94e83fdb29c9c3cdd971e3f57c434efa757c750.1588243772.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4289

--===============0728753104516720280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tcp_v{4,6}_syn_recv_sock() set 'own_req' only when returning
a not NULL 'child', let's check 'own_req' only if child is
available to avoid an - unharmful - UBSAN splat.

v1 -> v2:
 - reference the correct hash

Fixes: 4c8941de781c ("mptcp: avoid flipping mp_capable field in syn_recv_so=
ck()")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bad998529767..67a4e35d4838 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -523,7 +523,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
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

--===============0728753104516720280==--

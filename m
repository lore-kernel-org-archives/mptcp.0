Content-Type: multipart/mixed; boundary="===============0031272941181728510=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 2/7] Squash-to "mptcp: Create SUBFLOW socket for
 incoming connection"
Date: Wed, 08 Jan 2020 15:47:19 +0100
Message-ID: <8f259f1edea2ab7f21d53037d89b9f34ffe572cf.1578487811.git.pabeni@redhat.com>
In-Reply-To: cover.1578487811.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3291

--===============0031272941181728510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

use is_mptcp instead of 'subflow->mp_capable'
---
 net/mptcp/protocol.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 70e28cc0dbe0..283e7dc2d25e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -243,7 +243,6 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 				 bool kern)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct mptcp_subflow_context *subflow;
 	struct socket *listener;
 	struct sock *newsk;
 =

@@ -258,13 +257,14 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 	if (!newsk)
 		return NULL;
 =

-	subflow =3D mptcp_subflow_ctx(newsk);
-	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);
+	pr_debug("msk=3D%p, subflow is mptcp=3D%d", msk, tcp_sk(newsk)->is_mptcp);
 =

-	if (subflow->mp_capable) {
+	if (tcp_sk(newsk)->is_mptcp) {
+		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
 		struct sock *ssk =3D newsk;
 =

+		subflow =3D mptcp_subflow_ctx(newsk);
 		lock_sock(sk);
 =

 		local_bh_disable();
@@ -295,8 +295,6 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		bh_unlock_sock(new_mptcp_sock);
 		local_bh_enable();
 		release_sock(sk);
-	} else {
-		tcp_sk(newsk)->is_mptcp =3D 0;
 	}
 =

 	return newsk;
-- =

2.21.0

--===============0031272941181728510==--

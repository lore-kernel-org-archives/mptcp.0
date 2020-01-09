Content-Type: multipart/mixed; boundary="===============3687153703966691524=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/7] Squash-to "mptcp: Create SUBFLOW socket for
 incoming connection"
Date: Thu, 09 Jan 2020 17:41:33 +0100
Message-ID: <e58b54701e1d9798587db71eba1eeed6de5f77d6.1578586484.git.pabeni@redhat.com>
In-Reply-To: cover.1578586484.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3329

--===============3687153703966691524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

use is_mptcp instead of 'subflow->mp_capable'

v1 -> v2:
 - use sk_is_mptcp() in mptcp_accept() - Mat
---
 net/mptcp/protocol.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 88bfa4fedde5..ec792dbe0a5b 100644
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
+	pr_debug("msk=3D%p, subflow is mptcp=3D%d", msk, sk_is_mptcp(newsk));
 =

-	if (subflow->mp_capable) {
+	if (sk_is_mptcp(newsk)) {
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

--===============3687153703966691524==--

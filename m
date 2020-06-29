Content-Type: multipart/mixed; boundary="===============3860482179422058478=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 5/6] mptcp: __mptcp_tcp_fallback() returns a
 struct sock
Date: Mon, 29 Jun 2020 22:26:24 +0200
Message-ID: <f4474c22d50669fa3702224677fd2c2541b83ca9.1593461586.git.dcaratti@redhat.com>
In-Reply-To: cover.1593461586.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4851

--===============3860482179422058478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Currently __mptcp_tcp_fallback() always return NULL
on incoming connections, because MPTCP does not create
the additional socket for the first subflow.
Since the previous commit no __mptcp_tcp_fallback()
caller needs a struct socket, so let __mptcp_tcp_fallback()
return the first subflow sock and cope correctly even with
incoming connections.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/protocol.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ad619bda71cc..f2b2bd37e371 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -76,14 +76,14 @@ static bool mptcp_is_tcpsk(struct sock *sk)
 	return false;
 }
 =

-static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
+static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
 	sock_owned_by_me((const struct sock *)msk);
 =

 	if (likely(!__mptcp_check_fallback(msk)))
 		return NULL;
 =

-	return msk->subflow;
+	return msk->first;
 }
 =

 static int __mptcp_socket_create(struct mptcp_sock *msk)
@@ -1498,7 +1498,7 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 			    char __user *optval, unsigned int optlen)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *ssock;
+	struct sock *ssk;
 =

 	pr_debug("msk=3D%p", msk);
 =

@@ -1509,11 +1509,10 @@ static int mptcp_setsockopt(struct sock *sk, int le=
vel, int optname,
 	 * to the one remaining subflow.
 	 */
 	lock_sock(sk);
-	ssock =3D __mptcp_tcp_fallback(msk);
+	ssk =3D __mptcp_tcp_fallback(msk);
 	release_sock(sk);
-	if (ssock)
-		return tcp_setsockopt(ssock->sk, level, optname, optval,
-				      optlen);
+	if (ssk)
+		return tcp_setsockopt(ssk, level, optname, optval, optlen);
 =

 	return -EOPNOTSUPP;
 }
@@ -1522,7 +1521,7 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 			    char __user *optval, int __user *option)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *ssock;
+	struct sock *ssk;
 =

 	pr_debug("msk=3D%p", msk);
 =

@@ -1533,11 +1532,10 @@ static int mptcp_getsockopt(struct sock *sk, int le=
vel, int optname,
 	 * to the one remaining subflow.
 	 */
 	lock_sock(sk);
-	ssock =3D __mptcp_tcp_fallback(msk);
+	ssk =3D __mptcp_tcp_fallback(msk);
 	release_sock(sk);
-	if (ssock)
-		return tcp_getsockopt(ssock->sk, level, optname, optval,
-				      option);
+	if (ssk)
+		return tcp_getsockopt(ssk, level, optname, optval, option);
 =

 	return -EOPNOTSUPP;
 }
-- =

2.26.2

--===============3860482179422058478==--

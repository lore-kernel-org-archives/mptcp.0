Content-Type: multipart/mixed; boundary="===============8142624505775166675=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/4] mptcp: __mptcp_tcp_fallback() returns a struct
 sock
Date: Thu, 18 Jun 2020 12:55:21 +0200
Message-ID: <e277c0701c79bc5467f1ce9fbf9bcb1755fb3800.1592477699.git.pabeni@redhat.com>
In-Reply-To: cover.1592477699.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4730

--===============8142624505775166675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently __mptcp_tcp_fallback() always return NULL
on passive sockets. Callers don't need anymore a
struct socket, so let __mptcp_tcp_fallback return
the first subflow sock and cope correctly even
with passive sockets.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 75a96d8665e9..fb1f78ef3213 100644
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
@@ -1605,7 +1605,7 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 			    char __user *optval, unsigned int optlen)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *ssock;
+	struct sock *ssk;
 =

 	pr_debug("msk=3D%p", msk);
 =

@@ -1616,11 +1616,10 @@ static int mptcp_setsockopt(struct sock *sk, int le=
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
@@ -1629,7 +1628,7 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 			    char __user *optval, int __user *option)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *ssock;
+	struct sock *ssk;
 =

 	pr_debug("msk=3D%p", msk);
 =

@@ -1640,11 +1639,10 @@ static int mptcp_getsockopt(struct sock *sk, int le=
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

--===============8142624505775166675==--

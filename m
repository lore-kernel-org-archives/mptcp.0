Content-Type: multipart/mixed; boundary="===============2243587956042745315=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: check for plain TCP sock at accept time
Date: Tue, 16 Jun 2020 18:41:58 +0200
Message-ID: <3b0e33f9306a9eb6415c5cb5b30a21f6d686b7bb.1592325256.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4706

--===============2243587956042745315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This cleanup the code a bit and avoid corrupted states
on weird syscall sequence (accept(), connect()).

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 61 +++-----------------------------------------
 1 file changed, 3 insertions(+), 58 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index faa804f63c81..590009a2591a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -56,9 +56,6 @@ static struct socket *mptcp_is_tcpsk(struct sock *sk)
 {
 	struct socket *sock =3D sk->sk_socket;
 =

-	if (sock->sk !=3D sk)
-		return NULL;
-
 	if (unlikely(sk->sk_prot =3D=3D &tcp_prot)) {
 		/* we are being invoked after mptcp_accept() has
 		 * accepted a non-mp-capable flow: sk is a tcp_sk,
@@ -81,14 +78,8 @@ static struct socket *mptcp_is_tcpsk(struct sock *sk)
 =

 static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
-	struct socket *sock;
-
 	sock_owned_by_me((const struct sock *)msk);
 =

-	sock =3D mptcp_is_tcpsk((struct sock *)msk);
-	if (unlikely(sock))
-		return sock;
-
 	if (likely(!__mptcp_check_fallback(msk)))
 		return NULL;
 =

@@ -1574,7 +1565,6 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		return NULL;
 =

 	pr_debug("msk=3D%p, subflow is mptcp=3D%d", msk, sk_is_mptcp(newsk));
-
 	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
@@ -1932,42 +1922,6 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
 	return err;
 }
 =

-static int mptcp_v4_getname(struct socket *sock, struct sockaddr *uaddr,
-			    int peer)
-{
-	if (sock->sk->sk_prot =3D=3D &tcp_prot) {
-		/* we are being invoked from __sys_accept4, after
-		 * mptcp_accept() has just accepted a non-mp-capable
-		 * flow: sk is a tcp_sk, not an mptcp one.
-		 *
-		 * Hand the socket over to tcp so all further socket ops
-		 * bypass mptcp.
-		 */
-		sock->ops =3D &inet_stream_ops;
-	}
-
-	return inet_getname(sock, uaddr, peer);
-}
-
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-static int mptcp_v6_getname(struct socket *sock, struct sockaddr *uaddr,
-			    int peer)
-{
-	if (sock->sk->sk_prot =3D=3D &tcpv6_prot) {
-		/* we are being invoked from __sys_accept4 after
-		 * mptcp_accept() has accepted a non-mp-capable
-		 * subflow: sk is a tcp_sk, not mptcp.
-		 *
-		 * Hand the socket over to tcp so all further
-		 * socket ops bypass mptcp.
-		 */
-		sock->ops =3D &inet6_stream_ops;
-	}
-
-	return inet6_getname(sock, uaddr, peer);
-}
-#endif
-
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
@@ -1996,15 +1950,6 @@ static int mptcp_listen(struct socket *sock, int bac=
klog)
 	return err;
 }
 =

-static bool is_tcp_proto(const struct proto *p)
-{
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	return p =3D=3D &tcp_prot || p =3D=3D &tcpv6_prot;
-#else
-	return p =3D=3D &tcp_prot;
-#endif
-}
-
 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       int flags, bool kern)
 {
@@ -2027,7 +1972,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 	release_sock(sock->sk);
 =

 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
-	if (err =3D=3D 0 && !is_tcp_proto(newsock->sk->sk_prot)) {
+	if (err =3D=3D 0 && !mptcp_is_tcpsk(newsock->sk)) {
 		struct mptcp_sock *msk =3D mptcp_sk(newsock->sk);
 		struct mptcp_subflow_context *subflow;
 =

@@ -2142,7 +2087,7 @@ static const struct proto_ops mptcp_stream_ops =3D {
 	.connect	   =3D mptcp_stream_connect,
 	.socketpair	   =3D sock_no_socketpair,
 	.accept		   =3D mptcp_stream_accept,
-	.getname	   =3D mptcp_v4_getname,
+	.getname	   =3D inet_getname,
 	.poll		   =3D mptcp_poll,
 	.ioctl		   =3D inet_ioctl,
 	.gettstamp	   =3D sock_gettstamp,
@@ -2202,7 +2147,7 @@ static const struct proto_ops mptcp_v6_stream_ops =3D=
 {
 	.connect	   =3D mptcp_stream_connect,
 	.socketpair	   =3D sock_no_socketpair,
 	.accept		   =3D mptcp_stream_accept,
-	.getname	   =3D mptcp_v6_getname,
+	.getname	   =3D inet6_getname,
 	.poll		   =3D mptcp_poll,
 	.ioctl		   =3D inet6_ioctl,
 	.gettstamp	   =3D sock_gettstamp,
-- =

2.26.2

--===============2243587956042745315==--

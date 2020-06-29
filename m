Content-Type: multipart/mixed; boundary="===============2225261685754212534=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/6] mptcp: check for plain TCP sock at
 accept time
Date: Mon, 29 Jun 2020 22:26:22 +0200
Message-ID: <821ad8ad1581b906b6706426c1ba0c3b837cf60d.1593461586.git.dcaratti@redhat.com>
In-Reply-To: cover.1593461586.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4847

--===============2225261685754212534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

This cleanup the code a bit and avoid corrupted states
on weird syscall sequence (accept(), connect()).

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/protocol.c | 69 +++++---------------------------------------
 1 file changed, 7 insertions(+), 62 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84ae96be9837..dbeb6fe374f5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -52,13 +52,10 @@ static struct socket *__mptcp_nmpc_socket(const struct =
mptcp_sock *msk)
 	return msk->subflow;
 }
 =

-static struct socket *mptcp_is_tcpsk(struct sock *sk)
+static bool mptcp_is_tcpsk(struct sock *sk)
 {
 	struct socket *sock =3D sk->sk_socket;
 =

-	if (sock->sk !=3D sk)
-		return NULL;
-
 	if (unlikely(sk->sk_prot =3D=3D &tcp_prot)) {
 		/* we are being invoked after mptcp_accept() has
 		 * accepted a non-mp-capable flow: sk is a tcp_sk,
@@ -68,27 +65,21 @@ static struct socket *mptcp_is_tcpsk(struct sock *sk)
 		 * bypass mptcp.
 		 */
 		sock->ops =3D &inet_stream_ops;
-		return sock;
+		return true;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	} else if (unlikely(sk->sk_prot =3D=3D &tcpv6_prot)) {
 		sock->ops =3D &inet6_stream_ops;
-		return sock;
+		return true;
 #endif
 	}
 =

-	return NULL;
+	return false;
 }
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

@@ -1466,7 +1457,6 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		return NULL;
 =

 	pr_debug("msk=3D%p, subflow is mptcp=3D%d", msk, sk_is_mptcp(newsk));
-
 	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
@@ -1821,42 +1811,6 @@ static int mptcp_stream_connect(struct socket *sock,=
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
@@ -1885,15 +1839,6 @@ static int mptcp_listen(struct socket *sock, int bac=
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
@@ -1915,7 +1860,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 	release_sock(sock->sk);
 =

 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
-	if (err =3D=3D 0 && !is_tcp_proto(newsock->sk->sk_prot)) {
+	if (err =3D=3D 0 && !mptcp_is_tcpsk(newsock->sk)) {
 		struct mptcp_sock *msk =3D mptcp_sk(newsock->sk);
 		struct mptcp_subflow_context *subflow;
 =

@@ -2011,7 +1956,7 @@ static const struct proto_ops mptcp_stream_ops =3D {
 	.connect	   =3D mptcp_stream_connect,
 	.socketpair	   =3D sock_no_socketpair,
 	.accept		   =3D mptcp_stream_accept,
-	.getname	   =3D mptcp_v4_getname,
+	.getname	   =3D inet_getname,
 	.poll		   =3D mptcp_poll,
 	.ioctl		   =3D inet_ioctl,
 	.gettstamp	   =3D sock_gettstamp,
@@ -2065,7 +2010,7 @@ static const struct proto_ops mptcp_v6_stream_ops =3D=
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

--===============2225261685754212534==--

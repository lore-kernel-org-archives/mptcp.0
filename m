Content-Type: multipart/mixed; boundary="===============1878107344305640088=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/6] mptcp: Re-factor mptcp_stream_ops routines to be
 af-agnostic
Date: Wed, 30 Oct 2019 16:38:41 -0700
Message-ID: <20191030233844.4790-4-peter.krystad@linux.intel.com>
In-Reply-To: 20191030233844.4790-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2367

--===============1878107344305640088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split mptcp_bind/getname/listen into two parts: af-specific
part and functional part.

squashto: Associate MPTCP context with TCP socket (mptcp_bind)
and Create SUBFLOW socket for incoming connections (rest)

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 84 +++++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ee108e246dcf..9659afc9b444 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1104,24 +1104,32 @@ static struct socket *mptcp_socket_create_get(struc=
t mptcp_sock *msk,
 	return ssock;
 }
 =

-static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int add=
r_len)
+static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int add=
r_len,
+		      sa_family_t family, const struct proto_ops *ops)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
-	int err =3D -ENOTSUPP;
-
-	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
-		return err;
+	int err;
 =

-	ssock =3D mptcp_socket_create_get(msk, AF_INET);
+	ssock =3D mptcp_socket_create_get(msk, family);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

-	err =3D inet_bind(ssock, uaddr, addr_len);
+	err =3D ops->bind(ssock, uaddr, addr_len);
 	sock_put(ssock->sk);
 	return err;
 }
 =

+static int mptcp_v4_bind(struct socket *sock, struct sockaddr *uaddr,
+			 int addr_len)
+{
+	int err;
+
+	err =3D mptcp_bind(sock, uaddr, addr_len, AF_INET, &inet_stream_ops);
+
+	return err;
+}
+
 static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
 				int addr_len, int flags)
 {
@@ -1142,31 +1150,19 @@ static int mptcp_stream_connect(struct socket *sock=
, struct sockaddr *uaddr,
 }
 =

 static int mptcp_getname(struct socket *sock, struct sockaddr *uaddr,
-			 int peer)
+			 int peer, const struct proto_ops *ops)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
 	struct sock *ssk;
 	int ret;
 =

-	if (sock->sk->sk_prot =3D=3D &tcp_prot) {
-		/* we are being invoked from __sys_accept4, after
-		 * mptcp_accept() has just accepted a non-mp-capable
-		 * flow: sk is a tcp_sk, not an mptcp one.
-		 *
-		 * Hand the socket over to tcp so all further socket ops
-		 * bypass mptcp.
-		 */
-		sock->ops =3D &inet_stream_ops;
-		return inet_getname(sock, uaddr, peer);
-	}
-
 	lock_sock(sock->sk);
 	ssock =3D __mptcp_fallback_get_ref(msk);
 	if (ssock) {
 		release_sock(sock->sk);
 		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D inet_getname(ssock, uaddr, peer);
+		ret =3D ops->getname(ssock, uaddr, peer);
 		sock_put(ssock->sk);
 		return ret;
 	}
@@ -1181,12 +1177,35 @@ static int mptcp_getname(struct socket *sock, struc=
t sockaddr *uaddr,
 		return -ENOTCONN;
 	}
 =

-	ret =3D inet_getname(ssk->sk_socket, uaddr, peer);
+	ret =3D ops->getname(ssk->sk_socket, uaddr, peer);
 	release_sock(sock->sk);
 	return ret;
 }
 =

-static int mptcp_listen(struct socket *sock, int backlog)
+static int mptcp_v4_getname(struct socket *sock, struct sockaddr *uaddr,
+			    int peer)
+{
+	int ret;
+
+	if (sock->sk->sk_prot =3D=3D &tcp_prot) {
+		/* we are being invoked from __sys_accept4 after
+		 * mptcp_accept() has accepted a non-mp-capable
+		 * subflow: sk is a tcp_sk, not mptcp.
+		 *
+		 * Hand the socket over to tcp so all further
+		 * socket ops bypass mptcp.
+		 */
+		sock->ops =3D &inet_stream_ops;
+		return sock->ops->getname(sock, uaddr, peer);
+	}
+
+	ret =3D mptcp_getname(sock, uaddr, peer, &inet_stream_ops);
+
+	return ret;
+}
+
+static int mptcp_listen(struct socket *sock, int backlog, sa_family_t fami=
ly,
+			const struct proto_ops *ops)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
@@ -1194,15 +1213,24 @@ static int mptcp_listen(struct socket *sock, int ba=
cklog)
 =

 	pr_debug("msk=3D%p", msk);
 =

-	ssock =3D mptcp_socket_create_get(msk, AF_INET);
+	ssock =3D mptcp_socket_create_get(msk, family);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

-	err =3D inet_listen(ssock, backlog);
+	err =3D ops->listen(ssock, backlog);
 	sock_put(ssock->sk);
 	return err;
 }
 =

+static int mptcp_v4_listen(struct socket *sock, int backlog)
+{
+	int ret;
+
+	ret =3D mptcp_listen(sock, backlog, AF_INET, &inet_stream_ops);
+
+	return ret;
+}
+
 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       int flags, bool kern)
 {
@@ -1298,12 +1326,12 @@ void mptcp_proto_init(void)
 {
 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
 	mptcp_stream_ops =3D inet_stream_ops;
-	mptcp_stream_ops.bind =3D mptcp_bind;
+	mptcp_stream_ops.bind =3D mptcp_v4_bind;
 	mptcp_stream_ops.connect =3D mptcp_stream_connect;
 	mptcp_stream_ops.poll =3D mptcp_poll;
 	mptcp_stream_ops.accept =3D mptcp_stream_accept;
-	mptcp_stream_ops.getname =3D mptcp_getname;
-	mptcp_stream_ops.listen =3D mptcp_listen;
+	mptcp_stream_ops.getname =3D mptcp_v4_getname;
+	mptcp_stream_ops.listen =3D mptcp_v4_listen;
 	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

 	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
-- =

2.17.2

--===============1878107344305640088==--

Content-Type: multipart/mixed; boundary="===============5298606264936358339=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/6] mptcp: Reference inet_stream_ops routines
 through socket->ops
Date: Tue, 05 Nov 2019 20:41:29 -0800
Message-ID: <20191106044133.14418-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191106044133.14418-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2413

--===============5298606264936358339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Call protocol routines on the subflow through the existing proto_ops
pointer in socket structure instead of calling them directly. This
will make all of the mptcp proto_ops routines work for both IPv4
and IPv6.

squashto: Associate MPTCP context with TCP socket
          (bind and stream_connect changes)
          Create SUBFLOW socket for incoming connections
          (getname, listen, and stream_accept changes)
          Add tcp_poll (poll changes)

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2b29f8d0377..b3263a7f6458 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1115,7 +1115,7 @@ static int mptcp_bind(struct socket *sock, struct soc=
kaddr *uaddr, int addr_len)
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

-	err =3D inet_bind(ssock, uaddr, addr_len);
+	err =3D ssock->ops->bind(ssock, uaddr, addr_len);
 	sock_put(ssock->sk);
 	return err;
 }
@@ -1134,7 +1134,7 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

-	err =3D inet_stream_connect(ssock, uaddr, addr_len, flags);
+	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
 	sock_put(ssock->sk);
 	return err;
 }
@@ -1156,7 +1156,7 @@ static int mptcp_getname(struct socket *sock, struct =
sockaddr *uaddr,
 		 * bypass mptcp.
 		 */
 		sock->ops =3D &inet_stream_ops;
-		return inet_getname(sock, uaddr, peer);
+		return sock->ops->getname(sock, uaddr, peer);
 	}
 =

 	lock_sock(sock->sk);
@@ -1164,7 +1164,7 @@ static int mptcp_getname(struct socket *sock, struct =
sockaddr *uaddr,
 	if (ssock) {
 		release_sock(sock->sk);
 		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D inet_getname(ssock, uaddr, peer);
+		ret =3D ssock->ops->getname(ssock, uaddr, peer);
 		sock_put(ssock->sk);
 		return ret;
 	}
@@ -1179,7 +1179,7 @@ static int mptcp_getname(struct socket *sock, struct =
sockaddr *uaddr,
 		return -ENOTCONN;
 	}
 =

-	ret =3D inet_getname(ssk->sk_socket, uaddr, peer);
+	ret =3D ssk->sk_socket->ops->getname(ssk->sk_socket, uaddr, peer);
 	release_sock(sock->sk);
 	return ret;
 }
@@ -1196,7 +1196,7 @@ static int mptcp_listen(struct socket *sock, int back=
log)
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

-	err =3D inet_listen(ssock, backlog);
+	err =3D ssock->ops->listen(ssock, backlog);
 	sock_put(ssock->sk);
 	return err;
 }
@@ -1214,7 +1214,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 	if (!ssock)
 		return -EINVAL;
 =

-	err =3D inet_accept(sock, newsock, flags, kern);
+	err =3D ssock->ops->accept(sock, newsock, flags, kern);
 	sock_put(ssock->sk);
 	return err;
 }
@@ -1233,7 +1233,7 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 	ssock =3D __mptcp_fallback_get_ref(msk);
 	if (ssock) {
 		release_sock(sk);
-		ret =3D tcp_poll(file, ssock, wait);
+		ret =3D ssock->ops->poll(file, ssock, wait);
 		sock_put(ssock->sk);
 		return ret;
 	}
-- =

2.17.2

--===============5298606264936358339==--

Content-Type: multipart/mixed; boundary="===============3266901794001340417=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 3/6] mptcp: Re-factor mptcp_getname routine to be
 af-agnostic
Date: Tue, 05 Nov 2019 20:41:30 -0800
Message-ID: <20191106044133.14418-4-peter.krystad@linux.intel.com>
In-Reply-To: 20191106044133.14418-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2415

--===============3266901794001340417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split mptcp_getname into two parts: af-specific
part and functional part.

squashto: Create SUBFLOW socket for incoming connections

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b3263a7f6458..323b3e65dba2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1147,18 +1147,6 @@ static int mptcp_getname(struct socket *sock, struct=
 sockaddr *uaddr,
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
-		return sock->ops->getname(sock, uaddr, peer);
-	}
-
 	lock_sock(sock->sk);
 	ssock =3D __mptcp_fallback_get_ref(msk);
 	if (ssock) {
@@ -1184,6 +1172,28 @@ static int mptcp_getname(struct socket *sock, struct=
 sockaddr *uaddr,
 	return ret;
 }
 =

+static int mptcp_v4_getname(struct socket *sock, struct sockaddr *uaddr,
+			    int peer)
+{
+	int ret;
+
+	if (sock->sk->sk_prot =3D=3D &tcp_prot) {
+		/* we are being invoked from __sys_accept4, after
+		 * mptcp_accept() has just accepted a non-mp-capable
+		 * flow: sk is a tcp_sk, not an mptcp one.
+		 *
+		 * Hand the socket over to tcp so all further socket ops
+		 * bypass mptcp.
+		 */
+		sock->ops =3D &inet_stream_ops;
+		return sock->ops->getname(sock, uaddr, peer);
+	}
+
+	ret =3D mptcp_getname(sock, uaddr, peer);
+
+	return ret;
+}
+
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
@@ -1300,7 +1310,7 @@ void mptcp_proto_init(void)
 	mptcp_stream_ops.connect =3D mptcp_stream_connect;
 	mptcp_stream_ops.poll =3D mptcp_poll;
 	mptcp_stream_ops.accept =3D mptcp_stream_accept;
-	mptcp_stream_ops.getname =3D mptcp_getname;
+	mptcp_stream_ops.getname =3D mptcp_v4_getname;
 	mptcp_stream_ops.listen =3D mptcp_listen;
 	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

-- =

2.17.2

--===============3266901794001340417==--

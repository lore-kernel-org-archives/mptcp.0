Content-Type: multipart/mixed; boundary="===============6634622934478595570=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 10/16] mptcp: Add getname() socket operation
Date: Wed, 28 Mar 2018 16:18:34 -0700
Message-ID: <20180328231840.12410-11-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180328231840.12410-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 454

--===============6634622934478595570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 net/mptcp/protocol.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 373e89cf8eda..bf35d86a20ff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -218,6 +218,22 @@ int mptcp_stream_connect(struct socket *sock, struct s=
ockaddr *uaddr,
 	return err;
 }
 =

+int mptcp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *subflow;
+	int err =3D -EPERM;
+
+	if (msk->connection_list)
+		subflow =3D msk->connection_list;
+	else
+		subflow =3D msk->subflow;
+
+	err =3D inet_getname(subflow, uaddr, peer);
+
+	return err;
+}
+
 int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
@@ -254,7 +270,7 @@ const struct proto_ops mptcp_stream_ops =3D {
 	.connect	   =3D mptcp_stream_connect,
 	.socketpair	   =3D sock_no_socketpair,
 	.accept		   =3D inet_accept,
-	.getname	   =3D inet_getname,
+	.getname	   =3D mptcp_getname,
 	.poll		   =3D tcp_poll,
 	.ioctl		   =3D inet_ioctl,
 	.listen		   =3D mptcp_listen,
-- =

2.16.3


--===============6634622934478595570==--

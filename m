Content-Type: multipart/mixed; boundary="===============1986559213126037442=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: cope with later TCP fallback"
Date: Mon, 16 Dec 2019 13:22:29 +0100
Message-ID: <91571e18e2a8945349d6d84fdc5324a8e76f8637.1576498821.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3073

--===============1986559213126037442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Clean subflow->conn, under the ssk socket lock, and make
__mptcp_tcp_fallback() less unreadable
---
This should address Mat's concern on the fallback code path
---
 net/mptcp/protocol.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2b20f4d3e179..9e288559e228 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -49,7 +49,17 @@ static struct socket *__mptcp_fallback_to_tcp(struct mpt=
cp_sock *msk,
 	sock->sk =3D NULL;
 =

 	/* socket is now TCP */
+	lock_sock(ssk);
 	sock_graft(ssk, sock);
+	if (subflow->conn) {
+		/* Clearing the 'conn' field will make the ULP-ovverriden
+		 * oops behaving alike plain TCP ones.
+		 * Note: we can't release the ULP data on a live socket.
+		 */
+		sock_put(subflow->conn);
+		subflow->conn =3D NULL;
+	}
+	release_sock(ssk);
 	sock->ops =3D sk->sk_family =3D=3D AF_INET6 ? &inet6_stream_ops :
 						&inet_stream_ops;
 =

@@ -76,8 +86,8 @@ static bool __mptcp_needs_tcp_fallback(const struct mptcp=
_sock *msk)
 	return msk->first && !tcp_sk(msk->first)->is_mptcp;
 }
 =

-/* if the mp_capable handshake is failed, return a tcp socket
- * return it.
+/* if the mp_capable handshake is failed, fallback msk to plain tcp,
+ * release the socket lock and returns a reference to the now TCP socket
  * Otherwise returns NULL
  */
 static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
-- =

2.21.0

--===============1986559213126037442==--

Content-Type: multipart/mixed; boundary="===============5302147903478637578=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 11/19] mptcp: Add shutdown() socket operation
Date: Tue, 05 Jun 2018 16:40:30 -0700
Message-ID: <20180605234038.28497-12-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180605234038.28497-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 654

--===============5302147903478637578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 net/mptcp/protocol.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bf35d86a20ff..63cf5ead52f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -244,6 +244,26 @@ int mptcp_listen(struct socket *sock, int backlog)
 	return inet_listen(subflow, backlog);
 }
 =

+int mptcp_stream_shutdown(struct socket *sock, int how)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	int ret =3D 0;
+
+	pr_debug("sk=3D%p, how=3D%d", msk, how);
+
+	if (msk->subflow) {
+		pr_debug("subflow=3D%p", msk->subflow->sk);
+		ret =3D kernel_sock_shutdown(msk->subflow, how);
+	}
+	if (msk->connection_list) {
+		pr_debug("conn_list->subflow=3D%p", msk->connection_list->sk);
+		ret =3D kernel_sock_shutdown(msk->connection_list, how);
+	}
+	inet_shutdown(sock, how);
+
+	return ret;
+}
+
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
@@ -274,7 +294,7 @@ const struct proto_ops mptcp_stream_ops =3D {
 	.poll		   =3D tcp_poll,
 	.ioctl		   =3D inet_ioctl,
 	.listen		   =3D mptcp_listen,
-	.shutdown	   =3D inet_shutdown,
+	.shutdown	   =3D mptcp_stream_shutdown,
 	.setsockopt	   =3D sock_common_setsockopt,
 	.getsockopt	   =3D sock_common_getsockopt,
 	.sendmsg	   =3D inet_sendmsg,
-- =

2.17.1


--===============5302147903478637578==--

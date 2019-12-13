Content-Type: multipart/mixed; boundary="===============5055567060828724602=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 08/15] mptcp: Add setsockopt()/getsockopt() socket
 operations
Date: Fri, 13 Dec 2019 21:50:59 +0100
Message-ID: <20191213205106.2467313-9-matthieu.baerts@tessares.net>
In-Reply-To: 20191213205106.2467313-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3001

--===============5055567060828724602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)linux.intel.com>

set/getsockopt behaviour with multiple subflows is undefined.
Therefore, for now, we return -EOPNOTSUPP unless we're in fallback mode.

Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6298e1d0008b..891aa6ef0a95 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -330,6 +330,62 @@ static void mptcp_destroy(struct sock *sk)
 {
 }
 =

+static int mptcp_setsockopt(struct sock *sk, int level, int optname,
+			    char __user *uoptval, unsigned int optlen)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	char __kernel *optval;
+	int ret =3D -EOPNOTSUPP;
+	struct socket *ssock;
+
+	/* will be treated as __user in tcp_setsockopt */
+	optval =3D (char __kernel __force *)uoptval;
+
+	pr_debug("msk=3D%p", msk);
+
+	/* @@ the meaning of setsockopt() when the socket is connected and
+	 * there are multiple subflows is not defined.
+	 */
+	lock_sock(sk);
+	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
+	if (!IS_ERR(ssock)) {
+		pr_debug("subflow=3D%p", ssock->sk);
+		ret =3D kernel_setsockopt(ssock, level, optname, optval, optlen);
+	}
+	release_sock(sk);
+
+	return ret;
+}
+
+static int mptcp_getsockopt(struct sock *sk, int level, int optname,
+			    char __user *uoptval, int __user *uoption)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	char __kernel *optval;
+	int ret =3D -EOPNOTSUPP;
+	int __kernel *option;
+	struct socket *ssock;
+
+	/* will be treated as __user in tcp_getsockopt */
+	optval =3D (char __kernel __force *)uoptval;
+	option =3D (int __kernel __force *)uoption;
+
+	pr_debug("msk=3D%p", msk);
+
+	/* @@ the meaning of getsockopt() when the socket is connected and
+	 * there are multiple subflows is not defined.
+	 */
+	lock_sock(sk);
+	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
+	if (!IS_ERR(ssock)) {
+		pr_debug("subflow=3D%p", ssock->sk);
+		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
+	}
+	release_sock(sk);
+
+	return ret;
+}
+
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -380,6 +436,8 @@ static struct proto mptcp_prot =3D {
 	.init		=3D mptcp_init_sock,
 	.close		=3D mptcp_close,
 	.accept		=3D mptcp_accept,
+	.setsockopt	=3D mptcp_setsockopt,
+	.getsockopt	=3D mptcp_getsockopt,
 	.shutdown	=3D tcp_shutdown,
 	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
-- =

2.24.0

--===============5055567060828724602==--

Content-Type: multipart/mixed; boundary="===============0072157973684739173=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2 2/3] mptcp: Protect subflow socket options
 before connection completes
Date: Thu, 13 Feb 2020 12:38:35 -0800
Message-ID: <20200213203836.225812-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200213203836.225812-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3655

--===============0072157973684739173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Userspace should not be able to directly manipulate subflow socket
options before a connection is established since it is not yet known if
it will be an MPTCP subflow or a TCP fallback subflow. TCP fallback
subflows can be more directly controlled by userspace because they are
regular TCP connections, while MPTCP subflow sockets need to be
configured for the specific needs of MPTCP. Use the same logic as
sendmsg/recvmsg to ensure that socket option calls are only passed
through to known TCP fallback subflows.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 50 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a8faf66c38d8..0169e7dfc2d1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -756,60 +756,64 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 			    char __user *optval, unsigned int optlen)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	int ret =3D -EOPNOTSUPP;
 	struct socket *ssock;
-	struct sock *ssk;
 =

 	pr_debug("msk=3D%p", msk);
 =

 	/* @@ the meaning of setsockopt() when the socket is connected and
-	 * there are multiple subflows is not defined.
+	 * there are multiple subflows is not yet defined. It is up to the
+	 * MPTCP-level socket to configure the subflows until the subflow
+	 * is in TCP fallback, when TCP socket options are passed through
+	 * to the one remaining subflow.
 	 */
 	lock_sock(sk);
-	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
-	if (IS_ERR(ssock)) {
+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (ssock) {
+		struct sock *ssk =3D ssock->sk;
+		int ret;
+
+		sock_hold(ssk);
 		release_sock(sk);
+		ret =3D tcp_setsockopt(ssk, level, optname, optval, optlen);
+		sock_put(ssk);
 		return ret;
 	}
 =

-	ssk =3D ssock->sk;
-	sock_hold(ssk);
 	release_sock(sk);
 =

-	ret =3D tcp_setsockopt(ssk, level, optname, optval, optlen);
-	sock_put(ssk);
-
-	return ret;
+	return -EOPNOTSUPP;
 }
 =

 static int mptcp_getsockopt(struct sock *sk, int level, int optname,
 			    char __user *optval, int __user *option)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	int ret =3D -EOPNOTSUPP;
 	struct socket *ssock;
-	struct sock *ssk;
 =

 	pr_debug("msk=3D%p", msk);
 =

-	/* @@ the meaning of getsockopt() when the socket is connected and
-	 * there are multiple subflows is not defined.
+	/* @@ the meaning of setsockopt() when the socket is connected and
+	 * there are multiple subflows is not yet defined. It is up to the
+	 * MPTCP-level socket to configure the subflows until the subflow
+	 * is in TCP fallback, when socket options are passed through
+	 * to the one remaining subflow.
 	 */
 	lock_sock(sk);
-	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
-	if (IS_ERR(ssock)) {
+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (ssock) {
+		struct sock *ssk =3D ssock->sk;
+		int ret;
+
+		sock_hold(ssk);
 		release_sock(sk);
+		ret =3D tcp_getsockopt(ssk, level, optname, optval, option);
+		sock_put(ssk);
 		return ret;
 	}
 =

-	ssk =3D ssock->sk;
-	sock_hold(ssk);
 	release_sock(sk);
 =

-	ret =3D tcp_getsockopt(ssk, level, optname, optval, option);
-	sock_put(ssk);
-
-	return ret;
+	return -EOPNOTSUPP;
 }
 =

 static int mptcp_get_port(struct sock *sk, unsigned short snum)
-- =

2.25.0

--===============0072157973684739173==--

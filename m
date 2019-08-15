Content-Type: multipart/mixed; boundary="===============5039042795593279540=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: sockopt: pass set/getsockopt to subflows
Date: Thu, 15 Aug 2019 18:24:32 +0200
Message-ID: <20190815162432.22562-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1640

--===============5039042795593279540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to e.g. set tcp congestion control algorithm
on all subflows by issuing the setsockopt on the mptcp meta socket.

In the future we could keep a record of sockopts so we can "replay"
them when another subflow is added at a later point in time.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 47 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aaa71b161c1a..e41a4daf4f99 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -711,9 +711,10 @@ static int mptcp_setsockopt(struct sock *sk, int level=
, int optname,
 			    char __user *uoptval, unsigned int optlen)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	const struct subflow_context *subflow;
 	char __kernel *optval;
 	struct socket *ssock;
-	int ret;
+	int ret, err, subflows;
 =

 	/* will be treated as __user in tcp_setsockopt */
 	optval =3D (char __kernel __force *)uoptval;
@@ -729,13 +730,36 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 =

 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not defined.
+	 *
+	 * We attempt to perfom the operation on all current subflows, but
+	 * only return error if all subflow setsockopt failed.
 	 */
-	return 0;
+	ret =3D 0;
+	err =3D 0;
+	subflows =3D 0;
+	lock_sock(sk);
+	list_for_each_entry(subflow, &msk->conn_list, node) {
+		struct socket *tcp_sk =3D mptcp_subflow_tcp_socket(subflow);
+		int tmp;
+
+		tmp =3D kernel_setsockopt(tcp_sk, level, optname, optval, optlen);
+		if (tmp =3D=3D 0)
+			subflows++;
+		else if (err =3D=3D 0)
+			err =3D tmp;
+	}
+	release_sock(sk);
+
+	if (subflows =3D=3D 0 && err)
+		ret =3D err;
+
+	return ret;
 }
 =

 static int mptcp_getsockopt(struct sock *sk, int level, int optname,
 			    char __user *uoptval, int __user *uoption)
 {
+	const struct subflow_context *subflow;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	char __kernel *optval;
 	int __kernel *option;
@@ -755,10 +779,25 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 		return ret;
 	}
 =

-	/* @@ the meaning of setsockopt() when the socket is connected and
+	/* @@ the meaning of getsockopt() when the socket is connected and
 	 * there are multiple subflows is not defined.
+	 *
+	 * We use the first subflow in the list.
 	 */
-	return 0;
+	lock_sock(sk);
+	subflow =3D list_first_entry_or_null(&msk->conn_list,
+					   struct subflow_context, node);
+	if (subflow) {
+		struct socket *tcp_sk =3D mptcp_subflow_tcp_socket(subflow);
+
+		ret =3D kernel_getsockopt(tcp_sk, level, optname, optval, option);
+	} else {
+		ret =3D -ENOTCONN;
+	}
+
+	release_sock(sk);
+
+	return ret;
 }
 =

 static int mptcp_get_port(struct sock *sk, unsigned short snum)
-- =

2.21.0


--===============5039042795593279540==--

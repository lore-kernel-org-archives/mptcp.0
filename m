Content-Type: multipart/mixed; boundary="===============4994571449299327772=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp: sockopt: pass whitelisted setsockopt to
 subflows
Date: Fri, 16 Aug 2019 00:14:49 +0200
Message-ID: <20190815221449.13210-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1644

--===============4994571449299327772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to set tcp congestion control algorithm on all subflows.

In the future we could keep a record of sockopts so we can "replay"
them when another subflow is added at a later point in time.

Only TCP_CONGESTION is allowed at the moment, as some available
TCP knobs either have undesireable behaviour or should be later
implemented at the mptcp level rather than passing them through to
the subflows (TCP_CORK for example).

getsockopt is disabled for the time being to not expose a particular
behaviour ("first subflow on list") at this time.

v2: disable getsockopt, restrict setsockopt via whitelist.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 51 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aaa71b161c1a..a8cbd9741c32 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -707,13 +707,31 @@ static void mptcp_destroy(struct sock *sk)
 	token_destroy(msk->token);
 }
 =

+
+/* Only pass a small subset of level/optnames that are considered safe.
+ * We e.g. don't want MD5SIG (option space too limited) or TCP_CORK
+ * (meaning not entirely clear from mptcp point of view).
+ */
+static bool pass_to_subflows(int level, int optname)
+{
+	if (level !=3D SOL_TCP)
+		return false;
+
+	switch (optname) {
+	case TCP_CONGESTION: return true;
+	}
+
+	return false;
+}
+
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
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
@@ -729,8 +747,33 @@ static int mptcp_setsockopt(struct sock *sk, int level=
, int optname,
 =

 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not defined.
+	 *
+	 * We attempt to perfom the operation on all current subflows, but
+	 * only return error if all subflow setsockopt failed.
 	 */
-	return 0;
+	if (!pass_to_subflows(level, optname))
+		return -EOPNOTSUPP;
+
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
@@ -755,10 +798,10 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 		return ret;
 	}
 =

-	/* @@ the meaning of setsockopt() when the socket is connected and
+	/* @@ the meaning of getsockopt() when the socket is connected and
 	 * there are multiple subflows is not defined.
 	 */
-	return 0;
+	return -EOPNOTSUPP;
 }
 =

 static int mptcp_get_port(struct sock *sk, unsigned short snum)
-- =

2.21.0


--===============4994571449299327772==--

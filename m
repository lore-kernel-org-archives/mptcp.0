Content-Type: multipart/mixed; boundary="===============1444842778489234447=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 12/16] mptcp: Implement setsockopt()/getsockopt()
Date: Wed, 28 Mar 2018 16:18:36 -0700
Message-ID: <20180328231840.12410-13-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180328231840.12410-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 459

--===============1444842778489234447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 net/mptcp/protocol.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 22 ++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 63cf5ead52f2..3d517d6645fe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -167,6 +167,52 @@ static void mptcp_destroy(struct sock *sk)
 	token_destroy(msk->token);
 }
 =

+static int mptcp_setsockopt(struct sock *sk, int level, int optname,
+			    char __user *uoptval, unsigned int optlen)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *subflow;
+	char __kernel *optval;
+
+	pr_debug("msk=3D%p", msk);
+	if (msk->connection_list) {
+		subflow =3D msk->connection_list;
+		pr_debug("conn_list->subflow=3D%p", subflow->sk);
+	} else {
+		subflow =3D msk->subflow;
+		pr_debug("subflow=3D%p", subflow->sk);
+	}
+
+	/* will be treated as __user in subflow_setsockopt */
+	optval =3D (char __kernel __force *) uoptval;
+
+	return kernel_setsockopt(subflow, level, optname, optval, optlen);
+}
+
+static int mptcp_getsockopt(struct sock *sk, int level, int optname,
+			    char __user *uoptval, int __user *uoption)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *subflow;
+	char __kernel *optval;
+	int __kernel *option;
+
+	pr_debug("msk=3D%p", msk);
+	if (msk->connection_list) {
+		subflow =3D msk->connection_list;
+		pr_debug("conn_list->subflow=3D%p", subflow->sk);
+	} else {
+		subflow =3D msk->subflow;
+		pr_debug("subflow=3D%p", subflow->sk);
+	}
+
+	/* will be treated as __user in subflow_getsockopt */
+	optval =3D (char __kernel __force *) uoptval;
+	option =3D (int __kernel __force *) uoption;
+
+	return kernel_getsockopt(subflow, level, optname, optval, option);
+}
+
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -273,6 +319,8 @@ static struct proto mptcp_prot =3D {
 	.connect	=3D mptcp_connect,
 	.shutdown	=3D tcp_shutdown,
 	.destroy	=3D mptcp_destroy,
+	.setsockopt	=3D mptcp_setsockopt,
+	.getsockopt	=3D mptcp_getsockopt,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
 	.hash		=3D inet_hash,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9f417f3ed188..0a85f1418385 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -248,6 +248,26 @@ static void subflow_destroy(struct sock *sk)
 	tcp_v4_destroy_sock(sk);
 }
 =

+static int subflow_setsockopt(struct sock *sk, int level, int optname,
+			      char __user *optval, unsigned int optlen)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	return tcp_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static int subflow_getsockopt(struct sock *sk, int level, int optname,
+			      char __user *optval, int __user *option)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	return tcp_getsockopt(sk, level, optname, optval, option);
+}
+
 static struct proto subflow_prot =3D {
 	.name		=3D "SUBFLOW",
 	.owner		=3D THIS_MODULE,
@@ -259,6 +279,8 @@ static struct proto subflow_prot =3D {
 	.init		=3D subflow_init_sock,
 	.destroy	=3D subflow_destroy,
 	.shutdown	=3D tcp_shutdown,
+	.setsockopt	=3D subflow_setsockopt,
+	.getsockopt	=3D subflow_getsockopt,
 	.keepalive	=3D tcp_set_keepalive,
 	.recvmsg	=3D subflow_recvmsg,
 	.sendmsg	=3D subflow_sendmsg,
-- =

2.16.3


--===============1444842778489234447==--

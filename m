Content-Type: multipart/mixed; boundary="===============4374589271347842347=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: create the
 listening socket"
Date: Fri, 20 Nov 2020 12:29:12 +0800
Message-ID: <6d5989e448da96358b922f43133129d5f0c85997.1605846421.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6860

--===============4374589271347842347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch defined a new function __mptcp_subflow_create_socket for reuse,
This fuction is extracted from mptcp_subflow_create_socket, and it could
be reused by mptcp_subflow_create_socket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/subflow.c | 55 +++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index eace5eb49955..f9aa12cb2bfb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1234,19 +1234,12 @@ static void mptcp_attach_cgroup(struct sock *parent=
, struct sock *child)
 #endif /* CONFIG_SOCK_CGROUP_DATA */
 }
 =

-int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
+static int __mptcp_subflow_create_socket(struct sock *sk, struct socket **=
new_sock)
 {
-	struct mptcp_subflow_context *subflow;
 	struct net *net =3D sock_net(sk);
 	struct socket *sf;
 	int err;
 =

-	/* un-accepted server sockets can reach here - on bad configuration
-	 * bail early to avoid greater trouble later
-	 */
-	if (unlikely(!sk->sk_socket))
-		return -EINVAL;
-
 	err =3D sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
 			       &sf);
 	if (err)
@@ -1273,6 +1266,27 @@ int mptcp_subflow_create_socket(struct sock *sk, str=
uct socket **new_sock)
 		return err;
 	}
 =

+	*new_sock =3D sf;
+
+	return 0;
+}
+
+int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
+{
+	struct mptcp_subflow_context *subflow;
+	struct socket *sf;
+	int err;
+
+	/* un-accepted server sockets can reach here - on bad configuration
+	 * bail early to avoid greater trouble later
+	 */
+	if (unlikely(!sk->sk_socket))
+		return -EINVAL;
+
+	err =3D __mptcp_subflow_create_socket(sk, &sf);
+	if (err)
+		return err;
+
 	/* the newly created socket really belongs to the owning MPTCP master
 	 * socket, even if for additional subflows the allocation is performed
 	 * by a kernel workqueue. Adjust inode references, so that the
@@ -1296,36 +1310,13 @@ int mptcp_subflow_create_socket(struct sock *sk, st=
ruct socket **new_sock)
 int mptcp_create_listen_socket(struct sock *sk, struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
-	struct net *net =3D sock_net(sk);
 	struct socket *sf;
 	int err;
 =

-	err =3D sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
-			       &sf);
+	err =3D __mptcp_subflow_create_socket(sk, &sf);
 	if (err)
 		return err;
 =

-	lock_sock(sf->sk);
-
-	/* the newly created socket has to be in the same cgroup as its parent */
-	mptcp_attach_cgroup(sk, sf->sk);
-
-	/* kernel sockets do not by default acquire net ref, but TCP timer
-	 * needs it.
-	 */
-	sf->sk->sk_net_refcnt =3D 1;
-	get_net(net);
-#ifdef CONFIG_PROC_FS
-	this_cpu_add(*net->core.sock_inuse, 1);
-#endif
-	err =3D tcp_set_ulp(sf->sk, "mptcp");
-	release_sock(sf->sk);
-
-	if (err) {
-		sock_release(sf);
-		return err;
-	}
-
 	SOCK_INODE(sf)->i_uid =3D GLOBAL_ROOT_UID;
 	SOCK_INODE(sf)->i_gid =3D GLOBAL_ROOT_GID;
 =

-- =

2.26.2

--===============4374589271347842347==--

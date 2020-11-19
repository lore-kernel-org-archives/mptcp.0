Content-Type: multipart/mixed; boundary="===============3467381322818948705=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 01/10] mptcp: create the
 listening socket
Date: Thu, 19 Nov 2020 18:19:41 +0800
Message-ID: <50a92cac666f3359db3c5808690789527a385202.1605780306.git.geliangtang@gmail.com>
In-Reply-To: cover.1605780306.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6812

--===============3467381322818948705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new function named mptcp_create_listen_socket to
create a listening socket in the kernel side.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b5647a14ea54..7e40773f6b3d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -444,6 +444,7 @@ void mptcp_subflow_reset(struct sock *ssk);
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
+int mptcp_create_listen_socket(struct sock *sk, struct socket **new_sock);
 =

 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 02d757e0ddb7..86eaf4b76147 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1218,6 +1218,53 @@ int mptcp_subflow_create_socket(struct sock *sk, str=
uct socket **new_sock)
 	return 0;
 }
 =

+int mptcp_create_listen_socket(struct sock *sk, struct socket **new_sock)
+{
+	struct mptcp_subflow_context *subflow;
+	struct net *net =3D sock_net(sk);
+	struct socket *sf;
+	int err;
+
+	err =3D sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
+			       &sf);
+	if (err)
+		return err;
+
+	lock_sock(sf->sk);
+
+	/* the newly created socket has to be in the same cgroup as its parent */
+	mptcp_attach_cgroup(sk, sf->sk);
+
+	/* kernel sockets do not by default acquire net ref, but TCP timer
+	 * needs it.
+	 */
+	sf->sk->sk_net_refcnt =3D 1;
+	get_net(net);
+#ifdef CONFIG_PROC_FS
+	this_cpu_add(*net->core.sock_inuse, 1);
+#endif
+	err =3D tcp_set_ulp(sf->sk, "mptcp");
+	release_sock(sf->sk);
+
+	if (err) {
+		sock_release(sf);
+		return err;
+	}
+
+	SOCK_INODE(sf)->i_uid =3D GLOBAL_ROOT_UID;
+	SOCK_INODE(sf)->i_gid =3D GLOBAL_ROOT_GID;
+
+	subflow =3D mptcp_subflow_ctx(sf->sk);
+	pr_debug("subflow=3D%p", subflow);
+
+	*new_sock =3D sf;
+	sock_hold(sk);
+	subflow->conn =3D sk;
+	subflow->request_mptcp =3D 1;
+
+	return 0;
+}
+
 static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 							gfp_t priority)
 {
-- =

2.26.2

--===============3467381322818948705==--

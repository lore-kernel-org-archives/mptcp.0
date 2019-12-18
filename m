Content-Type: multipart/mixed; boundary="===============5153761027457532720=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 03/15] mptcp: Associate MPTCP context with
 TCP socket
Date: Wed, 18 Dec 2019 11:54:58 -0800
Message-ID: <20191218195510.7782-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191218195510.7782-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3147

--===============5153761027457532720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)linux.intel.com>

Use ULP to associate a subflow_context structure with each TCP subflow
socket. Creating these sockets requires new bind and connect functions
to make sure ULP is set up immediately when the subflow sockets are
created.

Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Co-developed-by: Davide Caratti <dcaratti(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/linux/tcp.h  |   3 +
 net/mptcp/Makefile   |   2 +-
 net/mptcp/protocol.c | 133 +++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  26 +++++++++
 net/mptcp/subflow.c  | 111 ++++++++++++++++++++++++++++++++++++
 5 files changed, 268 insertions(+), 7 deletions(-)
 create mode 100644 net/mptcp/subflow.c

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 52798ab00394..877947475814 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -397,6 +397,9 @@ struct tcp_sock {
 	u32	mtu_info; /* We received an ICMP_FRAG_NEEDED / ICMPV6_PKT_TOOBIG
 			   * while socket was owned by user.
 			   */
+#if IS_ENABLED(CONFIG_MPTCP)
+	bool	is_mptcp;
+#endif
 =

 #ifdef CONFIG_TCP_MD5SIG
 /* TCP AF-Specific parts; only used by MD5 Signature support so far */
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 27a846263f08..e1ee5aade8b0 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

-mptcp-y :=3D protocol.o options.o
+mptcp-y :=3D protocol.o subflow.o options.o
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5e24e7cf7d70..3a24044ee737 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -17,6 +17,54 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+#define MPTCP_SAME_STATE TCP_MAX_STATES
+
+/* if msk has a single subflow socket, and the mp_capable handshake is not
+ * completed yet or has failed - that is, the socket is Not MP Capable,
+ * returns it.
+ * Otherwise returns NULL
+ */
+static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
+{
+	if (!msk->subflow)
+		return NULL;
+
+	return msk->subflow;
+}
+
+static bool __mptcp_can_create_subflow(const struct mptcp_sock *msk)
+{
+	return ((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE;
+}
+
+static struct socket *__mptcp_socket_create(struct mptcp_sock *msk, int st=
ate)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	struct socket *ssock;
+	int err;
+
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (ssock)
+		goto set_state;
+
+	if (!__mptcp_can_create_subflow(msk))
+		return ERR_PTR(-EINVAL);
+
+	err =3D mptcp_subflow_create_socket(sk, &ssock);
+	if (err)
+		return ERR_PTR(err);
+
+	msk->subflow =3D ssock;
+	subflow =3D mptcp_subflow_ctx(ssock->sk);
+	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
+
+set_state:
+	if (state !=3D MPTCP_SAME_STATE)
+		inet_sk_state_store(sk, state);
+	return ssock;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -48,12 +96,14 @@ static int mptcp_init_sock(struct sock *sk)
 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *ssock;
 =

 	inet_sk_state_store(sk, TCP_CLOSE);
 =

-	if (msk->subflow) {
-		pr_debug("subflow=3D%p", msk->subflow->sk);
-		sock_release(msk->subflow);
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (ssock) {
+		pr_debug("subflow=3D%p", mptcp_subflow_ctx(ssock->sk));
+		sock_release(ssock);
 	}
 =

 	sock_orphan(sk);
@@ -67,7 +117,8 @@ static int mptcp_connect(struct sock *sk, struct sockadd=
r *saddr, int len)
 =

 	saddr->sa_family =3D AF_INET;
 =

-	pr_debug("msk=3D%p, subflow=3D%p", msk, msk->subflow->sk);
+	pr_debug("msk=3D%p, subflow=3D%p", msk,
+		 mptcp_subflow_ctx(msk->subflow->sk));
 =

 	err =3D kernel_connect(msk->subflow, saddr, len, 0);
 =

@@ -93,15 +144,79 @@ static struct proto mptcp_prot =3D {
 	.no_autobind	=3D true,
 };
 =

+static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int add=
r_len)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *ssock;
+	int err =3D -ENOTSUPP;
+
+	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
+		return err;
+
+	lock_sock(sock->sk);
+	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
+	if (IS_ERR(ssock)) {
+		err =3D PTR_ERR(ssock);
+		goto unlock;
+	}
+
+	err =3D ssock->ops->bind(ssock, uaddr, addr_len);
+
+unlock:
+	release_sock(sock->sk);
+	return err;
+}
+
+static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
+				int addr_len, int flags)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *ssock;
+	int err;
+
+	lock_sock(sock->sk);
+	ssock =3D __mptcp_socket_create(msk, TCP_SYN_SENT);
+	if (IS_ERR(ssock)) {
+		err =3D PTR_ERR(ssock);
+		goto unlock;
+	}
+
+	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
+	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
+
+unlock:
+	release_sock(sock->sk);
+	return err;
+}
+
+static __poll_t mptcp_poll(struct file *file, struct socket *sock,
+			   struct poll_table_struct *wait)
+{
+	__poll_t mask =3D 0;
+
+	return mask;
+}
+
+static struct proto_ops mptcp_stream_ops;
+
 static struct inet_protosw mptcp_protosw =3D {
 	.type		=3D SOCK_STREAM,
 	.protocol	=3D IPPROTO_MPTCP,
 	.prot		=3D &mptcp_prot,
-	.ops		=3D &inet_stream_ops,
+	.ops		=3D &mptcp_stream_ops,
+	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

 void __init mptcp_init(void)
 {
+	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
+	mptcp_stream_ops =3D inet_stream_ops;
+	mptcp_stream_ops.bind =3D mptcp_bind;
+	mptcp_stream_ops.connect =3D mptcp_stream_connect;
+	mptcp_stream_ops.poll =3D mptcp_poll;
+
+	mptcp_subflow_init();
+
 	if (proto_register(&mptcp_prot, 1) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
 =

@@ -109,13 +224,14 @@ void __init mptcp_init(void)
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct proto_ops mptcp_v6_stream_ops;
 static struct proto mptcp_v6_prot;
 =

 static struct inet_protosw mptcp_v6_protosw =3D {
 	.type		=3D SOCK_STREAM,
 	.protocol	=3D IPPROTO_MPTCP,
 	.prot		=3D &mptcp_v6_prot,
-	.ops		=3D &inet6_stream_ops,
+	.ops		=3D &mptcp_v6_stream_ops,
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

@@ -133,6 +249,11 @@ int mptcpv6_init(void)
 	if (err)
 		return err;
 =

+	mptcp_v6_stream_ops =3D inet6_stream_ops;
+	mptcp_v6_stream_ops.bind =3D mptcp_bind;
+	mptcp_v6_stream_ops.connect =3D mptcp_stream_connect;
+	mptcp_v6_stream_ops.poll =3D mptcp_poll;
+
 	err =3D inet6_register_protosw(&mptcp_v6_protosw);
 	if (err)
 		proto_unregister(&mptcp_v6_prot);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c59cf8b220b0..543d4d5d8985 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -48,4 +48,30 @@ static inline struct mptcp_sock *mptcp_sk(const struct s=
ock *sk)
 	return (struct mptcp_sock *)sk;
 }
 =

+/* MPTCP subflow context */
+struct mptcp_subflow_context {
+	u32	request_mptcp : 1;  /* send MP_CAPABLE */
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+	struct	sock *conn;	    /* parent mptcp_sock */
+	struct	rcu_head rcu;
+};
+
+static inline struct mptcp_subflow_context *
+mptcp_subflow_ctx(const struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	/* Use RCU on icsk_ulp_data only for sock diag code */
+	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
+}
+
+static inline struct sock *
+mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return subflow->tcp_sock;
+}
+
+void mptcp_subflow_init(void);
+int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
+
 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
new file mode 100644
index 000000000000..9e2ff5b40d13
--- /dev/null
+++ b/net/mptcp/subflow.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2017 - 2019, Intel Corporation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <net/sock.h>
+#include <net/inet_common.h>
+#include <net/inet_hashtables.h>
+#include <net/protocol.h>
+#include <net/tcp.h>
+#include <net/mptcp.h>
+#include "protocol.h"
+
+int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
+{
+	struct mptcp_subflow_context *subflow;
+	struct net *net =3D sock_net(sk);
+	struct socket *sf;
+	int err;
+
+	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
+	if (err)
+		return err;
+
+	lock_sock(sf->sk);
+	err =3D tcp_set_ulp(sf->sk, "mptcp");
+	release_sock(sf->sk);
+
+	if (err)
+		return err;
+
+	subflow =3D mptcp_subflow_ctx(sf->sk);
+	pr_debug("subflow=3D%p", subflow);
+
+	*new_sock =3D sf;
+	subflow->conn =3D sk;
+
+	return 0;
+}
+
+static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
+							gfp_t priority)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	struct mptcp_subflow_context *ctx;
+
+	ctx =3D kzalloc(sizeof(*ctx), priority);
+	if (!ctx)
+		return NULL;
+	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
+
+	pr_debug("subflow=3D%p", ctx);
+
+	ctx->tcp_sock =3D sk;
+
+	return ctx;
+}
+
+static int subflow_ulp_init(struct sock *sk)
+{
+	struct mptcp_subflow_context *ctx;
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	int err =3D 0;
+
+	/* disallow attaching ULP to a socket unless it has been
+	 * created with sock_create_kern()
+	 */
+	if (!sk->sk_kern_sock) {
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	ctx =3D subflow_create_ctx(sk, GFP_KERNEL);
+	if (!ctx) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	pr_debug("subflow=3D%p, family=3D%d", ctx, sk->sk_family);
+
+	tp->is_mptcp =3D 1;
+out:
+	return err;
+}
+
+static void subflow_ulp_release(struct sock *sk)
+{
+	struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(sk);
+
+	if (!ctx)
+		return;
+
+	kfree_rcu(ctx, rcu);
+}
+
+static struct tcp_ulp_ops subflow_ulp_ops __read_mostly =3D {
+	.name		=3D "mptcp",
+	.owner		=3D THIS_MODULE,
+	.init		=3D subflow_ulp_init,
+	.release	=3D subflow_ulp_release,
+};
+
+void mptcp_subflow_init(void)
+{
+	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
+		panic("MPTCP: failed to register subflows to ULP\n");
+}
-- =

2.24.1

--===============5153761027457532720==--

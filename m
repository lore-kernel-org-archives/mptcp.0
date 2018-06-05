Content-Type: multipart/mixed; boundary="===============3417167199961203842=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 07/19] mptcp: Create SUBFLOW socket for
 outgoing connections
Date: Tue, 05 Jun 2018 16:40:26 -0700
Message-ID: <20180605234038.28497-8-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180605234038.28497-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 650

--===============3417167199961203842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Override the bind() and connect() methods of the MPTCP
socket so they may act on the subflow socket and use
the .sk_rx_dst_set() handler in the subflow proto to
capture when the responding SYN-ACK is received.

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 include/net/mptcp.h  |  46 ++++++++++-
 net/mptcp/Makefile   |   2 +-
 net/mptcp/protocol.c | 151 +++++++++++++++++++++++++++++++---
 net/mptcp/subflow.c  | 192 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 376 insertions(+), 15 deletions(-)
 create mode 100644 net/mptcp/subflow.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d26effbed0e0..b1cc841f95b0 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -39,7 +39,10 @@
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
 	struct	inet_connection_sock sk;
-	struct	socket *subflow;
+	u64	local_key;
+	u64	remote_key;
+	struct	socket *connection_list; /* @@ needs to be a list */
+	struct	socket *subflow; /* outgoing connect, listener or !mp_capable */
 };
 =

 static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
@@ -47,6 +50,42 @@ static inline struct mptcp_sock *mptcp_sk(const struct s=
ock *sk)
 	return (struct mptcp_sock *)sk;
 }
 =

+/* MPTCP subflow sock structure */
+struct subflow_sock {
+	/* tcp_sock must be the first member */
+	struct	tcp_sock sk;
+	u64	local_key;
+	u64	remote_key;
+	bool	request_mptcp;	// send MP_CAPABLE
+	bool	checksum;
+	bool	version;
+	bool	mp_capable;	// remote is MPTCP capable
+	bool	fourth_ack;	// send initial DSS
+	struct	sock *conn;     // parent mptcp_sock
+};
+
+static inline struct subflow_sock *subflow_sk(const struct sock *sk)
+{
+	return (struct subflow_sock *)sk;
+}
+
+struct subflow_request_sock {
+	struct	tcp_request_sock sk;
+	u8	mp_capable : 1,
+		mp_join : 1,
+		checksum : 1,
+		backup : 1,
+		version : 4;
+	u64	local_key;
+	u64	remote_key;
+};
+
+static inline
+struct subflow_request_sock *subflow_rsk(const struct request_sock *rsk)
+{
+	return (struct subflow_request_sock *)rsk;
+}
+
 #ifdef CONFIG_MPTCP
 =

 void mptcp_parse_option(const unsigned char *ptr, int opsize,
@@ -55,6 +94,11 @@ unsigned int mptcp_syn_options(struct sock *sk, u64 *loc=
al_key);
 unsigned int mptcp_synack_options(struct request_sock *req,
 				  u64 *local_key, u64 *remote_key);
 =

+void mptcp_finish_connect(struct sock *sk, int mp_capable);
+
+int mptcp_subflow_init(void);
+void mptcp_subflow_exit(void);
+
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *options);
 =

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 2bd18e3b9fda..3f0e7163fe80 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

-mptcp-y :=3D protocol.o options.o
+mptcp-y :=3D protocol.o subflow.o options.o
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 393d214fe531..368854740333 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -20,11 +20,13 @@
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
+#include <net/tcp.h>
 #include <net/mptcp.h>
 =

 static int mptcp_connect(struct sock *sk, struct sockaddr *saddr, int len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct subflow_sock *subflow =3D subflow_sk(msk->subflow->sk);
 	int err;
 =

 	saddr->sa_family =3D AF_INET;
@@ -32,18 +34,28 @@ static int mptcp_connect(struct sock *sk, struct sockad=
dr *saddr, int len)
 	pr_debug("msk=3D%p, subflow=3D%p", msk, msk->subflow->sk);
 =

 	err =3D kernel_connect(msk->subflow, saddr, len, 0);
-
-	sk->sk_state =3D TCP_ESTABLISHED;
-
+	pr_debug("mp_capable=3D%d", subflow->mp_capable);
+	if (!err) {
+		msk->remote_key =3D subflow->remote_key;
+		msk->local_key =3D subflow->local_key;
+		msk->connection_list =3D msk->subflow;
+		msk->subflow =3D NULL;
+	}
 	return err;
 }
 =

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow =3D msk->subflow;
+	struct socket *subflow;
 =

-	pr_debug("subflow=3D%p", subflow->sk);
+	if (msk->connection_list) {
+		subflow =3D msk->connection_list;
+		pr_debug("conn_list->subflow=3D%p", subflow->sk);
+	} else {
+		subflow =3D msk->subflow;
+		pr_debug("subflow=3D%p", subflow->sk);
+	}
 =

 	return sock_sendmsg(subflow, msg);
 }
@@ -52,9 +64,15 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr =
*msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow =3D msk->subflow;
+	struct socket *subflow;
 =

-	pr_debug("subflow=3D%p", subflow->sk);
+	if (msk->connection_list) {
+		subflow =3D msk->connection_list;
+		pr_debug("conn_list->subflow=3D%p", subflow->sk);
+	} else {
+		subflow =3D msk->subflow;
+		pr_debug("subflow=3D%p", subflow->sk);
+	}
 =

 	return sock_recvmsg(subflow, msg, flags);
 }
@@ -67,11 +85,19 @@ static int mptcp_init_sock(struct sock *sk)
 =

 	pr_debug("msk=3D%p", msk);
 =

-	err =3D sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
+	err =3D sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_SUBFLOW,
 			       &sf);
 	if (!err) {
-		pr_debug("subflow=3D%p", sf->sk);
+		struct subflow_sock *subflow =3D subflow_sk(sf->sk);
+
+		pr_debug("subflow=3D%p", subflow);
+		msk->local_key =3D 1234567887654321; // @@ fixed for now
 		msk->subflow =3D sf;
+		subflow->conn =3D sk;
+		subflow->request_mptcp =3D 1; // @@ if MPTCP enabled
+		subflow->checksum =3D 1; // @@ if checksum enabled
+		subflow->version =3D 0;
+		subflow->local_key =3D msk->local_key;
 	}
 =

 	return err;
@@ -85,6 +111,60 @@ static void mptcp_close(struct sock *sk, long timeout)
 		pr_debug("subflow=3D%p", msk->subflow->sk);
 		sock_release(msk->subflow);
 	}
+
+	if (msk->connection_list) {
+		pr_debug("conn_list->subflow=3D%p", msk->connection_list->sk);
+		sock_release(msk->connection_list);
+	}
+}
+
+static int mptcp_get_port(struct sock *sk, unsigned short snum)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct sock *subflow =3D msk->subflow->sk;
+
+	pr_debug("msk=3D%p, subflow=3D%p", sk, subflow);
+
+	return inet_csk_get_port(subflow, snum);
+}
+
+int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *subflow =3D msk->subflow;
+
+	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow->sk);
+
+	return inet_bind(subflow, uaddr, addr_len);
+}
+
+void mptcp_finish_connect(struct sock *sk, int mp_capable)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct subflow_sock *subflow =3D subflow_sk(msk->subflow->sk);
+
+	pr_debug("msk=3D%p", msk);
+
+	if (mp_capable) {
+		msk->remote_key =3D subflow->remote_key;
+		msk->local_key =3D subflow->local_key;
+		msk->connection_list =3D msk->subflow;
+		msk->subflow =3D NULL;
+	}
+	sk->sk_state =3D TCP_ESTABLISHED;
+}
+
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+			 int addr_len, int flags)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	int err;
+
+	pr_debug("msk=3D%p, subflow=3D%p", msk, msk->subflow->sk);
+
+	err =3D inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
+
+	return err;
 }
 =

 static struct proto mptcp_prot =3D {
@@ -99,35 +179,80 @@ static struct proto mptcp_prot =3D {
 	.recvmsg	=3D mptcp_recvmsg,
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
-	.get_port	=3D inet_csk_get_port,
+	.get_port	=3D mptcp_get_port,
 	.obj_size	=3D sizeof(struct mptcp_sock),
 	.no_autobind	=3D 1,
 };
 =

+const struct proto_ops mptcp_stream_ops =3D {
+	.family		   =3D PF_INET,
+	.owner		   =3D THIS_MODULE,
+	.release	   =3D inet_release,
+	.bind		   =3D mptcp_bind,
+	.connect	   =3D mptcp_stream_connect,
+	.socketpair	   =3D sock_no_socketpair,
+	.accept		   =3D inet_accept,
+	.getname	   =3D inet_getname,
+	.poll		   =3D tcp_poll,
+	.ioctl		   =3D inet_ioctl,
+	.listen		   =3D inet_listen,
+	.shutdown	   =3D inet_shutdown,
+	.setsockopt	   =3D sock_common_setsockopt,
+	.getsockopt	   =3D sock_common_getsockopt,
+	.sendmsg	   =3D inet_sendmsg,
+	.recvmsg	   =3D inet_recvmsg,
+	.mmap		   =3D sock_no_mmap,
+	.sendpage	   =3D inet_sendpage,
+	.splice_read	   =3D tcp_splice_read,
+	.read_sock	   =3D tcp_read_sock,
+	.peek_len	   =3D tcp_peek_len,
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt =3D compat_sock_common_setsockopt,
+	.compat_getsockopt =3D compat_sock_common_getsockopt,
+	.compat_ioctl	   =3D inet_compat_ioctl,
+#endif
+};
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

 static int __init mptcp_init(void)
 {
 	int err;
 =

-	err =3D proto_register(&mptcp_prot, 1);
+	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
+
+	err =3D mptcp_subflow_init();
 	if (err)
-		return err;
+		goto subflow_failed;
+
+	err =3D proto_register(&mptcp_prot, 1);
+	if (err) {
+		goto proto_failed;
+	}
 =

 	inet_register_protosw(&mptcp_protosw);
 =

 	return 0;
+
+proto_failed:
+	mptcp_subflow_exit();
+
+subflow_failed:
+	return err;
 }
 =

 static void __exit mptcp_exit(void)
 {
 	inet_unregister_protosw(&mptcp_protosw);
 	proto_unregister(&mptcp_prot);
+
+	mptcp_subflow_exit();
 }
 =

 module_init(mptcp_init);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
new file mode 100644
index 000000000000..5e5fdcb3175f
--- /dev/null
+++ b/net/mptcp/subflow.c
@@ -0,0 +1,192 @@
+/*
+ * Multipath TCP
+ *
+ * Copyright (c) 2017, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
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
+
+static int subflow_connect(struct sock *sk, struct sockaddr *saddr, int le=
n)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	saddr->sa_family =3D AF_INET; // @@ presume IPv4 for now
+
+	pr_debug("subflow=3D%p", subflow);
+
+	return tcp_v4_connect(sk, saddr, len);
+}
+
+static int subflow_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	return tcp_sendmsg(sk, msg, len);
+}
+
+static int subflow_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			   int nonblock, int flags, int *addr_len)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
+}
+
+static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	inet_sk_rx_dst_set(sk, skb);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	if (subflow->conn) {
+		pr_debug("remote_key=3D%llu", subflow->remote_key);
+		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
+		subflow->conn =3D NULL;
+	}
+}
+
+const struct inet_connection_sock_af_ops subflow_specific =3D {
+	.queue_xmit	   =3D ip_queue_xmit,
+	.send_check	   =3D tcp_v4_send_check,
+	.rebuild_header	   =3D inet_sk_rebuild_header,
+	.sk_rx_dst_set	   =3D subflow_finish_connect,
+	.conn_request	   =3D tcp_v4_conn_request,
+	.syn_recv_sock	   =3D tcp_v4_syn_recv_sock,
+	.net_header_len	   =3D sizeof(struct iphdr),
+	.setsockopt	   =3D ip_setsockopt,
+	.getsockopt	   =3D ip_getsockopt,
+	.addr2sockaddr	   =3D inet_csk_addr2sockaddr,
+	.sockaddr_len	   =3D sizeof(struct sockaddr_in),
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt =3D compat_ip_setsockopt,
+	.compat_getsockopt =3D compat_ip_getsockopt,
+#endif
+	.mtu_reduced	   =3D tcp_v4_mtu_reduced,
+};
+
+static int subflow_init_sock(struct sock *sk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+	struct tcp_sock *tsk =3D tcp_sk(sk);
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	int err;
+
+	pr_debug("subflow=3D%p", subflow);
+
+	err =3D tcp_v4_init_sock(sk);
+	if (!err) { // @@ AND mptcp is enabled
+		tsk->is_mptcp =3D 1;
+		icsk->icsk_af_ops =3D &subflow_specific;
+	}
+
+	return err;
+}
+
+static void subflow_close(struct sock *sk, long timeout)
+{
+	pr_debug("subflow=3D%p", sk);
+
+	tcp_close(sk, timeout);
+}
+
+static void subflow_destroy(struct sock *sk)
+{
+	pr_debug("subflow=3D%p", sk);
+
+	tcp_v4_destroy_sock(sk);
+}
+
+static struct proto subflow_prot =3D {
+	.name		=3D "SUBFLOW",
+	.owner		=3D THIS_MODULE,
+	.close		=3D subflow_close,
+	.connect	=3D subflow_connect,
+	.disconnect	=3D tcp_disconnect,
+	.accept		=3D inet_csk_accept,
+	.ioctl		=3D tcp_ioctl,
+	.init		=3D subflow_init_sock,
+	.destroy	=3D subflow_destroy,
+	.shutdown	=3D tcp_shutdown,
+	.keepalive	=3D tcp_set_keepalive,
+	.recvmsg	=3D subflow_recvmsg,
+	.sendmsg	=3D subflow_sendmsg,
+	.sendpage	=3D tcp_sendpage,
+	.backlog_rcv	=3D tcp_v4_do_rcv,
+	.release_cb	=3D tcp_release_cb,
+	.hash		=3D inet_hash,
+	.unhash		=3D inet_unhash,
+	.get_port	=3D inet_csk_get_port,
+	.enter_memory_pressure	=3D tcp_enter_memory_pressure,
+	.stream_memory_free	=3D tcp_stream_memory_free,
+	.sockets_allocated	=3D &tcp_sockets_allocated,
+	.orphan_count		=3D &tcp_orphan_count,
+	.memory_allocated	=3D &tcp_memory_allocated,
+	.memory_pressure	=3D &tcp_memory_pressure,
+	.sysctl_mem		=3D sysctl_tcp_mem,
+	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
+	.sysctl_rmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_rmem),
+	.max_header		=3D MAX_TCP_HEADER,
+	.obj_size		=3D sizeof(struct subflow_sock),
+	.slab_flags		=3D SLAB_TYPESAFE_BY_RCU,
+
+	.no_autobind		=3D true,
+};
+
+static struct inet_protosw subflow_protosw =3D {
+	.type		=3D SOCK_STREAM,
+	.protocol	=3D IPPROTO_SUBFLOW,
+	.prot		=3D &subflow_prot,
+	.ops		=3D &inet_stream_ops,
+	.flags		=3D INET_PROTOSW_ICSK,
+};
+
+int mptcp_subflow_init(void)
+{
+	int err =3D -ENOMEM;
+
+	/* TODO: Register path manager callbacks. */
+
+	subflow_prot.twsk_prot		=3D tcp_prot.twsk_prot;
+	subflow_prot.h.hashinfo		=3D tcp_prot.h.hashinfo;
+	err =3D proto_register(&subflow_prot, 1);
+	if (err)
+		goto fail;
+
+	inet_register_protosw(&subflow_protosw);
+
+	return 0;
+
+fail:
+	return err;
+}
+
+void mptcp_subflow_exit(void)
+{
+	inet_unregister_protosw(&subflow_protosw);
+	proto_unregister(&subflow_prot);
+}
+
+MODULE_LICENSE("GPL");
-- =

2.17.1


--===============3417167199961203842==--

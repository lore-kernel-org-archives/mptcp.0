Content-Type: multipart/mixed; boundary="===============3834985054058189907=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v4 07/17] mptcp: Create SUBFLOW socket for
 outgoing connections
Date: Fri, 30 Nov 2018 12:11:02 -0800
Message-ID: <20181130201112.21806-8-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181130201112.21806-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 860

--===============3834985054058189907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Add subflow_sock type that extends tcp_sock and add an
is_mptcp flag to tcp_sock to distinguish them.

Override the bind() and connect() methods of the MPTCP
socket proto_ops so they may act on the subflow socket
instead, and use the .sk_rx_dst_set() handler in the subflow
proto to capture when the responding SYN-ACK is received.

Add handling in tcp_output.c to add MP_CAPABLE to an outgoing
SYN request for a subflow_sock and to the final ACK of the
three-way handshake.

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 include/linux/tcp.h   |   2 +
 include/net/mptcp.h   |  47 ++++++++++-
 include/net/tcp.h     |   2 +-
 net/ipv4/tcp_input.c  |   3 +
 net/ipv4/tcp_output.c |  33 ++++++--
 net/mptcp/Makefile    |   2 +-
 net/mptcp/options.c   |  40 +++++++++
 net/mptcp/protocol.c  | 161 +++++++++++++++++++++++++++++------
 net/mptcp/subflow.c   | 192 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 448 insertions(+), 34 deletions(-)
 create mode 100644 net/mptcp/subflow.c

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 5778de6b6277..2622817ecd6b 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -412,6 +412,8 @@ struct tcp_sock {
 	 */
 	struct request_sock *fastopen_rsk;
 	u32	*saved_syn;
+
+	bool	is_mptcp;
 };
 =

 enum tsq_enum {
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 79daad717275..a5c2baeb688f 100644
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
@@ -47,10 +50,38 @@ static inline struct mptcp_sock *mptcp_sk(const struct =
sock *sk)
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
+	struct	sock *conn;	// parent mptcp_sock
+};
+
+static inline struct subflow_sock *subflow_sk(const struct sock *sk)
+{
+	return (struct subflow_sock *)sk;
+}
+
 #ifdef CONFIG_MPTCP
 =

 void mptcp_parse_option(const unsigned char *ptr, int opsize,
 			struct tcp_options_received *opt_rx);
+unsigned int mptcp_syn_options(struct sock *sk, u64 *local_key);
+void mptcp_rcv_synsent(struct sock *sk);
+unsigned int mptcp_established_options(struct sock *sk, u64 *local_key,
+				       u64 *remote_key);
+
+void mptcp_finish_connect(struct sock *sk, int mp_capable);
+
+int mptcp_subflow_init(void);
+void mptcp_subflow_exit(void);
 =

 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *options);
@@ -64,7 +95,21 @@ static inline void mptcp_parse_option(const unsigned cha=
r *ptr, int opsize,
 {
 }
 =

+static inline unsigned int mptcp_syn_options(struct sock *sk, u64 *local_k=
ey)
+{
+	return 0;
+}
 =

+static inline void mptcp_rcv_synsent(struct sock *sk)
+{
+}
+
+static inline unsigned int mptcp_established_options(struct sock *sk,
+						     u64 *local_key,
+						     u64 *remote_key)
+{
+	return 0;
+}
 =

 #endif /* CONFIG_MPTCP */
 #endif /* __NET_MPTCP_H */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 63ce0e37724b..254cf82e2ec6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -216,7 +216,7 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
 #define TCPOLEN_MPTCP_MPC_SYN		12
-#define TCPOLEN_MPTCP_MPC_SYNACK	20
+#define TCPOLEN_MPTCP_MPC_ACK		20
 =

 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 77bd2efa44f1..eda515b141fb 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5864,6 +5864,9 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		tcp_initialize_rcv_mss(sk);
 =

+		if (tp->is_mptcp)
+			mptcp_rcv_synsent(sk);
+
 		/* Remember, tcp_poll() does not lock socket!
 		 * Change state from SYN-SENT only after copied_seq
 		 * is initialized. */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 53bede957e0a..4f284ed879ba 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -416,7 +416,6 @@ static inline bool tcp_urg_mode(const struct tcp_sock *=
tp)
 =

 /* MPTCP option subtypes */
 #define OPTION_MPTCP_MPC_SYN	(1 << 0)
-#define OPTION_MPTCP_MPC_SYNACK	(1 << 1)
 #define OPTION_MPTCP_MPC_ACK	(1 << 2)
 =

 struct tcp_out_options {
@@ -440,7 +439,6 @@ static void mptcp_options_write(__be32 *ptr, struct tcp=
_out_options *opts)
 		return;
 =

 	if ((OPTION_MPTCP_MPC_SYN |
-	     OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
 		u8 len;
 		__be64 key;
@@ -448,7 +446,7 @@ static void mptcp_options_write(__be32 *ptr, struct tcp=
_out_options *opts)
 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
 			len =3D TCPOLEN_MPTCP_MPC_SYN;
 		else
-			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
+			len =3D TCPOLEN_MPTCP_MPC_ACK;
 =

 		*ptr++ =3D htonl((0x1e << 24) | // TCP option: Multipath TCP
 			       (len << 16)  | // length
@@ -457,8 +455,7 @@ static void mptcp_options_write(__be32 *ptr, struct tcp=
_out_options *opts)
 		key =3D cpu_to_be64(opts->sndr_key);
 		memcpy((u8 *) ptr, (u8 *) &key, 8);
 		ptr +=3D 2;
-		if ((OPTION_MPTCP_MPC_SYNACK |
-		     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
+		if (OPTION_MPTCP_MPC_ACK & opts->suboptions) {
 			key =3D cpu_to_be64(opts->rcvr_key);
 			memcpy((u8 *) ptr, (u8 *) &key, 8);
 			ptr +=3D 2;
@@ -695,6 +692,16 @@ static unsigned int tcp_syn_options(struct sock *sk, s=
truct sk_buff *skb,
 =

 	smc_set_option(tp, opts, &remaining);
 =

+	if (tp->is_mptcp) {
+		u64 local_key;
+		if (mptcp_syn_options(sk, &local_key)) {
+			opts->options |=3D OPTION_MPTCP;
+			opts->suboptions =3D OPTION_MPTCP_MPC_SYN;
+			opts->sndr_key =3D local_key;
+			remaining -=3D TCPOLEN_MPTCP_MPC_SYN;
+		}
+	}
+
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
 =

@@ -802,6 +809,22 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
 	}
 =

+	if (tp->is_mptcp) {
+		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
+		u64 local_key;
+		u64 remote_key;
+
+		if (mptcp_established_options(sk, &local_key, &remote_key)) {
+			if (remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
+				opts->options |=3D OPTION_MPTCP;
+				opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
+				opts->sndr_key =3D local_key;
+				opts->rcvr_key =3D remote_key;
+				size +=3D TCPOLEN_MPTCP_MPC_ACK;
+			}
+		}
+	}
+
 	return size;
 }
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
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6e0a1ec56658..b0616f520da0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -149,3 +149,43 @@ void mptcp_get_options(const struct sk_buff *skb,
 		}
 	}
 }
+
+unsigned int mptcp_syn_options(struct sock *sk, u64 *local_key)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	if (subflow->request_mptcp) {
+		pr_debug("local_key=3D%llu", subflow->local_key);
+		*local_key =3D subflow->local_key;
+	}
+	return subflow->request_mptcp;
+}
+
+void mptcp_rcv_synsent(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
+		subflow->mp_capable =3D 1;
+		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
+	}
+}
+
+unsigned int mptcp_established_options(struct sock *sk, u64 *local_key,
+				       u64 *remote_key)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+	if (subflow->mp_capable && !subflow->fourth_ack) {
+		subflow->fourth_ack =3D 1;
+		*local_key =3D subflow->local_key;
+		*remote_key =3D subflow->remote_key;
+		pr_debug("local_key=3D%llu", *local_key);
+		pr_debug("remote_key=3D%llu", *remote_key);
+		return 1;
+	}
+	return 0;
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c1eb4afc3ca4..1a3412a742ea 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -26,9 +26,15 @@
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow =3D msk->subflow;
-
-	pr_debug("subflow=3D%p", subflow->sk);
+	struct socket *subflow;
+
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
@@ -37,9 +43,15 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr =
*msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow =3D msk->subflow;
-
-	pr_debug("subflow=3D%p", subflow->sk);
+	struct socket *subflow;
+
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
@@ -47,19 +59,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *sf;
-	int err;
 =

 	pr_debug("msk=3D%p", msk);
 =

-	err =3D sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			       &sf);
-	if (!err) {
-		pr_debug("subflow=3D%p", sf->sk);
-		msk->subflow =3D sf;
-	}
-
-	return err;
+	return 0;
 }
 =

 static void mptcp_close(struct sock *sk, long timeout)
@@ -70,65 +73,171 @@ static void mptcp_close(struct sock *sk, long timeout)
 		pr_debug("subflow=3D%p", msk->subflow->sk);
 		sock_release(msk->subflow);
 	}
+
+	if (msk->connection_list) {
+		pr_debug("conn_list->subflow=3D%p", msk->connection_list->sk);
+		sock_release(msk->connection_list);
+	}
 }
 =

-static int mptcp_connect(struct sock *sk, struct sockaddr *saddr, int len)
+static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	int err;
+	struct sock *subflow =3D msk->subflow->sk;
+
+	pr_debug("msk=3D%p, subflow=3D%p", sk, subflow);
 =

-	saddr->sa_family =3D AF_INET;
+	return inet_csk_get_port(subflow, snum);
+}
 =

-	pr_debug("msk=3D%p, subflow=3D%p", msk, msk->subflow->sk);
+void mptcp_finish_connect(struct sock *sk, int mp_capable)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct subflow_sock *subflow =3D subflow_sk(msk->subflow->sk);
 =

-	err =3D kernel_connect(msk->subflow, saddr, len, 0);
+	pr_debug("msk=3D%p", msk);
 =

+	if (mp_capable) {
+		msk->remote_key =3D subflow->remote_key;
+		msk->local_key =3D subflow->local_key;
+		msk->connection_list =3D msk->subflow;
+		msk->subflow =3D NULL;
+	}
 	sk->sk_state =3D TCP_ESTABLISHED;
+}
 =

+static int subflow_create(struct sock *sock)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock);
+	struct socket *sf;
+	int err;
+
+	err =3D sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_SUBFLOW,
+			       &sf);
+	if (!err) {
+		struct subflow_sock *subflow =3D subflow_sk(sf->sk);
+		pr_debug("subflow=3D%p", subflow);
+		msk->subflow =3D sf;
+		subflow->conn =3D sock;
+		subflow->request_mptcp =3D 1; // @@ if MPTCP enabled
+		subflow->checksum =3D 1; // @@ if checksum enabled
+		subflow->version =3D 0;
+	}
 	return err;
 }
 =

+int mptcp_stream_bind(struct socket *sock, struct sockaddr *uaddr, int add=
r_len)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *subflow =3D msk->subflow;
+
+	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow->sk);
+
+	return inet_bind(subflow, uaddr, addr_len);
+}
+
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+			 int addr_len, int flags)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	int err;
+
+	pr_debug("msk=3D%p", msk);
+
+	if (msk->subflow =3D=3D NULL) {
+		err =3D subflow_create(sock->sk);
+		if (err)
+			return err;
+	}
+
+	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
+}
+
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
 	.init		=3D mptcp_init_sock,
 	.close		=3D mptcp_close,
 	.accept		=3D inet_csk_accept,
-	.connect	=3D mptcp_connect,
 	.shutdown	=3D tcp_shutdown,
 	.sendmsg	=3D mptcp_sendmsg,
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
+	.bind		   =3D mptcp_stream_bind,
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

2.19.1


--===============3834985054058189907==--

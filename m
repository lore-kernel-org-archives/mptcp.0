Content-Type: multipart/mixed; boundary="===============7823947081883154776=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v4 03/17] mptcp: Add MPTCP socket stubs
Date: Fri, 30 Nov 2018 12:10:58 -0800
Message-ID: <20181130201112.21806-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181130201112.21806-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 856

--===============7823947081883154776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Implements the infrastructure for MPTCP sockets.

MPTCP sockets open one in-kernel TCP socket per subflow. These subflow
sockets are only managed by the MPTCP socket that owns them and are not
visible from userspace. This commit allows a userspace program to open
an MPTCP socket with:

  sock =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);

The resulting socket is simply a wrapper around a single regular TCP
socket, without any of the MPTCP protocol implemented over the wire.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/mptcp.h  |  33 ++++++++++
 net/Kconfig          |   1 +
 net/Makefile         |   1 +
 net/mptcp/Kconfig    |  10 ++++
 net/mptcp/Makefile   |   3 +
 net/mptcp/protocol.c | 139 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 187 insertions(+)
 create mode 100644 include/net/mptcp.h
 create mode 100644 net/mptcp/Kconfig
 create mode 100644 net/mptcp/Makefile
 create mode 100644 net/mptcp/protocol.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
new file mode 100644
index 000000000000..7f7b18b000fe
--- /dev/null
+++ b/include/net/mptcp.h
@@ -0,0 +1,33 @@
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
+#ifndef __NET_MPTCP_H
+#define __NET_MPTCP_H
+
+#include <linux/tcp.h>
+
+/* MPTCP connection sock */
+struct mptcp_sock {
+	/* inet_connection_sock must be the first member */
+	struct	inet_connection_sock sk;
+	struct	socket *subflow;
+};
+
+static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
+{
+	return (struct mptcp_sock *)sk;
+}
+
+#endif /* __NET_MPTCP_H */
diff --git a/net/Kconfig b/net/Kconfig
index f235edb593ba..96abc0a881f6 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -89,6 +89,7 @@ if INET
 source "net/ipv4/Kconfig"
 source "net/ipv6/Kconfig"
 source "net/netlabel/Kconfig"
+source "net/mptcp/Kconfig"
 =

 endif # if INET
 =

diff --git a/net/Makefile b/net/Makefile
index bdaf53925acd..1673aab222d8 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -87,3 +87,4 @@ endif
 obj-$(CONFIG_QRTR)		+=3D qrtr/
 obj-$(CONFIG_NET_NCSI)		+=3D ncsi/
 obj-$(CONFIG_XDP_SOCKETS)	+=3D xdp/
+obj-$(CONFIG_MPTCP)		+=3D mptcp/
diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
new file mode 100644
index 000000000000..8e48190e5fed
--- /dev/null
+++ b/net/mptcp/Kconfig
@@ -0,0 +1,10 @@
+
+config MPTCP
+	bool "Multipath TCP"
+	depends on INET
+	---help---
+	  Multipath TCP (MPTCP) connections send and receive data over multiple
+	  subflows in order to utilize multiple network paths. Each subflow
+	  uses the TCP protocol, and TCP options carry header information for
+	  MPTCP.
+
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
new file mode 100644
index 000000000000..5624e7d51d48
--- /dev/null
+++ b/net/mptcp/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_MPTCP) +=3D mptcp.o
+
+mptcp-y :=3D protocol.o
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
new file mode 100644
index 000000000000..c1eb4afc3ca4
--- /dev/null
+++ b/net/mptcp/protocol.c
@@ -0,0 +1,139 @@
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
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *subflow =3D msk->subflow;
+
+	pr_debug("subflow=3D%p", subflow->sk);
+
+	return sock_sendmsg(subflow, msg);
+}
+
+static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			 int nonblock, int flags, int *addr_len)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *subflow =3D msk->subflow;
+
+	pr_debug("subflow=3D%p", subflow->sk);
+
+	return sock_recvmsg(subflow, msg, flags);
+}
+
+static int mptcp_init_sock(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *sf;
+	int err;
+
+	pr_debug("msk=3D%p", msk);
+
+	err =3D sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
+			       &sf);
+	if (!err) {
+		pr_debug("subflow=3D%p", sf->sk);
+		msk->subflow =3D sf;
+	}
+
+	return err;
+}
+
+static void mptcp_close(struct sock *sk, long timeout)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (msk->subflow) {
+		pr_debug("subflow=3D%p", msk->subflow->sk);
+		sock_release(msk->subflow);
+	}
+}
+
+static int mptcp_connect(struct sock *sk, struct sockaddr *saddr, int len)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	int err;
+
+	saddr->sa_family =3D AF_INET;
+
+	pr_debug("msk=3D%p, subflow=3D%p", msk, msk->subflow->sk);
+
+	err =3D kernel_connect(msk->subflow, saddr, len, 0);
+
+	sk->sk_state =3D TCP_ESTABLISHED;
+
+	return err;
+}
+
+static struct proto mptcp_prot =3D {
+	.name		=3D "MPTCP",
+	.owner		=3D THIS_MODULE,
+	.init		=3D mptcp_init_sock,
+	.close		=3D mptcp_close,
+	.accept		=3D inet_csk_accept,
+	.connect	=3D mptcp_connect,
+	.shutdown	=3D tcp_shutdown,
+	.sendmsg	=3D mptcp_sendmsg,
+	.recvmsg	=3D mptcp_recvmsg,
+	.hash		=3D inet_hash,
+	.unhash		=3D inet_unhash,
+	.get_port	=3D inet_csk_get_port,
+	.obj_size	=3D sizeof(struct mptcp_sock),
+	.no_autobind	=3D 1,
+};
+
+static struct inet_protosw mptcp_protosw =3D {
+	.type		=3D SOCK_STREAM,
+	.protocol	=3D IPPROTO_MPTCP,
+	.prot		=3D &mptcp_prot,
+	.ops		=3D &inet_stream_ops,
+};
+
+static int __init mptcp_init(void)
+{
+	int err;
+
+	err =3D proto_register(&mptcp_prot, 1);
+	if (err)
+		return err;
+
+	inet_register_protosw(&mptcp_protosw);
+
+	return 0;
+}
+
+static void __exit mptcp_exit(void)
+{
+	inet_unregister_protosw(&mptcp_protosw);
+	proto_unregister(&mptcp_prot);
+}
+
+module_init(mptcp_init);
+module_exit(mptcp_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_NET_PF_PROTO(PF_INET, IPPROTO_MPTCP);
+MODULE_ALIAS_NET_PF_PROTO(PF_INET6, IPPROTO_MPTCP);
-- =

2.19.1


--===============7823947081883154776==--

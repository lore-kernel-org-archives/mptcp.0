Content-Type: multipart/mixed; boundary="===============5456551007773129387=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: Implement basic path manager
Date: Tue, 17 Sep 2019 11:37:50 -0700
Message-ID: <20190917183750.2693-3-peter.krystad@linux.intel.com>
In-Reply-To: 20190917183750.2693-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1868

--===============5456551007773129387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two features: 1) After an incoming connection is fully established
announce a second local address and 2) When an outgoing connection
is fully established, and an ADD_ADDR option has been received,
initiate a secondary subflow to that address.

The second local address may be configured through the
net.mptcp.pm.announce_addr sysctl variable. If configured
then for listeners this address will be announced with the
ADD_ADDR option, and for clients the local socket will be bound
to this address (or INADDR_ANY if not specified).

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/Makefile   |   2 +-
 net/mptcp/basic.c    | 247 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/pm.c       |   7 ++
 net/mptcp/protocol.c |   1 +
 net/mptcp/protocol.h |   5 +
 5 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/basic.c

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 289fdf4339c1..7dc8853ea498 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

-mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctrl.o
+mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctrl.o b=
asic.o
diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
new file mode 100644
index 000000000000..40f3496c5d73
--- /dev/null
+++ b/net/mptcp/basic.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2019, Intel Corporation.
+ */
+#include <linux/inet.h>
+#include <linux/kernel.h>
+#include <net/tcp.h>
+#include <net/netns/generic.h>
+#include <net/mptcp.h>
+#include "protocol.h"
+
+static int basic_pernet_id;
+
+struct basic_pernet {
+	struct ctl_table_header *ctl_table_hdr;
+
+	union {
+		struct in_addr announce_v4_addr;
+#if IS_ENABLED(CONFIG_IPV6)
+		struct in6_addr announce_v6_addr;
+#endif
+	};
+	u8	has_announce_v4 : 1,
+		has_announce_v6 : 1;
+};
+
+static struct workqueue_struct *basic_wq;
+static void announce_addr_worker(struct work_struct *work);
+static void create_subflow_worker(struct work_struct *work);
+
+static int parse_addr(struct basic_pernet *pernet, const char *addr)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (in6_pton(addr, -1, (u8 *)&pernet->announce_v6_addr.s6_addr, '\0',
+		     NULL) > 0) {
+		pernet->has_announce_v4 =3D 0;
+		pernet->has_announce_v6 =3D 1;
+		return 0;
+	}
+#endif
+
+	if (in4_pton(addr, -1, (u8 *)&pernet->announce_v4_addr.s_addr, '\0',
+		     NULL) > 0) {
+		pernet->has_announce_v4 =3D 1;
+		pernet->has_announce_v6 =3D 0;
+		return 0;
+	}
+
+	pernet->has_announce_v4 =3D 0;
+	pernet->has_announce_v6 =3D 0;
+
+	return -1;
+}
+
+static int proc_parse_addr(struct ctl_table *ctl, int write,
+			   void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net =3D current->nsproxy->net_ns;
+	struct basic_pernet *pernet =3D net_generic(net, basic_pernet_id);
+	struct ctl_table tbl;
+
+	char *none =3D "none";
+	char tmp[INET6_ADDRSTRLEN] =3D { 0 };
+	int ret;
+
+	memset(&tbl, 0, sizeof(struct ctl_table));
+
+	if (write) {
+		tbl.data =3D tmp;
+		tbl.maxlen =3D sizeof(tmp);
+	} else {
+		if (pernet->has_announce_v4) {
+			snprintf(tmp, INET_ADDRSTRLEN, "%pI4",
+				 &pernet->announce_v4_addr);
+			tbl.data =3D tmp;
+#if IS_ENABLED(CONFIG_IPV6)
+		} else if (pernet->has_announce_v6) {
+			snprintf(tmp, INET6_ADDRSTRLEN, "%pI6c",
+				 &pernet->announce_v6_addr);
+			tbl.data =3D tmp;
+#endif
+		} else {
+			tbl.data =3D none;
+		}
+		tbl.maxlen =3D strlen(tbl.data);
+	}
+
+	ret =3D proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (write && ret =3D=3D 0) {
+		/* "none" string: we want to remove it */
+		if (strncmp(none, tmp, 5) =3D=3D 0) {
+			pernet->has_announce_v4 =3D 0;
+			pernet->has_announce_v6 =3D 0;
+		} else if (parse_addr(pernet, tmp) < 0) {
+			ret =3D -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static struct ctl_table basic_sysctl_table[] =3D {
+	{
+		.procname =3D "announce_addr",
+		.maxlen =3D sizeof(char) * (INET6_ADDRSTRLEN),
+		.mode =3D 0644,
+		.proc_handler =3D proc_parse_addr
+	},
+	{}
+};
+
+static int basic_pernet_create_table(struct net *net,
+				     struct basic_pernet *pernet)
+{
+	struct ctl_table *table;
+	struct ctl_table_header *hdr;
+
+	table =3D basic_sysctl_table;
+	if (!net_eq(net, &init_net)) {
+		table =3D kmemdup(table, sizeof(basic_sysctl_table),
+				GFP_KERNEL);
+		if (!table)
+			goto err_alloc;
+	}
+
+	hdr =3D register_net_sysctl(net, "net/mptcp/pm", table);
+	if (!hdr)
+		goto err_reg;
+
+	pernet->ctl_table_hdr =3D hdr;
+
+	return 0;
+
+err_reg:
+	if (!net_eq(net, &init_net))
+		kfree(table);
+err_alloc:
+	return -ENOMEM;
+}
+
+static int __net_init basic_init_net(struct net *net)
+{
+	struct basic_pernet *pernet =3D net_generic(net, basic_pernet_id);
+	int ret;
+
+	ret =3D basic_pernet_create_table(net, pernet);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void __net_exit basic_exit_net(struct net *net)
+{
+	struct basic_pernet *pernet =3D net_generic(net, basic_pernet_id);
+	struct ctl_table *table =3D pernet->ctl_table_hdr->ctl_table_arg;
+
+	unregister_net_sysctl_table(pernet->ctl_table_hdr);
+
+	/* Note: the callback will only be called per extra netns */
+	kfree(table);
+}
+
+static struct pernet_operations basic_pernet_ops =3D {
+	.init =3D basic_init_net,
+	.exit =3D basic_exit_net,
+	.id =3D &basic_pernet_id,
+	.size =3D sizeof(struct basic_pernet),
+};
+
+void mptcp_basic_init(void)
+{
+	if (register_pernet_subsys(&basic_pernet_ops) < 0)
+		panic("Failed to register MPTCP PM pernet subsystem.\n");
+
+	basic_wq =3D alloc_workqueue("basic_wq",
+				   WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
+	if (!basic_wq)
+		panic("Failed to allocate workqueue");
+}
+
+static void announce_addr_worker(struct work_struct *work)
+{
+	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
+						addr_work);
+	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+	struct basic_pernet *pernet;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), basic_pernet_id);
+
+	if (pernet->has_announce_v4)
+		pm_announce_addr(pm->token, 1, AF_INET,
+				 &pernet->announce_v4_addr);
+	sock_put((struct sock *)msk);
+}
+
+static void create_subflow_worker(struct work_struct *work)
+{
+	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
+						subflow_work);
+	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+	struct basic_pernet *pernet;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), basic_pernet_id);
+
+	if (pernet->has_announce_v4) {
+		pm_create_subflow(pm->token, pm->remote_id, AF_INET,
+				  &pernet->announce_v4_addr);
+	} else {
+		pm_create_subflow(pm->token, pm->remote_id, 0, NULL);
+	}
+	sock_put((struct sock *)msk);
+}
+
+void mptcp_basic_new_connection(struct mptcp_pm_data *pm)
+{
+	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+
+	if (pm->server_side) {
+		INIT_WORK(&pm->addr_work, announce_addr_worker);
+		if (queue_work(basic_wq, &pm->addr_work))
+			sock_hold((struct sock *)msk);
+	}
+}
+
+void mptcp_basic_fully_established(struct mptcp_pm_data *pm)
+{
+	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+
+	if (!pm->server_side && !pm->fully_established && pm->remote_valid) {
+		INIT_WORK(&pm->subflow_work, create_subflow_worker);
+		if (queue_work(basic_wq, &pm->subflow_work))
+			sock_hold((struct sock *)msk);
+	}
+}
+
+void mptcp_basic_add_addr(struct mptcp_pm_data *pm)
+{
+	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+
+	if (!pm->server_side && !pm->remote_valid && pm->fully_established) {
+		INIT_WORK(&pm->subflow_work, create_subflow_worker);
+		if (queue_work(basic_wq, &pm->subflow_work))
+			sock_hold((struct sock *)msk);
+	}
+}
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0ce36cc912c..88b5cf6046fe 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -101,6 +101,8 @@ void pm_new_connection(struct mptcp_sock *msk, int serv=
er_side)
 =

 	pm->server_side =3D server_side;
 	pm->token =3D msk->token;
+
+	mptcp_basic_new_connection(pm);
 }
 =

 void pm_fully_established(struct mptcp_sock *msk)
@@ -109,6 +111,8 @@ void pm_fully_established(struct mptcp_sock *msk)
 =

 	pr_debug("msk=3D%p", msk);
 =

+	mptcp_basic_fully_established(pm);
+
 	pm->fully_established =3D 1;
 }
 =

@@ -136,6 +140,9 @@ void pm_add_addr(struct mptcp_sock *msk, const struct i=
n_addr *addr, u8 id)
 	pm->remote_addr.s_addr =3D addr->s_addr;
 	pm->remote_id =3D id;
 	pm->remote_family =3D AF_INET;
+
+	mptcp_basic_add_addr(pm);
+
 	pm->remote_valid =3D 1;
 }
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2fcdf11a653a..80cd984d1e01 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1130,6 +1130,7 @@ void mptcp_proto_init(void)
 	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

 	subflow_init();
+	mptcp_basic_init();
 =

 	if (proto_register(&mptcp_prot, 1) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fcf78fc0df84..ac5f87495348 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -273,6 +273,11 @@ int pm_addr_signal(struct mptcp_sock *msk, u8 *id,
 int pm_get_local_id(struct request_sock *req, struct sock *sk,
 		    const struct sk_buff *skb);
 =

+void mptcp_basic_init(void);
+void mptcp_basic_new_connection(struct mptcp_pm_data *pm);
+void mptcp_basic_fully_established(struct mptcp_pm_data *pm);
+void mptcp_basic_add_addr(struct mptcp_pm_data *pm);
+
 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
-- =

2.17.2


--===============5456551007773129387==--

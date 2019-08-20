Content-Type: multipart/mixed; boundary="===============1901288098278389406=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH] mptcp:pm: sysctl to announce an addr
Date: Tue, 20 Aug 2019 17:16:51 +0200
Message-ID: <20190820151651.32744-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1662

--===============1901288098278389406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of hard-coding the address in the code, we can now dynamically
pass the value and allow tests.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    Here is an RFC patch that I built on top of Peter's patch. This patch
    (mptcp: Implement interim path manager) is also marked as RFC.
    =

    So far, I only tested that the sysctl was OK, I didn't validate that the
    address was correctly announced.

 net/mptcp/pm.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d43d05511e69..b3c83e3cadb1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -3,11 +3,28 @@
  *
  * Copyright (c) 2019, Intel Corporation.
  */
+#include <linux/inet.h>
 #include <linux/kernel.h>
 #include <net/tcp.h>
+#include <net/netns/generic.h>
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+static int pm_pernet_id;
+
+struct pm_pernet {
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
 struct workqueue_struct *mptcp_wq;
 static void announce_addr_worker(struct work_struct *work);
 static void create_subflow_worker(struct work_struct *work);
@@ -203,8 +220,150 @@ int pm_get_local_id(struct request_sock *req, struct =
sock *sk,
 	return 0;
 }
 =

+static int pm_parse_addr(struct pm_pernet *pernet, const char *addr)
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
+static int pm_proc_parse_addr(struct ctl_table *ctl, int write,
+			      void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net =3D current->nsproxy->net_ns;
+	struct pm_pernet *pernet =3D net_generic(net, pm_pernet_id);
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
+#if IS_ENABLED(CONFIG_IPV6)
+		if (pernet->has_announce_v6) {
+			snprintf(tmp, INET6_ADDRSTRLEN, "%pI6c",
+				 &pernet->announce_v6_addr);
+			tbl.data =3D tmp;
+		} else
+#endif
+		if (pernet->has_announce_v4) {
+			snprintf(tmp, INET_ADDRSTRLEN, "%pI4",
+				 &pernet->announce_v4_addr);
+			tbl.data =3D tmp;
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
+		} else if (pm_parse_addr(pernet, tmp) < 0) {
+			ret =3D -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static struct ctl_table pm_sysctl_table[] =3D {
+	{
+		.procname =3D "announce_addr",
+		.maxlen =3D sizeof(char) * (INET6_ADDRSTRLEN),
+		.mode =3D 0644,
+		.proc_handler =3D pm_proc_parse_addr
+	},
+	{}
+};
+
+static int pm_pernet_create_table(struct net *net, struct pm_pernet *perne=
t)
+{
+	struct ctl_table *table;
+	struct ctl_table_header *hdr;
+
+	table =3D pm_sysctl_table;
+	if (!net_eq(net, &init_net)) {
+		table =3D kmemdup(table, sizeof(pm_sysctl_table), GFP_KERNEL);
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
+static int __net_init pm_init_net(struct net *net)
+{
+	struct pm_pernet *pernet =3D net_generic(net, pm_pernet_id);
+	int ret;
+
+	ret =3D pm_pernet_create_table(net, pernet);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void __net_exit pm_exit_net(struct net *net)
+{
+	struct pm_pernet *pernet =3D net_generic(net, pm_pernet_id);
+	struct ctl_table *table =3D pernet->ctl_table_hdr->ctl_table_arg;
+
+	unregister_net_sysctl_table(pernet->ctl_table_hdr);
+
+	/* Note: the callback will only be called per extra netns */
+	kfree(table);
+}
+
+static struct pernet_operations pm_pernet_ops =3D {
+	.init =3D pm_init_net,
+	.exit =3D pm_exit_net,
+	.id =3D &pm_pernet_id,
+	.size =3D sizeof(struct pm_pernet),
+};
+
 void pm_init(void)
 {
+	if (register_pernet_subsys(&pm_pernet_ops) < 0)
+		panic("Failed to register MPTCP PM pernet subsystem.\n");
+
 	mptcp_wq =3D alloc_workqueue("mptcp_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
 	if (!mptcp_wq)
 		panic("Failed to allocate workqueue");
@@ -214,10 +373,14 @@ static void announce_addr_worker(struct work_struct *=
work)
 {
 	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
 						addr_work);
-	struct in_addr addr;
+	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+	struct pm_pernet *pernet;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), pm_pernet_id);
 =

-	/* @@ hard-code address to announce here... */
-	pm_announce_addr(pm->token, AF_INET, 1, &addr);
+	if (pernet->has_announce_v4)
+		pm_announce_addr(pm->token, AF_INET, 1,
+				 &pernet->announce_v4_addr);
 }
 =

 static void create_subflow_worker(struct work_struct *work)
-- =

2.20.1


--===============1901288098278389406==--

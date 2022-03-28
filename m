Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049647C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648460292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipKVpT9hrIVVLgKmd+X5LCOueQ+XogEiK0+IjHCDLJ0=;
	b=Mbd8c4oSPmJZXDZ1epQo9hijcv0bLz5YCZ51BZfpmenkdjlxVVMTJjeg/C4xppOMZKT4ZP
	zhnm9wVxJS+c8CNlPveWXwZyzpRMTrqfvikcQut910gQ01Y4tYV5C7+qB9JtOfAV2bZIlh
	60vyNoZ9KqmFC5ixK4R35F69MhfD67Y=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-YISizmcKM2iYdymrMQmUdA-1; Mon, 28 Mar 2022 11:38:10 +0200
X-MC-Unique: YISizmcKM2iYdymrMQmUdA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mryLCe0laU8wfkSBLGuRRkT+85fAdkhRTJLRLBsWKTMNHL1iddW9Wc6c4+7GF5NpoOT7RdK/Nbr7oMQGs1rocKnp5CqW0YGZa4WOFnyi6GE0vB8r4UkcoNgRTD8zqxq/Izla02w2+8Ba5y04lhOIIC3/RyqDskxduIYy66iauzFUStKftyk7RJjAXnBPXgwuvWTD8YyVjpdELYHppE/bs224h4jHiU+7vxZeT+z67WoUJXfI8A5BvVUfacyqkb67MVjoOTJVir+QST2BVLPJQBGNMn7hWWGDFHGY7oRb5ocxvykQ//3rM/FsgDf0bYzAqvK/gaMi/sGuPMtZzIkO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8KsHw3NqjXFXBGvmVIOevvssRs9c8FS3p2k71bKNok=;
 b=JkpYnOC5tEF3iNhEue79y4J+vPjeTOeg6UVfjLOjJ+VsDVwVhn8YYYiQvYGe/B163dmq7V6mqOpNtRroP/5yC76QtqUqZwiAwyAfjK0Z5+XnysoqXYAgvJHu28tMRIXxsfFFCUE4iY3DUGmBtZvj6F4kxyZNFSMBcQ9CMxFSOEJInzyVJWw7PSYuXL2SW9MnfnPECU6AZOyK8ENgunximLaM63+LZZ0Hcjyou7IjOkB6H+8nVRzv/9sLZKztbEAwK9wu/ZtPQT7YUHC/ylr8FVROjTuTPgMI3TtRxLBFfG68Fs1fJX6xmXc3xF4RAZ0MjkAlMvQrbi6Pe2urOPt64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5067.eurprd04.prod.outlook.com (2603:10a6:10:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:38:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:38:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v7 1/8] mptcp: add struct mptcp_sched_ops
Date: Mon, 28 Mar 2022 17:37:55 +0800
Message-ID: <033f8762a38a1d4a838bc737104c609d86fec8cf.1648459865.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648459865.git.geliang.tang@suse.com>
References: <cover.1648459865.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e1473bc-2ea5-4f57-18ad-08da109eab3d
X-MS-TrafficTypeDiagnostic: DB7PR04MB5067:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB50675DB6609AE06A9B712941F81D9@DB7PR04MB5067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2tG0NJ2mqegbX5Jz1M+TDLGMsJ1CUa39QGbhwdAVhPoy+5S433IoVQFJHuB87xky3HU6FKYY9x2A8LNOvoJHGfaeqwAU6NE0byAUmRiJztOC8+RYpPaQBBAx2aEa9uDQf4zWa4m9/wv9DyjEwArB8j9NfGOa1nIRZN1SJ66g1FdSI8mA/w4/VbddbWAa1irT43IQnYRXxGvki0fDEHgMEe/IVgRlBLY5Kya2eQiasrbc/laa0zf41D/ZdtRGma3rXRgMByD4JlJ20zYtEmpqhXRk4NZtILZAHqL8HjAhxbU8hGv2XGk7+3tkm75ZutMgnQAjXEN686kWY+JrZPJ+kC7O0vYnbZ3TxxLlj+4AlgSzNQuO8w58do8U50x4IskhNP14HB90rNSo7eo7wLLXlOKRlbacLCZKZo6EwtArCsUJJ/Gj+tk2iynbIwYtzgwApiiTYD+OuCidwjYOVNPc8fz+FYNAppNXpy89kpwjliay1nP/+Yw/jpUJ09k2ZzriQH+bnQfmWiQhWKgDJoxNFU7K3/j+2iPgVRtELBe7PATPrgvcaWdZTH8r1l6GPuIhK8DPPhNrgN86vyWR3c88c5EFGA1DCAZTc8oK4bJMC/KHjm1u3JobZoQbzlp0lA85iYLhB/5ZpR9wasfIVV+q9zmzZFwtO9Iam1jJVB6sDQmeOrTKVXUMbRl1O8TKaVhX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(54906003)(66476007)(66556008)(38100700002)(66946007)(2906002)(8936002)(86362001)(316002)(44832011)(5660300002)(6486002)(83380400001)(8676002)(4326008)(6506007)(6512007)(508600001)(2616005)(186003)(26005)(6666004)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42xm1eFPKqBlvbYNzsSxdGO0jc9Osa/Cize1MKmkls0aQEzSWt2YrpFeL/nt?=
 =?us-ascii?Q?Vcm8yLyoV3XEGEM2cxo7O+HrDPcvzjaqs0LCMq4VzizW1FZyUuFSmdxCbaPx?=
 =?us-ascii?Q?HhGwrGNqMG9saqllYUD+WXH+5h2B21fUH3sY9fo5hx2G29z9fj3C7v19SIVo?=
 =?us-ascii?Q?U1VV07JpSW72ZYrNmr+2tuqnomOpkiZdwB1sjbnzBpESznChTrKO/YeGilOE?=
 =?us-ascii?Q?dGAT0nOya7cSG08ztsZTEDNy+Oal4VzjTfaMy7D4NUpf5Emhz2tnpeLwxiHz?=
 =?us-ascii?Q?D2SzsEOBrJFDRWWVwK0PNnSSdFv5VVIo8St/9e6TgyNvDFo7a5jcYSvb+noQ?=
 =?us-ascii?Q?t0GwrxKFw6pgHen5mqh33MCcYEjcxjHnZ1C7rejozW8WGaXiBGQ7umBuLglE?=
 =?us-ascii?Q?ubqxpNNRfM+PUh+rUm/0wraRpIDrJtmLYkn0kDP3KGqGL59i8hAzBc1dh08y?=
 =?us-ascii?Q?/70UgkLNGzwOhzm1P1LFbs6eT5EJfWaPA/NKfqbfUZ8MQGW9B9nbWUBoXsMD?=
 =?us-ascii?Q?4+YdOPy8+AQMwg/JLfefi4xs8RoYf54AnuoORXjHjPGa5rrBgRwmVeKo/x7Z?=
 =?us-ascii?Q?H861g8yw0Hc2jb2GkSNXoYixB2ApAqB7cPLAh9q1Sq1y1PjeQyUTjbgBGueG?=
 =?us-ascii?Q?K9bavhz1soZyQ1cC9ELciWQeCF/3LLWYFN3Sz5v1OnvGznSMaLcQq7XgyiwS?=
 =?us-ascii?Q?ctvOan0ZSj2Yf7d2uPi7BlOqSZUoeyRXTIIYPFTof4kgXTq6BPF2ayMc4aq3?=
 =?us-ascii?Q?lSm/d8jmhzXOh43b/MbJLQbIz+GYstoRBlUs8uNnd0pwPuggC46bylkXYywA?=
 =?us-ascii?Q?B6TMyEB6jf+bM271ZryY9oV3V/cBlIy1Z6ADMQF3ebPpYotuyGkJz9ptwsLV?=
 =?us-ascii?Q?t3807K2GC67etwhURGNMSZtqExifWXlBaePwYMwYCLWK5OuVyluBivk1XnSH?=
 =?us-ascii?Q?d18rN7SgRNqMEtBKAtAYO3DQnZirAFQ3XNlaNz3jDYjvnOD8SiczJJtT1LUQ?=
 =?us-ascii?Q?cBtjKSHZw+aD6VmXygDFP9DIQQqMvbZQLUKhipASqzGXpzOZW5pFqGcsIxfO?=
 =?us-ascii?Q?V5uQj0QUnQKJL/s+oylVZe2Hofh+ASyg1JfZJzNglVcZy4O6yFnU06DgmcRb?=
 =?us-ascii?Q?oWIqSdTsA6LeBQj4UqJyYh17HS4IsbuaLoaW7UGw4OxxH4V1nlm9TKk9Ne4E?=
 =?us-ascii?Q?Xezf+0zp4pSXl8jA+dmlYku8ro6+K53VPl1vt/zRLEKXAiFucWbViXB9Hz3A?=
 =?us-ascii?Q?4elvICKAUcM2xxE3tkRx4TPzPwzVRWSO/EPDpMMVKEaiCfMGJf5Dpe3PImSc?=
 =?us-ascii?Q?xqEdW5nSFQlyh1A9OQbuOClB5eSqoAPAwRByrBqFwf55OsVC7IXCAhb2UYQo?=
 =?us-ascii?Q?sugDEMAPS2aAYlEdfshdbD4d1qhSMfoc0LLTaAzC35Xe/wj5bcYiMJt6YcFG?=
 =?us-ascii?Q?gLytsuf16GNf09aCeQlumX66eJ1SYVAmYHlV+HipI7CYOhw/Z44Xo3xSapo6?=
 =?us-ascii?Q?MSFd0u9lZVpyGNUGRQE80qOrCNMHuEDzPtAIcI+nVLzScd4aGBEhhuKs4lZu?=
 =?us-ascii?Q?3tiSLZrArVZ7QdjlMJzU6JZ1nk7McaBfPKTpeuTY7LF2E5B/KliUsaCVJ7Qr?=
 =?us-ascii?Q?VhUL1FV8mTz/qG85lxRVDruuXA1OqoIBA8vf64qhYAsvKDhIeI/3hp7o/7hR?=
 =?us-ascii?Q?/vbKcfVj2F+dlEbUwcW6nF+qURk2Dm2Fyax/iGjUAtgkqnsBy/+dHhDyZ++B?=
 =?us-ascii?Q?MAV4SvtqdEB9s3GmZRyRYPUrH9r8PwU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1473bc-2ea5-4f57-18ad-08da109eab3d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:38:09.2943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7grn8qnQnMUsoKGpJuZKwabj3E+VGU3owA0MeTVCDwM8dSZn0bH6t/MJIC1y/pbBJPmnBe3uNnAwwxQT9k/JnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5067

This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init, release and
get_subflow.

Add the scheduler registering, unregistering and finding functions to add
or delete or find a packet scheduler on the pernet sched_list.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  13 +++++
 net/mptcp/Makefile   |   2 +-
 net/mptcp/protocol.c |   1 +
 net/mptcp/protocol.h |   7 +++
 net/mptcp/sched.c    | 113 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/sched.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b1afd6f5cc4..e3a0baa8dbd7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -95,6 +95,19 @@ struct mptcp_out_options {
 #endif
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+
+	char			name[MPTCP_SCHED_NAME_MAX];
+	struct module		*owner;
+	struct list_head	list;
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+} ____cacheline_aligned_in_smp;
+
 #ifdef CONFIG_MPTCP
 extern struct request_sock_ops mptcp_subflow_request_sock_ops;
=20
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 168c55d1c917..a37330760b0c 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
=20
 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
-	   mib.o pm_netlink.o sockopt.o
+	   mib.o pm_netlink.o sockopt.o sched.o
=20
 obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d3887f628b54..b1d7c8b0c112 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3807,6 +3807,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fd82fd113113..3258b740c8ee 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -608,6 +608,13 @@ int mptcp_subflow_create_socket(struct sock *sk, struc=
t socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
+struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
+					 const char *name);
+int mptcp_register_scheduler(const struct net *net,
+			     struct mptcp_sched_ops *sched);
+void mptcp_unregister_scheduler(const struct net *net,
+				struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
new file mode 100644
index 000000000000..ae1956b6de92
--- /dev/null
+++ b/net/mptcp/sched.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2022, SUSE.
+ */
+
+#define pr_fmt(fmt) "MPTCP: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <net/tcp.h>
+#include <net/netns/generic.h>
+#include "protocol.h"
+
+static int sched_pernet_id;
+
+struct sched_pernet {
+	/* protects pernet updates */
+	spinlock_t		lock;
+	struct list_head	sched_list;
+};
+
+static struct sched_pernet *sched_get_pernet(const struct net *net)
+{
+	return net_generic(net, sched_pernet_id);
+}
+
+struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
+					 const char *name)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+	struct mptcp_sched_ops *sched, *ret =3D NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sched, &pernet->sched_list, list) {
+		if (!strcmp(sched->name, name)) {
+			ret =3D sched;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+int mptcp_register_scheduler(const struct net *net,
+			     struct mptcp_sched_ops *sched)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+
+	if (!sched->get_subflow)
+		return -EINVAL;
+
+	if (mptcp_sched_find(net, sched->name))
+		return -EEXIST;
+
+	spin_lock(&pernet->lock);
+	list_add_tail_rcu(&sched->list, &pernet->sched_list);
+	spin_unlock(&pernet->lock);
+
+	pr_debug("%s registered", sched->name);
+	return 0;
+}
+
+void mptcp_unregister_scheduler(const struct net *net,
+				struct mptcp_sched_ops *sched)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+
+	spin_lock(&pernet->lock);
+	list_del_rcu(&sched->list);
+	spin_unlock(&pernet->lock);
+
+	/* avoid workqueue lockup */
+	synchronize_rcu();
+}
+
+static int __net_init sched_init_net(struct net *net)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+
+	INIT_LIST_HEAD_RCU(&pernet->sched_list);
+	spin_lock_init(&pernet->lock);
+
+	return 0;
+}
+
+static void __net_exit sched_exit_net(struct net *net)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+	struct mptcp_sched_ops *sched;
+
+	spin_lock(&pernet->lock);
+	list_for_each_entry_rcu(sched, &pernet->sched_list, list)
+		list_del_rcu(&sched->list);
+	spin_unlock(&pernet->lock);
+}
+
+static struct pernet_operations mptcp_sched_pernet_ops =3D {
+	.init =3D sched_init_net,
+	.exit =3D sched_exit_net,
+	.id =3D &sched_pernet_id,
+	.size =3D sizeof(struct sched_pernet),
+};
+
+void mptcp_sched_init(void)
+{
+	if (register_pernet_subsys(&mptcp_sched_pernet_ops) < 0)
+		panic("Failed to register MPTCP sched pernet subsystem.\n");
+}
--=20
2.34.1


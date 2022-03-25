Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6328E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648224755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zUXwphF21h5FjIPsYiovueZ1HWHUtLt7x9L28IHjEY=;
	b=VtyGWotA5telSaviY5T1OyjH2h7SJHMDis8K4mWJl9ZPVHIMa1VDQqR21XXTlltaqn4+Zk
	UgpQm2VEpKs0YUqV3fwR0CIFDj7wtxaAFZ0bp+vNhr0L0qtNj0rYn8z1GuTp7y4f082OeD
	Dj2jBciiFQkeHQOQB2d8DYTH/QoOErg=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2053.outbound.protection.outlook.com [104.47.6.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-wa4AlNKbNsC97rwjPpv6WA-1; Fri, 25 Mar 2022 17:12:34 +0100
X-MC-Unique: wa4AlNKbNsC97rwjPpv6WA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9wRr6K4yJB6Y0rEQxqLIGPg7GgU8MnNoCmCDew9t9v6Z2Ag+yRRL8dWWzaKTiXEI+Yn3v7rCSoBXau7mknCBQ8ozumyRVfqiYKTj7ZEBFw3ANt72oCHHqyNFY3sPdzKfOu4/BbX72Eep7LHlf6Et19s2LzQ+dA7igN6XmkQFu6izpEMwvH0/6ry/7hAgrSAR+3ieOU1yIbHRWtlOFSs8Sm7lYL1bKlj1BxyqB6gXphGmZDvI50FQUJ9iiz8CEc+HeKEGEh1Mq4P/MMSDWpaCaqyC5LZsP1slLpRqMVM2fj/wj5rNuXttn72wIJcVh9U0IaTjEHGa0ouJpBRIwRWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPWg1SHAPGAjHP2dydE9+fh4ezJdAIgiRXX133sxSHA=;
 b=TCo7y/mxVCxTOsrAbZ4WXQ98lkH1Y5uGmhGkmgncL0//u4zoiJCORsC64lNlvbB3xGsSGe46jqpGvh9eyCfEuVBIKeFaO2xORWd0SPk78pjFIb3S1cM7AK5h9yflaagI7V6XMS5SI+MZaXuhBfDE/GAiybr7ERmK5BvOZvQxkldogPwSWdJ9ca8IS9bbcq6plxKve6E8xRG9ajziDVCzifIRDcOvPewTf8eGeXdTgJBdwH3ug2oTu00eUwSZ/E9Qf8vEUpdsw6IpHdPlbfyPhoLrWKQjD0IEm/e2DkRsOliPP6+jbGKi4ocoxFcQx4rZ6URlAdD34imq9Zy++lCBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:12:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 16:12:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 1/8] mptcp: add struct mptcp_sched_ops
Date: Sat, 26 Mar 2022 00:11:57 +0800
Message-ID: <0269e4ec9fcdfc3c6ae4ad1075065c21ae85377f.1648223504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648223504.git.geliang.tang@suse.com>
References: <cover.1648223504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c659a12c-bc25-4522-ac76-08da0e7a4522
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB3938B7FD41E0110AA06BC448F81A9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A9dRQbbfD2KfFdjdx12F6Hj8ZAz2g1lKRc4JuQNpYMWVccvQu4v3eh1pTNXHDNn5Zl0UyJ1ILXcW4McL+k8/V4Ymf+0uxFk12MZfQU9EsJxjhY3qhjAfHqzNfflkLc6dK47hHnzR52MeKFdmsH+QKWi92xifYV7aNb+vOFhXSRjD7roekSX3TZfGcj3AN43Qbg6jqem2c4fKOF1NVBRTKNW5KiIUfW1tLSUqnw81vyUv+bJMbIpOvyafgzBt8RAREG0XgUkY01sJRXyuv9P8VGjLeYb97BpeG6nRp7vR5DdcEvYNjmNqgVRSXE/zDFRM0YOtCCYasTh5qhpMK3ik4zT8zrF0buECUnHQydDapTP4LK58jI+DIbCIFgG27HWDv+7VY0ZRy8+FpA3GZZu3GLZin+KzQKWfP8VEwiGUMIDMxZcAFOHekuK7ucyxsXqlPe9Q7zIrc5bU5xUMcpjUNl1Ig6mTcb8xMeMA5FY1mpEb1FgcU0hFGcQuc+QuFI51hkcA2I2SmhQmlGlSgOyA7U8gAN41uXWCgDHuZ8KvHvrkurLseOojsYDXE3Gn1BocsJUJI4lo0X1h3uVIxqdrfRo+D4XHnGK81knZY3EogM3qPL4VwZp1f1IB0dMOzxIVHDUMR8wLFQJdNVl5apv8VMoy7HLDg++Fl7GK7BNe320MOqnM90XsykKYkxK6p8tq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(508600001)(8936002)(186003)(26005)(8676002)(66476007)(66946007)(2906002)(38100700002)(44832011)(5660300002)(66556008)(83380400001)(2616005)(86362001)(6486002)(6512007)(6666004)(6506007)(107886003)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AK2qyIEFW8yKCXAURmnyKn958WQ0uBxlSMe81ObqRbM/3clqdUVzCpplyVin?=
 =?us-ascii?Q?j7csYCeLU+9S+B2zcgMOKSuahArEtyc2HHkVLTEyGug1Ew8gFvV0iDxo7Kxt?=
 =?us-ascii?Q?H5OVQXzmgeH9pgU8ydT5e/Tl6QLw5F6TKuDVfcJOZbFXsOKg5LWY8e1BopDS?=
 =?us-ascii?Q?uywx0OmeT+GnqL8w547M86bW3eqJ2m4OIUhS41EQ9HZa/5PzYfa5FwiaV18U?=
 =?us-ascii?Q?RxjoCdxhXmKZ5R5rIciGrUr95ZTS6b/rjBexhhbcmdoKHNdecSrk6dSRVPG7?=
 =?us-ascii?Q?TkYwz8/SpovDQiWzfYNDZWDG55gprrLleWdxXT4MZDvDsKScjD/SrK1k8sxR?=
 =?us-ascii?Q?+Zsh3wO94td2EYTqKV15xTbioo39VAotR7EPZsqRDQQEmB9NJTE4Cp5oy7CW?=
 =?us-ascii?Q?fHdc8CHbYSdEfYDS1aCh7TySy5Q4AlfECWOXDAAd6R+oCr2B3EU1Zab1eS03?=
 =?us-ascii?Q?2uxDv0wqABW4O7Hrd/D647rqsO2bd/mTqB0rqgKfvAWiHkSXkJD9d4Kb97H7?=
 =?us-ascii?Q?qeG1sguTe87kBEOvFejxR6+UWd0teellPlgoZ9Vn2YaS7qQagwy85fQTvk2L?=
 =?us-ascii?Q?Gu/9moAasI+Nu2w9SYv/bwEbiHsI/y3WD+lIeN5rfe6MEej5uNC1guIRt43X?=
 =?us-ascii?Q?nE5hnKZZsruzQUU+iyRpaeBYRxnyqCL6Y8ohcIEoAq5n4RUlwmwt7ZfV+Gva?=
 =?us-ascii?Q?cnXeYrDY7/oJHokrNxgZdR3zZjOPzclAyoihFjjbzboBzjVBY5UG39vOvzJj?=
 =?us-ascii?Q?fQSmH4lOD54wD4CdJJenUnJ8YwB4w72vDKg0ws6l2bxkWHn1fFK8sgg8TSro?=
 =?us-ascii?Q?qe/dwTpKtXbEhqPlzjKcGRydKLfKW8fA0uTo3aZNeSWCsHyaEPnSZnlNNkCH?=
 =?us-ascii?Q?8TByVemS4ern7AayWLd/Z4mUZLaXRFFg+1kixAICf7pke5Hx1X0V4st4ksXU?=
 =?us-ascii?Q?/8f58UnEJtBrMZSKssb0LavN2orwCP+OgWlr+ygybmHP1rumTCZagHx9dktl?=
 =?us-ascii?Q?ViuPq4JAKvsUa0uu1PMDNTr6Jot5J25BKc/y3uTgwRpbVI/4vImDyJNv/6uI?=
 =?us-ascii?Q?cZLoXRhpQuppcZ7OPO+anM61hVs+lZ/wGRcXGjKws6tPX+EK7WNbHo8v1bWU?=
 =?us-ascii?Q?BweY81KY0xO8K/kvOpXQEIV+39bmoRroREyvZDJSzHHHvHSCZHX4f7Zcf5GK?=
 =?us-ascii?Q?j4Anzbuq3vB9IhaNCrS6ivIbXKPCkv1eVgPdwMhrUfyFJV4/Kd3RjRptypVa?=
 =?us-ascii?Q?8ihBlQs+H06p1hHRuo/Yeg9n8MDvG7gyRUETFx847DrhyhYl+BlXpc0aTjlr?=
 =?us-ascii?Q?6KSpfFoLkptjrBggQ5wtXupwoattP2yHD1Z9PWa8OrmfipJXcXPPH+PSZ0Mp?=
 =?us-ascii?Q?o0265cRYJp1/Yul6AftkLtSCMEC4JM+sSBMTLRM/w/kQjlg8QuQDR0F4mnl6?=
 =?us-ascii?Q?Y9Va7NKLgifwTgGmV8N/hkDROcZtRaV8LYsLTJbZRs7DqLRmkjZvhCJ8SEMj?=
 =?us-ascii?Q?gMH9yMbB9W3e7MEnxsuK5QKekycHbBwUcFrD15ANENX6qeWaxCECZOuhHDoS?=
 =?us-ascii?Q?PXpc7TEuWLBOiGnXaibQYfPNQmXHcn206xqMqNVATHESYC6W/4TrNWZDNTON?=
 =?us-ascii?Q?1BLlm2jY+aAFJxgvEdUK558YAFnm/96+lBSms1OqnhDZ4CwoJmNVnUcE82eL?=
 =?us-ascii?Q?IyevDXVYhDcGdKfqT3nTuGq3X/S0PUbYm/EpS2I5L6hexQ8X7ccjRzSmAVTx?=
 =?us-ascii?Q?qonUuiVc7rT5NRTl/84enx7OizAbre8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c659a12c-bc25-4522-ac76-08da0e7a4522
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:12:33.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJzjbTJoJU+11UmGGtl0izr7DtTi3DYjLZ1ym4wgrPmz7BI0OG2xiNTeN3ECBtmyWPUDY72Cy08hQ0j7OMiJUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

This patch added struct mptcp_sched_ops. And define the scheduler
register, unregister and find functions.

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
index 99dddf08ca73..9ef6d94efc47 100644
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


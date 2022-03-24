Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262381FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648130954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OS+xBdcyabfs175FcYvfO34l2fMm+VKqOp3H3BFjNs4=;
	b=l6iLLr2jL2u8KdZOmoSx9LdEfcYbnbRuIt2MAOfFTTVKqP0WDsHCGmPHZlBB6IwJf3tip4
	76XrUUh5pasp+CoekYp6z3yMOqc0onLMjQaS8xlX4khnzvwrQzkj6TBAvYgOH6NpgfqyQJ
	2l5ctntrQf5Pm/AYpIAi5mzGZIrs1kY=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-Ah3cEuUrOi-F8VIvvTmqjw-1; Thu, 24 Mar 2022 15:09:13 +0100
X-MC-Unique: Ah3cEuUrOi-F8VIvvTmqjw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRo8U0gxGgZYgZtJheOYd0yh/YtE9+hP1wfclSoXDIfBJjwJ/PppcOD2BLa98+pHmtFFeAvn71DFWDTZSh0kMUoXwH+4G/n1y6oXlpqqnLKDOLQ03nUqCNLFeHPv8roaYJflWAzUy/8N0PswWYXjSy1pANf8tv8otelPlB9XWd769gHF2xaFftjtZ+YRfar+wCETB/AZPaJcUdtZnXvuGYO3s/AVLpHdnml39BnGGxd6BQNAkwh3gNDNF7kohwKv6J4cmqZsAb4EN6kjXEMZqLpphejdcwzmUNf/GxiUlJDcavVOCXerz4vPQBX6HNRwcIpO2gQun+8HvUVf9W4+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpMoOymuu6BW5R20otKBpVSQ983147OlMvaoQkbYoO0=;
 b=dPzM7n/6m5Ur9hltcBtOdgi5HgI+oaktFxLQKgKWY6NLyDGdbtl6PSzrDrZjVq65gjjC9KPrXcazhsX3n9c4c9dNi5hcc2WCC66s8aFDO0EJ8CydCy9iAd/+Dbp53P5mKLLc4bQ7vruIBLh7ZSsy5E3JFry1pf31BzAa5Ed8KAFrNUSWAo0X6VMLBxx28B94QoSjdhyR0Uxc3RNST2Z83+y8Qyw0gZBFWOAIigv8VQJnAQ1pdmNLLryXhjEw2Y2idyY8Vws2CHfeKXCjzVE4KN+eKg/q4J5mLu0oIDm7sHLrg13UEeX1gcPJQJdEQx9UpVNFM8nZxm4TE2e77P3Oaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3616.eurprd04.prod.outlook.com (2603:10a6:803:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 14:09:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:09:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 1/8] mptcp: add struct mptcp_sched_ops
Date: Thu, 24 Mar 2022 22:09:03 +0800
Message-ID: <4df8257d4783911e933bdf3a3ddcfbac1c9db4f1.1648130637.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648130637.git.geliang.tang@suse.com>
References: <cover.1648130637.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0216.apcprd02.prod.outlook.com
 (2603:1096:201:20::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b44da79e-2c17-49eb-287e-08da0d9fdf10
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3616:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3616A4F4283519FA6E161428F8199@VI1PR0402MB3616.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Af0ySw2NZC+aYQjqReSfhHO/OXoTZkBvukp0kP0JnKj8LdXBQ6jcRG05RKBgpYLYEs2yYIADr6GyofQGXSi8m8BRfnoW1ZYfJp08Zdg5WbWoU1onuN3/TL+HhgMazHXfGJFWj3CjhwKVx1SjY0jskYkLn7n4SS7ScHzZfrviVeztW/6C7RkYfLxr/+vsKJZS0UIXfgunYwG82ua1epldfwwJYHHTHgBBak3hbgZL1lQVTzTxr7xlJhk1TUXz+ucmbwHnFXVbViL4brxo/Imvv0fP40HBkS1jTFmewMhSetFxn9pBe7C2tcxBWWW/akqPGOXH+NVBmyWO0kyyoQImCYQpaU/juGLx2EycAB9bOLXZJQ1ENVzyGEhdcRfd0RlL3sj7Oju3buQA5MKgXbL368Ldu6AeEclF046BnLXmHGMDoiaglVy0CmRxQ184VXQYT7Zv9l4Wwc6vrnSSMJc24R53Xv9sR2Qjgc1XGRg+LDk6meVY5BSzy4L8QVQahiOxBOf/SpBgrmLmOEQIWFwn2EGzmAem491Rxm+Oy+puwe3KE+T9mOqKpzSGh4CTbF/MUYlilWmlYtTX3b2v1i2K9sw3DHLfxnGlEB4KKqSRoxc2Zbs3TQO1rlXI9zRE26d+YsVmeLBPLd4fAOy0qFfcTjbcMpmvRcOq7NzZCQr+vb64DL/8AmTybG/bzrk3qwt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(6512007)(2906002)(8936002)(6666004)(5660300002)(38100700002)(44832011)(186003)(107886003)(2616005)(86362001)(26005)(6916009)(66946007)(83380400001)(66556008)(6486002)(36756003)(8676002)(316002)(4326008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lg0Iz3m/yR+6WMWDnm3IUJ8x6ql57tjwtMQ6x3+Uxt1/1vvSygCb3LlsAYm6?=
 =?us-ascii?Q?oB8e0hVwQN8IrlXQTqwqn47YwNrzSkslER2rvsWyhS3PlIdHv0EFm4mZp9fl?=
 =?us-ascii?Q?wgT3g0evDevp6AL7Wd3eu+ITnY9MqbbUgtQkufp20T/0VRcsWQLbhVA2FZ8a?=
 =?us-ascii?Q?cefeHnJHtSVr87o1X8IPMkjV4J2jMVeJu3jyhZP5ZhOyO6/3zYvF+csFYhDh?=
 =?us-ascii?Q?Cv8gVcVOmAQtDGWD7jqeEHV6lrrbGAPtbNsaCHExuua+fvBOp+/62ZUGf23P?=
 =?us-ascii?Q?v3aCat/uIdf+/5FmhWwU/FO8g7KcjoYM1n+uDhz2WiVolhgYXiF7FYFdW0R6?=
 =?us-ascii?Q?vSQbMSi/Qdnf9/dbQeP6tdWGv9BnhV9s4bLsjVFW8j3m5PpyQ3jIsMts/whx?=
 =?us-ascii?Q?k6yOTZ+2sIZ/ss9A64PT/KfySoNkYhKO2IGfWJ6MeoPhWIFyx2irLfb4JenM?=
 =?us-ascii?Q?WP6o1T+1Rg0IM85ol+yYky++sl1IPsloF+Fh+HjdZMpQyMeIjo5fsDIwiDht?=
 =?us-ascii?Q?3h+X2v9bRQ5SOEALd4QYIcrjgqduDAgA+ivGbsLasV86VFY7TfFsqf+MFfMh?=
 =?us-ascii?Q?R5HYD+LVM3VaoVw+Bo39yPX9Vsl0UnfLCPdv0a/yGe+MthUYkXcMoP+BztTr?=
 =?us-ascii?Q?t5Q1vnQBQlACabqgSN09rQC5GDxHkFaFdH0CVv0f15GR6TMVVm30paPxwd0V?=
 =?us-ascii?Q?MeMdvABwzI9LsAY1mlVQnNM4cC7h4+YzxKfaTYTY6Dhr6luVOwJv7Gcy7aUF?=
 =?us-ascii?Q?3BK4YZCsO3F30H50/cdvps37qGgHhZZJtZEt7lGhTGEXAlSnz9O9N3TR4KJ2?=
 =?us-ascii?Q?exOmt/qsYkLfdLALnWSZSAs0dsBxj90gAOWh/u9Om/9BHbtG7ECLWygzr+XX?=
 =?us-ascii?Q?XLkJkvRmclzocwRg6Wlfr9keiEWthKyRPk9b+N0ylb7LW2KxDnyiTF9gDVSY?=
 =?us-ascii?Q?xicVoLc7U/mUI9mlNceQJRmC0xZORa6O7VLrqRAssXPO/JUI0xpNJaADX1Db?=
 =?us-ascii?Q?6PtZyJmKmVsPzWFuX3FU3/gJRJcZ3xkiomff4yjySv6PhZNm8fDVtSE23YQS?=
 =?us-ascii?Q?TTkiZKkrkizIe6rPooMURA5OIr1ZDSOXZS8qklNC4gyYQuXqN4FRF+a+pOuJ?=
 =?us-ascii?Q?WPeG7KTWUnhKRw8b2R0Vl8YXZd6hkVglotXQXbe0EKc/sqchk6toGxQQ3M07?=
 =?us-ascii?Q?+x5OrTc1t+A/zTBjpWbx5Bfv3Kz/40rdBJ6mCpjCVTfNQVQ3nq1Z1Zx7bi3S?=
 =?us-ascii?Q?jvsbmpj+hOstR4SqQLSiVdiYiWrFqSJfa+O7eLvpbVa9MUE2tH2yV6KDhZcc?=
 =?us-ascii?Q?WsgeL5fguf3ItRTk20HuZl2DAdeibAW8P5RvnS0xNYPtZQPLK/CMIJd3NA92?=
 =?us-ascii?Q?Vxy7tEjRxhMaPp5aFTR0oE30hiFKc/9w4VwiykeHu9AgGHEC2yPYQD095VH1?=
 =?us-ascii?Q?08cOfPztsW/f+OHp87/fhxpUXMFhVxhjmeaRwktN+yg+5v875d/P2w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44da79e-2c17-49eb-287e-08da0d9fdf10
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:09:12.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFOyZ44+SNIjVqjGt2Memn3TQmT9Rn6n3mUPCTEpu4w+B/fHqJntnZoXi4YIgeoXQe1Ge2jVfSF8Nd0zEWAiDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3616

This patch added struct mptcp_sched_ops. And define the scheduler
register, unregister and find functions.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  13 +++++
 net/mptcp/Makefile   |   2 +-
 net/mptcp/protocol.c |   1 +
 net/mptcp/protocol.h |   7 +++
 net/mptcp/sched.c    | 114 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 1 deletion(-)
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
index 0a0608b6b4b4..aa5c10d1b80a 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_MPTCP) +=3D mptcp.o
 ccflags-y +=3D -DDEBUG
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
index 000000000000..3798a5cefeb6
--- /dev/null
+++ b/net/mptcp/sched.c
@@ -0,0 +1,114 @@
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
+	spin_lock(&pernet->lock);
+	list_for_each_entry_rcu(sched, &pernet->sched_list, list) {
+		if (!strcmp(sched->name, name)) {
+			ret =3D sched;
+			break;
+		}
+	}
+	spin_unlock(&pernet->lock);
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
+
+	synchronize_rcu();
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


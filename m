Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79F2564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0kch1mhCGT8mPGp23dVtK/5FH5O9sUluL8tRFU5mUI=;
	b=G/iM/wc3ZYW0IoHglaxG8+qzQLBjcIwUeLVruNy1+rwLy8KDNjtVFjpZUB/M2OL2LGmvc5
	ryUphpoMcA+G4xN/rOXJoQJv5I3djoAPPHd20p0oJgBoFZYX2FEvrLZWUjLXRkLjKA6o9H
	LCz5PlkzlT8OhMPjX1oBpLUjKg+j1DA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-zu6tqUg6OCGFcENOjYvd2Q-1; Fri, 08 Apr 2022 17:38:12 +0200
X-MC-Unique: zu6tqUg6OCGFcENOjYvd2Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzMKB5GSLc7XrN4aopknrxgLL4uBADdrtFSrOZQ3O7cECfusrZFDajW29Ir1EY7RQGY3mCn2dPedodu/1Jc6BhB8H6FGzvcIo+DYuZRLnQiSkargyOuT1EVqEEyriGA53LVrTE1Sy5xWmkTs89Stte+/l3FwLwcbWyIcuzwHkKOx9KvB3zUFG3RpMqyrEw8WGrqdZjYp2OxYHIjoffr05vDgWeBe2tXMxAiopUYSI3KQ8NQah81hIuJN8zv9dR5JbiBlmQokaZCCJpYQj6VLae5CZhkxW95unGWqcAujv94I6s92lpRLoDdmWnwhkUU0kFx1hK0qyOmUoCc46C0lmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlRyNR4hC6S6WGRSmBc+wh+Jcf69w8y44rhEExFjO9Q=;
 b=myFaxbiHxCJDf+NvCugtKqC+/ZfGCAqR3e/bynWbVeTx6aEQuEEElXMAcwbhFiXzs6DS9xItH4woth4DVQ0Ln3Tnqb8OeMBCyKzJv8fIxIyT6jZtRN6UWTrYcx//rXizu012lks43DcSdeJFhXNE3d1ROTUT/MIXN+CSQ+H+eVtCojQSuIxv9R21sp+XEAtC+4d6O6LJkyWTE9EK0B5Jnl9+6HU2E+pu3LK3Sd5L/8BwTscaZzsDZ8437xQne8XgalcGqqtOAddcfG62Hld84M8wGGBVChCzKJE9jQRZmzAmW6gkhvYM40HFHoCAku3DLOlRHNi5wXCddABHqHYygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2995.eurprd04.prod.outlook.com (2603:10a6:206:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:38:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:38:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 1/8] mptcp: add struct mptcp_sched_ops
Date: Fri,  8 Apr 2022 23:37:58 +0800
Message-ID: <8d7648d5fc45055efed63783664deef03a0e3bba.1649432004.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432004.git.geliang.tang@suse.com>
References: <cover.1649432004.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0139.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69604048-0166-4294-f534-08da1975c9c4
X-MS-TrafficTypeDiagnostic: AM5PR04MB2995:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2995E1AD1ABA7BC725617D13F8E99@AM5PR04MB2995.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0gaT1LwLm5Yc0SV2G8Re+rufcDh6svUskzsssAKaWsE0XP3QFEKUhCpKkbc4AZ7K9RufPjj5KmzkKK2Tx2c5leFDpzRyVbtaZ0siuOD5/80Ke1qDA4JyQuSRM+DmggpwfuatDvgrZkBZhhTCoVDbbjp3rKpU+Ukdhe7Yx8UJM76ZDIEuWSgaJo99RFofIYJ7nboFvN05PfhNC6W9on9kUkd0f0F3YcjsGcpGENInfXEJ5hXz5n8cLA9F1MabLUuk1dy1h36TK+CoLxn+6BZf1iWSpXDyMbS0lgPGiSZgV/tizcRbhV/GEPCpPL2wOnUc/VlQbxnUrKyeqE0BzH3DdHX9J8OoqGW44H16ilOR4TNLn2ZGLEzQ8ub6XHfGANvAFp4eo4MvP78vyJ3U5Ek5LA/gBOPSb20ryBeZUx5f9KFahh9AKjRR1RxQW4L5oWBTBklBoQTJfjx0as041upZ6C5UfL0DmsnZODYx3G9MPOglIBIrt6IjlOU1NOxvfpwLtjo11GhBbYEky5zI9yNb62xZfPBLZaeAq9/mgV7ibVe4AKW6OAf7wxqMs3xKupRJnDQbXJzri5//5u9+O2XaggrQSSKE4ovvPHxziT9yRsBSSJiLoGvMVoLrwNnh/3o8K7AbK3DCVjaZRAd0GGThs/Rtzjtmxx9VTV09jLXX8LbbXmZWh0Y4+ln0WMqvCUTf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(2906002)(4326008)(5660300002)(44832011)(316002)(186003)(86362001)(26005)(508600001)(8676002)(107886003)(6506007)(2616005)(66946007)(83380400001)(66476007)(6486002)(36756003)(6512007)(6666004)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ypt+VwBdFr4McvtlUza4+cU3yjrdhu/xfqDahgCQtBIfBl8YOl3YjlvRL/Ah?=
 =?us-ascii?Q?xJgOjzdoADyyXNw3aN1VONdAXzFPvLg7/p2Tndncdg4rW2jnQFiC7zZS7kpr?=
 =?us-ascii?Q?PxXdT/d2wLaEApKBu4KSbzvBwJRvUqeRS5lcmRF5FzOgGP8nBuyxEN8LajoH?=
 =?us-ascii?Q?n69okNLid7V4nm9u9s4wCQ0s+pFJPZa7ORBHFgZlSjE4VXviJ8w1q6iZcE3+?=
 =?us-ascii?Q?bhwlXKHTyvURX0kGZwp6aKBLt2XZGL8aRXJvhk02jjsrbXRousAsoo4wyn5F?=
 =?us-ascii?Q?czSktGEWjxsZAdg5Zk2lRLvcpzKqyoeH0Yld/N0wKDd72gAlSz6s45Tdncqf?=
 =?us-ascii?Q?QWGE69fXPaMgxpoXL0LCaFWuckEweUhaNQlG4eg9GSiHTl5RaWWR1uSoDZX+?=
 =?us-ascii?Q?6OD4Adz0Tmac0aRXmg0WOwphAY5GN+wYrHAR9oOq3txUkP5Qu0PH+1vWwcYW?=
 =?us-ascii?Q?rZQVDTkeTWwV/GSYoYJKzyHvgfe0zs2Ogk2CZIVXBdmXH32lx6FSd557NLLe?=
 =?us-ascii?Q?l41ws5m34ZXoGG+5FMCktfZiiCdBcgjOZKsm9Jr1H6gxDsSInz6WYxFc6p19?=
 =?us-ascii?Q?BX70PGB4sUWE4VcT2pRT4gY9ofNxYkEzKeFCc6ylz2CPsVUVygYwdvVUZau0?=
 =?us-ascii?Q?WeWnZ+osSfVFhH90+GQTZfIpOlSF90X+qDnMtnhYaGBhGNXPFDSV4Sul1xju?=
 =?us-ascii?Q?Th4r4idZsTNJU1ln1RJeA4stdYiC+ur9KDYBmQheybR2oXVeuaaG1fFlbnEk?=
 =?us-ascii?Q?v5iimflmPc1gyNpkIuKU2vikhHJRDa9RSAWI+uRYDTMQ8XsE4WaJXj0zOF14?=
 =?us-ascii?Q?YjSpJ0iOThtE87AmxdYBD9DLi576O5Dq28wEr3zspWKmxZ7Sz9XnltKL4biu?=
 =?us-ascii?Q?TrVQq2i7cTy5UaaKuhe6Jh7VfpoL2uH536ue4oMdXGUHO6B/4Z9pQ60panZ+?=
 =?us-ascii?Q?BV2bj8si7k+il/oPDTIKMn5JbTRhZCoHoclmKyC46Cr2u2f2KRBYMInjxOyz?=
 =?us-ascii?Q?e+bQOcwcCyuEk1SKwzcpIcf3qWDQndTnGaWfqvkVJe8gwHX2sL5n+FRAyU/z?=
 =?us-ascii?Q?waEtAaG7OjNEYs8uM7jD31KWapAgd0B6XTRIXl0xwY6CtuZMXpYRJgipuqFR?=
 =?us-ascii?Q?QHw92MgX90TQ6afJnx/PbjCZM6NFtVhHkzXJ5tmpliQago04Pqm6FltZ6hHm?=
 =?us-ascii?Q?KZEI+KvdQxizUzM+7BxEhN0hphWUbJ6b/HEYgI/U1pj9dLasLK3VQmoRMQCz?=
 =?us-ascii?Q?Kzqbz+C5u/uT8D2SpG0iKjmw2FVKe/I+QW/BfKn6D4ny4JhPh3+I8STvdarQ?=
 =?us-ascii?Q?fMNNG21gWKkESuouurAMd9FA5udvl8vm5prM6u20CqRYGMjPigBqHPwJf/Op?=
 =?us-ascii?Q?s8be7dwpNDSYiul0oDZTG0/jXVIgVagz0dOXC49iEzxUrMBzwmbwuc8/QLK3?=
 =?us-ascii?Q?768qcxQGp7QGwWAi4U43G7cZ1xuocCJiQcVR3j958iYymvexfMG6j82W8nBY?=
 =?us-ascii?Q?HNg8SDm493iIPkGc1CxE9OPfFfFOpUGNeuMx+E+CUsjzOWdwQ42lHbjCDkIy?=
 =?us-ascii?Q?rEod1lYQmFvuFNL3+53Fta8Qj6F2GyOrJ/HSTRiJuSwhBhrZP93AszPVUCXT?=
 =?us-ascii?Q?qpaZP4Eo95/+7OWiIN6Tb7hZsyeolDBEehtwsrI8fjkZ02HHV7aYJayD5X2C?=
 =?us-ascii?Q?+/uMCOWno4vlvWDJ88mU2D5Rlw4/xUDjAndcfpNXeHtEroqBGL98VHVoUafb?=
 =?us-ascii?Q?VpgxEpQF1ECrjG2jRhig8IfyNxZcghI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69604048-0166-4294-f534-08da1975c9c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:38:11.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfuCOOe4fcpOJwp5b6FTP98R/yvJSDqYklegWJ38GijKAPvOSLHRMbOb0Sn9vF5ykhdU8jT6JVp2EBmq1exjug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2995

This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init, release and
get_subflow.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  | 13 ++++++++++
 net/mptcp/Makefile   |  2 +-
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sched.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/sched.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 877077b53200..78a5cb44fccd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -95,6 +95,19 @@ struct mptcp_out_options {
 #endif
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	struct sock *(*get_subflow)(struct mptcp_sock *msk, bool retrans);
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 187c932deef0..7cd2c1c3d25c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -608,6 +608,9 @@ int mptcp_subflow_create_socket(struct sock *sk, struct=
 socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
+struct mptcp_sched_ops *mptcp_sched_find(const char *name);
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
new file mode 100644
index 000000000000..c5d3bbafba71
--- /dev/null
+++ b/net/mptcp/sched.c
@@ -0,0 +1,56 @@
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
+#include "protocol.h"
+
+static DEFINE_SPINLOCK(mptcp_sched_list_lock);
+static LIST_HEAD(mptcp_sched_list);
+
+/* Must be called with rcu read lock held */
+struct mptcp_sched_ops *mptcp_sched_find(const char *name)
+{
+	struct mptcp_sched_ops *sched, *ret =3D NULL;
+
+	list_for_each_entry_rcu(sched, &mptcp_sched_list, list) {
+		if (!strcmp(sched->name, name)) {
+			ret =3D sched;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+{
+	if (!sched->get_subflow)
+		return -EINVAL;
+
+	spin_lock(&mptcp_sched_list_lock);
+	if (mptcp_sched_find(sched->name)) {
+		spin_unlock(&mptcp_sched_list_lock);
+		return -EEXIST;
+	}
+	list_add_tail_rcu(&sched->list, &mptcp_sched_list);
+	spin_unlock(&mptcp_sched_list_lock);
+
+	pr_debug("%s registered", sched->name);
+	return 0;
+}
+
+void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
+{
+	spin_lock(&mptcp_sched_list_lock);
+	list_del_rcu(&sched->list);
+	spin_unlock(&mptcp_sched_list_lock);
+}
--=20
2.34.1


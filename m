Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889220FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 07:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648537779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI8OKjCaCLZUzemyiLtMzVziY2WaIQ/dWvcn5/xEWtw=;
	b=RP/XF6ddLnyCJHA73xm0NMhXtSmvZsdEum65JXRVWhSHLP0eoNlfFEnWAQnsg0zV/ECZRE
	bUXZsR0vIKV/fadbm2YlDrLz97dePRVF9WauyEWsMq54NvWLlX1PAQofrSEUh+KF/FDMLd
	bRuIE3DO2n8be/gqH1paLMB+oqkIk2s=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-hNgF_QuyP8O9cpxVsamoyQ-1; Tue, 29 Mar 2022 09:09:38 +0200
X-MC-Unique: hNgF_QuyP8O9cpxVsamoyQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egzDkOB0MpXn2AU5JrEVjREXoIGdp1pPlq/rGL/OZ7CSxwryv6nWDdj38pwfqRqArJAVMP0M7ki/FUG6UDwzE8xANe7RTE3AvORcBHuS1tREZbEFLIF5lzENiHVsym3hO1m2GsdqS8fMvgvdt09EN/bl9byq9jBGC60f6sQJv959s2NO/ndq7jSfIUYQ/bnGvPr1txZGOXbzo12G+CnEvC37HQv05Dhf6opQObhVjdnGkQWa5hOYSzNShERzoHViQBU0Q+qWJel/NWFvvZ3wSSCU3dm7XHu0qdJ9mRaxIRGZ44GsoWtymaWvWQkz2WXukwXzKZzjTP0NwsyY/6W7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwOIokwTiTBz96nVEmnsIyVuC7LFShvt8zZaMX5U5jg=;
 b=nXeAx38azU16J06rL5Uq0V4XVYAQlYrQl+bg+9X+57T8h+WhNQ906E4MxTOPAlut1ErsEYiOps+dF48c4MkTvxV+FK56FuNQIMW7NAH1uRehUHCOIoo05448z4riSaWIgO7WgS9bLBsLmt0yDasByU2YU+N/PLr7b2GetnjlANLkj6eSGbjrMbZgA19Hphi75z3/1lBtvvbcDcFiPB/IY4ePfQ61WIPhjB60xdYXGXKDnmUtHqoEaQ6dS82gSaiS5TkRbkKnYFKLYEsgoRAdRq15cRqxFO0ADus3m5GnU1uXhaC3lcPyfMvbtA47htpAvFQvzDVJbSsRUK1wGboxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 07:09:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:09:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: fw@strlen.de,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 1/8] mptcp: add struct mptcp_sched_ops
Date: Tue, 29 Mar 2022 15:09:20 +0800
Message-ID: <9371e3be95302900e3dde3cbcc7708cf500b54d0.1648537203.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648537203.git.geliang.tang@suse.com>
References: <cover.1648537203.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0062.apcprd04.prod.outlook.com
 (2603:1096:202:14::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022a457a-b57f-4601-3341-08da1153158e
X-MS-TrafficTypeDiagnostic: DBAPR04MB7335:EE_
X-Microsoft-Antispam-PRVS:
	<DBAPR04MB7335A0FAA9C597A166C88401F81E9@DBAPR04MB7335.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4UEAQl3ARZzd3PG44UQS3eQfdwaLNEp+Cfa18fRdLyFo4okzf1vBDz4CIIb/yEU8180VLvtsN3EnMzWbwUDK1nQOMXTiXcC3N2ZXouOEhJpa1PxIHKZuj/A0luPaoO0u0Q/xdc3nj40o2mzYcfqlxP106kc/LDj/7p2vYLJx4dDaU8bM9+u9GDHpOfmTVucv00X5hZk064kGaDlYxnr4MA2UbjQx+/EiCdhkU/4ugO4kIp5Nd0+JurOoDp7bIn8TU1J1vhM450w5rKnICoENOSp8tuUXb+d9lS23l5hofFr2lgc2s/asyTFdZ2jVPldK7vStNBRlEhkeWJ1vEGXd23mkkOPaHO6xt8292vI+YvK6UohLTwGhhs5UaHEFgY6pJhHr4DOTi8E2bwB33nvJZnQ6Zd35qc1Ecfw+C4doinuUzUE01DzqzJA6mIXUkUS56CHo7ei5beoSw2Nsn5DoQBUdr3PevHfiqb4Wl28l6Rr4J5c+VirJPGjux7YTM+QMNLGuUAi/okTIi/x8eQFvENPkToevldtR8FPMGkc4jk8YARfFhbYrfRHhtIkvDN24UjnTbpz3dKdCtxca/G4j8gkQsPFxJAMUwqVOFwacXhE0zmy42F4lczqbtCd0Hw4b+XPaqlGMXvrEG78LvuczRfuhqmoACQCdBDyJN0HbUsvss4zBL7HkvbVssbCkZYpWw+kmEx+s+V9KeFv5BdKj5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(83380400001)(36756003)(6916009)(26005)(316002)(186003)(107886003)(38100700002)(2616005)(4326008)(6486002)(6506007)(508600001)(44832011)(66946007)(66556008)(8936002)(8676002)(66476007)(5660300002)(6666004)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2dTZmayhKqC8or+IE8V2VWLhFhYtZ4NY6RvSB+Sm7Af+DwW0QsnFKCINuxy6?=
 =?us-ascii?Q?bTUIYGLUVLXpZDIbs/Y0i9miSTcM6JjvJw8+IQobFPDEuZqMYAYkSzwNTDfr?=
 =?us-ascii?Q?1s/OEyrTEuM0I1APBEyIBbwwvo3vcj9uQ3oiw+80Y1NRpA7y/5wpNOe+vVfN?=
 =?us-ascii?Q?SNAkhCmpTJn7NkiLsitYDnf7NqxT8T12cEYh21lqwsob8gsA+bVZl8Af+SSM?=
 =?us-ascii?Q?p7liPW6JKbzyi0yZ2+AJFpGS8gU+F+eudpNkUivsWt2N9OyDL5VQLiTrtIt/?=
 =?us-ascii?Q?hqyBlXtY6//n1/kHYykBAM3WvkiB5VNVla2pO7D/qzCW6zhXeMfNaIazuPTF?=
 =?us-ascii?Q?3F2Meuy1M35KVT0g+373cE1YO1vgbJroSld01BoxYsneE3GWWFL/TuG9pGp8?=
 =?us-ascii?Q?nqtDFy2+I8asOlgUWOkbTU9ihziIa5BLUTc363NAqknB/J6LLGLGb6bnbUEp?=
 =?us-ascii?Q?M2Xn0FE8R6EjIoTUreI08Xoylpm4V5ZXTXmKSrd3BhRiKNZJGmeGgAduVPQf?=
 =?us-ascii?Q?s2hVRzEZrqgJkmSoSJhdpskP5w3r/gV6x35mNpAWIMxf66M+OV4eBRwVMNJ7?=
 =?us-ascii?Q?tC05eCrSJRHVeVDROuw/gvPSD4xgUpcPa7ZChAyJC9tW6upV5DkDqwWY91oj?=
 =?us-ascii?Q?qYqszgaGu3Dop4lN2tLroqnxVBoQTIZz7p6Y/dsE2WZ5jtV1KJdIMmoVFShi?=
 =?us-ascii?Q?CGQTQnOB5+BLnx5Gx2LV+kt7itgpENu8nvTRFhza6wwy0vsM9cPhJek6Ophc?=
 =?us-ascii?Q?GA9BjiLOFdiSnnY1muwYT68pYryEZr6vqXyCTIbDuxCQy8ZvyACWs3mk6D18?=
 =?us-ascii?Q?kto/1F7ldX4QJsQwwmRaqnd6V2Ey2YsF2BLYOycEKgHBY/hJ72m3K8aI3wQe?=
 =?us-ascii?Q?PpR4SUTwgzjUqIcElbS29iuSe3FEWqsTqq2zxan0o2tl4Blqoyf9B41lRTaL?=
 =?us-ascii?Q?izTlQQOEF//ObtOk36Tdi3XDMAqEuyJ+gNuddPVcA8ATTQcJdbo9FBxBzcDl?=
 =?us-ascii?Q?XgDX3bpa9c45P9C8AFCaZ0X5JI5E5ZPpjZiVXx2xQfhQBwnXsxWCGRUXhGPa?=
 =?us-ascii?Q?sQFe4QIoQvMUbZ1QFRLSVcNNWfPrS7tkQ97BDeOzcwQOIilPiNqPy1QsjaDY?=
 =?us-ascii?Q?r+uZ8sD1VvJWgKEo2rMyJf+IGFQ+Y2VqWOgwzcCmuVgr1jEPkCos4HgdRxYN?=
 =?us-ascii?Q?2O6Yr534+EFfJG+VLCKtuffyjndwjqYtllVlsRGYmuGRFV5OKt6djlh0rcWm?=
 =?us-ascii?Q?FuJeKMA850RPTCNMJYHDnoparVyc/zPLXgQ6leTA+t31XurBcVqeSHZTU6ZE?=
 =?us-ascii?Q?gE63R694T3c+sdAvkOYmediNNXA0gQC4ozhQR4rOW46iPPf2RbXplmsxCBoe?=
 =?us-ascii?Q?6pc1naL0aCsrl+YCGmcY+fPEuO90ZhFtnesRyMNFgKlOjSq91pL1aokxwTgo?=
 =?us-ascii?Q?YlLzW0uFigr1WRdkXo9en1Zrg+kgaDv4DhmM61XOdRXDlhY3sdMX1Psa4V08?=
 =?us-ascii?Q?cM5nPFk7Hs3tKnMf3nruMSAE3rFgQXBd3ZKSMagvvICfybsNi6w4pT/0IEVE?=
 =?us-ascii?Q?IDn/2+M/+h6FAaLDqBgocLE/F4EWYyW8fvxJvgEOp0rBkTR+48oaNdf0CSqI?=
 =?us-ascii?Q?XUVC6KInp8+xLY8dpOdd4UT0/rCCBUr0Xg3+r4VNnBxDXVgaD7veYrA/NpfQ?=
 =?us-ascii?Q?ZfnGlJuKJH08I6vImd718qQmsGlp9Nfw6BdG8DlJQ9p4o6ndl6NqlJ/7FCOI?=
 =?us-ascii?Q?fhsBU55DiTIJjjVWzvzlThLYILY3FL0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022a457a-b57f-4601-3341-08da1153158e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:09:37.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIvq0ydhS0JOHUbSAfU/qsCNraGryfJ0UEl88PJcTehmgylaQVf0YZaNiySjRynyfXsi/JtGuvvmbBBbVoHTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335

This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init, release and
get_subflow.

Add the scheduler registering, unregistering and finding functions to add
or delete or find a packet scheduler on mptcp_sched_list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  | 13 ++++++++++
 net/mptcp/Makefile   |  2 +-
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sched.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 1 deletion(-)
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fd82fd113113..9d264fd4aabe 100644
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


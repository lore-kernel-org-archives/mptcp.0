Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C315AB
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 02:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647572304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUiEMbU85YReMz98lB4dcKozzqa05TaVJaK1DXyQ8Kg=;
	b=Zytw6rdIg5ZtfQsZmVFiw72dj+gXQVrBPgbkaCuIC4Dd9torChcSxVKxZeQttbF8y64MBz
	SVBhtT8CdFC+BsaMsQu3a5bbbt8iSn6+nWYrOE+B7m9xLsL51MjBEUxJP6jidVOCuJVGoh
	QDwUEWLmiVo1DNT5D02vgIBaQtgD+Fc=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-LM81veyfO2eUJebpSbLaYw-1; Fri, 18 Mar 2022 03:58:23 +0100
X-MC-Unique: LM81veyfO2eUJebpSbLaYw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m37fztI0N9f4tpA2LzfB50S4BFLn+xLecIyz2tSXmCgpsANfYg14SGmnr58d/eb/kOHEnBNvnCP+0ww0Ritoi8Qm9HB+azNjzyzI06ZzLgXDcS0Ql2Mrs6Yk+4D4rxUM6iwtftthdSRKo2TpgYzzTQoS3Jop1C3qEzqnaRHivIlnuia9m0ji3FqLe8SuWlIR61JRuqWTPwrTD8lG3SWlT0B5eA5AmHpJMrS6PHsFC12UC+AuKZjamSmY+BtGoYoogMDwXvQwlnF4BaYcR9GS1hnRQzGcL3q0S/9myQsF1rQvaVAqvt11PENBEBVJRSS0/m+Vzh7ixLaQ7bvxpAjDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBwh+BstVxnZcq4v3Nvhg5/PkI2onUsBH87oSPa8NaY=;
 b=DuQPmDfvAv4oD+t0tJzWl7LSZufU4Uc0rHiJCOGuiNuvYabvLGtw6dP3ZIlwicgJLclAmOkY9wcZ1oZz7JkZYiednEbeRd77Di/Zv3DB+412nVlqLWTM1q1OH7+Xj+8rjU3wtZ1C0GG5fh7RK+igBpgnj/e9jFUnDAu4VnXAjjbwa/TuWAvsgaynQAZEoCKJLJakPNwMEi7O1KOmHBa4/jfDE7FUYIG7mgTyPQP1sPiKKPAitSCUpbyIVMFjDcsn/f+IocwQqbLrHbvZ7T2cmHeU78ufPx8s43dHEXgaEkfTAvblWuLmjR4j7I5XlpFQqwk9/nMUAUg5sZFdvuDmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 02:58:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 02:58:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/8] mptcp: add struct mptcp_sched_ops
Date: Fri, 18 Mar 2022 10:58:03 +0800
Message-ID: <50a302c839de8e9f885b14b20f3d2047cb8d0197.1647571510.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647571510.git.geliang.tang@suse.com>
References: <cover.1647571510.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02491f69-8f1f-4b6e-80ef-08da088b29e7
X-MS-TrafficTypeDiagnostic: AM9PR04MB8321:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB83212F99F54F45CFE7B3F608F8139@AM9PR04MB8321.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	82DyYsTSU2fN34o7hvUJb8TwxsrF82Du6ktOTFTqE8WABAIQEymftSa9gl33qCHME6mnUlKv0hPEQfnDNsPMboPjxY1V/ULow95yqVnIe9SAVEzC9qhJZl5iptVMbijb0RA3OOCBLX8pSQtKdv39eLaBHMKsoRDemP5XPZ+RZMIqsr3wwIwMyOKjdNSnL+M+M4LKIJyviN5zMQ2BenWGWlwft5IK18siDeha5cr+/GdMTeSrwS+tOddceEjWyywBl0hq9XRhEJiK1mwvWcb31O2FbN3GBMNGxZSStLhk2U3L0ppTBJnRlf+sXHqn3TastxIqUGzPyjtq34vAt2vGFGUaleBWH5DtLcNMZ8lNBeTDHPJdvOpRcaViWPHCo5ANFRB6K4YM0CdaM4ey+jbY+LntVbV1Z3J0WVPQXZxOptxVw8bnJ/8yBJIr8lUuvhTsWmhw7013aFw9OyK1H5GqddDE7tXsgzg4agM9GXaCF8b1zE0yIsmfqyTuDaGGthxou3Y2sKFKAmujzu3n8/AMaJ4IDrpYeboLqU77awTUnALRQaBr78/U6haDcUM1jXMV0jH++P0FLlI9rxjoMO1N7VbCpgAIm2jlfEy2zUo1mQTCvrVVhRVpp+GAMLn3CRbRy64ozVLLu1myMd4v24MH6EJf0/v0zeMs8knqU66lPUlvwYkRIRhnHqx7QFSOmbq4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(86362001)(44832011)(6666004)(5660300002)(6512007)(6916009)(36756003)(316002)(2906002)(6506007)(66946007)(6486002)(4326008)(508600001)(8676002)(8936002)(66556008)(66476007)(186003)(26005)(2616005)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d56i9NzLvL+HfL+kk+ddbcSRl35X7ffnUwwrPk1SQ0UDZz6FGv9/ZDspWUoU?=
 =?us-ascii?Q?oB42azDpi9TYLRW/g506+kutAI6A9cPwnkra6lrWChzD3zFfEtOVpKVsHHp4?=
 =?us-ascii?Q?ep5IlysvwVLnCzCabvvWpgwMFjNX5aWoqhviJS/Nrrq6TL5Cb/nq/l/Ecqou?=
 =?us-ascii?Q?9XCInsDYL9X7VTvFp7Lcxa3gr0WAzxhU7l77x1r6yuseDpzQeQxJCh+kXeac?=
 =?us-ascii?Q?ZrPR0YUhI6PSzUN18joJIS9hRtJpKm8l8fgnJ3ZPoHtK/VhgirLSD6HgPsKV?=
 =?us-ascii?Q?a0QDUnUm9CeBnDwNKTmh8ufZKnwLATiMvuVOaUCKrPO5RhiaHICGurWCselF?=
 =?us-ascii?Q?FgrWw+1QjBKz+bhOtd01gSk+ed/Pz/CaDhsOFgtWC3MiPkA+m63R5etqxuJb?=
 =?us-ascii?Q?/FuEC/M6lfdhBTiinslyD2eyetoPbCiFlXMdRSQB3iinF1c8k0Zqd5OtTT7b?=
 =?us-ascii?Q?K/QSQsnCIJ4behutbG8MbYjepOigSjujCRIb98d7yehmpPdVd7Gq8DkNjEiG?=
 =?us-ascii?Q?Br1u6vQjEtONXyj8sDfJhc04XpSh+P7xTT/5mNHWp3dZtSU+FmdI8WxM1gYX?=
 =?us-ascii?Q?nVKjfvPeBv5+E51MixlqyQ4BNd/7ta2ShnNLCde/NgoYIXmZ22CzumTZHjcf?=
 =?us-ascii?Q?q8JntBdx954WitEETVWL/da5B/Sksfypc/8+U80EcXwzjjfWOu/zZ9qq4j5g?=
 =?us-ascii?Q?zDUN4TaVB4S7J/pqE+cEO9byykFiajgqalK4Bxs891XEp2ZhaRHs7NbXmdf+?=
 =?us-ascii?Q?zm09ySMEEaKv8gJEx09aQz8CkDAVzK2xLbeJ5T8LRLw76eD+cpePsrvunal4?=
 =?us-ascii?Q?E22i1kzRc3XefLKGQk+Lsde+9zkVkn8EOr2FajTVZ7NhBO+PsVDnWUhbBP87?=
 =?us-ascii?Q?oeKLWwD/xM9/B1EfaItd0Ws0NeI1CWBI3GsBlBvGRBiBlJOGFp+aXJFPxtHY?=
 =?us-ascii?Q?o2mE5D0b1y7j11Lv3hwn/MMeFmE0SK6dYscAH09hTKCptF4ObLQoPuj8MDD8?=
 =?us-ascii?Q?h1F7EJ5SI3kGZrzhvdZuPve+9ojlQT6NTcngu3/mTO4U/gu9TBnu11Kuc/th?=
 =?us-ascii?Q?gX0yDPtyY9/oNxTueXRpeE9+MvrJ6yIfksHVY1tEm4VPQlZslBolTJQ24mje?=
 =?us-ascii?Q?/ejV3e06kLJ+H+K4b2oq7kuozZ7d4ctE3FuB8FB+Jz39X8Kiq+57pYpngg8s?=
 =?us-ascii?Q?WR5vJzWC4t8AFPkepzasjF4YSnyKRGkkI9c3Q+b7D1K3UHNstNTHD3VHAEqG?=
 =?us-ascii?Q?vVu0TXE7hkhwSSbybFrTV/1ybxf/nfsUKOQHu4CxemFYidUb+LEHHn6kp+Wv?=
 =?us-ascii?Q?WBq9PhZYFBmDpWMapCMmpGZGW8RtxsX08I7+K/Sugs+PMXH2m1y/ESKO06jf?=
 =?us-ascii?Q?INsWsxPNDQtOW/6kKh6lkcSLSJ7yRDh6qPrNtL8HTtSnjA7OS7AL1PCPFDql?=
 =?us-ascii?Q?3k0ZzrwOaLDCC6bFqL3Bl31s96kbMiv+HvuhsDd/hPaFWBnK4LEvjg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02491f69-8f1f-4b6e-80ef-08da088b29e7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:58:22.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rqy4gsH3gknd7PQ7JTQX2Vl/MjHGf/2C9JTWloWf2qe1bYmNSgo9/bOhTPqRNqlsXZaGGKB5bC7WJ8SbPFrWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

This patch added struct mptcp_sched_ops. And define the scheduler
register, unregister and find functions.

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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..500dc7b3fde8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -605,6 +605,9 @@ int mptcp_subflow_create_socket(struct sock *sk, struct=
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
index 000000000000..88ddc4aba4ea
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
+#include <linux/indirect_call_wrapper.h>
+#include "protocol.h"
+
+static DEFINE_SPINLOCK(mptcp_sched_list_lock);
+static LIST_HEAD(mptcp_sched_list);
+
+struct mptcp_sched_ops *mptcp_sched_find(const char *name)
+{
+	struct mptcp_sched_ops *ops;
+
+	list_for_each_entry_rcu(ops, &mptcp_sched_list, list) {
+		if (!strcmp(ops->name, name))
+			return ops;
+	}
+
+	return NULL;
+}
+
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+{
+	int ret =3D 0;
+
+	if (!sched->get_subflow)
+		return -EINVAL;
+
+	spin_lock(&mptcp_sched_list_lock);
+	if (mptcp_sched_find(sched->name)) {
+		pr_debug("%s already registered", sched->name);
+		ret =3D -EEXIST;
+	} else {
+		list_add_tail_rcu(&sched->list, &mptcp_sched_list);
+		pr_debug("%s registered", sched->name);
+	}
+	spin_unlock(&mptcp_sched_list_lock);
+
+	return ret;
+}
+
+void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
+{
+	spin_lock(&mptcp_sched_list_lock);
+	list_del_rcu(&sched->list);
+	spin_unlock(&mptcp_sched_list_lock);
+
+	synchronize_rcu();
+}
--=20
2.34.1


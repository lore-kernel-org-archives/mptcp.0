Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88828EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651412960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oovb+ZHHC+dYdEbAU+x4rLJDmPAeMOH/dTgCE0EfGU=;
	b=J3JZNo7EyzjlHassyNNqmcyxTKfvc8KwVSfhmaY6kcmOIMhOlFSzAzXsCUNh/CufVbqtTf
	38nVwLxT6uBqaS1ScAmiZpeBwqkz3jNM9zfL812dibBqr2iaMWbJ8MTYC51V8z4R24x9fB
	6pkUvJ+0AyrsrFrF4Ax4CJCUaFt2hvE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31--JenxPC8MGyvbCvXn2Uubw-1; Sun, 01 May 2022 15:49:11 +0200
X-MC-Unique: -JenxPC8MGyvbCvXn2Uubw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ42F82zxR8SItB80IxgKRobIVchOIExbBj1CpSYxYEK1hQBDvX1fFyzYXw58+6gOmn/KaPNch6buRNTKve2zKnLfb7gsasltfq1ssO/HY7SBIMXSSB2kmwNxHGi10lqEi+x8zIT5F0AycgeO7cOkz4Gmc+pNkVKLn7xVo9wtxQUqaHAleaJtPCwglB3W+er6rj7xH/tPEBVWBuS5SS3LjMAy2Bt4CMSnJXS0uJk2s0ZFmayCZ1EQhh2UlIOGfd+N/La8zZ2Z+cK1mbpjtanSu17gRcaA3S1/u+gf0XGho6utvjWDoQkZPRVrbdAmVVOk3htSJmnthfk4lEBQCODxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjxaVLgKBGQww/ySwgmhoftg47xFbCxbplz9+bc0/kk=;
 b=fUFHKrCwZCYBK4kcRwB+NYYIn1bekIoPh+K0LJZljP7mX429Y3nc7sH7xKcFcdUbLbtr0Hj3ioDjDe/2k9SJsaoNQcQcHzl44GsVMFwBI1oSXB+bV+QzbGfrJfZbCMTKe0V6DgrB81V+G1heA6OrjxnF8CP5gPJPeSyvLGxD9A8qYBc9OP/dNh61+Tya7JTMNlCdxL1G3fPclpe05qLMy0+KnEZ35wiRfIff0EXV0xU7/3/QUR6SCh4eJvL4hEPmS+jPa2pX2r/bH+Kez+Sz2YfbUcfINYrrTkUYihyges9hlOOm6m8unICg54sKB5Hx8MTBW8YpSJQTcM/NN6EzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:49:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:49:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 1/7] mptcp: add struct mptcp_sched_ops
Date: Sun,  1 May 2022 21:48:44 +0800
Message-ID: <69edcb553754c9be998f21e3596ceee69e3e813c.1651412613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651412613.git.geliang.tang@suse.com>
References: <cover.1651412613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:202:2::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d92255f6-92ed-4a1d-d35a-08da2b795e9b
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB628358E135ABA866AAAE8083F8FE9@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pqMI5ECeEZkyyx4RjhqcEgW9ypUwaF4Sv7WnZzs9n6/9KqkO5iJJtwmqYRlLfkJ7jaVeHpItn285lhrxFqvyETA8Ec6vDEhDiDB9jC9atEHMs/93C5QmrFx7I7ntIsNr7RYeBwrUrmTWkBeE0ZUVp6baQpeMQBLnnqvQFYGJjLzkfLICQ+w4uIJVPRk+zxufzkIuPA5hCFfsSSU3qrzh//VageKjXwK3fUXW6h+1NXSNNb6NFMQ/dnrSc4tkMWmUDqJ/7+tHc0HAY7Uez9JbdTFm7Lt9i6G3DYu+9aNd+qtF0MaxOuf0UXvAJ5KMtYntxKFvWpjJ03/P6uKgyowuqQEc9COKAhEo3Zy74LQ7Kea7DiL7hz0jnOInQm2NlFY0xRPO0YGBduPPJndRVg8/paifv09FIpcl+X3xDv9wKRK5SRNn6b8mUv/CVhvZhv5cy7znv22BUe9wgKHpTZWHiImX8AHxLwfdKt2AKJpcfmiBDLkIyZ8vm/6byHKBb+pe7/43WLctIOPMNvXETVeA450ch5QS1eq75VTbdVtLMUwyq5YfYQ7b1QbwA6xBS7Rq2wys5DjJBJiQsIRVOTobw5D6JIua0zDpYinoCerV6qn4vI4aG/a3wogvRl426K8MbrVaRr/ZzZ4EiyMIIbJkWTbu76pnCegO+FcvoafIQ0n6wXkLmK/FFsUxomN50utD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(5660300002)(186003)(26005)(2616005)(316002)(4326008)(66476007)(66946007)(8676002)(66556008)(6506007)(2906002)(107886003)(86362001)(38100700002)(8936002)(6916009)(44832011)(36756003)(6486002)(6666004)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6DETmIq8pm+ugTha+CZPrvqsbMW6pB8jZqA3PDWJTpZmkSa5R4SbWuVbdDN5?=
 =?us-ascii?Q?h2+4FUcfgqx9b2LmXXs5pjeV2n4OtsHJFzrdq72modAs9acoYBCrlMSiYq1C?=
 =?us-ascii?Q?QBNU6MI04YX00GxhzlDfKg8d6yZY6gM861xFeueRXy8rHNKeo9FTi0CPMEhZ?=
 =?us-ascii?Q?F1JYTJWaGPqG/owM5qCWfPdzfWprG8MGKC9OSZYFWr7apbfndUPyNGjjI4xK?=
 =?us-ascii?Q?S3l9T/lNg04rQ+V2Jv92ZfpC2nZ1/+SAlNey41A4OPO69D74UgA5F2ZH15Bc?=
 =?us-ascii?Q?GYbmlAZHmP/VO1/cBgN+PsoP8k9FDpu8BhmJmrOuEv8XG3aHcgZu0FZfW5vX?=
 =?us-ascii?Q?raR6uKa0l1eF7wuEa3K0fUT9S4fsRL234zRdkpBH37GAEq6DpSwLulQXi15G?=
 =?us-ascii?Q?hNZpV4wRrGoOMSpk84+8nWYYaWdlcXTcNUYEfbfEBqVMHxE+Cwif/lt6ooeC?=
 =?us-ascii?Q?4HnYiNu8VSHGOWQPatSR50ToYDrqDiwRcl8Vmh/Ez9ESN9M1SWXwqhOx1/Ad?=
 =?us-ascii?Q?iwXMnLLTrysbHBg8C+mbEOM6dkI2X+JnJuyMJewpx6DR7Zn4JTAC+ENiHyhW?=
 =?us-ascii?Q?S+M3JUM3d+4itDfy5V+uwZxxqlZaUP/Kdko+Jd+qp5ElX2jtR3J8T9ipQXuz?=
 =?us-ascii?Q?sRqx1t1ZaZJyNXgyZ6UlARF0uuQA3xk0rMEKA4utJdoLBTDmCGXu5s/QiRAz?=
 =?us-ascii?Q?AjrYSGb7CNU79LjRUCPQ49jl0iWhE0V1fQiK34rj40Ntj7rlZWfjJFVUIVaJ?=
 =?us-ascii?Q?Mmnx8W0GUb2Kp0ymtorq9na4vFtERbaZOVtswS5Q6cKK4zCLbjX45v2CLgbo?=
 =?us-ascii?Q?EvCFkyhPCGzzlPa95F2veaKop8JGvZVyzxs3NWSdv+PS1O3o+d8pzKGunc4C?=
 =?us-ascii?Q?7JaczpKa41jrAV9PYWHnU/PsLaAkbAGt2uCoUrwJEpcXkTWuxLg1Fuz6gBbC?=
 =?us-ascii?Q?ZW3uf+dEvHBKSM+MHiMfBiHvYNPKp325+EkDh4dtntQmyI1VUlZCZNEb1/0Q?=
 =?us-ascii?Q?H0H9tfUMv4gIW1BzFNq6YN0aP3Qb/DANrqeLljtvN6ESUmNzM/s25cAJgbAn?=
 =?us-ascii?Q?WTsUfw5FvvtH/b7l9Mc0DKnhucjCuyuj5tNJIH/YbOKMPEGsicfiDYOtEZvX?=
 =?us-ascii?Q?pLQAHwyHpkCXQKXa1dJDKXbox5TMtU/Ltj8XoUMWDJTnzId0Con7xRE0W/GI?=
 =?us-ascii?Q?FrwLaNx1o2XF9w+MGQUz1lnMvP5d8l/oVwn7PJwHMBMXqfS1RhRCB6DctfnD?=
 =?us-ascii?Q?FJBmhiA+ukZw7RDlbgKMrKCVAKfOISN4zvUFI2WltMQdridpKhVoZntVG2yE?=
 =?us-ascii?Q?FrlwMeLDhvA6tYrQgK05P2qSJ7c0uUyMmPKosievD64KiEpaEvGMHMcymy9F?=
 =?us-ascii?Q?80/V8We2ZJQm090UUI/YJMrVFcaIVQK866XckJdF/LluqpV84Pycr1wvetI0?=
 =?us-ascii?Q?RkSt06XMEuxAe7uBIW/QmJzGVLvpJ7POtVqLz3eMu/FlQ2MVOf4u3uEK7p32?=
 =?us-ascii?Q?sX7paQjnSgVWN2MO1Tgb7btsP7wBgVdAplj4drnS7UlSERMWkDSlgSeDL5Qi?=
 =?us-ascii?Q?JdEqGoQwBgpEw2uR0MbgSjlbFLnD7jVGDuLEVUmVyL+1dhtVMISiWRuizZUq?=
 =?us-ascii?Q?Wn2XQPX4KipEdJIEPgfVqjw93VcInatVVjn491D64GpxMb9lmR23A2f3ntPv?=
 =?us-ascii?Q?SdAFVyZaGAXv7Lrqy/H4e/yrBOYBTy3J472sYlz02kpJ4M1GWwhYb+XG4nAH?=
 =?us-ascii?Q?hGZLTxH4xEACpWCSIrVFCqyqMVIXDXI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92255f6-92ed-4a1d-d35a-08da2b795e9b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:49:10.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oy2jTouVO8BFtqVupHFPrMFOeBHNazM/mnhFqsJFyI+cfiSnXTlFLPiTxzZELXJFCBT2GnlLKq+xt3hH3X2D3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init, release and
get_subflow.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.

For supporting a "redundant" packet scheduler in the future, this patch
adds a flag in struct mptcp_sched_data named call_again to indicate that
get_subflow() function needs to be called again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           | 19 +++++++
 net/mptcp/Makefile                            |  2 +-
 net/mptcp/protocol.h                          |  3 +
 net/mptcp/sched.c                             | 56 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 18 ++++++
 5 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/sched.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4d761ad530c9..bea7608d72d3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -95,6 +95,25 @@ struct mptcp_out_options {
 #endif
 };
=20
+#define MPTCP_SCHED_NAME_MAX	16
+
+struct mptcp_sched_data {
+	struct sock	*sock;
+	bool		call_again;
+};
+
+struct mptcp_sched_ops {
+	void (*get_subflow)(struct mptcp_sock *msk, bool reinject,
+			    struct mptcp_sched_data *data);
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
index 6e7df47c9584..8a7f68efa35f 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
=20
 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
-	   mib.o pm_netlink.o sockopt.o pm_userspace.o
+	   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o
=20
 obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4672901d0dfe..221bb6b9860e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -621,6 +621,9 @@ int mptcp_subflow_create_socket(struct sock *sk, struct=
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
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index b5a43b108982..5b8eef4f1b4e 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -6,6 +6,24 @@
=20
 #include "bpf_tcp_helpers.h"
=20
+#define MPTCP_SCHED_NAME_MAX	16
+
+struct mptcp_sched_data {
+	struct sock	*sock;
+	bool		call_again;
+};
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	void (*get_subflow)(struct mptcp_sock *msk, bool reinject,
+			    struct mptcp_sched_data *data);
+	void *owner;
+};
+
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
--=20
2.34.1


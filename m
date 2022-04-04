Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4423C8
	for <mptcp@lists.linux.dev>; Mon,  4 Apr 2022 02:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649038212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw6sy+dxDnhhPoKiLnOOZXtBCtJwAO5Rrv85zrosPXc=;
	b=awB1ZDxhBKbo5iXsDEZlwxawAACrj+Kc2q0khakokBwLQAZ8JwrSopAGkOHxWVXGZe2EV0
	cZ+NXiJz17oJ7Ei4qs6emWxHKKWPKta1K47Sn5JrUK/+JHSsknIA600Ob8kYdhs+wTc++0
	8LYPBgmC5EeNvV//EXY1L1oDb2BLuzM=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-m6GlD_ShPUKXD_vAjQrHIQ-1; Mon, 04 Apr 2022 04:10:11 +0200
X-MC-Unique: m6GlD_ShPUKXD_vAjQrHIQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEtnLSxGIJj+xldoict+qePei/8JbcR2uquVBskMkbv7YOcApzHPpdzYOdWcRCeMO0MOZ3nM6YIa8OsOBQ+6Y6MPqXrdqoGuAJue40U30xVb9K0ea77lrvWz2semHW8lqyu5UuxNoUjw7nVqW10kyOpwegSqBt/E1TQDzbRUJSI04sHkxm5iUWi1PLohn7pi3+duQnGYTF4QqAEgGUztG6VV5l78P+i4J7rm0A62g9ELLiE2GacBSo2jRsXf30WdVAaqYZ7L0BCsrH3sNYqD4+rLXw+iV18KahMWd3utODCfXm41J7+ofm+NQtgg1FebX4kiHWBcj5zy0xI87kNgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCX8myZtyLRft9D1sh8gWC08UZmLyQ/e8B/2nON5+ro=;
 b=Nw853BbebN/vcA7cKLQislOAAl0YBFgrjaikPez7tW5OnUWKGssFH3YphjJUpJOJ73IPYNqAbYQ5UkNv7hAQ9/B00CZDn93z3nQ/PHZUN9N4mryZ9/kFsov2zjItS6O9QRm/66yWe2fweHc8vkUrnegVXLH4JW5I8UErqbet7Xm3Zyij0lWigtKY0G1DVnx/NjYpJ6iDDON3wfSu1/JrzFrQa6kKedeYGIo6GIZ/ETvw9FEqTuHzOAIqHLbwE/bkw998bj1v6ivUhmCDlRyCb3UAW6BT0YqcWeK9ypr2yd5mCrPmzuDQJYtsZe6rsXOU0ecZMpiZ4kQKL2ob5gqV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 02:10:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 02:10:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 1/8] mptcp: add struct mptcp_sched_ops
Date: Mon,  4 Apr 2022 10:09:53 +0800
Message-ID: <dbd813d09f67ee4c3fda0e2da5c4886c64b61d2a.1649037838.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649037838.git.geliang.tang@suse.com>
References: <cover.1649037838.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89130986-dd21-4cb3-3cbb-08da15e03f2e
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB7189B83E21E3B79E37DA8BD1F8E59@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YQiZy2bh7SP9ayIm+Zy7HKwDogvt7aHBn9+6pvs37hkP45Eq89UT3ZfnXh7oLjXD4bQGaBvAVAUGd/iFAOL3HCqsojDuEjMiLBNT6ju9L/kdfwhD5V46Ejfpkz/Hfw1eewxwHSIOeyzGZ6lQEN9rTlP6huR5ODRHpvsSNPrRqQ8wErxscJpcMz+C4WBxyi3T1XPUeq4Z8RLkc0amMWQujzU2MiZ4zlwURJhBG80erBnmsliJoFZTNaVZE03Xtpg2FlAQcXAI2qoJ2McqINsWkVuJnyIj/24nYUewNUdBH+OeXupt2kMZBZcIRP6HLuexbAh+ZchngmIcBsp4VIE0sTTpy0KHdGgbtyknI7U9VBlObXpS1FcQz7SGaA3KEt3pm4yXmJ1Fzy/Z+CkIUUAbtrLJ+xtM4oob63ACVKJC+npNrRzDUDstHgKCdYh5cmWICkATXM4FatYu6llBkPQ0iC/BWQn7hC/Y7Y3cVjOpDRbLwhxR9H09D+cCS3r8OVTSo/3OsZ4c9d8/pw7E15XUj2yydsgK7uclGLcY/Bb4gJLWh3SpzO+zLhXO1+aUbUKfyBpHwt1EF97+5xQP/H8LcwvEP8mvRyLrtFjl4pvkgo5Uy6m5bi6mAl/YyqZ1GZr+glCKEHxzVCMTSYKf8GybdtaysXj8Wxhi6Tc7hEkrEV1yo1EcOXHGRD2fHu/iVx5s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(6486002)(5660300002)(83380400001)(8936002)(36756003)(26005)(2616005)(6666004)(2906002)(508600001)(38100700002)(66476007)(316002)(86362001)(6916009)(66556008)(8676002)(4326008)(6512007)(6506007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W503cM4ZPok/YESRPh/CRuKhHsQ5VugWvOYKUH40Cv81bSkQNPL0rKN9hPbe?=
 =?us-ascii?Q?kk4QvLyiqKdiRrJZzmHjqUUOfKS9kxVbuBuedVzjRflEByLRxb20ZT5rUUQG?=
 =?us-ascii?Q?RUQV4Hl3BlGi4vHbCPZkc82GP14yNR/8WrxRfzBh+HahJfJ8tmGxpBsaecpv?=
 =?us-ascii?Q?AxbDpQ16X/qLkgyHTVTwAGE53B8/CYEPLpiSBWLup0pbRTMsP95dqKYPe885?=
 =?us-ascii?Q?ZJB/gK2rG2AJT2r/tGEm8eYH9HuKW0Nm6Dtl8LYb+BbxvyTxuq13CjWifeGy?=
 =?us-ascii?Q?G57X7kQeont1j/7lCpz3PqoKMI+xMSNYd0W0tL3IofsTiIPgOTsHhExsZxvk?=
 =?us-ascii?Q?6/+EvEZ9MpPPM1z07/augSJNdH2sBpqRceEweab35718wNptGFmJgP/+iEuo?=
 =?us-ascii?Q?mWw1sFdJwTrWNn68tk0SgHIckTNua3BXUGu8v54Vgf0px2TLKvCrrCTswBUE?=
 =?us-ascii?Q?W9QYLVM3PeFR8JJn/TdqeJ19FA/6g4To1EOnp5ogo81EZhWWoSH2jGt4GBLV?=
 =?us-ascii?Q?pAyaR02oerbnw0MvVzKhe1qwT4x9qx5XJqirzOWMryV266NYxRxj/JlG5Eb2?=
 =?us-ascii?Q?uxdi+X/RqQsWV1JSlcvn6DYRSn6q/V7xamdUhb1wbiFjUN+wN20gqrtyL7Ke?=
 =?us-ascii?Q?7Z7gnmAR+HqvjC3n0DIlWmp/pdRl6m36i7mgQNGNhaEVcG6fYtKkaipDhEwv?=
 =?us-ascii?Q?FXtXKsK5n1OZJWzYQqxZ/w7DyJNt9xBVH/mKFhepAM6GTv/ka/NEF6Dn+4+p?=
 =?us-ascii?Q?Bm/SzvrIgvlizxYDqTn492zglSrsgHxyX384yDNjjgj0qYYiivD5gK/1liTf?=
 =?us-ascii?Q?KjK5qvjt/UB+OXf0mHf/oywriS+i3FYOmWgx0qhDpBX096axuunawMM86MN4?=
 =?us-ascii?Q?sf528ozLmbn3lPz8LUwesmh5VdfomFVdt1TCzSyBqYn4kyFcdq7eJv9/Tbq+?=
 =?us-ascii?Q?AxFBgaX/GsrOrmklreLQRWG/fcmeboqNY2OZ+LOBxBU2dc1fhzqN1HHVtQpG?=
 =?us-ascii?Q?e64K98e0xYIDxb1OvkhOMgAeLG905Cy7mTMlF0kE8ss6h3T2zCl7cTI0d2Dj?=
 =?us-ascii?Q?VaQ8Ve504tcDtdVS+vtT1bGOsPDG70EzchB2+F9bJ3Ksca0PdVxSHooP8mg5?=
 =?us-ascii?Q?nCop//uN2EMy5iDuahOVlnaWwPfVz967up/9ihPKQWoBE70sqjLpI3yR1ll9?=
 =?us-ascii?Q?9OI0hvXiU2nJ8quUUGU5DudvGkOmwrDh3yW6yarVdW2GbJiu5EPpdFUfooud?=
 =?us-ascii?Q?pAgoViGDnYVEZlCR6kVOfDoZI0S9ehi5It1BqZuQAsj6TXXaDpTvsdcO0uBV?=
 =?us-ascii?Q?UY5c45kVxZuesmtEP2AgfraE6t6b/4V3VGdRPks4hlcVtGuZftelrx4ZHpsD?=
 =?us-ascii?Q?jXWB2pp1ha2CDUbU3LmhB41oWuaCst89PSieqDFQiMRtPFj02U0X70m+HbmJ?=
 =?us-ascii?Q?/CiHvOGkdfdoQLorejAM6wygspfT0OqA73UHnIvkYNoYC9WPTwGmArOxtKBX?=
 =?us-ascii?Q?e8q+2J1LnYlsyvIcgJ9xmtB0KJ6M7hixZg8Ns7WvTwjqTJR2sdHiO/kfZQaK?=
 =?us-ascii?Q?6OSjJ9ID8SMy7Kgooy14M6yhfUVQ3GvgN4YMgKFjFc5uxrBB+pClR9GvCPEK?=
 =?us-ascii?Q?dPD0f/Y9a6xC3F6RISrG4hC6x3x7WCSIk9oxavwUNQlR637mz2/JjihW4NPK?=
 =?us-ascii?Q?YM5I0Q97c91F4qfNaPSpIVGqyOp6WEOaOdyjySu7N0JVd7NTm4xm8fhW0imB?=
 =?us-ascii?Q?YSuTk2nj695Z6PAcTMUu2wPjkJcZ1mo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89130986-dd21-4cb3-3cbb-08da15e03f2e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 02:10:10.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZLgB2Y/+bdxyO1HlMS8Xcg3Ty/4JlzTbJDeur9cqXiql95b8Oigqv23li/jhkRtzLWmjpaOUms76jXgWkhW5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

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
index 877077b53200..aea7ed9a2250 100644
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


Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23833D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647785367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MAy+91Kg23sBeyeawmxSOzlRvi2e+ZQO7FLfz1bE1Y=;
	b=EWJZ99QI9axRODuGC5J274RAAzfMlLu6jMOVzZdhgbmrdbHgplHxUAl8D/lZ4BZ4EKcydN
	UKSG+zeZHrfr6T8M4i0XJZBoPH7Kn1A7hsM0qWfnjbZxI69nU/W+NsK6VhtONn0nZ9dP0i
	V6UAxZH7ZAAWA3XuYVDiMCyVI2n6HUA=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-jvm23xKoMAq30dtTzaIlbg-1; Sun, 20 Mar 2022 15:09:26 +0100
X-MC-Unique: jvm23xKoMAq30dtTzaIlbg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLmV20NgN/AiBff7VvNjKTpTUa4r0biRP/iKxW87zmLasr0qaTo4n7HPeepw/IMG/TfQ2iwU8xnja3sz8tLnwOfTxrtQF7JPg0TA95a9YscL8U4CC3YYAK0x2lS0WF0LdOrbfBkKkeynk2nOq9a7HdMwUGYAsjo9Xw3RRZz6gcBWnXTWOjgnWsqlIXlKNaXQ864Mw1k5FtNmJ0qQb/d6X8su+z6evXtrkv5PhWo91CRlEMDzRjbttvoGphXyNyaeVdh9J7wN+YhtnEkZqQKA4FmtAIe+DHrntNMC06yoFQaLsTAbh4xirfsCuV3YljvX28mGlPDUX7eH2UqlCUO6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar2sgt6n1vDt42NO9hrl4dj76DBnZY6SLqbb8A7M4yY=;
 b=NyzrVsbR6Tzx72Iiqr3U0hg0iY+uFNfkBdy0gcIjD2bbzSOWANjdCw3R1Q6qw7I6pUCZ91qhWgcDefyhTtIAF76OLy/3ItqR9ylzQZ5ulbd2ViVUBLxHoJg9tGufu+T77vCHAYsA+tQmSNQKRfix9dKBbY7lT5339jmBYY629H32gFRm1d/RQNPfwfWwfYSuCFoCf00JmLnynCk9gAoiqYZizMUdG4NeiMBlrOL8sJR8bKlliQ2UpODOhpytW4VfpHCR1ux3/WYKnWykS7r8FTDqOee3l3LIYIDMZn8TTklslBsdwBViwmxgBOaWRF09sNmcs7u23LIUjEvsvdyn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 14:09:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 14:09:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/8] mptcp: add struct mptcp_sched_ops
Date: Sun, 20 Mar 2022 22:09:05 +0800
Message-ID: <02c1d2d2eee134713737fe5c5f73127e8c741589.1647784679.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647784679.git.geliang.tang@suse.com>
References: <cover.1647784679.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0255005c-44f6-4824-b647-08da0a7b3ce3
X-MS-TrafficTypeDiagnostic: DB8PR04MB7035:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB70350D3414B7444EEBAABCD9F8159@DB8PR04MB7035.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KfYgpDI2Lqwc81tUR6JomuVAuZ5vwiZiySKOPcxt44Xpul3e/q/5KxsZcE0NL/7diUOquBnI9/SDj+rkREpsmoUneFCV/K1KZOOGwJiI0fOO1LuTBJnkTB/ugUmmXDftngy/YLgnbpGbS64jHSy+jmVYXM55ieSFE+BIAfOrGa6yyFFXRMclZYzTnmZM0CAh8P86651pArMfJAOc8R2S3pUSAWjFTBDfX4XmGzfL8lujSsV1eM+m4rAmc/tkJOEYhiVL4mUb2/qx/KXMXbEevI489kHpGfI52iQSQRMn1QEPwg0tKcb8R6lOjzlA6Ul88f5JvaRdw6X9Z1Bc9CuwpX4stR+Mr+iLoB7j6YCzrowk5gOeVsMYb7MOPjBbwdgQ5mUcw+Mp4dDAj04yi3PC945Z9XANgPdORK4Hf4WriL/M4dRXlygVieLdjIwSHFLbJb8Kd/pIO2Ub9Wy4CZa5AvTLrXIZbj4JQpgrA66KXukZvDoaAoE8dRC7Ks9Rt1P8SLiNoVyU71FAowiTTqkXN1H+qtlQbMce6AazATMKDCE07A/MiD/AilfRTwlQVLVPasrOJpQpvVgBk7gpqUUBQoJRiBg/iqE3yDFMVjv39nPSXgkHFz6r+LfQYqayhXeVkjbqZYSLmMv4b8BxfktbsrA1ArMEzJrzx9FkQvQal+DWE40mJRmea4rjgZd3sFVe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(44832011)(66946007)(66476007)(8676002)(66556008)(4326008)(6486002)(6506007)(508600001)(6666004)(2906002)(36756003)(86362001)(2616005)(107886003)(186003)(26005)(8936002)(6916009)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NZ7xviVquCVYrCb2VHiafdcxenKFyhc9efstdZvYEMC7Owh8H6EY847E0Omu?=
 =?us-ascii?Q?HKEdSN6H3IhpYDJselhkjD3hbP2ES0ob/e5kepI57TgPqotY49G/DhPZIcXb?=
 =?us-ascii?Q?np6QUIQ4E1TMyKd0EfLY5gIjljhJC8K8FvAd7GP3Ay1DzYd3mj04YRoZ5LhX?=
 =?us-ascii?Q?W2QOSJgOvHyZ/fMHNu73ZjNwsJUIsaPZ/QisPLDZeSxhF5jvi2yMntqdpvVJ?=
 =?us-ascii?Q?ZBssC1/oWkfeg/MKGt8Z9HZmi9O1d7/EpZJAsQYtlWBUuug0+RjD0sjKh3mf?=
 =?us-ascii?Q?U3KWDV8W6YNOKIL3hsW1aGJZWmGIv0JeUK8LZfmAkUEd32rkLqffHniMSzJr?=
 =?us-ascii?Q?RdEOYLT7qUdahxYpkcuIqN68XZBlWOGa+6/b2pHSAAP7Kj1snK1ebE2cVDUZ?=
 =?us-ascii?Q?/e6Vs+ltQVCXH5O2k1yo56qsLVpo1Jx0E1x/ux+3fLsLWcsUi/tYkEFA71xS?=
 =?us-ascii?Q?t7G9NgYR3YNxbNGsOZ33UuEkonAPDSKl+Nz3KHbIWJpzTKOHOnsYx0eQS6iZ?=
 =?us-ascii?Q?TS7hcx6bgpi6Iw/qE+bknk5yYr7Bcoo0f1dM88tzclA7WrTo8kNxctMy2fnI?=
 =?us-ascii?Q?LSbIrFipDoxAZCjvNOInsmWjvALbjh40GgF5nCWfG7FJlmr8GJiUrExhD8UY?=
 =?us-ascii?Q?xDxx5vndi5ceVujO+rqCz5aYKarXENIMo9mBBvaJ4wzkLFun5SHb1HCR7e1b?=
 =?us-ascii?Q?aNH37BLnJOvQbnDRqr5EIofBoElZvI6KyaZG0SfpJXPJLRLHv5+WOgr+iTKd?=
 =?us-ascii?Q?Z+gAIr31Dh+Ua6QuOPBSYxW8hchIyX+7rEwwdcDwnByGaIBrOmrf9mhD/zes?=
 =?us-ascii?Q?22y/Rg1l/7IRLsYDhd1cVfW6a52UXRH8mQL7RIuWG+TncepPgue5jHNoe2V8?=
 =?us-ascii?Q?JYqaa4Bk0ejUnW5Pg49QHXMEzZTcWo4iDjmUjWHOFnFiB+VeSZkdt+L6iEgU?=
 =?us-ascii?Q?iQnjeqKxQEPg3nyFBqlibV5UvQief8gvlJi3i0xpswOXT4T3VCPqSE8fPzBI?=
 =?us-ascii?Q?icX27eVBfs99VL5tyFp6wd20xg8tr+hLlxqfawWshcX+JBLnN3lPNP+ubzcM?=
 =?us-ascii?Q?pVmHR8KczYhIpf9bUP4alMF8Mmscd9lCmyJfTI8bldpPsfjn00xbSMIhsm9D?=
 =?us-ascii?Q?RVyQz9OTWmNNKMTMnuAzWMfaNdz78r/CmyqcRIRBlTLcCR4uQqLGS0lyiopn?=
 =?us-ascii?Q?lTWkejX+JJUHJZDH6jQ+7005EOuWcC6WBeR5t9g7LPERJkTqzfB6N9iki4Pc?=
 =?us-ascii?Q?5+y1u1LEQCf0zwVMxaXNbYhY7fG0ir30+95qwukG0HgAb6thjkiMpVMhQKcQ?=
 =?us-ascii?Q?GbWSYs4PTlyexbvxCUA66k+oVfOdq3Vc5jfxEE/U3cy3OnKZCrZkOHBglZxQ?=
 =?us-ascii?Q?m3AHcQV7FXu1Wp8AOca0bUofOFZgCbhMlaCaB/62h4EchiKmADYTuCrgtHg9?=
 =?us-ascii?Q?4c+KVCrmNQkYZeOjewKgB1J88kf861sfx7u7f8N/F37zecZKXu2mFQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0255005c-44f6-4824-b647-08da0a7b3ce3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 14:09:24.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh5C+aS0+3EI87yUQhtWkDX8nBtcdVkYyapWugN2FHHN5rJifnE+ZqPEMvXrl8mo5HXNhK2mgN+MX31OnEzl3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

This patch added struct mptcp_sched_ops. And define the scheduler
register, unregister and find functions.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  | 13 +++++++++++
 net/mptcp/Makefile   |  2 +-
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sched.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 1 deletion(-)
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
index 000000000000..53a1bdaae2f1
--- /dev/null
+++ b/net/mptcp/sched.c
@@ -0,0 +1,55 @@
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
+
+	synchronize_rcu();
+}
--=20
2.34.1


Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D1A31
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 09:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647942783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MAy+91Kg23sBeyeawmxSOzlRvi2e+ZQO7FLfz1bE1Y=;
	b=eicV7vTAByS13fnM8klw2lvA9J2wvZZYPijULdaFZhXMOQ83CMeoBZ4YwZpW+g0wF0cxe6
	aZyocfEwhIkj6br3UyDdYsN+H554Q2gEm+XBjBe2f2IA5+sZA74kH7QWiGvbkqu9NKrE92
	Ple2z9ZOvXuAv5NIqDUowjqtr++qd7Y=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-edJxvMuHMrKFRasokACwXA-1; Tue, 22 Mar 2022 10:53:02 +0100
X-MC-Unique: edJxvMuHMrKFRasokACwXA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzVTS+S7LpJ9DW2p0XhGqjwI/0QN2rrkIE4Or02WK/RoELvnd6nQZzFd8Vn0PEu+wUp9BZDesXFZRwsagmF+OHPMXSb2+K8a3XRsF/imlCDge2IRwJfPXX7tOTcnHXBix2BtC4cOogFAcKXrIU8+kuPS+IKgmU9Wv6tWmUlrbfqi4w0kLdQcSTW3ojSWUc/LATwTp4qZ3S5GKCDrvmB8CXfihz1NXpx1xMkB1DGwgwCPa8OHXcifRZOLG3Kryo67xqFDE5MBT7u9afPhEe46o2g3hPn01xZ8Ak2iDl+LjxNoCL71LPuEL6DsU6ZhMLO6K4iLLeNwKCOfN9lK3RK+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar2sgt6n1vDt42NO9hrl4dj76DBnZY6SLqbb8A7M4yY=;
 b=l7kzaR+AOhZoWWlg/pJORoFhgh5HUdOirSf2D1O6o5GZZjOtr5izBLpxKrOoqPAkBsbGV/APL6n8G35kQ4AdfljKrc3g5yySbV2EVIhP4T/QvrWDse7u/Svn39533l6EMkqCTpzs+OXji81bG6U6Uk7H9OLKjAEDQxL7dms1J7XnV5mwhfkxinSUKLU44Eig+5XNK7WeYCPebTtxtYPJFaCne8zsgHIw/Hnz9RYHPj2lntsOf1dlqmNevMLOvkCMW+mSTJZBrugfBdawlfwIKjDRKjuHjBlC6uvfYhE4SSvgebhHWhHQzJ2upcvjEyQsSG8hKxK+gtU7Tr6q8NPmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2282.eurprd04.prod.outlook.com (2603:10a6:3:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 09:53:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 09:53:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/8] mptcp: add struct mptcp_sched_ops
Date: Tue, 22 Mar 2022 17:52:36 +0800
Message-ID: <02c1d2d2eee134713737fe5c5f73127e8c741589.1647942374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647942374.git.geliang.tang@suse.com>
References: <cover.1647942374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c283c3-5352-4962-3c6d-08da0be9bfe2
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2282:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB22822988A51EEB9AB62761C5F8179@HE1PR0401MB2282.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cWDVyYGeI8brebT/8hgeggKSE2tvHIAlBju/9xkGbCPHVTdf5LuST6seejp0XAXUAdDmp4Twrp/v84ArToulcS093LPASPiipznFSp4MklcxtvKlWJ0kb+25Qmgy7KME+cFVKe6lgK9X2ms86RJXjbSJERWNa2IKET9r65JE+1uXXTBNdEACcVLxuQe0EpAUWrWR4ylYlQ37/SLLLXFcwM8IC4TOXOLXLTA56tnPcAj26eOvnwqndXuDmFaMIuD+5kXal6zTk4eyYWTnh1yjYqJ8GKwva7AKllXV0AgACoiLBFq6TsrBPBK1alk2P5MdG1NZs5SXUM8qmnjpS7vF+vbtAyqoRMgaa3dJC7ZGNwhWXnXPG7JEFnRb/WWCk9y6YaTssyMelpN7eiER09/aMlNM9tOnJ9d+/qcGcXIUWcI640T3pr3Kioh4eyhUNR0yAKM8Abl6FrPeDEHacYHTDpAMAV1VS+Q9dTzavzOdMKflg6Gmj23gU/pHqJlMbJY9dOCZrPQtMwtDnvzgo7fuZrl090A5AQ1RzlouEPZaoxuVooZ0fjdYgEt1qYd/h8Dmj84I3ns9kzYYEpIwnvPARZxfaau5zcCfbqBKelGsI2sLfpb0QuP4JxNpkQVgrc+2qofR6613ZfCitylxPS/rFis4QP4MLoyXozqTSBI4T+RigUWXU8NgitKzT6GjWEn+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8936002)(316002)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(2616005)(38100700002)(86362001)(6506007)(5660300002)(6512007)(186003)(26005)(107886003)(2906002)(36756003)(44832011)(6486002)(508600001)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1X9/SRNwSyv2MMgtbMI5qsSp5llHqombrxke2prXKh9kLCiukzOVSVApX5yg?=
 =?us-ascii?Q?Fxq9F29PJSMVwnFdaQYCIIinrAnzyt9SSug06l0LAq6laCM07GIBldqg22q6?=
 =?us-ascii?Q?dVX7cbhtpHfxuxcNBBMpC+i5GXa8cRBDGIFJQ7GZ3xPEj5TD60YKvPhc+ySj?=
 =?us-ascii?Q?yPOo0EuvL4gzUihj5q+Bjp7KtYImdCqouw1M5syOybN7B3QBoZlPirYEi1FP?=
 =?us-ascii?Q?bI20YevXo4uG+lxqMWzHDIsY2Za5ixAU3NN/77m5ynMe9q4fVGHLJIKs3R6l?=
 =?us-ascii?Q?zlMs35m32QIGG2tzD+rpJ2RXzgq0tlD0bjlP+kUxH55QrbpKzUBrcnpTSXav?=
 =?us-ascii?Q?53Q8Xp3ik/fjUCBLErwfJJVqUJ5CKmU3YEuMVt7DMa/VySTzNTNaNfBfy78X?=
 =?us-ascii?Q?pf7R6sOHgyiJOJwtsK/aEicZ7b9WBh4sBakObKaYuT4qREuOuOSzbkH3XCrI?=
 =?us-ascii?Q?WtneMHfzlQPdp9jtnZMgQ8DCTeWQluCMWTdiPs/RkPlrCtamh7is69oDmQuA?=
 =?us-ascii?Q?37tpaGCJdWSomjXpsjWYVnotTfOgjYOkKF/90IgxDpQpO1P5ri89apnyZRZA?=
 =?us-ascii?Q?eZyVbgNi0lsLyHJLNKamrIBUMwu/M/cY1Qi7I08vEEyk4qUdEjgC7KHwFOqo?=
 =?us-ascii?Q?lIPW+dduEd7+y57cDdSX0fFk9GovVfmuX6ekkaEEs1O8Az+n2GVF2Yw4z1NV?=
 =?us-ascii?Q?O4tYkLf6otjH6ncCOX8jpkpbq0cYgOSzY86iAC9mHfjsIvHwqbOfz2usVEcE?=
 =?us-ascii?Q?+0ANeE+p+IFEOWQnW0m91NYAlwWrr4z/ROsqCxR/+/bqTgj3VLaejwqrbWaf?=
 =?us-ascii?Q?d1krf5tTnMgFFKnfCO4XIOvWsyaUMqVnczilLn/oMT50jYdJ0d1pVGqtnwvf?=
 =?us-ascii?Q?U+/BXir26Bz4K6gI+YzkMgNEmQRIstuTb7NzxxOh5wXe2eBfgi9Z7Xrmd4iq?=
 =?us-ascii?Q?vQk+JTzU2A1RDCIOzjTiD1DtzJ9jwCYOF17d4LFHdzMProapi8EjhVfHbqGU?=
 =?us-ascii?Q?OU+DUouCEOHESi3lWzcVk7psqqC5rw9xO2hMiC2qnsUdmt1LFvG1sLnImFw+?=
 =?us-ascii?Q?qbFf/uoyh9YwleKQu001dqHjEN0ny1vDCuJw+9qCxzJyrfad+eFnQgjjbcZh?=
 =?us-ascii?Q?bH1V/lcZJ0ZsnPoahl0241JFReZeQ5mb+vL+CILV7aCIubce04qudCM76Q7X?=
 =?us-ascii?Q?h0w5H3K91cv1131c0zX9EkHS7WAA/sLi8skM6S6ZkIPdAQPRjT7806vGPBYF?=
 =?us-ascii?Q?0TCLrx7pOFAnmEzpP4XYZmwxAh3jsCRRVTMoEbM7L4WZAdVyDH5Ddu4PPCqZ?=
 =?us-ascii?Q?u0zhQ3CsR+IaFespDmxRy77o1+VMCytcq0eZnmHlQId+0F+Ofs1ForR7sWSI?=
 =?us-ascii?Q?YP67O5lxzCvop3yvsxJvjYuGRqafGJk9HF+WfJwmDohmc0xlCVPGiD3Axmij?=
 =?us-ascii?Q?H7OBC4Nm0avZ0PSPUJjjME0xSsOYr567jNVTowQjvO4UDxEuUNFXRQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c283c3-5352-4962-3c6d-08da0be9bfe2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 09:53:00.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2YNgaC+dWHEJo+vaJ8LQo+f4aeXItSkfM8SIOYF4Hb0yMx07p7QjHg/TmxNBxD/n2LWYVOfV+7GiV4N9CN2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2282

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


Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4F20EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73ozOgrfWsfxESILQ1NxiwrvKugMDlo58jmJs+BxxiY=;
	b=l5bmtRcse6ETdKV79KIMi8tAYFWkY9eIhOv4T41WTNC+5hDIQBzo9sNI3hcGzttel01gBv
	66HwmiV9Nz0vjOKS/7hZrj26fPCSCB6KyToQ/jhe1EzqwmIY1TWRLm2iWxjX9mbs8nZ6yC
	lDiWMxcND3sDO8mtx0DrOErV2galL2I=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2055.outbound.protection.outlook.com [104.47.9.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-tRnJ4-8pOuml6CaNTUU1GA-1; Thu, 07 Apr 2022 06:03:26 +0200
X-MC-Unique: tRnJ4-8pOuml6CaNTUU1GA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXAX6HWHVnnX9kIAf8TG6t816KRAPN8d2SjeO9n0Mw7JT1iPsMs0vDjrWMKYIrZRUArSplTW1oG4UJWf/r7lbsdlZsA8gXbCxFwKzQA2fQtpz9z2FzdRRY25VRhJy3spWbcLU1YEpWouSVM77VXUp7lVtyLehpGF9+K/KuQ81m0c51RkiH+wHI5Xpwo6mK4EYCUeiuP0hI5IazXafxseCBWGc/z95A2S71cvNJSnCyTg4UgZRPFBbHNt581gZUn+WiUGryTHVA5aCYq10X8+UjuKfw9dx3k+1Kqdp1vVa+pPsvuqnJqmI5xsNiCcbfElxV0zb2xGYQOtNd02d0BW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx1yjbrtd8F8t9UdxNkGcHayV4PzO459DIDdCQVThRg=;
 b=QnkVGdz2mHdcyVjHFjxSj/kjPvCX0/pPpGhhIJZys9Dz27pmBarFfwLMrhooJ1UAo4JEo6vFzWRZbCueZ8m+c35+7W5tTuKPdZMdJRZ/SO1CJEU7NFK7kl48Jdr4U+EO105jCLAkeDhBMNpWBjFvBxcbZEOVhiDV+GIw40iUoRS6MLkX8htoEh/dxrHRoHhPbfrFW1zwig3KGhmpmlT1XpZ1WVwD+Kr3vDsfVPVDz7Xou17iNKHhJ4Km7gLFEHVYfog9RXvGICtETTaGHwYlQWrvViZA+DHnIemKq6uZKDJcK8hp+WDHyDYHAvwB3mvXuOOr0aEC0ekhL4DLuZkb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 04:03:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:03:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 1/8] mptcp: add struct mptcp_sched_ops
Date: Thu,  7 Apr 2022 12:03:13 +0800
Message-ID: <76be47e5ac562b6909a7e899ce7be4d4649fbe97.1649303876.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649303876.git.geliang.tang@suse.com>
References: <cover.1649303876.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:404:14::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55f78b5e-3924-431f-3506-08da184b9067
X-MS-TrafficTypeDiagnostic: AS8PR04MB8818:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB8818764D23688340962B084CF8E69@AS8PR04MB8818.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4oKU7yLcH74zZFhp2O+3/BDrkHS40a2JvS+JO5NAljACzShwe/kY9vOWufgS7psBg0FKwsH7s3Oju9YNAkLhl+x43azedkQHLhGP6rsSXnFBykUo1JxnHL/9PBsduGcPanROuWebM7yhB7KFT/jrJYQkUoK9U62i59hKCx6riJtGxPtiXoRY57vIj0vRqeADauooaZuHAXQWmHRuz4i4XjHc3T+kYELgEQzDtuJ1MFCEHmsNTlUwg6+2mpI9S4RnnW918GHdM2Tasc7CgP74/vNayK4DERAx+H5ZDx5aOxUxfG+MsbYH7IEblcMwjgGQ7aq7SwyW+OUjGFpUwp3xZAfH0lVRQC86xziNWQ6ay99FPOkhZ9fs9jO1ZVkmws348N18+QR+72BAMa4X1AkGmOez1+Aexd7CidAWg0O6S6PD+6Il0bqzxSVhRZs1PUvarQK4O5Oi63A6gZSKj0fqcrNHuC8SEdCN0DhbNrjlHdh7pksi6mbakaPaWCOqefHLbR9Iski+7gq1Y9HuCpUNMr4sAlg+9ReRu1kCy/Nxk6+mPcfFCZg+swSjni8TXOeO7k9Uh5BNV2hgLdBseyIfFfFa6WM8zfgj10YcZtc+S3dEpZfPUxgbeCuhltMttkyDXaH62KeeZPQzm5UXZVCDT0tUmqfBiOpe/1C4El8CHwpDpmEKxS3fc7Cz/BaFEYnr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6666004)(6506007)(508600001)(8936002)(6512007)(6916009)(2906002)(4326008)(316002)(36756003)(6486002)(8676002)(107886003)(66556008)(66476007)(26005)(66946007)(2616005)(83380400001)(44832011)(38100700002)(186003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H8pjcA2jgN/MV1eyj5TlWnAiT0UHW3QhCJWEq3gvyy1lHsXVwvZlMup53Atz?=
 =?us-ascii?Q?8CHloZJxJguTlBCvCY9kzOiDEF0hgqummFUjwR5NeGLIE7tOlpR1O70HVrWS?=
 =?us-ascii?Q?FRKUkaEL0srW/yYRd1shLmtCOX0VrQ1ViDSnI7xT292ifN7wwPZl6JdqMTd9?=
 =?us-ascii?Q?BG2u6p1PLIg1h0HPRG+PGAT2cjOHDVQokScPsgA4D9c/OLO9HIJ5LmwmXmk1?=
 =?us-ascii?Q?BUwPGv28GL81JfmY0PJWX8qpj5Y9ke3Fgt+mjuhsXdbjBtH3ZB+pp1iZNIuY?=
 =?us-ascii?Q?hDdCJdDGxO8J7rG/kT7cI3rzwLbHrd7Bv9NkMGL093p5OMvqfK8e3UAE7+53?=
 =?us-ascii?Q?A9T6lYxZ8OCQTxcrcDoDyqKPf6MPeUUL2OEhdwiChTexukwIPIdvJcg9UNmo?=
 =?us-ascii?Q?UiLbqvfPxJTxtYj8zy6q6izAHkB+k6Z13hQMfiPJ/4IIyu3Fugu5DG6WXS/G?=
 =?us-ascii?Q?bW/vCOradZMUEQXfgmEr+PgYt+KBLO/+2lc8ywBlsKQqSvJeqIC8Vre6j73q?=
 =?us-ascii?Q?eis2HZf+QtWKxEm/itS6VjSyQ2OWbFeENKnJlBS92FwfrVkG4iAmPSjBm0Ce?=
 =?us-ascii?Q?X950cWmD5T3/WEqtY8OUqJfGT4j54S/5JMxPmCUeCindAK/cswsfW8mqEONr?=
 =?us-ascii?Q?wssLd5u06PGbrMW/E7vmgC7CmkU3QUgGIsYhXnCnyLwVXBxh6fLPtQ0e+YuT?=
 =?us-ascii?Q?M0vu5Eskpvk/ZaEaff0QupgfYFQAKAv7nYll+EQ2NZ02zzyARYkQeV1xwRDB?=
 =?us-ascii?Q?dtxPHYq6+Z3ThRUWnI7CJsBLLp3UCCdr/MvUFvcfbEdA06WiTKbTZIRKCAcm?=
 =?us-ascii?Q?xHoyKNjRRCMp2x+XNXvNQ1e9JTxj+MKiK4mqq5k/nJ7v+goeDHJAAKJ03rhB?=
 =?us-ascii?Q?/n9fbb8iV2n5YA9CYUephVHn/Esystbbhog1voR5ehlNuwWPlSDN5Cq3Axho?=
 =?us-ascii?Q?uwPuow1j6tcSihdibG3pHpGz5hf6LD2oZI83Q7LYcxx7ODM7HsaSyKe1jtge?=
 =?us-ascii?Q?9NOqMhSU1TleLXWhY8e9X+Hz5kO/bwdZmUhQt9RfnpUazuM8lE+PscHI6j+d?=
 =?us-ascii?Q?SWu6RK+Sim55Aue/MQoRyt/hZ0wmbA3zlRymlAaseV3jecuwJxMKk5OeSG0R?=
 =?us-ascii?Q?i2KSO2L9RR+AJuBZQR1HpnkI56Ds7ri29s/gerZQgFDJADrSwVDX7tF9Wott?=
 =?us-ascii?Q?hzV95nzRdFFh5/gwtmZ7E7m9ON0nTIAqz9HBYSCN8dafY/D9EaPQz4PdPhDE?=
 =?us-ascii?Q?xbKbrdwBrlCX68hVWjCt7WzXLxZn+nCgFC1ubPCaR1EMP2Qw1Wk5ypKDMFkT?=
 =?us-ascii?Q?Blrb0kDc0Td1b/5yeOnP9yl8CpiB1eelqqiwqeZchkIf+LGAf/+pZX/gvBC1?=
 =?us-ascii?Q?cL/B8cSLvjk7Nf9VdXIsgHawn97lMzDOyqHx7UtyyNmkV4psY5a+RX0mh79B?=
 =?us-ascii?Q?7mdnzj+SbI5ZO3PD8/BBlOx7nfJmGC2WQPqpCnbdNEt5hG/p9JY1iPO/+EkF?=
 =?us-ascii?Q?dky5zY4iGPFsy3d6olPo6m+6f087anEMVXvCaYG+4egKNUowlOBIE5E2oVkl?=
 =?us-ascii?Q?ak2ItLIuNnHzTMRlEunHHzUXSwSTfJY6XZdb8jsJER1MTrKy+2D5CO+wc+8P?=
 =?us-ascii?Q?61GWQ9dnkAPvjAzn4JAkbuYBN7/Cmr1zZtHi5gOM+k+KZsUI2c/v4R08veO+?=
 =?us-ascii?Q?Y/K9fDYDOWUOpdbQvXtDGEDmfgyu4J1LcrbrAWOerWE9h2dxL3+qIelbJ5dH?=
 =?us-ascii?Q?wFp7Y6DJ9LWYK8vz+e1RZbXHpYQerPs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f78b5e-3924-431f-3506-08da184b9067
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:03:25.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRPOCEyZokZ+k1UuR6bCfa9Y6l8a9dqFahNRKhr0C9AWU17G1SRnJlmefx6Fmvbns1KT3F5BGwxTbIGzz/fvgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

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


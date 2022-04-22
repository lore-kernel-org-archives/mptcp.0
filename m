Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CE23CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2v/MNsNuzkVYIEoz5eADDNxkPOm1I9eKIGut1dkIxvs=;
	b=DVqw1uggu3qA05T+vpuIzvy95+iz4w8N6BgHwh6QMCW8jXNGbiOMlry5SKMax/s3GkPhDu
	NZLU9y8+RZK+JDIbfcDIu0w8Fgm5RZS6PIC3TixwITw1+LE8W7IjnAEKOH2TaJvLHBhY1q
	Oo009da95PKg3Jb9paM3wcw4d1Ed8Gw=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-LuZF-p7TNbyQXseGcQ4pmw-1; Fri, 22 Apr 2022 09:42:55 +0200
X-MC-Unique: LuZF-p7TNbyQXseGcQ4pmw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GufyAC2FKqbJ7EC5DVO2KrJff+pJshxVTk1sA8KW+k9jg0H/b/wgYLem7RU1DOB9lx85oreHVo83+cgadpmftAwBwq4KoSxwi7iLqz78lpglT/fW0knix1CpHhxEJtgDsB2V7igCpUVodkgtNMVQy47Mxpu+oYo3sFGUxsjqJkbyZW4RS1GIf8kA2SrsMTfhxdfDjtHgpLyKP6b6oIe08rLt9Tj4Du7VKDaLqADWzj8RN3WiJtv/VFmP0Sixz0C8aZhRZ/Do75GCYQbK40ovnR5gCv1nHqS+g3o9RyUsKE68EE/fcOxpPvHa43Ia1h2zEzREBN3p9Dd02FyvM64zLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmGNSSj/xLPzQ8uC52/s563mSFa/9dt+8/cqvLnx7CE=;
 b=W+CAv9gN9C2kR4D+BcX4JIPNj2oB6tZzLOSjbqo9UMzNVuqdxgc2BNt6RzlK4q2CwLvTElP4p5Zrl9RKHDg1Foi/2Q7hx9wYXca+gIlG79KgInHVambNJUa5hmUsW+loWHOsnAEeU4baPZpqmvVf1uavfOnL88NbB0oCVIMVU7A64qxmGPKcm9BVAKc2tAdyjBIDCvXlyWhdYK5fzLQ7utcaxWA54ubHqk4DcMdkvzdd+R2PjR/IkIDz7sSyzDbM7RvgtZdIlgtvKBaywY4QLEZ3x4KnNLKJuuukk/oDH3t/UFW8BW3xCUhXPYqJW4eUaksEKHqk0ohYnM2/UK2KLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 07:42:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:42:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 1/8] mptcp: add struct mptcp_sched_ops
Date: Fri, 22 Apr 2022 15:42:49 +0800
Message-ID: <c752c8d536c9409fdd9bc9c237110223306d9624.1650613135.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613134.git.geliang.tang@suse.com>
References: <cover.1650613134.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7d54593-29d0-48b2-a0df-08da2433b5fe
X-MS-TrafficTypeDiagnostic: AM8PR04MB7251:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB7251119443CCA1AC9E0EF3A3F8F79@AM8PR04MB7251.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3cMjnBl4ZdmGcOAgzruJiMcW3uwAN8YC8+jercbX4wUPd5odYctJzHMuC77feHZVzRIvLP+R7pD8UlzZZdlVw6o78GRzIyv2SA5hvOv0XuXl3v3fOvpawbbjLn3XVoBFUleDduG0bIG0JLXA8spFW7oRXLeB0rk4Q3n48WcpR2u4juuFzR/i4mbCsf5+jqM0hKQYEJzvKUTGE8NnTK+b1Oy8EKnWUYpSJhroPhbpZZ3lbPHJfhxfNrbFc+/PoJGBVpz+LHOmXXu8sQMODreq6vgvzy9cW85BnKUdjcBGp4mEPye3et9gnb0aBn93g6Ty4bmW0H/98nS1QIZQ45Fp1sEMvsuWaKW8FOItmf4sqTKxPPOmGjGpV9d6Bt6ZBhbkWDCq/NyrSlzvImHtjRoXBu61R52UGjgnECZGOefNLVLQtxvUM6XCDxOgAIAZ22lrUL15lylXNwdCrRhlhd8WUon/XltPDtUuyWhXGO1wBhIxk4bWPdTUQT28yBJo9wCZjMj63qt06oSTUmIJq1PPJKDq9e/0Dn5ROO60Gupkbw9DMvc3d0xdY5ZWG2BlHUY7ohEPnKewD4Uge44njoC6hmmwVSkR2+SRTw3F/m09IlZ8W2vtepES5IZ3FhkfjNleYWXjGjV7aVPW8WLlk71db0btBD3HgaSo9bgLOPEk4G97fK8S7kfG8c9Yrev0OYfv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(86362001)(6512007)(6666004)(2616005)(6486002)(6506007)(508600001)(38100700002)(66946007)(26005)(107886003)(186003)(66556008)(66476007)(83380400001)(2906002)(36756003)(5660300002)(8676002)(4326008)(44832011)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o8Nub0B4DtJaOCnsATlwuGsNNyI91zwbS1pY73e0odzaUCluz2zGvhNrq9+H?=
 =?us-ascii?Q?llKIX0kbRe1XkAZQ4uFbT1dulQER+qTyvcbg3jQj8TrrxoYjJtvavT0PXfbe?=
 =?us-ascii?Q?bzSv4ZSzlSuiKNwPXCTmjYRsxXCqN3w8WEakQADyWKghinREbHesOPrS08AA?=
 =?us-ascii?Q?rYfk7w7klv5XTQ+PtPdKjiZXblFFqr1YB4PfSk5qT2Vgm77mstEU9H0hFz4p?=
 =?us-ascii?Q?PfoCJTXeCotk1etVTMXzP1zvpg9hhcuanWoc09mQoD7dn+PR+iQM/zJt7ATr?=
 =?us-ascii?Q?sLaWnHjNlRBxdr+ra5jsffJcAAKBqXc8FSqtvTVhsFC/CSECM8hIL9oBD37E?=
 =?us-ascii?Q?UJWe61bOew9HyK3yiXklJerwEMM8GpbcqjFONJ2sQRtRO3eIL1Xux/zea5tR?=
 =?us-ascii?Q?ZvpNlQir+I9pyGl2AXouLRBGefk2qyWJU5MkKUV/fmEahmvCo2V0S4H4CEzR?=
 =?us-ascii?Q?X9/LjJ1GgdVcCVOax6WtNMXBMZXJxZaZIVMKkQqjNehD2iUsapfOuhxGh111?=
 =?us-ascii?Q?ECZrVUqpAnTXu609QRJQDapfo9gpSLrZt6oYydmStB0md8uYNyv5kjcM+5SY?=
 =?us-ascii?Q?yQrz1+kOnRVvN9APTGPQTtUbfMacky/LpReNztYUcTvDzaQ2/PUZqQ4gfcwi?=
 =?us-ascii?Q?c79kFjgC1VcqbWBR+IEJ+tEnGork5rqpQO5fMByzLKYr1hz/9TraUv8CHIGm?=
 =?us-ascii?Q?5HcNAtd6hxB8tIinXLi0CKfue0uYSEwowouRVM3n3/ESuDgmP8cgh6LscwRl?=
 =?us-ascii?Q?qn/5tNVb5iLpTDXx0Lw3TBTkjua46laeLpSxO0kf7dRRDuMZr0UO1BXUp2IC?=
 =?us-ascii?Q?ikRuLVeZ7Kh0neyfV51CAYUmFANC+UKmmppraAxDBvBfAH9ZNr+qM1KYENEH?=
 =?us-ascii?Q?azhmoG+Vq5wZ+dqKuM5Q7HlQjYu3S/wp4vPrAx0vNTwU8kngOcKI9VvtGZx2?=
 =?us-ascii?Q?opsnQwNQ5+g3yxWn+Ld5sTf76NBFl/GNqXndIZ6jHg7vkuoY2uU8GIoewntd?=
 =?us-ascii?Q?1O6a4R3zuCB06YBGGbFy3xrW48lISVpStpwV8q+ECBtZpgdnkJ2Tk/Ljl4l+?=
 =?us-ascii?Q?qX1R+tlTEHd+c67iYndSYgfBNq6ODohaJaNfgoKY08zKB/RBH5215eiEACYe?=
 =?us-ascii?Q?qIS5YWg5tghz8sRar/2Xio3jD9Umq6xgR494HXIyM+wMxiNJeMpXI/rMdiDy?=
 =?us-ascii?Q?hdB4EOotKG5kPUHL68KMZD1QiTsnLOsPPhTLQTanO56Hl+xtIXA1LavhnK90?=
 =?us-ascii?Q?uFUYWpdk8YVzVjHWg9a05HbDc6bSx5lSIKXGWPAersyQ4hP8wpn/BHCZM7xH?=
 =?us-ascii?Q?ueVYBioTfXuplhtJFlKE5JsKawEeua7UjPD3ZEkSI/fpZixR2RaZ1uUFjTmf?=
 =?us-ascii?Q?Smxc9AsOamhjXM7leLfDVu3fAl0wTaUTxVg2WJKhcOi6nGpRfbvkgyN9VJ2l?=
 =?us-ascii?Q?tSe5Oqh0WPhP8VSxmxmiFLGwPc8naJM7qjihkoUmJ0lXdGJ9ByVp1MZBCSNg?=
 =?us-ascii?Q?ZSzRXiRKCWixkKVpjq7XhpLUfKQwS/FaLyJ3HyexvoGMN4KDl0n3HhQTpVX5?=
 =?us-ascii?Q?tfIb4V+yaNxXKOkIxaSqt1rmkxdftKqpuwgOhAgKyX1kXbmeDq+/+lEKXv0H?=
 =?us-ascii?Q?67ziPxCWAd7QqplDECdrbeOCGSXd20kJLK7irbKNrs9alJIE25gYI17TvGT7?=
 =?us-ascii?Q?QPWsfsdOE5k9bFaVN+UIRrl/JPzlPJAL1HF5MiYgasz266Xm9+IBzJ3rF97g?=
 =?us-ascii?Q?FL53KCMZqIuF8mCb1WY+cUK3qWxHT+Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d54593-29d0-48b2-a0df-08da2433b5fe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:42:54.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +STuGXDB5Wc6EXXdIKWIhkeRY4sJ2td0z4XXpAPzBTo81D5zye8Qw49+WloPmIAwGEtqOuq2C3KZB6yCXVqLHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251

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
index 877077b53200..967a3180e657 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -95,6 +95,25 @@ struct mptcp_out_options {
 #endif
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
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
index 4004347db47e..702b86e8ecb0 100644
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
index f542aeaa5b09..18f8739bbf9c 100644
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
index b5a43b108982..de20fbdb6d98 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -6,6 +6,24 @@
=20
 #include "bpf_tcp_helpers.h"
=20
+#define MPTCP_SCHED_NAME_MAX 16
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


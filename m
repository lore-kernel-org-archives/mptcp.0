Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0A7A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHrzFntM0+c/8yNSYBV0cD0sRMl56pl4BQzzNUH0gfg=;
	b=HH0yiVBDmxI+LFBkyHxm5ZO4gZv3dsTjt8UqUC+pev681Ar/p0CY2/SIgDe4AsvpL/fxA0
	8U74zp4qo5ohOJMEf0NWOCD93pD3uGeZsnZPHQU8wov7OSu2QNgISFRjuZi4btLlUSaXRF
	Wm37w/+G/kccPQrl/8M/iRyLMitm31Q=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-KFakr63YNSyW4N1rnfYVFQ-1; Thu, 21 Apr 2022 08:22:25 +0200
X-MC-Unique: KFakr63YNSyW4N1rnfYVFQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUA+2+jVMdBb0yOKIBrYH3Q+Zm1RZr0AXtwLwk1+jCnoiLynQuzAHIh95vo8xX1T2hBQmpHHj/e+hRL5PBkvvkPXUQAXVOO7hs1uOcPgb9k36mnDpEKcDtJzV8DPviRsVCJIHCAztu0oFQ65SmyuzIvIqb35X1FW7FSVasJYBlkrH4cJ+y2xxHLOqcK1jC4L5X87zNd9zNKTVxjgDcCwg0NXMO9mSQ2g7N87oQDySPYlz2RjkXeyJ42vS3jDQEha07xGJNzN2WbsJPpe9gbKtSYubsLPNY807kYhyw1Khi45x0wb5iwpXpHqbR9BY7nETuojIAkDjc3HQxdEXNRfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Gf08l9MjetOVwS61r6WozOlxzEb5LfKg7QQcwLdVeg=;
 b=aj53xfEbRyJQmLPDZynwp49B2fUVRtYm8REQ2p9KqOhMC0ujsZdLx13lTg4xNItiA4KE6s3eNZpyxZsSVtnAoU0Jdwlel+VumeEm2PQTKTJ/nw2EV2U0YfstzheWaM6N7/SrM/zAQaHWDVoT/hAOhzTfDAP0bfEqL2ogDkQ6TBU7b0Vpp7+6O2n6QagRC7M8vaE9iy1g+5Bpg8hlCVtpUitMNDES2sPo32LCvyrG+QjdkOMvemfz7L1SKe5Vovf/CPEZ/sWIGtU3lA1mkWYwkvEX/pfEjT1ayzOYDASEn93du9KKqWa7fNAJSPXmQgMAUJwqBdEtn6JhczJmh/aZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:22:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:22:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 1/9] mptcp: add struct mptcp_sched_ops
Date: Thu, 21 Apr 2022 14:22:19 +0800
Message-ID: <338fc9842abf8a626481f84358ab5d5190b87082.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650521788.git.geliang.tang@suse.com>
References: <cover.1650521788.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a5db9fc-c249-470a-3a8d-08da235f4c1a
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB81001DBB3518500ECC7D0AF5F8F49@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Me6rPhnlPJ5TWKoxxvbEjVS+mTC12GKHsqUxjUZnfM6ThU2hUTl+GzS+IMSMPLocZinuhZELZyAV2tJ2U3LkzwVnhqNrawrkMrDY5XFouHTDRH/A0wa1u3rRJUZcc+XECQXQ23JYXP4m/aZ1Rz6F8ePISijYpAbd3SkwZDTpTDjTwczFdJmFLRzEmdhSYWfI5vquDEcXrtwcZcuIxnUJMNR+fQBrk/3Kob9lkqceAL+NmimJEzyRVhMIINRxqi6cf8ehv2mOApMKsNN/mAl5WPsmEqeF58t/tqqzQV11zJEG5KTJ2SphsoD0vXtKeShdptUQpaN1qe95SIbOT0L2Ya+mJbTL7abuZFA8boNy8SvbOuOOV/cj9h17B75YjgW+V/481FvKCRwZk7Cv+PE07aOYoOvN6GY49mGxAPomWzITw3oAFokepONqg2kbPaK/ZB9rmWwUmfrg/ys+XHGj8NTQOEinwVncmlsXNIWAVVIgFwlqC1NyEZqEBIDEK/6+2SnDadYPnHZNvKr1DWNSBEWnnbfxOvvMcLOkJipn/nYKCP9N+cWEkHKtEP71VcqcoJjxEwB/Z9RahQk/yEYmslRpJqMzddmsIZy7epdGlb7boijskWYktt+WxjoEk8OzhSmVQ41WSn1ad0ESAdwd3PPO8kB8asHG37MHG7O8Ti9hYgwZoKLDiHaGrPJNUIEM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2616005)(86362001)(6512007)(26005)(316002)(6916009)(508600001)(6506007)(6486002)(38100700002)(66946007)(66556008)(107886003)(186003)(83380400001)(66476007)(36756003)(2906002)(4326008)(5660300002)(8936002)(44832011)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6HliQ15Z5ZC33Ll/BJz2tBFdFH8NjdHQBC6RsWihJJw8B6nWE6YB8i2sEdOd?=
 =?us-ascii?Q?biLLjSoNW6lGiFvWpUOeakxrh5wl2bj7YWWx2Xfd75Wlyb1Gkz2eG0KkAY2W?=
 =?us-ascii?Q?aN4WLRk0z/qxPV4PpxSj4We+Og6HRWbrMLsd9GCp5lUEjtibAtmNVecfAXqt?=
 =?us-ascii?Q?59PU8bt9tikvTMy9Qe4zvzYtvgT9V7Ugp0LkAgLMgnHNbGr2ZBRkpQ1iWNo5?=
 =?us-ascii?Q?C0TRxfAxixABVktOIE343iTpLHxmfJjEjd+uV7R6mV5lt5H1s4uIxVWjWrmk?=
 =?us-ascii?Q?QrOmtIXFgV+Tps/J2hBmvP26oLkCbvcHN2cM6CD86Kzftmja8i/SZPmR1oXu?=
 =?us-ascii?Q?EP3A8j9ima2S/3A+aTfS61iz/xZQLjTIuOQi/biMBGZFvxpF+gw0nYNm67w0?=
 =?us-ascii?Q?xgw5ctUhbB8qrBgLbe76QyHMHYTZeCmrxwKorZxltDGgJHWolZtgPF4WFrpi?=
 =?us-ascii?Q?l9rsQv9Ay7ldwy+T2OHxNhyPRBfCPWf4O92ybhsWbccJq5/iLJPnxwT0eT/D?=
 =?us-ascii?Q?ZW8ErnC00O30Q6BRIvqVCrrigsO57msmBnNJvp2SLPeFu0xSN1lIdaWhKOLX?=
 =?us-ascii?Q?9ReqGxpesqV+D108fDYbEzQPJMU5TlkFrazGgOwv0Unqlz05gRJUNRtXkfhE?=
 =?us-ascii?Q?B+BdjDQc0iULpBnXsFjkEUbDXdLnIpJbjksimsfdUO0RZbJvPz8DTnY7Qd5Z?=
 =?us-ascii?Q?1YxASnfEDKg24lPFV+Y1lDjZ8KD06CSFZ9krU/gOeuFtRr4SscxEz2Q6Rmjz?=
 =?us-ascii?Q?n5USGBtFZeE1z42RDQuGcTvJQsGh8TCNju89MYJB+vg5Swl1o79+by10nG6K?=
 =?us-ascii?Q?g4pJXeNNtAaRbIPbZ/lFHPss8obINRx0D0Zi1LvEwHFxEA8bT1NcF1PphvR1?=
 =?us-ascii?Q?qYXaw2QCYYTuFs48Ty01PDBVrOZfaNXdBwOKAuznbTxTPDUlEplIbYfO8Y/M?=
 =?us-ascii?Q?P+vimMi867m+3cLLyrW9LyawtAPyroqQ8xyd4SEo7AYNw606iPn9cBRQFi1V?=
 =?us-ascii?Q?g0USShxy+XD+0kkBscVjRe36FZjTunUJ6nZNVciQ+yAUO1PkSOf7VAIN3VcP?=
 =?us-ascii?Q?Y+4nMfl/ogPWIPUnA0b4xyHoDOgoZ128TOvuj7Zv8xKfOZNzuMavb4OgyKS9?=
 =?us-ascii?Q?Q8BVHfSJ4uSHjNQeoRh6795tRhwjha7hAkxUkB6L3d93cRvoCLkZdNVc7K5F?=
 =?us-ascii?Q?wc7Pcoh2hzMMskItFD6Ni+EOS6XNk/PEV9geVEFAviy7jgAcLH0C2PCbokbj?=
 =?us-ascii?Q?xzLGLPg9iIO9K/RWKcA29bcWnwu4RytpsOzRXMf/gdWlWRDjYx67cRpa6boi?=
 =?us-ascii?Q?rhu3IsIs39/j7ohV/sfUFo/X4EovMpG6QFy+V79RkGqqrLdC4snE5B6nUlu5?=
 =?us-ascii?Q?lfP3EGrN7QECURKzAYvNZGvirkR+cIvYT84vTYz2NtlMokEDUcl0PcSwsMiN?=
 =?us-ascii?Q?ECSdQF7lumHKjJNlTbZsCwtGRXgb8aFdhC0vKZ7OxAy/BhjVWB/S61Kfpn5I?=
 =?us-ascii?Q?9q9bDlCN9IQkAgUMzGLelV2wqxz06N0f51xCvp6mvYI2EysSL50Z5wunb+T1?=
 =?us-ascii?Q?Y31mEKV/G+95sF9XuISgyA1OgkWWziMP1TQ6G5ct2N9Q5E7t47W6ZqluuwaL?=
 =?us-ascii?Q?7tdO0ZCi2BRXIp1iLxb68drD2r2zSCfB72T5ePYPNJlYICvFTz+REMP/+Ast?=
 =?us-ascii?Q?d4GZtf5Bq7x/so7tog2PfIayTiAiDxF1WL+hM+gtoHwk01FGg5Xp39VLE/UP?=
 =?us-ascii?Q?OnW/Ir3k497YfIoXPWTH7hNNBxXGyPo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5db9fc-c249-470a-3a8d-08da235f4c1a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:22:23.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 435rk7BA1tvoIoKjuERz6ZsRUR+phlnoISOJC0vjyVQ8OuLA5pmX4NYYA2sud1Z1vrp6wa7JPRaRGElBpfanRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init, release and
get_subflow.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           | 13 +++++
 net/mptcp/Makefile                            |  2 +-
 net/mptcp/protocol.h                          |  3 +
 net/mptcp/sched.c                             | 56 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 12 ++++
 5 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/sched.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 877077b53200..469a93da32a2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -95,6 +95,19 @@ struct mptcp_out_options {
 #endif
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	struct sock *(*get_subflow)(struct mptcp_sock *msk, bool reinject);
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
index b5a43b108982..8587f951ccfe 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -6,6 +6,18 @@
=20
 #include "bpf_tcp_helpers.h"
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	struct sock *(*get_subflow)(struct mptcp_sock *msk, bool reinject);
+	void *owner;
+};
+
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
--=20
2.34.1


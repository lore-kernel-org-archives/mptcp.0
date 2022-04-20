Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B187A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ovcAqFfzFg8bT/XRItLC5GaW6XmeOYCw+8KfszpueU=;
	b=GSPADH49erY2b9HQVQrWIp60ym3HbUzpM+3isq8bdHjvpUQ/AocczHlgOXGrRnNcC0UFBT
	RqBVqV/os5Jbugwrxv7SPl3G/0nMY3tSvP7HuGzhWxMDXwfKQfmUnOniOoP5Q87nx216Am
	OTHGphu4etA8sw/th7PT+Fi8SWCa/bo=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-ZYe91Ox9P_ipYBo7F5LVqQ-1; Wed, 20 Apr 2022 06:57:05 +0200
X-MC-Unique: ZYe91Ox9P_ipYBo7F5LVqQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpdK6zAwzSq8UUoPrTVGKmkC2HN9IBU0p2VCfnf7FJos8uNYVl1YC4arH/vs9ByWUhR2W5Rxq03ehKWhAh0a/MCGXnYPo3wxoApynIPe0iYOFUjj2fJJKpjNLeDvz/8ewKP3yLCQwicYkLqbmTyvVKwcPY8CHO1BizPKEsH43wMXlvFUTraBpFCNrRiq1IOk1ozPFs4LCej5e0IZ9wKbzvET/SUuFtSp0XtOkVRSbwe0NSeabvYjZN3yaUSOC2CMo+qiTqQIFCIxubNmryFB4HK6fPGRcbDkN0G/v29YZ4O+sEi4G/XLaU5hBObntNhr8TPdAyqXz+H7zNmSUBd7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO3zp8ruI4Zj7gYD88xUvfV83/jIC1OiEnSUq/Fvryo=;
 b=jJ/KD+2baYSC0RjcU8vKj4QbmMFdM7ymXdiInTEr6YyRMkkvWf/7viFdReF9ZHsnfPEyC9ovQPF+Ov2q36pInz/UFqxZNSHIbksYltMCR7fDPSShqv0gs73AGTWzYkgDDa+ubYfJe1isqEiqf/PNQQUsVBpAJ/kXcLT9DIJ4A/G5MtgAlp3vSMeVW/Kbxu7laHuyybYNqx9l8CW/e3LOCWJSg42yUUQ/Ye/ep2+q8bRmWWIK1G1UYGPBc3pKZ9mpffIJDtO/H4y0mSG5LhL085kr6odcQYboN4BQiAuE96xAati1V4XW0sHNV5AHHkRtK++ZvG5SgiAUNtCRAxE/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:57:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:57:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 01/10] mptcp: add struct mptcp_sched_ops
Date: Wed, 20 Apr 2022 12:57:00 +0800
Message-ID: <9112f71e4901f8dd719c515b26581c8d747fab45.1650430388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ef239c5-3480-44e9-0b81-08da228a36b5
X-MS-TrafficTypeDiagnostic: AM6PR04MB5752:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5752AF1679408E5DD209F5E5F8F59@AM6PR04MB5752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2RxxQvANsykPL42cSY90uKvCrJ6S8O+8cthA87Qr4tJZh6x/4UkMOEcICqbHieNuZOfwdznkOs6srBUTSbbaBztUfvY8cViEbRlwyGL/WS7Ys4jXwq5O2l+hOs65Z+/deHssaL2m0s4Xn3XWGRnR4q+O068mRh6fV/niwavmB5Nzh+bqWEjkYsZI6GE6j7PzoFjj13vh3pgldU0DC37mFtbrkHYtXjx5MeTa9ap4BJ7DvOIHb5i0/ljVxown1nd46Lpn2uDKIWznyRFEK23+w1UJ37u7dijAl3QYWaSq2t0TKIOuZJqbmocFzn7tj/GnoQMvlKRUw2GImGsY9dr+YaaAhlCdNLCCaqg69XznZHUS60ttIB3K3/sOhoDTPNK79zW+9gMbWhsvrDXDaMOvsW+WnSh/+7S/L0eD3qQek1AI0VWMgNMWDHQOvaoTtxFlxPVt2QkvC7j6x5HaS+ihFdI367XBhWT14vg3EXuGz0TM22iVIRqpYNFWchf1PYlAFozkSTM9oAW/4B/5InKIXqBTZCnqfUW2Bkxn9OSPfPA0wIkL1Frm5jPY05zSzLo+FJSoAg2NOPujkyxTpHzSIRYobtLKLLvgVhpoupS68F3j3h1qwhUZZ8SZWY30BMDKQKEhXCrRtSdEKj9ywPW1AZ4SXbmYEv5LAeNv3OjgchhdNzzFAEQb3Ck2d4Iieo8N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(508600001)(36756003)(316002)(6916009)(6486002)(66946007)(4326008)(2906002)(8936002)(6666004)(8676002)(86362001)(6506007)(44832011)(107886003)(6512007)(66556008)(66476007)(5660300002)(186003)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIvasRL1imw3r/LR5YfxqgX/4cX+zzVMCPCX73+EyxpBX5GJkADKeUxJDh1H?=
 =?us-ascii?Q?viC11tL0t/l4yaYOjTEEpB9ql2LhNP05Gb2dTuUY9TlllH4SdAJxnAYqkS+D?=
 =?us-ascii?Q?kUYBvw+EJOxdwTNy/Yyd/joyfVzOVxAqK0JynRHbM6BnwVL0PH9UMogf9hhQ?=
 =?us-ascii?Q?NR/hxq/V6RqkXPAf55Yo2PLxoUyBIzE5Vpbbhmuu3fzWZUkU5bnQyTwfVOgx?=
 =?us-ascii?Q?L2Tnpot2XpFdbjBmSPzF/YckV5FTYi5jKxOj7rSg6ztS7aXUHbrTnK5lZ/SK?=
 =?us-ascii?Q?ZD8Vm2tSPzPVXOVQ55adO1bE3PptV24P6Wx6SyVuIvYxjXY077sNXcBqq52H?=
 =?us-ascii?Q?02oCtbtCZ1bbqV8+S15q+nmRZ/VdYCwMWDtAv6ov+2N9AWYftaqieWCbHePQ?=
 =?us-ascii?Q?L7/DJAJOB3oU7JPHIREQbYiRSbbQ6+d+6fAOcq7i1vnBxfXpqfeOyZMIYe6e?=
 =?us-ascii?Q?d46ueQC4YpVE+SFW4yHtDC5Pk3qkfApSo2y8sUeJuiMXQreZAiu8iV9Y8Fmz?=
 =?us-ascii?Q?UP0+20JUQg24aYJLpVMJ5NAjOPvKQH2ImLCo/UM0z+b4TWETDQpQ4m+t/C9F?=
 =?us-ascii?Q?lH1uVP5jwx6jsNzkUkarCnk+lEyNkrBAFkJ0PANaja+KAZkqMuBz9zmGDzB/?=
 =?us-ascii?Q?NtlRysIKWwiC82dJlqkSuYTu5waOOpIKSkJxsZyUgDz1NyS4evo3Y+3AnKxk?=
 =?us-ascii?Q?CeF9IM7pQK1GVq+5jPckd0FbkEmT0A/iPHbmFJr9Bm/RyNTUERepO5UlWP7r?=
 =?us-ascii?Q?wGd029fcy1Tc2raQy4DpcIRXEFNWrYrY24l2OWFA0FxKvsDN4bTbUwMgn6bx?=
 =?us-ascii?Q?1iV6UB6YbGNFfaCNXfBFtzS1bAqzv98SN1D0sCHHSdxVMJjoDPergKGQNY/s?=
 =?us-ascii?Q?1HQEhauOXyfPmM1ZRm8MSFB57Sg2UU45FKKSqjgjJwWJ4ilGCUZRAlk8+i6B?=
 =?us-ascii?Q?DxUTN7kR3RLwPvd4wNEillhd4KGcMq/4tRP4SrrO3ytVRcBDpO/ZDYBr1O8p?=
 =?us-ascii?Q?CVpjtEgTV5rSzY/uyRFTYkBtm/3gPUhorW5/bz97TizSXTZOpr73OkVpXj+B?=
 =?us-ascii?Q?1+Nn3/QyeQzeaHWOUrd3d79OTy3E+tqWpprOKcmcLFHf4mvoZ8wnvLR7+Z5r?=
 =?us-ascii?Q?dwKeojJHH2V3MHO7kHXyh5AT1FuHxgKUfvZET50qyhDe705vF+G07yj3s2pg?=
 =?us-ascii?Q?tkqUwjeHxWa5e3AIlRSrm9rvMAXm1wVw5UUcjvE9u3QwRMi9nVYtkEL9FymK?=
 =?us-ascii?Q?dvGxx210E1fEsUNCp99sf78lAiI8swfs7JvPIke10xL8D+Ow87ml6AKGES9O?=
 =?us-ascii?Q?le5liZqBYkQ04zaizVCkM/ieceJdD533IIvU/druol0Wl3MEOOQ+t7EUVPwN?=
 =?us-ascii?Q?3Szfald5tQEXl5rs6laVyThzetMiJUSMkrro41FXoFfR1ZwK00GafgvrWqO4?=
 =?us-ascii?Q?iHkBu/TX73C/Oxq+R535HlfTEwx+T3mKNynG9zyEC3fxdMog6qgEjo0//WYH?=
 =?us-ascii?Q?m3aLmdRyIHrZFLTibibB5rCkMSvDu8AdZV6zrKPLWaD7cD73bkib4aiU3nCC?=
 =?us-ascii?Q?dmgKapE+PI+uFwqAUUbCgF93EdNudtxuECOFXvmUe/ETgCFQwt10WdkgLr5I?=
 =?us-ascii?Q?HCp2S89uA1hJcHw4xk2/wa+q5vwoA3C3BII1Tjw/U4RTvFs4d1uu1B0ylGW7?=
 =?us-ascii?Q?Ee2rxF0ZTaUym+4h+o+/DAOYTUhh+jJzcD/eST06hhV8NRQhAqWmGi4/Z2cg?=
 =?us-ascii?Q?OJYI7ZZ41IWDYD4D9w1pH1txCqW+6h0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef239c5-3480-44e9-0b81-08da228a36b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:57:04.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42T6T5pFht0ipN6WB6HGQ7ags1BIssq0jfo3TwFUOOLB2DBOFtIfY9iakEj4AcjhMF9yVuJSmzHFf7HKtXoD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752

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
index b5a43b108982..8d4e4f08d327 100644
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
+	struct sock *(*get_subflow)(struct mptcp_sock *msk, bool retrans);
+	void *owner;
+};
+
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
--=20
2.34.1


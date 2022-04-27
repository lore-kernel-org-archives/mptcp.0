Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBBC621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651024608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ1EoAt/ZeVfyTsL+JuePBVq/k6t0m2m2CH6eYEln1U=;
	b=RMJQIW2NHXZymMz+PB+CF/TdzUfOhgP4zF8JYiIPemUDkExD2pC0u5tCkBvSNHG2aJmXJh
	hJG2Qy5lJE+ijYf6rU+MzZT/xsL3zVQmC06bm6KXr8fgcKmqfpB6Ee8WUQWuzGvb92CeGp
	vV0iezyyqwzK/cO1Ov+tYN+TQHxgPpc=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-PsYqxzeCMYeuR3-ClbkeMw-1; Wed, 27 Apr 2022 03:56:47 +0200
X-MC-Unique: PsYqxzeCMYeuR3-ClbkeMw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdYzCwLIiuTIirDYrckjs4VZ2+ESV9g57Xb6ljhqDFhJxoSUgwXWVeJxWEfTDmlmOXSfjhi5ftshikbp/Rr2G0KRVFBzgqkL9UtOL+JcmqIU9zyiSppkkbFzARPkp8inwxB2j1Xrx1TmrPT7hDDEuNERI1MLZgmI7WdPyfWamLnubsizyWU/1VmHFD/0AkL+VgO2T1CSMFag+qmojtXY2NgmV4v/cQ9UOY81C3/9bF5VEfcMOWVusB0Dv1k/AlrNxDzMmNR3azEFG6My47hDuWrV2fxz8NuPtOOLqi2S3XMRuYcVwFeK8Z9aoyhpXHaB4HWa+6M1CK/klxYVYnZLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEjn6iEVZ+w/+dyplNuWhzUfwIx1yEX9TzuaJzMTzqU=;
 b=oGjWx0tJ+J8Wtr0qhTqjsu0Z1+v5/WcxkzlvgxELtr8hFhQOyEUIUaV1fIG3rIicgLLD0inU2lOYIWqly8cV25ufmE1rnI0nI4l10YJS5Fz9wHFC8YYNaMhcbqNeVkZwYviK3ao34ttyX7iYtsxbjQtE3O4hd2D9ylB6IeK7VXE8cbqQx80FzDlGRpK3m34OiG9E4VlNN5zmyb4LOtMZ85+yBtSQwkSCyhbb6DkIiHN2vQH7pZEjK3jULwUpVf+0otVuL12flW2qoE7rgAJpCCUuYFCBCE+fX7HoktUXufXPleri5nsph0YCKoIGnEPKH8k/7KKq0wOaeqW9LHmORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:56:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:56:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 1/8] mptcp: add struct mptcp_sched_ops
Date: Wed, 27 Apr 2022 09:56:48 +0800
Message-ID: <b354381e5cf2f4a94dc9bc5cb9aef11e5764c6ac.1651024344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651024344.git.geliang.tang@suse.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9094a38-f1eb-49b5-c851-08da27f12f24
X-MS-TrafficTypeDiagnostic: PA4PR04MB7661:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB76618B07AB68F1206CDD740BF8FA9@PA4PR04MB7661.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CKg7VFCmLQ1NJ+U+Yq5pIUJ3qRLg+Lns+MuXuPbKnUQPF4LmQo7hlTbOEc/DU9mf3iKySZfb1m+94OfCQfTt+KKTPyjBPqWUuh4ADftcXvr+cD+wrlPG4tyeBcNUtfe4WFgTpTHBg83ngKif73ftQGOfdV5waTrza2QWy2l77qAl07Xc6bchNKjxR1ZVFxHpBvhdMNzpGUAfbOi51GInxHlU8PYGWppB9lzAmLyi3gtl+BNkof5yVucdfRyqeKda7MFYs3V6x+cdtudDs8la5jjQF8zaQTR7gkJgumTQjxP/zta5i0RnEV1qfzz+cOS63hGd3SHtncPu2JlEloVND0SEXr8UYpTPcVxFmNmFVbptL54LKRGSFYoESKdX09+rTiZwgHaVX5cwUV4HiIKEJthEa0A6AV0c88otlEY57VUzl5NokwhQtR+Mo0OXFkQMdRe/8iLZUzCQQv6gJcZ6/FEfz2ZgHWEDqr/O1MOLKC7jVXqv8BhW9ek4NsE8MvDoXdqS/rclgVZ3l2g3VWw2Hez83fedzdQUhfUVBHVgFbFsEYHscJ7FJfuQQRl2yUhFWy4/yjFU6Eg2jSltO+DYKsU4oX01rr3DyXmEn5g0X480RC6UXFxqWkpwLjxmoBOxX2CDhy0Mb+HUm1kQ3NxggC7cdfXc3VesfBrZ+qVNquiLqfGtgX3D24lDTB3E46bS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(107886003)(5660300002)(6916009)(83380400001)(66476007)(66946007)(44832011)(66556008)(8676002)(316002)(186003)(26005)(2616005)(4326008)(38100700002)(2906002)(6512007)(6506007)(508600001)(6486002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rSxz064MrP6dHxi99eCnZjzXze8Wxv5EUtccbbeBit95+zEEYzcUqXNjRHRl?=
 =?us-ascii?Q?Fpamu9aZL19sWOp+cY7Nc0VeFxl1y4YmZ+MlaU3RinE3jqxeohG9jvRx2SUY?=
 =?us-ascii?Q?ruz4bzKHjSaNrvqq/og+sGX1U/hiY+gV7NNdPFz9ihZM8o4J5LFceycgaLQO?=
 =?us-ascii?Q?iWivj/thvXdKl8pCPUivnvIhcTxR6ChruwkdsOo3sL4sYROczRqzenlxc74v?=
 =?us-ascii?Q?kyB0CjCRIcrfYrqCifja+z3wpYeVTBkgdLLyexc4RThLUyp5XIikQeJbAF+7?=
 =?us-ascii?Q?4URM7nMjIA2rbfjbdskZYua6G+EjSq1UZKs550YJSgLF0DyA9cdFGQWCoWVP?=
 =?us-ascii?Q?tq2c8qWVCSqeNxRJiLfHfp0VgNORmL8jRHErLMDMYwDNqvCqR+Ikh3JvEvhg?=
 =?us-ascii?Q?iffJVaghE44rBGhmiu+L6hYpMx5dcUVDxKOutCFDgHLFw2iNz+Xebr6B/fiP?=
 =?us-ascii?Q?2saM8HQO9N7LpQyek0xngc7rtgvLXqaTTvFFMI842JqNVT63d3UyhMgbmI6N?=
 =?us-ascii?Q?vYfAX63gvynSkLZIwlj12ZW94G4GucMrD7DGx1GHn/3Pjk+sPZPMRe1XS8qt?=
 =?us-ascii?Q?hhr/qG58CXf98GbY1vJ4o0RYj7KZZGiRdIGimmMk6lIqy2T5HF2RvQE/E5Kx?=
 =?us-ascii?Q?Z7mI3RL2nTOgb+Q7ycT8yS1+3OLlu6lWTlGrgBNdpH1AV4WCNBwLTGroOd0I?=
 =?us-ascii?Q?8cXFievgimzXQNrsfYbA6x2aXiK2B7kxHX4zvUIJi+9eJvU/Ud0kDsL19sFg?=
 =?us-ascii?Q?SwEmoEAcrZ7Hnmyeo8YyqfCram48eOd/GpHACY2GW3pQW5+lO5NyIwGUreff?=
 =?us-ascii?Q?Dq1T2o27Pwx+Lp2T4jJqfMt2xmVnfbdU0D8xeTkb/JUF2sUdRRNhbxbdMDJW?=
 =?us-ascii?Q?7JXAuMcYDnSwrxvBuBqFufP5XhtSMCmKQEQn6NzYQZvzhW5w0RqsF6m9C9Xp?=
 =?us-ascii?Q?Q+q2Ac1p9urHu2JSUoevoUyQQ+rhobRbezXU6QCzZeCOfxLTdbC043UhanSz?=
 =?us-ascii?Q?CMuUmE43tI26HuDGCTI1ekfnUD50yV4OmXOomZq+GBs1+FuDhPd3VojCTZmc?=
 =?us-ascii?Q?CeGk0J+2Y9lrbTAFyGUD8xxE/8pR0LLbEqUYlZJO1rf+tjtg2I5uulj0pn9P?=
 =?us-ascii?Q?EKUUVfNam+VbmaChuW67lQ5vrBKBOPbsg0r9tDW1O6ZKba5Ci6Sl/M4QvabB?=
 =?us-ascii?Q?x7IMeS678WV5PCNwhRAZ3RIKr5p0qVX6D1iXHrP3coDuPPxif1PmWF+CxSS9?=
 =?us-ascii?Q?23aEC148c1RJVSlUpWTn/lk6g8pOXndg2mDC5PY1dPK0WaOPJJpDeg/ng45U?=
 =?us-ascii?Q?DULVTKephBNDgTdt1FPwG5Bz37waowIx3d6FDd7vpQf3XA+2fwsNqtJVFPQn?=
 =?us-ascii?Q?njZO59p5vvvXFmamy0oD0GZ4f66R/337FQZ6xpE2zupn9IBQvvJipd1xjk26?=
 =?us-ascii?Q?zoGwjiVFfx27jBviTALYyhwYNaLo+zFj2Yh191tMgd78kLysSS8TG+7oT7j5?=
 =?us-ascii?Q?JvDAnG1TtJ05UdouwA5Jw4JNU/tAu3UBdaURXkaYReu5D4B601cl33jGdjqa?=
 =?us-ascii?Q?gDdZy+3WI+lJzsDwR1G9ltgG/QH4cSrJ+ktzMu48wC8rUhlZSbXwr2I/BwqT?=
 =?us-ascii?Q?ZTQGTno9AUhZia4Gcif9WSHJx+D3TK+PSVay/9UVg/dMltQt+/86oKA9+yy0?=
 =?us-ascii?Q?iRvIZClFP/BMT91I0Lq91KADqiHGR3SLRtR946QcwuC6C8NySHYWg2C45PZt?=
 =?us-ascii?Q?WlYLgwdF02Wgq4IVc/G5qhZq3mo/O5Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9094a38-f1eb-49b5-c851-08da27f12f24
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:56:46.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwgSPO1Iv+Z2s5BqQKmUmlTqGemQqtLOyvwocZtAf0kHDEDTbCjjtuMOZ5JMp2BEPoMhaQZW1cEi7Jf2JdkNfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

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
index 4d761ad530c9..dd4ee7a77567 100644
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


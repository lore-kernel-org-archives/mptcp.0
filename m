Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4AB15B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJGEYCRP66udYnrXucFJzabkuDpZ3mLXMh6LUFChOcQ=;
	b=RaPOMcZIfBPJZyl7JE7NrzDOn0SeKEoWoth2xFb4kFV24UzYcXu8jndKJJZ3y2VhM7VvV3
	YgiumQqEsF/dC9dxkFbjcnrVmE7NvWH2L0zpq3uPj58kWsXbifZMVVoC4RvM1zQoULsKpr
	j0aZs1ZGsgo4UGPTFqGD3j8WxcAy1mo=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-cbcYXTyuNoS2OCeX8eoS8w-1; Wed, 11 May 2022 09:57:16 +0200
X-MC-Unique: cbcYXTyuNoS2OCeX8eoS8w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivveo3DijO3+nfKP/okqtbKWGqs0yFitKNKFyenSHC4UHQXaJGq0AyZ32QpoJwmkwfUN3CmNrHrfEhLA2Oifpnb/mMW2NLzDZFH7IvK/dN2gWV9KMZtvpV+pRfwDZWm/PrEu8Yi7UYonRd4zeHzL+3yJKRfkEk7hYfle6uQaOx8iDpnpuuTHp5uvSnCdYC+fpFLjsOmjjulT92BY1wWFqbeuR69Ezshfh+sxP6Rugln7udrvPC6TN9byXe53NlFbfaXs6SSdMdimRDPOETwUgExtLg2g2OmTrbXfzVxCeUU+FBjihopXWSMqdwe/zBCYcH9Zam6ZUei4m4iisHR4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVgGfgCVut0BtEnF6zYRNknn9mZ6kjv5xXy+f39u0Cc=;
 b=Y4Cb091XaA1HhVwfV8dQeSvG2EwISgQUPxbx/H5EJtU49qmkRURO3elUP7xpjAErbM4TtQ5yiaXZY1sw6pB2lF7t7QdtK1BLsdBXlH8oemsvU3Hoia533eOcwvqgFb65utETRAexuBJCpu/A65cQscFhTDAPXHPkUQ0jDkpM69efUWDrU7vrpT13ZuVUznJ6gm3PRpW6LMRf2R2Ugq5Ixjs+NB+68vsRuBbXehtjQSKGXoVrvMe0EWxdwT8PHU+OtWcSynYGEDPZgydR8+O4rjHtvmfBA7ALwmL6cyd1TXahbGsXOAyEmA8G3UBQsT6uj7Xh0J+z3SFCQJIRxDRzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR0401MB2653.eurprd04.prod.outlook.com (2603:10a6:800:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:57:15 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:57:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 08/14] mptcp: add struct mptcp_sched_ops
Date: Wed, 11 May 2022 15:56:14 +0800
Message-ID: <62fa967b63e0e7cf6bc055850b12e03738dd2591.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e365d76-d1e8-4ca1-f67d-08da3323dcbb
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2653:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB26535AB881839EB6927233C2F8C89@VI1PR0401MB2653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	99j2v3qvzl0CKMhs/+OC9Nnxps6aR4Z5ETcJtRyVGs2Ulpo+o49Tv6njN9ILXkrWDhlCtUpmvj/nCmtMf/dhAf5LUQH3msjPNcxhreyImRAPNEGh3LMEwTAniRufmmaXI0QF6Jmp/Yzb6FANmgKikNLbziAMQwvZS9YvPaLARjK8KnYSi6G7ccLHGIGNzqg6Emevjof/CS2HcMNszSpSjZvBEP0X70/l3MOGNvkb0N00XKS8+qf/FhjA7sRK3cedbLhkZkt+hH91iKVNZLtcZXnOHsYcKdBtzdyHajeadLGpZPhDy8krun6cIEGjJ0r+DYyNHJvvteoXbIKktqrGOV3zVXtO5Zu2AWljLpd8J6e6DZoStFXft2BBzc9J4vMzvVX+djjmg+q6Uyt8uOKtHxI5C8ruVS1b00Jh9/D/aAPhGdc3Aq1Sy0xGVPR0Bpt0S6lCFhcbwLlbeRggnpb5+eTZ/A6A9anCV70bjUV37TRIEqyu/9desIr2druH1R20BOupVrvRQs955b3bhMheKJoiu/BnpGtis7Jgk1ooxlHMOsFWfmRznLfryiZ1xV+WpdbjmGTHaDvqkOaSuhm2Ky2HE7bD/7mLXi/60GFoYgYvTzWyT0XHnTZ55DaPxBlh9+R94g0HkByzRJNt1poeKuJasDVOE2BoJ0qDCjURsAVWe4Pgc6UjJIGWwfAaAvjzF684usuMxYuwc/YDhNNG1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(66476007)(186003)(6512007)(86362001)(4326008)(8676002)(44832011)(36756003)(6506007)(26005)(2616005)(508600001)(6486002)(316002)(6916009)(54906003)(83380400001)(2906002)(38100700002)(8936002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SFCMMYBTnOpDwDqbLSeTvuWAV+65iSzKrSkT4s15XMU1ZQ9hJZmx7n6SGh3X?=
 =?us-ascii?Q?IjtD6/xmpea59dBtI8YoTM4S+pzKm4dNnSZwqBpJiNnSW9Uz+TCw+nu7YVMU?=
 =?us-ascii?Q?cncmj55oFD/ZFkpnq6TOv3CC4D4MM8La546c5C3E/F9LVk/zjg+73qTIe/MD?=
 =?us-ascii?Q?GJsGrUPMY3TnMx/vmrhkUtkhUAA8MttOC2NBwslJQo4Wfs4kYvDaFw17H4zY?=
 =?us-ascii?Q?mJYQus73huzycgl6fH7yY3DzCtWAY2s2oOapkSrcZmjKS6BFQF9gNPOKQKRJ?=
 =?us-ascii?Q?xIgCDn0iYlkrUHxL4nXfLfnWMKL+XrmFnoge/of3llQLO1wV7MjmlhixUVln?=
 =?us-ascii?Q?m/8DXi1keIR16SoOQ7oYu1FlaNvdrTr3LKK6Hke4LA/3xY4vh+Z8eFtF1Y0Z?=
 =?us-ascii?Q?J8YHOSd/WJkzgNytyv3U/jlrxDMt9DAmz8M7syV4SyBJbVl9uq+nPzD2ORtZ?=
 =?us-ascii?Q?gIHNdJs4MUjABebxLsqzjUWkwqPR3XhFqWN0euco+Wlz4oNXhDZ5Dv5G08I6?=
 =?us-ascii?Q?WZvQUwtFF0o8jZSEXt73PdCIZxCPdDMfleHrbIm3vFznCAbVz3VXOHCiGzOx?=
 =?us-ascii?Q?4yc52y82odYGaCMbd9DAF3oPO3Dk9dlnY4gFahZL+aHVpxnV8A7fK81zK79o?=
 =?us-ascii?Q?L2v4427KR+t+atQTzKCuyl757MVGdl8qIgk5fAZk9NAGka+pm5W91A4wcdru?=
 =?us-ascii?Q?qxrwUNFFPNK2dmXpA2VATRfDx+9G5+p6e33hWCqOt1IXoVtMpXNujHN1tXuJ?=
 =?us-ascii?Q?jbZ2AfZ1JEOo7jpiRUSvHkfN8PjKLjHdQxQvugApSGkmtWxlSL+XAZIO8dPh?=
 =?us-ascii?Q?dMlVQhRk4Qcnb2Rt7T8yG1gzQ1oUIP7ZZW5WrPxNVTTxpDP65cpF59JscmqT?=
 =?us-ascii?Q?iyRH/Qr6U+jNsKhzG+WceDcTTu8fm8NqnKPobqi3/xrrHyp7IhxLok5tsFCg?=
 =?us-ascii?Q?y18mo5Qcjv2oiteuOOLlJCq0Y0PdRli5wbXvQUQ8xQzl9AriXY7pZhEwPQy6?=
 =?us-ascii?Q?oXWB+sl/s+6dntqjSe/dgrqMTAfTQxMFI3h9yl9u+luZBTa7YwDRm/yBpsOo?=
 =?us-ascii?Q?D6gOQFGIBeEwxGt5MTKx0XFxZOvggFsr3rOaTWAONkxraiP5vR/5KkQ0pmPl?=
 =?us-ascii?Q?auXC6G9o4toMjuVcbhjjP5yqqpWe4zeUoJzpVyevnky08WFYbvJNdlysmxlY?=
 =?us-ascii?Q?q0McxlzwbLcQLgEyCY5zUFAxYJkdS/ZnygF3l2RglU9pybf6igzImaFZkCCX?=
 =?us-ascii?Q?5T7EtgIJYfneXBRw6/XlSG7cQh3cmw4GkkN58ONJ8aPfDs8TUowCGLcTsFgE?=
 =?us-ascii?Q?wHqdEUxgrZ1Lmrckrfwqd2TwU5UnkUT1GTlRp+VNyQYZXVqbmxSrmufXsx+p?=
 =?us-ascii?Q?lQftXzE9UsimvUcT0afXNmj6cLyvUkb1NAd06xpNc61ZHmWi7ubW44TGX8ux?=
 =?us-ascii?Q?QduVnuP2BkWseTDblhzHVSmx/iqMhGyxv7K9Vf05t+8vzxMh78rfojpptfW/?=
 =?us-ascii?Q?saWGptu9j2/zMgKyn816oM7BF+ym7BBlH/8TjB3lSggpjiXgb+xWLieXS+Ez?=
 =?us-ascii?Q?OOoDw+0d0i9/LthD80Djt4yo3WgIkFAQokqro/sHxV0+/QnCrvi1BEPJypCV?=
 =?us-ascii?Q?i4hWERlGk6+tALKUqQHkQWfJG3gtUBktMZlskFXGLIQHXwPh/pkLNxzxOS7L?=
 =?us-ascii?Q?02wsQ1Htpt9Ii2aKa9HMRh54sCdA8TsL3X17udQPbiQY3VTudxzTRBOdxiHJ?=
 =?us-ascii?Q?mw0r7OrW7Waf0qHkuoqRFeP6JOJELpc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e365d76-d1e8-4ca1-f67d-08da3323dcbb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:57:14.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ez10aeA1GhlD+iVifH5dh1Y0h+jIC1x8u4bvFGJnBSXCwcmpghNejJ+kiM1sZ3af9y++P3qhvaAFlqOzqM+9Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2653

This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init, release and
get_subflow.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.

For supporting a "redundant" packet scheduler in the future, this patch
adds a flag in struct mptcp_sched_data named call_again to indicate that
get_subflow() function needs to be called again.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           | 19 +++++++
 net/mptcp/Makefile                            |  2 +-
 net/mptcp/protocol.h                          |  3 +
 net/mptcp/sched.c                             | 56 +++++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 18 ++++++
 5 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/sched.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4d761ad530c9..b596ba7a8494 100644
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
+	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+			    struct mptcp_sched_data *data);
+
+	char			name[MPTCP_SCHED_NAME_MAX];
+	struct module		*owner;
+	struct list_head	list;
+
+	void (*init)(const struct mptcp_sock *msk);
+	void (*release)(const struct mptcp_sock *msk);
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
index 06b8ebc15204..2f6c4486a009 100644
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
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 82a7c9de95f9..bca318d2cc78 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -230,6 +230,24 @@ static __always_inline bool tcp_cc_eq(const char *a, c=
onst char *b)
 extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
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
+	void (*init)(const struct mptcp_sock *msk);
+	void (*release)(const struct mptcp_sock *msk);
+
+	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+			    struct mptcp_sched_data *data);
+	void *owner;
+};
+
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
--=20
2.34.1


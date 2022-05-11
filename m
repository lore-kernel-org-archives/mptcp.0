Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C615B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihJ4REGzQ0YWsJ7ntbQs23JaJ+6t4W18ivm6EXexG+Q=;
	b=iRfpSYoLxSdWN2YPBkLDhZjqNewJrFJkW7l9qt6CK4KEnNpefAiINEkT31yk7By4Mq1Lo5
	eHyKVvlkRSvCVuf6FUFZQ5JSF36RroYzdUnM9A3YI0GTvbVy1vKtWqeeoXDXAk6YoApirE
	q9aOWfOYUh4BRc4xUKdH6il1VTX4EsM=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-lz2pbmVNNMeYSeZm-XDeDQ-2; Wed, 11 May 2022 05:40:38 +0200
X-MC-Unique: lz2pbmVNNMeYSeZm-XDeDQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLkITqH9lI/lWLKHYEmMPbIBn/Z0yvJLlryNbySKmxGAAm1cG0v7FGzcjijWgkn69oY7M/4ZNEhiT0OicHf4HnmfkZcsONqHJtW5XNKXjPiFbfyhhqF5LxR/v2tu0LBk9XUN76/y7veU6c+unC/f/UmfvFzoXd3BoxmgEm79cUQFhjP7xuCcfcrEd2gJnoUunl2OEX5442nNUFqiniAv3ll9AALSN2IOdwDHELAT44hfnWJbZawEtgBhrcBCcdHbfQUFaxUnj3+qDDeI9SJqU3D2OMBYy2YG3vGJkz2tye3SWwNX+470NZQJjBUb3Co8ZtYqBDPoPMrY8+pwYgtMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ozj8fcMKkCMSdyKatnXE7jXrj+xg9HDHBRYWlRawFPQ=;
 b=NTGgII/rS3vjfxoJHPk43zN/w+w7s3pyQJ1XoNDOr5Mc/5wsZmO70noFc8/qhnby7s7xxFVu4Q3IeO2AB0Ekc8xxJeJ0d1wtuHpo1kYglYdUMl/39uKcK1PTPbo5mPl5Js8JlqLeeh5u3XRepr2O4Vo0sFxYl0vNiaflOu4P7dFGhC34a8fQ8KfcbR7vwiB4surPGWjwQcAEFsxqdi1GWhrtlA+PwfFymI5vduYFbapYVs/IAX0HOphThze6bKsHWBOLVKy3rLwQ//nGkYHWPr7PoCbfC2+ZfzsDQv/XOo8jOLrBiTpTS4W9o0HM4Qo0XmzUP1fuhtBax/OyJ5yyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:40:37 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:40:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 09/15] mptcp: add struct mptcp_sched_ops
Date: Wed, 11 May 2022 11:39:10 +0800
Message-ID: <0ec1339efeb6939f9acf2d79aa43102e1724a3bb.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5842f86-5098-4f4d-5df1-08da3300033f
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7156B45DF9B18DB4B4A5875EF8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9yS+soolOmT1MDaZkaUTGha+6QuXCiHAIov+LguJW+JBnpd92k0EhSmq0S1EAoQJyoatbrHozSWtdcvanjfkPS3nN7ckKg/uf2xi939ig1wM96Tafqw+r5sVXroaz/2xt7CCsaf7/asDwgEgbJtFTG4N/G23T6BtP8jbcdK3t5HyyORJwhkY87pg4xzKBT78+Q1azpqu8tZ5fdmNvXobDlHQ5t5QYS3pHuQtO14uePwU4dvySrQJYrjFg9UUJagh4qs+DuP0QFyjFVX3l5SykOf9JWomD4SqD2GSbN/8+MYTpHMpD9ozJME+e7lUMYYjB0+E9V918qKzvjfShEWM8MbafdGHnfoz3Xnx9nyZ0lJhrMA45eDVRDeFTru+iymZwksCfTdfWugtawDJQo0ki1UHaXOfbZuYgFKzWs5ALw8R35JwBlc9M9cViMUCiDUQFnXWysPUx3vadlSqghzUVW8TxvlSdhB1YgOz7qc5ZffeSa2jiPDjsMHczoXC5dP8IwviMiYD6atZNIO+XJaFaBVPGvx+ylhS8r5WoymETLeaFrFCjeHTYdfX2aUE2OopNHb9WdYlkqDF0YX7+YPerxGe50dF1qZA94sMo+llsPkoUPy4kgi3LCJealHy9XIXREHwHjVEjEOEOTYwNj83kEPatih9XN78hgqvVr/NQRK0NB41KXLr+DOL5T1nt46HoiQhmT9jaufua8TaMG4JdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P2CJ3nw39/KNjBz76DXoJHYmtgOrAMC0BmUXiOa2HrMLgl+B6kFwazVj7vtA?=
 =?us-ascii?Q?2XTTZU4BobxxpOhWGCCIuMZwjMbKCO2Hd8IUT4HH46cluUz7QAe7bL9YHFtZ?=
 =?us-ascii?Q?WSMmfGvv3Z06IZYs08a13z0z5OGY8qGbphvwI7T0zomipaNPDe88SK6bUgRd?=
 =?us-ascii?Q?Z5513zVxqT+eWPcaDIt+aUp+OkfCiT1HqAfoSx5lG8YbDL7bOOEr4f2arCwY?=
 =?us-ascii?Q?ko1uqRUyNbemxv/SBM791lYb/4vggqboVP0JuyLZ3QTcBYUuOA1sUScK8jR8?=
 =?us-ascii?Q?OGTKAlN8qbzQ6AZXXsJ4KoUXCk8g8gHgx5fAXZ4+OBCSncUA6gnfrxX15R2Y?=
 =?us-ascii?Q?lKgh9XdgNO5RwEu7bbLeHJMg6bFNIvt2YZXodh5fwDtuxAUTolLWsVEyAPz0?=
 =?us-ascii?Q?HUV+WvRQS2ErLwisnbMPC7c9reTkyMdpf9gFbkCsIPvWMko30Z4AseEvUNt5?=
 =?us-ascii?Q?MSopD3czD2ba8Ql4sDlektczxINu7q7FStFJEsT46TVc5W47UdJj0HgcB09D?=
 =?us-ascii?Q?VV+/AE+yVFOuf1A96Q7mIBL7d1VjOZQSx4RnFON7Y0bXS4UQ+ilu9DOOy78d?=
 =?us-ascii?Q?36Yc4ochU6PYUXK9Qez2AZfuHvSyqkTBUMRqaopQbGqnAmNgLEZbMb5377QW?=
 =?us-ascii?Q?2ys8ZawDOqgf+tGRpziPizumvqw/8F7YWnDS3wh4yHWuA817XEBBXfHMxU5m?=
 =?us-ascii?Q?2/Ev8agxz8eoytQ1lsPtd3Bt7EN9hohUFzH47sgXAPrrfxT4bkFR3VJIX4dU?=
 =?us-ascii?Q?KXo7G7/aSO2gnMmVAbCWn3nTZWBHyxw3XRWkSEE9yvW72FNhiTJWssBzUrTr?=
 =?us-ascii?Q?0M+ODOJ7IUS+v3ca2IYUhWHxajzHy5pZVqZq9ukgW661pCDy6nmvjL98Qskw?=
 =?us-ascii?Q?E6UX7zOvhPl5udPWtux/r1nr62TvUxlaaKTlJgla75XUlju13ieNQGTjNcyP?=
 =?us-ascii?Q?ULWGCxmJ8umQo0gOjQOW0NqjrFvW47dpvI6+C1w2eouFVB9oL4oye0B7ahN8?=
 =?us-ascii?Q?BCaNKrptdtcFuQnbvrUdd1pbmVCYX684tXZKqqKe0kH4xz8eoBQefbzwuX8W?=
 =?us-ascii?Q?OyvZoKcGrAR272U9AAQi7syN/y3YAShZxw7INI75mMkW2CcTebRXrKGa37RM?=
 =?us-ascii?Q?acEXY2S50DeH1vqnhODt7sUOq17vrGLCAB0xIpAo5ORqmUeqUNS73fUUAJb8?=
 =?us-ascii?Q?OsgKiMi+XF+W/7ZQ8gIzagCYLI3yE05KdeyPW9+s05/YUZXy1JsoYdznZMoz?=
 =?us-ascii?Q?F6yk4ZZ3qId5c3tTqlzwU4F2/+/9jJqXq0uLrM2IAJh1+6O4wGXw7FPeuqM3?=
 =?us-ascii?Q?HiJNUV4ohjm+DR991f+ADE8fiBmA1+gIJ2v0Fz2M9iXBiQ33VBpG9VYSKc9D?=
 =?us-ascii?Q?PYhIPAgZE/WfnR6heJR/dY3YzYpLJTryY9XUebxnjXFpJQRL9D8nEab82tIk?=
 =?us-ascii?Q?aK+88rcFkabTwc7H3hC6eLTDDb7Q0+NatDG7jZEkG5LrQAt2V4BQCYUgIhfx?=
 =?us-ascii?Q?18UakEeSEbUXPqd/02mszm9iLSUrVkrdCuwDd5iJJYyvVTAw34136NsXiMbq?=
 =?us-ascii?Q?JryILWguNR3jT9KTBPKJF0QwjhMcLZI4ULyul7mOHQaYxcvkBR6b38e/dyb3?=
 =?us-ascii?Q?3GyV8T8rXJSNOPFiA0e4A1yGhIRFAR92X8pAQafDNryvQXV0nfSwhHNKz+xX?=
 =?us-ascii?Q?d4wXfxD+bMc7mc7hDXeFE+GXPHRNNaZYIHfUeJur+U2ouXlyjP8K/9wSe2GR?=
 =?us-ascii?Q?y0bKAxzdQK4q8YTpV2mpTb/hT1HHvuY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5842f86-5098-4f4d-5df1-08da3300033f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:40:37.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 593C2x6ZPjPqnJYjyhDXXQhJ8TGekDHQ3/v/qBdtMYuwL7uge1DkKEx1gt31H9QF2lGxIFrB2w1Q5zbwB9b9Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

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
index f1044778455b..ff4d57993e10 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -229,6 +229,24 @@ static __always_inline bool tcp_cc_eq(const char *a, c=
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


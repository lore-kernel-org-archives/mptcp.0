Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50DB7E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650981657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ1EoAt/ZeVfyTsL+JuePBVq/k6t0m2m2CH6eYEln1U=;
	b=DCWV+3KQm8gubVGstrNB89dtIwNV+E3srK8hQIDtxRMZG7aFjjN3P4tPO0x0aF26hWxVkJ
	Q8TimcN0y8RZxEnG6Y1cUYJ1EYiiUAgyHbK2EVw4jUVqO+6BND+mGfYtckKUUKTPDQATI6
	INV93Wr+6Dv4mg73aOYPu3GWxHkd9+s=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2053.outbound.protection.outlook.com [104.47.0.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-IwNqjK6fPl6L28WN8GUu_w-1; Tue, 26 Apr 2022 16:00:56 +0200
X-MC-Unique: IwNqjK6fPl6L28WN8GUu_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXB36fxiT4rnNH89CYcRtqK78flhIovjF2S/lYWCvMhD40cx1rHFeJRh209MHaFdHrE3Uq6Yrjvyqvj4kW+QMu5ghR0WtH9gvAZR3qHx3Ib6AH0yD1qWCJsMHmDlqQopJ1I0B8Wmt/C45DVp9XkMYbTHO5dak5bliQxoevtPAFjcHGUFOMIeIaLClx1dGeGu3cSAmPwmBgAJCfnb48cOa+qwn1TaXoxsFt4fcB6pKRh5srJkFavNQDEokapK/Z14r5tbFcvBjhPUR4s3Hwqpf4KFTxSn+9DrKfwEPU/qiZV/N3T9XlqTDNzmj8WBBP0jaBUH+UiLTV8R4mmHyYsFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEjn6iEVZ+w/+dyplNuWhzUfwIx1yEX9TzuaJzMTzqU=;
 b=RlaK264Gb26w7SJ8p3Lay1jPmLbnfqszKn08WN4/hp584HgNUaWQ3pGVfk3Os9vYGp5hIPqzh+eOuRNRCWqyiDkW7NH/58nOyi1N4wop7ZGqhrSaNijFVQT9UdakPeZafqlaN28FGjdLuqxy7q5LRDRe+9qeKYu+RGZas5R940Og7rz28/s8NJDMcmYS+Qztnh8UT9BywK+WYCHBb09eP+gCOZZmoxHyDryyqo1T9bWb1+9FMwlq9SNmHRNjH8LriUiIsFgP3VT7AK1eP1luf1eW+fXheRdrbKI/x4SMY8JG1IHgsoO5m7tb7nsJkyLl/Z2Pq7Cjp4RmBcJfilUD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5182.eurprd04.prod.outlook.com (2603:10a6:803:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:00:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:00:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 1/8] mptcp: add struct mptcp_sched_ops
Date: Tue, 26 Apr 2022 22:00:52 +0800
Message-ID: <f0ec6099d3b39c1b0e91e1e51ef77a2f0bc380b8.1650981078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650981078.git.geliang.tang@suse.com>
References: <cover.1650981078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ed5495d-c42e-4952-c8ad-08da278d2dc9
X-MS-TrafficTypeDiagnostic: VI1PR04MB5182:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB51827B6BD8D72D5535BCD6ADF8FB9@VI1PR04MB5182.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xTNxjAKvYLtqj2Mto4cv60fEwcj2kO0ITv+54PVhs9mgx5zqYIUOLbNe6KrRG6WFc+2WA8kRWUe9tyGIh6hvGGBwfp92VIKx9w6rbxHopWbEuw1SQXXholFbEMlTWc/jIhg/cQDdecR4ItQEdOp7N2bt3ueRB6eZaBfntStcRYjUepKWkaUxk5QjOqdy2DQOpflLKgyPecyIEgXICDz60pkWPxcknRZUauGiHSlCYnYhprnESzKAyWMk0puC56QOMTrlLKhYqTL3egOTT+F5kkLrvkM4KOWxrOSN8HCBjewjF/QEiZX91SG3b6woJMHaqPbSSmnNAFDSmkvkDFK+NLRQrhffxK5QxuTjify/W2uayk6XArr+TVI/+W+heQdgAj0/FGFakrAUgTVkUobz7eTEdj2msUIVQPHvU3SRtup7TNXkepnhR7ehBJZul2BotPV91MAoTo0eI44+SjeHU/J/M7XbcmsN6KmhPOV5498Zbra3gYc3X20NWdmjPYHEFosuodWRr/byHILBiDcCj+uxZCICYjbbibKbINPWvoe8+E/LdCsB0EviuAYba8aNKv5KEAbvg7Je3onOgz9It1nDyfkJ7u0nzPV0bnfJPflLS6xUP71G5BZOqDI7iLVBd5H+0vRNK9KUB/omrNRTaCv4NPWSBd7WxKjTFH4P4awoVjQr5O4wM2PFFrx9DFad
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(107886003)(186003)(83380400001)(2616005)(2906002)(508600001)(316002)(6916009)(86362001)(36756003)(6486002)(5660300002)(44832011)(4326008)(26005)(8936002)(38100700002)(66556008)(8676002)(66476007)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idJ/vGBLZh9IGerC9E7aHuD2N2VWjIUxMIjP+VYZDqfrRZg3EF8gO84lfH3h?=
 =?us-ascii?Q?zZ+CzWXCf516T+/qW6jMm4QikqjtvvcgnjlnnpQYH2yW30MKGEgAz/aE4hlP?=
 =?us-ascii?Q?C7zgWq/iSoihVhvrIpzPy4HwWNh0s4+hTXdyQMlCVRc/pfywXKLyElQw4B5l?=
 =?us-ascii?Q?jSnOfFpij8s0CMJin7vFiVTBRM7aWELsSHFARulzpc0RwlHY092coCvK8XEx?=
 =?us-ascii?Q?azFJvQwYn29iTP83L7sX0BHtW1QrD6XjTRmireuoEXkSXhUPlOFw0pYUQYJM?=
 =?us-ascii?Q?Jf9OW65sUf1lOVbDtOVTFVx1u5RSTx+TodyQPxjC7cWxqDfKwzJ34tYoIRZV?=
 =?us-ascii?Q?Q5aC4vnDxsCun+3HkCiMdlUoYN4We06AZo8rjt5FUD3ep8rKo7cKGhj04W1/?=
 =?us-ascii?Q?p6uOiDQXMTnfdwv7yi4uxvmTahXm++Za3L1Wv7csqPqAPzIsnV1RQLJh5g77?=
 =?us-ascii?Q?4b9GuVhkV7nocX4jfmR+Yd/P9rDpQBlqPM83+XJhZ1PJvicE6npm1GsoysW8?=
 =?us-ascii?Q?WDapiGP//bVlHmb2brE8/wKZP8CAJBGzYTm3Dj72UlebNs2vOKXZVUEsi07P?=
 =?us-ascii?Q?XdL7Lx8MSMb5WHKSYJTsrRfU819SZ65LsU3dqXFEaooWy9PD/y3rlEsMJW9S?=
 =?us-ascii?Q?jjUiz1gmVmswg44f2h6eK+1uhBEmKTDFSW3qqk1KaI5F0oBr8Th7cKSfpHa5?=
 =?us-ascii?Q?4MO+nh1hYbpSMMStPzFQM+6RFzlVxITCYN4WFCDrlzdB5OxhM++4/SQX7JmA?=
 =?us-ascii?Q?FCDo73mh5CEp5/XG1XBp87aiMFq39Kw7v3foIPTE/pbZ2Eqxbo9rixdQZ746?=
 =?us-ascii?Q?/Z/xLEpEAwONIgQAerMgYAQU1HyaRac+uVoL9Q1F/xA1MsPYVeuePvjY9NfM?=
 =?us-ascii?Q?/CcwSVMQ99Av0/jCzRJylGYxaBGHXb2UWZRZPJ68s1AedDX754RY5zcUyenr?=
 =?us-ascii?Q?xFTn0c4wi7MkvF/fABQmcFGlK9OLdXsEgVhETUmRUXDWHGs6TGRVS4ivbW9d?=
 =?us-ascii?Q?JHv9AEprSsrrWTY8iUBCa6EcPnOatvDgsxowQ7TkWwiwGX0+tduJ8LUFHM95?=
 =?us-ascii?Q?+mlkru5WyM603LNMiDy+nxvhnU36eXySGVkAuCFFSeeokxMGGdZX+VFoqeOF?=
 =?us-ascii?Q?c8bo+QpkV2Zd9D+OiJlJI4prbiM9lQBrFv0xKCfMEQi81mKkX7sbPqN4K8MG?=
 =?us-ascii?Q?728VPC/+/VzSSSAtvMsBE4sH9GthUgpPorRFG7POdvH1zF3WeFIZi9Yxd4qA?=
 =?us-ascii?Q?EmjeKqnDWR+dfps+yqZQntilu/cRNLR9Pg69NSI+jwZb89KyaIxHGQb+8j+Q?=
 =?us-ascii?Q?mJBgWyDf9aiz+vZU2wduPbGjrcHtXKLx/4J7mystUrycSCnGucSj3NaihvvZ?=
 =?us-ascii?Q?EVPNgB3x6DpjUvXipzX1oTEB5DVz1c18mC6KKiTY0lASqGytuWbKZ9npgu0S?=
 =?us-ascii?Q?2gsLUJx1dRI7Bx5KMMvR5scV7Jvro3qGpRPfKseO4jgzKCekPU51SPf6ICQ8?=
 =?us-ascii?Q?zvwyyqkIHsAxDIRljlchq8EIoUB0ub1SbtAJz37mE8n+yf1xQc+UbmHq7F9u?=
 =?us-ascii?Q?unynqi1rPs7gqX1nvH7cFsMELgudJ/48D94vNFiL9OqmBBUVKLg5UevKUFP2?=
 =?us-ascii?Q?S0exR0HZ8dKBznszLigTfuJKptiZNVGs6aL8FQjL6cRY04YErJVQF0NtnH3P?=
 =?us-ascii?Q?3DSZjCduihz6vF3L9cZVw+z+im3N+q5B64edNGSPlrCPKDZ5VvBHqHSJa4/5?=
 =?us-ascii?Q?ifBVz2VzM0x4mHxp+K1LO3JAdT0lVr0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed5495d-c42e-4952-c8ad-08da278d2dc9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:00:54.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIWIMBJVt+tjnYL08u2y7c5TgCjIyZZA4e+6fJJJOqLY0lnD3VTEUIuQpac3nA5M5IvkxjSjoLoYNvx0y1O8wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5182

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


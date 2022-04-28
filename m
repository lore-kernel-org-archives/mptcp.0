Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445877B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 05:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651123409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ1EoAt/ZeVfyTsL+JuePBVq/k6t0m2m2CH6eYEln1U=;
	b=jpn5tHpjxxXOJwS3Ik02zOb163YZcoBQcBJV6pFon+kiMKw7gNotxmD4wjyVNgNMwGIE+p
	541dYtibOHGroi13yLCqgHhkuhQTr5q1WJB3er4UVB77kXC80xzEQemAscB7BwSVevwww2
	peoxuaBNstGF4uWHcLRtunh/1zxMBxw=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-_0O61YjlP7ajQaq0zyy3dA-1; Thu, 28 Apr 2022 07:23:28 +0200
X-MC-Unique: _0O61YjlP7ajQaq0zyy3dA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErJ1NX3DEJnDTz2d6Vd+T0m3zGGLjmrTGW1+DoKFJQnFswfi+9jHrFDIvNwOGTQvKCzkIWw8aK8Akcpl8SUrVwa3/XCglOfYFd9ONNHtb4dEk+NNaej9NZUAZtrqAN23DrXrdXWiJRpwVAN7TecM6hb52+q+xdqq+XIjaTbxlOrKS4QqrWtUQJA7BZ8wzyp+jxKXj6bRPCgxbPCd+9N7B+yXLDPQqGqUHK9DabsAAhj/MkIHIXrLdLxphrYfETuW9m0pl6y052qShRvj2eyDFNjQ7fqFOoZPbd7ITAZHOQMfUJ1lGWCmVcPEG0Qqf/Rh/bAWpxlStujsx/BFDw/0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEjn6iEVZ+w/+dyplNuWhzUfwIx1yEX9TzuaJzMTzqU=;
 b=A0hk0jD06uctCzqhz1lwqgCKsFENah0N+X7vENObRlhIciiO6najuqt7jDFaWvNmSMaqgg8eR7NZlzbn71hHkwpEwZuu9RBGLX+NxxnV59BPh9c3R+nbFUdAAC1v0t4hTjq+LiofiZAw7hoqdm0uE/fQBmbb3IZjaFNlfaegCwMYQDkMXN6ISwMGtgt20GUkD0fgincOPJl0lZpFYr0w5Gw0hRBkGSWEAydGeLh17PkrxeuSAyWeEx92gomb8DeEdvcSaO7Bq7BsHLDIvJzNjToPKHtaTMr4vUVnjXSpStHr8GdEnE0XFuCLySnMIXTcZOLub/+LvPxrPY8uM3rn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5653.eurprd04.prod.outlook.com (2603:10a6:20b:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 05:23:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:23:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 1/8] mptcp: add struct mptcp_sched_ops
Date: Thu, 28 Apr 2022 13:23:28 +0800
Message-ID: <22c172814ef2369523d9bf57803fda829ec97ef8.1651123078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651123078.git.geliang.tang@suse.com>
References: <cover.1651123078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d8eeccf-4116-4dab-e3bb-08da28d7396e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5653:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5653C07ED7B1AB693F81DB41F8FD9@AM6PR04MB5653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fmpobAICrsoPdVZqTTsNdLIglxKb6fro1PUewvNK7583L0TWCgisHHkvO1zSpnFEma+kzh/tZIVzx58TMF7N5BVG7bRZR92aUmoEdQMydlEI8pa0uW6yHLXvGdoy6hiUU6tkfa9EhgdsYv0n3CW6GZA5BBLBBoaYbYPa844/e+a3bJLYzSpZt7BZyVqRURzzOTPp0xiZczfCne6A9wmEVvqhMKwdFRJbLNJG1+f5wHHUBCeFQOWWtdwq7R/aQ8VGYY6pTEj7yjbvIoS/1Ekz4KJ5pr8jVe+Yn+eF/TgcquzIfnya5cln31k7D5xoLKfEFFbX7bXnBfgGECQ8W+H/QWhlqTj3hbt7AqJcP8p7CNDp6ksIH2iRXQkJoQrdGPUrXhTfz3BQEDc6lkwrLazSBSepV8Wwk9dgKfCNC49CvlFyjkmyhdz8TPDwbDvlOC3qRsLrI0rI3ezcqxlFXkv8CpNIY6YLRqJ8spw7i7inUENzb85whlIs+lH7yIL9qO0mHkhY1nD4BMz1cgO9yxPaLHvKsz+fLDJb/MCFCqlj/pmNtboOvM1IJn6Cuv9BY5VbhdjEVdIoNU35ZXBZEDsB+N8XsP5MEJqNPEdxHf+e/hN9NGvev7xHJthtuBnH/mDrunSmLFDylAhU+VnODwFUO/AamuO7DhIe66tLeNXyS2VBsPqdOBTD/8zEBXR+FAea
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8676002)(66556008)(4326008)(66946007)(66476007)(6506007)(38100700002)(5660300002)(86362001)(44832011)(8936002)(508600001)(2616005)(83380400001)(26005)(6512007)(6486002)(6916009)(107886003)(316002)(36756003)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+GoE+LNaAEmxnZglEz4x5OT7FeLLzUT54miexE6RUkvvcLWvTC15mPoK1bMb?=
 =?us-ascii?Q?XriD/qXWPqHXUdCOlIVUdfr2+xd527F4jy4tVL7F1M2oT1gYH2G6l+TU0zVp?=
 =?us-ascii?Q?DOFT1XOHfYf6sSRWkUcL9jqdVLXhSaAEAlww2OXyDQodHZFYBqRdxrImMneM?=
 =?us-ascii?Q?WKJsCz7CkFlM0euFlexhJtqVmcTpzpbOBjE4yXrf5w7dghwhDtYCzPIbBciJ?=
 =?us-ascii?Q?O04JZDiO3P6iUppPP0jMFcg9BpVrp0FvJp3f1kHKKzqPyuGSyEFb+wEE74pK?=
 =?us-ascii?Q?v5xQ7y/lMs+kEKrjhmsUKlEKJZF5gJCpHYy3a91SB5GJ3mb1vBYlhpfJ7CFi?=
 =?us-ascii?Q?4qV1Fn/qRt+zgNCnxsrbjSRMFaZWE5ppss5PM3Ebj50cAT4IUP2emeFWr31C?=
 =?us-ascii?Q?WWNx1fr5EcCX9DziUXwNd72PSUJmCUgihhdy5m4awxEnbzXMEIQsdMHz0WPE?=
 =?us-ascii?Q?HrtX7Fe1TRmP9twkVvJ0ZcLSpN7mUmhpJYCPOWCNjK5MVdEyWIfpbZnNQq/a?=
 =?us-ascii?Q?65p8fkgZdJQvTZUqP2CkGNtq8capy8ycriCWRAMqLpmqoapTh76oct4eP99Q?=
 =?us-ascii?Q?beFeRi6iXmFligzWf6lRdcyqsnWtmliPCx4d1S5Z4rONubMQLrT+Oy2Pl6Cz?=
 =?us-ascii?Q?c+Mqni5xjYAcBkYPRMBuNcls7pMygITLL8z4hOC4sf6FQyFYtKwin+Q42wMF?=
 =?us-ascii?Q?jZgx2wu3IXzDoI/9leRejbIlKzFgXL6YAjJamvd0ftpfVVtm5twG/n+McEsg?=
 =?us-ascii?Q?dsvJo8eGd+YWRNqbqAVsTs4ZRiGPZ1KZcWed+WkvhLjc9MS/lyZ4o1jYSct8?=
 =?us-ascii?Q?bwA1Txz5bFbK6Y2Jub7EfmTc95SnF8ulofImMD6kpKI91j8FYQ+wgm+7qSf7?=
 =?us-ascii?Q?kUP45AfTgxW0hrE2XQIleJJ9Jj560sZrRDinmaj/i+bd+VYdgQiC17XveeYX?=
 =?us-ascii?Q?Nffp8iR5PL0+hXMXkgfDdRp11SLCUDdVaE7HzH9kBkuX3/WxuDixoOOXLG92?=
 =?us-ascii?Q?MkaZSHcKkmY/QqtgyPvNYqWdL3d1cSMnsm5bgbrtKImA60yQ8YiUWGNJCPwf?=
 =?us-ascii?Q?3KBW/xkoh7rp85V1m/AgxjDhF/4pETJum5W1wiXF1RttIXoPGSrWeaZr2VH8?=
 =?us-ascii?Q?gfdBNXzQ8Jj9chH1pNehVltkC27xubiWFLWQcI5zKnIkw2HG35a3Dx3va5j/?=
 =?us-ascii?Q?Lra2H3hXF+8ZBe4I6/QK7q7Qh8VB45coeAgL4LJ7Czlt18zFby+zfjeGHGEx?=
 =?us-ascii?Q?gGJGQJm8JGnJ3TwYWFxi+gRZcuklqsZl7w9rRtrGOI0LM0wvyod/HkwKPT9z?=
 =?us-ascii?Q?BcdM7EqAwVx9C0oU0KWQz+S0iuYAo+CfBemkxEKoUy0m1hgaKXQt+l0qVTM0?=
 =?us-ascii?Q?ddpZDFjvWT4zqIMBHfFvQ1geVvkccA5ZtcvdiH8sDRmBjOGpiOtGPR4Y83zn?=
 =?us-ascii?Q?IeTpQ24KIk4P2s06Rm7XcWHgwdQwOpCQvD2M4mtuhRkfddVImD1TQOZR8ZGw?=
 =?us-ascii?Q?AnIYmEXTk7wtV0ZxwtF9m7riI+1niPrASqYipl4MnTSak/QXZMERsXyJjTA8?=
 =?us-ascii?Q?dYZmN6s0m3rrNUjP/sLK8n/RAoajseKTwV4aD0i3W0nca0zxtplE3YWZNbD8?=
 =?us-ascii?Q?QUBfOiPtnGYnZs+/LhKXs7ry5HyZDqWGCI+BCa9FlaI+tNWW0iAHXcmJ/bpw?=
 =?us-ascii?Q?rdILix2z41g6qq+7CqRAnO/D5SAgwuPeTBWDe/qGmjaeqGUv+FXsydx94KIc?=
 =?us-ascii?Q?Agtpz5QGkQNXl8kcHXpu90v2N5K6/4k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8eeccf-4116-4dab-e3bb-08da28d7396e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:23:27.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEpVmZXteJwTAWC8z9NjLa5F/FWpcnm6n087i3NJNTkJEM3mJT9JUVdWGOXff6IaJ5YfBmNqJ+m9K+oMaJgmbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5653

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


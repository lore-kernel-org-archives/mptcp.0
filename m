Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0E1852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiX0Rf8qWd0zsnoDCu+BohE+iN5sssnVFrfCrvp3vPc=;
	b=LZbquY+QffTqJf1b+zRCRtEY1ety7pTA62gnl2jif4hFqgQxJd4KYzzFpZR08ZMpPK7JjO
	+WovmhZrm2wisMyXHE0Eg+uMFKbTKrqRqfxUj/mdWzlOvHO95hnHYpetkReJ1pD0bnkDGL
	cgbazPfQPMn2QNejcVhBQAM+ouv3f4Q=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-b_VS1no3NsGySFYBs7_gxA-1; Wed, 18 May 2022 08:12:20 +0200
X-MC-Unique: b_VS1no3NsGySFYBs7_gxA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUHSBWpgGfkDUlTgQnK4+0eU26TyEgjqECYNmHNaXQx4x1iSFVRxlh7diTiF1jqQbSMXBbz2R+kfyOpEezgKWLankHGFxfHrcU0pzL9b58vw5w0Onh5Q490BRUARqwmChdchEyAw98B8TEbQBY+eNrmCtr5azMQq+nYCphvXhnbzVSMLIiGXtJMxJwK9quh9bjaJseofOFGYQdhaXmpCDe/X4jkbrjerRC++dLL9AWK9BKeYhguusX0/6dOItOuCKtEjJ39UJyz4t3MTrxsoalhlDNkOBdwGPRO4OY53LmfrAPmGlKiiICEia/U6n8whCT9cSsqnR9xwlJgTprP3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWiTaRAE42MtSaI1EcvXMrNnQr1umgmN9nwFYJP9Be4=;
 b=QVY/w097BloKt+NQLytvd7REDtO7MSp07/fcJTc71XrkR3rwpDDfA3OuYp8SKw7QxYnNzjqyFDwDEyeoiS0V+XJkHtYyqCmyswT+ISQ+84LPB+nheBtWGDuRK+VGNm20c1IVxPy794uf1D6+GM+7bz7W0cxIn4n7CUpeItCmKwYPpty9eb35PQk+gJIyZNkJWel5OP7TOvsw2/vB65MnnhXPz0zMj7LEN9pgux+7DBY1hYJRsnN14PivRXrvpOp+LSBSFTgzr20kvl7+KqB78VPtYsyg+AvksckujdX/7unro133gBUJ3U1coDOA2NrBnj5dD23sj/jdohrtOUTx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:12:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:12:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 11/17] mptcp: add struct mptcp_sched_ops
Date: Wed, 18 May 2022 14:10:49 +0800
Message-ID: <2c1ab076061c9463ccb922af66fabd7ed6843ed1.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a432fec-0e41-4466-cdbd-08da38955d16
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB25849108B8E0E30582A81051F8D19@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l1qvptIzgvJFfk8/ZeTlW7U4QZyZcbCgeK8/LJguNRE3CIoCMQJXOvBNHbv3PHAI7xvxdNY1nq0ZaxrJUZahYzk77SiWkfPn2YzrB3Vg6aCILMIV/yN4LInfO84CywXCZhZgAfLuIADAiMblVGuu5p1HcBPmKccrAcRxQrhO481A4yptugzpZ/2juN6HXZzAz6Hr0Ekmojx5koBthdCF36VFVjKBIgeYBBBXzj4rsHzTblCNEyf66LVuZzn8WIUJKzzubH96kuESO1+x3xxR7goDUoIJ5Zev0kjYVls0Jt0blnum3Inqn+PrvwBiU/E1btwQkr/pALaek6uX5nQBheuartz34MNajtEOzIszpwA2akiaJrRWldQZcaqdrD8uSKE8cJ6PJeJY96Gx5ZB6oEceoPzRnniRqW26AexK1ex4qGjYr/zNW0ZpCnta8O04ZpofJqvNE8U1ZtYlCEiM/i/iGhnLXePlfS/tOJ4/CRpb/4BkFjbXTeZMSsXUrXpf1J8EURfCE+rfX61sz4tpXp6xNoCJORTTs5OtUUiK17FOjJy9FlNi1qGkG/wQjAZ5L0k+qOVOoZLdjZzn4+2K/Jx9pTslz6yPTfGofdKMq+axPrml1OXHkF01E65muwDMVePls83Iml7BYF7HK511Q/qKHoDINj5LoQu9cAbLHnd/3glhMWKWKANsSevyyQW05/smpAe99Tu8aeI9ClsDEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66476007)(36756003)(44832011)(2906002)(8676002)(4326008)(6666004)(38100700002)(86362001)(2616005)(5660300002)(6486002)(66946007)(83380400001)(186003)(6506007)(6916009)(54906003)(6512007)(508600001)(8936002)(66556008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zWm6d/ie8d38+t/OHfDxptgXFANLpPlUN4pkgzMe54Lw+2PVWs7uOAZdOgzg?=
 =?us-ascii?Q?1NolAJzvjbGQZTs2NPHC2fnscvxXsoIDKFIwbUyHPVLjZT+21TzJ+VuJvi9V?=
 =?us-ascii?Q?4nDvVWt8tjrOzwRHaLdK0oXoc0y5oa4WH80FwMPxgxOPdKzCFqZ9yzm+nsp8?=
 =?us-ascii?Q?BBfUqppJ5RP94MigtNz5TMmgrKz+IxwzvQYVUnmS9IyS0wucEexyLrxyfaQ5?=
 =?us-ascii?Q?6pKJg9ZedUDVpLpkoiWY1tBCCTG9HV0WXV2miggH13jwu+JVcukmT36dlf5t?=
 =?us-ascii?Q?XK7nJyK+9caD1+E/Xl5GFJSMd/Z2FBslzYyhDd5ta3EvAccaLc6EIx1NzlN6?=
 =?us-ascii?Q?zcydplBfyoxFnY+eVXM2ApKIv27Wx6kDdv4BL5JWKmWhU3p4WuGDWX26X01K?=
 =?us-ascii?Q?eU5QEmO5xNZbm2fBhaPBKtM3IKbtyMtlDZc2vPTzzYxxWzTNFIkUh5vMrOBC?=
 =?us-ascii?Q?/tY8PWvN7e7h+tbixLsDU/xRMqSn/opU9UmmmnlK6InlokTuPxu5lYbCHrE+?=
 =?us-ascii?Q?Uo+3bAKgXFeGHmmaKcTGIULD8gVFQfx2VCR9pHl8MzjNqZCN+IlcVuY3mgrV?=
 =?us-ascii?Q?95FKtXuuOjVl9ahmSq3R6hyajQnNtxA4B8mXAV+0jMPDZOQ769SvYBCDEwM/?=
 =?us-ascii?Q?ZB9dFs+rM8xKo3Hhd7pN43yVy6SBqcizLN482Tx9Jm7fREwM4wQjTn+o+lON?=
 =?us-ascii?Q?oXvyNLAp/UG7KzTnS9vnhCFrP5NwuDLbQxqORmsM72nHRGitdvxHIInyKOW5?=
 =?us-ascii?Q?P9CUAyHMUKm6CMgQtflVRudbDQf4OBpQB0ZFmea6HEtFVb9/gbTtmVcqumFh?=
 =?us-ascii?Q?hMIG47zZbD79Bd94yZ7aJ6v5NivvVoKvBHPcOKY83m111o+QPiu9cuvUXfnh?=
 =?us-ascii?Q?wzmqgWm7TDDyhCNeBoBfoiQ8ibZPKYSyEvSKMP/eCYETVNf2RYSGb48jNx/O?=
 =?us-ascii?Q?3aJ3hwBZz0DrSNq4ZLEKnefvFT0UIRnVhLFo4JDxd5XRZUj/Iu8isgSR5WXP?=
 =?us-ascii?Q?AZ7hyPonaQC229DQeDcJsrxJ9fbV390x9DRQP0mrICYN/2CasInlXc0aWMjb?=
 =?us-ascii?Q?bTAmFGkmzgoXUsPq+SY6trpr8TeVODXSOCHTzCGneuR+iozAAmyuhziz7xiI?=
 =?us-ascii?Q?IZhbJIowqY2zLLeg25Q1R4YPzGWli/AqF8SYa7/L9tiFReTlxrI5IfK80fPY?=
 =?us-ascii?Q?lAorNGx4c2pvK4d0N920BY54rOc3qQtPt5tJ2S3i8sr/hckmQ7pVCOjHdU1k?=
 =?us-ascii?Q?LaWen2RUkLsOE4qMFvB79YzT7KeClWW1/iduyqIcQLf1Qy5roBL6YxPzQFfe?=
 =?us-ascii?Q?t9zKV+0q1djc4sCjWGgEn2WUjRmdDGkj7o6h/EN+7ulHTukp4pljlGfCEV81?=
 =?us-ascii?Q?LnUmSwV+U7PXriG37Apeam7XT7kN6wGz8XbXlO3+Wo5tCQ+UcLqfNRSug0Y5?=
 =?us-ascii?Q?AuNgV869ckJpj3jPQ2TGfVgVGXdV49B+kZJ8t4YX+1vIE4tUf1DuOtJuASlH?=
 =?us-ascii?Q?TVQnnnmISDlxxEq5nbf7HjYNvkztXK2j2YJrJtffF0j4dRdinhDEhJl0VSPK?=
 =?us-ascii?Q?ol0E/DgM8bdDflJLGMu1B3yAeTZHdi6wZBytxFzdWJVG7WWEM9kDEXMDXIAO?=
 =?us-ascii?Q?nje0shT8HyLbtI208IE4uAjzbg1LrTC1ubXFNxUxiXy0eQmElu2giznA+yH7?=
 =?us-ascii?Q?ZyVrxrfFFk4XbmtGzQg6m+nupDtn65t1RNubekso9tnvnM6bGJFivZywWLkL?=
 =?us-ascii?Q?1bH2WNIvxUeL5QNac4hAc0HEgtG1vYk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a432fec-0e41-4466-cdbd-08da38955d16
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:12:19.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uq0pNDoRZUVtp58yHs1A4H69uJoJ5poes1V7b7ycgjfYY1oOZgAOBilDl4Tknpk8SMqknQXfanEbs4sBz0LHuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584

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
index a267cff36197..6e872d0a35af 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -176,6 +176,25 @@ struct mptcp_out_options {
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
index cb7f53f6ab22..b68eddf4639a 100644
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
index 2fc8aaf5cb05..86efc5a6d878 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -527,6 +527,9 @@ int mptcp_subflow_create_socket(struct sock *sk, struct=
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


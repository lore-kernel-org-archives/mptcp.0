Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010F28EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651412987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsM/9bojmwVOW77z9O0usyka/E2mXMcExfQ3jhVXLmc=;
	b=O1ipeG3vkP+qGbIU/8Y5ya9VYtVgZ3ZK2Sa2ZMiIL2smAAVynxuvI4rGgXSGc3ciIqNEPv
	f71AcKVZfSp9PlFlvkVzf3Qe/hwFmsRhfqAZgmj2jmphOxdgcHMOrViWiivwi/mzq4BSTA
	wMrYmGEbANOf/RoJkqc27eI396atoQQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-yuMhlxc5MVW3VM5Aczr5LA-1; Sun, 01 May 2022 15:49:46 +0200
X-MC-Unique: yuMhlxc5MVW3VM5Aczr5LA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYydtZnK6PMiTpEjgJlPRTXcmAdOEnhUvpa7ZVmiagu1ot7biEzmITt7hmFhM1JD09T/72METAOwtfrrAoy3YB6EvoK6YAKaT6S7nOvAL2idrqxt77VkIlK4P3yzsPJcxcZK4OkRqKQpFeleW3ohMIjuP9pjDwaw1K4to3gKARNItTcPAjErhHZ9bPiwJs7JbFMDTYWHonCnANYiJuAC5AbVepDWl1f6YBMAu3QrXujzIN0S8OEiHZ14qwtBRX4up9puNtDA2hemO3GCAWMhhu/pQ5CfDR29VWEmjkDckibDXwb3g7obl2Ev8mHfx7kIggckMWtKW9DS2TECDkJJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jrci614GTuwEUvC7iLN55am6sqa7wHevcMP91NqPBI=;
 b=NSELGdh/+m03DpAVZSIlVBgnpYXIYTrpJqwlAq7j9BwpRuWjctFXuQBO4BIc5X2i707puujusnXhhNARWUUXHl7/+As8dkKB0bwUA+t4Mm2WHNq1m0jmNdgG8W16S5g+ppYiC4YySC6R9+75fLfxXKvfw+KWSaTGb0bGq5QjTFEcW84qJ2Z1RVa41kdC0mTgaY6VCxEXHu194EzBJ2lt2OWFJhwMI/72PfwI6d0HRQeFIlVqcGkGFWLsx7+QO+sYYudc6+UihQM3K9Uf+ggiYDGpdfqGn3PRXAsmN+bm+jFieT+0pbq8R1khpcgV7NxDFxO/XPPEgL/2/J4wiAgvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:49:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:49:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 5/7] mptcp: add bpf_mptcp_sched_ops
Date: Sun,  1 May 2022 21:48:48 +0800
Message-ID: <2ade81287c82a673c3e6f03d8700e8f77fcfc651.1651412613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651412613.git.geliang.tang@suse.com>
References: <cover.1651412613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a65e991-3fcf-4f9b-7387-08da2b79734f
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB62833E163380562DC4CD0BA8F8FE9@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v50MtcClWUUX1+AiuZnPkX+zGCZpsYq/ovunZ+PUjReeJJlUaF3826AnhIKTGpTqB7sqMjKbwGli+SoVYZsR1fhjpR8t4+oeOAssVZIT7fzKc9hmzrtnFcJCLvVuIv8kHepoogZh/+i6hht5VycgBuSaBlgxXlkeCsw+1clRKrWAKIh4/H+uCkcrzYlNDrJiJrJJK/FvsxMh8L+JV0+0ScIJ0Pr2OLSNRK6NL8dZZR5EGyxJ8HYnMHa2Nz0IXVcIT/xDZvvYVDuH0aIMuD7crYB3DqJ5QXBhmiLdplU0pllPqYaiVpFdRbQlSvqbV+JbUXtvVXkexxihv6tc5P4VYlqWFcC2E+KcpdjCt2uaBkiOKvnXqD9icjpFCDhvPMG8zq2Tdk3763jzoQUq/TlBJU6Gjej95HgF38EaYvrv97P/essLIr5C/AbNJsYRQtCvZedvWw267AdbNTeg3R8WG7pJcQ87yay/zFDowNnopAfpxLLBChr0bIgRvcN9z7ympZi9phPwYoluC7NipQUhYWwwEQaJABj8z5DbrYyRpoQofCL+qsp/Rtvrw1AGR4N+6+C5iBevaeeeMNbUE28DyEndoR1+PjQdKNRHmQpoUtEQ8MBwvGkIvNE4NUGE6zGaOZZNTwCULwTGXzNX9DzeMurkxuMoPps9rGlhgmGbGuBNtZZATkKlXVihhlQiyrlMBUaYzDiCMCkq5VKjgP958Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(5660300002)(186003)(26005)(2616005)(316002)(4326008)(66476007)(66946007)(8676002)(66556008)(6506007)(2906002)(107886003)(86362001)(38100700002)(8936002)(6916009)(44832011)(36756003)(6486002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?11hzho19Q4Dv/ZwahSr+9Yiyb7yw08DPeJ+xMZlJgMVhMTHdh6RzRedPa1BT?=
 =?us-ascii?Q?7YeN1S9wgIT7FtaCY+tetzryBmbBZELImdiEYaxrsnRCjh68BQ75mnWG7z9C?=
 =?us-ascii?Q?h99AZY7LzCG9BVk8wKsgBKx4D8jR58nQyc+2lbKAULZuktkPkxDOL9onAXCg?=
 =?us-ascii?Q?9vbmzUAAz4AQQTfPKibskOINgu3mEioS+SuvfRSjEbWc5tp7GaGe6UR/vq0r?=
 =?us-ascii?Q?6VJw7rGkAou+a1qych5LlUiqTaDJzQU0eJItmbF59RuRwRUZg90AC9wj/ORy?=
 =?us-ascii?Q?hSz0WWqsg5oOcZ532/U0D2zo6dK7LDKVJG3Ypc0+3O3Xjygs4PPaFUFZU8OZ?=
 =?us-ascii?Q?Z3ZWpRstVvD8YASzFm+PpZTqE+EH3gCOgiXRCTWUurBlWTAhJQKML452eq+n?=
 =?us-ascii?Q?hsMmsEivWSsb+oe2nxJ0st8g3hVS2mzPMhuUjIF+1G6DUlUzkM0ZnWAE6RIk?=
 =?us-ascii?Q?C2CMCOfs74w3qp7rpaADjxoaYvYO2RTVAyDc/qmv3IDMMoWAHgD8e1t5z/aU?=
 =?us-ascii?Q?TayyNi416oD0sv9DzLy6uaYlioz1c+sZkZv0Sw4+IxUhbAIQVpUiceJMLft5?=
 =?us-ascii?Q?lSROb0L1lrKtJ57nLqglEtpIjCHDfuS+LqHMjWXvMyOosQIxnUq95nOfNHDL?=
 =?us-ascii?Q?DWVFngNIB4vqDqIYTrM1pizb6W555IngBVCBVs0dmCC4Kikv1gjiU/cVN2wG?=
 =?us-ascii?Q?IoHoEi6LFk3YqS7t77clVjHq8qaDOaw6/30VhDnq+QcQcZZ+BDzQRP43Y5RW?=
 =?us-ascii?Q?E2uz1hBOvjwlOeB1crMBBKRjuyMlABRHYJX6qC4GybE1uv+IOUnqJLS2D0px?=
 =?us-ascii?Q?GtX5Fx1DxV+GVVsHjvgowZN1CkIDiW18Bg49OW2XEVQXZdAmpUyTHQLAKP6m?=
 =?us-ascii?Q?MSr962pQqAv7EftldO7YR8BlaXOdQd/mMFr6ytzuIVtBOr/qAb/ihvYuDp1y?=
 =?us-ascii?Q?bdt1ObVU5n5kHItFsfrDsYplM7PYj9sWlomGhE9HsND1U0Rnfnk9oWHv9bbU?=
 =?us-ascii?Q?2n9UFJ1eyGVAdEpEoK4XQGYGZZPYkzCsh+TfZbjrEaX8mwn00YUeljWi83sM?=
 =?us-ascii?Q?svcCHsderxmr9Ud4HIAXYRbxXDyQanh/pKKMb6ZPdidC/7La5YWx5c9YBrYF?=
 =?us-ascii?Q?TDhs3HHEHWIxYIvixnlufT6AF5U73zf3HqPzOT2YGoQ3ywnn8HodoUfuT9tK?=
 =?us-ascii?Q?3rEqa8xnnPCJNhMQ4NqRKuWCEaXaFc55V5Mb1FLIuuBi1974m1sJ3g3DeFF6?=
 =?us-ascii?Q?UufyuDVIR9rDVVVK0GfRIDLdqcr/iIg/GHy7ig/SVmmmJ0zBOLkxt9wRjRoD?=
 =?us-ascii?Q?pYreeMmunZq1NKqBqzCl3+mkAS/8MtZ71n0Qx6VFAVkHMAS9jhtEAUmmgVKA?=
 =?us-ascii?Q?9Qam/avnyGExeLHQquQrBIsRlf56koA3PEHEeQPmw+J3WN5uFt6I7XrHk7eP?=
 =?us-ascii?Q?ViWQAn/Z/xXmD6YfOuYRDsm171rnjKfMd9Llce10ypPM4CtJKy++ZOuRE2z9?=
 =?us-ascii?Q?KPMfuzEMYmNUEsUQtR8AlGFkkq1l5XrA8+MVj196ZY/uJ9B8seMUFuQJCw6o?=
 =?us-ascii?Q?yHkjnMlcm6m7UOyQktsu8tJtBTbmITcKeXbpj7QmyipkoWYKwdyrptul7eJp?=
 =?us-ascii?Q?4F9WPdqUGG/F4XwZtuFGGANBziqvB49noSdd90cL7uHdjrGaBUFSugophvMA?=
 =?us-ascii?Q?oQPa0OGKyT1GKcn92nRHNL8Fhi9Ip2moJZPh5nBhO2/8Lqyb+xp/soPP0rAf?=
 =?us-ascii?Q?y9aAL9xfV8A4FY1YgckXxo9ZLNTIjMQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a65e991-3fcf-4f9b-7387-08da2b79734f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:49:45.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeJrjgKXEIIu2iRKOzUY8l5OCzQYJs4BB9jmzwnBlMIxBK7K/K3SWWghGm9reR1X5+9UM+VIgi+A+t7nSqZrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 +
 net/mptcp/bpf.c                   | 154 ++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_=
types.h
index 5678a9ddf817..5a6b0c0d8d3d 100644
--- a/kernel/bpf/bpf_struct_ops_types.h
+++ b/kernel/bpf/bpf_struct_ops_types.h
@@ -8,5 +8,9 @@ BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
 #ifdef CONFIG_INET
 #include <net/tcp.h>
 BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
+#ifdef CONFIG_MPTCP
+#include <net/mptcp.h>
+BPF_STRUCT_OPS_TYPE(mptcp_sched_ops)
+#endif
 #endif
 #endif
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 535602ba2582..ad770deb5a72 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,8 +10,162 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
=20
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
 #include "protocol.h"
=20
+#ifdef CONFIG_BPF_JIT
+extern struct bpf_struct_ops bpf_mptcp_sched_ops;
+extern struct btf *btf_vmlinux;
+static const struct btf_type *mptcp_sched_type __read_mostly;
+static u32 mptcp_sched_id;
+
+static u32 optional_ops[] =3D {
+	offsetof(struct mptcp_sched_ops, init),
+	offsetof(struct mptcp_sched_ops, release),
+	offsetof(struct mptcp_sched_ops, get_subflow),
+};
+
+static const struct bpf_func_proto *
+bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
+			       const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id);
+}
+
+static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
+					     const struct btf *btf,
+					     const struct btf_type *t, int off,
+					     int size, enum bpf_access_type atype,
+					     u32 *next_btf_id,
+					     enum bpf_type_flag *flag)
+{
+	size_t end;
+
+	if (atype =3D=3D BPF_READ)
+		return btf_struct_access(log, btf, t, off, size, atype,
+					 next_btf_id, flag);
+
+	if (t !=3D mptcp_sched_type) {
+		bpf_log(log, "only access to mptcp_sched_data is supported\n");
+		return -EACCES;
+	}
+
+	switch (off) {
+	case offsetof(struct mptcp_sched_data, sock):
+		end =3D offsetofend(struct mptcp_sched_data, sock);
+		break;
+	case offsetof(struct mptcp_sched_data, call_again):
+		end =3D offsetofend(struct mptcp_sched_data, call_again);
+		break;
+	default:
+		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at =
%zu",
+			off, size, end);
+		return -EACCES;
+	}
+
+	return NOT_INIT;
+}
+
+static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops =3D {
+	.get_func_proto		=3D bpf_mptcp_sched_get_func_proto,
+	.is_valid_access	=3D bpf_tracing_btf_ctx_access,
+	.btf_struct_access	=3D bpf_mptcp_sched_btf_struct_access,
+};
+
+static int bpf_mptcp_sched_reg(void *kdata)
+{
+	return mptcp_register_scheduler(kdata);
+}
+
+static void bpf_mptcp_sched_unreg(void *kdata)
+{
+	mptcp_unregister_scheduler(kdata);
+}
+
+static int bpf_mptcp_sched_check_member(const struct btf_type *t,
+					const struct btf_member *member)
+{
+	return 0;
+}
+
+static bool is_optional(u32 member_offset)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(optional_ops); i++) {
+		if (member_offset =3D=3D optional_ops[i])
+			return true;
+	}
+
+	return false;
+}
+
+static int bpf_mptcp_sched_init_member(const struct btf_type *t,
+				       const struct btf_member *member,
+				       void *kdata, const void *udata)
+{
+	const struct mptcp_sched_ops *usched;
+	struct mptcp_sched_ops *sched;
+	int prog_fd;
+	u32 moff;
+
+	usched =3D (const struct mptcp_sched_ops *)udata;
+	sched =3D (struct mptcp_sched_ops *)kdata;
+
+	moff =3D __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct mptcp_sched_ops, name):
+		if (bpf_obj_name_cpy(sched->name, usched->name,
+				     sizeof(sched->name)) <=3D 0)
+			return -EINVAL;
+		if (mptcp_sched_find(usched->name))
+			return -EEXIST;
+		return 1;
+	}
+
+	if (!btf_type_resolve_func_ptr(btf_vmlinux, member->type, NULL))
+		return 0;
+
+	/* Ensure bpf_prog is provided for compulsory func ptr */
+	prog_fd =3D (int)(*(unsigned long *)(udata + moff));
+	if (!prog_fd && !is_optional(moff))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bpf_mptcp_sched_init(struct btf *btf)
+{
+	s32 type_id;
+
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_sched_id =3D type_id;
+	mptcp_sched_type =3D btf_type_by_id(btf, mptcp_sched_id);
+
+	return 0;
+}
+
+struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
+	.verifier_ops	=3D &bpf_mptcp_sched_verifier_ops,
+	.reg		=3D bpf_mptcp_sched_reg,
+	.unreg		=3D bpf_mptcp_sched_unreg,
+	.check_member	=3D bpf_mptcp_sched_check_member,
+	.init_member	=3D bpf_mptcp_sched_init_member,
+	.init		=3D bpf_mptcp_sched_init,
+	.name		=3D "mptcp_sched_ops",
+};
+#endif /* CONFIG_BPF_JIT */
+
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
 	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
--=20
2.34.1


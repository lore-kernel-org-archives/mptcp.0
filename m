Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DD7B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 05:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651123441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XUaqkaLV9dssjVhaNabkHHBXZGLvOQ0xODMALR+WY8=;
	b=U9GgI4ZVFdpIP5RXYWZcN55MY5D0CKy5vPulzCJIOjQAnv2wGpcNu04q7i77QxjoD9Uuna
	guF9ZtCKe16Nq67ZBkeh2p8hvRNJ2sL2xwbR9U2wce9pD6Sm9vg9eHs9moM7cmcTFpjO8w
	4GFDsrpLisgKskxRdDT//ZnUtwUzKis=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-4hTNS4n1MnqAc8b_doGJNQ-1; Thu, 28 Apr 2022 07:24:00 +0200
X-MC-Unique: 4hTNS4n1MnqAc8b_doGJNQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmHvj3Mzw1voFjj5+cSm4fGsfTjpMhddhTCMq/u9K9wo5uoENToG2gtjgdEczIbwyL/3sS/dFt+X/YnQO5ub77xu99CEN+o30S+Uuga1EnZO7GQp0snUcXXeQMDl8fH+oDIHpyNi0eDgLcsrGXumHjLHiYyLOTEdg4kFQXO/nS7ym4HwHB4q6cLv+nRCCWheMPjE5e0izCCw5G4PbSpSz0dICkkb7OGAJj+qH6owgUVQBAlYdJVZqoWZ8e+LL0TTJ6AS9FyBnXzahd2g2ZzBfMxNoBhOknXrvjP4F4R4esNsMy9b6sB9/K4q0yp6e8nnn19Q+e92F8JyODN75gWU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcjvrzqE7oE277VLeXMPk4vh1SUz28rwGb4o5sigZXE=;
 b=gWs7EIBxesHCDk3CRkh1Djpgo6yv6PA7NpcmHKJHzxZYUFm31VX1nzwgZ5su19MRbUPVZJZuUFJUzxN69nNxWIeBK3ZKHILHKpOIbiEKoECpbunLz+2LANkV5FUPZjZEwGgzlgJhWzJBR6hiMCSJi1waSCBSoWLzCzMaNddU3ciWMd1NqjryQMFAOpQ6P63gAM7rcfjzaZ1b2HsOSNQ7L+nsxWIg2EFA6zwJW18WPIenFYfpyAz/sLZK5RbRnFFh3mfw1Cj/WEaGkt/UUpiUs7je/gQizdRRGJVJpjAXp9ZZWfdb85XfWOyFfPCF35WQOthk7BJNYfyK6sNkStFYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7422.eurprd04.prod.outlook.com (2603:10a6:800:1af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 05:23:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:23:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 5/8] mptcp: add bpf_mptcp_sched_ops
Date: Thu, 28 Apr 2022 13:23:32 +0800
Message-ID: <1209dce7d8a44586c9348a5029b8e12f1e3df68f.1651123078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651123078.git.geliang.tang@suse.com>
References: <cover.1651123078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07cb4b28-452a-4da0-ef04-08da28d74b35
X-MS-TrafficTypeDiagnostic: VE1PR04MB7422:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB74227B6CDFC990400129E382F8FD9@VE1PR04MB7422.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1LdlbWeKuw6ych4VqRi83/tc2knigAdiG3NaGFO6/QdZx0GAw8ajh5vZtSVmS1xMwTZtCz77M8UkOibjY7gNDwjvdFxQaiJDzsU/2mxPMe/Be1voxIorZdSHt85S0/Nr0MHrMXhGBg7nNLwJJjSPFwNfMyTwNLZ4RYOKPEcXo26kMsXu9f5JogAgZARMAdWmTVpc+IcySaium9kv2HE8MkogRpdOn2qPkI/+2NUxKarDXMEOi8D5RlKwQsSVbeT89ihOfxp1RW+TVvDL+15WQVcMrXnebuBKC94pBAQ7yDSBCpswretSSnNl0QT0bN7tBjUpSeNxeSgfVzKgrqTDff2EcV1+SZaP6QE5uoAPfbstEpfWZRK3SCfivhuR0r81DqjGarvFozsX1m/Izq/Bzyc6S4n78C5nvX4G1KvvK58usaW4nqxjA6CbhEl+ByGQHlV15DbAgm4uJrL+Lm6/J9EIyGLQP3oEHGOX6VIbCphUhhpx77VhMeAzrAyFYb8NwqkFB2XhjEbZ292Xh2YtyEfhHYpsQGrj6XEe/N9GE9Fkgd/bWEZinR0MJV/1MI+4T3ehZ6zWFSPk47KXdwkB+/bkRoZnpCJF7/6/Sg8VXmoSGC4V3mqgatFPlhOoPLANgTR0d4f05swWBNA8sUep5FksBsr4r+AxvkdsmczNFq3f4jm/lQ3Ks8sv0dDS/2SUp4O3qSgQZLKEjqfmMhdYOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(316002)(6512007)(4326008)(26005)(2616005)(86362001)(6486002)(508600001)(5660300002)(6916009)(107886003)(38100700002)(8936002)(6506007)(6666004)(36756003)(186003)(83380400001)(8676002)(66476007)(66556008)(2906002)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BL16bnddThDOA3AiD7V0CagixoddEdj1U22JfeddGvR1SWRABVldD2LHLUct?=
 =?us-ascii?Q?XmSzOQg+kaZhi6Of3aAczakeRR7vEwCS6nN4MoxcePIgrdaz725Z/6DW3qFO?=
 =?us-ascii?Q?VEBDFtJOOjpth/huLifzuUyFS86xg07tOC84NrGL1BI8N97pUYL3HzV/b1bF?=
 =?us-ascii?Q?lKKYG+0FtIH0l1W+hgifkfmb09B0b/lGcN3G+KV2loJdAOVomNNGQ2tUXtp1?=
 =?us-ascii?Q?UUz4X09DjOHTEP4X4U1CwsEhTLyITjahpSCCc1opdSBYqCJMZ8Sp3VTr5B9F?=
 =?us-ascii?Q?6QnWTX+25B6lqkK85/cJ+HCHNAWHN4p8cjBrmW6VLfo1OhnEA3g2By7iaemh?=
 =?us-ascii?Q?ilv+wKOy3LTwCk+Fp4U1HK6/nTIJNI6qXbPmSwVyWMMQeNvGGVHX2mk+cVLF?=
 =?us-ascii?Q?XmrhKMmdp6dr5HVb1mJ8goouy1h6DGVG2GQ8KjAYLO4ioX05sSFfKdFLCXfl?=
 =?us-ascii?Q?auDkoHb63QBq56jCbx+S7+4ywd/iZE/OLNE3aDxlAMgUXeqpFk2dfi9tEn5z?=
 =?us-ascii?Q?8nI8QmZQRb2o9vzmMiV8i/tvGBWxZc9678FNODcFs6jRRBZbVQDCxQElo8f+?=
 =?us-ascii?Q?sBUXT5nz0YVuu/2Tz3kV2HEEOHMsRIM1ZdxSBoThk2Lqr3b8Hmojv4khzL71?=
 =?us-ascii?Q?TW/ndzz+MOWEDo4NrsOW9wlxzGcqacUOvJ/2dyyK7+VgCcB2BPvWc7JKeXwp?=
 =?us-ascii?Q?twRmH7EEybAkWwTlerwNARt81ei+0G53wH5+9f7mvYQ8dENe9IzBLQsJeFsm?=
 =?us-ascii?Q?ZVHufPQ6QrMTbffefFvmLaBUYMRc2MpX9x7vPmTRgfOPG3HeMoVHZgAwGRzv?=
 =?us-ascii?Q?D3DHeWY0ntr5zrA01aMGuODzE7ZT6/qh8BVLp22myRcwURIE2SiaDAeWgYn/?=
 =?us-ascii?Q?q2YSYNRk5xhOT/m/BPvkpUlqdSDcYsxQFvgOszjfEpHHVlxnhiE6QXbbGFqI?=
 =?us-ascii?Q?ZLEKAoo9WhHAgjlSpqx8BgcA93FQ+apHSmevLsizE//TQajx/AP9mazF3GDk?=
 =?us-ascii?Q?Vdo52o6AaypYEjb/H30868ScYfAenwPwTQCr9HfedLe3vVZTR9tS/zv1Rzvd?=
 =?us-ascii?Q?cDMEBQ6sfbEu1NSOzQLmgUm/q/6hs5eXcJglJQIHJGsDIUJ4wfvtwxlrt73j?=
 =?us-ascii?Q?u8AMryw8C6ymu65K14Ufkp79SunSkM1zV0FkYtSYpoO+PU+JCDZs12frlFYl?=
 =?us-ascii?Q?YciIIgarXuvqa/a2u2scLY/9YcIBNAAEsCbe277audEtOFVgmf0ARgApNbCD?=
 =?us-ascii?Q?1WLxDxmvWRVmASIb69476kC8k4cXw/9TCfnd/eeU9hYLJZbAUvulanWvhGDe?=
 =?us-ascii?Q?7uJfql1m8EszLjOCEY21IiqICq+y4nwBW2bRagxXtOanHixwMaz3HIzDG3X5?=
 =?us-ascii?Q?bsSNzSr7lTCwcZGwtkhtggv58Nc1dhzQ0pl1LFHnLOeyDpoM9HoxactxGwRk?=
 =?us-ascii?Q?Myx5C/eViGFZ7Usr+K7loh5B2m5aKdJrsB6bc2/DylSibGMyWJjB1TZAWsoO?=
 =?us-ascii?Q?z2ifOhPsHDp165nsP6xJ2J186JN8KomWjE8heqdNN9YauXpdQlRusag83LZM?=
 =?us-ascii?Q?mRl+WK1YKHjar235UxDqbuG/RcQ4RJZ3JNY8t4OMSYoQWk/yAj5gdBf26zbZ?=
 =?us-ascii?Q?eTpfdCPSp/9YlOYLrOUD5p/eo9zrPGZgcf+zVPa+N0d7ojnW8RTjgOPJ3ahV?=
 =?us-ascii?Q?BAdTvhSCBGrgeXbuXBvTSxcFjHrehG5K6RCuk0Nv5bkfGqvwQl5/IzXtcKP2?=
 =?us-ascii?Q?PGOShZspYXWgyKi4FtlCdo0T7C3dbqA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cb4b28-452a-4da0-ef04-08da28d74b35
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:23:57.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ+pBbcQieYvP0BbeJi2FnAqFOb55oPy6uw2EAeiNoW+wHHe7q5r0EKYqtb/XOJ+S8S+4X6prDQ999RTlbZL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7422

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
index 535602ba2582..a085c72fe695 100644
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
+		bpf_log(log, "only access to mptcp_sched is supported\n");
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
+		bpf_log(log, "no write support to mptcp_sched at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log, "access beyond mptcp_sched at off %u size %u ended at %zu",
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


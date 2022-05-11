Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BD15B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wN0KjzJM9Ev/2k5zp049T/Kc3dOdK+O2RKGqo4NrXVw=;
	b=Qhp0wF12hbsAekSvXUK6hZStaZ1O5i1mG/0x8Gr7tE0tBixjMfYBsLf4/x+6Hst/tcEott
	lyIfblJYLbq41EnmMZsQw6ZA9q1lTpL2oZftcQhM3MBxi1MPOCNXBGcZ9nZit2pCXl7tzp
	NqrJzNgQRq9jBtEol41zBFaRMJyFLjc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-whxVqwckPCKVI4bIHL6Img-1; Wed, 11 May 2022 05:41:08 +0200
X-MC-Unique: whxVqwckPCKVI4bIHL6Img-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNbS2xpGlxWFhs5dOvktCWatWNcUX+mq7lU4pHRSeMzo9wx+AyC8WyRQrbk8M6Wnb66csbv6jUKZIN8EjskBU8lOrUMNwte3OPiuDwnSBMwrlV6TM+WuhWeLqwbWGMHNbY7u0cxt23XO3EkAaLdY8auZf01WEozOsSvmTuAiLJSk6/sqBJra2HrtfVsRQAm/2LqZcMkujZg4jb9pepoJNquQEubD8qqpBdF7hzJ4b2evI/5OmlmJqtFxG33yG/sS54ilNApo4IMBFHC1Vje8TAvvQ3hFoiD0lbRx3Z6X6K9OLHbVIXPlJ+AklxlF0l5PabkDGM4hYiSUvDDLIqjLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfatK8xf2UjGyo9mADrgza71Y9wgPq69zv3wfKdrO3w=;
 b=Zj56SE/hpZiMu8qN7pOBDxIV891sLskdE/ziQHzUR4Ml/H4yCMAi/BfgaV624qpy9K2qNTKau6gq72OnJZ+ADJ8j42KvlMkUmF8RMkmUH/c06S/wwu20sS/foOvNaRZEMeRaEY2jO80yQSuxkDXh8pelPqaVZfG4e/iWkywNDFvWt/5htAHRBrsP9bUAzBNcthzRxZe6wwjoDGTbr4kDU69ybM2CGdQgG8yqV8KDuOUP+ySio8bW2mhvFEeioigm0pWHg8PG8wh4iBZb+vJs1abddO47xxqPm4YZmDLvvHO0fXP+FOzohjPVvExJ5p7QP8rylzCh55MpBjjMBP3KVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:41:08 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:41:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 13/15] mptcp: add bpf_mptcp_sched_ops
Date: Wed, 11 May 2022 11:39:14 +0800
Message-ID: <41774e8612c969c3f8490f85765df5fefa480f12.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a031f0ff-faf8-4337-1296-08da33001561
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7156CC289A1ABCBE4F2BE178F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7lfXb+etMZcAov+tKvUDLZFv/iN2T0azs3WnG50zQjjNAqRTh47+nCxbUzt19/qFjigfyMOw2+ru6r7jpam3womrkQetdpMSGkRcWBvjYx73X6nIrFu4817AnEX2S3fBV14POYMu/xZ8vi22WxGhFLI6uSayQskMwT14ejVxkf7xJTjqZBsT2AkLDXY4M5TX0wBru4IFYUWsvzhO/PmboabdMC0ZXIY7UgOFnv/S7CFZoZLBFMRkCgeKP39pWp079aWrVOpBbAgeDVKv1iPO/4sZ/EhJFKEx2tIrvIwkt84+P4JpZZfzbDPFWJYDykm3o9pHRUlKRxjQrkt1K/KTpOILkA1fSQMRoLDu+cS7Xbe9v6DUagDUV+SZ9AhebY0PdbuPKKBthAnR4ihZXOgBR3tfPxonu2gNSx9EJYR0d0LEacU1A4fz0qjkashVqu1s5V0E6rPiV+D5+8qq2jMlqginojagb/7Fog5d05mTkLTIaBna6hrbnDq0jg99Eqwq86vXCdye58gPVdAKMMUVyAtVLd1KXT9ycmo2STHYee/5c7x6JizcfBA1/I8KTtZahGlKu4meIsoRz6MnghoEwrzgzuNbeowwuNwT7E3YTVLrgyw8L7y4NcQeSbx++JZhrxWkQmhnIaX1ca982nME2kkR01SQpbJmq+jlo1/sSOJ8M3F/M7up/jZAfIVKH2xnQrS1PciGpBmFK4OJV3vTEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W0PYxGArAZeeWLHINQSDgJxN63rxk8Z06+witvRi2kxoVBNNyGicR+iDRxTu?=
 =?us-ascii?Q?9joDlGP+HdXiVBBBWjPCFA2i50ztwHYKyOBkqgLyuuDDvEU0kVkxHJX6W9ko?=
 =?us-ascii?Q?exHLnOSILBS2l8bBAieUQAD6DU5+cfLBVaUuzV/ORd7Dvpt+RuD0wt4ZXuZD?=
 =?us-ascii?Q?6s203JIuUhtChhMUZpumAf6ss2aPwTxRAG50VGN55x9h5pbYsbI2tZ/ZZh7z?=
 =?us-ascii?Q?nAite9aIrzcXMPrB33cmeO1KzuyYqQ6o1k3qp30nZnvqv/VM5cDRHjlqqSCx?=
 =?us-ascii?Q?rmG5xxvFVYLhHxOCAwT0/UzIoOUJfNbTyDV0b9Ox6eVAs7o86I2XpHKpc0RO?=
 =?us-ascii?Q?aPOrYsVREPVl9V8afeljV9K1T1tqL0h0Jr2X6Kqr/e6pmHeP0p5jVl8vqGYj?=
 =?us-ascii?Q?4zFUV+2dS9aKFMimhY7kXwmgSvMJUDgpy/m3wMByMrSB01jaz4G94AVmcHnp?=
 =?us-ascii?Q?CRVln8Hq+rBPscsxsT/N2Bd3dLA5ed5XPgOcMs2uljzSQm/05ydC/8uOckyt?=
 =?us-ascii?Q?F+HsiTY07a5AVg52xHBf+Y3bu1r2+Q4/2IZK7MD731gNhmIH8ACAr+41Y4Aq?=
 =?us-ascii?Q?KVHm7xHYH8ij5fH7Y8niKMKEGitnkaXo/lrDjKsJmffuK9B+tbxruuJfWg9V?=
 =?us-ascii?Q?st4CX/aHErgCqFwNahOo5notM78BRX4mSs3Yp4MkWpGOw80Px2aRvV36zPK9?=
 =?us-ascii?Q?VyekbHGiXZuPDv39C2gxLHCNiLhzI3fXcX9NK60yutRUyout7JFfxDQSp/k6?=
 =?us-ascii?Q?wQ7zQx8ygESXrKWNLYqEPze33n7giIa9PjTT7miPriZCmq2MwF4/jvQC7x1r?=
 =?us-ascii?Q?xjkz2c1o8mZZ9EqkKosv1R7LDDSmrbyGqqVNUN3Iq9NIYj9sMkguoY5JN/eN?=
 =?us-ascii?Q?+IQRBl3vHu2Yof/zGAIeISkIBhNAtatOjURWqgqkD922NbmvANn3+nEksunr?=
 =?us-ascii?Q?+Q08RHFS2LzCmZiCEAFDNUiuK7QK76rJu2KAuApv0IjL8mLQavV2mfIs6+0E?=
 =?us-ascii?Q?HfruSpoYXbvcfRAUCYyFBi0QRP/PGoNAAaX1XJYwwaKTUEq5f1NF0R6ZBe1B?=
 =?us-ascii?Q?GsFC33DdrwWC5yLTFWSiUABJFet97+syQ5oXbuF2MtvXSAyT/qZ0emfle+1J?=
 =?us-ascii?Q?9FwbHUjIQpwu8q4OHysBZB/yj1g90NfwaWYFh+4/Q2HzUv/GN8o29jTVNj+a?=
 =?us-ascii?Q?JFzBJrAavDDLGcWxgxYBfX10bBm6yWAngOHycQLlzzlrW3loxPRBR+uw6nz5?=
 =?us-ascii?Q?lY0pWQiO04keCTL5rF2qyFMmpUy+VMQV1D9TYdDAhUud0tHVltXictnh3CkG?=
 =?us-ascii?Q?wZHtKsRICTCrKc/Ct4vD0p+LWJs5hKQi1te7WBFiN0FCfBk94/yBV6f/pC9+?=
 =?us-ascii?Q?GOgvy23VHMdCMw96HIytIszW9nHWmXf1JtBhm/07cGVyHpyAaZ91dC2BHeIK?=
 =?us-ascii?Q?GMJmOoLoRwp4nrz8MLImawbZuAfNOYtAPteq1rGxI7aHDNM2TNlONGx2gz5/?=
 =?us-ascii?Q?8Ic4U0brio0ObDxh/rG32Hh+wyk5hSiJhf6Y3G7/BcChCp6WrIBbocBzkgU4?=
 =?us-ascii?Q?8VirMVIheUpXVtRuH5vFYYhMVgNoH9DerM4moTP+zT7JRyvYkKZlpt/0ffM3?=
 =?us-ascii?Q?huwt5XtpLQzbDYJUSxxm28bviGIwdzjqsHOeYY+tMb7UI3XFEhIGs7lKf2Gx?=
 =?us-ascii?Q?fj6//2jP8T0byMyj8+XZkf1mlnr/vz+WeF9Ho47F+hMETZZS0jUmQFF0RtMQ?=
 =?us-ascii?Q?/84qhfAfTpWJv8HHrgP64pPW2HhEdsk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a031f0ff-faf8-4337-1296-08da33001561
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:41:08.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yBbhFUBZY8i3UpZefkzHv2OIlRAmgZgwoClNsFV1VRWCAQZX49asTE8tcEdUGlPV+F0+ajUvZfSX6a7rXsb5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 +
 net/mptcp/bpf.c                   | 153 ++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

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
index 535602ba2582..b7cde38f7a6b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,8 +10,161 @@
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


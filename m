Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7415B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wN0KjzJM9Ev/2k5zp049T/Kc3dOdK+O2RKGqo4NrXVw=;
	b=OXga1KyTO5+0Julz6vnpn2llsUM03jv5etVnBV/yIzMjAEXDVNb8M3CHA453RaA0gRAwaY
	hEIayAP2e65Rnb1glCHfpchEMU7/lJdNvRvj5s5060Y/HWSa52FRFzxd82/+L9bhrG47im
	6ZNFRoHTlunaPrOuU3JEzQYY75ECqJk=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-_IMoxOLkOYuQfMUV29X49w-1; Wed, 11 May 2022 09:57:43 +0200
X-MC-Unique: _IMoxOLkOYuQfMUV29X49w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYlwnzDyzCk6pSy4rhqNNBGxsZlbIMTdsRiNESSi2sTv27MNdhqp4aUQFCnJZMxmLmCg2JvAm5JyFtP3hwS2ckrIrlDkr5ujXfammEWIsqIZgpvJtSPO4ab7khw4obSzU/LpGRoA5CmssKY2aw8izvtMqpJm1nqQDkvS1AF6s5Ajjv7HtHTEQ7iaztA0w6zX+qwWB3qF9h8c23mBbB/DBFS8sQtf7V17GmRlNMoz2wSLR5sbjRDsS3KGrfZk/Au+F8x26lECDbYz8VO99ZRiQMv5eJ5fOgNBPivTl22FogtBww3aZSmpgkomOKB6aq3SEznHUAeBUMxrkNsX/PbMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfatK8xf2UjGyo9mADrgza71Y9wgPq69zv3wfKdrO3w=;
 b=mKwd6mJAWH+WbWZW8pbSqfIS5TtCv0gFjkboAK2sOmSht3qq93Cl3Pb6dRh/IaSDDP36MrgmkcjP30PMoAahjsOSOSMG0CyLb8eLK0ldvY/Kv1SnU5WTkwX2iIj56e0eampZ8+C5QZvjoI78ZayNPOirYVe+y36IGvt8CT7XWX2W9rShfPXFnk269vR92lTZWiEWjyR7lVQLpjHIXAi9+VEDIQCRS6vZtlRUiOlmEVgCxE8v2UNyeptK5ZSvT5KqQfCU/fcYT5Wviv+G18JabrYDMxeso03XuV+f8jDHpluM2tc4hkQcWsn9VjytEp/zP9m+SlqdcBoAByWV+u2DHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR0401MB2653.eurprd04.prod.outlook.com (2603:10a6:800:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:57:41 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:57:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 12/14] mptcp: add bpf_mptcp_sched_ops
Date: Wed, 11 May 2022 15:56:18 +0800
Message-ID: <b3de3ea047e6719442938c73cad6d55dbf697afd.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f91f1f75-018c-4583-2e71-08da3323ecd1
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2653:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB265399092CD2FBB191887C5BF8C89@VI1PR0401MB2653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xsdMAD+cVZvbkP+ikzvTV/KKqhhlWzBzBhjW2vtexJbOSCQE4/oXiQgS0wZn/EMvCcLg0+1i6IXtpCkRW+Eu7g1WHiG8Xuz0Cpy9LQwdHwseuJ/4swVP2wlZphqFETNA1rKV2WIXnVjC0YDjUNXCwD4z87uJR+tCEjBaZWg+pKBAlM41/la6z0NknaXzklQ1bdwQqqKG+7kMHeAa8McWisM8T+TYV3s0Slk6d9SllXFmsF1zQJfPiJenUJ4F3zYo+EFfQZFJsaF46oowo8Ce77f6ODSP9n8mAC333cxDpewCjWVYHvu+WDJ0d0lyXWLWTXzKf41cfYlWvHfEsYRX1h+RmwGx1PJXm+/WKkAbEI9wyypT46yFJnIv4W1VlYkanypN6ozVyLoAxPngeCr+Ehr0PrDpHsZ4dX1OJZ7TMB9uqg/HV/QfwxVqwTqqHDh5a6/6VnxjpVntHirf/0OzbNq+Izlx7Eow1q5zWq4R61L+9yFLb3SeCYclqvDRd5V4qZaZbRY8Lz+/9MPv0ehxu/Nt1Q95OfwCh7sBE5PMklRXez+0GpsWy62TDgwLzYQIBH9HyzjZyP0okUssegIOa60pB90f0s8riFaBQIPiXot0RcpnRuMYGNG4uPSdZpjJtR7B3WfMdMJmbU3aeL8AKIsoCjOL0qlHxy2JWbr4ncecLfoR6T4stVUmsvw3CrNXGeADkPQktWlrYyS9j0ZwXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(66476007)(186003)(6512007)(86362001)(4326008)(8676002)(44832011)(36756003)(6506007)(26005)(2616005)(508600001)(6666004)(6486002)(316002)(6916009)(54906003)(83380400001)(2906002)(38100700002)(8936002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oAra1GKymB0J+cGNcdVBB/LNky6Y2RUgf9WcvAvNRtXbrhV8UoOhcxtfER4F?=
 =?us-ascii?Q?EUajn9j0Kre8l/Hyp9jCb1TbfjBWAN+yqVrkhiCh+RVfd8rX/ssPHDG53GyL?=
 =?us-ascii?Q?gylTRYak6tzob5i2qCEUZQIrx1BTSiJ/nnlRD//XVz/cmUng4tVpJN21iCDE?=
 =?us-ascii?Q?3fY2kr8wm2dqxDm0kdFuSxWH4NmLIrlDjdk0Rg1yBcsaNanbNZ57TbtwP1IO?=
 =?us-ascii?Q?57tQa0fKvZbq5h01fwtATKr2RQ/aqvvda4ATnMkLgBCPMFGtGtK+YKvAuwGm?=
 =?us-ascii?Q?Q0UzeI+mpmqEx/GsBXK7X3wDhyQT6feL/Mly4i58z3ZJkDlyUExBB2NYrpqO?=
 =?us-ascii?Q?bCrmIQqcCE/k5/3Dv+WFR2FqqOErY7kvZ1GOsNbeVsWWwEk+8EOt4G/gtvnu?=
 =?us-ascii?Q?yu13nH5EpifI9uA2cX321YyWTk2x7MWD/KurhB2YHISvsFtQZyzeob3dLYBk?=
 =?us-ascii?Q?AFg1floa/UVN1WTMjUN9++/8H2YeJTmhZCrEVca48uzSw+o2y+rO27wQsIIZ?=
 =?us-ascii?Q?IR3KlZh9vCimoF9oRW6YOwe+7/RQTBlm1yGSgmdyVupJ0YpYpVQ3+mj6k/YS?=
 =?us-ascii?Q?DdUCULmvudtbikaD2/jT0PJi38DzcL/0JBuOd3Cfl0wt0Cg8oRhG1RD96IUx?=
 =?us-ascii?Q?8KgKXJqNmUNuPPSd6TR+8g5/vg59DLIeBDcys7KP7/VyQDT8k4aRW0UHXKk+?=
 =?us-ascii?Q?yLtVhkpqopPYsdo4B90qkCT04x3aKxRRHcWvUxOEL34RUMCTFCjnpE85D6aF?=
 =?us-ascii?Q?QohlRmNo3+ktbPZz7FoHWkcw1kS+9QsMU460SG2DWXGxjV/KaBzCmDjs/1Us?=
 =?us-ascii?Q?xbM3hCPU7x4HXdnCcYyG9kW5BOE2YlsLsVG0HGR0GVZRKKcc3twd1aVBdk6x?=
 =?us-ascii?Q?+XZhjyR5zFzZF0LiWleHEI2AKvHhJ3KX39IuEQSM17UPnLN2QbrO+dUWyw7X?=
 =?us-ascii?Q?uKk8HrR8VhDglFbwO0/Vkxns/MJci0M/PiRvUqn3gS+06FF8Pvkgrpc2yv2H?=
 =?us-ascii?Q?0ZoLXCvVUChFEHVoKHXtXLhQU78Y8eSEPLqDjTIuco5p9I4HqwYZW748zbTW?=
 =?us-ascii?Q?1zkOcOkVqdRix2ZPkEhpfdYMWFVLyM9smPiTpMc3p6xVBFUY9szWmAqgRl4t?=
 =?us-ascii?Q?Kl4/N/7N7ja6A8cFvjArYvUla4JZeRW+IjWFNMGuvJamXrJZCrI7XI1PbfSn?=
 =?us-ascii?Q?HctvjAe2c2nDX5/Dkx9X0zCgS47hD7HgDvZ7gUZyCK9uR/CJXvMBDxIVqzYp?=
 =?us-ascii?Q?nWK2onMOguDwqBeH1LLLVCD35atQ5ZtapxjbTVkDIHmkj6ubrrD5fXIqfCqG?=
 =?us-ascii?Q?D/D1V2YhJ4PYjsgvTXSQbwQHe8fZ75IBa4Kh/m89FcHLBcNEnKjF0azqOR14?=
 =?us-ascii?Q?/i4k2dE/euiW4D0q846iy4vHLqfznsNL7HY7652ra/MjakKIlyUqF5pATUSM?=
 =?us-ascii?Q?ZQdBgq3BMPwfpAqiiHswEtvl77dJ6sLbaRJNSeFi4xg2Tgk5qO1YXnty6bIo?=
 =?us-ascii?Q?ozgtafbfNDbMZ4p2Qq13OMOwCUX93SV9ISju2jZ+5sWIgqW4iUtQaOcJdtRj?=
 =?us-ascii?Q?0BZCvikhpWoxGt8k2FvRw3SwBbSnMrGwXzb283Jw1xPbIlFetBbVeNAh1Kkg?=
 =?us-ascii?Q?lsWXMzKNAoba+72gl8CjiAHvNxZGJQ5Q7W0NmiK+QCFwe6FXz9BVzHIwUg4F?=
 =?us-ascii?Q?lqHu5ff0gNtU+Imd9qhIM8M7pVMX9CB48qTVVJjtDcOXJL2rLLqbUORWs13i?=
 =?us-ascii?Q?QISsJJI1iDyFqvA4sUgJe+5Gb92dUuw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91f1f75-018c-4583-2e71-08da3323ecd1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:57:41.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvhE6iwnbHXPhhAx3v9iICHit7c1s9dbOx1geqAD/kLj7hwaP1FFU1DfblZEWSIYddFKA7MqMVtpFNI5koMmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2653

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


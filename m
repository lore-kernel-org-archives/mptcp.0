Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245420EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hvgizazLSVqB/vatjqRkjg0r7EonKFUfE/VaWeXCr0=;
	b=KbUKsRNVR7IFOEjGh0RLOo1NwTME3xyTXVtmLBN8Z05j63MvoLCV76F7PsrrRigmeMdYfX
	814cwL1EyVXzjg8HXLJ/ENJcrpyxTmIT4SQAaEXdZ7VkJWbSZqk6EI+AggTAyI5KkYDoSj
	IR79qqGy8D7rrxrSEjDI/3gKyRzWa1s=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-k-MkVWj6MRapcb5Fitdr4A-1; Thu, 07 Apr 2022 06:04:14 +0200
X-MC-Unique: k-MkVWj6MRapcb5Fitdr4A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnR0BP3n2RI/WsVbq//q1gwOWOUhuS58al84dzOjCWTtKutyMDt+xlu8Dp3YuBcRrW8Ssgba0odptbt4upc67xrGJ1JT009znFL15lP5voyzPRtZK3QYGuFSNUNmUbZd1vOBF46i2MPxgKKPDGZG1DB3HUQ53CqA2kZ3AVfxgt+tDjf4eJNMAc/c8sZnFEAAviel6E95DDAWSvxMFv51c0agy/cn8HbDdaZM+IW7vmjZPaL+kBWBNhVB0Tn6di++BCEF2VWbn3oW1R5a2x5nl0VOT9gSoqZ0hg0tdKrgug1+YeX5iVEeXS82abDlWYC7GdHtjppIA7xSX3CY+DFMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/QGFqUTVH0QlTuFZqXcDHVQX6mvFPq1GybMAx2rAjk=;
 b=hMwLoG5uoQWTpHJtT0sWT4zVmSX979NebpraJNvbeg40StNF4vcTKeiOtu5uoYGIVAYG6RU7PGM2rL6mKq6J0fdBtOzIm1zwqf6qGJD+xJLUTldO8g18AY3Km8CrhffrG9kyEd+EvalQRYVOB+eO7SehPwrIm1NVJeRMVLFcx+ofIY39zu3GEAwGVtZlkSRf8SU8b1xjv8Frz+ANxz3sv9QmDIgKH+C/TJnHwDE50yOuJ4t5ZXYtOKg/Xeqh1H7iJXeqbLC9G/25HVgWOZg3qhGfiiUp5gugEs8Apdg+bhGr4P2Q1dkUTAHIdNFcF7nOqKjrykURyiqA5m68q06XfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3354.eurprd04.prod.outlook.com (2603:10a6:7:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 04:04:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:04:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Thu,  7 Apr 2022 12:03:18 +0800
Message-ID: <2d711ffb3e01fa3e88ed6f32f7c334387e8f98ba.1649303876.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649303876.git.geliang.tang@suse.com>
References: <cover.1649303876.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:404:14::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6d120f4-a3bf-4d78-f6af-08da184bac3c
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3354:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB33543C0A1EDACCCEB1648239F8E69@HE1PR0402MB3354.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cjgbeO9ABvLbYDSSRcD78YKLYVWMTF1cfvcyj2NQC1XgWqtwX29QspD6US1Zs6Oy6SPBXf8dHcuFDy/aeGphcmuw5JIepRBsd9slu8Cu26qFGCPu80fp1B6inMWsiueWstiqYx3L4TDU5cMHjOHCECQ4RHBkCkjtuCHR+TzlpV3AjLYsWXdE9vYX3Qtvu5MPYow2ymRViuIBvs73t5B/ueTx4aHh1Oc4WWPdSiUkH7lqHNBB1yXRi5LVzgnMiLpM2v8s+Vjwt/8maJbah0wbBHpK+dkbCP8u73x22bi8XySWZ1PAAMYjX/ns2kugFUdW3LZM/9FhgFmQmKvtzOMuJfO0H2rgPUU8TwfE54kSWTkXWqGkq+pWtiM8zZkyyKHgQnEjOISL7+eLQ/ZiKVuqz43gzBXmhRDumcooo16R1cMfHNahe5xqLpRzHh+ghJ7OriihHs+pFSzjznu2KCXslewEn6H4cVwo6SIC4kMriucdi66stlZBoE7YHNYQqQ5UMMdX7lA4r4NyeFTiuoUO6vurPs7d1LYJynl/ex2iKDB/a9UJfD74hkGSXXV03YI2Lrh32MUPs2nrGfczZyRO1n954y4NtQDAIQK43ZAJnSKYzDuwq5EAq9stAEDNx7RfZHP9+hFzykpRn1dnsoppvKNzM+4UFuzyBsSyiYaHucGerIC7UZLbPcCYY7wBf00PHuW2Q7TqspmqvREIMh+9Lw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(5660300002)(38100700002)(6486002)(36756003)(44832011)(508600001)(8936002)(83380400001)(8676002)(66476007)(2616005)(6512007)(6916009)(107886003)(66946007)(186003)(66556008)(26005)(4326008)(6506007)(86362001)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UUKlwAvhbBXScgXg9GsNfg/8l7WC6McOtkkELp8dpDfnb9KNZLGkm3cDngYR?=
 =?us-ascii?Q?2k8Zuk8dC/a8O2J5F79SZ/8VtoozqFOcqLXAZHUF61XclqayRHCvQvdV/S8H?=
 =?us-ascii?Q?fiSyMB/rZ5TFvrIsgTs9Cmzt1uIyZpwkhTlwC2/dHbNq3KsfUVU0ChEiKLd8?=
 =?us-ascii?Q?2QgYuyIpnnY3DFRsRf5sDbLDYVLsJw93A0W0p8U+8iKDVxrhcIRwAQ0qHFKg?=
 =?us-ascii?Q?enfIJ9Ek88OandDmXrGcAUmJf43wSOsRn3V8em2xvlG3r1MgE+sjLxEaoB64?=
 =?us-ascii?Q?aza5KJEtEsLVXXL0qUdlggDFU9+mQHBgaGXp21NBzJukPhvOdJlCa/n3Bsf1?=
 =?us-ascii?Q?IU46JLbSME7cm4RlduMZlh0L+uI3sVcKrhb+yV0oPH0M5aO71A5e5zXB7IBD?=
 =?us-ascii?Q?/Z8kzD9MloIfq+cARuUQ9U+RPo0yhef31NxG09AhaRMPAqDKtuo4n/6ogSxB?=
 =?us-ascii?Q?pzzj2lenyUOzJOgJPaFVooSHYTJ1BQRv94QCSNaCgLV7UdgaxL76ezQKrmxC?=
 =?us-ascii?Q?4grPBGPP19KhIzZCjyq+3VhNhPVLjWYNOt+z0FG7yhjQ/Vv9Mnae4LjV/403?=
 =?us-ascii?Q?tqIPNv3Pk3oDy33CZ70dJs9svVo65EtOax2lzIgMbR+1Btt0GsU6ppRYzbDA?=
 =?us-ascii?Q?gEKNNqH7NlgdLDEKAkQQeJXn/fOXT5lq1adTHKA6xWvPAcdfC8CoNQUWK0JY?=
 =?us-ascii?Q?wr5CwdhGEXu8aRp4bAxdjmhtc8L4rSq/+3C1ZGTlaphk1MAkUFHzGLO8bbfB?=
 =?us-ascii?Q?WceLbQ9kr8nC+fwgGdVs9Aajsc7NFLAxciH1au7gp94RM8gnXKRhOTb87jU+?=
 =?us-ascii?Q?Qdf2ZC098j6szmYeiscB42WJe6RRpFfnxxTBtEqZ76rADo+/mrmnYT0BoblR?=
 =?us-ascii?Q?ecMkMZnePHdNThGDtJDpU4r7/QJdixjUUAf24oZZ1RC7eMX/cjBkpZ2/BHYR?=
 =?us-ascii?Q?BW93CY8OgjTWhtqCZsgC7P0Fd49s4DfkXVSYM1Z6DEoPgIpDIipmtwyXJC21?=
 =?us-ascii?Q?9PL88DXY1wD2t61oCA8ngyOo4WDsoVRCO2MIE876ZeOSXmiZvzdtJ6egCDAB?=
 =?us-ascii?Q?V69G/Zbpj/nOd+a/xxnJXytJV9twZc+0dqWTg/FR9hOhMS4RKh1cOxLvivvi?=
 =?us-ascii?Q?9x7pz79/6XaW5j7uAF1OrWaSIy9ivDb4oJJGWOUJhm3kMrlljXeHMMMTaVE/?=
 =?us-ascii?Q?gSWM40g7grzqN/LGPQ30zP1dQYVsSrEuQDCJKADOVQFt+tBtErZYZ5c5i975?=
 =?us-ascii?Q?SBvDC84nnorL26c6ELoR4mqm/cNQC4U+ondzKSPEP99jRtKAqdNKhZgxtJHv?=
 =?us-ascii?Q?6jpjwe63af3jxd0NdcsqDbN0lR+/ZJYg02yYKx/y/r3u05sSNlHXn+jj2GHl?=
 =?us-ascii?Q?anfPcoZk47/MODA8f4P7Xbu60RVjUBg5OECpRVSKcWFVIT+TTL4SuI46l1/T?=
 =?us-ascii?Q?eFJLlXhtpaLe8X/VMum+hLx2RIvpQGzvpsBEk5IMABjJ3rWozozIbqB7uCMy?=
 =?us-ascii?Q?ux3jpTok18fujvU4FUvZcgaDdyYVTovrmvsAL/97kc48D3sBze8sBBd3NFuL?=
 =?us-ascii?Q?njJVDzymiff9gkuO3rJk90aDPQ1sGoI/kgcaIU8IHdxAF32OJyOw4+wXsRtp?=
 =?us-ascii?Q?aSey/Eq4iSybOYc0q85pAo4dBjpvdmKsL4Dk047HQH2f+yo6mrLpi7lZ1QN2?=
 =?us-ascii?Q?tzStHWKHf4HH6CcPG4U+GiwQLLhPrKSrS2NBBqsqjw1KuNh4Gg81Q3n/OYI7?=
 =?us-ascii?Q?9QOyRWcxnGQVxCAgAIqA9C4kLO4q5gc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d120f4-a3bf-4d78-f6af-08da184bac3c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:04:12.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz785D1zxgfb7rDKonIQrKrjzftcmctyhoq9bHCjktCErU1zki9LhpRtt5xbq6YPZFV83JyjiP2aZx8JczDVvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3354

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 +
 net/mptcp/bpf.c                   | 129 ++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

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
index 535602ba2582..e849fc3fb6c5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,8 +10,137 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
=20
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
 #include "protocol.h"
=20
+extern struct bpf_struct_ops bpf_mptcp_sched_ops;
+extern struct btf *btf_vmlinux;
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
+	const struct btf_type *state;
+	u32 type_id;
+
+	if (atype =3D=3D BPF_READ)
+		return btf_struct_access(log, btf, t, off, size, atype,
+					 next_btf_id, flag);
+
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_sock", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+
+	state =3D btf_type_by_id(btf, type_id);
+	if (t !=3D state) {
+		bpf_log(log, "only read is supported\n");
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
+
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
 	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
--=20
2.34.1


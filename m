Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CBD621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651024644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jz36xWGYzdHC0mHWxDhbp25wjWlOKiN+eq12bx2R+t8=;
	b=Z4BlGAg+vpPznh5OYbcOGBg7Flx9gngkCjBmADzkA+Lt26xbqGf2mQEqHDvrvoBY2JCnrq
	uNrALPTUuvNql/KvIwVi60fpMvGW3/b335Sw/mGGLh5R1KXT9jSOkB+8UFsDp+5KnPV84I
	gYfTt8HlEVjuuB4z1EVXprsolok6HZ4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-FAeqtNPWP-O2ZwdzovuKJw-1; Wed, 27 Apr 2022 03:57:22 +0200
X-MC-Unique: FAeqtNPWP-O2ZwdzovuKJw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy/d3Z5AUlDfzATQcVss9xZ6WhdNP2r8LgYWoT93UfgMSGorAZbvuW6IP3Brz/+0EwWLtSqIg6qfex8GQgzPxFNCWw9tXJ5JivLSqQmsOA32ioEyyk4oirBjA6A9KZLk+NJQlqPb4ZcGCpZeTZuKBS+1FCqsljzPY8oF4yE1AFu9C85kY8EwNKDTB6wluaNHuoZPJAQXpuQKLikAKdNLAltwVMmgrirIVBSEEk9XtyLwpYcOrQzUqSSTdBlTyMWtCvUxNf5LDSY4CVx7R7Ny0BkmymW/OdtU530wAJNHB5JJ4dL9Bf4bsC51hZyh6DDUp+1T8gdpY5AEFB00ZYq3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkIfIGYQA8yBy9tJWrKB5zLp5URVrhcds/5bYYWg5UU=;
 b=eVCfYoeSyFKeYNoGAgeyU9w4WHlFo/f8lNIaND63p8HCawdlgTzStlbnh7W4mkSwf0N+tJN3F8qE6Gw3CSg3sctbsjRR0DFq2BNiSIKX0xDYK7nipZX4DckT/AM5TqoIxkZE7r6jJ/P6C3Qse5sgDZDocjAFiETRsJqH8ihviMBS2u2T3CLrnra6vhT9HIpvpGf1IbAkB8zdtkMnTOvyKvExwfx+nvkSexdwBi4dxsNPB8pn7Two01ZF0MO4PGo0/GUBBDAovvmS0SAwhz7OC5oXcSSdOThtIIlbTgvEKJhZI/pVdKkIfy7yvvjITF5hAI9gHWEyqni9g0bsJiGxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:57:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:57:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Wed, 27 Apr 2022 09:56:53 +0800
Message-ID: <8ac278434203662add804d00e007c2cb2b6f52e4.1651024344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651024344.git.geliang.tang@suse.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43d534b5-777b-410b-fa20-08da27f14470
X-MS-TrafficTypeDiagnostic: PA4PR04MB7661:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB7661DC6B18EE46FDFF63BF5FF8FA9@PA4PR04MB7661.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qwAaFJpgYg7DER0GZ7ebv3YA+o2C4vroInXNopqA3qWzJEO6L7irCeX+vVVQl7GZGd5h9yH6O2mVL8Ji+aPKfFKrOgex+/BriN78McalbCcVV73BU5lLBT4u13VTPeMlVy1SQZqL2Pf1tuEuBCR7hqUkZ5X8pdtsVnDw4vNvnb8O/sV5w1J6be/B3Ofc6snQzRTLNjLGI1INIQ+IFfOLME/Vt3ANG2H8A9PvE5vTgrTMe5N3/WgGC71hUgaNG1PeM7ExjqjrOi4t1ZCVPsdZEQ/ZqVjwaXDqXUkw/93c1J9K7jcuxGvaS7ldXuJezqmNZq6JkEPOddYPcTN3A1e90buNGNsYqQ1ZQ+l8xlwyL2coMVq92j7yzkeW6jmZkFU8fohU40i46GsUlhQWBUYbVPA1gY3r5l5kpU4vE2UdqnE9DzfsJQvHMa/Wg+rH6NRB8VpXs6yWoiJNBMd6MekmYJNQgLrEl8vxBdM+i/F0bLg2BxKKeITBwXIcvTRadj72EvZZXIVTtBVNU/KNMs0Dx67KJnUV1DOAYXRLSDdLWdjb0zKacDLjI8YW6rJnFrcnZjk0+hzAvkzWryhNKbEO8URmI9bcb4HHNMu8dPXB5IxOIMsQ/PXPh3HISfV7SssjyxAOdFRdE+IQ6GXZOeN4oW3/Lh8UsZ0wr1l2NEQ2tvtKbeHMPcI405Yk8dQTi9G1SByG3/kbzk2GLV/AUvJ+hg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(107886003)(5660300002)(6916009)(83380400001)(66476007)(66946007)(44832011)(66556008)(8676002)(316002)(186003)(26005)(2616005)(4326008)(38100700002)(2906002)(6666004)(6512007)(6506007)(508600001)(6486002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GJ9bLCabmAegWSrJsUFL2V50tGlbRdAjS0LUWRctLo3Z2UYzrIThEMYrLgj3?=
 =?us-ascii?Q?AD6KTWm9dpnvpo+rGLTa6tclzwuZSFADAXd/cgSLoUFHnGV3QNw9BkMC4Xvt?=
 =?us-ascii?Q?wZf+UvJpF9RkxkpDAcuG+fr0tuJbaYE/lFYOk7tIP0kmav/VMpxlcUZI5BEZ?=
 =?us-ascii?Q?M59ejzo/pT5zV4hphgYknrjhm517eZBcvqkHgiH6RG8ipJlKlVzGunv2V6My?=
 =?us-ascii?Q?PeTiQuTWXKOdHEajD8bp0sFVutHcEE0IDuFKqB3S4JhFirhoxuacuYNq+FRS?=
 =?us-ascii?Q?EjDRp0lQDPztb4gi1YkIi92kZwoi1JEmg428uEoKhSyeSY/KJiju6rmyksgS?=
 =?us-ascii?Q?mxnqvqxXcIKfcoa/WEl2Ey/9g92Zsey7IguVz8+ao1H/squqeIUEr2Kf1ft/?=
 =?us-ascii?Q?qnKE5jpD6D+XFASwnh/T5aURGDygcL4ZL3t4YCklvbDvPVmtIbCzaAMJIzl8?=
 =?us-ascii?Q?bN1QhH8f8pXKgjcdw77em846/Oo1xsTqVkxGRxvWpp50MScvn9Ei5MAr3wSL?=
 =?us-ascii?Q?npFpqkool83FAzMYFQ0WlCl4t0VRYj1lVlmmY20CXWn1tMMU0bypP4XgJqOD?=
 =?us-ascii?Q?S6u107iq+HRyg7crljBt2dck1cqVibKMLQ/4W5mMzDSaFGTBtYIPT8YtnBhe?=
 =?us-ascii?Q?SeLLDN8fiVgJNhjRu0BM/RiYQ9ymX34/EzvmjpMl/Gl9hxRuJk3n9OU8fCmX?=
 =?us-ascii?Q?/C1PIqZ1vXBBNmMB93g/LBr3wuunk4udYcIUyIkeTXJE8Ww4XOB3dcXknoR3?=
 =?us-ascii?Q?fOLkIuJQ13LNuxqSYL9mK9c4Zsn8t/VbTJ1nQqwwA5sU4xjWDUpEydKeVZxY?=
 =?us-ascii?Q?vBYUrZw+U6KcgVmtW8VbBEVb7yExRcqj5qFokJWEyPAUKgJsOqoLJv/Y8wdp?=
 =?us-ascii?Q?C6juaHj9TpHts0HzYqYvtMTqBDs2l1ZlfofQV/wJAkfs13GpT3lm1CF1t6aq?=
 =?us-ascii?Q?K0z2kVZ5zlPwA1RXv9ZniBwY0gSKlORvaGJ6VXhhuK2L80Q8XI42GXBvpL6n?=
 =?us-ascii?Q?cs/q4euwixurfZbEheL5TFJ+mSe370vPEfP00bb2qgC4UhagZRZtzMhBSX6v?=
 =?us-ascii?Q?U0qDX0zkSkDmcGwp5DCJQz9e9AevNsinVjr1Qnsu22L2PRAdioshJUgsW6g7?=
 =?us-ascii?Q?CHKmJM4cyPiJZVkhNWLMQf477P+YgDBmsBTK3bsyS1G9e6CgYLwcgy/joyqJ?=
 =?us-ascii?Q?rbKJeQQ2D5+B6wJJtbrLYF5UX/uu+jJ7RTpP/czwxbbVradcyDb3ThV2UFIY?=
 =?us-ascii?Q?6Dg/3vgluVbPFIXhUp4gmwBFgyg7OmIysq5EZc82w1m2vqM1DJSWJyHIe9xv?=
 =?us-ascii?Q?/T7Gmt6M+fEBQutKZTSdKc5GMj0MUhfjwXnX0LSSTgUsER9byAtpRgQ+qX3Q?=
 =?us-ascii?Q?bfpd6+FqQP+2y3OJF2+n8iXmm+zbT1cp+jibOREJITeTdIWknmNxAEOZ+GCY?=
 =?us-ascii?Q?JwtLA/Mx5lXadbRTOiAAwiBGitOxAGNVMdSkpmIhuvUmrTjrnlCiw2M3GdGb?=
 =?us-ascii?Q?cHxj5ljvE5M+edEq7DYjsiv474SKQOx+5zfoGeh4kNemQ02ywgRPjuD5cPPx?=
 =?us-ascii?Q?tVovftZUKsIxTCVlOab2qLF85Xq4BBuVjfjV1cRxSR1FpRbIKLLttTOnrN8t?=
 =?us-ascii?Q?+milhIjKHCI89aH6GcNFhiz85wegyn/5wkCIfcNUCvHYYBSdJLDJsbDVZxuM?=
 =?us-ascii?Q?8rIIShusiunaXNEv3cG/es8iCNJqBCqHuGg6Kj6A3jq1DSo0t9wcg6z4UMAG?=
 =?us-ascii?Q?NqZ+zKCBfTmC0FfAGWy6OwsMpF7XSvE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d534b5-777b-410b-fa20-08da27f14470
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:57:21.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FUmCjkDlkgijEz50Yi4Nh+bj+IAAw4S6CdRVN2kY+3+aqiEhSu7mLXtxcSxi6kXJgpeAgTRPW/6ZAFlrW2dLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 +
 net/mptcp/bpf.c                   | 151 ++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)

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
index 535602ba2582..debd23497784 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,8 +10,159 @@
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
+	mptcp_sched_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
+					       BTF_KIND_STRUCT);
+	if (mptcp_sched_id < 0)
+		return -EINVAL;
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


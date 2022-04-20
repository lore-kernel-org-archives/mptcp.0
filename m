Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5617A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hvgizazLSVqB/vatjqRkjg0r7EonKFUfE/VaWeXCr0=;
	b=Fq0nDe9NXC2+KENZXSBJ98K8gts4kXPZhgEurYNehlGeQdh95cOeANWE0ByRHtBVhIXmGs
	Ua9DEibzx6iEHRJrZzSk1BqP+gHj+cklCBrw5e1P6cQnkctLyOPFaIvJdcJERAn2hK1sAZ
	8aNGlx7Dh+yLWB8i3AUKhzMbqI6O0uA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-AqS6xcSWOJyIQyi_DQffTQ-1; Wed, 20 Apr 2022 06:57:41 +0200
X-MC-Unique: AqS6xcSWOJyIQyi_DQffTQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE02y1A73cnJgrgkJA0Hs8gIcg1mlQv8ooSXFeZ8VTelZq+3PwMbIX9c2tknXypQyfmm8gMGx2d3I2/QJUP1PHlp9y4cbIbOnEmUrPj///eCZ5gbGEerFwVWWgrt0KNVFTKwnFiJPdHdQZg02okgkb/1Nhvui5Rg7QuauY5GuKOvi4qccwt50BtDxrF8qiVDioiVy2v4y2rXMNkkRIpcpSJWq6EK8mrOjkGYULmHFBd/WZDvVx5JrKw2TWVAGQZYlx72WbrBHj+l+ABq5InzB4b62XaVgDoIMPI/RU15kKebel5nboTxlxv3xOOXtpljcCgyPsidRJvcQ8vp04ROlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/QGFqUTVH0QlTuFZqXcDHVQX6mvFPq1GybMAx2rAjk=;
 b=M9ShZ265fZoM4+cYX2jLVvTa7myBR5VkAR+YPWh1WyefmAoqqQe1aDq4u/BVtOdPTG/jH+TDKhBCsxFg5tBbRCHlV72zzvhzMP/ipIJBR/409YOthVvfnBP4OXtd3PTm0RYZe1In+1gj52VJG2RoL06XcGKGyiD28tLm7p2kBO36wPXzpg/q9zmdKGpFcLm2kfoSUfDZYTwq4vXwF3DT0ByprgKsYwjmrX0BNhke4+MH0BGABD92xUbd1qWFvm5I2VDBflNzhTDHhI904Szdw+HB+Dm9PLm43g0/i67qYHFJkD90Uut8c1QsWD4e4npk0Ew0cBOp2FOeqTZTSPlsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:57:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:57:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 06/10] mptcp: add bpf_mptcp_sched_ops
Date: Wed, 20 Apr 2022 12:57:05 +0800
Message-ID: <675ea3a801243d177df45b9259d0fa5d46746e13.1650430389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b4b46e-8ca5-475e-6274-08da228a4c27
X-MS-TrafficTypeDiagnostic: AM6PR04MB5752:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB57522D8433D059E3643CEC5EF8F59@AM6PR04MB5752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3fforc8Ui4Q5syJ1pUy4CX3QsvFv1RDt3eRCwcaLJsM2lbpZUjU5hBfWNup7Q9S4OsqFwaqPT3Op2l3C+DWMX9asc9RgfCAnK88j1kihoAWOD4euqflbjqDjMZprlw+83WYjqNqOrtDbIgV3MUaUN3GmGRE2I/KfVQ3BbikD/g/RyAcVwXtt1xiut5loISHW8Tz/znxhOtqanhiBZtLPs3j8iTI5LB93XaCQzd72ir6NlcwYsZyxAl0TvNAraW/p6Ap1RagRAKq88L5V+QG6VUBa3BQUJFq7sXMXrrk3LPUJnhNXmQVHRWrBb/VJE1vJuv6hPk/zv8nTgfNvf4Le2iC3HW6SbUxsJVdmmxB4vK7LXqaD1ZZgxtq/RPcpawo2ER3XRVIFsaEnthENeC1WD0IZ/W8MbqPie30vU892jvJIROaxJJkPu4iW1tqkjDoF7B3HUOcRr3f9cW2W9M9g7fcj0sh7toYoRbOD3ylyZlVXCKn0fKa3i0OKEXsr9f62CR8inA920DwMgG4TeWSo7o8bWHlTqq8WwZuOiVe9N2256jYnoWdfnvFe2h3Lg3V8wLtRNnSUUzn5xk7mI2VV++6Yq4n7cCUrpHNruwAoZty0g8efQ4Ig/sN/2ylcq/l+PJNZ2w5/H1TJhDa4SePC8KqwLqyHueFas4Cqmw5JiUYe+K8+TBviKH9D+0NeJkn5bFZnsLhix1vaPTYEBa0KcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(508600001)(36756003)(316002)(6916009)(6486002)(66946007)(4326008)(2906002)(8936002)(6666004)(8676002)(86362001)(6506007)(44832011)(107886003)(6512007)(66556008)(66476007)(5660300002)(186003)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?98z0Ug2rBzudvOKRGp398X9A4Rx+XxnRxv+K/ymFA0xVjnr00jbpFg6ZBeJB?=
 =?us-ascii?Q?gz8/lLI9tW7yo/HJpTqg6AWODhArLNHNBX5pE19RfY/uJPHgztPEtMusN/u3?=
 =?us-ascii?Q?pshi7+ZRG7ZER9KwVkUOD49iM/le/y+Qo+RyDWKQnjWfmkyP0hzYoNK2fR4J?=
 =?us-ascii?Q?6rXbYVBAUzbR8Y0GtKREEyRq0rLWSi6M6eoCxIZpAp+zWy0pUSGQNSUpNiW6?=
 =?us-ascii?Q?qraJq2Xhmf/o1iGWH8o0fDkWc0yzHauwyBlYpDOChxk7/D7lIf5fydacs0lO?=
 =?us-ascii?Q?JEhIPvMwxPe23/czQQ/3GYaUJAAq7p1aL2BKWk8bGYo1xMNBHP9oBX9wek40?=
 =?us-ascii?Q?0yMCCmpFSwBg9o1fdxynfbepMMdoIHb+162JKn9xwm0wuQWP/2SfmKf1tohE?=
 =?us-ascii?Q?3v0m7J5VD4j+NmxMZO25bijh24uBrMojEMVib2n74PGaoWzuh2rYx87R04Hs?=
 =?us-ascii?Q?8pnLoMan3VU+2ApTStCdxUjLMrmlQ/+0FbGkVtMMgsTa3q0zE3bhNFI/hbF8?=
 =?us-ascii?Q?dHRDkbRZX030bMy8986QOXJQyCWgkjw0JbHMLihDbNqSxg/kmowfaJa1n0lU?=
 =?us-ascii?Q?Wx5qQ3lWHAX3xOsWBJAYBPGSIyxmEhH9XOBSgEHrJabPWUuxnDSIRYTXLHB2?=
 =?us-ascii?Q?Kw9SEG5uAopqS/fA+ahChUsr/s6LTAfu2Pz5IHqVp5WhyqHpg/lYkQgN+7Wr?=
 =?us-ascii?Q?mqYpHYSxNyGnDXupSmGk9UDYi89ClbFXx9dfGLrgNW3+umPyu3DhpAIkCn7t?=
 =?us-ascii?Q?XbacMzAdxnWoplWpXyjh27bRYukS+V7uwt9f1Tt4RDd27lseHZhGLGPPKY36?=
 =?us-ascii?Q?gd+M1h3DYbIFnbc8oHJpTXcvc6EJEld6+XBxHVl5/cNkIwWqZcOyFqpYbIaL?=
 =?us-ascii?Q?bOCbuO7CkZ0VzLARuLyzNBesB/qCE1dmy7Uhb768rK8tX5r4GVP0jwD6vnJX?=
 =?us-ascii?Q?aHAPWjH4C1EqgQhNBEzSvSBKvQ2v4vC27f1D9AdAAdpOij6YHyiv9VcwBygc?=
 =?us-ascii?Q?nnchy6rXN68q/Mu8/+vGAAywc7NXo+UFk56d/2ou2DrbgHash63CMXZy2IPi?=
 =?us-ascii?Q?xzl7Hx3jz/829y10m5rM0eEcAlIONrWFI591XvqDdIMbusMgsuVOtz6S5RlE?=
 =?us-ascii?Q?x9Z+ubVTxb/2ZcX8ktAPOSuJ6zLPV+vIt37fbnOjtCVZLhlRhZ3o/jwTAOm4?=
 =?us-ascii?Q?wdviugCQ8sK7ICjR4MVVrQooUfi3mW3fUVHd3P4TLzMcTw7Qe86lXW8dFJRl?=
 =?us-ascii?Q?peXV2fhOXz07dDr5uf4wypNfNOskB3K523chdDTaJRRePdhZjM0VR9rpUnZI?=
 =?us-ascii?Q?MYRSu6m/zf/rtuUt3jhs6GqZKgDmzZiYeLk9UEYbs/5Rmnzf2IPtast9VgTL?=
 =?us-ascii?Q?dPaRznf8cLkCZsdNc7TzD2XoNwAT1Vlh+Nj2uWQ6zWLfdsEUXn6T+6Irtutj?=
 =?us-ascii?Q?RtuR270wzE7psyAj+EEzOyTYMrdEhjXqAf/tVXuvyZBW5sBFCCb2YQWsgf6Q?=
 =?us-ascii?Q?GKBaRuptuQ5GwcKvJ1f5oV8r4l4bN7WMUEZcK7k4SFzfyxa+gCSlwiZI/+Yx?=
 =?us-ascii?Q?FhPJCgHf9nhO14vjA0CcNu2KQxo1hmF84pJzzrU6tin4iqcsF2DoUnqc5qYQ?=
 =?us-ascii?Q?/E2myEyciV3i7jYjuyvg9EFft2+G4EZ0mt9g/mZlDM+hTeHFpoeeCPt5GIpQ?=
 =?us-ascii?Q?oXpD1gY4SNb9DTJaRiWwEzZXn1FcjCNPZ32CXmOwYnT7GEf3RCSky84c58RN?=
 =?us-ascii?Q?8cbJapO50DFM4kxl5QbuuEfh0E6FakI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b4b46e-8ca5-475e-6274-08da228a4c27
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:57:40.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwRk3bo4xp+vY6reEtwt+g3KnYwM1vM1nm4CP5fUWAKaMQAwcDgTg1Z5k3Z73QtABJjKxXr0BjTNlj4P43tAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752

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


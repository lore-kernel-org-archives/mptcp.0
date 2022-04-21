Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B597A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hvgizazLSVqB/vatjqRkjg0r7EonKFUfE/VaWeXCr0=;
	b=FmjL8jfd/ts18XlX3uATwGhZWOn+5SD/s7XSooYaQcx0kutVz+lLSNCDQFflyGeWIk+DnQ
	lu0925+jAx7O7dGolsRvR8tgVY3wgNruHyBtHtD1P0OhqRHesobOVA/uO8g5+BKwS1gdPg
	c+aJEztmIE6J1oMBtGyYb5NgMvLb3bE=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-TtecusQGMBSLfjQQD5aq9w-1; Thu, 21 Apr 2022 08:23:02 +0200
X-MC-Unique: TtecusQGMBSLfjQQD5aq9w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN8GlBdq1rwadE7Dzc0ivr/uwb5oAuhSli2enUF1vAC2i2M4IygAyfjo23NMSWz+N9JFFgso/7rduuWMVRBOLf+CkbzGXO+m99x5Rb9SN+uaTaySfPQh+wrgPS36ArpCKe56BFzpuyDyL8z8eV/h+qVuGB22ADo7ZBz6Tf46he5miV1Qm2R9By/sm7ylPkO38OfzjgokkvQIff/uvxYmRTuRnFW+6VDRtoFDXPlAW6jjsHM3729S+eB4D47gmZlg4Du9s/k6qMiR55curUPN/hHVzuBiglPW2Oq3loWbOe9Hc5qoDuGlt85Af1elh66NhzJQ8fAE84YM8GIHKb6q2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/QGFqUTVH0QlTuFZqXcDHVQX6mvFPq1GybMAx2rAjk=;
 b=k+MiJdwqSa5igLKHXUoX80FxgdXUz0/8T4l7euQsDp5vBZF8f/ot5KmiDU6bmkA9Ai2nvDaBpKiPRDGNegqAG7e+jc7prePwaa+ClY5YesDxY9cDcJnRk0f47cdWFeLnhJGvEA+PXopWm34jovxTQBRMfnkpYpXA0hHqh+NEq/rHI+9AR4euQQLQp+nZw09I2pLXtsSKHXjJYnDoV0PfrlfFggZ2fIIWEjGaJbrKzIVxirG+Orf1eTnOWUWDlACyPmsU/dW3mad1egA9bFuDyEpFZgslklP+hP7QUuI2T95bPvEPTRiWWQ/qdQz5b9ONfFSxUNB/MrJ+hWRN8JDzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:23:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:23:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 6/9] mptcp: add bpf_mptcp_sched_ops
Date: Thu, 21 Apr 2022 14:22:24 +0800
Message-ID: <3d2648842f4a15f8aae6ba33fb0a769db573c710.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650521788.git.geliang.tang@suse.com>
References: <cover.1650521788.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b56830-0da3-45c3-bad4-08da235f629e
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8100B98ED73A3766F9AA01A9F8F49@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	magzuvunwcI8pzUSNMYcsFP1CGk/sxDfjLuL3m0L6nA/DXguxNs3pSudMgXy6hkfAO50CcmP8eN9BMRE8bDm5JoC1FM+EexZTAqsh/TUa6wlkau9FqGW1UKJwTB9D86KXeoRl5eb4yqX9KMo1n9Y3K9L8xAEeURg07wOA3lxRueuFZhsdnyhpVRtZMmp9hsE/XEjW4U5p1/ZM9qkEkXdjutH0CTBumbHECAemCd66HXDX5CfmV2ToWaCOFe5y7fHsC88ednsFwdCcJxJLyzdyPk2+jGfDGOdCyV7kYYve2bFMK8LfWSpV0O0eKWeet9coR+NsReEL90zXkn3Eqi7PBwrcKpm0fgCdAsFo1P/LKubXHEor/psG7Ru0UzsWZP0bTLfq/S0pyA9xE60KCLLeWdM9zkf4m41ojojoFBi7hr1tzr+ZyeL8FesA1xiqgNsfbwoIgbTFNlLufYybReRRcdw8VzCowEHl2OBg6CAw3zwnLmDC4FJGWr+Lr+nyK0j0quRV7s1hxk9g7z7w+n737v3/GidONGdAQiRfTegTpRSvqHPvwbWKOfwU1qf0KhARSeqY5w6IFAdNfRa1TrGMxoEcf23Mii7+VIl350A5HWqCySs6QaUeNGqD4qCYUK8ScA0KBGv0NiV6ZkkdvRTwxIy/52GaWsYTjoZu+YRsUfU8VutVIiQPBoZ60Ur4JgFcjQn7fY299gCjNxZjDNXAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2616005)(86362001)(6512007)(26005)(316002)(6916009)(508600001)(6506007)(6486002)(38100700002)(66946007)(66556008)(107886003)(186003)(83380400001)(66476007)(36756003)(2906002)(4326008)(5660300002)(8936002)(44832011)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNkDBvhMwjB4SZP4QRzxFvle4U4oL0/9oGYdCeeyEuReWqb7Hl9vyhV5bi6l?=
 =?us-ascii?Q?myK/c3VYmdzv7FlwA3BBLhhjA5pAwka+rNpONHwO8vJtZNtDnvm6fkn2ftYH?=
 =?us-ascii?Q?YBgV0ZsOHtLNgNHMV9Mb8as0k+NmqKfuajOcYgY3yEwj3czWK8isZLxZVtZM?=
 =?us-ascii?Q?e8fjshpRuxHM5kncjZT3HDSXEirIMnZ3zbV27DQRK1duqvnn5kqf8BTPR6/N?=
 =?us-ascii?Q?HPCRNEAeYbaKYw7TgaENYNIOJPUTsELDy4KHWQJvubmu+/mWEzuhUtQVvDfG?=
 =?us-ascii?Q?3yPrDomX/h9vItiXnj6JP3+aekY0psc1uSPziWaL6DswMAKhQFkATNZk5Tb8?=
 =?us-ascii?Q?gI6gm3tgiT6NzN/e31JR3I7DzdoA34kIt8OGkC2ujo51wimlSXsfmh3SHfmQ?=
 =?us-ascii?Q?OsTyQAtQLV2dL8lDtl81W1EDZi72BOsTo9TtAQlaLWqMAkOLYIa6JUz9JEBq?=
 =?us-ascii?Q?BS4J1NpRb3uKoanSj0PDGdSkDXpia/4qZfXc7ufAqzdoCNsJAZIQwTaOGpMq?=
 =?us-ascii?Q?HzoVvb1FX+xoopVQXE+xUfrU+chttNGuDK4zBrCU3Ch85UInRK8wSI7EudKg?=
 =?us-ascii?Q?zW2gLbo24vI6X1MEgoc378+lIsGIUmT66hePeZV0gWIo4sEqS7UrZq27P7i1?=
 =?us-ascii?Q?/rl5jVOlHcwMdDO4a7e/z7HchKB3jWL009BH7Y8CCvr2g9DpHvU8IYUc6OBj?=
 =?us-ascii?Q?57vPIRY0uGRYM4tEbAW7e2yYb8XahgxzbNKfyTfICwIdRHIWfvZI4CNmiDN0?=
 =?us-ascii?Q?rjtiJ4Rm3NY5j3tnE33B1MWsqAZ7500pduTB2SYRjsV1/1q/zQVa5nHfdUDD?=
 =?us-ascii?Q?yuGgy3ZVVPZ/O4uUGzaPNtorG/6C71pzjHpJ3wldN3mGBp6B3nfOGXJFjnBI?=
 =?us-ascii?Q?ET/Ok2o4Kk+j8bNHPxDIWdeGPi3QECevqdVpb5RYLOMrB7ndesuIzfvXVjJ3?=
 =?us-ascii?Q?53ZHpNan3M7IRNaC5lLq00eD4itXCe2YzQ4wQhorffF9OKlor10AiiVvuacH?=
 =?us-ascii?Q?2yDNgCMhXus34qKUVZkM2xrw3idPIOUye5faz+0k2ytBmPWL1euQejeKu2Tf?=
 =?us-ascii?Q?ZtcxsNcNZ/tYgYMOgFuLFTQcPTha+84KZUayLYKgkUyhBYtTuU19N7kvIb3P?=
 =?us-ascii?Q?EtXq265XHNapjXfKc3YgnE5ZGjvDfAvaD7eLJZ+AtzKHIpBghmejB0bcpV/Q?=
 =?us-ascii?Q?3kH3+EAedxQOwqPdURpTlP7vGVeDye5sJmokO3aapzpscUsrV6rcw4WoWmpn?=
 =?us-ascii?Q?Nu4uTXUkaXf22PwlOH9+6bb2StCkjA16h5yzwHNSjb1IcPEgn84adOuLGKGz?=
 =?us-ascii?Q?N+/hpwAN3tmdrBB1dno/WtwGKveplTAjLXKhOTk6BjBgvvsyLBC6QA+9R21A?=
 =?us-ascii?Q?NMCj3SBPMEbeUgV/z+cFJVzYpo/pVV0T8hn1B5J6U6Ntby/LY6GA7/skFJvm?=
 =?us-ascii?Q?ncO/YfLMWzL28KDRrZrr2ZFQe4r1kOT6e1AEQaas2URzhFwwAwY1vsVZYjax?=
 =?us-ascii?Q?9SFWvRKTBcS5Glw5qhGJCHMHR91zPQNAAvFSdsp09GrWhEJf6gIZiSGShfGU?=
 =?us-ascii?Q?1rdbxaVzEli5RYe/SIJe4JFhZrTBJ5xpTZhiR2txY94rxk/0QTlJoAVfBLZR?=
 =?us-ascii?Q?nQhMPi06PHMo1ggSCNKUxKrwPry49qqNKfSAQe9Y7+XdS0mPT9FGS3qPA4Dm?=
 =?us-ascii?Q?17cyB/wh7kl4IJwN/MmStSDNQMbY3PuwvVyyoG0Z6+dQS8T0vFTqgHbda6JK?=
 =?us-ascii?Q?7PQBeXVzweXW5Ot/kV5rkR06iGSyy30=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b56830-0da3-45c3-bad4-08da235f629e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:23:01.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HK4QrfImUTxIxMvowYTZ9yOGW+I0MNAO2G2HS2FVLJu4Alti0F2/ejoJNfUIVBh2QPcoeICUzpY6ePJUGFOirw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

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


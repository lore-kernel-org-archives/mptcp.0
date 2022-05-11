Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85A15B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2R3aIfRF88N4fKuF7WMISdk28j88e6veR2C6sFhhHg=;
	b=BhvQQ68YZgFCPDpnVFIpnyIngSsuMENiOeTRtQmgCv9A2ioBOpE/uxTSdJiIQWNnO54pfV
	EKpR0tooUZiR3bOsbiVEn0EgVpkiHXHF1eF7Yb18VJfD5MYXOpsxYTN6PnsdRubPLAvITN
	3hkm13vqVH+zhNWOeM6mU6V0Ow3CnrI=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-SLv4lnd6OK6E2ntxw6ttJg-1; Wed, 11 May 2022 05:41:16 +0200
X-MC-Unique: SLv4lnd6OK6E2ntxw6ttJg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcEp5qSq3/YawFlC0MmcBWpMQJ8YTXBy0QAC7MFuAyHSoojr/Rz8gHLU32l7PYf6RoJ26dVcFVbPwL5CU3B9huGQDPhc+jgNiS6PcC8h4sLrlrN8F5gyZCh/3RE3GqBDMnY/unMV98njagDcIKLuqrtzb9FznVfpwI8e0m7vyr4Pi/se5Sg9Iri3l9vt/mpwykSn3rb2IuHN9WbURvmbCI+bk+yXgY479YeuUJ8LvErUJh/NGH3mhLm9yEWLQ+BSLpdY3pEMdTI2AET74ADRDDheWF2myiZPFOhUPcmKJZxtoeJa7E5lKkILW3sBiKGoDBt5vvr2wF76LRUhWTt28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOMM6qvB5KWBoElwhlSGobiSp1e0WnPwL2Y/XX1dHAg=;
 b=Rl+pE8Nx7/RRzxOLtF4DLt1YfjKhmM36+Jg3YdY3oKfNoM6zspzw+19Eju8NSQeCUBICaHEpjzDOtdDUHCRpdZ8N6qEWHLSXTW2hoat+x0nu4SxdzjpRedKm+p6Llh3KPSYmP1pezEej0w3aUh8JNppTJj7uRz4tF0KMnuXpqstquhVyCCAYFu+YB+SBGemy7D4MlON7VZeuFuvdakgblPTRcQt7ishnxC8UImhth6bjzrH8AG1Hjs9/bZtRYFJZqeaWqt4JmlVT6A/orHzgczs9qbhCHVdxoqs2t9DfH4OkWmGQUjSj8sFEBtfXyQB4aPZGqh4o/0SR5yljm0C7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:41:16 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:41:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 14/15] selftests/bpf: add bpf_first scheduler
Date: Wed, 11 May 2022 11:39:15 +0800
Message-ID: <bb9bc7ff12085e79610377ccd5a254e500504b20.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0158.apcprd02.prod.outlook.com
 (2603:1096:201:1f::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b5b9904-b5a6-4476-9da7-08da33001a31
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB71569F5E570DA311285A0A33F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yWc+EoNh4F7UOCVDy+/JKDzDuy2ToBoR7N2x+kLtREGFHb6v5B8LcI0hmQGLgFhAIK4fbbmiU+fUQ6PIkYivNHvVLgxNIZOV1jJGFI5cVgom5qt3wgRw49JNw2LaupC73nAnEriSyfYaGI03fE/pX4Q+61EzuoMcs7AwNUYOgUvCc+/xfOITRw07uqmOOC2Af9htxKH6wrb2NA1cKXZV7xQWcLTwrtrKH+JduBwFHYD6P3Q65BS+R1akpIW3n5DoLukY1c0B52664CkXw6Cp+FVZpJh57ZKRPDjvbcXNqSzC9tTIFsN78MnCuk9R7tkPm2nsJC53w6Gj6ANyM/CdNHj3MXsWvZbVEnUFWl9G/L1UoZ7Puryb0xZVl/iGEE2L9fUUukeTRix2cFo9LzhXqzUcas3VXghXgp7Efm1GR1ggpkcZ4DjZWhE5FUO3y5Lzq/6G3wSI6K8T2ltBkZ5OM/Nk9byaAkP7jQ5eQQaPa+Dnn7syoHlKBClMVfm51Fy3KewKjeCHKAgTYB7wGx2UM5iH06Ntm9q4WozKyr+U2ThojUdKJvvRMbvGNCY6nNUP0qVolEQHWDVvHDwEbIRK+BxJnOVnFQTD+wdzqTZKM7fvLfTyXPkRNrymDLA8aa4K/z8PO/asyHDbumIQyuEl5GzAhvb4bpp1WTUcPzemzjRLLqbVu1HWe58Ik7pupufbPpenKHr3jSY0MFDoez7lXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+x5RFyBsFfnaowwYeq4JPcaQNgfwVbJ887j63wt2aCM9GIVkWO3Lnw+p92ME?=
 =?us-ascii?Q?uGpqZaB8qqEstXSLRvgu1bCGbiIPhJKNqrP+CZ5TGBhNlnxKiSciTnKh05jr?=
 =?us-ascii?Q?xbX+DcE0dMEMDLlJBswkTFV3JtZmd100WZkHJmkYhptp3Ko3gc8/8Lb5NeJH?=
 =?us-ascii?Q?j1jooPseFrELv/3dafhlNjmzoArcSFscj8Ypx/FcazQzY6jeGDfuO5UcohE7?=
 =?us-ascii?Q?vL3Kq1tJgRRJHIsQoEEUIQ28vnNDWXKtBCXViepK9bM54EhWzn6uhsx+RrOl?=
 =?us-ascii?Q?wSrXPRnmPONsSgv30jjQVTq/d6lQ+vVwE2NqeMmJsdwhfEn5p2TYaXSfUaBs?=
 =?us-ascii?Q?OOWOlMZ3CirwzdyF8zz0HzfauWbMy08Ia+CIBhMFs07AO9+QToNAZ2HqBasF?=
 =?us-ascii?Q?MmPZpjoCQ6DuIeTZU2QJkNcjK5PstRP6xw9Yf2BvdlEuqq4V30d+e+9yZEYy?=
 =?us-ascii?Q?UJEv6g/BU1Z+7G5TD3sCqgloFMQgM4sLfrUxdYow/JGBiI6Ry3zsCRPrXrny?=
 =?us-ascii?Q?M4RlWJDua0Btk6lNgl69MRbRKCaytAI3Ws1WSdmoBYQrlJoEW2NKgqA21Rl4?=
 =?us-ascii?Q?nb/5kx5zLALQMK/5otwoq7OQ4XbwGkAWuFGjomGwDY6NDBn6HqP2pQdbxDSI?=
 =?us-ascii?Q?8XU0f4IF94jGbIjeE0hBXMHHeDRjkTtDs2NsVhE9+SkuM7RZSQwwYwtfm/3q?=
 =?us-ascii?Q?Kydbm79gAJC8Z2elsRDzIykc2RAY7eCV4uSsF3cwig1T07dVMn8W5+WIw0Nt?=
 =?us-ascii?Q?jBd2cuf1Fl+yoOQ4Skhp/CJj4+6IowUgvs+3cURt4NngJfK7V9uxtvF3ar9D?=
 =?us-ascii?Q?KfkOw6rAojEmxRbGepISzEek03rogv356kPRqYNY+7BgvMqID1MZk2e6Cf02?=
 =?us-ascii?Q?OErIh8/pyI3zCOmFbQpc7hHi/VVKdmv6e+guGi8M6cn+yn3O0WfMBVyD8krK?=
 =?us-ascii?Q?USIjBuPt/rgb7jVTEz4PObgGglJZQGzwb0dm3dZly6Qiylz7Al2KScoLnesf?=
 =?us-ascii?Q?2Iz4lC39gY5XsZ1ScRJi1DfHZ1fEsCsH9WxAjvxWtAf4XNuy0uNc3POGb8Ap?=
 =?us-ascii?Q?BbRDFn10UkYjuIuo6i3lGgg8BCBSi41LONnal7KRkjqMbp1T7/D144kthg5m?=
 =?us-ascii?Q?kvKU9lyw5dvWIvdgVRuXdsS5nlg3FbS6R3EMYwQRsxD7X1JIRvYBQM7X0GE/?=
 =?us-ascii?Q?6R5P8JH7+4iCBfMIIijKctRZ04yAEsxutu6O/NdRTXk0lbJHO1IOmCgTFUVg?=
 =?us-ascii?Q?EGx7Nk6FtYfxwKZeE5yQDvfwSZO32y41Qle3stV2yS+njJCdPoa32WHcYM+6?=
 =?us-ascii?Q?GkV9WOsVrz1p0yQ5Nf+sUl3cAef3UyL5Cys+qZzgbH9StLD9mduuq1xRONl2?=
 =?us-ascii?Q?cEulXCCqfIaYrK5hbG1wG4KNJkDkFW5WPCqtts3iwY7Je3VDSCMWKNhhjyn3?=
 =?us-ascii?Q?WZm6DMWKEhayNaUmrNZkFzXC1XjVIRrfYK0MKmMXqRi5kn1RTRKk3jnfnJR1?=
 =?us-ascii?Q?anK0XfyNEaJhoU+s4zeHD2alm2YaIhcFqO9SQCZ7K/PWSuN9UFePedXfkrS5?=
 =?us-ascii?Q?zlPPI0Vn4RuTcH8diRoIjy1/2bInIQzWC2JlYJcc2ls32xhzXNc3xSMSxWFU?=
 =?us-ascii?Q?q2I8roRL6GwO6ubVPeIO5hdMlqENbMqXC+wOBp8T9x7RLMjrkpA4CV4yIeLp?=
 =?us-ascii?Q?ybxdlxYBKD5SWDo5/qzd4DgtCuubBlRokIp4I1fi8fXrOwbMSJ0+gw/wmq57?=
 =?us-ascii?Q?BTzndj3KPEZ+Gusct6N6/LoBO9blgkI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5b9904-b5a6-4476-9da7-08da33001a31
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:41:16.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKIQcvQ8YO+MMwGJ7XuhYxku0y71QmYwGzionjdAIqaaEsA7ARAJskPFx7N/x+54oY/RL20mjt0f0WmufX/xBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..fd67b5f42964
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_first_init")
+void BPF_PROG(mptcp_sched_first_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_first_release")
+void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	data->sock =3D msk->first;
+	data->call_again =3D 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops first =3D {
+	.init		=3D (void *)mptcp_sched_first_init,
+	.release	=3D (void *)mptcp_sched_first_release,
+	.get_subflow	=3D (void *)bpf_first_get_subflow,
+	.name		=3D "bpf_first",
+};
--=20
2.34.1


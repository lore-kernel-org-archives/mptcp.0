Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150041.outbound.protection.outlook.com [40.107.15.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902A1FB1
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 14:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB5ZmdXJwYboA7IxC05FA6rW3sm2yQDORk5Ehhr0c0ECEiw01Gli880sRDs8z1QgSG0E4SkKlnV4vu5koM7ZQ8BnoeuhJPq02i4xupIQZa74cibKC4yHi2nXYBxK6X6MNNtVBqPdf4hCPoQpQTdmuJwvN67P1FWhxUZZWgSAbSibOyZ+9UEDnKoMhyupI1i48bbSmEgbHQSrkjETx8OQwts56WlsytLbjQfsJCbSkWbgHMbJBwjtO2ighpm0fIPOYhrpFfq78y7d7zSlkYP4zTCGXMX3/K27CgrQTWuJG37l+lorFBcB8/nAOFR4c4SbRrciHzXVXLUfmux12zqIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=H9NLWIrfjDGK9yRXchBqRuzxTvYN3+6W60c6smuGzBawrPwepQ/NH1owFisIrfNcAQ+bYzDaKZ2Qb4cnzanlg+5KmeWdlgeUynHiFEOWObBbnDW7CKS4lUY6kBZ8jrV47EyihWetVj3NV6JIO9wv8u9+DgS+inJp8eB5akaweuMfG/c9adSawRHqnQ2CEPhrGtq3WemBXj1T8h8hHBkEfZ7n/cjQIiAsdIsnSi+ACLpIm808aQL5mQtpNQj6WBPk0lN73ImRpeg40K6IV5HZFWztMDf+ag1mFOLptsYJSEKcsHE3gLzPHFvPkEV8bB3ndGmBQpwYfMciV+mPeK3pIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=Ln9udPDtqlJ8BBPqLHoC1R9NuDfvjMHcNDR/xuFYt5sn5u4ILI2pzI1YiMDee/a4vuDAiaE1pgKU4/6sELlZAsdThzbOhfKsvN1Iu8OUILdEHL2KPXRjsySEuvycd76nrvRbwTAOXtMw52UoRYu1ZVSWe0xK1PDlqJ1tgBPUnMmmyUI8tbQt2w0RdT+zufMUY3uVtc6iEszqV1ngIfJ2fJPZiA3YTrYp5ZS04XXFwE4mWaU5vzu4+D0qxPHDL2PeV6fndOU/mBrd1yn8BUm3n7kIk8/DqrfAzc0ttj0TOdS9PUoPXORHRa3DyR4LZsdJlCxh7gUsjgSdunTfe2pLrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8299.eurprd04.prod.outlook.com (2603:10a6:10:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 14:54:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 14:54:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 5/6] selftests/bpf: Add bpf_red scheduler
Date: Thu, 23 Jun 2022 22:54:21 +0800
Message-Id: <f17de102cc5f0c10ed80be296a5d99b71dd1d0ff.1655995770.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655995770.git.geliang.tang@suse.com>
References: <cover.1655995770.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c32d93c1-ed56-47a6-6e46-08da5528558d
X-MS-TrafficTypeDiagnostic: DB9PR04MB8299:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB8299B701D9A5DB18AE3D3CDEF8B59@DB9PR04MB8299.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+xBE+Xy21IY0OPQU+8xN0kQ8pAOZbr29Li+59TaeQXL9k6SRu32pdP4+iDMxa29EYBVM2kIXpf3zX1BKiijQvrdU/l4tXHeuzRqD+MhjuYK1qZRcmZ/Fxkfa2w8GBnrLNCo5ubMwVK/ZLcXLvGZYov3v9CX64+Z1+NxOSVTzDNlJ7M3mGhT2rje12Ilbct3GAnJV2QVJHUjkFK33JsELsLly1zOllVuW8DEdy5qluvZOqMW6fe2EPFk5vMc2VKtua/4lgKStnkNieNjS4gyaMEF9r++FXKGMza52wM5evebvSKOt+3kE0/L9cGskK7gjebHd+VHZJv11FGbF357pANdxyqyPwg1VbJXYTXBF1Jt+xGUwyzkvffNR58qGkJM+TWWZJNo1ksh74jBKQk81yMQ1fNho/oM/bEJ+nSChKPUV2MXnXwivEQWrrDkNaKu/ZTjr3YgXXHqlhT5Bko2/MFlCmEQZb4l9mbcX++BtfHieTRb3nMM7uAYFJJBbvV0DPdly+zDztRsA1bcNvr9RdplaSE6NQSs8oiG3Tv7WlYFcDpZB1vWY7U1q9youxpIzCkgRwgTQ2Xi1t0jV39fo9hmO4Z/AOdwynpvsJWDkRid/81o150wOksdqJ1ZMMBA3p13piUDhIQ0zinODQ8guvzDXk+w91oVXtM0UPJ8yIVuJGPp7X+TjoXgBjPdZYi/nIyx75uLfFIQHaytiaFodo5Bi9DtTE7yk3QWT6o/07CYfPR2VNCmPe742m4Hdwb2o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(66946007)(66476007)(4326008)(8936002)(8676002)(5660300002)(316002)(66556008)(2906002)(6916009)(6486002)(478600001)(36756003)(44832011)(41300700001)(6666004)(86362001)(6512007)(26005)(186003)(2616005)(38100700002)(6506007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?leWb6Uin4bMKtz4tmR7q06DLRkNP7HqmY8uruTjt6BROMT4KKyYFu2n4Z5Qi?=
 =?us-ascii?Q?+47x4IFCoeiI8/HGYR4M+6EwOzmzTFiS0WJruh/aTeml9U3pYaEv8RURSmMp?=
 =?us-ascii?Q?7IfGr2CArIY9sOAtwkeNbgA4GhrLIBliRh71B4twopEL6zkSkQb6COEqHtUx?=
 =?us-ascii?Q?6g3TIdjFOsttbi6hCciWXIneTgTDBLPP4Z0ZQDQ/8B1kxMfAETryk5lt15Ec?=
 =?us-ascii?Q?kZ3WppiELop0dxmGFTkHYXBBxXYmFZPW6UBpDAHP9m8/bwbS34v5jlbBByUj?=
 =?us-ascii?Q?OURluqMPt5UH3XnYDXAxcDOzgFzgjXY19YhQxxtROwv+e2JPQ28KAtKDdY/V?=
 =?us-ascii?Q?w9fHqBED9bj9/J/Ap9wxmVezfhIZOOU0NCo4jU/NvDWBpU0+NwUULb3qQCfX?=
 =?us-ascii?Q?9SO/2wtyEpHp6LIhdEyQbIP/y+KOGPvW1QR6K4S+tSfoR8VhYWv0Fe9lNDTU?=
 =?us-ascii?Q?sXWb+intP0XyH/ymGcD5yuNst/aOSv9eknYAn4nIXD6uvLx4e1iGwT1L6HVP?=
 =?us-ascii?Q?vm3GhQERJuSeuhOYhdvHqbqRnWxvqbncDj26Rbf1l9zCE4I+oMXQRpsGrqak?=
 =?us-ascii?Q?ltMKsQ6nqjdQCWQdePcROg4H3QPqfnqMI0CqYVllsewwmr771vyVkf/trrAb?=
 =?us-ascii?Q?/rp5HCYAD06XCSBnWiqKqpfjt9PhlRBtZOZ9pNe1J3iC65lJvk9dmuvg+BOu?=
 =?us-ascii?Q?MgNs33Znpj1haIfMquqkNbPC7/xrbybQJZTS8RS1xX2X5sMq0w9t2ojDhi8H?=
 =?us-ascii?Q?RIls4v16uvAItoc/mXphsCyBNCrwXyQWJRYTAuwgRcOc522i6AXTDgYBUbKM?=
 =?us-ascii?Q?l/ybPHT/zdiDwV5Rl9sZS3/kq7WyOdKRV1lx2Lg3T0xIlTll2gyi0HMuvzyP?=
 =?us-ascii?Q?YdQzciZPUDvIMZXIsDKMquvJ0pydfdO/7JyDeSpQomMFX0bmwS8/pMAWtgP6?=
 =?us-ascii?Q?GMgEjR9KftpVuQ5kRy1R5NC8ISwY5PmC5lpZ2wV8lvKDgY3N+SCRPxv3Gxla?=
 =?us-ascii?Q?/dr+jYPYwdli8OwzCy79n+qvzdOtCGaZV2Zl2Rx+tvVzCXxYfZi2swjGI4Es?=
 =?us-ascii?Q?/9tbEOVcHQB8sO1Iby//XiyhMDxPpo0NPvFxsdR/Gd2Qx6c8P5lKsktnbf8W?=
 =?us-ascii?Q?y/0hRj/tPQ0t/8GVQ9pqzICg7qC9V3qm0HmdmCoeNvgsmlTpyj+ar/mUAqM+?=
 =?us-ascii?Q?8/aEFwdLjM73Zdk4Xo1QHXMXlqonJ8emzwcyJgNmqa7CmsWMUB/gJsNyqRi9?=
 =?us-ascii?Q?7kIXOijm9M/0VXd+v52z72yO5Vq8f0g0Pbp5agBo+TlO1qH5lPl2wfrS3p6/?=
 =?us-ascii?Q?lIM3ntFP+8cx0Jf0szFDtxEugBrURLaYL0kXWvvuLEyrdQHUMXdQEwOe20/M?=
 =?us-ascii?Q?J8ij7x6M/EwYCXOrgkj0v5TTk6P6FOcVP34DObWJLgHGoyAc3qKjsIcJQMsE?=
 =?us-ascii?Q?uIWED15kObXkGsPNVartmYxl6Lfe2ggfMdiAKlWH6QOgm1PvDjpDv7cnPCCU?=
 =?us-ascii?Q?yRv3t2l51bar2ZS27k6wTgQWAhtRvG/gyT3Mf4vuX5FKlNYMqp1RzqEcq2Nz?=
 =?us-ascii?Q?cI1FNUxdmhBaIC56qVDfrc9SJfkAM9tfNo3eN/8+iuWeNV3tEvbkJnq7AMea?=
 =?us-ascii?Q?s7gH9Y7MuGJrdix2lSRBRWLzP/+BaUID2lrEuAE8IRKEhDaJV8V87E9iqt/k?=
 =?us-ascii?Q?0wxv9o5eV2iraUSd5/Xlk0zwqytv1fv9b7HrJ7RycHXnaJq4iekBzQxbAoec?=
 =?us-ascii?Q?bu1BHG+KGOUwcoSKNH2cO9Qo6MV/glE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32d93c1-ed56-47a6-6e46-08da5528558d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 14:54:55.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pciGxx/f1F6XLWP5lo4XUC2y5XRE9JircGsgYKGOlN2Q/VomS4JNc69RN/aDI0+yQiGaGsx7iHFjnswOuR+RbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8299

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..58f90473e495
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/mptcp_sched_red_init")
+void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_red_release")
+void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3


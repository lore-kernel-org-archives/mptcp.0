Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633892F47
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 13:37:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcXjvsMygdLtv4rnqF8snV4ZsNDVHCCfrXHodJSQMlstNsBFj0iBECfjGcjDl5gMeroG31vs8RfD/pBX8RK8hyUB9Rl1aUoN9OSk1KjAzoXmA1xLEDRu3Y1PqoapoJPdyuLbW2TgJOUAAStf3ZLWFlAFJrQNyOX+zylUxJ9lRhuf5ZxVDxvQN04g3qHgmBJaERfChacIOd710ZIGTdtOtfRHVT04FHiqCGFBPjg1DaxG6x3NEGDg8OWObwL5Kvh0piAm0jJaj3yz1jVJwaKCC6ocKK6qF3roRkDQq/tV2OKdNmZRTJqVZWfy9FTqPPMILtHyptf3a7GpmM4OUwadtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1wOkWwfSWqD441BoPgl1bbwBkTnvH9YLbUx5Hqk5aY=;
 b=DB+gagiNFH6fLkIOtWDcqYoiF/nsuYY1sGJge1ejjXz2Isu2XLFm98VkNT+Asq4vKU3aPIreQU3dWMHkDV2BPs4AVOZSztDZ/bvr/baHerXgJ+TDz/w05XBsytj/VYhnweq0gjdYOvhbm1gzlCYqzANg5exfPA45w/18H8nSbyBJeM4sdQvSJoASHtvVGFb/ZZoOU8jG6GvgvfWq8m9YYqrBnH2HRzQelnQ+qf5jMHZA68oJn9SeKnyI+Za6Sny34h3vmztVaAWp4ZiDVUPUVWJzeOnh8blllCOo9fFgqbZA/8fVpdFTvOM3yHoTRBCX9DNXH0DIX1nHZm3i4ao4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1wOkWwfSWqD441BoPgl1bbwBkTnvH9YLbUx5Hqk5aY=;
 b=ILwmS0XjH/PlSt2+EYKcZPr+4l0ftWI/HKhZtUwWpyaFSDzJov2Pl1o7PfRc862Yi1zrjOFA589jAbCNDUTBV4b4+YIjPmQuTsX8TNE4+3uADUC9EMsP1WBHv+yqrsF23OLH9PiISvtI2GxUENKOg8Z7LRteZ7ZgKByrpqXtpLtGNpsInmlu4odC2SGNkyMqAp6mJRYO0jchbBmRnE50dTOgst4pD/OebGU21cOxESt+Fp1460a5ukuGsyGrokAe+ihYVsNN5iw2PbO1blVMbePL2L1of+qtQ8th5duTPRjN+abPZwWYQ093cAMhIguh/KvMO8j3Q2kbl5ctw7BwXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 13:37:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 13:37:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 6/7] selftests/bpf: Add bpf_red scheduler
Date: Wed, 19 Oct 2022 21:36:04 +0800
Message-Id: <fa8fa105a91e17b619cafba6b570e2b5b1c42e84.1666185947.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666185947.git.geliang.tang@suse.com>
References: <cover.1666185947.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0048.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 411e8f03-ad4d-4b73-3e90-08dab1d70506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aKxNjWBKEjr7NwQmIEcQvpQr0qs6fcRzhwiXY2in9QLu2frnw4futDOOpmlE+pnu0QTe8S003UKjsF6A+4tWZ6wuACIVONzIS8wk+QhPHzAqJ58UgmsTj/a3LteRw9vlzALM49O3OXM7JVKaV/63te+GHdz7c/2FqyGhnRA1aailgwf7MXVoWBnXsalCuOhoZGEAQc8wG+0h86FL9A5WG17MQtEltuSCedEtFmaDZ7fOpEWzv4fHjhSsm1rpm+QxJx3qEwkouPkAEfrRQqmJHlbjLwv4jvAhqLT+D53inXD+OezWOX+dQV/kT99Mk5PyUUjTBQRUwObN/ZknYR6Kp/Knk7c3YA6FX4bH1GxmrsbSRaloW8a56XnEQf4IwQPaLpS/1IQD8ElER5oMK2UOObLQVLn1pRBx+bI8fWyov62wr+UAMDW1RbAL8EvyI7+n0mKAqjbQN/GK50hTtx4WhEDxoRvevxOHpZBOMIgFT6YeEXF8CzAtRhOVS7l62PtzrVXYnZ9Xmp2x+HQm5ePWjSouy3gbq9dDfH1Vvg91lVgR1VVPzEMsrhKFbPD6edyqO2f8FyGACGdsGcK8Ekk7nNJAqUzfEbyXUNKiyDVQwf0y2ir9uRUrUArb5aRu0u35qPTcBctOLAchaxJsLMga2/tgVCx6ulRZDgiMfSH7DFar/gx2c8/ESEqaY+Jcu0sD0uue1o4d6/cjQQBBdrirco03DHsEH6YDlg/tIjrVkmhR+281aPfKsj+jzZuQ7koa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(36756003)(86362001)(38100700002)(6666004)(107886003)(66556008)(316002)(6916009)(5660300002)(44832011)(8936002)(186003)(66476007)(2906002)(6506007)(2616005)(478600001)(66946007)(6512007)(26005)(41300700001)(6486002)(4326008)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XHgkgRsJ15zm0FXk8vhKHxviGeVFCJZIKq9YVxDC5Pfk7Cd9AGgUhdY6rx5W?=
 =?us-ascii?Q?MLmC3UOpoj9FOU3h8Mom5MnSAkl+D9RT/n0gyY1f8Sjz4EuniK6fUPxrTR78?=
 =?us-ascii?Q?Dcg2V7la3wPK/orktS/qpmAQxDLiCikZcihjYTQUYfjT8GduiVqklL+Lh/0J?=
 =?us-ascii?Q?3Y0ys6YuePqsGAdBc9NPiqYlnMqNDDPMLH13wjhGTHEhR/kPMOfS+dKaQjF1?=
 =?us-ascii?Q?5MZSjtK+zqZz05oHg3JRNJxiegZIuaH4A5DSneJNalcdX79ee0/wCdi6VB23?=
 =?us-ascii?Q?YtppbWJdNrvEAUCSZSY8n9N08N5N6//bke8VoL2fMS+BGLnkAZJY/yidrM8M?=
 =?us-ascii?Q?XPEQyTBZ9v2gq2+E2Oc5B4fKvly3LOfYAu393l4seR6+efMC2DmBkdIw/ysg?=
 =?us-ascii?Q?zgkz/GYTDugs0fmqTYqy5Q1gC1MSPS1eAJR/gSVz3/qPWgDNQzqj4/c7c6bD?=
 =?us-ascii?Q?HrHtXn64/+Vob3jiJ4Q1CmVBSz0qHCPeWHThQdGzw9PIOvcFX5jk9yQuIIgF?=
 =?us-ascii?Q?mo4TyEIdPaXt5Dpw/FH1ugoIjdox10s1jPJAjNypCaB40oLVGvnRBO9jdC8N?=
 =?us-ascii?Q?5kEbWG8KwINXSkrY6CEHHErbD8yMZGJ8/jaf5e6h7juUCvN3a7hNwPg42Vz1?=
 =?us-ascii?Q?5L8VeoL2Olfpvjxur9aDgDjipEQchxJPpoDqcGeTOdJrxRD36Ie2nKi24ERr?=
 =?us-ascii?Q?bnpkVWuT2W/A7VnbsGhlg6dYEz0K/spKaFj582z36pl9uvD6PNFmvtY2xRHj?=
 =?us-ascii?Q?cuZV+Y0jU65vB/u+10QTpp9g6Z6gdjn/cDj9YL/4Q15dgHHMRfuYjWYeQjq8?=
 =?us-ascii?Q?azj4cOyYQXK/YmFnjPnmR76E0h4Vb/qBKUscEh5n7A9ufEimr24PtArBKWIc?=
 =?us-ascii?Q?cCW/mUqd8YcmKU39fc2FStgAFLjJXnC0YNDaqZMLlYcekBPU830H7K1w2vBt?=
 =?us-ascii?Q?F+GM3grzFJh60YKoz80wNoxSp+mDwrrA/Mi2JzUUTMY7fVF4Cfy3KndjOOYy?=
 =?us-ascii?Q?WLCCyXBbmhN7T/592dSt5qygTf30sQy/+vPsevWreGXv2W4HQXCsjeOZfZ8f?=
 =?us-ascii?Q?S8Hh547OnOwM+4js39QTCmD97aDvslLjAK2wY3Ppv6JXi4yMFrISVj5Hry1C?=
 =?us-ascii?Q?8qFV8nwbO2Oac7ad4DB5YMebeL6UneIqxjGs7qafiDDFiM0En5MqVb657Rkr?=
 =?us-ascii?Q?3ZPHaabEZ4cEz/l7Eab+kqYqig2FHS7npuRRr+HpetOeEUuG7spGuDkGLMBp?=
 =?us-ascii?Q?r6DYCnt0130pWiImV5iq8I9ZyFtptlrmQtwYpA3w1ZI0vENiMLZ2w40DxGWy?=
 =?us-ascii?Q?RerUi51IoaG7rzFgqDjZ1t+QgWQC1BjosHrQzSL0BHS28QtBz/dFQlkn0RxC?=
 =?us-ascii?Q?WNVJuhf29om5HjvpFUySiAUjjP+3zG1hduO7QcOE7LUOqurzbHU8gQafEw/O?=
 =?us-ascii?Q?gN+55zGM8kMxE9ztNZPgYxT0CKY0PW6Hrf2z7TXPq0+xOjSoLXmv3zaV+4M3?=
 =?us-ascii?Q?r99elwtDr852K3Br+zIrifS9BB74XKS8Bi4/AWdyKpJy+GwmFf7TdCKDbYo/?=
 =?us-ascii?Q?FlzvLJRCahZbiqZAN8BUQ1373yZ7KMsEPx3fttz2MAPXKWF1zJ3gfWRfTJQm?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411e8f03-ad4d-4b73-3e90-08dab1d70506
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:37:08.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRUEsd8E5YfY/Yk0jZpvTPV1/iiWwid/lZGHHLpSyKHRhZaxG7QJC9vTz6eEglGAU0Vqk1WSrw7gHi09nc7vog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..f8a9b4d1630d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,37 @@
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
+		   struct mptcp_sched_data *data)
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
+	.data_init	= (void *)bpf_red_data_init,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3


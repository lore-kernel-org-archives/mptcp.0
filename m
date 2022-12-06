Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299F6AB3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 13:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNRfXbmNva8AFW7pRUX9aZVe3Su6dZGwa4NXVltXu0VBKX4xVXjt1usR7u5Bgh5uTvDvEq/558Tek1SxUcIOjN9WeAj7Y2porAi0gNL5AYKsFb/WXYOGnSyfyJShmYBf+irSjl+mIg3XmkdkaohFDni2XX/cc1fY6GpcNvidW5eEZKJGw9pecDNkthWsfctbmrVSWZSTSF9cdAtpg3Qe+S8Gn0XqZHWT7/MQTAgicaju/BxtAt6iYMnJSi0NKLFNGFf0ldLiXWSBTXh3Y5vLz/VSfaTaXBIsdnhRY2W6EHRMsicF8VVJ3JFBNoj2d2WCzogd7JWGHzR8VBeiD7ML7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=QRkGKxndpKoIXg+i41to/bxRPArOdR5dw7EuLWYWokXxBMD85I3oZpgSRp78kWvLlZufBb0mRLaIrjyQ+3Oe7jUeVCZrn2Ak4Rfm24YfAxGu4usbeuxcYM9PBFYUPdVd6BjQqAoXnjKtbcvQtofdZRjeH3R+jSZWLHkkz/JWFybk5oZxwFz1qAhanyjgmyMoKLRJjwMMdxTJui04+pVXYOb2UkxHC+j/6m7IRMSMy9SZKHhAaHw8B8cb5J7PIUx/bkJx5aDKD2l0Ayj8L4b3e769BL4cEW86dl7qo6A7VixcC35HVjjAqCysGK4+ci2REs3Xjf3YLYxF4yT5POBgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=fWE8VH7smJDZte3DaVfWUdT13ct/UqrFUsWSeciTYvHQLn2I3X+Opj1FC3E7IhSQAUC0g5yv9Zho2Czx8z1Fr8sfaR0FcXpJ6dr/sfbr0YlRPqT3/RsJUVsx+Mo2yf8i1oeHhWLwGIq/HdJeiAwcP5WiaZf8rWRUc14B6YVTD90UD4U20fHWye32uA9TZM60SBM12Cd4vNoFvutCQYRhlyFOsAsDDnWblFQNxF+YM0IiLwmmO+jxVq2j65PoFJsLx7owZXzeOjKiWZH4qpouEQSxBMmG0JwrWETWq0MJRNgvw7pdDi7KdlmG0vIN53F3Q12/V9O9u16DFmcpPBw1Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DB9PR04MB8409.eurprd04.prod.outlook.com (2603:10a6:10:244::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Tue, 6 Dec
 2022 13:24:19 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 13:23:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v23 4/5] selftests/bpf: Add bpf_red scheduler
Date: Tue,  6 Dec 2022 21:22:20 +0800
Message-Id: <e9aa3bc08cf1d56bc7cb6828a067494831255ebe.1670332660.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670332660.git.geliang.tang@suse.com>
References: <cover.1670332660.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DB9PR04MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 63dddaa4-6317-4048-b445-08dad78d169e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BCkTJzg8gMIz4JnJ6e7JpE19D+RZSZYQ71soocUe7GPbKAYDO0wOFWGErCFQixSGzUtnTglDAFC2Kk3cvCzC0IXb/mdZx6j2XrNLbpv8U3s6utGx2UYEJSclrKNY4TvneKAtRnqbKtRygY2NdZo3BaCCjHJJDX0NrtQyt/KotGwdJumjZrXckUpEbCD29uzU0d1Xo3BzK0z1bqN9JYhHF9TEePfmf3d2gE81C4zEzIwb7rtCakBL1zRTuoZ2ow4uVHeh6zs0X7R/Et50vi4IGhQlYXu6AFYXXGsncb6o4J8aZp/A/NsxmEY0JaEGV8FVFmttWMK9f/EwjEZAYQaYNTo4xOGsf+8gul2i5M/fBMntKY3VRtfUQo7Q1lhP6FN496bqfzFCNAD5wZ3/jWPtroWunZK6ikKSCbAXGfPb9O7Qv4a5Ij4fqi+Ld/b9mzECdsQnqEyi91q3z7Izww6ACLNxnjryR5BiAzndRQOAxNiHv7ifDnRRi4ENEOA34tj/LjLSLXmBXFB0LDo9W1T77ZbTO2nHAcGA6IYCzBcQMg6QKGJj7vRLIRIjO7BVGvHULiiwZsaO0e3UzGO/lxyQzalvEWK83JhqfJR2kGcE2DZH/jMaPuwJLCiDhVpnXBFXgK/9DmmAsGDgKgi7ya5Kug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(6486002)(107886003)(4326008)(66476007)(66556008)(8676002)(66946007)(2616005)(38100700002)(478600001)(6666004)(86362001)(6506007)(36756003)(6512007)(6916009)(316002)(2906002)(44832011)(26005)(8936002)(41300700001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GnQB6+6h+SqCOpbmtFMB9BSOgMZAvT6SDEzakQhk+TECraEmhkBPwZEgXdsa?=
 =?us-ascii?Q?TtCQ+LZusxHxw2nc+z8I4aIAx/MQ9m2k/N8MUJmY61zi+rqdXiRZ4mKMwfxm?=
 =?us-ascii?Q?99NN1o8OF5u1W50aq/KoqxbJF6ph9slXaCyjIGvbisOA4vtcWPqBLIbjFY0R?=
 =?us-ascii?Q?M6D7Naq0H/lgiiSCbkUscEdnewDbzCzdbSkxRCWZ6IL1eTXTwptHTe+4Mwjx?=
 =?us-ascii?Q?rAQBa7LG0cgjtaOn3AvVIpwhYUmS2fQ5jzZm5JoQidO4VUc0/+yAr9w1xhqm?=
 =?us-ascii?Q?3nJgpCs26BnGANoS0iV/ubnT0g4feAydcIaK2V0xOKxMnULPt1moCgnCuzU9?=
 =?us-ascii?Q?3hxniYsgyVBth7ABephhlhVGJe49LSGhypA8JNa3UYWegxBjxZ92WktSttbK?=
 =?us-ascii?Q?a7mCvlT0cbtULSPvTiy5vjJet98H16qxNycDfQL4MntrHJkMEZsIrZhgJHis?=
 =?us-ascii?Q?EMfxc+ia9IMKqxlmfFW+WerKbMIxG48VmplE6i1btKQ44dheBhMNKjcFwM8Z?=
 =?us-ascii?Q?leDcAvEFwxISIVI/yTgDgOh5EF4IrvhFeulkHWV44+UxlOic2pqvyiYcy5+2?=
 =?us-ascii?Q?8DpzvyY9wHrRkB+7GYIouYaeOph6LHuaXWBjnpOs72SbLm4ktSOPlUips0LL?=
 =?us-ascii?Q?48+t/eUW3pVVAs+SlXQz/LvxTda8unoLJkIN3ypoto2hzTfvBy5Lhdhnw8A2?=
 =?us-ascii?Q?8kecmqauMrdNtIznBOszCyRAzsHokW2hkKoaloKDRM9yfOudP2VnnZeEtTVa?=
 =?us-ascii?Q?5PY8/74e8GVJjvqkjTxJk67FdkHheDkbDOkpWX5ZhqCWFjXMPzvz2r9Lf3Dl?=
 =?us-ascii?Q?3YUaZsdHjQ3C5wV6eoM92QrmWtrOyzu1VzZHrsFbutElmUaHhTZEwHoywjnQ?=
 =?us-ascii?Q?0dYEkLax9ZFQymi3y+QSzA5T/Yr+TUbvzZFM3v1xDd4b82d3JBI/jql0cFq1?=
 =?us-ascii?Q?bDlVHkBs2MIrVCbDJymUBGPaMYXergMv2FKVr0BVq5y36zd+8MF54+oVUzab?=
 =?us-ascii?Q?pvpj5z/gzVgiOu0T7vMIeQWjq4YRkmwJT8JWx3RqNT+E8qffQSQaMKfuF1SW?=
 =?us-ascii?Q?2x/XRXopVdstZ1/uN0A6jGwWsgZ0ddBL6hZVWWMKFohMEt0/rO5J9yEqa377?=
 =?us-ascii?Q?+aJPRGOGo1fz43vJ0pWNptNlDzQRLXbJNneqff+5qxbz7m577lMLU4b1XKso?=
 =?us-ascii?Q?YP36NnsINstkbOAT7dgvB5AtQSlaSnpltWDdtZYtcgMCs9j8hV0oM1J8IYkv?=
 =?us-ascii?Q?ZdEBng3/76KizoOZlm9BRVvTrQlwXYHvlXcGn242/E9TKVe1uNEtGwN3/KbU?=
 =?us-ascii?Q?3WaFONbNjohcUyDWsiW3qvmb3dHd9LtF5fWKj13Fpw/cdCfbo7tQMzCLJyDX?=
 =?us-ascii?Q?Dmw/Wffcm+WtYEEzScgTEyEqEyjZ+nfPjMoVCB8v/jkAMGqs6Ody9C381R6+?=
 =?us-ascii?Q?kepSRvhayNK2LztCAUHoZliM+X+q5lGPJ1lDsSQ4K4v9rrMMie4pbTrYSscz?=
 =?us-ascii?Q?AwREh6LF79t7Orwp+C38h1nZWVF13yIIHDoARq6hP2ei2Jjpe+OkKbKawJ7d?=
 =?us-ascii?Q?SjRndwmxtxCRY+qIKaffPMK+05ajL+4J6wOhaL09JplB7yOljd6/oDPNBsV2?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dddaa4-6317-4048-b445-08dad78d169e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 13:23:39.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sKk2+oYYGS3ulHIOLrv3YPqNr8bGc1tN3elhfZKM1llwkB54GQZ9qjkUT8iIkiisWfEgA0m80RvNwOMEVGLww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8409

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..30dd6f521b7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,45 @@
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
+void BPF_STRUCT_OPS(bpf_red_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+
+	return 0;
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


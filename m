Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570810E5
	for <mptcp@lists.linux.dev>; Sun, 11 Dec 2022 02:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIjnNetLUDZhHQvfIHGY+oVV4eJ2JRCFOFO5CZyipXjaDE1ayyWrhR7Xl+5ATBMry78DEV0QA2/RIuY7JxVR2cX/3WfpqBBmpPeLQm8px5xMfAdFpaRmeZwoq39/zuomtQHwlZEO4xH+b20N200SK8KyMe7aagpGZFcKkuxSL12UlfuNn0My+KxpFL4ju6hMdye3Jqd0tK8PHY2ZII6xypsv14Y2WDpPf84UCBvQ9455qtEZNPqila4KO8hYUYoSTb3lkNaBaj3TH1DGySTK3U4K2apco/HjN3pIjodVB5SdyYLKPOdUDoc/TNhdRiApwRp8asuJ6fqV9TJ7Go05QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=gAupQ8aJiZH70alXZCDtD3spypUTVA+3hON5kKHzYEZRB2PW+oZI/XyCLQfFX24CSug+XFrwFsyxlUI8dYIF1gkKImvOqcKhtTUavUzUIiISRczPoxCIddn2IFa7b4f7K3qOpHkMdJB6CW3U8kBIfJt1txR4i7yMd4GRdNrLRe12W+sHU75tGwYQ/9TDybv+Xjnh5Q4eAyvuCjMY5wMsBhEjtI5jHDdg07WkA8kVH9LKCpiqUnIgSCNPwZj/qzQ4jJjzVyRYyXkVPC8cMxhqIUA7xo4n4rnHPiNLymoQQ27l7vchihAnFbh0zrp7dHV0+PV6GDAA5+siB+c0KGpI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=PkbNta4hf8vQFKtty57g3DvHsOA05MII6+fg7QYUNaNuSYfJtEV1SYMv6WZ4R/bAYQ1G1IeVdishRTZSZ711/aMgughlkCEJUY7UjFM0yhyWKc3f8UNwhWz53uJyTLF8RC1nEObj9H70XU9tuw0Ys61D3xWPL6qVIdweQQAjoPIoGNvOZ4nxHUPYEJGqB9UO+xs5vzHAk4VhlYu/EHp9rmLGpb5QzcJ4woP7Z4Nt+SjNrqttpmrpA1x7AtFahRVsBcsHr/34pvNi3YqX8Q2ZVZdIDb8ly/Zi0aD/+AMWp0YCQZck9elwk1B/72acDVyothyNQGR3pgqcs/HG/sM8bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 11 Dec
 2022 02:01:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 02:01:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v24 4/5] selftests/bpf: Add bpf_red scheduler
Date: Sun, 11 Dec 2022 10:00:55 +0800
Message-Id: <5f97717813ac7cf87e5fb1d08cc7815e4ad2018b.1670723836.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670723836.git.geliang.tang@suse.com>
References: <cover.1670723836.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3bb316-4885-4a75-e86e-08dadb1b990d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nGe+syP4agayWYrxqUGCj/rVAOckD+hCOqtwB79G3PWqEbDT1wo8ROEhZAlm0zjiH20uiKGndp6HTZRYkBVehYw9rc6DYiJQXmex13IFm0Qj4WMgIlL2X8yzldMjVw9STgQw+ep3y5rVFf/VsyxJkbToFyy39boTwibr4aNyTbHn4KgajCXd4zHl6hMaawfZ1b5allHWWWO0vMsp2l7wqhLazwG2s4bIqRVPlnw2hkJG2yUdzVlCSZrLN0hFsKHgEG70qie6+0TMi4BLG5ScQJtd7PyU1tQ6hIqxefxRVi+XGQf/u/djJLekvXAhTw/Kak+Z3SAMScGrWIAEcFUDwSh5bVxAQY/4A8ODw8VLQ/w/B/Q1Y1g5xYBf10eDKPBbQOoHq1pS8ZOL9xxL8u0y2ZLXUpztAlefG7Hg0D27GipTowrlcK5WrJ0YycyihbhskRsc5wRs6JXrx4uFdr1MW+IT1+Rk0ARW/7sNrOJSazH7TykkCvGhVeQxtIH0q4wfr3itVHp0/5AXLTtqKmWY8EzoL/6IS09fkiLW+dr9HEasfxdCI9WBVMh6P6hNuZjLoYnFUzIEBuG2zYmM4dOKe10GBXet3iWLzMmUfSoYfVtjqRseMeGJ96rWqfnQrVxfapC1GC5MSWfI7ZJrRrNsGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(8936002)(36756003)(66556008)(66476007)(66946007)(6512007)(26005)(6486002)(2906002)(186003)(2616005)(38100700002)(44832011)(5660300002)(6916009)(316002)(478600001)(8676002)(6506007)(4326008)(41300700001)(6666004)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CBiEdY65VZ0KgCHTPK3II3F5BTcN6rPUYygaVPc6ZRoZabADbD8TRCFSESN9?=
 =?us-ascii?Q?P571Veqp9vWOfCSOCHJ46d0a0vEYjNSsQVarzHdhMFUK/hhVcaDJT888AoHl?=
 =?us-ascii?Q?HYr2f4FrVyPs6ZPQuxUCJhSlLbMP2HJgdspWw3vrToYp5acXRQ/yg3AET6nF?=
 =?us-ascii?Q?wAroc2rbK9hW0THsY0Cc0uoVNe2wiDnQGWWkS5huwJ2tK6t85RbHnttvR3ah?=
 =?us-ascii?Q?lKKCXd32Gs1l/YAISY1HVnsar8FRsOEPMmeNXRwEWehpStlMkdnAs5jO3d2B?=
 =?us-ascii?Q?PtISiXhzag3fz7XFXLH+tYG+YRmvP/mIa5dIrFe7Yo4FwwFHlsClXc9K/YL4?=
 =?us-ascii?Q?2YlTBY0qrNJcmhC692TtoMBFPgc7vEtudcRUG5nHk7X61/fMUGm59mB3aw0m?=
 =?us-ascii?Q?gnxL+BE0NRm+HmtADv13t/jXW+vOWiOnEdPHAMeOEGJ+vnbBD/u2oPP61XEZ?=
 =?us-ascii?Q?Ei8s5xt4x2HI+NyECheRSUjMkzvSSHpvj4pdIcJUGT1xqEh4BLYaUjXKYWCK?=
 =?us-ascii?Q?thBa4eKW+k0Vp0O6yoMa3cNYsbceBVd8x8hwUQ5lv1vO1/qWUo0TFQiDUM75?=
 =?us-ascii?Q?HF0CYegH6bN39fdu91IiPSsJOqxBkEinesUaMCzZ1ItjyzIdIkj+PURyFFpZ?=
 =?us-ascii?Q?bJC+O9Nd6E5jXszHysyFO87ZfPKVY7cNJJEOX8pXc2yYcGKqVSPmRdsH8oqp?=
 =?us-ascii?Q?p69YnlKJLJS4GgbSysojbTCtf6rh4qIv/UuOQzqVMEwsU3jrYtNEuDjMaYSr?=
 =?us-ascii?Q?mmqdZm6zxPoKp57nQdtlYaP5KkpSKC8hUw9jVmz1IeIrmpMt1ZQHS3LwneRx?=
 =?us-ascii?Q?bHJSJCkEujoN0f5q0n7NvsVkjng7NAvO4zDixI6qFjw+GIYSkyYu+1CIcMFO?=
 =?us-ascii?Q?5Ie6/ZwXxRhGiA5VGBn7r52sU+0rYfgn0Jd+YyzUAc5HGcRni1csBizwU1eg?=
 =?us-ascii?Q?GCSxJ93unGPIwqK5VEWVqI+t9Me92oFCjNPX5sC4EOIfbKjRg1rrmotgzopu?=
 =?us-ascii?Q?qnoewkOTKhd31QqlDCmqkoereg9Ny8h2pMYRNQzyvM3acGMegOMb14M6gDAA?=
 =?us-ascii?Q?hr85TW3tB8dn5oMzN5LOMzeRDqz6kl9mfO17fe4D9SPN58IY/dAepzTdjnsI?=
 =?us-ascii?Q?8pjT5D+o1MLqjti9xolodRFHMj2+HdWJGDhrJyXNNgJJVNUVKxzCUBADKvBX?=
 =?us-ascii?Q?/ij/7JYfKDSv/cl6YfzgpNc9xf1chiy9kZVp2dtpTnHHVkaX240rERXfr1/s?=
 =?us-ascii?Q?f3x00pJy1H7v8sdpZra6Q10RZOSj9Ngi+7KBvx9EgHI+OXo42BjbsNs6lnht?=
 =?us-ascii?Q?eAGqE+7tlv0k9otxfhbE2Meb/hMNhUSuWynz7MkwmIS/hxuZsdU7Y1xrcl9w?=
 =?us-ascii?Q?20FIHkVWTt5EkZYRUO7Z8dlcKEQ/jcE3Chac1msS8TA/dS2AvPVeWeJ1Sfko?=
 =?us-ascii?Q?lSwYXrlf7HcPtTSaQ5Ig3s+gnpaF+KhhIjixYBZziamqRUymtpKMmC2JWxKT?=
 =?us-ascii?Q?lUC4odz7Pzj563qtxjzzHerLAwFQtXxwSGIimCjoq6Mzi3yGmJ6Bx5Z/eP2q?=
 =?us-ascii?Q?piU3c3ojUAvbpM0JSavJIa6FUWmh3kqKN3Nccf4aRYEKl5UQd8zglw+Dhq4k?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3bb316-4885-4a75-e86e-08dadb1b990d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 02:01:20.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJmFhs3t8YnFmNyePXeXoNIS5NiNAQ132sL7KKUUWg9xtmZfs3I3k/YGakFqTr6T9dXlWOKBanQS/wpAnvP0DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

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


Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B76D22
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 13:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxwxtRyhYPdA8bIqzPkDx/DAjSyt8vVZ7nPoa3pm2hHCOxxxcU6U9EMDuLyVflJRbwGSLRzJeELt6epzEVk5DqbdM2i87JpVbThIjUio506DARhd1rQ9BurohYlHFFaDDtnwQP+fAlj4E+juurFmUzMLGaRwKbQvEkucye6prXeHKaRr9GF2aCKFAQglhByZDHDiXha44L1cP3Q2B5HbMWtiJJOa8X3XU/6S44eAM5T1RHV73LP1IYesC5CHanlglwfAICMsFaHv2U3EYPHy2wg2s0g6OKUATZtEtMayPYqBQ0ANslvHFlcvukSVyengkw7awYB65eI7zdNVar6dUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=f9Zsph4iF54A244/w3aPtIUjYmVtA22TI9/eSGNvi+rqT/K/bW8izaP6+LSIwPR14lrpWy8Dlunl8J7EVZH4u6/wne/iL3DwdkuAmSYYCJdATJobHRPlIRIp+jPDxHS7EFAoaskNI7MmN6WIElCCBMcRN81nSRyVA9yH0516huPywHUTE7UoPLib3tV5u6Pv7QkVdP5X+w805527bL/jfgeLGpi9enNy0Gbp5htuUJpDoQc5O5X4XNlGwQIjJHASTWGuY8+qfFnDxcEulZqcZhSA27/60hzeXVA86yWI6X6ki35uesQUprlBt55BPZZs3rJDptNRQMOoIQiTTieewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=qZnaE9GtODT1djTIEVTkKmCyeAVy8puR7ATIguzV2R1iYsXB+3lMijo/F5wja/rojLklFnunaMbLfG7xdPwoFAKfqFnq98inJ1w4AKN5Ojv2Rg8pTj87SZR7ZFDXcT7LXclSpJdTssbWkLG5dhMHkXclxZZzTYTCM3pz0DXNkv3rPZ1z2Njllt1rfqzxoIdSTjwdxFec/M1SJpR3GkDm2GDha+zAJmLKEzgNaFQBYp3F3j5WVvf5bEQTgt7i50czU/OgAJOFqtL1JztSD/++dionPuqAf0LDBfLCwWwz/MIp+vJHPS+K8HF5cQWhFSkBNrjsPvRY8B/HrY3zH2DCHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8327.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 13:33:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 13:33:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 5/6] selftests/bpf: Add bpf_red scheduler
Date: Fri, 11 Nov 2022 21:32:48 +0800
Message-Id: <2f7ad6af06b2628dc20d03f5f62826114b16defd.1668173360.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668173360.git.geliang.tang@suse.com>
References: <cover.1668173360.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 1021f842-33e3-4713-23c2-08dac3e94953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eELBxZYAqK2jOm+VNaIBGTIO9qDa+7cOAxevI4duiv++c7Z/3VJHUKTG+XXydsvSW3XQnDn2OHO8cVSUTQNxQ8hcn8JtFFKE9fh7rJlFMvHK6QaAvCn4NJeby81qb4Qr3S/dUSF1K17c7xzAafBfnyn7WLJo4FB/41Cm0QDNscnZyahquJ0cuGI9wHq70bz0tU7v4xyJyHAo3WpyZw8toQOj+LO0hvdWYNEx8iRoYbqjNdkY0feg+WcA8sQZFL6L7fi/qkN2yD/7d44o6EW6GrDNgdMS/HQZiYD2rzMJDuzPOOJg51chv7wcBXE7Qb/6ENPSbrXk7k/0AHE1lYHKp+JPKndyxYcq3FTQ9PP+JqPN9FxWHcSHt3hpBE4w6VmU2mP+GwLA/LrmJE4QnGiAiaMpcUnJkq0nYYwoPkqeDYKHuPlAX1BzeXyMaYr+vfMsxb5iIEgPc74SZv0vK2BwGCgll/tF6qCar6oUiXVeJnKF6NKkIRCz6W3wmtr7HK3xgWUdYiYqf9RZrwHA/db8dOBdvJGkwCuFmITcfwQ2B0sbJ4y/6rAYWhNc6bO3jNnifYyg0M0iEGk1FGlg9UtLqdTKCBZE6k3ZkzfjM9uPRXAffnkB3404Va4OiQfwhBxrgo09OjKKOhB3LzmaPHbUNU3/PC1qEaah+Y/HGQTsI9mdWx1qPP50iYeMTfQzGxvlVG0qbnBk7KDcvtKoxGEyjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(5660300002)(8676002)(66556008)(6666004)(4326008)(41300700001)(107886003)(316002)(86362001)(478600001)(6916009)(66476007)(6486002)(8936002)(66946007)(186003)(2906002)(44832011)(6506007)(2616005)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ywA2h2YgURtALp/2GKOul4jftFfQ74zkGB79oRYFDRRwpckiPshve9PknZDl?=
 =?us-ascii?Q?H37Ug6LszLVVxG7cp7/GpphUjX+yhC4qZNXUkQ7BM49QWwI4NyeYiw3PyphH?=
 =?us-ascii?Q?NsN6cjRP8iHWmFkoNJISv9Ze0dS40fGYiZeGZ4MJkIBLPGjUDsMl1l6An6Dt?=
 =?us-ascii?Q?0o0x2FsY+lZRPubIbPdNib/52kNnFifk3s65CsdIkFlEbBZLa6jksW9l5Ncy?=
 =?us-ascii?Q?XeqXJ0roMcjkNZv5E4MxhPwkJq1wtiP5/ujklQ8LCGUhS89Vr4ZyADy+zYyX?=
 =?us-ascii?Q?GtC29wHXAYGLMRmhV9TpcXbLSzQXn3Ol1ytjVv2Kv2pWV0iDqrMIFA9erR9A?=
 =?us-ascii?Q?+MsFwr2ApNwBPu3h8XqSr4GLr4dg+OxqRbrfW/LAWrYN/F/qehltwaObN4EY?=
 =?us-ascii?Q?afOfWWDgA7/9LZW4RWhIgYtyrri5Q2vq7vbt5Y3OqHQ3h/QtPKtZL29iYAKw?=
 =?us-ascii?Q?I9RsltTMF0wzvaXCDj6gtwI1h0NWOylYupWefrvEL8oYumtZtBLFmENEIK6j?=
 =?us-ascii?Q?YPz+Ady+GLKsK7/qExL4dI/8SDVow7Cc6XJRWZZ1Xc2iCG6niGQ9/EbEBYoP?=
 =?us-ascii?Q?/x9H9E8BYIZ7k8z6bPXtUhN3CQLGOf6g5QzI1IkttUYS/4l2FwJ15VM871Sr?=
 =?us-ascii?Q?0TbV238t+LJN1/ha5Rk8wCCJihizya33RHYpDpbteuwQvG9EVjvlJZGTV0MO?=
 =?us-ascii?Q?10JuwfhXiBsLWM4qdG91FPjQMRzpXxL2/2vMikNI9sjIUPTdKeVA7cfLTLSL?=
 =?us-ascii?Q?SlcUfliWex3OZncGO7AkXfvO8ooUFEKZyHUfU6EWo0KNjIiqvz7Nhnuk5EUT?=
 =?us-ascii?Q?xEVShIcX4dc2Wf29YTfAFiNQLlCMpJqeO4GNnsXRFOOnGt+HTbT/i8392Z3D?=
 =?us-ascii?Q?OKYf0ar93Z9UZc9T6gZYfLKm5EWW3sLJrFfcOF7YuXd4BUXNkLaxhfu8egdC?=
 =?us-ascii?Q?9Qo/b1/n2M5sXGCbKGHGwZbeusU/ZETkV+MF/DErYRiO4INRAFncGllVpjme?=
 =?us-ascii?Q?1Uz38aWBcFAPL5vekysWt4I+gQ92WDGbyu5Dzu/DkbCx6/if3lDBe9VwdDhk?=
 =?us-ascii?Q?NQEfs8fGOuSAgB4SFFKLR9DT5JEdBfqqMkxeCWwokykWjovvkCVIh0fRGdXo?=
 =?us-ascii?Q?6+ngslfpx4x8DvBpXPZl2MYunxJoFabZgIhj3iARXRHxvNNGtNsL98fdkaLN?=
 =?us-ascii?Q?Q+MiYYXuv7uUqcyTU2lFbuzJAiiphVuHxPzirBrpmzm9VKZkFtZ1xvtHAu9M?=
 =?us-ascii?Q?tHDW1Zikruj5wMWmT8VNHx+A0vBOFR1Y5ZT6D9Fz3YldpRLwUJHolbA/igUy?=
 =?us-ascii?Q?SBu0f3M3sT4MzmzZSEg5QVyyLZxkb5EnWa7ZHwVamCVa4oopXX3zfarsL2Zt?=
 =?us-ascii?Q?duhsi15QOnkDSuyTG2lRuLNdpNO0TpVxhm6tJJV6oXtFlntIeSyZzF/hgAN7?=
 =?us-ascii?Q?AcP2NY2zfIV8l9a2DgLi5B2FOwahdvuYOzC/mNLFDK3mhiiBXih0avPgxR6T?=
 =?us-ascii?Q?djsNl844iYeOK+CVZu8z24iLKuzrUiNHOYEguFF9L2t2sFPO4+UdTDi0sn4c?=
 =?us-ascii?Q?vH5o3KPbjd+wUQpTRE7/kAthBH05kjUb2EOwRJbQG3cwfEg/cYUcYwTJsSsu?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1021f842-33e3-4713-23c2-08dac3e94953
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 13:33:15.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzFzAAsOU7rFvJUxPobAUkf+csoMQCiG9HC2VTT7nHivfGLF/gMwJ+YqwxHKvqM+X+Zud2RYYkv3XuyjGp+jKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8327

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


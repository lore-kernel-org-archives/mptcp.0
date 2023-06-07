Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB65664
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Dy4+ft/ImyFuf4J78i+SO76HoBROizfmq9JZnsJ98W2eItSlT6CzSHa/sUruijXMLD00a6UljS6lDVe4Vux3n58MsvWaAUnLTF7UdpY5wjwu+CmeD/wC5uKld6m2qaj8onApzO3u2ckEBCPi1EjdEP2TIVDDxI1GFuYHb5+7aHftM27dPwJamCA8kNWHnBKz7DBQh3vZJVG6LYaJsEOhVM9g3TybU6rG/et0vLeo2Mpz7c0e3SCr+2rO+oSGfcA2x85JyF35uvxf/nMLPLcMHvm7NerFx9MpWDsqVVCrMBnznYXqWEy0FyjhoEYj7VZd5m0eYchYXruJ3UYTnVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2Ro9XRc4QMXxeS35DjM+OwsCfuaHyAD1TxDPyPZFtI=;
 b=HrP2+kAveAGfkdxP1uvbR1/bTBoseDGiXIIvZQfNyp/mbZo30YiaodD5hWFyxIVRxGcHA0R+9OrZ6KkGwERhcbG5FTGQ6P+zQv/NyJg4qYZKMTw6Z4IynHtIBie9fdPvLOtaLI+lAKkV7MvaA8Kby54OrlLbOiHIoWA9Vv6wgXnJACnZbhzgMNWa7yzM/bCsP8FMCOEWeTZqQogv09BbMHXKSIxkPkc5IT5LTgn4lsy9aphUEXY8IPSiKrqnLsz6qIZExHD/bc87TKnbOmUy+VwhtDXtVxs5jrOrmpi1z722JnNA2gQKe69KS7LJY4b5BxwTt3vJ7mI8WxGG5Rt/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2Ro9XRc4QMXxeS35DjM+OwsCfuaHyAD1TxDPyPZFtI=;
 b=NroYogEbgmKRoeoQ/E3PWJE6CBFO0ALgWdF5cRreNnwWX4URaQWHmBwZPCp9SSV3vK6jwM8S0HXHkbWeXPdyEmYbTgfi/safbnzR42m5ijH9BXXQ0e1ciX0vAil3IuZVxpRt0FzRbp2O6XY5rFcuOZXh5USw37Gj0VUUsxzHtz2UVr6LCcgSqi4YjyZtYqgcGHQctnvT4EMicm0PilW83hAoq2H/pUBEEHb5xWujMm5Yo3zrWbtuO7G1uqGov1aN9JwTl05z6JNxVpijZ417uaVyXtKTuZMjKNQTCtfe4hsmqDxSIyk8DPS5Zayg/wsaRPguUy3a1Kch5DKbeJ3d9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 08:41:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:41:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 18/19] selftests/bpf: Add bpf_stale scheduler
Date: Wed,  7 Jun 2023 16:38:33 +0800
Message-Id: <d5d25ac6ac8e525fa7c9124d8e13340c379f0142.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fecdae-09db-4618-d8a3-08db673302d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KNP7hw6vxikGRHn7+EAOGYTpNhWxJFDu3qCLNY6lKzB+ijdVrqfH0rwxWWHNzvXloJU9Jl+GCmQ02A4ZWKvH19Q1BzfL/kqQWa7A8ddrubs1kQSCGCaCe5eMWfxUSwyKPbDr6/YTQwCHlb0ZNZ7s+vNTdZXIIkHUdedXqzWFS2g2MMPcwXN31pXYPf21wF7DFaZUluIp4Qxr2RvRDy9xVafl8BO+bky/QKf10WxVOeoGpIMLDlesKkSl+Rt6Se2jfn4n+w4C1paj9B+J3r+5u5lV31MwSbk0pGQ3rKd7fa9IBdwEYgvUe31KnvcDeze/Ru3A4BXyBHskAe+F4xUwDk7hTeXTzB0wuCw2/0Z9QYV0njBmxs8vLgNi+osVCj8z3g6b+JkKQ2IQdP4aBPIeXGN4YtyNYZX3bHX082UbI5FM0gYfqY3p4NjYdkgpGh/bylJ19ZAreZZ17wWKog5hPAzhmB3ZOS7aHwn99RwmbFW/g2L69Hy2VCVUPyfJnAlFs74YdhPWN/ukVKvFVtY1X8KNiu7eYrMs38AIw+OXR/i+y7G+FTDiGWCwtYLMf+1Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(107886003)(6512007)(26005)(6506007)(2616005)(83380400001)(186003)(6666004)(6486002)(66556008)(66476007)(2906002)(66946007)(38100700002)(44832011)(8936002)(8676002)(5660300002)(36756003)(478600001)(86362001)(41300700001)(316002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kOys/u4R7J7toM+prqHO6EUTgh3V4Xe3qZ6beLjfWiZbgHY/82GGAsgz+TR9?=
 =?us-ascii?Q?n4QkMSSrqf8tU/lcySFxm4sBQcXypbGVa1gdI6h1gV3YVrt5tChDvCakOx4n?=
 =?us-ascii?Q?vXN6Hx7fz4p+7ymZNQ8VlyzHq4Kohp3uvAw078NBU/3yJfcSC6W+TLk2Dh+g?=
 =?us-ascii?Q?qolfwe6mpBk6Kj827CnHDA2FXdAI0mlrjHdMsYWxzsDiALIA5trEhLM5z90G?=
 =?us-ascii?Q?yI42M4KK1M4feX+X5nHSMMC+GJwksW5dVhKXnGkkC20S/m0zCmFKcPRZGlJ2?=
 =?us-ascii?Q?UNFAIM8GV7zZEsbHjJyXxch4XiI1Cw0bAsk/PebuIM+ffDe6OZ7bhyorj8hP?=
 =?us-ascii?Q?Y5iL20xeUAzzDMC4ILpSm0iSRYGUJZ5P1I+EgwymlvOpvspPx3LQKNAP5cwR?=
 =?us-ascii?Q?Hyxschm7/ZE3FfrDGiiCabTPDjf5SOoQT88ugR5e07rbOlnxpWEAZe2d7M80?=
 =?us-ascii?Q?2T+jOKm6qnD0NHDpVUSELnS20Y2effJwXtuQ5i5cIwn999xbt9lWLX3N/LIj?=
 =?us-ascii?Q?yA7/yc1lnUUvpvVSX7yHDAutWo+ACIRYWUfs1sL7odcJQ69WrZgpgwhAxiUM?=
 =?us-ascii?Q?cJS9YAO48iYdD6HwNIfejULvgqbRtb76FojckHOZxHXhXLOycAEQXFVPf5p5?=
 =?us-ascii?Q?MpYMqsdhR96sCV5Bf9bgzHXnwfQ3kwH61ejPnhhf5QkdIJtl7Fk84TbwG6vl?=
 =?us-ascii?Q?Tlw7LWHbJdv26v1zhngqdxIuwCZrg6SSTOxGujXt4K1rJfMAlEVvnkmX5gDR?=
 =?us-ascii?Q?c5slZ9rJtphQM26SClvzly26OGy5u8vOgroo90WdkVfBOg4EVQPmy/TSZFBV?=
 =?us-ascii?Q?bFVRogzWaZTr1WDZfs+EsbK1mccD2zlYyPLcx7HmhYemKErDBro+uEyLpdUy?=
 =?us-ascii?Q?hoYxitI5QbSl5d/lAlhE2nT7bephQ6+Tjhy7n/uy6Uu8g6KlRYoCRzblUWzC?=
 =?us-ascii?Q?wJdZPe/ewi5tOPk+22IMnP/xrFpqezKhZG95dN63c/R+2FMgKc/OcE/iICQp?=
 =?us-ascii?Q?NUQakVUZmbTBvjq71yvXpT2fib5b4z3bCyHk9Ao0F3IkeKcQOsPIB5iCyF6b?=
 =?us-ascii?Q?dtLWwvCIKR4b2o4QgX4O+gYUpVaDaYtSCar1BfHY57h8FrOVcLQAUqnzBMi2?=
 =?us-ascii?Q?eFemVvDF5HsEkBdDfiWCrp8rGtyi1pm1+Dk4BcHbV1KvFyhg5kPwWjY6FG0s?=
 =?us-ascii?Q?f18EN9ofojygrVZHlomOflYlnwvlLPE54pu9vrF4D4CWepGlxZAHLAdVgMl+?=
 =?us-ascii?Q?wZ60oTgdW0twmtZ1LubHTpf0lujdnfG8NtPh3MAU9YXmXQIYTepW9D+oid3P?=
 =?us-ascii?Q?2UbdZd8THPcT3u+AxHFYozq9k0RQRpjmv70nQ5nbBLGIDXHXmHoJmJmAu4cS?=
 =?us-ascii?Q?BEcrQXRTBPSruHySqTrLgOwU79K1tk8e3jD46bUQ4fEGwicawsErz9Xx6Vm+?=
 =?us-ascii?Q?PZXI82S0EI7lXICcSLwKbGqsaz5lGYtmMhKc81mUO8PZKBoGOGCDPnsrUaW6?=
 =?us-ascii?Q?j4e0fdB7D3ikudlhOd5lIfWYhKtAgGBWDTcgrY/LBRHJx+eVScTLGbpbRPja?=
 =?us-ascii?Q?pot8EyoZ5QFvFKexRWRWAHO+YFXeoCAOdQTpiE6e?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fecdae-09db-4618-d8a3-08db673302d0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:41:39.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhiihoBMkPhSSBnjwffzn5vpANpd3rGTUUjbioJLHkhEqeAZjpIi3prXqe+7GID+zCrz4qaqVcgfAjQHx4qdUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467

This patch implements the setting of stale flag in BPF MPTCP scheduler,
named bpf_stale. The stale flag will be set in bpf_stale_data_init() and
will be checked in bpf_stale_get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 2c35cbe05d33..9fef10fa8aa6 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -236,7 +236,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 
 struct mptcp_subflow_context {
 	unsigned long avg_pacing_rate;
-	__u32	backup : 1;
+	__u32	backup : 1,
+		stale : 1;
 	__u8	stale_count;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
new file mode 100644
index 000000000000..125e84a1e49e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+static void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
+				    int stale)
+{
+	subflow->stale = stale;
+}
+
+SEC("struct_ops/mptcp_sched_stale_init")
+void BPF_PROG(mptcp_sched_stale_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_stale_release")
+void BPF_PROG(mptcp_sched_stale_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_stale_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+	if (data->contexts[1])
+		mptcp_subflow_set_stale(data->contexts[1], 1);
+}
+
+int BPF_STRUCT_OPS(bpf_stale_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	int nr = 0;
+
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], stale))
+			break;
+
+		nr = i;
+	}
+
+	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops stale = {
+	.init		= (void *)mptcp_sched_stale_init,
+	.release	= (void *)mptcp_sched_stale_release,
+	.data_init	= (void *)bpf_stale_data_init,
+	.get_subflow	= (void *)bpf_stale_get_subflow,
+	.name		= "bpf_stale",
+};
-- 
2.35.3


Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D828C07
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbqbSuzxkdcIjbvafISFbYIsqlscp09K3AXVzzYBfHRA7Ir9Yp5wYFzsHUYtGazl5fxhpbBmRtmMJt3SIUVei/8wAKFknwdTujD9z4iSfFhHUggmFbr9QB9qttcRDupWBHXlQTWLeYeOqa51Ymu/yDFPXL+dJBai0HpF5A5+bQvz7Z4DBTZuClirYB/xxRwagndeiYGY+tDy63buZmHgiTeQvJTz/esy3wvWm8vMcRTafSml+x0VMwwIneTato725l6epPLnl4EEBDSGlKawFPg3P11fVdB735yuYkZJFVGstBajJPjuccvmnD9LQEzqnJozfa6Dzdtp4eUlnzFLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=S4aMM/jddXcRCFWGff1uRQmVM06ZEiwwx6lFHF6kqN9HMMGIeS4BnC1NxboLDXnuOTYxXcUP7oJLAH/xO08ADPniGEkXY2BixefL0YDuCVmZIx9tH1GQsAHySd4GuhkCcG7fl0kqMgjqEGH5J1bf+6QZIav96muJQlAle0kS1AVAYJ/AF5aMBvOQvJbfLMorHtP7JNZhVkfZn3y8+urednhJbFe4OpBFWCSfnMtgnsFH4jotgInvO0SkoIY4lQLPA16TQjQoUoM45MKulF2hTXRuI12LfHWkSDjhyMd9C4ub/vgr+XWiyH3/vfMQsX6o5E5U8B3rP2W2yNDL56l4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=uy7EEZaw1Z+NeM8EBsxj3OUKrvuTPWYiCg5atTYgUAtX1BbqmtWk9/8Is9zxyXpA1Lex75BDR4s+ySo2jsAV84dQpv8m2Ul9xf2TdcSRFRJMROavxCSIwH1GpTttA9kuNsMMNJ1CDfXupprNGKBk10Cl++RJdTfstuyRjXWXCgWCahDIYq26kfZ+xeSO3eQXZ5WNN2FnKBK+Kyc3sed0k432u1D49s0UAn62VnsGKlPCxWlxIQFMXfeahmm6vkZmGrg4XTkfH/dXqi2NWQxEjIkiY9ST+ZYrMXAGwvmFS2WLr5Ph6e3gohGxuacnp5Ob8jl/G9nFVSVGHrwbHDI6tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:01:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:01:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 08/18] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Tue,  6 Jun 2023 16:59:22 +0800
Message-Id: <630d69f631295955c7c3b146135387c019bbae74.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:404:e2::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: b301e20c-fc24-41c4-81b4-08db666c9c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hiv1wZb2ZsKweTN1U1fpZBbxAliBnaNSrjOpNhtHXJrhSpXkN495XJ1B4LpfEowKI490sQ/ESUUN5l559vhbQ+0zS/qAq5vUfZZienVUHRhYe7iliHsmAZj2TUmDIVMgw7OvOvdLEjbB/dGD4KxbjcAAp2HD6g6+jreLAKBx/tDMwCu5tuwUlKzPSfqWB+F23tfRIR18soTKiu+jO/UDaszBQ0PicoFCTk8fF4hPAIxd7MfoPwPPPFmaO+KXZmQGt4f49QxfLq8xjCLCR155FCqEppLUpQ7rqFA+F4FRZrkBYzfIWBrYq5FUw5iewi8Vh3FgRz6w8/cevvMJfllw4ljJQqxvqf4Gfz+E3L+PnsrzXJ/qyMaOhgKAitY2yyQNxB2/wVeG2B4KgCNjJDwzauq9/MHyXr/qe3OfjSfnGUpy/3O5KL4nrrCwgXEpmyKQBtO9rti82WBR7u7Fn4ttJzLE+Fe5S4+OBt7QsFfgUCQfpty0uXNo0EKGavnGidPA1GcObrSdsFGJBFbycJSHe4W81wRBPC2lydZX+1fChUNvtg8DQu8vpu/l720zf7YG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(4744005)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qLZpQI0xszZ4yn6NZAZmEGW9n3uyKNfX6jnfXmNAcHCDnBVr59ZP5iy58D3l?=
 =?us-ascii?Q?RucBhagyVthrTZL3IPzp75N5+6xsDtLI0p/oxBw0x4oJz5/omXDPDk/p3Y2u?=
 =?us-ascii?Q?Ayk7EVuZXj2XAi9akivW+vW3vENxgM/MsCabmkWpVaUnyOC/c2LWOZ5O0dcF?=
 =?us-ascii?Q?mJ9OW2lfSSG6jH8dKcjz4yd5xmgjeRGg+5Oey5c5yXFEmeUabAWQBS04G1uh?=
 =?us-ascii?Q?ym7x017OVMozFGsIpR6G1PSTJLngxcrfRCPkL49HjJUL+Zq8BceccLQo4EQA?=
 =?us-ascii?Q?TAYzhXFblXtJZ9kASNoZcNFGivbUR88QcCidyA3ZfK6DpAdCX0T38yyabF+0?=
 =?us-ascii?Q?3KoQQjoDR9y9JlZMXqdd9AKp+49j/hPQ8zl10RnbmX6cWK8KOHYeIoQpEXZu?=
 =?us-ascii?Q?xTvF+N8yj+0aYPvpd0iHnEM1DT3pvhUNooZuysNK/povb0aY/IU0NQfVjtf4?=
 =?us-ascii?Q?599YuLeRtSMPbDk3KjZlOGzJJKIgeelcdd8VN2CE+/6yCTGgcSAATtIyE+cO?=
 =?us-ascii?Q?SYwOXlr9zRRKtkqIHdQzZT8+mg0VMbUAYAwtGKkpQ6Mi2L4KwQBCi9euf6Gs?=
 =?us-ascii?Q?9dEU15qc7KKn5pzNyd04el76BnmMvwxs7uJaE7QFOC3AhCbCqDpNR6UAyAlu?=
 =?us-ascii?Q?GKN9qb2HrDdFIKBu3ZXyHWl5rNFLF7UvlF57JExT/gga3gJ82s5Pkqn4Gc2M?=
 =?us-ascii?Q?hO7r47sLggxDIFY6e+kKdKbDE18SLw++T4e/gSXd8mjk5ZElD/TFP80tIBCW?=
 =?us-ascii?Q?mQEYOJ0nWoVFPL7iUqa5BiqIzf4tc6HlX1CtCpbIJ/UewxPhWrbAcd03/lAj?=
 =?us-ascii?Q?szwkJM3XQxsEYLo1+1yuwhLCIDuo+FRvPU4SIj8tJIHgND5lyL1xwJNmGSiE?=
 =?us-ascii?Q?sZfIPUtcW14025PvFHs3enJoaHMLvqm97r0hIk6SL8dDbbTBO62e/5bxhb7c?=
 =?us-ascii?Q?4sLHlGaha5qRpw0vc/gF6d4EWfETL6/VVp2dfyYl/SO1Vdq/BcjxqVmz/JI1?=
 =?us-ascii?Q?nMqytNTyNEHjFCkfhdFb3YJEUm3p4rGWsJ7t67HYbUyM6hZTAzmTTUTzw24H?=
 =?us-ascii?Q?eBgvdnou3Z8E2FsJL1BE9MSm6y50Sa9D+9AGqjuuEvHgazfLGGZG3pgLwYkN?=
 =?us-ascii?Q?JcTNxXppd41mdcgK2IWCooEzg5DDCBqYGHmiTI9pU2TXOcMbZrubNH1oaCqg?=
 =?us-ascii?Q?ndiAbuGqdWSUnm/jWVL0mqAZKEHlyhgXqfJMFFEyEE2JpFS9eQnIHbb+EoJI?=
 =?us-ascii?Q?fBpD9ILhBdLYqPmGCjupLL3HxvBdvtsYyulSdmdanGAQ5LuItTSiKo+K+SCV?=
 =?us-ascii?Q?Xj/NDiHtSoJ+qtlcc9ioZeGlpU/JZmqKtTfeBZkhYWXM26lMTmMgLGMqg6GZ?=
 =?us-ascii?Q?CiVlEdy9gI610mngHBThx5bwhG4X/dIQ2dfn+FfCN75NhBv60xQauaqE6FdF?=
 =?us-ascii?Q?bMg8kL6DxGX608q6tfTrJsDhyfD/y83EN9vza88hUnp1KOkMnrBiPYMIaxS6?=
 =?us-ascii?Q?oWoPnqeCRtblhj+SHt8WJAhgWHdQEgYcMvm3V44vAzKVNAZFokB3Wn1G1IeG?=
 =?us-ascii?Q?jzI/6s/zMGcwEfPpnMae7FqWQ6Qu9+O+NbPziVGl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b301e20c-fc24-41c4-81b4-08db666c9c50
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:01:26.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+WxC+Ht6B7V4ScNuw+zIOwGa1YvAKHkiB9gz1l433ULRPoZIA58AzXpDLdxZWyjMK8noPaJEaDy3iF2L7azTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

Use two tabs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..fcb023a749ad 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,7 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
 
-- 
2.35.3


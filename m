Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC913AC4
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYtY43DwvgHLIQljHR6SbkFmB3dMrN/CIz9QWGS0E7aYUMmt97kcN4yHBKGFs0nXAPrQCInzdura26Cw6QlGD05mc/oMJ9xDeEBru7SD9DnekwSai3bjlQOgtQDz4XCjsOTlBc7KcG6S2kIXqgg/vd4vDy3Z88urOOukYf/eoIeHkxQKkGqYHJeh1+qERSk/W9gIhFDViJmWPqvwjs/u00DGiCOvuHchYsOLkt1E9KtJEAnHSdpTbx71DENwxOTd9BUfDfwGh8S83T2nAE26TMkrSJ0vTu7OSBJB+yjCLCBJj6bok9/8dKqmpHOC5j7voGCgFzGpDtVboUNPpx2SYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY1WeZc2co8wYVV7YLG8dRaNExyi+RszWAcK6ptLLog=;
 b=NmQ9K8+YUXWEBnAhyXdzlunaGsR8d84FzS6/OuHkBTcZFeylcpM1LOssTXDfuvN4dGpXG0Aj6V2q/hujmRKJgWkEcbhC+LhCfxvtnH3JEKo9VvEQToqMU7so+VYK/CfFU0U4+/LVysAKing6sC3fI5Ha6FHOKcLHrQsuC5notdjCt9F1qOTvuczWnaLPDAjHwh1p4EHPlmFvkegFnurI0ORwLg4i5np9yHlHBLEXR2QYtQPGaMPFEzf0z7gwT5nASQm5lCp4eDAp0o2Jn2Yt9f7BJh1YmDQZqRx9ASdxzExbFn7cLc6421HdjYjzf/LNz7iqKVhBu3XeSIeFzKym5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY1WeZc2co8wYVV7YLG8dRaNExyi+RszWAcK6ptLLog=;
 b=MV1Yl0n7L5vkNUS4Mw3s7KyTbzo5nSibzeQMWHItPMOYvGB6PUOFtfHMR/DTIFGXvUuYN6bw26ZOxsdv+vImmHJozsFFH/9y6jcFaDMIK0+2XjaKdz9erAfhHq3FzxNpwF+yINkXYNqSw8jgH+R/L1axrAvA18nGYb9BKTpUu2GZOn0jD4fqz1joYe+pulAc9fC/xJuzA4YbYoDM64BN5osXc3WMTKkIgQ7tacAP4l98LA8TN0TMmmVB5CO3+rbIrHEFeOuadnh1htZnGnQr9K2nBLZ1FmMmBQb66+ra/QlB8yNHimCzVUwlQQec0Lr87fKfNLnz6Bq/GAIyJiA45Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7728.eurprd04.prod.outlook.com (2603:10a6:102:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:12:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6411.019; Mon, 22 May 2023
 13:12:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 1/5] mptcp: only send RM_ADDR in nl_cmd_remove
Date: Mon, 22 May 2023 21:11:58 +0800
Message-Id: <8fef539019c6a13f5bf689e8d05486d09e813648.1684760588.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684760588.git.geliang.tang@suse.com>
References: <cover.1684760588.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd456b9-6e7d-4d55-cb6d-08db5ac63023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eOCMDpK9lIg37TphG3cebIJkuhLbahnLhKvPhj0wwsOQaMkzOAdHuiQp3QO193bomh/ypWTvqX8Xe2p0ARSJaIvslCBNhuViJvzGYgx0fkd41AX4KVpNZ6Eiuj+a+rILbBLogP08wYTgTQf/78BFqM2rcSNeNujaHgdvSwIyDs5dmn++NG8gIIr8kBrye8L91bnwNaasFeZs75urhcEBFjLrdFuvMj75++Lj5r4lKfR9kLrYx9EV0kvPDw8zo54pNmf7vsX4tyJdrsC9AcBfUDE4zj05v04vXHjGNoV8Ph4CtlLFY2BRppmf6uq9pKHfsZi6BBgCYMhrL70A2gyBH+YTf1Wsdy+j1YEoOes5AkuvMeqHTD+jUeDan7VY1G2Q37Gqkq9ZiAyhL0uFrseDGZPp4a+kJCHAaLgs80DenR9FP4fi79Vq6tJtDvT6rtG2ZI4DwAQQ+TpmpyYd8y0PcX8hciqbE9nOWeX90gA1Q21gNKPLKHFWQF6MKIleunlMQC6PGBkyTdVZ44wTZgj4p0yjmmcKPMAq2713C/Z242A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(2906002)(5660300002)(44832011)(8676002)(8936002)(41300700001)(316002)(66476007)(66556008)(66946007)(478600001)(6916009)(4326008)(36756003)(6666004)(6486002)(966005)(6506007)(6512007)(38100700002)(86362001)(107886003)(2616005)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dOxC2LLcrt5ok6Le1GMtNFZ+N3LWXX5SpSh6Vo+5F9fvEOPhUIfOT2iSuE1L?=
 =?us-ascii?Q?8dJTx9jScO+0b8lcuNoTp8N7ySc/GkEWsdZgYsCtG3RHRta9ehQaeclH7WbU?=
 =?us-ascii?Q?jzoQ2aysoNxaf8uO5Y9PMtvkvlqa9HqQKz9LIHQDqsnOMWaYHjnnmrpO8jPq?=
 =?us-ascii?Q?NQbVBuSZzlDjnvQjr9bp09F8i1Owpiugm7nxsmVFTlraKHktcA0Xws+3PanX?=
 =?us-ascii?Q?qhZrer7E3Yf8M3HzqPtJaMUgXr3r+SWvw6SZYwRn4mg4scrhrQyCCbP7HMoJ?=
 =?us-ascii?Q?nP01dEqpvnUHezySvt8ch6xzBXrxopJOJaUaAGuybIwilgnxCSuDebaxDZDA?=
 =?us-ascii?Q?TdLoRHScHR1VQqLTuCxifX5QCZVHGJlUUd3nL7sbD9QWF7yO8AKuFxUAHizu?=
 =?us-ascii?Q?ks2biHcUsVUIcaDt4kozvFqRhs+Y29BgzwWiLw6le+DXrbiKTm65hTcBTHBd?=
 =?us-ascii?Q?NcarMsrvfxCayisHAYUpxHCYaYHH6W6TXM94WihopoWknZ8YALFHP/lhE0cR?=
 =?us-ascii?Q?KazQQIKSwfsOT11twu15N5aj/5bKsAuco68QnavOJBuzmAQiMKx1/Vzj0/0C?=
 =?us-ascii?Q?NQFlHTH1UASftG7b8EXNTFjn+06DYrqdGDrAh7h9iGWgix/Lm4oQc1QnXEh3?=
 =?us-ascii?Q?mDo8mH0wblIlKn7Ph1EZwmajh7XlFdfAJJ2UiKBaJ58ArgItNFIH9EORPXgV?=
 =?us-ascii?Q?qicKV0HKW0ZutLEvt8CPoLFvBbXeicMA3Gtjl9P8/oEdHBX8Vd+q801DKY0h?=
 =?us-ascii?Q?p9omlVc7feN5kSFWZsLqd66iVGaJ6FdUmZlmVQYu8MCtneq0G44YLwqwDZNq?=
 =?us-ascii?Q?Q4d4zh+QqMQegfZyfhlq/9OANJBu5PjshPaQM7Wm8/AS1WXHzzKw8VOYJVU2?=
 =?us-ascii?Q?mRSykqvqFO74MUP0rkFiaEuXOb8FfrgXgFozqXbsIqdxcaLeSO5Wnd+eQlz+?=
 =?us-ascii?Q?CicbJmIISzLHAOyQg0TizqJgpWo3wZZVn09tCApoL/4z+nCDrZ5YAfb1Numc?=
 =?us-ascii?Q?J+9bGOVHBpU9DoDqJg1IZMajOJXgzsoKbFFA54pP5mQHfI+33LZKKlmWxtYA?=
 =?us-ascii?Q?6CwZ6f1zwJhkdviqQTU7EoKAouwIA4iL4Rjd6T/bdIkDxt5UomF1FW5+EIhI?=
 =?us-ascii?Q?aRoBustPjr6mypajDT2UExMVoHb/annzoCYHtY8JDwDvhreUXrdcgOXcEJ2T?=
 =?us-ascii?Q?2UG+kRyVwESUsGxjy1UYbJ6/G4YUxiRA9ZJFBBT0zTCaPOwcbTXGiZ2hQGv1?=
 =?us-ascii?Q?qG0Iq/FxDhb24nXk/42DXBF46PSjQceozLZi+VJHsSYgyfJkznrplRWkWNPL?=
 =?us-ascii?Q?aJjZJKcB2vmnatgxzl6CyTuzOqU/CVLqFcSY14T7ta0H9i0IQA1Gwgzl91fe?=
 =?us-ascii?Q?xuPtTXlOT9nUUqMTkh71PIeSuRCxaEwadLE7BDDiW66i1MzMGdUZ23w1CyPg?=
 =?us-ascii?Q?REMTSkMqcuSl1mWKRyjtu3TiUjC6KXWHYAwbuuBzecyhUKCVcJ6IEGY64nF6?=
 =?us-ascii?Q?L+2hecXHoQsEzsYhypZXPoDh8aQmnoxz6a3j+AptCuHcErrRrLFsM2DXoDDv?=
 =?us-ascii?Q?Ei3X0Fcajy2DmswaaYyyiNPvdYZ+4CeLPHBfW0gR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd456b9-6e7d-4d55-cb6d-08db5ac63023
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:12:26.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VrNF+Bsw2zUaicihzYM/rQkWPyeZFUinzVbD1fHnYYQw5g5yT7pXG+HP+CLpD8T1mPFoNAIVZW0F15imR8GjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7728

The specifications from [1] about the "REMOVE" command say:

    Announce that an address has been lost to the peer

It was then only supposed to send a RM_ADDR and not trying to delete
associated subflows.

mptcp_pm_remove_addr() is invoked to do just that, compared to
mptcp_pm_remove_addrs_and_subflows() also removing subflows.

To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
command, see mptcp_nl_cmd_sf_destroy().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h [1]
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..622698fa36f7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -188,6 +188,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
+	struct mptcp_rm_list rm_list = { .nr = 0 };
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
@@ -230,12 +231,14 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
-	list_move(&match->list, &free_list);
-
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	rm_list.ids[rm_list.nr++] = match->addr.id;
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &rm_list);
+	spin_unlock_bh(&msk->pm.lock);
 
 	release_sock((struct sock *)msk);
 
+	list_move(&match->list, &free_list);
 	list_for_each_entry_safe(match, entry, &free_list, list) {
 		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
 	}
-- 
2.35.3


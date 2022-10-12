Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60083.outbound.protection.outlook.com [40.107.6.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BEE17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqLAIxY0WAF7MO0LL8N8sWS6VAbIYAxF1xJN/ZvEgI37KhSMGkPh9KNvZehbV0rI71s8qkQeZVXcFCea2clco3UBHNimo+yafYGHtPbbzPmOhAKcAvdCR1i/6fpvmYDShya6fmr0pR8hXAEvGYPL4ffL02EkgEjZc07BfI7Yu9/uMJ9bbqwT7kGwCWJdwTXE2nihvMA84r5OJ/PozRxzuogCROqoCuHVQeiCyOmOe6N24WxfdrZb51mxhbbFIYOgfLxTsmgWrOvR9awjuI9qeJ4cXTwJ0w6H0t9OdC77ruZwrCaOmQVnlVemuyhLyC5uZAs2eSRTGVoG5rPRNrPphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBUSMUsPmrHQ8wzuAJd3VSUSQUxo56dkeKi0OG13yVA=;
 b=Z0Q23SW9w+/ihFFDgsB5GPGFKb/ZRwQ1m7uxjTZZ/bBP2Iwntq89eqgecM8wmDOHltq+opcwxo1EDi3gfsKYAWUW9gMk5VgDRKc5UPKVvtakXkRIMKaNurla9rsREUEms4i+5D7DBAjLg/LXlG2EY4y/VWFqtahDMnXU58WRmIWZKEtKXcOvDD5IqWBtqDbs5iBVDEyYHAgqZTEfeR7FLYwBc1e/g94T97C3PgpXTBMJqGPv2yel4WthFM4f8tyK6XvFHJ2FHi9f03luY0DKlXY6Y/4IuqiycbOMAua+2jJXWFXT8d60KBQYgK15Ggq4tJ3BLVAmFCaTdVbWYWxAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBUSMUsPmrHQ8wzuAJd3VSUSQUxo56dkeKi0OG13yVA=;
 b=sctjpuQzKQAz51auLH/nsQKxp8LbsQOlfv9w71FM5mrGAQ+u6lnhLGi5DQ/CW7fAHlJDiQSVjSxo6CcTID7XI3juPu2vmY3KP/TT7If2Zm3EyhCWWPdDJ7/JhqEhOQQFzc0KqysH8yyrNloLt8ulL9jc1aWWLFap01WEhM8xyNrgk2pNRzgL4H+/8JT3uW6THQ8sFKAXsIYUsoDyTn8+LpIA8qzQHZBEJl1rOP0FDvC4EyXE2rIN6+H30BBjeIbikhPHAuO17jOCr6CiLnIv0dZaKKLzbO0od+03XaXtdEeAAM4utiBy1nahF0FRNvuHaQ5k14nukBvAAe6HkmqOiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:51:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:51:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 07/16] Squash to "mptcp: multi subflows retrans support"
Date: Wed, 12 Oct 2022 12:50:28 +0800
Message-Id: <1135e8ffb09bca2ea627b7f624fdd7b0578f8061.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f914ce-71eb-4abb-4e43-08daac0d6d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vo3LPrFjx/vYRCznmRz2PtFicm3BNhB4h0TBwX1t+qUlOYeVLWGtSAQW0KJ09pxsvXtq2td8tRfC9FmfoRceErkQ1EdotEmcTMuxAACabRD7VoilOq+9AOHWpsS5wibCAPqErRp4UXwL4rDRJZ7AgwjIdQyTdOIc+Sl8/vZa+fAZDL72r6rQaC+CoGRzITq3KjxKPDOA9tsyRSSyPUwLWufXAu3IQcAV/6Xd02RBvpAIDuvpzydb4jCNY5/fe2mRom9HjjhLLoHRq6cHLOEZPH9DHJqrG12BjoaAijBAqYpQHkGgRA/sghUXVSh4BTPhzECQtzY53n/2AdyJumSRAzOQd7rQGmCcY4iJ+wEj5t05slahwcK+4GySe6vb19SglUt5KveL/BZAT8HWYljc4nNYvr67y+tW1kfU3XqWq3HlzvwV/Wz/mCNu68kBrgnBzquremGLjnawGZ1bR1UiVoRTrZ5Jl8auWMaaDYa3ATfqWgMDmdsAo36L7hTK30HYu7/rwvLBqFQs73s9FXd12/goyGv22tWyNG7bGQPi1LIJZWQIpX0AS4Ubbf8I25xM3+Wh7CrDFV1DMTLeJfKJEMJR5oeJRYm9yz3lyY8lTPG+vswJ/AjbgMvqJ0dfhMHcOf2pqvkopcfriX3C7R/Q/A/mW+3FyCPQsJLxxd3InVgUwSSk4yUbkGyTGS7GsJBqDij8l+JROVOBZKa5zxyUir0V2M2H2h6nWiF9JW0bpoSda6CQpU5pVmL9YS1Uy20c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(4744005)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ghwIUnE2u0av4f2/31KwmtCq/z9RwkLp7VhkKs7KyF0jIJAJUkSSfyPLyium?=
 =?us-ascii?Q?irNaRG1U8M4UQyHemhEOfZoGMDS6Loj+8A625shM11OiJnxvl/mZkpZK+SIs?=
 =?us-ascii?Q?KnLdmPnaF0/sZhbB0jgdATaK2KzxJi9yAgwgC2enYvSLxu4mXStV7G1xtWO2?=
 =?us-ascii?Q?BplUg94H6gFIMLUvHjSwSJDUoIoayv7uEVoeO3LULnZiyYb0QjHn0RaEwz4B?=
 =?us-ascii?Q?tO6qDdTnehBp1VG3P0uEfZBcvP7Ro6TntylZYga0ZxyhNh1Ds7nU3pLhgmOS?=
 =?us-ascii?Q?RbNai2mbJdfQyzXMHN2q1PCW2CigiizijVMO0HTdMlgi0gA089eLxDYnuP2R?=
 =?us-ascii?Q?zJ2g3hVEQ9IR/cFGGt4GmgXZV/uK/3xEHn4O8Lq8qHLVLsE3KQlWCHf/jI/t?=
 =?us-ascii?Q?KYJZT74kbhHCzHmm6ejZ0CcE4nl1fVOutH4xlDKlBlO8+czHntc8di/u+SRV?=
 =?us-ascii?Q?vzaha/p7vndybj9zh2PKMzfT1R7leq+/xhTPvfmtwcIJDSOc4XAV4xScCrw3?=
 =?us-ascii?Q?ldPNura09nP9QxCdevZKb/Lkhn5jlAXA38gUOqdmSMmyIXGp8LmlUax//5Eu?=
 =?us-ascii?Q?aIDKMce/8lnDAk/iRNvvSeh4YLZCwXEsO7j/kGHmLcrHG7IvaI/Q4khL76+5?=
 =?us-ascii?Q?3v3qFbcQe6GbfrGFCDLu6EwGKHp3ziTCpDmVYs9Ucvn0UzBCoxj5UDaCcQGB?=
 =?us-ascii?Q?iXdWBmmB3ktb4T2cnFOf9pfgT3MJkXzwNh/3ReMP+N221K+fyiNHksP+bVRG?=
 =?us-ascii?Q?ED+47TO0X6EWnOkHaC5AeQlH6nQokqikyV9nPA01oeEeHhaPcKqnTdqhCZCg?=
 =?us-ascii?Q?UPQOeMr4kEoZFjziRG/9C39m9Wm8PYGcpaQRGllTHD42RtYOrZaoTwvS39ob?=
 =?us-ascii?Q?hEjwTJIplptZvrqGiOHzt2MrcY0053DhEuYycEl/8wpJzUruiy7uHzjI3Dd0?=
 =?us-ascii?Q?tnWt9MgV42Qh7hTY8zmflPt7rWpKHbUb4U53VHyu6fa3+iaC7JEwKSfYclhM?=
 =?us-ascii?Q?558Fr7ox94vWISpnh3u8AcKQTy9SvzxjQkJuDbCe78x+C/tuL/iJ2QJ+p9WC?=
 =?us-ascii?Q?SZ5th6NgVPWB8j8mlCdpYkxhUlzhEpSIaRl1VJoXHYMFU9NYcJtQ4cXXWipV?=
 =?us-ascii?Q?9U4jq+/r5gQuO+3ik3WdJI2kTK6DahAS9hY3XvgOd+dHpSNL3AgCltDaWsQy?=
 =?us-ascii?Q?9FWbn3xtQBmgIOdC7tEUVLhsZB1el9xl3zllMq6Sp58Gh03uGR0+9BTmPhxJ?=
 =?us-ascii?Q?l7Ns+8D4FlNGnlqE6Py0iDjgzAZWauT50g/vkgKIRsaCt6ONkrmVtBecPBeC?=
 =?us-ascii?Q?ffO2ihdjQVjR53Z6wpgZ9HMOsCrI3+fM8aTS5PNAE3LGUbKERiFYuQQc4s9o?=
 =?us-ascii?Q?YfewcI4HckKgqaOsQMSCA0Q0VinxNxKUSQyvM8xRYPhKa0DS11D+oQUNtRam?=
 =?us-ascii?Q?q8Nf2olSiqhZx/3Er1DLuP+8JlYk29/XHBwBeQd8Ik66iBX9Z0rpmdtivhJv?=
 =?us-ascii?Q?5bROiPpHlGKlpzZBn7YHbnktXBEyIPT83rO3jw8yJBwcHSZZoquOwWRo0pI+?=
 =?us-ascii?Q?RJo2lGeCkWpF1MQmwVhb56JhKfMk7wgcwIG3JO9AwIzTseYdBI7LJKctQesE?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f914ce-71eb-4abb-4e43-08daac0d6d9f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:51:30.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vobVZi42DjzLsPfR6bM9gfWzODiObtZNBtWjxD8JjlWRW3dT6it064b14S0R1t8oPu5aWm4mScW+HEeLhTHH+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Pass data to mptcp_sched_get_retrans.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 18e439e180dd..0d9fae5718cc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2489,6 +2489,7 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
+	struct mptcp_sched_data data;
 	struct sock *ssk;
 	int ret, err;
 	u16 len = 0;
@@ -2496,7 +2497,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	err = mptcp_sched_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk, &data);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
-- 
2.35.3


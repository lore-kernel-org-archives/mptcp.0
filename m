Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41048DDC4
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="3r27gDgb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkAUbYoYxnVEN6BAyQTgfrFo4/tMshPc72dzxcl7xVjUS5AfWNmE4I0EJOSD9q/dV24p7GGbAbEjWdGhW3dyDcr4gLjYR/H80rjnPhjtOgyJO0PhjvJ20jn6UM5AkUE4xfusdLeL3pQ8SvR65fFaTXF+i3qb9cFJV401+F/z+GEDYRWf29OTSlYi7AitNEXRIhVW2tlrxrUrU5TOQGE6tIRYAsXG210BzrOfMSJ+ZJCVcrPPNg2iXetyOBetgWyDR69tDT0fr/G90ZBopE6ETGdY7jG3WE7M3dsgIrWmYNnSsRSHjrvsnjkoS6cBGe5Ub/y5aFOcKLgJepAPHrYrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ASbCxDxa4b0kAoZ+l61pmaA2JVoEpPyDyXXLuM+ktE=;
 b=gVvkOm2zEFQrJqAyjlFQiiR3o/84+S69jAbdZIgg2N2zE4p92fU7HZvkVN6LIhuiydCzr7GxDb2BjVAgnB8ep9BFrUNDyQgcWauG7rolnpJYo0Xt5LrVJvOzn0Wu9yvkwoRGHMGesHxmUODLPJCVVHmZz7G+Lj1JckDh/i+bVTPcZQvC7L/CT1tXhU1/12gMx0hx0E43kYASxIv4jBuX/X0QLq9PCg45BUHipl6hgtutJpXegu/0QA3JmWfw7ZmkkaU6/rU3rQZCLYHVLq+WZkb34InfHjIPhKxAAGCFulTgvuCRzPjEyooTwSYs1DO8jzWFgoEw6MmmR7V437MSfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ASbCxDxa4b0kAoZ+l61pmaA2JVoEpPyDyXXLuM+ktE=;
 b=3r27gDgbzOne6Aa6EugKH34eH0jGdiz7IGWC40FgdPPfNT99yH3s45BPx+CPF2bytTEic6Y+jESGpAeUvJXYugf1hXp8GRro4qmIAsuDZjFK76dgXbv8Fh9crOUrZQXw4WXqYqKguuWM44G93CAfDQbOpjxd1Ql8G4HVBSutPiqAnFAqy7yWE+dG7o5Q7KDxgBzf1gWObfIeHARSktJRm4GhGZdeXarUiXGLLtJGMz9kN2J+GkG2+BEoaojCtvNWqDZPK5CaQ4I8cjpBJ743IMz1HxW9qLkaZg5mVMqvQ4uUHeJKDuACCx/sCzSxYGcgqo6IerN3YvXtWHTZ8h/Djg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:14:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:14:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 04/20] mptcp: add a prefix for free_local_addr_list
Date: Tue,  7 Nov 2023 16:14:10 +0800
Message-Id: <522dd7f4d906d8ff65f78084f2029376aa3d9593.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbc96f4-4753-432a-8d78-08dbdf699c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nwbNPt4MbQE3HZ4uznnjAI+GQth0z8A3HDjGx4a9abFKyLmbOGOmSJg/CipjNhZwy2H7M2lJBTHVhTONy/PwdYz/DF+dMqtFtZtRgfTN/tw2ps/5wv4s2P4qLNpJaWtJP66bozSJuvaCO3H08tE2H8uwv/yRHJ/HQP9vzH79PYut0FykPQD4eLxqKsxEJ8nhoSez3dhK2DOn3wNZXzrxMKMyENiaw2wnDyWyVC+zI80ZUQyr4oeikjF0Xo+G8qJZbM+6yPLwYR2OiK/iItSYeH9vas4ptBM00zd8APngBEI6Rrbg2efBgdDJgffFeFPPE+L6bO44IFS5oAm/CqdiopDUSXOqOlbSCzd4fjY/ge4bNSDNHlt0hBPdS1vHIIGyGqDfWyh5DomzACExtsyFFjk6qse1glxeEePs4Q7nyfKXQWjV+DI5btiAUTLxuDOqKjZbYuZ/w6q0DZb1U7ClMs7C1Aw+rD7luZH+zihRL0ypeFTezHCd/C2Gn4XplULgF4MLm+bWfSa74N3I8mdIxgKVDHWOEYIeIJq9lHWSGHbRGQ3/+VmL4813i9b1vVum
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YljAEhKn4LEEp7U7+15cDdRyl+fgvHvv5pGngNAU161MGdNcGFuZ8fMWRFrP?=
 =?us-ascii?Q?WO++7ouujjvgxYYBK7E1rWFjPDcHNGCDNzsKJgzvbZPIsNBlQBkYrYDVb2j2?=
 =?us-ascii?Q?YBRWIOwM2wuUS0O9RXEiTyltko65ZuqsgwiBx6XAicgu6M2xgFLwYtCvBctZ?=
 =?us-ascii?Q?cB5oQWN+Yqa1SBD762lkSkPkOxIddLhrSnIqQg53RlRjDbtTNfaDilO/g82q?=
 =?us-ascii?Q?QEfvWjD1nN7vLirjNJ0q1YIU8GIjp4lDE/8iarxuhCjm9Fgj7AFY38TdoR1e?=
 =?us-ascii?Q?AB9VDpde7yhIfmYC0uJYHwmBuptAPeFYPQ6ozHezq2EkfmS1YJZRrIN91sUM?=
 =?us-ascii?Q?nC3FSiQIEGfouLx6RAJyNaEhZf7XuRuYzMMorhtPhq5OJOAZR/5lqrSKMDvn?=
 =?us-ascii?Q?pZ0ib0RfcqNIVHOHsc/iFD6b6IWPHzgmVtccPwNowye2kJywJDu3YSbr3JmV?=
 =?us-ascii?Q?AZoGKUSHvzy7zUeE/doNXIIVt0LI9M3x0xhB1/Ob1AOhJBQzkUJSJXdnm1w0?=
 =?us-ascii?Q?7fcM9FCV2vrMLyaOEHT+UpBXvEX7nWK+X+XzxV4+KTk7VGGtLyTnVr/nL/Z4?=
 =?us-ascii?Q?/8K874jObQPO+NFQAi9yEMlElOkyUOTbU3OpvpEedt6aISd6++SiCFt4j5KV?=
 =?us-ascii?Q?yT1VsKslpTQfY/HyynHD4DOitf+gI7anXm7nnB/lqxj9om+7q6nEr5a3bLMv?=
 =?us-ascii?Q?ASIq87NH8LFMaZc4Fh871KfLKLnDPokWsdkckyNnanW7jO9Vie6yscpm67CU?=
 =?us-ascii?Q?7Jy8z9oJ/PJh26XI1ryE2edHMlGl48VOH2VJBKzbvkezaTGvcReJUlJz+LLB?=
 =?us-ascii?Q?SJp3mYJm2ghhOU9c38Ng/HfYa2QJeS/nO8GCY4+xK6w9qSoezED3rLTbwoyZ?=
 =?us-ascii?Q?BuFF+4XQw2Tw8DbJzlYRuKsrsoGyYO5XAffsNmQ2OI1T/c/PC0UD5ONhcrqi?=
 =?us-ascii?Q?Leb0ksz6BUAnMO3J9TkZ7W1+j2gY3oqqZnc4BW9wmkntg/lge4x7dysQpphY?=
 =?us-ascii?Q?64T5rAxu1v23Fe04viRWT6RvUxLJAcBaytyLqeTxNg1JC9kP90tRfZo34ocj?=
 =?us-ascii?Q?XDrdaC0PJPgiseYlbtXIjgbYGdHnN2+497fIGx2auXgqupDIV3MHYwLC3uC9?=
 =?us-ascii?Q?PLfpo0nggrmQhHf9meFaqRux4Q6JnunEXfapo+FmC9l9dxmZhLWKp7tO5wPU?=
 =?us-ascii?Q?UisJWfn7w+M30bpnzU+P2cKOGZ7eML0rFZvv5R/HXgUtdFI5jmbr5c9sRkeu?=
 =?us-ascii?Q?P1HyVwRA3Vx7HzKH/Y+VCLKo4OQlLP+Eqog2V07A+/pI+NZr+9SwlRKNhk3D?=
 =?us-ascii?Q?ltpdexlulAByjS3H2/XJeRvdfHWBjbdqqWh0b0FbSc4UbwxWc4DOBYrZqotn?=
 =?us-ascii?Q?xj6Y2Eo9w+c8ig6idzgEHgM4tO8gc84TgK6j8XTyf3QXoTYuXSK+b+uLrdOV?=
 =?us-ascii?Q?Ds+3+CV9pJnyAmhHfedASlj8TLQ0XimLZq6sL4CrMVVswGCtEvB3EyWdX/2k?=
 =?us-ascii?Q?5qofIcEtqEFPen6YA7Rv/CZkazOJgzi5P87iL9mxsXITc8OIzIGNCYUBPZsm?=
 =?us-ascii?Q?LHeEg7D1JpQw7uUzKCp+eIzITVSPmb6gDQ8ZPrWR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbc96f4-4753-432a-8d78-08dbdf699c78
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:14:49.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1yRldLelkXme4RRXlxOQIwxiw65hTsFP78wT5s6r0xjX/8KIfD6quMG+Gn4RfgWDE8uGC6h/rXEEOISK6nurQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

Same as other functions in pm_userspace.c, this patch renames
mptcp_free_local_addr_list() with the userspace pm prefix as
mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b3a606a5e182..321224e09d40 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -7,7 +7,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0ad507ac6bc7..3bbccb53eb29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3317,7 +3317,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 88f5b422f941..c38350abac1d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -943,7 +943,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3


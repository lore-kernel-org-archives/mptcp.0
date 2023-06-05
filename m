Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8905684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQxYddXq3K6vHylsKLWuMp5G60XfdP2b0YKsFmIbAtJVuhLhcoZL4C0AuCJUXjSRhR8lupm1uhWt2Z+EM0wGD2A7pjbTCVm8Wxnd9+aNpxWeS7n6PerXA+pKupogIfO07ZTFWT00i1FYHiCmk4eq0UaJC6TUv3eZEf2VqXg/M9AEATLhHsZ6j/vfpJA1M/g0BrhWzb/0DK9P5se11aMh500GdhMirkBwWc82mf2kfSovaN41OeOGavQTEJI3xr5tMSSObTJgLFZytCsQpj4y3cdn2SWVZcWZJ+PelKaByvN+X1JnOpJWnnej6iSCRVo56BUTJrMWqXwd2x+SFCUeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=E6VEsOM8ET4AhEcSfka68+2zQDPBCZrE0bQMUVT6N9zfyIpJ4rWDXv0d14Pt1kHYloZQYbyhxhD5waztlAIuhKsUzCkYQUpQYTtPMAdM5iGYT5JiY5NiKGAfr0fvCbsSr8HWzyvqPAlQnfTAlcjtgnZU+7KJt5TnU0gCGw60uzmZuJKLYd9+UszEkIj8jVR6OOoM+CEzZ0Z1t8L7aSIRVgMj5s5ecVvThRyN5JzpxvjQWRrB7dTuNN8dakxAJFYG/4GcPHIJwocRHm0yFcx2p8MJBLe5oQIUIPxj0yzJ7AJlN1xIDKlWLWOXabqUF98EpKgY857WwTjpEz3cF2gkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=E4+32sZlsA0dimPaCCBMvMOxn+Om4wmOsZl4xtuQZRQy9mOhpLijDWAnBtbxLRloEKMzuAdQkQFj6eg2xnSdrG6hzq9Wu1RBTZx6EDUN+prUTqlz08gYmyXALn7AHgF+bsnVkd4i6jcA+lMY0+cd8DiAI5/A+p5iLagFIa27oXXfD7cmipwDnPPTF9FpbGZCe03ABUCtAlE8VUaY4UirVbi93QebrY25ZF2r2DWq9jc/rYVZnwmhB/PBlnrfWF3tgqlBI1a7JcaFeI8eHSTJHoQcgt11kDuwW1jwHxmtxkT6pXuW8PwZeWmJf5BsW2frPI42/EHcbv3uLboS+OT4VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:04:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:04:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 03/14] Squash to "mptcp: add scheduler wrappers"
Date: Mon,  5 Jun 2023 18:03:58 +0800
Message-Id: <78c762473c2b299ebaa301b15fa9849ddf7d14ea.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: e30ac6c8-fdbf-4517-c613-08db65ac4725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6+v1mjj2lbEkVDlhu5025U28dn5v628MIxvYxB0JudZ1w1Na1X6GKZitWnrS7crLUj5k8Rs/yiK/Yk50MmENcfPCiozBznd7QwwfjWvMxdCBHdY2G317ZpFiv1Jlrji8DFle0mqepwu6dkM4GgJVj87IbC8lSXEVcq1xUzKHzbtI3OW+d7g6Gj/gQR/iPN3rsirNx/4kCEx1QRIDZKGoaRmqO6GQHKLi+X+3ynf8zgPCl4CLPsdX3aQozb263RvryyGo0bcr9f8Au0DM++WkBcieXoAswyVvhgDOavmYQzkPxtFm+05ZrRFFCYLqRax+h8nkK7mHKNCZj3WUf+9SP87Hy4pkCiEOKtb9noo22H8VschZCz0idHovSygyLOpST59yJYBRrZ6HjcV5OyqeBbUWD7YHs7KiFOay/RpRict8YDqzbXz0t06SW312o33IOHooElQ2YIaXb2oM6epWNj8xWQSo1g1JUEfbFxcXUrVM5+UAyQdlavBqNz/hBPaAYa78+BN3zwEcznY9Dft1tXWAGNjbcoatCy9cN/EjSW2KOeY62bvAhKFRN88RIV5t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yc3Arn1mum/oUvTYfz0BXu1N+S+ucimqw6rxKRtAOKE6AaG4m/q3Xp7q18+1?=
 =?us-ascii?Q?4dbRn3nuvWoNpLBkTKwzOwGqJJo6Zxk5gklxrS5f53Z31il9WjEZ+v2vkW7g?=
 =?us-ascii?Q?X3/vOnTzHqH/EGCNsB5nGkM7xh9lKBuVZhwR41sOY5g2OPhdiX9sF9WTgwrX?=
 =?us-ascii?Q?3eRYPmnkKUe3owOi5FkwkoPSCkL5HeAMcOp0zUGRg2L9pOIH5kE+vpgR+e/m?=
 =?us-ascii?Q?STKiGDOZefiOdffqkE+CTCQAfcEEuc4yorZlAsiPhK+tZUgIb0NkYfGOmcC1?=
 =?us-ascii?Q?fxwaJbCZPZbZ8RB/1l+KT1MaiA94RrNXSus9vlRmm9+ktAgQYKiPA865z/pv?=
 =?us-ascii?Q?DFkm85hIC79eV/imabJRqPZ164HfH3Jn+0oelEH1HkrhpC0dZP/K8zEj1wLO?=
 =?us-ascii?Q?GhdNk/CAcFVUUxdbcv+M7ahtkCflBGD5/xzvFrghdIP0FheEFtHpmRf+AQx6?=
 =?us-ascii?Q?Y/3LXZ/aer/pUt+0b3t8ZGEMW2Ez/qOCGMQKWxYC2jDE606PS68HQGezmRn3?=
 =?us-ascii?Q?W9aTX6DhzReZ8AjdZhHPUGMBP+UYV+WZO7/WFaDr+owPHnTI1LPibIGN+azx?=
 =?us-ascii?Q?UAtJSAgNBzVUUUK1s5e04Ebca7shkU6qLhn3W7f+dVX7Xu6BhdyhD2WBN1Fk?=
 =?us-ascii?Q?ZFxzZ11yhcouMu28QpVsQFdTx8spJRHMeqXjTeLfZVvR87lehJPa8VR1TPkp?=
 =?us-ascii?Q?wCx2dkr1efrMOEs0SoZ42UX7JH5eANT4WBI3NPSspr5k8NpwJB3H5wK/wxqf?=
 =?us-ascii?Q?OTZ6GmekV+pfAWahi+F6AV0aUtHELqWm8N5KmgSnkIRcvxqSLGtjy4L1yaS/?=
 =?us-ascii?Q?IL4Q98J1JcKI4B833HTR+FqsDjt28t7S6vvu/20WiVKkgddVAADDYDKAxM4N?=
 =?us-ascii?Q?DECtxZqRL3cUzwS9ld2eLVm/aDeuhfdqZDQXakQQLXN0LB4D3HNc9MbB3BPo?=
 =?us-ascii?Q?8NderFfGD13eUXirlIgSJv8xG2b5KK1zZILIToHZ7S05tEEOjagSqI5E1emD?=
 =?us-ascii?Q?SDrQK6A6xVF0MaDgNCyVOjuKYy7CXB8BznDgvfm3sjr0QvoxexJjlY8blyNz?=
 =?us-ascii?Q?a0kR3697qHfC2k9Z5L5svP7tNZOSdSba1ycqNu+Qc5umVxi6ZsAao8vX+Sl/?=
 =?us-ascii?Q?zzwMef9zR0F4qGAA4oxIqUvSufXZ1ALaL7jzFvmPs2GOQCBEvxq7qI7zrPhe?=
 =?us-ascii?Q?0zVM6TqAxC/WHddvvOJUoJ6zjzg5xB0l6PzPf4T4GZBS9J2q6luUS4ND6x6B?=
 =?us-ascii?Q?NjxPf89EzKFZBxTBk7Vcw+z5zA7kfz88KBKE3jHN+vXbuNqz0z/x5xKuF2qc?=
 =?us-ascii?Q?LBYDpF/rpDqP+cfN0ntTSQP9qsG243szIL5LjW7opFYVEwwx+wuuxjPBONjm?=
 =?us-ascii?Q?LZdOpIMGju2ZDmIEJRqhWSEIKpHiuAp77nux189ILAoe5hi1bcNsS3LeN4ul?=
 =?us-ascii?Q?t7+ut+vebsXPe11fE1V8R842GEirM8TE7Cmc2cOTQZcMVZPeKpyNMeLyz7bj?=
 =?us-ascii?Q?T9Bjsyemv0e1dqPQ/aIcQowMC0bfvyiY+BEwOtGi6oBHDuXbEL4bxx1qLTYi?=
 =?us-ascii?Q?pilWPIqahoRPL/GXVxXre07YNAL50IaT9+GMXJJR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30ac6c8-fdbf-4517-c613-08db65ac4725
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:04:40.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWhumWQW91XA282T8bEQMo9jtt8iwcfAJCbIorWPcW0dmlL4FrC+0wXXczMpR4CdQeN10gbOOyGU/agjSnt+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

Use msk->sched_data instead of the local variable data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a053a9504dfd..5438a86e897a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -127,7 +127,6 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -157,15 +156,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = false;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -188,7 +186,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = true;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
-- 
2.35.3


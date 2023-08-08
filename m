Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85C80D
	for <mptcp@lists.linux.dev>; Tue,  8 Aug 2023 05:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRv5GwdYiWG6Mu9uwjrILRSX32x+z9sbcfIgq9Oy4H+H6uLFMcYCB3lasOEdsDFvnbYC78db5sJn8ZKFoWLJU0MHTO+1ZHStoV4ZdtBupx8pnQQ/TXKQKVPEdfglCgVPBriymOy8kgrD4PDqKOX60d/4Z0phmAcLqrGTNjktNkf70iLVji+EEom4dmQrgSO3CpKaqFXTkEFtmLJFJfXrtHZwRA+t43x0lPKxnJBAd0eyW0hJKrAzwxsGgHF+HZnCZj9rcrYqQVbe3O4xhKdWhooWnbLq3F2kDT+T4iMMR/1d/Jvt0FRnqwUKYUU3Z77ccoS2j7341/xs2O7CqsRdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2XXCJd/g3gGPFRi9FigIonSHLoLOG9WdKxj0s63yHs=;
 b=MR8+AEtScYpuRGT8UNKFyp2VDSrAUIBI0ZAlkwKAerTGq7cV+zgbenbosbQuIfbw+JDCzW34gHw/q5jARjuAtWdOybkzDLZXDqlTFpSTQLF2dEGNADY/r19hMPohwTKNUu1HjDN20rlr4VgqfeNxFUfkm+nSio8YU0N9/FVm5UkGlaoNWcY5A0fbbFkodbaO0us44gaoxMBioczA43sNDizgh8nc08byBLTEvVMX2m3DOg3K8vYyfFE1xHk7yvGu2b3DPrYWpk0cSzU7ua/ObN8K4apa8/jT3lS3MCPR6AvKCSwS7OZtm5Fxumo/DXX/nBARJEhFGrLfe3yEEQNhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2XXCJd/g3gGPFRi9FigIonSHLoLOG9WdKxj0s63yHs=;
 b=vi6A3Ky3ma3PysbRNZPx42bb59MHp8ZL2Hsl1VgZiXPM5fosB6S1xsZfDRzgrpkbXfqf+EMpeR6TgwDto9Q2F4+5wh66xk3sJa4HuTq1KzmIkvqCC6hMVjqnnuV42YVPtunf0BYGzYEmiP58AFioO0kfNfmjxJ+frVmI5GvbjCOcecBXZmSDDPbMiK5KiD5xaUbWvuMoWQlDD5F8nB+IyZj3dFtUERKKU+xIxksqclOR4ppQr3eCnL2lLsOKFXouRJWDbkUJmRTudNB3U+5BOmg+xKTJqA+QGW5KfLK6KSZd8AlFNMegvgO/3PrDuROvWHHlyIDvLW0h+VemOt/93g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 05:38:20 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 05:38:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/4] mptcp: allow creating id 0 subflow
Date: Tue,  8 Aug 2023 13:38:24 +0800
Message-Id: <30ed859cdd93007e7233295599085b905f3ab881.1691472939.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691472939.git.geliang.tang@suse.com>
References: <cover.1691472939.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d56c85-7aa5-4741-41ff-08db97d1ac52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5zHF+hjtJtjTuXGBQVUAyqyW1+JqAhJZLD8t13nsOvy3TQC4o9I8hzXho2FrnMCcDaKhYGUvuknY9IShJneUKEGZHnKThzSaj/rEdyzuOm9gHa8bLr7T8FHi4BMt/2e4iJZs5/S+yOpHS7rR923FlE4+6KRoxu45xCiogkiqzRYqtPgz4X5auWTuvovhtbgzCLBMHyzrjmf8kk5Uiym03EI9/B60XtYN4QDeoVDIFNmrBzmrHQw7CaJDqQxLP9bWGUphkzvshw9JJCC0Jbt7nf6e5OrNQjC8tmDsp9mZ6Nr4Z/nYLJGFKofktVly0j4ew3jU9HGiT5elB5kZKV9DOJm6cRWjDhFTGrrpr4DYxV1nZEhy++459dASHfJFyNDCtKkSMoKM9EJ8B3TiMFC8dIFGUDvYL3e29yexU006FZd2WIBeGFWRI1ZvRwnEA3kStoOqMjUZzY5PtCwJCfhp+FRExwzpnrGR8ZTvqlbrf8gORuQFMked5V4AdF3cF9Q6iSOY9ZhRVGw2N3qXPCHT7yI8u8Hk2LRw6Uo3hpoW0G5ijznX5e/fwlxdC6xVIxsruw+m8yXEzMCs4JkEZbXmTHLAzetlpB9kY/EuEsKCNGpaBk+PtzHP6cfaZa9TV2vvjrAUIXQ6tkn/aNoFhKGh+Lbb/nr6KH/Se7aORDuGvTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(90011799007)(451199021)(90021799007)(1800799003)(186006)(2616005)(6486002)(86362001)(478600001)(966005)(6512007)(26005)(36756003)(6506007)(41300700001)(5660300002)(8936002)(316002)(8676002)(44832011)(54906003)(2906002)(4326008)(6916009)(66946007)(66556008)(66476007)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iq0No1TSdfSqcjjTTUoQe6DukgtYQZpDxX9wcreNitXojVc7AjDPFEt/qA4g?=
 =?us-ascii?Q?v95jVuBAqvLuW8h0NQ3/yVK663Yqq0BempGhhrKJ9WcHp/xZyTNHuTfu7QA4?=
 =?us-ascii?Q?k0gVMxf7G9IHL2qk5JblcX20g8ArhP3Z39MiUY2DLI9EWzf+7Ya3yWiMnuYJ?=
 =?us-ascii?Q?dE2qc5HrNzQqe7b61EhIrr3sK+xntXK3vyFsNarcozkZydfcYTM9mZZedCxR?=
 =?us-ascii?Q?7O2FVt8fE/5JklJNZOnkmMz0XWyPut3F2dfmYrigNjEcuRG4015wy8pfVWOm?=
 =?us-ascii?Q?quLX23L6gDcU4p6025/wpv/NZuPufqTTuNlzOpvz4dD/7BxIdZk6ISe4PSWJ?=
 =?us-ascii?Q?bPxpjAuEPKU/d2pDqlCe7b7yuCgyMVVYd926sElhNFSYnEgub/V51U9akRoH?=
 =?us-ascii?Q?cskcV9W02tkRLtowoJZOjxBLGeePeA4vZoit6GKhkosmbQiKtiNNKUxTqGaH?=
 =?us-ascii?Q?ODPAKL9hdwQKIUkHy5XPLcwRgsEM5IEQBuN4579WLYVOEcwoonYOqMvUWzsI?=
 =?us-ascii?Q?cZSYrZekjIal6M3nnhoUc2MAvJ5DAY9MaWrmAnnwCOYpjWhEgItjgUmwCkVl?=
 =?us-ascii?Q?A+U+/sV0xrDULkz3TK3vTBJghfjOiK2KcX8Mgq36Q16oeQ/uPWUjpAIfHAef?=
 =?us-ascii?Q?onJGgqU8/tYq8IPSH5Hpgy/ECTJoYwV4H9b8AOuPiJCgYoCIG+6V7VV62/49?=
 =?us-ascii?Q?BVjq6hdi7jsE8bTtyv+iSQRdFLRAGCR6KP92WDzRmFowza2W9g9EBlACLpL1?=
 =?us-ascii?Q?y/v1t8LkrSfAYG9XF1aZLbSRGc7imXm+00JjTbkxIfF3kHadkfUast4eQm/o?=
 =?us-ascii?Q?X6FCy1aLa+D7wijnv82MR2F45baKvZQKwEuFRYXwGLpSmugp38Ghk+W/C0ZY?=
 =?us-ascii?Q?e1q0hQUEY8uz3vItSrY0Y14T0Up4KQeP+dVn1tGG/+yd5CESD1lLgUrUOhZl?=
 =?us-ascii?Q?Rve/2SlE8dpRLkgA2leTbe2fvb9Cprj9nV04IJtwepp1I9PRe+KVsSm5cuQu?=
 =?us-ascii?Q?pDLYLUTnBSaGMsK30j8zUqddr2DYDq5u312joWQoiZengtyJTJMk73TiutPl?=
 =?us-ascii?Q?wmNZ8je/FJ8YH1LCHjsSIGNAPxZqVUDVuN0Gc6n1Ule4aP+xVWmU0YT0HYbq?=
 =?us-ascii?Q?Ut8SCqOPXQQjsyORiTXOSbDarkhfH/gJOBPglF3nndYU1VJL6XWfgYjyjosK?=
 =?us-ascii?Q?Mjgjuun//tnmxElKeI/vn9kkXHt5b59vQOAXInXGcvqZLAJyXX0zBQDk3br5?=
 =?us-ascii?Q?v+Um5dRI/88oQPVXE9pDh174bFbTNrLGJUqhIrK6nYKm4Ub1G/MlQSG1djMS?=
 =?us-ascii?Q?7KEhq2aLAewgtyGjISsdaG43WprUVLu51EsvVKSJAO/CdF0nit8WhpWe1G+B?=
 =?us-ascii?Q?k5yb4vnCmYhQSkgEzcIf0UiV/bMqrsY2zlokbGLUS/Zoh8f+O8AUVrLY8JUY?=
 =?us-ascii?Q?v5XNA+S0QEbb9tdcPq2DGeA58iBTIQGRu7JajH1Q6lzGJse3APKwLTxxK2xf?=
 =?us-ascii?Q?4ti62mqSp6pniyRW5uVe8SYOvCV2hY/f/sCixjwZ/o5Ksu4y4xfOdPJu5Qi0?=
 =?us-ascii?Q?Wtubk62zFziF6u6Qqp5JAZZ3vYIs+7GEY2d7bsdD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d56c85-7aa5-4741-41ff-08db97d1ac52
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 05:38:19.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8l2XH1GqDkBvYypn3D7rhJX0KHhAG89zTkcUC61H/8OFAf5P91RCRQj9QrwAEcSpfhl7/vEZEdKgxfIqH4GMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

This patch drops id 0 limitation in mptcp_nl_cmd_sf_create() to allow
creating additional subflows with the local addr ID 0.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5a8aa4c1ebd..d042d32beb4d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -307,12 +307,6 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (addr_l.id == 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local addr id");
-		err = -EINVAL;
-		goto create_err;
-	}
-
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-- 
2.35.3


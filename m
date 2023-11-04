Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09E7472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="3wb4ZEbq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY2oCw6EExJGmcB/fZhFOM+6VB/RtijqGe1EJGMuwckGICcA2NXuHiovg42wx4vmhZMTNwuUFBmi43jCuwuQZmsiwrAab4/4n8SVyZpxolm/vwfv4y0LMGWKPiO3BCJxIYSicIItHZioxFe8G7QM1EPQeQL0mzNf4/WfVnByVFzvw2mjMdM4fz/cTKjX5Ym7C/lWAZbTYc6mehEGW07CNgcKUBTKcGOLc+zNEjuC+71x6jEaR4hH1PljuDGiqDfx2jfZxrGSVtVgTeleHAyyrpm5CIZdou8LuLb4cZQ2ZSyFxOu2ZCxdSeFrzVXLQxENvWC92qAJwCGuOvwAjkqXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7oMntDnZsri9R88qHDRaWM6NL0YmCk06chPyihEA7g=;
 b=DQGoH5rRW6qsmVSjUKo/icaOls2fpteLn9LXg73N0utkve4VSd1ipKvW1hdS912R3m1eIECBG5qIIJGc2+BcMdGGe8+cgraYhfE0O3oy78DQ1IjhUTiUHo8BJpozVzibbQ/s1tXmsJ3G65BO2tiPTzX8CKGbP3pnM954UDaABPyViuBQWMfe97D1kh3IdQ6et33Qn2xgwcr4NyZaRF8nlieO4yIjl0tj+/OUwT7P5K7vf8PK7HZFV3eJV4DEg0Ev268BbZBDj8ImR8sEgSee6nmHP7M9T/PamV2/9Lx71VimLPQdgvQIifOkXfyZhqeIH98AHj8XHp5eiCfgbFY5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7oMntDnZsri9R88qHDRaWM6NL0YmCk06chPyihEA7g=;
 b=3wb4ZEbqSuSi/M7cxt0wNtFSyBldDhRQgQ/SKxUsattc4BoKKbaIuXaHs5huLh+550z+dop53O7TE46CLB9zm/pjqv3ghjeZKrUQFW1Tr1AI6kmgLl1xqagpm2pExPA9OtPRwpF4OpoJDC5zC2bWCJ/tXIw+vz/n1j9dSCr1kEx6J91bWbHJsYQJTuOLP/yz7Pi3/41iMMYzVWgfRTQclSHKDcFP94Yj8UbcvGywV7eAY3ivN8ryhIzZt9Abifpta8LkXB9ijj7BofEHw3cdKpY07v1Gg1xf8tnnS/36/DElM+Od2P0wO7Iu5JgUQ9MQds2KvHk2VPJKJooAudeB1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:37:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 02/12] mptcp: dup an entry when removing it
Date: Sat,  4 Nov 2023 16:35:50 +0800
Message-Id: <efadc373998ca0746ae69231a83aac5c9f226b4c.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 488abc89-f04d-4ff0-86ba-08dbdd113f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vZMi2AjfVN714+uJpasryhzFRqTIKHNLDKBuYv5D1kPM/0bcWukNh5oY5WrP+eubKMfzf99VSShSEhMj3wUG9vEjiik6mPD/WSc+PvBsXZ3djLFDaYQ7VlrIggei9YgUgRO4Hff7CFw968QbJ+PvXqTcL0vUke8WcILm0kZm8CSG9DF6ukz3uebebZ2uQJrrs8g6D+CrHJwXT/Zbvmokza83iJqNGJY+3DNlpdcfyJYsRVWbkwkmP+I0TnWrvWXxSKcTkBHiXICIHT7DxC7FlmPeDaMcElwJF7ryqSS4WNbJYrwv4KMGQLWwzQcZW6ETZNoii5NTg4ZsDNM8bS1VeqLZnuUI/zx3vE3cy2iSeOSIHjQjlRKkUsNsgioIqnW7BYCHthz7U90DoVjUXZHEHO54fP1MKSgWxTO/pp3uKgQQz93XrNOS9F4+X0E5N/y5I7snrpk3YFZlWuRS50ZHdfjelO0902Do/FPLPVTLNvbhBqgyqkMywpVom9M6co6Jw7hlujHqOBaaXiekwDP7lkp5JfIpPBb51mLv132U6tvGtx0Asvanc5+MyA60NRhEJn9tOpiSu2NZr5zS24KBbvSiqHCCPO+dLQyuSN07Odg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(4744005)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qVJTNVSd/ZIXUMkt1V2KKIxNRFjJkSq/nnD4OrOzCEji3b4IDjnetoriYVnp?=
 =?us-ascii?Q?ZinY9xcloJlAc9MIT/qKPmktItnvVkgluqlA67Am3GceiBJ194eig95nVv1X?=
 =?us-ascii?Q?4d50+lf1NQKSFLp9NBDL0Feqv151LAKrseVrQJp2/40A0XYgBnIP/9J1xSNf?=
 =?us-ascii?Q?hhvcPRMz747rPZzlC+ib8x2cVwi0ZaEcLoeUiHso6ZM37wzOYXfla5Ork7JR?=
 =?us-ascii?Q?c+qTBMS7SyuUE+q/NY0bfZ//NNFSs5afEhw9Sp+DH07n/HwGfL2UEF+qTAgk?=
 =?us-ascii?Q?Wpq7bXeK0KM+tSlj3+9ZhlyWdD0yMHOBaLMovHWtnxFIXI0SKTvvYt54BiQh?=
 =?us-ascii?Q?6uLy4DRDJNJhq0Ts2YcfUaFFt4hiamvpPXQ+zXYBxWFqvTJDY3BoXsfnobO7?=
 =?us-ascii?Q?j+2K+lg88smmzolak1Zrvm5nIxRrlxq5eY3gEDDf2exhsZm2baAiSlotMEKF?=
 =?us-ascii?Q?v+9thFlYZ0S5zr5Tv2IiTZZAYvLmMTWCBrHZxlWJEQ+06EAkE0BsveM+NtoJ?=
 =?us-ascii?Q?sDSLglNJrtfHINeuXJ8+XGGICcV1ayiUBh9nzhhceDBwY6XtNamvkYHArB6r?=
 =?us-ascii?Q?EMgUl1EP0OEqoNysbKvDwEdt7dxqg7uu4Yeau8Q9/dNrznGIbchsaBVuslDe?=
 =?us-ascii?Q?ICVcv4DKjG1gWDR5Hj2OCuX6C/L+SEIopfJ0pFknr4h2a9KkB3jrolkxxHWt?=
 =?us-ascii?Q?v8H+PV+WIkl+Ru+yVHh1/sh1lSkqcs3xkoz5BZ4rXE1DIvRKc5T480xiqX9B?=
 =?us-ascii?Q?zOUau1fYMUiSjzNBxjeh65TIDhGTXTvINTfH4yyzgajSKJ/SjvntMHN55RSv?=
 =?us-ascii?Q?0SMCAcLHPKBEwyPNIHs0JafikcbgJPd/YcC8CmZWfzF7sTk99q/eLIHYhlYP?=
 =?us-ascii?Q?jx5DlfgB6e+szLbz+HurpIFlPWaqvGfSHNIh20IN1fiBqFnzTu8jYtM2rW3X?=
 =?us-ascii?Q?lLawp5QBFhhFBJmHptPzH92Qt47CR5SqZ6uRSl1BREXLYkhSNWyj9l6eU6We?=
 =?us-ascii?Q?lM5KSRulv4gu3+UxdGJvoa+v5qJUVZWabLveuF+7tLCl2xiYoagE06bSx6PP?=
 =?us-ascii?Q?crF9lom/S2aed5Kxb9KnTfhEV92meHmju2AEJMDt2SXxx3nMwHbrAdt9vX2b?=
 =?us-ascii?Q?qYjbH4fSbxiPMqDQqrk/keH8nUOUcxyQAW9RPeHGylB2ookZRYn8YXVe5mIt?=
 =?us-ascii?Q?tGQ3wHai2yB31SSBbqeUMyOgDUiuAHN2vX3fSUk2p12tiX3qZdJ4EwvNrBsg?=
 =?us-ascii?Q?r7ZiKVDOJgNGlac0Gkvt/SnaJcQRHZszq4jFjlE2qEp9SWGZLwgVUZwVH0Qu?=
 =?us-ascii?Q?d/GEucn4BnNtoORSUAOUhMtKI3p++Cv6yRR1r69nks706sdLEBgvA7Lfdiz7?=
 =?us-ascii?Q?g16vG+J8ibQpLmguVj4Z5o9FskWsCdvClwgxBLZ8FKUkbetxWYBI6lifOPAF?=
 =?us-ascii?Q?i9k++xYutk287Q9+aONFlFMiZmFomIYCAzlWSCl2sJDU6PJC3eqmqzYxYhmj?=
 =?us-ascii?Q?E9gaTsIsEhU4UWXVwFit5n3zrcIruV/oXSYWuIYalVDyujLn7Wl0snn5/mGI?=
 =?us-ascii?Q?yd7lgt41SYV/QBZOhAVOdwHUnfkAC417c6FotePUmh7XLiZQ/xIwDue6JUXD?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488abc89-f04d-4ff0-86ba-08dbdd113f98
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:15.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P02KPPzJ72Xv+agXtpt5dxuHIqAUO71JHCkFBYX5wdwDGKaU8kMK3raBZcQvHvWjmAajzetO12bircDLMeDimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

In some cases, the address entry does not require free. This patch dups
an entry to separate the deleted address from the free address, so that
the refcounts can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3f42323c30c6..919428b9edae 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -316,10 +316,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	entry = kmemdup(match, sizeof(*match), GFP_ATOMIC);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list_add(&entry->list, &free_list);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
+	list_del_rcu(&match->list);
+	kfree(match);
+
 	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-- 
2.35.3


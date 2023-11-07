Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50BE1FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="rDAOk8n1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAOCV94cufa1T7ps7WfDNlM3peEqypOgA9LmSSneRO1I1SF2k/M5OitkqmCTodCjmdoMtoIRBP5sk9NaDuzT8NdxHn8cBPQ7N8WG0T7gT7TPz9zLxjUS4mRpvqfsO3OhmmXr7jVHIN2JzCvQUfSXKypjr+tZj8sOF77CfF+9V9niTcrulls8+iMvHNsdzXP1tXjBD7Gtgu9J1Htjn+B8bztRF3nBL62K8qbxF8y0nw3cxy+/ew6ZwHuZBdbqKZJcHrAel7JcZKftSNfVCd+/f5CjeBLqOsX9ILZIMw/IzYS7easyexj8EyoieYgvxYGh0k9C/fgHpLSsYcgo5OvGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ASbCxDxa4b0kAoZ+l61pmaA2JVoEpPyDyXXLuM+ktE=;
 b=TzCHbuFa5gvgbIDI35tQ6uIe6RCoCV2z2uOnqDrluYOaHnjih2Rjq9SJ9Yqxt0pEmMRQp0JBAnIg4MrxdfMW0PCDNkZVjWOcOldvv2DujFMJQPDs5Qs5UiyjC5WexPumQ3bYkhNUnEUZK4cOkoDymWl1FLV2aFjSgWPq4T58OreILrZSiBWal0L7ekU3DySWwyof6t80Tr57tGmbmM0vCyKJPoYBfKT0szH9yPpvPTMoORSFJ9PJesWmpeuIBhS3cwlMom0NR+y2MjVmqHsZ6LX7Sgp2wUu1IVhH48uVU0OdGCuRtHSvRTnZPpBnaDKPitQat3VXdOJAnrrk+wBsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ASbCxDxa4b0kAoZ+l61pmaA2JVoEpPyDyXXLuM+ktE=;
 b=rDAOk8n1tKc5oJlmZL6d1qP/qfxT9TQMCfMfxxmuEfIiha35hohX+aBCVlWcUnW0+3uTGKByIv+0xH50xScgrE4ZR4CaRHsIulD91/kDnofyskiGYYWYBASjjNWDnkiGuIvB5/dFBgqX9YsnS7AT9/F2rbeU7jXrLcj4qwhLJhauIqp9nH/j3TEC5maCC+CQTSro/tS6REW88D20Bq8tk59m6D4B0/zxzhgtJF0Ox3u9cdiJvVq6dTM3R/kduAKAIJ5AIMIsKc9SWYh/qWTJQjwDWwddrgG1qFt+lypnuTJ+ZAI3NrCQVI7xpYB73j5tE4iu6aXoPP4IvHhfeKmivw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:02:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:02:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 04/21] mptcp: add a prefix for free_local_addr_list
Date: Tue,  7 Nov 2023 14:01:48 +0800
Message-Id: <8ecdb449d53e4fe30a71f640c774af799f0d92d5.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac35458-8878-4ace-4177-08dbdf572154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j0Wur0+zueolrnXJ15mV6foH0S02aMNPxcnIxLpYcAr1dPaGDsG3hsdmkvEEHaL7KsuGgk3nbquX9/SXNFq5nTwlHMriS8KQ04bThMA1e5GleXQEp0ImG502BRO6V93QJajgJLgSY2k4LWzO5UzHbGa5PPBdeWxVjJ7ZNLg5oc+S1i1KNeX3I6Ha85m6rZLP2pos8jOj4l3s1P9oqC8P9xweuHLWxy1w61VQmi/1KrH/cdXV3buYEpQ7YGWWubVn1jjRTyLWgcAAvU+nVm+gVeM+XSC9OgaLVCMC+6WAnkkK6W1JOAKQQJ7HjUyTu0eOOXj8TFVlQbURo+pt6oXJdCi7jpGKCJMNsz6as4U5dItRxFxeOY2AMrb+j7ZAOO1MBlbvmxKiER1uvNzOL+d4+2+clhroME+3uc0xu4Bd9i3KEtie6id1aPHkl1H9VUPHjeHvgE/iFUdESq9H2kFNPyah0jitto6SrfOuQIV3FyGKjyNyZwfvGrjkyZFXhN420E5DoSQ31HmsEqLnPOeH4gCdog+qslKgxqv/p45xqOgqtbPsaY2hiyQLS85msKnb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OX3BpizOMMWiUKn84FWsdpVMC9w+9xQKn8Q0HCT/pMxgSnpU54fAudtNBXNv?=
 =?us-ascii?Q?HgXuuk1bMKQeg60eVLT7OBvv/z3PyquIt+xHla+vL+lij4UxFst7b/lu9Og3?=
 =?us-ascii?Q?hCniD0of0doVulwjgsm7MEAiFG2pX4MhA9SDHIee31v7LM7dWFdZSYTRsi2q?=
 =?us-ascii?Q?Sfh8FC91wq9+tL6D7kq+8+tVaeZalHj407qz6eWl+O28OHCRYM8CQKL1zGqn?=
 =?us-ascii?Q?dOTtmvWq1V0m8o1yEJf/8h4dEaVWoDKTuvfdCJ0LdZZaNuQwzxrmaqyUBOZX?=
 =?us-ascii?Q?T151WTcIXnmMaEVTK3B0K1FCM7aU1jEhf+Vra8+gjqFedN3LrhRzexIrOCTK?=
 =?us-ascii?Q?xmarxBdSTzx0vHb78kE0ge1ED9NvFPCdGqNqsABTk/DBOGfSpqkYWQvYd3lx?=
 =?us-ascii?Q?YnuOWNuZ9Pa2pvbVWeKBRuZdBlT1Y20tI2DQgLtI3RhF5VhD73v9xe3KJJeo?=
 =?us-ascii?Q?3L+GsNZatVUYxw+VsVmh35bng6qxiJKHqK+nnbZzfofSXEMof9qCnJaN5WSW?=
 =?us-ascii?Q?d5U0yVMHlLGghIURAsG+LoMpAf94VvFP4fQ0eMVYes9e0FFqXFhIvsHXtGOp?=
 =?us-ascii?Q?OoVrX1jsIjnMayxx8DRPtdSFXPzshD0sTHIsogOHv2NOBrl52hTf+ZsHBMZV?=
 =?us-ascii?Q?xyqLnn6qwVHhNtGBP1z1FJ4Mf5v7gJlvhMJ1eLM1ruZ57Qf819SXwH7rtqSn?=
 =?us-ascii?Q?6uyIR+AFUliVKefnwWnZEW+e1pZ91Y23Npo17AVuuGB/2ZUPsQqdjcqI/LsP?=
 =?us-ascii?Q?O5r6cPPU8zxMcSB5c09MqJIE17071dg+FN6/41O4qXCdMOsNUQPrVmT6tEgZ?=
 =?us-ascii?Q?N7/OxWDrx5iIdalE2vn8l171xRyxtNU1oA7+9+bOG1F/o6m69XgYHEFr93Qv?=
 =?us-ascii?Q?kZvTTZ7DIApghSLVaTz01f/jlrNU6fJgmnPPZ6xu8p0f/mVunFmiUiixqZRo?=
 =?us-ascii?Q?rPg56s8arOzRYiHo3F+7ZmdLnv2gp1zwZt6bSzOvs4fxz4zL77IXtJQSvplu?=
 =?us-ascii?Q?7t88QBzEUbJnRGgizJFubUtamJ2kB61KcfZ05uUMRRxP64z8btXm24rLAahn?=
 =?us-ascii?Q?lfmpbbrA0o1ky2rW+3oK0LNSeBFD1jhgYE1rcCwZnZ1lzPTWEq5/9HPLv5mv?=
 =?us-ascii?Q?wrPV4nqv5ggOGIBKlxBUomLY2bIWQrVmYlUXrzm01A0gQoNxLAnSn+ZeqL5k?=
 =?us-ascii?Q?rL1LGdLSyao8y4VfdnXKhHGiU30PPR4XM126+edlQsKQL8adDM6N02m/u3Qo?=
 =?us-ascii?Q?GWzeqBFEzYetukMi5J0OH/fVORXr6kPqCmipCiVgrPuD0v9qexR4bJX656Hl?=
 =?us-ascii?Q?UUZnDeFPqTjfLF4WAD19mqPBgUBKQ5oTLogv9lB5xMQ8t2YuPV8z5I6htrl+?=
 =?us-ascii?Q?/pTML2dwwG6jLypae9TrAWywgpNPmKtOQECaWR/Fb6VWOFBsi8E7Pzvpplir?=
 =?us-ascii?Q?C3gn7E52oSVfchwd1chUtDgBYrGleyA3Z63hnEEcxjSirxClpuS1m2cIeaXl?=
 =?us-ascii?Q?qYucbt5FHnJvh+nBZZfpBsmcQmxwlymrrsEGMls6ocZjY7glkxAzAvZxiDyC?=
 =?us-ascii?Q?kXaR3UAS+rXMb5saVGrroxfWQ5Y/jXw2Z5ocvcqb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac35458-8878-4ace-4177-08dbdf572154
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:02:31.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXX5+f4F/EZ3v0/tYJ1AuWomnhOrrCooM/cpu9BwlWvyxmStc+Zdtrw07avA2MjTJr+J2lT9RbXr6U7qAS/Ukw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

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


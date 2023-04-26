Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F941C2B
	for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 08:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+of8JX/2Y9yWFEVIy4rRmiOtQlF3Od11ueqra0jPJPfy9cULFUdOL5+Izmc1QfJK1uC1GIRzT9CxTtsvttGKoAx9HCxCQuKSdPMc+tY4A1i/o83HdfThIRxrRjjn8uKD0KvO8eQiLfdGyMbjqRCOCla6rCYFPRbvCbN4bELCJ+1IGw41PLnXKe8cwT9U8dKcM172DKYB9K3F6yG+dUx71hmvMI98XcOG3E+v/kMf07DFOLIhS//Ax7eTmJP966gsrjrezougnBF2oC76rFBslPQCpa10FLyzNgkzCW+EAJ/KuHVFNLaPcMxv0D0k9JG6cZzU2A2Lmz/6w+Omp1REg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIuhJRRTicz4OSfyhJ/shrS8i0HP2/16yyNL5gbOwdk=;
 b=efW0DXCIKEaNTZk5/6SGl7qSYNjKD43sWhXQn1thVg3qLFo96q6zmWVbf/2d4oWOIrbXU1vWdnrI/9MDeGtJQSxFnrSyrlCam8ib2VpmSE0jQat5BMJL9r+1xIqmrxUPLgOJ33y07+BW02mBneUhmdsUlH2t3l5t2QfEVnak5UxbdtiMf0eCs4eM78MwTxs91GOi330hYSlEv0cqcjDLemXeKd1EtWaAoW84K1TUp7wIF8YlaPtAEippZWc7f5vJE4z+OOwgB6n0dwv8YZtTwHI8Jgs/0br67uGv5PzDQ88IHwUVqX4kc3229lQ6sn6ht5aNBhc2+Y2nSlR8vuQcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIuhJRRTicz4OSfyhJ/shrS8i0HP2/16yyNL5gbOwdk=;
 b=2GimO2cmEv/8VKwlcvDgimZ4EDkaO3XzScusOzPO03hKWP/iLmIel0vcQbQ11kMx8WQ9+wO3REbJayFL+ciUDrg1XrzCxWPIQ3QpZ3jlNoRNWWUhLpFS7SGR+oPOxR+NPpKCoXO5fTXT1X7JpBxI6BGH7L8cwKKz+IzVKUEbkICh2Xd16pLwXZVqpDJ77pBUrPpKSKUrAVzSVD/aG4vJRF7JJlqz4Zexw9t+f0DGWCxqSHjmoxaVsJCiLuT69lAlDtrCmV+HVS6cz7nK9yRi3Wt8ZmII+cyTz1BfAuTlrWONTPgI9Cco6pgqvu83CNrOSWSXmHtQkHB9MOKvvvzSZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 08:57:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 08:57:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 5/6] mptcp: add addr into pm anno_list
Date: Wed, 26 Apr 2023 16:56:26 +0800
Message-Id: <247abcd097c77e86b606dca38179693f8c00d559.1682499136.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682499136.git.geliang.tang@suse.com>
References: <cover.1682499136.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: ec705eb3-2392-448f-a426-08db46343e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7uI1IrZwcGXZY2stkKFuhqHjq+1FcrJQrBvkOJ6OPk+ys9jS5pNQbP00FoDHWmAfe81uzOhxpyTPm1raEA7m8sVYdClQlVeSktUBSU2UvhgQpQexguHDkYFGNH4+keZH94SKxVmgfN0xLMVHAsDmmjCs6dmn/JBcUvAGuft5rZTvY8i0fsCuARHkPdEcSxkcsoHUsgotg/6QaqHMW1yLcqwcER5ukn4+E/OvsR+zzA40k/GcW4/xQcMXsGQDuOQ39bUEjQbnDbX5qgZCA4euGJFO3QkSp8PDdWYgLY6xarHiy3bJPFn6kds6Eb/yhcMyXtSh5V3zoh+ZhUo1wZlUjBh8/JUQSBgtE/wYGs25l3Z7wqtH8c29GXlc9eqvU+C7/vo4NYyv+cPiDxgyWZr5J1mmrbFBK0s6NnW8Y896OhHP42TutRHnaYpqjLUkffNhmBuwXjmKk/f49WVsMSXDseBU45y+QVzZbbHjRU+e0L/mo8klWMtAKsWUf1EbByPecCubGE5qMDbq3mzIWmZbA/cK7p+enPv2zeAbT9O8UkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(36756003)(5660300002)(44832011)(8676002)(316002)(8936002)(38100700002)(66946007)(41300700001)(86362001)(66476007)(66556008)(4326008)(2906002)(6916009)(107886003)(966005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vkFNSqraR5Xt1zQ8ebPsYlfpVTCgGNvf5UaRM6k6M3lniCT3aAvciR3vWWrL?=
 =?us-ascii?Q?TgRL/TfaP1W95lJ8iafjruC0Q4tGCCLK8xvqZuTGh5sC4bM76ez6//oqEua/?=
 =?us-ascii?Q?cRng9WM6mo0KurMWKAwNuuGXYaGw5sxtWuhAXC72tsXnqydnPPxb7kJHIqZO?=
 =?us-ascii?Q?to/IiuIlhwXC49JmOrOAEkjn8V72FLk6z1P9O7aYRMngNwHNYpat9YNKFovU?=
 =?us-ascii?Q?yV5xNvjG/nF9BQ9h9DJn41oRxGEFYzQrEdV7OdfxbOVhhQzLmtZ6S51lvt3b?=
 =?us-ascii?Q?D7LKv2TWO9hFd3uyl0WKT7b8eDcI5a8XFvZWHNo6PmKHt/XEBS3nWJ99+EEt?=
 =?us-ascii?Q?kvaHizsr2plPm9Cgxe/74P7F6sc21fLnrwOPS1JFNinnB0V3Ou+wWGZvxhiR?=
 =?us-ascii?Q?jn3IAfv7d4ZE80HuAzFJKMLd0UDbYCkREL0/cjSHwBGNNiGCljwExgX9qIWN?=
 =?us-ascii?Q?YNJSWdZUbPVUNsHpxpzq2VElc0QHWGc1hXWCpyUuU27P8QiZM9w7vYRcDgLU?=
 =?us-ascii?Q?ly7CBEujLwRGEcheebXKSf3NyXy4OonY+E3vfzF3wDwb1dEIv2g1NdHVjBZ+?=
 =?us-ascii?Q?sJPS3jzRiU4KJUL/yWy3l22cg9tA05pOlcHvTBYi5BsWNwqD+EE6GRzntqqJ?=
 =?us-ascii?Q?6I71Mlp3kJGyrpqYFTSj7nBtKLHBjfdP7a1x7r1IyZ+DyLOENsRB2kp7kjtM?=
 =?us-ascii?Q?pBZl3ojpQ95ZIIKiEUBQsCB1pQnb3yh8sHWAUv5XRDj/I1DavV2o7CdTVOHu?=
 =?us-ascii?Q?lPvVKLb1CHoHWAm3CrMID3w+jniCfL9lVEuoBZzuADm+j7yG5ci3a6iZDYUa?=
 =?us-ascii?Q?bp2ZA3pSxULkXB5Jh4SoQjY3iUVdvkGvMbgzBDi9V+3lWFSqwODfvFa5chln?=
 =?us-ascii?Q?DSubc1opfUBbejwvm/IF9Co+M8RqQb+5TH6K9A8cM+LH8Yi39TY7BXwnlj2M?=
 =?us-ascii?Q?s3rXy3uEF1ApTVt3zjwOb2+9yzJwW77O2MY1L7XJC1mBvBOm+cGrm9gSsOdE?=
 =?us-ascii?Q?YBkRMissR9LoPHDhkx+eOGgAPld6w5xpb8rB4bwXPlm/NclWZjJ9PsvkOOHW?=
 =?us-ascii?Q?CFCL5uqRQfNtbtKz1pGvmeXckBK/42WgXyFvxFB6xdh5kcrh8u5ZbihyWQA3?=
 =?us-ascii?Q?5Dx3DIcE/hxEb8bA7cb66ClxnmO4epgV8FaoZlQhPzhmc+zJsKyS7RnUCmrx?=
 =?us-ascii?Q?fBgs7Uubj4kTwMYlejPadTQkHpS8Zu9ImZ6t7JKnNX28AIl9ijMH4cjx83qV?=
 =?us-ascii?Q?sJ0AVt656FvZtnvftrWjFHAMnsXpfGKY34Y9Z/eMxTIwjm8FK2rnuApLA4ov?=
 =?us-ascii?Q?OietbX4L7/HXSy4dxyRC5cf05g5culsosM4SXhTRyg5r/5kAbeHjLbDgET8B?=
 =?us-ascii?Q?k7R/whJ2wNjdbLbBb59DqqOuvoslH4lnvnahzu1CH3erZIOiNpnCyvwakmmJ?=
 =?us-ascii?Q?3bgVBShWXifaigxuyDAymiOc2riZNNy++anRfUXPygW1as6cyEjrrAG0CAOJ?=
 =?us-ascii?Q?tSIT56suQ5eiBEpKWa7V9f1mi6EYRdoUmDHhZTw7Goi8BgDDPai0VxasHVgw?=
 =?us-ascii?Q?ulQ5Z5Vk7OL/oveX/jPviv8qYkHOA7ISJHUqZxBx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec705eb3-2392-448f-a426-08db46343e79
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:57:20.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBNf/ID/K3FoyqoUYJrGUyYXRDG+7X8Ua46/BDD4ASiuHmA3IVvuqKPN9Lp2dkd7Oc3Xs8R37uHSVYg/4rudKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237

Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
it when connecting fails.

By doing this, the "REMOVE" command also works with subflows that have
been created via the "SUB_CREATE" command instead of restricting to
the addresses that have been announced via the "ANNOUNCE" command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fc96405b7616..ab7c692e8c5e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -326,6 +326,14 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	spin_lock_bh(&msk->pm.lock);
+	if (!mptcp_pm_alloc_anno_list(msk, &local)) {
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+		spin_unlock_bh(&msk->pm.lock);
+		goto create_err;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -334,6 +342,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 
 	if (err) {
 		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
 		spin_unlock_bh(&msk->pm.lock);
 	}
-- 
2.35.3


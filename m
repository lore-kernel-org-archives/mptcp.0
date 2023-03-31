Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD17EC3
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 08:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5avtCZ6PU06Xywp80QIr6VJh7RZhC38wNRLBGWJQIV0lPDz6H4o/olJjIR7uLVYxzinO9msloeb5kdSXybL3ab7qQEGlFgIrmQqBuai0z3FUF5CtEPBAUsdTnl4Pb8PWvxwFYtjCOjZvp2nxF+D8hBqbZqXepvpaA+hwXpqa5mJNTz+0+hmmOxZJs90yNyVu51FaPpsUw1bN8F+7rcgu5yUjxMFOpMuuE5e8AH68e+joJ2qwh93aSiblbyadNB0hF5PB78/H6XXnZVosiafYzTOd31JTrdsXfjNDXevoy8dnjBIUDw6TUi+ropNcHo8+v0MRGXQUjpF5I7t8XZbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhja8qVlKsBqKTXiz/MTQhpeRwKoq+qacqvh286ZiH0=;
 b=Um8yGn2zKCRqbNY0bWNMBcoEoibijOIeENWy83R5C+fjlYSiBuiwwJmlB6FhLMaWOfngXLK/GU6FJp6tRFMe8tYrXwtxbKAELrEUA+1PRcmU6xP8Rqe5RYBJLQs42EKEBHWMJ/sLxwfxQJ0SN5BdPPPGF+Ib0VHof3luQIYP4ZWzhBJQwGINcDV23awxGJwnA7Ao8w1i1am+b+FHX8mo8QfUiaYH6mUERBTEBjTBtLBtJnLmNnz6x16fWqMb07v0BwNabBzsFN6tUtoiQrZbTxon/KJz+8Um9QjgIfyee+VctX7Lzycpthdh6ptuqEuQveFJbUSwXIASU0i1nc+RLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhja8qVlKsBqKTXiz/MTQhpeRwKoq+qacqvh286ZiH0=;
 b=WDkkrNHH44D/6rjxacFimHMswstEWPxf6zuWTi0zDI8VElssZkstr2+n36fRyYDoLG7OUBViWC7G8nsikQl4+5oispkGE00rdpi5fZv5Dvr21loRu7668ZWh6D7bPfQ9utVBPuCCs6dCPbrfkUaDKv4Uai2ENZttBBE75of7pUBinYMl0dV+jJAqtng+IDk483K7kmaXXHrk2ApJrSYE1sT4Ly2AqVtv8B85KrHK+D49NA4KhfBYzTy4iO/mel0tLCwsj0PGnWmiy0SFJAyIwdgjxi08bkaPs0RAd51QqFiv4nNRrI4zFCWNmvULmng1+Wj2ftBsz17f/yrzD4RHjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 08:44:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6222.030; Fri, 31 Mar 2023
 08:44:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: make userspace_pm_append_new_local_addr static
Date: Fri, 31 Mar 2023 16:44:28 +0800
Message-Id: <0f4d10f41b5a51353cc4738d6b5d63b9aed8b1f7.1680252220.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0204.jpnprd01.prod.outlook.com
 (2603:1096:404:29::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4c0028-88c1-4fa5-260c-08db31c423c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pDwqj7rmpEYKt6AR5XSSZFwUX6BUW6mBYAf1SZrxMSm8Cl6l3gbV8E9xToNfP65vktQQKCmjiYGniC4opMTgv6dKnzIGoAp/vU51ogUvTt68mazkab3gcgdc2p61cRhOrxaC298BUdAJzv5FjRYBwd2dmEb97TBbg6kAZHkFHS3wQVGOPwNhHHe02BQ4TzW/GSyi4zUJX4mv4wicHdanLdyfVr7C/x9Fw9v+UgersoCKm0V4cTCtdI1O5FaIG3v1T8ol6ibOIkoiQ24e4NXOCrFIzEVcVbT5NudEP43FcgqI1fSRMJf5uqe7lhoV1iAmLcIs9KanEHTZpVkIO741ck1MiJoJER3YMKf096K0cKpYdr2KIrDjzKqA2JO6RJ+u08CoCt31hjUywMI0CiyWabWCLIIsqm4TKSL0vRB2jxuMdQTLPhWmZzmNwuuANDs9CHiNg/l2jy0X0WM+t4VQWk+GCVwFnUDS0oFeEEKpxpz8njzeSww7OG4hgLCZC4ZhAA9z5rFnmh0vFtlgvLYTAIY5W658Y7MByBemsXj52MmTFSk+qzHhTkuyiiXcnHK3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(186003)(478600001)(86362001)(316002)(36756003)(6486002)(8936002)(38100700002)(5660300002)(6916009)(4326008)(66476007)(66946007)(44832011)(66556008)(8676002)(41300700001)(2906002)(26005)(6506007)(6512007)(107886003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dnPCcRfeA1I8Rfv6KU/XUF3eWybXbeAqDJSWDvXFL8LvkMGKEtXBd+s2Za1k?=
 =?us-ascii?Q?tP5x8EuENgTS9oBRqUeaLF6BVSAigCRNt63CO7NFFBe8U6tu/iC/L3cP4JlR?=
 =?us-ascii?Q?BdZ9mSkKv7IZfC4hGrnGDAQyk/ZOLVH02DxD6pV7eTTPLna40RFkC7cRQMMC?=
 =?us-ascii?Q?FUiSDIl7HNRTjakhtN6afkY12FMViX1eYsqLCfM25dP8SgeMJiUWG3jMxzlL?=
 =?us-ascii?Q?rMvE+ztguhP9WKSoQRpqrDyP+LW1DbkYrP+i9uUt5Jz9i8lAMjH/deGL79o1?=
 =?us-ascii?Q?tXaz4OAoN7Xe1qL5HRM7o1q8ThLuqmt7nDtCETXPiCotXg20ahsJaeWjzzbs?=
 =?us-ascii?Q?HrjPV9Ml6iVbInz98X4i8k92/6u2HK3rcI2PgebYSOguyrfkmr2VSQnJyU4B?=
 =?us-ascii?Q?hB2761iTTv1q4iVfsyy6BmDGm7jWojx1oYZ1Smm5YaUjx3HQzHTY16zlnx7n?=
 =?us-ascii?Q?AFZpFJQuR8x+nfsnxO7PR0WW7qMN3YpATfYLdcWm0UT8tz/ntOVplf1xloYM?=
 =?us-ascii?Q?FAdWwJ70SSxMzEtCpCiEN+zN0a1dUv8WB0hp9QlziKHDtLYloXn4QM7KxUgi?=
 =?us-ascii?Q?FeEuakhtQZJL1SQv7HInkI9vxABQh+uSpp1s0aFKcMvRoWeccVVmnJ2TEj1j?=
 =?us-ascii?Q?fpSAFxroEWrpBdqk26Jq4qBm2FHl55TTdZSMT1FoV/vjdPwPc9rZ6AaN4lCz?=
 =?us-ascii?Q?71S9jEL2SPLrcyryfYsDbx7J2fH/asRg6CeQ+i/l1QpH0NMw6ELmw+ScqGwb?=
 =?us-ascii?Q?bLFdog1oTBp5Sd4qymPFWnqKbkgb/Us9Jx/jMHEc+loS53nb1Ot1w6/UJdhI?=
 =?us-ascii?Q?1jkMNFGGvCChAIkTzJEnGf3dIcO/X6jh4Kc7v3liQmox+9iOUJb16VjtU2ZC?=
 =?us-ascii?Q?jhXKib5cV9cy408wp7nKkGvQsv3XtOij5EwnDYiKl+1fU5AJ50JR91GjNS1o?=
 =?us-ascii?Q?C3qLtQbSaO8BmssJQPNHov4Ztzr/kDBS+TQ0j+HO9qlHCeOVErLPnHtWydlp?=
 =?us-ascii?Q?DmA8tUByTaS6zGpWx+4djEeB9VtLaN+5/GuepM30O40g5J4iJAeLvYEbPrUF?=
 =?us-ascii?Q?/ed2DoCplVkxSqFYWUu6icmCGN9fhUSel9iCcQSGuENN3cnhaC6UzKydP5gi?=
 =?us-ascii?Q?X7KLpqX8q8BrWPeEW6KEzMaChRkhjyGZvKqfmH0pjE/CXF6DBCgYyfbFDSEE?=
 =?us-ascii?Q?5bKzubRk6Zy1ns/dvI+82dHP1xt4QLkqhQN9kv7dXavvStcHnSjrbs3UCKX7?=
 =?us-ascii?Q?rRIZKdq5Qyyb/PGU0VIrw0o0DIn59fg9g2Jn+9fG+HneTwS5zrwCdde5EBPH?=
 =?us-ascii?Q?xzpyqc/pwUUoZ83LLVcRaPl1q2dS06n7JQklAsXCOUCNILeOYAKxvFHWl3HV?=
 =?us-ascii?Q?Jz9Rtdad20GLZpM8tW6PuVfBpjOuwe8DRkv0ZTUOty9qFuiWchCBQEsJziT3?=
 =?us-ascii?Q?j+TCa8zxwdUMq7gMC5zNwTaaIjAHNnbP/t7138aEqJfX1vP3mLKuvGA/o4/y?=
 =?us-ascii?Q?eSu5bOjS6do1JTCmdwFgud45jCX/GYNJkzapH8IXRHQ8bUVjCsVwt3x5N6LP?=
 =?us-ascii?Q?YSISK1UUF+F8wIGa9h7WHoGKv50oeUMuyRhYKiQK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4c0028-88c1-4fa5-260c-08db31c423c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:44:29.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQLcKXBk+2iZfPW5h5czmB6x7pfhMgWuZPLk+ChqBu5N0/wPz+OPfsQDy3CRJztOlTk/F35MUOkKk5ZAXAC8ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648

mptcp_userspace_pm_append_new_local_addr is only used in pm_userspace.c,
so make it static.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
RESEND:
 - resend it as a cleanup.
---
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a02d3cbf2a1b..27a275805c06 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,8 +25,8 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
-int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-					     struct mptcp_pm_addr_entry *entry)
+static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
+						    struct mptcp_pm_addr_entry *entry)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d84f0d19e9d6..08e14a4624a6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -846,8 +846,6 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-					     struct mptcp_pm_addr_entry *entry);
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info);
-- 
2.35.3


Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71EBA45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZBt+yJBr0Plb9l0O+Ds2FTJAidGtY0iSxaXggX1DMnopadbXzWzL1sr++/lZMAgkI15Dw6mR6+XqMbuqsLBebT31+rGg3lKjj7oZ/NoGfQCvZXgPew6q9Z+9p2u5HV4xjHuJUtTHFU252Fp+8/a0xXaywX2fXnsZMjEg1v4IhwmqZlPy6EFQN5NSYyjUSGLSpynBfxABpp46i7WPIk1o3ll8d6pu7obFZHU+kBXSiFBSY7TIJBSvZyRVEbeX1i5O7azXimSj8BmaD40fYjOwJ9qjUl0tw6EN24IBsLUWccBrDpXlkIR+ACk7T5hCuUGsAg2qBZ00fmt5pQHDTPwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1OOp8bXi7EpwnMMjwxihycnv++9icP74XgvPQFCUR0=;
 b=DAoMJXThqUFucT+tRYwig+97eJ+AjkPya5YBGqPP8Q1rV17RlVdHDo18IpiwVFJQxlARDnLwMvFOmYmE9vUDbq8YUxLyvPFtkWxBMuPfo6VNXvFD+o3yCNHxGp/Fn37zxmy4WDU3fPwc4Xek2TSH9cm0aWR929UVq0XlzVMlndV7/w48jYMVwgBCQUrD2BqkpyD8Ap00tpJh1bb97kOyJ4ouMWEjAX3LimzVhp7pkPYDAIEiBeT7V7ovA/2CUXDpBleDrT2Ewx3pAR+mcnkkKtwKOr7lHzHkpCMQdoio+b6Q6ai+58MRJI0Ew/PCbskGg5fgES39/M3aoQLf1Av50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1OOp8bXi7EpwnMMjwxihycnv++9icP74XgvPQFCUR0=;
 b=2Deyi9nhHZlk2YnngE0XM+An5Ss+Xvv1CAsnKy7De7Gup+Ga33iKJpF1cX99dAKhtf9gO31dvecD9bCjimTXCAhVmJwBYDrSQ1f7I1rhvCVidaq1zW0YJh6pZF9arzsGgeQrWyALKj6oN56kXymaNfe10+IRzxLqqrvn0z2NkJa0s9xZynAjP2Uvw4nET5seZcp5+KTZ9b0nFbZ4Be9NG5Ns1vOt7MLhRUlg4U/kkezgT5Le3l87aO7PbEiTPtenz7YeYp3WRjfYDyN8ePdoRdjovjvWAHn7D5yR0NCC1U0ZU6f+wjVT9QIJmHkmjp5i3bB7IX4DFXwgxv5bJO7HIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 09:11:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:11:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 2/7] mptcp: only remove addrs in nl_cmd_remove
Date: Fri, 14 Apr 2023 17:11:05 +0800
Message-Id: <bb500770192e1876ca353183f7f255918dc39f49.1681463340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681463340.git.geliang.tang@suse.com>
References: <cover.1681463340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dc673e-a41c-4110-abeb-08db3cc83dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mxN8vl0zdi5LvDxexamgdDzHUBO/G3rNflHkeaG1glWwxFZ/++5X2HNmFb1wgRItnGkOs5JS4mubN26V1IcjtwUZOdztINRnT773RnL2sbBxslGiQfwD3gJdAE8VJ0JnOp/dMw0Q1BUnNEogJe5wpKUg+nMHuX6IFyEbBrJ22tHWE9Gc3yk/qjOglWfLbPpS0Bk/bF+3sfh+15VbEuQsZ4UsPyF6gFh96LfiFPJlbLCwxc1dsX1Kpl2JkAobJCN4G7TNc79LNAUn+3yHN0yyx5Bx2Kpe5EvbV1jCz54+JeBKbHu3rnOlRfiTeKANOOpVz/PRYcYxpOuX91pC+ZK+g/tPL99h0mu5c2F7E/kaalZizxAL2fXMHWSwk+63EX6rIk7/cs6FUfWS8Okupe99KybzLJRPdRRcA01ieEiGj+513/GvvxCKfQIFp+LGB5I2+UIhTSYcaZuWYPk5IKuNJlVYyJzVAix1ngCB0ngRm/lO6+A53HJvRTD+Dhew+1pSSprTgHy4Jqhylsj7vtuOHSdKVO7pHbbDow9oiTr3aywmai5DUTUpLl6jHgzT2uEC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(478600001)(83380400001)(186003)(2616005)(6506007)(36756003)(86362001)(38100700002)(107886003)(26005)(6512007)(6486002)(6666004)(2906002)(41300700001)(316002)(66476007)(66556008)(66946007)(6916009)(4326008)(44832011)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ZXk/qIoNqK7LiyGM/7H/rwLSoErFQYzTJXu180yzet3uFllmiwIeIzDtFeh?=
 =?us-ascii?Q?WGJbnE5Q9iXujPdbuY/V7f+9i1NxVcGLEnSz/Qjh83nH86S/Ui+JXuXQtMIG?=
 =?us-ascii?Q?1fD1p7vW+j4bFXhkiGY0G3qkcmJd10mKM4SEwpXuOo0onGafLALm1TqBulvH?=
 =?us-ascii?Q?wlkxFWdWRcCGP1JS12Uy0dDs+xiAu3ngn1NfSMM8GQvFurYwy8MnWf4q7CRs?=
 =?us-ascii?Q?V0ntMBesdSTGu07cOhGsMl0o88nQQAsLql9ooxGaJ2PfWNCFGv2Eb8AMr1/7?=
 =?us-ascii?Q?L7xHodkx3VqoYenjINPjRQ/hHmPoKPYcLlb8/Sm6k+8+URP6VLrE38r/gnL5?=
 =?us-ascii?Q?VKykFW6G8v32UuJcDIUxue8WWiCTgdXqrTDA719/RkozT8maoeGouMOpa51R?=
 =?us-ascii?Q?du7ry34SwdGxA36FbRaT7y/T1OpntLqaQLtWjF1jQ8v7ebilMLo2X5bWlos4?=
 =?us-ascii?Q?QJ7M3Jv5K3QGxbyMX2baAMvV+GYcpBQ4zOgIrhYJl+mQQBk7TFrSx+YsmQf/?=
 =?us-ascii?Q?+aKM0Cf9g8odGuNyYAGlQ26rSSJh9uu0bXgTHejAtQi5JSjfT1BmMWXqUz1d?=
 =?us-ascii?Q?Xpvz026ycsAa/xJbaXM33SIoXYo8mZE/gaXJYAZS6uibWQd/j8bcfixkTPzP?=
 =?us-ascii?Q?GvVyJRYYOGfQvreHAXoDqUDETJj14IZyf1+WK+qvM1lbsHBdzYSgEHbQOHgX?=
 =?us-ascii?Q?zeG3XHtECjVdB+Gzb31qcZjixisLgO/zhH5J8S1wC2WHKrHTaw/5xRMB2ECe?=
 =?us-ascii?Q?/1yZFywsOmUKcflAaHlvogRgVYuaY+ERN1AnqNp5BAjg1lfAmDo7XIPgw0bD?=
 =?us-ascii?Q?OPVdnI6P91eA6o0ZVVrrUOsjf5Ktb+7p9642JfeK+TQOfbD/YHJOt20MBuA6?=
 =?us-ascii?Q?BqpInIrRA8EGRqknHraO5BVwSEd64SNvvtqIgiidpRTA/JjrtrRS/82nRd8L?=
 =?us-ascii?Q?tZkQ/MNVM7ZskO3svBqUnCUyXtj+dG4EJ6PjtslUAUWzWl4K0iVgvzslqMob?=
 =?us-ascii?Q?nzMM2gGV6MHLxgMbxN3LkR2QeMVIKafG0esn/wJHcP0o8/RfjMOv5hwkOogI?=
 =?us-ascii?Q?O2y1dkRUWD+ZrGz+p+R8WmOkTr4MXq330jnOLo1EoviL/okkKSOqqO9z7F9A?=
 =?us-ascii?Q?UlUSch0j0+rYCX2bTXOkGa1rvQowbYC8/1jdF9lkCC7u173NY7R5yppLsHys?=
 =?us-ascii?Q?ML0gvo8a760hVVlnbGf55n/0j2Agtq3WT8StEM+TFfoUfBDXQSXkWxrowJ7a?=
 =?us-ascii?Q?ppNeXVPQaJvWaXTkVIOojebFSCkG6u6Fpfr4TgXmc85Remll3tAXuI73IqqM?=
 =?us-ascii?Q?ZQhXEKDphv6oqZv1Lpq1dslNfB5mHPS9HbN0hO+UCCcsdASp3TGUwy6agT0f?=
 =?us-ascii?Q?th/lJNYrOXr2hRplUkRm/wT/KoFrlxRT3bWk4uB3qqKlZoSO3Gs3TWoRQDC5?=
 =?us-ascii?Q?JsTG6TPUDu0F283mFgNnIqLIOCdiS8XcbanFpc0xIAaWz3EEvdkogRg/L9Gs?=
 =?us-ascii?Q?t7seUay5nv2+0Cg8nWgyQX2FyQJCCtdq3sMyMkxPjd4V0M4qPlYIPx1J0W1M?=
 =?us-ascii?Q?0UE9rfLWsBYcu6nvTkf1DthBdIzP8/w9LE+8wK8u?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dc673e-a41c-4110-abeb-08db3cc83dac
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:11:33.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPwtMuKdPSGShO+XAvuoYlhR4H8LNG00H7E8hDMKogXOIc2k+5h3eyUFG726bWfYGUqTq1YTRAOeQSn3R9WaWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9088

Only remove addrs in mptcp_nl_cmd_remove(), add a new helper
mptcp_pm_remove_addrs() to do this.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 17 +++++++++++++++++
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a02822111218..dd15ed96fae8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1555,6 +1555,23 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk,
+			   struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX) {
+			alist.ids[alist.nr++] = entry->addr.id;
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_remove_addr(msk, &alist);
+			spin_unlock_bh(&msk->pm.lock);
+		}
+	}
+}
+
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4d0e54fab5cf..07714edb9086 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -232,7 +232,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	list_move(&match->list, &free_list);
 
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	mptcp_pm_remove_addrs(msk, &free_list);
 
 	release_sock((struct sock *)msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 990c21a97975..535c1b3ae6ed 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -845,6 +845,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk,
+			   struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-- 
2.35.3


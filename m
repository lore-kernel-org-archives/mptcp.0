Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFB15D0
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOszdPK1Zqkx/5X3S+JgPd2YRn/Kd1hqwVf6YUOnjV2Dsr6UyLlVBuLE6nrQul5Q0Ba3MnkDJNrs7dzEbm+XM9fMf6uI+nRl3vfv8qy/jnyeRo0sTXr0dZ2oth3hDfQBDzMyNOKhfZiwnO8eLZVqocGgH2YIHJrGUDyRWFsT6lqaQ/5WOmmwnn6AuseLWcwqk5QJcm9TiOt7crybBT8eR7cXTEZ4e+ZsyKwege24tPUzah81hYDqEENCDZ9uouFy7Fg7Ct9R4QDwzAZ782wZoYWNRRmYCDuJJ8c+PY0RR7JdLycCsSvhnKoK+iyWM0R1n89jUSd4wOY+n4nr2v3c9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3bl3W2DePJSR+A5CQupDySYUYnnndOVDynmbOw3Eb0=;
 b=J29EwfwpvCwh0GHhfQ99M9PyjLW9byjpAW4b9pi6mKEodlHbOnWSIabtnge4H2subYo6gF5rRpSewTE1dL6ShhCM2jBRG1PjoFIj1hSkKFnv1wvVpZJr49qKJDFB6lHkD5ajKdz3CxwY59pybbiii7sjJ9RbLgXnNSiWmDO0BQHNOc3jpJyKyIFFgOxvbFg/a5blD6K1n2EMYaDVz9t/diKpa1btcS/mH0ReJ8cBQGKlFCTcQvvZ/j69iNJSxT33q+ZTEu8jA8dIi9ZtxLgtvVJyWjeCWfZw+6laaOrvltT0ln6D4FxkZ2+BW6gm2o2jmBIEIUGsfbZofFlntvRGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3bl3W2DePJSR+A5CQupDySYUYnnndOVDynmbOw3Eb0=;
 b=gJgmN17RXlPjOUOGMKjJf0o15MiuTJGjHspdqiiCK9MoL8nNu0iJpgHLW42L3zax8tVtqSI0s4RG8G5t2LlZ6/1HZkSN//9fshWQCMMqeucQSQbxdGEpnYv6/5pdg7Xszyefrv4BZRYt3jgGEztBfjvIxhJ4YscS07q/kCO86Tzok4Ts4uGH/lLDsjjuIRFwuJHsJG2lXMnZFBX/IhdacKOHoxOWhkZnw9u+ii+NnuMp845OuOzcPHYtv5cZ0nw+XTVVF6UTXAK+Z56yXFvF5c8oMgM7gr0ZDj32PzA9InfF1+sokGlM7WeRegTkTNA+UAkp835/+GsZJHHDmSzjyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:09:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:09:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 01/12] mptcp: only send RM_ADDR in nl_cmd_remove
Date: Sat,  6 May 2023 13:08:49 +0800
Message-Id: <2e7631b717164948db37847ccc7cb40ee80995cc.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 760e04b6-ba77-4d00-472c-08db4df002ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K1vULFB7EHD6XCelJa2FsMyS0dIpbifBMK4BoW6sueZDiouZu9JuLDd2WKdMuRtNld1zvJnMpAT1jsjvSgKyxXMTfZ2f+XeKBbtezJJw54NxuI2sIJ1sLPyIY/heyI/0jGIbT58PjY2y1fxuWOySOHqJGsxCE7XW/AeCh1IiS62lGEDE8SOi/F4kzGahOKl8O3BeHiFWN6KYuAjUmBbYTE6VsDKluiqIlCjB9kjCfRvQ/YUyzvVJDpieP0JQI4mbjJdfmeHOfHc4gCVwvY9XLIPHsMZj6Kyo2TGSk99iNUpyfyqK3QxqsqeG0w23KO9LvvmnxIR9D2G1pKQMT7f5r/a3Iz/+Z2eU7/zIefz76sKWk0HnSAaMbyFWIgi3xgH5NSSn+S5VQtIpbAmg3gkedGrVePc7t7WCtGeJTQTIAu38vgWTsmQw1w/Ok6d8x1OgWkpNCx2EAoaPATEfBv4aN7rLeb0IQ6tGtTCMb+L1PvDkgO/RMV1B2nxaS7UTULApr+eopM17GikP8ZLavxirNEa1+/8zQWymjzt9SUHiR/XlokBApjB4oBF+KjozeaJi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(966005)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WmZ6OHf/JPoqtmqFBqikAhr3d2M7Qkde2mtF50SNvoBam3YlZAFc/FVeGFfd?=
 =?us-ascii?Q?BHIuQNktYwpjpVfdWfYGh7AXJFeii9YNFgqDnL1QFsfQ38ha1XKR1INoZh5w?=
 =?us-ascii?Q?oR20vmFkXY7XstdWw7iL93lkKr1bxOCWiEu9C/rrRsGWWeN+EEiDSyE4nP5u?=
 =?us-ascii?Q?tfTwK8BMlQXezjNBlmXT37oc7qkuYAlOXiqf6X6PFA49NmtN2r/v6D/pb6iQ?=
 =?us-ascii?Q?fc5Gt1IAXxK5vOJrcBR+cyvjH/0RGt/aIoxO2ObAxiSfs2mQeOfX8SPA9q+Y?=
 =?us-ascii?Q?1Itn+q7+++yhcobICfIvmYfId1Ulpz1O7XGsk2AEOQFiy+N4gdhQJx5zQjnk?=
 =?us-ascii?Q?/YItmcUEC/EwrRElb5Vye7iPhMvUV0HyUBjeilaVVpB0lTz98EzKGryUML1x?=
 =?us-ascii?Q?VMgr5okiKmMIyEgs48EJMlAB/np7ahMnSNbvE4nXFz0Uo7E+YgFDcEpfqo47?=
 =?us-ascii?Q?XHIrWH4sUWGAMDX2tP1MInMNb5izzHGTNNfUJW2YEdHMfix7kndGcBf39QOE?=
 =?us-ascii?Q?FXVn5LDaPzpsTl0T5iBgQsds8OiNhv8eY7MckVi8znVJMldxjsjtmqjwngR3?=
 =?us-ascii?Q?FP73wMVZtzgMQ/TuDNQyq8P5g4EudVq7wsvAMzIgK+IcBEBFro0FaJy9woBr?=
 =?us-ascii?Q?6YulYaA+cKrpTWg1G67oc1m7uzid+obgbAxcHWgUbIipcTHfy8LuJZuIf2za?=
 =?us-ascii?Q?YO61RZ59+FVPTaTu+LpGkB0v3i74Ri91kbYCqtfsAwyYKPTX1NV45O4suj3r?=
 =?us-ascii?Q?SMYHM6sMdyVhSF3N5AsDTvniGf4iz1TIfwbW7X+OvkIR5yIGK+PTtrwYD7Ey?=
 =?us-ascii?Q?BddROXBUfR1aN7FK+sOb4pq2KuVCXEuhTwQ3RprBONlChTi36WfEDZbdJUKm?=
 =?us-ascii?Q?VrcZLbs2bi/iZzqyd/rginjH0aKKWy6NXIUcg5bWJPyVddKmguhytchqa3Pg?=
 =?us-ascii?Q?QFdjVq+hprOEaSElNnl+wVSaxSzNJMLM+02TpcBgrpd92zuhF5iamzfpp+Gw?=
 =?us-ascii?Q?xZV0Tt+6MOsaOZFdbtqyPYKwecMxRIjl7mvq90SVhRbR3CHFh8R8b9RGVE94?=
 =?us-ascii?Q?tnr0aME9mdXpNJVzX4qb3682dRQQ+iQpDdjvrIHKPmPxBDhrwiyiGxunRQBv?=
 =?us-ascii?Q?VuAVYvtPEJ6XJ65S74jX4K5YLo1W43MDfPftzdnXd0nDUFJP/annONvAox8S?=
 =?us-ascii?Q?gTBs3+vKrVOLNYJ7nMfxZ9BbNgKW+CsyRzGdDmwG5/IXJGbIuyetTnGortOf?=
 =?us-ascii?Q?WLjxFpaARb3hsm2pMnKXLI4YGdvBBeuMYqS191SckCoHoMhvCbRCOJ5smR+0?=
 =?us-ascii?Q?DPZRzOCl4z1BEEiZzHS9pJg3TqqozmjXsTN+uaSnsh6sZALvLgSaFnKB9LoY?=
 =?us-ascii?Q?zM276cn2u2SCsZBxZhAKSIWDyPu5IzuxLoVB7phe1MD1Xl7F42AS8MnPERmJ?=
 =?us-ascii?Q?n4x6vcFmiQuybL1f+MKIA7quk6sJJzsYY8jkiP8Nlo9BCKZNKfLhPsIDNDFK?=
 =?us-ascii?Q?ydeQtVCcwAckb38VHuWagKWzc0hxUNe9yqU7bMR1Mo8SFPZ5D2ZWsUtFRZoA?=
 =?us-ascii?Q?reme7ugiBvzchMpQ9VQfv7skOAx0hmnAkw9TCFY9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760e04b6-ba77-4d00-472c-08db4df002ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:09:03.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PITz960IAvYyScmDj8eTZ3mW/sJeY+kZU9Yc5iWyZT/zg0fmDHLFlkq7/ZXtPeogDUKBC6ekoQavQLld0zB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

The specifications from [1] about the "REMOVE" command say:

    Announce that an address has been lost to the peer

It was then only supposed to send a RM_ADDR and not trying to delete
associated subflows.

A new helper mptcp_pm_remove_addrs() is then introduced to do just
that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
subflows.

To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
command, see mptcp_nl_cmd_sf_destroy().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h [1]
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 18 ++++++++++++++++++
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..784145e6a314 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1555,6 +1555,24 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
+			alist.ids[alist.nr++] = entry->addr.id;
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+}
+
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..6beadea8c67d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -232,7 +232,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	list_move(&match->list, &free_list);
 
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	mptcp_pm_remove_addrs(msk, &free_list);
 
 	release_sock((struct sock *)msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c39e172c95db..1a2772902e9d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -845,6 +845,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-- 
2.35.3


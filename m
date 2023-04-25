Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C187B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 07:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DicO9XNvdVtNrDepJ3uvEd6QmXCWP09wjb2M2nmy+IoDAe6dfJqeDY9AMyV8BDr7LxkMPZY34ocJwWo69cotjtC4rJzwos/Yxv3h7Bgppmg5kK5Y0CeiYq6WTFSRJbeqGghGyBIzOzWnPmrt2lq2teqEcLGXEFHye0HAzSwUbcB0RpybqdcyEOrmMEpX1+u9eaXyFMojEgBLDn1j0Jr5omV4RHAIcZ6ZAMhY858PnMp6VyhWoZyi4qGv1lhsSqenqJNEWq+uKwM++9tR2ycT+Z63y7GZxDtyevO85+IaSHqU5bvl5lUrk9gWJDcU69eBYEgHlH0SXLH0mSJKFxFT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyoRuKlfziwGBDgVyC+fbi4y7ALsa0iyF1xMsqcf+MQ=;
 b=mLrlfCq1jxayDWdeUEp1Pd/xwBWzFwdB1bkGkU1rVHHBHvG3BZEk1rz6CHBmIWcw2rAtgaGiK5i39h7vPW8N8Mv/0Qx2SLXWELErCLX+41WZroqkQof1f5s1rJRXJfHDg0VEBNef2vig+h5wYLRmrkF447OLXmjau4P6yEwumiAU5dJxyALfCG6iA1Y8GuvrhQbxgXNZe7xHMQGNcgckUpbEXQOTZblDx1BhWd9zDXYk9Hjzz41AcMWkJuPUnPpKdYSxp2062GAWHakTa6c5Z0I1loRsms0lr0OQd2cfiAo3tpYMoyz09AoozFaLAS8qVbZodDdsqV4nVsWh5B3aDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyoRuKlfziwGBDgVyC+fbi4y7ALsa0iyF1xMsqcf+MQ=;
 b=eGfrmN/7MiL4Of50z8Xicr/+UkEvxKqDIXyGc5yjgoXg3S7wizCCAUJnzq32oIz3jj49lqhHHgfuw1pZJgUB1BYQv3gC0wgMx8Jqj5Q51cu0KaH3OgYxdg8fF96vDWOHoh1iG6XUJaigi3ht93zc3L0TTi5Mir5eZa/g1csyOfXAeHSXgD0OqK52q3wx5sfUW9vNbUq99SajkInWGBeV6uYeKYyAt8cqMHpsJdiqAPdxT4UytC9rbMTmPu/XMYMX3iNFLz4hYtFCwZFk6+1FA1e9tm2v9ZDyWjEntqiLrNq2NG0kxBOtEB7xTIzLeFalLCohzWbeueMdT+Yy4nN1Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 07:55:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 07:55:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 4/6] mptcp: export remove_anno_list_by_saddr
Date: Tue, 25 Apr 2023 15:55:09 +0800
Message-Id: <1b782af3035e0c727ad25e9a51488b25729f099a.1682409247.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682409247.git.geliang.tang@suse.com>
References: <cover.1682409247.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: 374b0ee5-1067-4803-1a65-08db45627f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	alBUJdCvjPschkaoawI4SZz1wIg/bqWilULkofWMNHfUj5dTJ2O+kzue6WAy38dPqLiFVYFaJlY8cuHboneOxR9Q5eDCVmUxxzP4J6yjYlWYZfIBs1NJbKHVrEZz5qgmvisQWPXAMRPvLTzNY60BE+7Z04Ek/v4uoDa3dej7gDWoaDcxdiCor60BQWHLKhvEKhVaqaAWF1ZL5Srpob20sOt7SWGUe2v850dYC2tX0Fc0vtDeSfi9I/Il07rCVmlGALNcfJSWk6O0DinqCqKMc9eEuNmVfQdPksb6TVJrU2QNWsoGArUfyAlz3f6ek32NbE482VOBvTfXalPODXv2HB2XgGjWktLw0q87dLhFTykZjLdwZjGDpLU58Zo/quS/LaFJKnWyMwKlPWTAnOBDHc+5SX8A93q4RELXWgz+NgRkQzEPnevZyIq7Nnnd6/PZ8JbUZ7Xa6QnjY62/MdFZ4MclewUR1XPsjCJZrqQBERc00PrQFHEjbTXhblTAdnZ0FAeKNIAQ625bA4HaGLGx6XGlVqq23j6KDG5YTfse+wdBdgKzKwzoH1pdrpKRVPT1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(6666004)(38100700002)(6486002)(107886003)(6512007)(26005)(186003)(83380400001)(6506007)(2616005)(5660300002)(8936002)(8676002)(41300700001)(2906002)(316002)(44832011)(4326008)(66556008)(66946007)(66476007)(6916009)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m4zyYWpl5ezVeRaaAF4+oRILRhax1qH0plG0azljTCNZSfCozEV6powwqKvu?=
 =?us-ascii?Q?QxgT29LCekDGc5Pfoy/ADLt6FhrjqDWN5ZqWddXtrm09rf+lopbXsDFkiEOM?=
 =?us-ascii?Q?rMCt9zgmMW0inZFvTUS2BD3bxC3nGzc2spK0RviwuEe2JEIm/z5FaHJjzD5/?=
 =?us-ascii?Q?4alPkDDrP/6iptU4k0ZUaHzFPgnD/LkjXgFoKK9Gz6vnlwTd63cdbvdurDNg?=
 =?us-ascii?Q?gbTh9D5I9V7T4iLzzGn6p/ELvQAvBxuoRZ0aKxcGncAmTFGRPL075lfCZWtF?=
 =?us-ascii?Q?cxt2pVLCnryhxu0hhIBRvqtMRsagZOr9Y8GbAxvNmIoedtXzLMKj3ZSrCjcD?=
 =?us-ascii?Q?bPjYsuyLFGeDa7mws2nIHvyXnBE9gZ0PMF/5oIWEx6hdHBC3seArn96qj7Cc?=
 =?us-ascii?Q?+J7RbvVq/YqgTFTnznLG6xDFqUrHJn/0pcP5PoNySE9iEILXhRP6cc0Ab6ln?=
 =?us-ascii?Q?mfG60YU96qvQNR0vdjNJNTTeY+Lbn2Tur4sHmHb0mk0168ImFZuzn4yMaMDX?=
 =?us-ascii?Q?/V/o2QxkaQc7L09If3/hH1nYoblCSrUqc+s1QjkV3Q6DMUgEu7O9dxBNqjHE?=
 =?us-ascii?Q?Om+iqTV6HHjmmka0WSgDjEo/nQ/Zerennt8mM6kcr+9RIJGueoBUi86B7YNs?=
 =?us-ascii?Q?KyGLEMe0krhTMXJSewfJeKbPnRX0c4yVcDz+JLRQfW4Mb532ymJ0sa3AXbGX?=
 =?us-ascii?Q?czbxtp6zrzvp3ErT+oKS6J9IcP+DfQp/ER/A7cs9uDzW8EuRqAcUZMUiO/FM?=
 =?us-ascii?Q?Xj5Sdv8AZd2zmjfduqaJIPXbCp11KwVEVE/kq4djfdKEpCh11PvsaJCN7Ris?=
 =?us-ascii?Q?vKsPDZDjd9kKh/NnEa6rJ8HbZP0jaW05QrrSHe6RngpjzsqHBsDMdPH32xYi?=
 =?us-ascii?Q?9/S+1ozKVXsM/YqvXz3aD8huzHsCoiftnpZCQEJudawi3c9HyQ/pmb8eqngd?=
 =?us-ascii?Q?0SB1I8OkXgHaYXrqUw3peSw35MLEdjU1zvrXTDfEg7uOSa4UYBpHmxWje31S?=
 =?us-ascii?Q?r/1xaj22JZPuTamZReURRE6AnT2eEhgHZxhB8LsCcCkY0iOne0H479c2akQU?=
 =?us-ascii?Q?FNdejmorMar7BnY/TEn2VfyimFpaCQWT7Q5xoRjX+4ZnuipLA71o5K75SP4s?=
 =?us-ascii?Q?VPuO84vu7DU/H3pXVrrQfa1ewOyX+lBeFHOZaMieNieO3kiltERishmqJln9?=
 =?us-ascii?Q?oWbvEN9NWLMn2YGNML209RpQUofL9Mqh6s/wFl73Gj+yO72bqRZkw4u0e9An?=
 =?us-ascii?Q?0MoUli+6Zgv/wgRs0HcnWFUJ3klhjhUjfu/QROETR55cR2rUw/8hhNrQxy2b?=
 =?us-ascii?Q?4kyTSLe6iYFW+FqJqGmQIjvd6NobwwEz9M2ktPKqDUnRWdKKOlBK4JX15DX6?=
 =?us-ascii?Q?W5jaCULjHT3ZG8VLzYLOVil+vA1nhT7ZrK9M/Hpv/1KxBzL+KS0lL6DUFQHK?=
 =?us-ascii?Q?rZF0YTf/+IwYptewf1+R6ptzhJXbpTGtqssSVXL6T6Z9V8ghrvYK3D1zK6x/?=
 =?us-ascii?Q?62vfGPH0ezE47B/3GtQAKTQbY+kWyNSS55N01yPqJ+7U3x33MykUwavidCMh?=
 =?us-ascii?Q?eelOjOkcuMklKm+X05ja2QB846PLJYRl8eJNebij?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374b0ee5-1067-4803-1a65-08db45627f38
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 07:55:54.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvmYfmMUXSyfVX6SXbHK06jok7rd9JfG17HJr0K9z0lW5qc4yPFX0OJgIqwfETmgACDctxzUgF7XMG/Ml9Y5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

Rename remove_anno_list_by_saddr() with "mptcp_pm_" prefix and export it
in protocol.h.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 10 +++++-----
 net/mptcp/protocol.h   |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d85649bc27e2..3958b8ec4269 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1399,8 +1399,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return 0;
 }
 
-static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr)
+bool mptcp_pm_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+					const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1423,7 +1423,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = addr->id;
 
-	ret = remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_pm_remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
@@ -1561,7 +1561,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		if (mptcp_pm_remove_anno_list_by_saddr(msk, &entry->addr) &&
 		    alist.nr < MPTCP_RM_IDS_MAX) {
 			alist.ids[alist.nr++] = entry->addr.id;
 			spin_lock_bh(&msk->pm.lock);
@@ -1582,7 +1582,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		    slist.nr < MPTCP_RM_IDS_MAX)
 			slist.ids[slist.nr++] = entry->addr.id;
 
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		if (mptcp_pm_remove_anno_list_by_saddr(msk, &entry->addr) &&
 		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1a2772902e9d..bfa7d93a1c1a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -831,6 +831,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+bool mptcp_pm_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+					const struct mptcp_addr_info *addr);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3


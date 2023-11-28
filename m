Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BF35888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uSsaf4ZW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwExRkraPzpXcFIB3XCsZqmSQ26GUaBsmqMbSZXMHRXPSK4KmSYteA+a//iju2cxZx2UQM4eE+q+8j8oNiEDa8KrTqwr2C42m0KiEyo0gUl7B4jOe0NRFxi0MwLkvYaNBmMLow/EPQIbYn9RTwC/tBqq798zPKiMRAaCEd5BMz2ejvqDCc1qP0a1UQHinOwwDSIdg80rJ9gssZEREgq4BzfuaAaQoidG1SUoYQchpdANA+UuXFM9Al1zvIH279woTNPIoz8OUWAmTy8ATf/pjvJJe6W1OgBhAi53HrQ3737PGrwdoM5w2zgbsvripxO+gw4DWkRPGjDZtWTfUpJwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=ghnuEcssMkT0reYwTHcuW+/XM3WxCcHAe0E7OQf1csxkwFinXUkzJ0A8j1khwW6BjFOoC0q2HYqHsLDh6lFmYVz/O6G7YGjAhi0sZkuif21nQ0EHEvfvTbXCt+IkXxqKNO6Ez8n3/WkQxsDxkoN2LRAjz42fKszzmJVqH9nac0xU8LiRcn7QgsqhHoAee5KSgtNPRGrjmDlCt+/uYNIgaS9JqC7a9rb157YYlxubXGN5XY1WYQhGupGAGl+AIRPjL5Rk9Z8uKA6ZEurjnzOleBRBgDEvw++RNCnZgMet6PL8Wgz/ySD76f9S2Hjihl74R5OB0kJa3DYvyPaYibulSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=uSsaf4ZWrEw//GE+Wtk3YuD7ZGt5N4XTBGzC1A29CQOzCn8sGrpDeZcKDjSue/6xaSvEcaYmyfjUU1e2Qlf9WXKcWUMY/EjcrR5TkS9fqawYRsq00MYp8BSAmCbqPwrcG6OfTtk+ZKxp8llHUT2tLi6+uGbjhCGuNSTfrOUi9De1NMRVJR4b5wdByE/CZaEkWAtJSxF/a2oWx8zBPtrBcha3fLVZVozmJsTST00z3JlZ6iB/zum9vRI6N75WkXq7r12IZ+LQNc8iAERXqxEEc/OEbO8RtcWeRRYN1MECebvrj+FgUeuGqzhYQOT34xIJ8MJjG+BEfNrXGe2PHy+fXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:22:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:22:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 05/32] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Tue, 28 Nov 2023 22:21:58 +0800
Message-Id: <9bfe393c72733c5a13ffc52163435196ac2c81d5.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd9e108-7d5c-471b-41b3-08dbf01d719b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3X23ZGx+afqMDtwIKfqMX6Bn3WuYXnerT4Yq6Z+OS4HMNiIeW4gLWgsZGUJedHCGdyEBJTAsy8qS1crnr9Xo8ABXmuAwv0S01qU5Jd3JKbFy5dy5GlIytk0ZmjcoHVMQ4SbwCp8T8aL4n4JyOMUgDhhPclSAK0cR7dzIlgUc5mwXSv5SK37zoUsMiJr1pI2QfqP3QovF3cFfSFCvw0npPO9yMFexxTHrVbTByy6xgbJLEltyKyGPGgeyzTtq5DJbkDSUXVn36qoACBrU+J2LmayatDNszjBJv6zxgNaR5VwbuGCZzcS54m8KAeGZyfnBrXFKnKLwWvl5lCOFljBuFwCoOTyjPR0G6JQoPwd1i4X4A6AgndRcRcbpHDV6pYQ1uay8VbmtaEwktaBL+l7b1FJM46kLlO5PyIbbD7ybprJt4DWb0RPGpDCU7qYPpjqJKQVJsEM0PsJWfn6S6ixSG4DMgbDCrUn+cvhngNwn6z23/g7AHcHmBVDft1B0wBYKPDJshyPg8ysgI6rKfT9yBSQQIWDIycPEfhTRDNltnADG1O/082k0+Nl+IhtlNLYQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6666004)(6512007)(83380400001)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iz876a6fb/y5UojWweqRJQ2IQT+L9xpqaGn3W49aGfGyLPJ/U5ftEdL4Lnh6?=
 =?us-ascii?Q?qW6V5dVoDSwbKQDsn/IOpTS+ahqnZF5lX4oCsxCJbPoamnIaV6V5bECtXoUw?=
 =?us-ascii?Q?JJEGYJX+eEfws4FPRsYOQ7dTvFtKfPa+lMNyueqm3xgSc5DTh42u6WDujrix?=
 =?us-ascii?Q?U2cw9wVY76h+Ja5RvLYsS7/54CFjzCf0XmTzDcUkvDs6yz+H0/lszFZCDYb0?=
 =?us-ascii?Q?8Ovlx1FyXzF9KBLHjTyTV8goZzU7MJwl5ACbNXgwoDt/G3qpoXOvl7AYHM2W?=
 =?us-ascii?Q?04R1kbzDUZw0q3pZF3imKHSUC3zIEA607bKJJNmXcxJukATLRc3mLf1lEl6V?=
 =?us-ascii?Q?Y6BBh7yB4yzrDUMGRE85kyVQmWnKIhSC+clVLGb7bLQBSPqp01frCIw2TTt7?=
 =?us-ascii?Q?kHjpTrheFktzMBS1PSDlrGVNrtG0tCoC7ShMCDTErm6QyaMs1Y44W3lHzXgW?=
 =?us-ascii?Q?P5x6ZmUIgZ4jmsiZibtsSxTefOUqd0761C2tJH6LqyKAbLqcf19IZg07pbKW?=
 =?us-ascii?Q?BmqVObyEljAOXSn9xEKf0MSp18Dhms+c5YoZVzCVfwFaV4wjD8jGxAOfY2PS?=
 =?us-ascii?Q?EL2aflkadrQbBXaHL3c69HSVYc5PLZJGNI+8qeKzsQVCSrmCXhhWndM6Ltu0?=
 =?us-ascii?Q?eJwClnf9YtJCYKVazDlqWx8ZXHqJPhLYi/zDYfKRoM+wBZklRkjOI9uhDJAx?=
 =?us-ascii?Q?HNd5g3IxNZhcmppwFSbDZJUL6FIaDoBXgdttBE24Q+hGsgrTJyzkYgozAMd8?=
 =?us-ascii?Q?y6aF79I7rtl715tojREF9GuBgubSt7HvexGYtRyR9yoPV1oLo2vdYm6mWpXa?=
 =?us-ascii?Q?6xMjsZfkejg1wa6gG6lHDIxHr80sushIarayVTZLCEQpR3rjSA9IHhBVM9aj?=
 =?us-ascii?Q?wuD/rZ6XuX9yrBTPbdz/wkkekYjjAtljktQ1gGXppwtNTP5073inDX8JImWv?=
 =?us-ascii?Q?CAQNMJWAoFfR03Qcttsp+7xWmPSeMgN6qB1IYSdmLVNTyPa9NSelAfB9cE+q?=
 =?us-ascii?Q?aOMszHlwEmxu6DF8zmPX1hKByfVAuRfReXNU783oZ0Ei7MC/E4fvHqrzD+yx?=
 =?us-ascii?Q?g+YlxH2AHqnefyVJBpShAratFEuDjkNorAUsirCUDBeGTz3B7+ypaHIhrrsU?=
 =?us-ascii?Q?ENiolbBGxtuYwAG4zNlOXci8xrpXCcSeik7sqwKDTe/cQu6eXwbiqemJblN8?=
 =?us-ascii?Q?eIgcbbDAvLeKCuL/rJtuvazxAPiT4UYlV9qzcaX3R23CtEy4tjxZMYTGPDQb?=
 =?us-ascii?Q?G2/RW4cri6cKJKanbQuzubFsDOi9Q2semW9TgitTQt9r1R2aIm5P3LR05n8B?=
 =?us-ascii?Q?4WAtH/vYMEJGw4WeYnCdXyrzbkI/JXGZcDhga+vhJU9mWbmWsPEpDu70CUt6?=
 =?us-ascii?Q?EoFUOvgAXIkVjYEa1Z5vreiMXId6qrrb3zM3RPgDipSbUzlmBWf5X4BkREK4?=
 =?us-ascii?Q?boNnvf5I/LglZISP/JzaMcciwS7pk8TFBOgsGPzPkglGCbTbC9WbqSNCSLyG?=
 =?us-ascii?Q?PcA9WNmsBJzbxL+/CAjiE453XbtkJ8ZQHqsoIA5Bq2OFNktuprV+67za2mPq?=
 =?us-ascii?Q?W+BOxi/6mjidBjqrf9Jp8jlfrWgB4rE3dzVLkZnG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd9e108-7d5c-471b-41b3-08dbf01d719b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:22:25.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9rXUxqxSiE4qlczf16laXexziS8HYeNwTR6dN4nWHu16M4APC43Gzy2tH1W2JRPyhuZIfyLywEhLy8JBf519w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dbf040e39af4..4cb52df57ba5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -458,15 +458,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -496,7 +493,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1832,7 +1829,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.35.3


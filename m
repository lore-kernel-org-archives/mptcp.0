Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB81FB8
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeicHJkKPDJrGuUsY1Iyd6iQU3dKdEFa5h4HcOZSDQje1hUVmNse0+haqWGnOiSDIaSLLuXsQlfvY7E/8o5+WO+/u6x8bArzA8gMm1p/bhUjqHUkldMkybOZ7Hid3jsiXONWpK8wRQYxKr5Y53vayHIw5c95C8Ug7o+9eI0Dm4pczVKBISF2/2bVJzjRAz9bcIsRscKowqfqswK1nJPVJfiMswPvpXfYzv9HJ3leSBfHcu3+DcmBZirXpXZpwCi7kBu6E5KLCvsrgtgnSPerPiH/bbq2hTL/WqE34p7o+FvWS8O21AFyQtSQDXfFeaaMhAhbo9kyN1Q7ipqdkfcPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6dlJvmqnH/DnlcQ0YYS+LdKilIBArwhW5gjE5sagf4=;
 b=BQnFyTF0+iAWT7IpqJqi+zb0WYe0RKceqjopyfm1DFwps/vdJgfxHVH20v7fbzMAnf0oI8hELJGDj/scyJeZUowuTJLdAdhXW0G/HyKqKi9o2f1nyoVNm99qKX/X3KEtO/8QhBAGXleEgRWc01RS8LpwH8nK1idT9qIFQMYpDfv7YxNd/uLyS3rP0dpNyZ/KAlLi5woESg09L2K0zQ0kgjupp3UDcHTnxQjEoqzt7iWsOmmvEs1cJzhfya155TslSyckR7LN+1u3HUtrss8l1Plpyqi+z46Z1gTUy5p2YC9q05eoejcsmxOtnBqp9uEdKe0lso2PVDa0GQzDsqiaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6dlJvmqnH/DnlcQ0YYS+LdKilIBArwhW5gjE5sagf4=;
 b=OSkfXTF5/CQutII9UO0fAjcIKfnIWq1tOp4bZFgcoOTble/Ktsg6FjDXxoZBr/f+fQVLn1cJc53NJVRGgHxX4Zfl6T6g3nK52FN6y+dheAjdisGfayqI6aP5ok/bCHnLFvC2iSbNnk32CxGpAF2zUJSH0vloNUqEwPYMOg425y60pWj3X+Lkf00k6vVZ2CfbCD8kIOBydk+fP4tHXPFbc4XxoRXmV+RfVXn1XUgG+1pDCrBxxEKZP1LXEzAK202WndS1OOMH7NcrhW3w2qbNq2weJ3uqyKK4MJsRi+IPV4MBp+Zny4iuQ/2lj8mKUALbUUM+BLipWbe9JtsL7+UJgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:07:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:07:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] mptcp: export local_address
Date: Thu, 25 May 2023 16:07:07 +0800
Message-Id: <c8237ef479d4db0fb3c170e48d7c991d274816c4.1685001897.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685001897.git.geliang.tang@suse.com>
References: <cover.1685001897.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e2df89-2725-4d90-d3ab-08db5cf71242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pxLlFIHMOSvvnfgTWgYKhLg0eUc5DS83r1Cuspsy0xJn7EChtGTa1Oh5nITKNoFSTJKVClQYZ8lrO8kyNxviOhuCekrbfAp2LS9GlPEvbaRy8kX+D4s73QGcXrnDgYWGCU37q2gzqvxXzqj63I5BXkHaTjzms8m7Y8tkorx2CsbNFGI4eNYXGbJEVTQp8ZMwmCLTcLQn6aaBgO+Ad8el9sMfOJC1Ho79xZhTbDi/odyzLzhygXZHCRG6bIwBgzEz9sBSmkETwp4MMWFiKUEqt6CBb1KS2n6mQ0ON02Z1FFAySohFQmNUj3vfiEBx29CiyvbC4ZpE4DCFYRDhvGGy5RpzYNFD3tSD0k7AZNZUrLQvv7XiC4Jd6wAM+R1tuzePqkCT9ZyM4MlW7JPJm81nyFj+NTWmqG0OIE8sh0QF7P7W7OOXRhtBj6WRFfRLcj4VJlSWLMCAaq5sV9GoLbC7sh4XAKT4mQ8OTQndakyWRRnFYnSKXVPdmWNIkWgdkIPXth1xQG3kNsm99jqrRHYWxdrgjskHMylDsLOYc/ShV4TwqxcD9J4FqE9p/jnaOz6x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(5660300002)(44832011)(36756003)(38100700002)(41300700001)(66476007)(66556008)(66946007)(107886003)(316002)(6916009)(83380400001)(6666004)(4326008)(6512007)(478600001)(186003)(8936002)(86362001)(6486002)(2906002)(8676002)(26005)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7W4Yqh2qfE6Xb9hs01p8hcTS88nC90m3xeV409U2ZVyMneYlC1UPvS8JFwB0?=
 =?us-ascii?Q?2XgNXzOLxslOD4SIHqHrsXMABeGtgMZ6f3lfbpB3nSknssRN3ZUsEDfD9h9p?=
 =?us-ascii?Q?JkcM4wGvANoxp0bB12ikxzXVkpzdzhS15wH4cGOxNjro0myPlOFfjk7EoKhg?=
 =?us-ascii?Q?CvmIIZWMlAQnQ/K5AISVemORfU5Vy0jHc6B286Ex6Jq3JST9PhZ8v7yR/OPv?=
 =?us-ascii?Q?IhCEW62YzYvnUPVxcLfXOZ3KmIWBMpm2LvwsrzTlcZ4dpRb5ryKoOkSLLnOJ?=
 =?us-ascii?Q?Rpz9mSAQdjkY5ou5cy2KMEm24R06pYFmfkktZF8GY76W/jXv/2N4ROf99WVt?=
 =?us-ascii?Q?50duQYCxNDkzI2j808Fo5tOoRwPzg8igN4aBmZ4eYi+x8Y3dKS/Iz/dGcKya?=
 =?us-ascii?Q?7ugsPMTyYXmWah5TNkd92EvIOa5Ip7/QYAo/D/zn2sNN5S8awAllis8UPkLE?=
 =?us-ascii?Q?CsSAtiCWglq5BH6j2vSTZCpkabsyqUPZm2SyAkLhOqaRvj3gO7/t7Ix3Tlbs?=
 =?us-ascii?Q?sUVLmdRsuYkPaXHIHbS7Z/3jD0Xy/3CI9N69jrsUvmgz+TqmZcyfP6dPpkbG?=
 =?us-ascii?Q?4J21gPWXW8V7u+DbD5LlQJJ+1wKh4OuTPMNFBxo9hp9vRdpjDO8am1AIkMG+?=
 =?us-ascii?Q?JD/7dDMxZKDggy0MtG0/tJ4Wt9CI2H6EkKkJ2XG1XvJT+ON1xK1k45d9EZO/?=
 =?us-ascii?Q?cUHMFEjLFil5TtMIeJTxAzz+kFSPAuvuBpNROnPx5u5ZNxCtqZkkHa2cki2H?=
 =?us-ascii?Q?B5k0AcZI2FoYH69oS9HoMKEDUQAgBsTm2IfwPq7msUz/Kup5F7r5Q4aac1VK?=
 =?us-ascii?Q?w7her8iKpTy0eqOUqokO7SvVnqZKJiarSVhNLDZiS7jYn8SNHET6qqJRWkRo?=
 =?us-ascii?Q?Qbag/xbuFDvln79+IjF09C8RNKGc9tcK2BQEDT9Yob/ZqPduvy7iENgFg83h?=
 =?us-ascii?Q?9UDAzLUKoAjlXIYnzLokD42nIqWmHHQhIaqRAZuRaBMGHsJjViP7uRvDx3Cx?=
 =?us-ascii?Q?K68e+C20+GajH8104EPm0TDqPphCvfHk0UAOgOUnhi3id1hVtKHPVOv22CQ4?=
 =?us-ascii?Q?HD1j5oGpxujJygMUtkVnPgVzmUEzJslWm89ib+QwgjgM0BvPC+kMO7Mtyl9h?=
 =?us-ascii?Q?ZS79IUpCNYX8l1BRBt/sa7SHEOjj/flEl9BebJ5f4GD8AE4OX8FgH+iXSHrL?=
 =?us-ascii?Q?UFtGeBWGwCKiOPulZY2wP4WKZI+fVzkUoDHkiyvi4wqBE57XkpYv8lj1xDTy?=
 =?us-ascii?Q?EPZk8iUBjKuQM9jg+VcXAybHcJEJ1xr3+ucQJ+wFXzZoZl/Uw9HPKq7mtSsR?=
 =?us-ascii?Q?c/lEIRqDS6eMIMAG/IXxuDv13Q+ktqwwfZQN0UVIJjT2P0bxG/0fQBl90u46?=
 =?us-ascii?Q?TunAHsWKqGJdDfp+xfH3OZtUW2fsqecG64CyPAk/mzoOCh/a78xCkxSU7ZZQ?=
 =?us-ascii?Q?Wrwoc8mHkQPI15y3W1jnCRIIWUulYj+rWq32ZCMULCmGRqNnV0QGg+LnhzhE?=
 =?us-ascii?Q?JxKzUMZ1wKY1N4aoHPajTdoPYWiUf0cH9ArrdUKrl8N+00KHXI4IudNHE68l?=
 =?us-ascii?Q?FOyOiEF/t2d/HwYB9steInsBeeOMJiAWkxe666rv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e2df89-2725-4d90-d3ab-08db5cf71242
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 08:07:23.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cKT02YAQU1xYC8uOMRPloFQzY9vUe5MJx86V56/fq4iV953bg6wkSdc09DUlx3KaVQqg80hCZ7/EAuD1Scamw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

Rename local_address() with "mptcp_" prefix and export it in protocol.h.

This function will be re-used in the common PM code (pm.c) in the
following commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 17 ++++++++---------
 net/mptcp/protocol.h   |  1 +
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ec892fb8d85f..2f58ab49512a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -86,8 +86,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 	return a->port == b->port;
 }
 
-static void local_address(const struct sock_common *skc,
-			  struct mptcp_addr_info *addr)
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
 	addr->port = htons(skc->skc_num);
@@ -122,7 +121,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 	list_for_each_entry(subflow, list, node) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
-		local_address(skc, &cur);
+		mptcp_local_address(skc, &cur);
 		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
 			return true;
 	}
@@ -263,7 +262,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
-	local_address((struct sock_common *)sk, &saddr);
+	mptcp_local_address((struct sock_common *)sk, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
@@ -538,7 +537,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		struct mptcp_addr_info mpc_addr;
 		bool backup = false;
 
-		local_address((struct sock_common *)msk->first, &mpc_addr);
+		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
 		entry = __lookup_addr(pernet, &mpc_addr, false);
 		if (entry) {
@@ -749,7 +748,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
 
-		local_address((struct sock_common *)ssk, &local);
+		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
 
@@ -1067,8 +1066,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	/* The 0 ID mapping is defined by the first subflow, copied into the msk
 	 * addr
 	 */
-	local_address((struct sock_common *)msk, &msk_local);
-	local_address((struct sock_common *)skc, &skc_local);
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
 	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
@@ -1488,7 +1487,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
 
-		local_address((struct sock_common *)msk, &msk_local);
+		mptcp_local_address((struct sock_common *)msk, &msk_local);
 		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
 			goto next;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bd3771c7d79d..d8c9035c44fb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -640,6 +640,7 @@ void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
-- 
2.35.3


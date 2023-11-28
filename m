Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35F58ADF
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="mlJ/p/QV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBBv3rdUpN2bR5bArQPhZjaRlmdr5HomkoKW1C8MszR0xhbbS3EncJ4B5Lga5ke6XAAEP3OVB9vxxP6yNZWXcOR112BnEyUrtckYI46InwtGpt6eOZZ4oM2jcO7vWDO3G8oH6QpUEQCoSPtjAC3Ed4pyhZdTZKW9Y6T4bhM3rQA8JBCH9uG0SkprNv2p7OG1j1Z3G99fg1TXGFBJKDHGySHOF4QvU5702WG6aYJ9MwF60H4CGqe+nKQSXJh8v3IStp9pVsRtq5yNlEWGZTyFhhcFZTujmMtxSNbLdR4/tfGImf0N0rg2hFWJWT2XF8dsN0U7mt4wfurD7J8sZ73B+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxjjzLZ6kHF8UAV+cJ6wZQea+75Dlq7CfTcoZPopX/I=;
 b=ZTZT6aqFoq4QTvBWW5pdsxJCcE6Wtg6aWUxJgHJN44hl7d6AMwFpGwowv13/Po6tWZNIUP/Lz7KIiFc6NucZ4TIB15GWtmvE9cAH06IT2igvdT0WuRilqNI64as3Uuo34AGedkvCCY9Zh1swSABmk7plNiw7vAE9u5xb9gtB0TquGcuj/qE2rDwAgzzzNAs1+hFK3zt4gk7bTUL24UgPJHeuuoknoF0hJ4ohWkWfqEjEkHqni6kme/HAo0wf5nC58Kadztn2VDBYcbATPOyY1BVIj6q+VHIsiBfjjOipskDcoDn5z8v6Q7C02ZcYvPQPbo4150ZDn8ddvnq6YwYdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxjjzLZ6kHF8UAV+cJ6wZQea+75Dlq7CfTcoZPopX/I=;
 b=mlJ/p/QVk9gT4AaOXRw44/U3WVM7iODnx/gvQ4f7xZ4FTJN08vCVqSbEoqG5mtzrtlF7ASA2W3GAjOtpR6tGp94zZvDCQnnm1yynjJ1y2TQUGAdNSf2Bpd8OLVQh2IJmH4U/hI14oIXgk2SGDNyFjy73KEvifgxM6+W3g00PxVABUUmV32ZFG+uEwZFhejUMDvZyv/fKm6uCEB51D0+p8KXh5siW0q4azltfY2RENVgUadJ4/RVLG0EkmYPZscEgEOgj7huh742KgTTJNIWIxrtNcDnbrsi+rra8rnxcVNcQKg3fDXrqXQfspJr451NadyK9xe5YZzRL9ZX0t3r7gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:25:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:25:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 28/32] mptcp: dup an entry when removing it
Date: Tue, 28 Nov 2023 22:22:21 +0800
Message-Id: <bb75dc309a508b94ca79684c58fc897b8a0d5cab.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: bd45b36e-fdf6-4ca2-3cdc-08dbf01dd43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YXXIWBNiW0DXHPYJRGRsbG0EabAF6Bkx8KIUo/wemvPTqDI08U2gwg89KJuvtyAj941MdSN0oBCmd3dPszfRg2wmuc1bdLucfw6dVOYUDMi6x2cep7acryNfICYDzyAbhf125rixi3/eJT/sSULDp1X00rq5R8R7KpbHPU3Xw6swjPB3cv4e5ouxm6i+SyGVPYxySyS2RjGALuoLSY09LWZOdSL++sEDqL1YDF2hn9WV7Rac2VjWkk5UDXSp5CZ2QLR2VOBcNzZgUoc98E7N/+PdDVZTC7ZmCEljqOfXW1LhhOjBQlSUYvVICZaBUwoWHIyUdr/Lhb4TIfQVfqtreYL/qzmbIwV/T26W+n5Y5vUtaAG9JYEevvllLtY5iJGtEM6Wkq+e8PYmSDlEbFmtpm4u6SIAi7P1XpvaSMioKeU/ilKea9HDOIhs0RHbSoN8wJ/KHBdxlSYYHMoM7yjnqN9HyBOdPz1mXesWssyWCLs7QIi9E+5CJi4j0n+lAEuUSJisw48NLHv1qLX3twirHb2D9vngD1WpjWB7l1+v5MfxOkJJBPLPdVno21Pz2+Rd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(4744005)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Virmk2yc4RBW89/9nqSJHUh2nIZr2PSX3XB/QX/FCNRr/W2xLpe85qaBrjXC?=
 =?us-ascii?Q?C0/E2aKh9lJIBlx0SxA3MsN0hsgou0fvqkCNRNVIp1mnXnBDXmtO47DmxOmb?=
 =?us-ascii?Q?5Z4DbnNNh+1MQalSGJL/2VL9FPj5yKcUI4CyXol77pzyhX2XOQUJZgy+K7+/?=
 =?us-ascii?Q?ZB2NxjCUF1+5XSaLubiEXbvJI8LnzH/rS1CfQeBYlcC1HJg0GKUTKS1dzAq2?=
 =?us-ascii?Q?RLh7wV1aEU4SB9tHWaaefZwlyr8eAPGmKG8vyUvvXRzr9hul78gyUWB7P+mJ?=
 =?us-ascii?Q?nB50Hlbh8NlPKjB/9r3Xcz0QO6C3lK/mmtQZrpIGGswXDuu1uCI7Q1fcLVlz?=
 =?us-ascii?Q?E0Z4uaFjP3Psb4edPo+FHdmfKMoMsCwMEd/PMEL48/g+GK7m4kYEZsLbR7F9?=
 =?us-ascii?Q?BGxyN0KLwJZW3YgpyFCKchlw6E+NytJhaGakUYoOGnMFQNL6swszCUuqEa4A?=
 =?us-ascii?Q?2Avt60KjnfDx/ndJttegm2DSCRhDjkNc0HVtBp8j9iiaB4ULdTe5bXX++RCJ?=
 =?us-ascii?Q?aVAm5bPiRAVqhuEXpigl6RhnP1qLCMobPWccZ1HMSVOJU2bkDyxAFHHGF69Z?=
 =?us-ascii?Q?PIkq3lhlNvuRBXT3zoCoD9LYMIgfybSuPNEuRX9tqMrBpFj11V3xaGYzWrE5?=
 =?us-ascii?Q?/WZ10H+Qw4HDuCcLRRSfH1R4A6Zh06LzJ4Kia2R54B42uu7Gu3SVhW8SO+M/?=
 =?us-ascii?Q?JQguqBs5arkKrAL0vBCHd9aSKbIHXD0zzFQUK3aIGo24k56jk4YVJZXKGZ8E?=
 =?us-ascii?Q?1XSyF8aVIB+V2oST+VSXsuYnDwFP99sySWKdx4fzutUsii0Fsj1s8mWRoTlS?=
 =?us-ascii?Q?/zYaq2Tv4HfGoqXsOUESsKSAvF4K2I2fHZ+hLtMw4T0NMQ98v/aDrCgrOY9L?=
 =?us-ascii?Q?LAvJk3LzOn7W95Ox5X7LC+2MNEZhmS8JOB4CWAR33Wtu959T0L38r/fxCTjU?=
 =?us-ascii?Q?wy7H72PedvEQgXj2zqm157Uaqnm/4Ame+DTs4cQ/VUCbkqPROZhZQKcaLpSZ?=
 =?us-ascii?Q?+0fpqy4M+5ffJEU96xHeKysiNdZI3JY/8jq0BKJNSXoczwCB6Rd83PieV8iM?=
 =?us-ascii?Q?cUCXeG6qAeTVQS4dYcfIv6O8JN6udodHc0j3Q8BGCJmyNzAMpBU8LUYhW8x4?=
 =?us-ascii?Q?vKPpFtjaclZoFCh6s+BBemSKvo7mDzi5Gjp8nHiHXavchtukva+DqvaX5oR1?=
 =?us-ascii?Q?ZV7PSL5VLNyQHfEpC7bfURQbwOzqf9hFDEbPYBfQI6WR/73w6wp35dXFkaLK?=
 =?us-ascii?Q?F7On/r2fSGcGN2I9BorEm0l1MccVysDxXseMEGbK++jRRMZTjBwRissa4tYa?=
 =?us-ascii?Q?Bo+ohw7mUuhmRMfeIPQ5v+Jq+OKLJHyk0ZZRgg8Eq8N+GI6n+Bhdhitu7y3w?=
 =?us-ascii?Q?imu9KEgshvVFQVFNISmZ/XyU36dMNjou/sSkRbnpKVLvgVXqaN4RR7njSCqP?=
 =?us-ascii?Q?31TnIlWqBbv7RHLSsFZpBrN52SXfMLiYjtBlpM+8rLX1JCsIlNpEHEpl9TQB?=
 =?us-ascii?Q?rc+QdYmL8wcwWb44nbC9HYrNszD1gYYAEldzdngnPvvTNbD0e4xRnuc5Lr9G?=
 =?us-ascii?Q?8Ff2MeW5NlTANNaZIh2k3Zd8nqEd5hLgZmKgfZz4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd45b36e-fdf6-4ca2-3cdc-08dbf01dd43e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:25:11.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9RDzueqM77/t0Q2qs7GHRA8FH1EImwkCGvboozuTLUNnBQ7QL0irbGW9uOAjwbvNCA4atWDj9bs08Qzq0ST2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

In some cases, the address entry doesn't need to be freed. This patch dups
an entry into the free_list to separate removing an address from freeing
an entry, so that the refcount of address entry can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a608166af121..99ade938eef5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -312,10 +312,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
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


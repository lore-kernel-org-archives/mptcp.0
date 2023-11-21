Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB978171AF
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OEvWBBKs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/CEKCOD3g7T5k28VaeARdDf/c5FRaNGFKsPPTd4ZRjy6C+w7n5NAzPeWKJWd5BeptzlMwkLf4HxsPxm6LWzXv01nXjSWLIn/t4saUc8XZ95K+i4tA5WG5CvQxVox9CQwKXoHg9TRG7aGLJ9dPFFuK/+kEiXbSv5I0FcrjkPEOTRuKk05VJz+SVvbv3oawQGKBt6/VMwtDYkqdEO90nymyb13QBUX6uYncqNQo6Q7REFJl1YADHbH/p9kciJYAQRv9cHx0Wu2oX3xqYKXmLlWLpIXpSi+mUbvtpyOruG845ZqNVzl6Op2zXD451LFXRWaBBOHwAFIxQ/Mo0kZqZ47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=Vz0JDAhBdq67Leu+6DVzktdK3ww6xgQwxF+P7U9dvRmANnCeQMfRPWMqWohZJoGKqaOCAnHvlwEa8UFbI+uKsn+2GhyfsbkyQUa00OvPQpseJKaIt5PUooarMygMZ61SLGVQ5Aig0UwfrVsrJD7NY7WwM9gSi5aXNB8mikuFJ9BgLktrwzdvDhbca7Jql+EHIkbLlz56N67sxgfXfYsAtPXF400CzcmAtPg2cqxiWVVdvM44xntp6ADe/Y4Og0Kl9WFSHqLWgznd0Lq4/r75QiJELM3HtPc7/LudgxpXhp4p8wfhny+iM4vPDCXE6FLTq1NA+s7uU3rDs74KckFXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=OEvWBBKspFgMYN7i84/G0dy4K96FdRKhi9bMA7IkwjNPfAxepnfolrxhCc7KMMMLOWQX69D+pPuerFW2BwTE4FGnQ67+QnsIYWgL0oLTAR7b728Moj0KJZlmZCkU4bnR1OGDE/gg05FMhPopGAClafMHoJtj+LV4xtOqM8asxYXb7ygcR53kOMTSvBPdOngPXMHOckpU/EzT6HtjSd6vlSTflZR+vRWiXyeIbB0kJra/zutE4imavka4XrxiHXYT8kHnA21EQBvPZ0SUXk04hu8ThRpOFGjWKmZmMwiqkZdO2XTJ7lIWIa2v6I8NaXYfh+ijVHuQUyZZ/OS5ai6ZEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:54:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:54:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 05/28] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Tue, 21 Nov 2023 17:52:28 +0800
Message-Id: <49ca7641ccf2dce423b7f40462d0ba8f612a1658.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cf36ac-441d-4e10-2bb6-08dbea77c8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	otdWUkW5bRwoeR4P4JU+IahJyDmnCEMeuGVhBxd1idJNEbNPRi5SKulIXHr2nGnVCmeFW0MxTZRBET1HeoUn7eDKakUMRxQPfAPaYuwYEa1CU2NsyaO8DbkJAenbfu5SATfoDgacMwt20QAOSN08W7QSilSP+2NlDvO+mLjN+hCME6UYvuzSlaLW/a7WHoFHQJywDs/xBaPA0zwaouJ52DDhTqaXILj2Z+nYwljC5GFsRanOHE7Rzr4YeBwVKhCgv0kMPh0CWks0zn46HQPOk3CqHKFD0Z+TmAp0yzN+IizhS9uGnLb2J6R+Zd7uFstIfLgNSCTMoGdg6FZM1fCxYoV909zv53qcS7CRRmVHiZ4Gl7RBHteO3OBRyJEgMy5T2gEePJdxBJdJuPw3gR5mP6c2O44x8rZgcKGGxDcjRtsJNIXQjcmovAGjdkW6hvUXYbaf/Aq4wC1joNfcuALOHiDnD7BEZSo2SH+AQ1VPGSBp/bIJlCWc5BUblIjsMrx0G0saOE//cpMjLjfAhcr8+1/DC+dyGhorw5ZYy/JIvlUlMgmoWp3OtZDqjQ/leGrS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6jUvdYG0ZF6aJVpgm/xRKVBj3yoeMJWDx4iad8tzia6BlXvc3wYHrqAiZ8vN?=
 =?us-ascii?Q?npTJPQsjgl6EZy87MbTFwPTQd4VDgfZ18g98h9g2QAHevrW9rJ83+lOzrCVS?=
 =?us-ascii?Q?OgupY9VlZu64UcdC86UgMDY1u79X4fF7I6Mr1+awhI/Sl+/ZHgTQtsTDgW0s?=
 =?us-ascii?Q?TamL0kW9CfqVgfJwhlJIAfUt9hr+OcJoWN9A51h8tsX5oAXdEoxedPO2y/1J?=
 =?us-ascii?Q?yWoh1WyMLilt9jXIYjiSgjhnyjXJdeosckunixoz5a6AvmKvyShX24gp66K4?=
 =?us-ascii?Q?k7Gjmi0l/5MRP4xSQp0lfNTpTm4T/sVeGb9qL7QyTzDx+d5J2FFFOuM2vL/I?=
 =?us-ascii?Q?zoq7hd8IQdDS8hj3DVCTFK0tOfzvMELtgmCuFaeh3RAWGk/GQ0N/CjqEcr2f?=
 =?us-ascii?Q?otW3oc5ZX8LYP3kOk6xlxJoRR5vIoYS0hvvU9ti7GUNe0A3a+cHHT/Bfakws?=
 =?us-ascii?Q?ha1dl4lWUUsO4IANorBc0lj+U+ELcXZmRuQx8n0Q7diz/LlBmSqlwEd2IpVf?=
 =?us-ascii?Q?dPrEB5aMoA/NyK9OQ3V/SwAuupYrAw3wB7cbJSGA3Q0BRs4ebpDEQGqaNGyh?=
 =?us-ascii?Q?93wOHFiDoxdhs9rtte45cHk1agN19/f4Mqo5wQqQimv/YQUHp5hpCzNPaep+?=
 =?us-ascii?Q?rgdUbboavTGZpO6s8XgrQ6yR8InTiBKcUrmvFGqM/Xw3MsL7N1fxJIoz/Pd+?=
 =?us-ascii?Q?BFAqKDhbk6wMfzcCibWayIgEOsWwscGyEbaJN0U5IGbxToJyzzjmeFWu5H4X?=
 =?us-ascii?Q?dqUCS8jJjbB5/JW13aIYp2slCcH2oJqx7bCWwjBm5GXIJee+vgF6ZRn9bloC?=
 =?us-ascii?Q?3XZhZXJyAka0LvfhzN8HG/I3O8hirFLYtagEmq/hYo/+jW+irCBNIyvqtsJC?=
 =?us-ascii?Q?o6CP8macYUayQ+TZtJHoDVrYI6va5ANpThqaqHIdiJIlx/Bzb8GOX4a93R3G?=
 =?us-ascii?Q?Gi69H82kRQJKBktlLzDPoiBQKAPuZxuF8q4mufU0JwhuStLhy9n9dGDv3n2w?=
 =?us-ascii?Q?fb1najMq9mkktrTV8zZRtvZRBI7y0Dm/OhgzTZiBuYtkZEH541Zo63MzgT+K?=
 =?us-ascii?Q?08zs+yGnkirShBhhYUhVQd0p6/G91OWYKuDi6fOVa3IoXO/OkZlSa4PN4Bvd?=
 =?us-ascii?Q?x6lKbPKtB6MY9FKJXgSilkx4EI8/TyB5Dxt5vX9MCpqWiox32xYqW7txpWGC?=
 =?us-ascii?Q?VrG+/T/zFpXvWP73mqG34QalG12ZSBXEwNCbDKi2ZZmOy7Z0JjHGKHj43CFP?=
 =?us-ascii?Q?Gi14PGbrDak5Ea9+zD8nXC0qZ3X6OZzFHr+nxb4hi5dx1sKBuJ80spRTeDVE?=
 =?us-ascii?Q?IsoKSvHxeJ5yCr+AibsVeKyy+4Jqb0RSl9Gao+uD1gLr6HKXiZ0O1dWrS0Mx?=
 =?us-ascii?Q?UxQY1AlarbeNl82SkuuWHR5oi7vZSglnJhlCanSlPGnQgTRoAKLs3acUwRbS?=
 =?us-ascii?Q?1qNY6KEP3ThI/mf0mhYglm1rF3BfVoVRBeDtVMynN+8WYraXlxqpnwhDDieP?=
 =?us-ascii?Q?NuTM8eaRS1SVATexgaA/p0FcNEp4ClmVQBTF7C2IRIR5KNEHjlZoQzdmSX7p?=
 =?us-ascii?Q?coYKaSFf/9pqfG0l3p2BzmdgmNhgdNoevFM0JUy9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cf36ac-441d-4e10-2bb6-08dbea77c8f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:54:00.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4i4BJlMC+Hkueia4CubXFcjxeJgcWcjA2h2fyUCgWuSIt/2rnkAq2HVxblif5Z1Q7qNiSRbjupBo6eT51Vtk8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

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


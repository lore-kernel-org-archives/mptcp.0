Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9061FB8
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJViuvTX6mq0UKVBUae5jNm525jCKayidiEOBwrTYi3fVH1BTPa2Hx2HbwoEbS5ZeSdslV4+ANavLVwXJdxu5wDFBATRwHnCbHztDth1GWJzM1qZDx8TuyU9nE5a/p6XT1IfwiwFAvenFj6NvNLpACVTanKHJaOaGAq0KKaA/RoX32Gqrrs4b6Dq9B9zmxbKcY+THyJyYjVbXHPghrAobj4ytEUvMbUbj0vxo7lnWlYBjlWUP35ib9AG7+a+EwMKlITgMKtf6MvilOTvQxNycSY18OLBFO+pcIrExUnlcpUvuy1G6vH468V3k+HHJYu4mwsTSlfhRYOiD0l8pyNcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbyZfgZBEFSwM9YgdVyVjI7LZnwJY5FYUgrPHcsvxX8=;
 b=ELh3KnjZK5pHalvTYlXerYcg/N+c4N8SdeL/WfAZ/8LaptW6QGyOIQDFe8SvqFb2VMYDaNpzdj/xVLPxAgomyDs2oiSk8d9OkvaVfC5NtadSh2R/hs2kt34U8j1/AuB6o46i7THCQePLLQLiIs82onfMRtqGSml00fJczkb+ZZJl1ucvyBhS+IFGWFL6O/t1+Tm8vnLuzFmZH85qL3pbpwO+EFN50ZewrtI99st7nxOV0e4wq2L19HaDuQ16dmPIHbMCdHQftJY9jaEpgY/4vBFoHTKFtBcAdYdhVinGeXu+wpiV1rYv6fgDRvs7OML0GjZtBByG0tiJgX1edqvllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbyZfgZBEFSwM9YgdVyVjI7LZnwJY5FYUgrPHcsvxX8=;
 b=fEIf9Jh/STJkCJnjcZNUX1LLDJHnIwF0bNNYEgQuZCTgki+rCOpJsHzQt099GHJ8eI+kP9JbhoXoR/gRg6toQtajQnLVeFtkjonb3kQ6K5APnhjfBh7D/UIvwgHdJHO77PGdfvr99GBR0aZYpDG0v/4SPr2GtODh/F15CMll3jeYeZNAMrmD7i9FrJY1yGmZyi2EpmoqaLWrOVdjniJRYYEKw+jx9Gsvl00cnTu8CnoP9dx8V7BlfQy+vQ9J8mqbnRwHS2bk0YTfyn2ZONZR8L4GeJQmQyG8dFqAOx3XzxheZzC04a85OUmOW73fSVXC3gcxEsJDbLEQQKGfMKEudg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:07:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:07:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] mptcp: unify pm set_flags interfaces
Date: Thu, 25 May 2023 16:07:10 +0800
Message-Id: <05ba1107fa5edf988fa07856ba359d73bf51f54b.1685001897.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685001897.git.geliang.tang@suse.com>
References: <cover.1685001897.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b13018-e532-4301-d355-08db5cf7203a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3uFQRWpAZLHHECsE5ZRXlKXP2fmdT3hBTC5tRXB+yaIgpBdcYIT3R/pWAr8PgNCy/FTyXuCK7y7jFwuKpqGmD1uDLem7mAVWiTjzsfMZVCLkHkyFr8IaZXGMQiKo3vhi70HqzgrhxWQTnnnbhSvf8yNZm/fP4kfCij8ak0N5or6hDCPKy42LGyj23fU8qV90WPOkjiDjawctOoTt8pcVUEr2m8GpDqpMIRdtm1AbxpAMATfGd2683GdHZ7lPFHSO6QvEmzKhW8n0oQ+WmsHiM26RSiDW42HhhNHThr/aLpPadzNIzxRYCU+RmFpoTm2ZBFWDqtIpJQ8O+Tx8zae+/R5yJWDOg5oP0CwAY6TsaOXX5LyIV1E10xoW1fCull0T2aIs3UtP82GAcqKyUJuBbmIQWh7mcHRLSrm9Sp61eAO7bysjnuFkK2JYwBZ3UGJsrXjAORmV5SBUVMBxLJc3NfDSO1GAsKAAygYQrG8nVDzN3GhkgmLUnj+8/GLRACVA2w9w2/1ErMhZrRbZKbwjU+VnrWvmU8k1t8BIG1ZI5kBNX1pn6U6ccTQbCbih6u9F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(5660300002)(44832011)(36756003)(38100700002)(41300700001)(66476007)(66556008)(66946007)(107886003)(316002)(6916009)(83380400001)(6666004)(4326008)(6512007)(478600001)(186003)(8936002)(86362001)(6486002)(2906002)(8676002)(26005)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?voov/UTU1CUqb0uvGDC+uI6h3SAcTOgvPAoLn6dM85HEgRPUrIw9/noS1gLJ?=
 =?us-ascii?Q?zBkES7NmRaiM4FLrhxDRhViWEcliawR9FZd24Rgh3gccWKMZCk2FjsTI6Ngs?=
 =?us-ascii?Q?oqmtLmOMb3zqaRaUIhlYU0Ct60BLCYlv+9qZzdjlh4kJWyJ1VyiPgkTnX/Tr?=
 =?us-ascii?Q?vSbFWUlvno1rsHCA4fhSMdViWxXwOSGByz468regZc1UHGMVn6PbYAbfOZu8?=
 =?us-ascii?Q?ct+BogGA6GVkbcba+gG6gGH33QUOUQ/z352jyjOrqZHg5mu3DD+a+w7m5E65?=
 =?us-ascii?Q?DRkDuil+1EvmEp3z6KEomGCUZSMlB6RyuLD4Yg0KIy+Ys4dqpIR5dx9K4jN8?=
 =?us-ascii?Q?IiYd3EFHLHpvwxkj6v2lX7Zhmz+cZwLsKhQpFTtPmftHWTkfzPj+jZLtoRWe?=
 =?us-ascii?Q?a0qEpnQOOyuuzG6E+d0yelZwuf2jCDIKHpflgavlWS+AnadrIK9mhYj2VVUe?=
 =?us-ascii?Q?m0//FmHwgG2TbXcJ3VkiYN2UDtdJ5z2FtqmQ3sy8WWsJbKE5KqqRW21N4QCL?=
 =?us-ascii?Q?R6hA6lAI6BZNJR/z+/69OHAQKyFnj1dRgUlClrqXIDIqvri17s745JDRXWxT?=
 =?us-ascii?Q?2PaslNWIE9CQmxK2cmJK5CT5ToZqiAymz6V0UHVhlgkfnSo1K0GK5wqc6Jdp?=
 =?us-ascii?Q?u0TdG4hMR0WQTyAQ1Ev5hkQL3EyOazLiPyq21cfjZlzVCgxB1rdTRhWPLY59?=
 =?us-ascii?Q?d8yXBs35Tpr8Z2GwezO9hnTFIYoact5d6xE3Pdjfka1aV6SUn3T+XcapqQMd?=
 =?us-ascii?Q?qUwBzdQ1C4k27jhAg63irVREII1rrB0FWxzWy3Rac2kvVn/SJ85hyO1Pxo/O?=
 =?us-ascii?Q?xbMmkwxHOz6atoFcVclzX8H5dRS0KN7DAUnhf19/RHsEcxkMM3EPwT9o2T89?=
 =?us-ascii?Q?9FuHutSnV7881yNEsqim3kKkvrmGQ7E7g07u/zTJAnAY8uyw8cZ2f2eeENze?=
 =?us-ascii?Q?dlMYgaRj7mn+oiFmhbvOEXTWhuetorwhf4nLVDa74Q+DkdOp3HAUxysK5qs4?=
 =?us-ascii?Q?HsZb2jMn4GgFlWfCPPjU2WA0N09/QtqXR9Yb4auwWWgv9TcNokwCgMMaEVTO?=
 =?us-ascii?Q?1A9iNvQ0EAFzRahcuZxR+mx6Z3fcjTz1ahPsNlj6jLym1G8y6quRmba516wC?=
 =?us-ascii?Q?/1powtLd0Oworv+cYAcaGo0n7Bnya1oZL9n+NfE0KMXwHymgNXKUmCYeGDLa?=
 =?us-ascii?Q?IxOdhBNfO2WcmFzsaCKhIPbFbCsacBaN8AkH9qgZFi/sTGMURNF/49Qyf0ni?=
 =?us-ascii?Q?R1XZD7rLAbPNk70psHIBRqlkd1dN7ZGdemVO8YIw4cP+szY/n/zNptoa4z7O?=
 =?us-ascii?Q?kE+5+dvBZ5rugfgDaftSRaCBRcPpViRPnTo/CeUBZ8dyT46gwTUTdNjFVWdl?=
 =?us-ascii?Q?JVIDhNyWbj7P+OCl4sTpSnliovDJ7S043jicIKs3gsBbYJw8VLVhg+WXsQ34?=
 =?us-ascii?Q?U4jvkjxEVVQfTvmMyPAKTaKd0atxxnDzxaoTuoOeX5663T6TQT3ixp1ooY7n?=
 =?us-ascii?Q?R9goariTtt759VYx/xXJJ0JBlyfFsh29Um32otSBWpAJCEgiAICPR4lw8m7v?=
 =?us-ascii?Q?6LKJxB2h4vXXUIMwOsFQvgnWyh1ZO4KTJFEojHQJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b13018-e532-4301-d355-08db5cf7203a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 08:07:47.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rl4YaZ4NmvjpHpKZb0cISAkAyhZZtBVWKaqANWSV/EUXXR9AKKOlZNy9A2ale9OW0JV6EQ9CrE4hhn8MF4iZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

This patch unifies the three PM set_flags() interfaces:

mptcp_pm_nl_set_flags() in mptcp/pm_netlink.c for the in-kernel PM and
mptcp_userspace_pm_set_flags() in mptcp/pm_userspace.c for the
userspace PM.

They'll be switched in the common PM infterface mptcp_pm_set_flags() in
mptcp/pm.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  9 ++++++
 net/mptcp/pm_netlink.c | 70 +++++++++++++++++++++++-------------------
 net/mptcp/protocol.h   |  4 +++
 3 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8499196b8789..3d5f8afb7602 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -432,6 +432,15 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
+		       struct mptcp_pm_addr_entry *loc,
+		       struct mptcp_pm_addr_entry *rem, u8 bkup)
+{
+	if (token)
+		return mptcp_userspace_pm_set_flags(net, token, loc, rem, bkup);
+	return mptcp_pm_nl_set_flags(net, loc, bkup);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ab4f0483d9d8..d2e86ede5eec 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1890,18 +1890,50 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
+int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8 bkup)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
+	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
+			   MPTCP_PM_ADDR_FLAG_FULLMESH;
+	struct mptcp_pm_addr_entry *entry;
+	u8 lookup_by_id = 0;
+
+	if (addr->addr.family == AF_UNSPEC) {
+		lookup_by_id = 1;
+		if (!addr->addr.id)
+			return -EOPNOTSUPP;
+	}
+
+	spin_lock_bh(&pernet->lock);
+	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	if (!entry) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
+	if ((addr->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
+
+	changed = (addr->flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (addr->flags & mask);
+	*addr = *entry;
+	spin_unlock_bh(&pernet->lock);
+
+	mptcp_nl_set_flags(net, &addr->addr, bkup, changed);
+	return 0;
+}
+
 static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
 	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
+	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
-			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = sock_net(skb->sk);
-	u8 bkup = 0, lookup_by_id = 0;
+	u8 bkup = 0;
 	int ret;
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
@@ -1916,34 +1948,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
-	if (addr.addr.family == AF_UNSPEC) {
-		lookup_by_id = 1;
-		if (!addr.addr.id)
-			return -EOPNOTSUPP;
-	}
-
-	if (token)
-		return mptcp_userspace_pm_set_flags(net, token, &addr, &remote, bkup);
-
-	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
-	if (!entry) {
-		spin_unlock_bh(&pernet->lock);
-		return -EINVAL;
-	}
-	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
-	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		spin_unlock_bh(&pernet->lock);
-		return -EINVAL;
-	}
 
-	changed = (addr.flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
-	addr = *entry;
-	spin_unlock_bh(&pernet->lock);
-
-	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
-	return 0;
+	return mptcp_pm_set_flags(net, token, &addr, &remote, bkup);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c91c9387f42d..5bea299a8499 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -843,6 +843,10 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);
+int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
+		       struct mptcp_pm_addr_entry *loc,
+		       struct mptcp_pm_addr_entry *rem, u8 bkup);
+int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8 bkup);
 int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 				 struct mptcp_pm_addr_entry *loc,
 				 struct mptcp_pm_addr_entry *rem, u8 bkup);
-- 
2.35.3


Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881A196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e3TGp3eX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8k3dUfUPj9IAMXVMcVSo/q2pQqvffv5mlEJ4qqdGB8A9YaIO0wnVB5vPpRW5PmV2GrxXbQ9DOuoDQ/ifmbOacxAPWSn5syTqNDKuDcvZZjpthsU+BUAVgUeAdHJZ2SC2AzMSD+ovoQKOcqx56zhjUWN6J8EQTMZ3dbZRmnz2/FKsnuylhcW3k/ZpWvSYD1a3XRPFyyLIphfL/PZJbBRwg28sjje2EcCoZcMmEzfkdizPG1wZqjqmVZqCuPVSvfz8mkF+IDBVxXtTpakyFY+Dqsv7nJaeHbAf8fUIlK/h30JAM9UCOuY3ydEXhBvkzC7EG52FQGyG2jfTp1hqdLWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKXnnJzrR08/qMp8QKkbY67C96F8zeiYUOah2aR3Un8=;
 b=iS/vZ6ehhOc9Sve6XUhZrqsozAieiCYAtBzMCpanlgeslLcXFWQTVDxw4k6RyEhGYTl9qHRltf2Vzsfrhuvzl4HzYUzAbCnlGsARhltPr29W4qOmWjevNs8ZsKnWJOAl+8zS9g2hm3SgW/Yqr5wjX529WoKlbiYscxTmXVy6fFGMxhJznanY6nPb9dxT2TATr+Dq78KXI+9AM3T8nsR+ZEut8OsvtKgbrRRre6/e02Eh0tG6b3q9pCSzZww+KHMg3g95qCKxAKiAbmVtyhqikNcwRC93mpsBADKaO8YShwDD57X4UMsqoVjZnGSVfK/A1vP1EF1T/DFOoEHVwJUUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKXnnJzrR08/qMp8QKkbY67C96F8zeiYUOah2aR3Un8=;
 b=e3TGp3eXH1QS6ZbduqAlcgrCTEafkgwWBIYG3/ehf9n629ryKkRxJSEsWDY3pcy7IWVPKXIeXXVcVwKuH00VDgQgYBEMQD8M5uUJGfUb5udkZHKfqLl76K86qMryhMJSQamkHKg37idxt8KDlEY062rxTmdqf75Xv6p+KB6B1aGyixyD0ZOvwueSbC3JrhAAWtzjRaoXdgQKIJbXizkU50gn7/7/JnLQZQCMnhYG/zZBLtTkBXH84YZv3RdwzE+mWuQVN3dOxnmm1ltqtNvAy7ZtK6Ctka0vBg3LY+PX2pD9huI6OnK95vgD0Fkw9t8pGox3QKwOCPhuSS2y1Qhnvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:26:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:26:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 02/12] mptcp: lookup_addr_by_id helper in userspace pm
Date: Sat,  4 Nov 2023 08:26:13 +0800
Message-Id: <2e0955e26232b50bdd16243fe442d70801c59f7e.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a22024-25f6-445b-1c54-08dbdcccc121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eUg7OsPBX1V59M3lEjEmW2nj4IZ1Dz8GXOKTc4s/oKbygeqyLDLaTnQLvOBnHJNYuKiHc33xt+Df3us7TT7URZDN8wLGQ/jA/tmHaewXrB9N/Hd4qpZcmM0p586LKjrYJ5ShikZepEHofpYaKC2sh9Io4cnK27/ctB1H9gtm3Mvw8BxeLPpSMXBbf2usaTddvVNtOZFl5ZRrzhvoZxm8tWF7ho7Aaiibyc9IRGDHSkzwU2cd0vDbXfvOP08D8w/+S89dNtWFn8TkKSsGiTUoBFE1DS5I23QGY40jO9JQn9Gp4WYVFbO8qWmD3Sq8cw56PYEBB9sbDYHxy2MSm8HFTXOvSXy3vcX5jd46Noo5uT9yCwuBBu4WlylRcjc8h2qnBbXLmOROncc89+QqFIiwQYQES2NwDvlZuLGxSSXnPCc2KO1bRpS/CzWWh2RZX1OkQA4g5VQFcggn3jBKQFJTb/J5Azaztme9pNpA/LJNnb3vftNr+looQgXtX5pD8PSJjM97lSt58ionbxYHDeF7jlhTGFNmh06aYrWiTKduglaQJxaWhgW51LCmsl99Ce12zJugqI9IFm0EWlDei2Jau53lKxaiVI6lFKpy/xue0C0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJyh/yxOwzVmxMd8K5gg5zk+dPni/kemJChwwZKLizXNkcgmZdlSvil2WdZp?=
 =?us-ascii?Q?8Ip0g7+LTWm/3k4flWPcj8YmxKBDNNFnm//Mhauo0lkr3TKgZ6NVVQKlN01J?=
 =?us-ascii?Q?hcrfDUZlla4GaCodxhxYVRIZSVVFQVlPTlnjRIeYW9DWEsm5eje+WEEzLbDs?=
 =?us-ascii?Q?f16WM3SjBISPC+7FSEyZ7gBOFC77ZSYSBgvHRH01OFmuzzGtsD++gyg+rb5o?=
 =?us-ascii?Q?JuUYVaCnAowp0dgmoct3Isc/Ov+HMc97og4qKJ7DDF04tmapnxMkyZa5i0ZG?=
 =?us-ascii?Q?vCpw4sMIFfLhx0BO0GRtW7K6HXQVAyZQKzwXyL6bHfL/27nuBudQB2B3ZIHs?=
 =?us-ascii?Q?FVZ7vnh+FQys5fEk8VtzYMhvwfrxyMUXCPwC5qWloP2Rx9+ICX9WlmgwlHXE?=
 =?us-ascii?Q?8wruKUPvK1OF7qC+Y70C3vgRnG93cQQdZQ1T9HSRYjnByArb5zn5YpGPETXk?=
 =?us-ascii?Q?x0EEpgx0wJMJTzKWdtvSHhA0l1CY9ARxm/j0uCcZ7+ku4FQS36LPz+MkW/ZW?=
 =?us-ascii?Q?x2ilQ4t0srezqDr/D8y34aRzuHVVyYW1y+j6biKq01pIeFd01UN5AbLicdAw?=
 =?us-ascii?Q?C1yPRX6qSqYfjQTlDqQhCijZJTRJSiNVgwBl6/SepBrPjbTffmUwOUhNiH8T?=
 =?us-ascii?Q?5ZZeJWX/XlQYwq4q6S89PZ/7uz4/WHErJWe8JzQiGkCdAyn68LkjKN/X4ESO?=
 =?us-ascii?Q?xWJwlLcxfbN4atm8jfXGbr4gCjKtLP7ZAf0wF+4ULlizFZC2MREfTRGJomr3?=
 =?us-ascii?Q?C+gU8FQ9uZ9vOry/Wqa5DnhHUVe+VTY6nu+BHrXqpxx2SDjW3hjG5a4k/RST?=
 =?us-ascii?Q?tu8MoTqzGHKQrFKHIsup5R6elnEfq5By0oKOoAof1X0gmx300i/XCJ9MSzYD?=
 =?us-ascii?Q?EA4qpZCq0hY7hqDJAf4beCCQ+0NtumlwoUvf1mQ0EFawuhqTs43kBeuuuUX/?=
 =?us-ascii?Q?6pmGmHakyy6nid+JLCIk9XXo80Ik1Ub+mivBLXxYqifzsGcxxRSuqt3/QuS6?=
 =?us-ascii?Q?X0RL7FeG+fzClB97xpKPXLZz2GNxtbAQId90ZeDLKXXScdygglHBdy1m9ZNc?=
 =?us-ascii?Q?yD42xbG89DZQmb8AePsWx2/pIGRnKhgNXWnU8qmkwyHTuwl7wgMobJlIcZwK?=
 =?us-ascii?Q?vdxZQ/WCS2fnZsyva2JXd9zOefxQclKeHtgPCDpfr76+b5CP0yOXqIxugioG?=
 =?us-ascii?Q?kmNPepCRvcK0x9+PBPZNFt9xYvheGpysylLrPwe2OQfq1BBJQYUZLTgFnbqt?=
 =?us-ascii?Q?+rsm2U7YATyWNMAaZt5M0oH5yaHi/re7aE1swzPlSQ85OrUeH2U9Arj9tSEM?=
 =?us-ascii?Q?/elAfioQHxBNtYvgdYqJ2Nhb8+WXcyIqvrAwJmFjUFfYVkM1Ipo5K5LFUZy9?=
 =?us-ascii?Q?LzKmIgDi//21eRVnp2Pu2lA8GkE4PdAI2GGwGgoEq0biMNsFf1kmcAcfJ9pK?=
 =?us-ascii?Q?w1zQ5kA9P/vGoe/EqaLxVGFHY/8hLssb88zLMoktNIvidotRlqwPlLBEO6av?=
 =?us-ascii?Q?eFuHmsQbFnQugvmqmZR6UYLcbWIPBx+Nn+ymzqH8GixHbCTJy+L75wVMTjZZ?=
 =?us-ascii?Q?T/qv7gA4uMCDMSsth0+y+DjYQhquNixhjYgwAbM6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a22024-25f6-445b-1c54-08dbdcccc121
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:26:57.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09F2HNwcSBkS2UMzBUMctsPT2gcU5FhrIbD3z+lWSNwOA0M110CH0j4e6/nDTNcg13h22CzeRWLHr8zw2ED1ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

Corresponding __lookup_addr_by_id() function in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 69733a1a5663..b5687578e6ac 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,6 +25,18 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
 								struct mptcp_addr_info *addr,
 								bool use_port)
@@ -122,15 +134,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -262,7 +269,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -299,13 +306,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.35.3


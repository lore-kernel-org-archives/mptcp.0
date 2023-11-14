Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068572F29
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="esXVVKbw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCbqJwVtK91eZnyZUB0RhM380R8Fyj+hmpL8JqrN6z3zIRFSodN6XO1Ijv75AAimmnCxbm6gR243AvFeXX3Fqzug4RX8ssfThq0kw40ov9SKVE74rKBIXHuuQ14fz4iuwif/tuySGgpMbfBWNyoESLzRPAgS8JSpz0cnLmwbdoU3KCyGU6sl4t/+RzCe6fqu1wVlgNy8yqJusHJHtJ657dAzHtr0I9dEqSNxCsrPH/r5VvB9xLhM+WCxQzV81QTjpJ5JeNP8GOPrzc5MKqsFHL70t39PdZqa6pZsD5AssiGcO8U6c6kv1uCmdaotQdDD3gtvCjiaiSQW//uQ7StyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=XquyygDZ5CZW1GwCBjgJz/LWH7SKv0+HukQe8kSncNhRD6JRaRyA3vaRDYEWyvuSbRdZexb/MM4lXp8dAj87zwSUhHudxolgY5Xs6dtiLt8lUhOE1EVI5B7qwvek+W01uB3nheE7eMi/C3v/iNDvrn9wd34cOnaTIT1lqH8dqq0Vl1RrFHz+bFy+LmkzHJh5L2+oxpFqo3YqYn7kDnB7whf/jmGVTUhylHIGG5Vi4d//5WKusYIF6i9Ig2JCsIpQyGEUC3i84LSzZAEdCp8PqzWpR/syrKEt11U40BFMjLC+bH/gyhRkOScKkHlDT7Z+Dzq2JnCIU0IsOCdaUFl02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=esXVVKbwIIe9pBz8e2KKWGInCc3ueqocxIP2MktMOgYx2zNMXyRx0/VmvPRiYXYf7kaIoQvMcWvgExSv6KqMIbaHhQxt5iJKvTNsrnhKej1v2MGqKp5CLd/uDNhAtj+dSviOsHh1d7hPue7lfTfMC5ULlEAA8G3HtPFzCCiixj7ecMtQ+n1WG9TOwxbOPbWrG7tL/uiHk2syRrd3rPKWD7Kx/92HmUj2cAYJqfxkeZ/VUbVQqkHv/Ad47ACGAB7zdlwjO0sgLkU2yGNzEaNhBQxRl9F4386nUF7fAcLVQmv/8B1T+nFoq6V+xrJURDs/x241nDdL9gZDafVpIyugRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:36:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:36:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 04/21] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Tue, 14 Nov 2023 14:35:01 +0800
Message-Id: <7d75f273737622b3eb201af32869e5b2b0b07463.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d403cd-dc82-4d07-cfad-08dbe4dbfa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F2+rNE/N/pqsB7+Clb8kotGvQuAU9qAFZXvxroIzAVUglFvkZKgFNpIiMYI4M7RHbDuhM34fwW6alhM0T6isXmt12f5vJOUPQ82otATvDSX2IX7/ayoUmG7g4DIBVjdzTIrik2Jjdg+tsAGQjwbY2FssAM9mIUbm4USAeaRxFs4Vlr/QNpDnjk+l+nrFWWuA8jj9p+wzFhe1P2bViORoRnVQpN3sJxubVV8PDNb+n+AL6DM7TffPKJihyR7JvjLfX2/CfGwRHft6LgJ5t+pD0aePYujLxW+N2BQTGbG4sbIm2EfqbFWrt1yYA+dpoGgFv+ZR9GUknj4NnEG5tu2xpXy1o6bD7IK78P8HZ2qnCr7wGvZWG2I1K9SixdeuT6iqM2K9m73WqRbesXoArqdYReAmffC0JBMHgAwj0UE9yjyzwQhXkpOKRdeIWeZNGC0kn/a/FBN+mra+2pNJVVfiwfR1wJk/ep2TftfAc64f/QMyYt3Gdo7KoCpEiMiAtAWlb9G0BYz289ht7X17CDK3ViBDx1FlaDNlYde8ANjHFbNtQmx9yXKMtDpPth2lX8Ew
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SS1aPfeHby22D27jtBHm0kqx0mR11M5NCyOJ5/LsKOiqjMl4o3MdTaN2xO4r?=
 =?us-ascii?Q?RD5hSYKqHJG/ELZGF4ACtg+XLCyZwSXG6O4CM8xU+enAmobVZ41kTwf7TTnq?=
 =?us-ascii?Q?bj4TCMDv+74NmoyZDryAV9U2oBn7Ku4Y2RtGLcp3PJEY73h02IQUtr6idlVH?=
 =?us-ascii?Q?2aDrQfIlVinMamUMES1cHatSgHwdvhFP74tCSmb3W5OHZkwxXJ4MLpFxtq+e?=
 =?us-ascii?Q?ub4b0p0lzGrM0aVYp2XFR/vCu6XwCtPEEsw45Mv2N0lLfLT3gGXHSLM0Af71?=
 =?us-ascii?Q?dX8qZGEZmCElEyivycYo7XkjTTVRlvC/nORJj527NtuBXW2k8d+9uKjP3G7e?=
 =?us-ascii?Q?wnAcJINCIrv7QGgtB8b7sTA8+HK0wlbGNGM7ShuHcoBLqVXdmjAqfRa6YQ+X?=
 =?us-ascii?Q?QM813zvh5KTcD+P+uwkc+vLe1gp+o3U1s3j3x13lb17ZoFDNtQ40/XMWXKca?=
 =?us-ascii?Q?Sv+k02iK+WdNL4DkYz0zIySyOqBjlebXS75f0SaMZtL9ZX1emIqG6jq7DSAa?=
 =?us-ascii?Q?3gDdZz/YSkdVP19J2O/uNTssL8i/zhKdQM4QGWlG2jYTLAVcoUlYArZgQcE0?=
 =?us-ascii?Q?9fZXn4m+yRXsvIgBhHo0pTnNdywoRFC0d+ywrcH91d15+N6451p/Ve/KWih6?=
 =?us-ascii?Q?55Pvr8Dx9ts1ioE2tbGc1+vHyqZJnEkMzQmb2FeKEmJQU78z9DHQ7E/YJDai?=
 =?us-ascii?Q?tzCr4KAypuoBxeZZ19S+16WB5PdePqFnzRMwhplSNQNVxN2I0kSibkydXFUd?=
 =?us-ascii?Q?iheDwlP8BKFPC/QQQKogabPXpGF3JsWZIbvp1JKsE81UbchNuY2MZwSNyFtw?=
 =?us-ascii?Q?IW67KDulEf6zGnUUOuuIScYfH9UyZhHVX1n4QVF6Cf9MnQ3bv3/5MLvnUS0r?=
 =?us-ascii?Q?Pt8GmRXAILUVsBKhj0eZxRWSGEcc3w1wIywKwSq+rK60AzCY8N5znTqC5gpH?=
 =?us-ascii?Q?oeoEwJiNByf8Ub/gD8qR817Y6rBqle+t9r5iEjD4Fm5XIOCKRePJMXoj3I96?=
 =?us-ascii?Q?3VUN8YXWkqNbQ+OhgvSOAbp18twCQXEQJ0ujvUGad53+o9pnRo5MApL/P6fe?=
 =?us-ascii?Q?7tfviTqmTvwn3iNpbRbkKZZttcbUnxrr8xQVzOM1Bex4gRV1nrM8/cZ0MC6r?=
 =?us-ascii?Q?shDhX9+t7dW+dn/ymNTRnaBifUxt3qnRVfF4XymytNPAgJ9NecO38ceSqLkB?=
 =?us-ascii?Q?Sh43IO9HPMvck/uMCul4Ig1Z34d+qQojJ/4QO4/0wJBjiwsKtsBRFUOPirbT?=
 =?us-ascii?Q?mbvxfWifAmh5LFkJxqbhBGdbLq0DJA9Qnchexwe/NmqEHh+oZ+3Esju6I+tj?=
 =?us-ascii?Q?H9f0kp/g9ne+j9wpoEeIqcOb/xL6GYP8JtIzFY7ddiZRQ0bSGtIZSdst29cS?=
 =?us-ascii?Q?9ETsyWt7RQ49FgL6vQMbykAIXct7Phw8UHXJP58uTXZ76ANzKWNl/Yt7D7eJ?=
 =?us-ascii?Q?a+5+9jjMqBy0tmSxsxy1PAf26PKre7Ql720tCElDQvc7r8gtWSUBhMOl4vjV?=
 =?us-ascii?Q?Z8C5TcaX0Kwu+85VkUqBUWK63HbBKUoxLMvJcwdBWoLIpFUPtuzQykF4Brp/?=
 =?us-ascii?Q?wzSPmDBINBZLLqOnwevdLWHQumxeiQBkn8/OsAAq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d403cd-dc82-4d07-cfad-08dbe4dbfa67
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:36:05.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qiDS3HKYbGDxiituDTs6EpNPpVb3WRx1UKbI/oq3hoN7UWi5Y62zssM8oSwfflQu0mk/ilvBfQqSm6pnxuHhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b3a606a5e182..6999296cd5db 100644
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
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -107,15 +119,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
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
@@ -247,7 +254,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -284,13 +291,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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


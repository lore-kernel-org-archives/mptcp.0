Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57E17C9
	for <mptcp@lists.linux.dev>; Fri, 26 May 2023 02:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjJWbqPGbDCktTk4Bc4HNwTe/IXq/qLO0ulz33SskLylSusR1x02mHJmjkYi1t3t5H4Uq8+AxgCH13Wpk53+/DXzubrHnG0eb0t8OByrumls4JyOZoYlEMY6Rm6DljDjun4nhvnMr37pITVAUpagfKHnxfLQpcESeeCdrjbQWyL1jNbeU4mK880DHOvdhJGUav4yp/tnYaeaOagLfJ5M8Gla0rrEqF0LshE+MuXXnxy7QfO8dm/ApPjKfJbEqpBPebffddNNU8DgLbUXV9hFs66Nraq+Du242Pg0j9nGbaEhFzk6D/tqW77hwNYjT4tKpDf4SVusxRAAZl0QKi4yLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7snnTHibG53UnYuz7VlUyA1HK34nRLpP8DDHfWNUBM=;
 b=L/B0vktn8L7nRyORfqmMKBscytTOIwI4wVjN44JxHsWNrLr8ml3830VvO7c3MzhQAZKiD/s+i8Ue/heaJ4+99fQ9shjiRJc004UY+hmp3u0nRd6pGRmO17YHOHXBomUg4iSpxQ3khmD6LHILm8ngP8ifrsw/520Tap3F3DVph0a7YRl70Fk6KMRpP7j0jv0PHcjfEieJXAKMk7tPfRCVR5Cp0o9C+MZYACHReRVCtiBSNdFjOHCZ+Qucz0LurlRLgXzmXBTelA+Y32mi6b9YDbi8V9XygWMjKNUq3TOXTAcrpY/5ACmjBIN0nF4Aai2W7IzkhYQSeCyXQIbXfN3/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7snnTHibG53UnYuz7VlUyA1HK34nRLpP8DDHfWNUBM=;
 b=YUPxbH6ktYXm9eQO6oq0Vl4jxX2AUpCSdHIVfcE1kYoW9dJCp+7mv+g2Z/9OTpzw4bgs54xpTluCrk1fKrSXVH8J3ZkNXIO+5k22yiPuGeVfNpo2DWjF/OkR8NtRiWcmCclipsiCXaQUUO0v4aDqgeM19sTaPdG2Pbhuz+WL8/x5o+LM3mUWynq4I1wFh7EOMN4DPRZCz8IW7/dxkV2yK0KcjvXtDgr8WC6OMq+v+lLpImF7Nmbw/UlK7ydgx+kxm6i81CrjPzSk4zm4U1RV+p9ker+qNnCxMNWzNkDXGeBffleIzvMReKM9eQLHKF+Rx+2QgHdTeV4Ou2SM7hVrTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7466.eurprd04.prod.outlook.com (2603:10a6:102:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 02:16:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 02:16:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/4] mptcp: unify pm get_flags_and_ifindex_by_id
Date: Fri, 26 May 2023 10:16:10 +0800
Message-Id: <dc365eef75bb09284fab322d740b1e982ffb4ebc.1685067241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685067241.git.geliang.tang@suse.com>
References: <cover.1685067241.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e2fde8-e36e-4772-0125-08db5d8f47f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ye78OKvKNP0YJtTiQxyOSUPgkK9IrGolrwmgiJs0q0Q7DaSL8Lse3QPNf00Ubt+fI/h0VQsS1cakYa6JPT1JhxeYFQ+OYsSJIMhSj0vOTMG44Hf1q1R2IsYx/cf6jlu2b21HbS4Sg1jXVJYZk+5640fwlbgjlb+sr+aRHGdNf+WoOXqTZetXKxAE4L14b/aR8JKIxw5NKzFZBakYHgLRYV50tS/t6wrWELPRhM7PDYA/RN0yi7AMqzMAp7mtexCMesreZ7i0NpLdBoDX2YO9g7psFHyOpnA/qauy0Jiln0iMo/0dkA1Tv6dRLg72u0IQbKVOvpnazQYQ5jhVipDIxTqRRijjZBgc/QTZjEi3P6tABTLpJaOSXi47rObp/qZSD1tT4fxMqLbRnw3zecCtfY5jmDH4zMwYli9EK3VupdavFJn02DE4oYjuO1oC0ntrVv5bt/vJ2qhALDCCbUe+crjBZYZxpNvgmWq8Ni6C/pGcPJFUzMB5nJznDFjSbOQFRkkR78vUJ5yi4xm7nTOq5Q/ZCIdEDn4dEWHkHYXCVaB6Ei9ccpHvBT9sDSavyG8S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(2616005)(4326008)(6916009)(5660300002)(8936002)(36756003)(86362001)(38100700002)(2906002)(83380400001)(8676002)(44832011)(316002)(41300700001)(6666004)(478600001)(6506007)(6486002)(186003)(66946007)(66476007)(66556008)(107886003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBDjx3yUbS+GTGq0TkK9Kzsro+08UsjY46/Bon1V8E8IgJCDk5hW50A3Xhvx?=
 =?us-ascii?Q?GxyPISGlgheilWk3vWHNR5YkRr8K5M0ybM1P71VrZ/OS9MuloVoVLg7zRh2H?=
 =?us-ascii?Q?jcIu9tgAY6beITVBSkn6DfainuI3y4NpuMg4ac6WjLGT1PKoQYWiQBWirKk6?=
 =?us-ascii?Q?dkAkYC4qMPCpPhgcSuYKnddfiZtfpPNRxRangiX2yVSuBItjOgolGaTz15n6?=
 =?us-ascii?Q?ywRTdgCdH9TYpcnA7rqmmiQ/qesoUNRKoRe92B9cdseyJ8Ot5oXT9YHVR2q9?=
 =?us-ascii?Q?bso6dxzDjPvRbwKa2swJqzO45Br7PfE1ug9A9kGxsHaKgJPymDJZqGI8sHj0?=
 =?us-ascii?Q?an4CNY0TjffBJOsxbPlOp/VfYo8YM9rgnq/ebb7960ffUz8ssfY+6epGOtdT?=
 =?us-ascii?Q?3XsnPcWsOpKnlcg3RJHiJwkPtirPj8auvAKAnaJ8uNuknfTbjdLAfYzI5ozd?=
 =?us-ascii?Q?cEQAQQOzXN8gfdNhXc6fNZIYr69E0w8OLOJnjmE3inF7d26EXLJZxDQ6LHOF?=
 =?us-ascii?Q?tx1nG8lWrk1qlpB4zIZhKQinwMh3S/plNs8zvjNN1GE0V7FyGyFSI3kaUwAo?=
 =?us-ascii?Q?cAw9srcXl9Ag+FHHibqtNrXLfM2ArdHsiqCOdr/xR9T4+daKSuPaK+YvKtTF?=
 =?us-ascii?Q?GilLmsOhOfA03tPsNOypLZlt7ZalErepuZE5yCMx2uuLdHjjaMyPmD7dpiDE?=
 =?us-ascii?Q?Xh8CtzleHT2h3oVMUdUM2uUyuUVBql2in3E1DtWQ0zJuWsGlMvYf5TJjwHUg?=
 =?us-ascii?Q?EPn8IuYTknqHki60RFfFYl3mkPXwTFuHLSxcl8HLFu4kVXA7bhUZp3RNs09E?=
 =?us-ascii?Q?jzb2r2UnWRczxhy8WF1G+wkBzTI1VlSUhCxWq3sVj0t/QNjt55uLhi+aoyE1?=
 =?us-ascii?Q?60s700CbZxdWnMispoynfha/UX4qfN/VFzjSxh4jDwDTE2wbUnDMLrqLgO2H?=
 =?us-ascii?Q?znAB88I17FDi4fSTguPXmvYOABkTsJdohTi78ITUa3Jwc6yezOX4cS2quEd/?=
 =?us-ascii?Q?306cSzb0LvUs5r6SiHJ/ja8yJC4fTwfOLIiessz5DP2Os8kZdeE6kWkvNtTc?=
 =?us-ascii?Q?ebi81MBXoJZA6Uqazy+SpnNQwfiJFRzYWoG3aBUUDfTPxCS6PGfRv4ib3nJd?=
 =?us-ascii?Q?3f49kXkV3LITJkPKC+F0dzjnnSXHGpUroEEjpi6MW8XqKhAFxQ6ZjTDra0AU?=
 =?us-ascii?Q?XGlcRuR55dmLqizb8AogBoOzYWj+ztHYzHvrUdB6k1UTZ36tJpmjaAovV0Ad?=
 =?us-ascii?Q?m28dHhpD8mQmpJ2HHw+m5alxfBtKdM9xOEc+MKZvc3JhJDoqyLs1NRkMvm+C?=
 =?us-ascii?Q?xuEEsEgxohaWtcyThR08Jte0dK458LXTvlZ/2Lxn33bTqetR1VfWuoQANhOk?=
 =?us-ascii?Q?gkMrjJ+0o3/TR9E0x5zWoJ+qFZvkAXoozOEHJJEitDofX3KviCRBCS2XKX2m?=
 =?us-ascii?Q?hfQbJTNNkt9W2VxHtsj+2V3Y4oSMrYTLKNlJNSfcDBfZxGdDXKFb7ZCEA1gv?=
 =?us-ascii?Q?wFyqfDYgVPb+QgpRO3iKv44p+2BbOabOtCQP0kloo30xTpiPeXtHge5aXygZ?=
 =?us-ascii?Q?gDb+hcYziGnZlpjDnwyON0m6EOkBZoVWdHlVJ+1E?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e2fde8-e36e-4772-0125-08db5d8f47f8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 02:16:57.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPseIEZ+iTa/7birFQoexhqnneoEno0qIAZqVroZqHqL2afHDDcaiAIwfzcbGXWMJ4jEjZcBoxtwAZjnt6M14A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7466

This patch unifies the three PM get_flags_and_ifindex_by_id() interfaces:

mptcp_pm_nl_get_flags_and_ifindex_by_id() in mptcp/pm_netlink.c for the
in-kernel PM and mptcp_userspace_pm_get_flags_and_ifindex_by_id() in
mptcp/pm_userspace.c for the userspace PM.

They'll be switched in the common PM infterface
mptcp_pm_get_flags_and_ifindex_by_id() in mptcp/pm.c based on whether
mptcp_pm_is_userspace() or not.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           | 14 ++++++++++++++
 net/mptcp/pm_netlink.c   | 27 ++++++++-------------------
 net/mptcp/pm_userspace.c |  3 ---
 net/mptcp/protocol.h     |  2 ++
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f8c23d6a0d3f..74b81d5ca4ce 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -427,6 +427,20 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
 }
 
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
+					 u8 *flags, int *ifindex)
+{
+	*flags = 0;
+	*ifindex = 0;
+
+	if (!id)
+		return 0;
+
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
+	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1bb8e7e9c54f..a77029648f36 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1353,31 +1353,20 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-					 u8 *flags, int *ifindex)
+int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
+					    u8 *flags, int *ifindex)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 
-	*flags = 0;
-	*ifindex = 0;
-
-	if (id) {
-		if (mptcp_pm_is_userspace(msk))
-			return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk,
-									      id,
-									      flags,
-									      ifindex);
-
-		rcu_read_lock();
-		entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
-		if (entry) {
-			*flags = entry->flags;
-			*ifindex = entry->ifindex;
-		}
-		rcu_read_unlock();
+	rcu_read_lock();
+	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
+	if (entry) {
+		*flags = entry->flags;
+		*ifindex = entry->ifindex;
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b06aa58dfcf2..47a883a16c11 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -111,9 +111,6 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_addr_entry *entry, *match = NULL;
 
-	*flags = 0;
-	*ifindex = 0;
-
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (id == entry->addr.id) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1eb555094a7f..5bba863c5167 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -838,6 +838,8 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
+int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
+					    u8 *flags, int *ifindex);
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);
-- 
2.35.3


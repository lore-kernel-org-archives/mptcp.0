Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF7320F
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TdQRsMq8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+qhupuHKKrG3vSyDW5Lu/5Ze54ETuHXXJJGBsnKKmX8olmslWarkcHbrECg8fVVqqCtjw3+vvgfMbO86TfTAYDzJ+UcxtI06CqWnPA1age3wHAiTydQIyrLzOk2u9adVUaK+1rkusrpzJN+4klIxeHeQ6BmzGYwzOrJX7k9SUPgndSN8n757RRDp+6Ki3m/sGSpt/TUdHtzUC/4BSfwGVsPJ3sv5G/U54BVk36SJAp+xZwd2nISQhTtGIrRxYN3hdQ7gcrDBxeh0n9BnM9znka9hEMjnA6mC3De/EoNfU/k+ylpyVPkCZWqftq0cg9a6y2I4Dp3ChWpiprezorN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eur/i4I+u/zCOSJZDwVRFa9Fs0wVE/IxjUU6DKAI3RE=;
 b=FK1wmj9a0aeF+AD5BafpZTaz0qmldp/C9zZ2OcT0FTT8bFmsGYgg0Rlr73i90MUwfb0VjvRZnQ5l8OmYgh4qpVaYkC4jBD888M9ZjadO7buLKNFRZSP4OzYiQ90XTyGZnYEcYjwHyzQOkzuqoZc0WOl/BbDFpu99U7qd7FHfwwoigIbNiz74E7HdLQT6nr6Ja7NXcEh7t0ABJkvDBHgBE/lr016om/GM1i+ijIMnI15GL6N+aMVwHSL7h3dMf7q0aLlQf6tYPaBBQYbsQBtwEYD7dryC+0dhZlh3X7vcyjbVdDzaZZpzEVlAE1SbHuofdynrKe5glDSP2qYnvg+v3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eur/i4I+u/zCOSJZDwVRFa9Fs0wVE/IxjUU6DKAI3RE=;
 b=TdQRsMq8LRi3lZJdbHltTsiQydKe+IS653p9IgcK1cAc2rI1PwqSsqsFdLn90i8rxUR1xzWfCA8tUsftZ5FpOm0uC/LD6gBN/8t9a+1OkXBl0kPoYsF/a5MsU9OhyPLm2KXNaQ4gEFd3iNmQilqt8iSatICzqOAKm36BglAWvn6iAngS8s2LSHOaWDsVjVWWtTM8eHwoTLWqbMGNQ60lblrC0bTfuIsEDfhNelegwshb8KuCCG0Qs+T2tP44FLGH8N0GybMYnpl17Bon+VVdTX4ynag1uFYkKMmJOY9hmmLWzgii8lsChKYDpqdUDqoWHSbMgtJ07GPNfsfLD6kNnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:51:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 14/22] mptcp: add use_id parameter for addresses_equal
Date: Wed,  8 Nov 2023 14:49:44 +0800
Message-Id: <2e82b15587bd3c74c1f694bc3e75beb4954f83a8.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a10a051-79c4-4f26-8c65-08dbe0271be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h0I+ePPnJ5VXLts9jWdsuD5d5P9ydJl9mZ9spaGdgAX8WzouhcUCjLRKedsDc8QeiGTW/BdQwKPNgwCoN82yj4aruUGy0nsUNnhRbniWNvrCriedjq+S0UH9oVN28QXA5XCVa0IAvtD6tWIUwCTCz46XQB/RgStBi/KtMVDsRshOetM+h563dk8ER40+ZNlP2kvLbM8F7bLLzpro7jcNFNj1a/ta4sfu0aV75d0oyqQ97Sk4BVl2bn06OsW2xiVdj95bMPL76xLf1E5TM1ozK2ZBf9Wf0eiTqYYM5hfwSbKcR483S9EmlXn98TImZ64HFsrDdF6kmTAjf0xO4jdpx/kLdOT+QBqz2FXdPTG2ECRn1FxWn+ueOEt9GO1xmPaFoZAcXwrCnrfgK4QWeDBQRgAz9bTt4eg3/vAHvPlQk4+aqp42Kcj9IFmBtsUhunv4T0mW8vjhfQP1He/79sokKyIxUOlc5TG0Pu7PCvgm6JbUmSelEfg917vIKu06lW1Z++sRdzeNP1MfoTEW8FcEVndSPDntVMQhGKbii9r9a7W1INEWiKA6ZDY47RtAnIyzy2y/lzHySpX9oZ/EFUz6OEymNBcKOaQX5eSWKQMgmEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSG9JNbelia896UMgEIhYu1mrwD6039q0paL+Pb+cLMuoKWMhKy0VS13cj8V?=
 =?us-ascii?Q?UYqj0nGGmxOXdJc0Uu0NIlVE2R6jfbO0yegTuTCDtdKmRk0gCXIUvkgZSKfQ?=
 =?us-ascii?Q?uJOtJ4CA32li6V9yOcajsDy7Ow+wQrDJUiCvszW9sN+kc4WnHNt/VBJRR717?=
 =?us-ascii?Q?NjLd/rOc9ZNtBdFZfsbrVBxJJmKmyontmkU/YuA5PNrpr+o3x3u0T2fU3Ewb?=
 =?us-ascii?Q?dapUOtFa78Roljjq0/wz5bdkdGyuUbY1K0F0d9MLXhqxTnN3VCVHNl46pg2j?=
 =?us-ascii?Q?u6esZ12TRobWc6lwMbD6tt3SJtC8Q4LYqdcncX2AR3IWFnUx7huWthIYrnfl?=
 =?us-ascii?Q?Rs6MdCtlb8pnh34c3OR1cs3xq8IAj87E4qHEQWb9VTCJbQqcyV+ecFvHtl6M?=
 =?us-ascii?Q?g0J3wC7/qE4CxPHkBqxYVrz+L6bIou4iS+M+4n4/5i0ib9Yhhg1FNPLW+Yx2?=
 =?us-ascii?Q?K6yxS1tqWAeJ8GWiWZXoVVCiB44m0nwd1N6Nx51vKKwlWrfpWZoF7MaszJZ4?=
 =?us-ascii?Q?azJNNR4imLEpS4iIRzEYWU/jjaEU30RirrSQfKtv4Oat6wCZKwyuq9B85hBS?=
 =?us-ascii?Q?9Qgr5Vb/jdojpjBPgP5eAGdDYYjxdyEhFjar+J11dxsUs2/V/CTqyMOu1HK5?=
 =?us-ascii?Q?Loftv/8LNGS8bXzczZOxcfLLZ5NwLZinsGxmMu1cZbfgdA1XUuO4yebrDty8?=
 =?us-ascii?Q?E9u2BhjrQRCPG9U4vX1+ZrJxeczgOE5NjD65NXxgloc/83vHmw5ZYqiLde/h?=
 =?us-ascii?Q?vtxS8JyG20ZCGRP1cS66H7pyY6I7oNVJIZqY32r4NJhI+uOfzWIEWRxwlqK4?=
 =?us-ascii?Q?oza0f8IAlbBCfoqHoSiuClJzKB1JKi+N1YJWDMrRlksxelWnt+HtrcIRfpWY?=
 =?us-ascii?Q?cA/E1ibzMtyJ1h1zORVnbErfNAXqtiRk3Jkg7oWnuomdjiGPOnMGeuyBWPnP?=
 =?us-ascii?Q?C74yQ5bt7bzwRhEd2zEhYss91a7oTIFwF3seY4AYAzinKPYx4RX5qAVfwaCh?=
 =?us-ascii?Q?p7mgqfKbmq1hT5T6u3Ws7gdtY9l9pEmHbMjIIOOCuVPSujOrsxT2wpIctFv4?=
 =?us-ascii?Q?mqZVjNKkCNZt1bJH0SU4l35RlnXqEUF9DywWkrY0N6MCKWitqL0+g28L2h6u?=
 =?us-ascii?Q?+/iAikgAwv9t+Rtv3U27PtfbEjEESmUxWGDIlIyY9fRRAIYFwF7kD4hOHi0a?=
 =?us-ascii?Q?rGJlKymu0Kekdi+NlEq5HKfou7i3EdQBGcnNhtO9sne7RVSP3i0VJb7m3adA?=
 =?us-ascii?Q?OaTZDO4WctpW/auPX1FcmuGV3PD03g6uX4kEsbIrGdMk7A/iVIcrpTHZjziD?=
 =?us-ascii?Q?7l0b15sbiXpF/x0XXK4D5DZJ8+XfhDr8wh91i7rcxmiipawh2Em/mvSdXLNv?=
 =?us-ascii?Q?lV3+9Er3ER66LwVd6y4mi2yIWxgwD2YP2j8Q0gUmYNwqK6OcTLpU09Cfusla?=
 =?us-ascii?Q?9VGSHq0D4xXJ8Sw3AbgJBO7A1MDX2yS3/7ZYRp++zF2Z75SyQhbT3BScgxpY?=
 =?us-ascii?Q?oXjwvAlMvgwTJ5lTrOchBo5isN73dJG+foB/BrzNO0KfAcM5jK5xr3NrEnd7?=
 =?us-ascii?Q?XA5pApFrlji+T+9B9KXYR6+Wa1aCkH/hZuYh9+iG/tHrEKWloi6ELpf1/BG9?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a10a051-79c4-4f26-8c65-08dbe0271be5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:18.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xlJ34vjZcoVILKZqyYswB3M5ouUFmJ3mf1LNWQbXSKlYwTGGBQB2I7T1lZxY98OeCAQTrnen0prO6eSTMXVdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

Similar to addresses_equal() helper, this patch adds a new helper
mptcp_addresses_identically_equal() to test if the two given
addresses have both the same address and the same address id.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           |  2 +-
 net/mptcp/pm_netlink.c   | 32 +++++++++++++++++++-------------
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     |  3 ++-
 4 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 48ff7ce20890..77a0e859076c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -420,7 +420,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	 */
 	mptcp_local_address((struct sock_common *)msk, &msk_local);
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
-	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
+	if (mptcp_addresses_equal(&msk_local, &skc_local, false, false))
 		return 0;
 
 	if (mptcp_pm_is_userspace(msk))
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b7e4c8d21078..599137001148 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -47,7 +47,8 @@ pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 EXPORT_SYMBOL_GPL(pm_nl_get_pernet_from_msk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port)
+			   const struct mptcp_addr_info *b,
+			   bool use_port, bool use_id)
 {
 	bool addr_equals = false;
 
@@ -68,10 +69,14 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 
 	if (!addr_equals)
 		return false;
-	if (!use_port)
+	if (!use_port && !use_id)
 		return true;
 
-	return a->port == b->port;
+	if (use_port && use_id)
+		return (a->port == b->port) && (a->id == b->id);
+	if (use_port)
+		return a->port == b->port;
+	return a->id == b->id;
 }
 
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
@@ -110,7 +115,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		mptcp_local_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
+		if (mptcp_addresses_equal(&cur, saddr, saddr->port, false))
 			return true;
 	}
 
@@ -128,7 +133,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		remote_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
+		if (mptcp_addresses_equal(&cur, daddr, daddr->port, false))
 			return true;
 	}
 
@@ -205,7 +210,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
 			return entry;
 	}
 
@@ -222,7 +227,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
+		if (mptcp_addresses_equal(&entry->addr, &saddr, true, false)) {
 			ret = true;
 			goto out;
 		}
@@ -463,7 +468,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port, false))
 			return entry;
 	}
 	return NULL;
@@ -704,12 +709,12 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct mptcp_addr_info local, remote;
 
 		mptcp_local_address((struct sock_common *)ssk, &local);
-		if (!mptcp_addresses_equal(&local, addr, addr->port))
+		if (!mptcp_addresses_equal(&local, addr, addr->port, false))
 			continue;
 
 		if (rem && rem->family != AF_UNSPEC) {
 			remote_address((struct sock_common *)ssk, &remote);
-			if (!mptcp_addresses_equal(&remote, rem, rem->port))
+			if (!mptcp_addresses_equal(&remote, rem, rem->port, false))
 				continue;
 		}
 
@@ -883,7 +888,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		entry->addr.port = 0;
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
-					  cur->addr.port || entry->addr.port)) {
+					  cur->addr.port || entry->addr.port,
+					  false)) {
 			/* allow replacing the exiting endpoint only if such
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
@@ -1021,7 +1027,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port, false)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -1397,7 +1403,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
-		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
+		if (!mptcp_addresses_equal(&msk_local, addr, addr->port, false))
 			goto next;
 
 		lock_sock(sk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index abcdc95e7bde..58e9ba51ad36 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -52,7 +52,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
 		if (addr_match && entry->addr.id == 0)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
@@ -103,7 +103,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry, *tmp;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 089fbebd21d3..e66b1fb7b522 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -645,7 +645,8 @@ void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port);
+			   const struct mptcp_addr_info *b,
+			   bool use_port, bool use_id);
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
-- 
2.35.3


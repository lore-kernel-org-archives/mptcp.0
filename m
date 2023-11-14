Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC2612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EEZyS5VQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMgxADULnmwAH/aZ2GXvQjG44JKOk1cSRYlFKfl9uFlEoMUVzCR8ukx/azCEgchvO8aKMS4EAI30mc91DjCH6xL1vYpZVn3xoEHBftw37w3rV4t4eJEk9SNmyCNS8EV+i5o1i6N/DNq2mAHntIGTwrcAgljqCYcTYpWE921L3q25HHZ56zkdxlZHeIcAIq6NslWwhdb605S9zzxRf4QKDGDwvKmy1pKO5D+jJyxriX5u0V2ez3YpTyY9uyb6c4Lr+aeg2wOHk7BM3HGY6fTGaJuf2yqpf0shq/IONc5X4MKPTLTugG+rUV18ii8H5e2A8PsiaqYeJvXRU0UwRgnHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sry4ClfUQYAHqy70Fa5D4BueLaP1MOK9geOxGarhCVs=;
 b=Sz5lrPsYHFG1QaF3eqgCl70TT1Aqo7yrwzMhGaj3SUtA4s0mhUs8NUFhgXTUwvjsWvhkYJUTvnmgS4esA1Rl9vDa13u5PdBT9oHnTmNuHmOmcsDyGAs92xyyEbBq87hS1DKfgltUHwvKzWXC+IrjiEo7TcD8A2V2Ou2cA8P3wSzUITAIEhQArQipGPifO6IJ7HXVS0y6/28XqGGRfcSxhXjEv8fcWoeyje/NlkPWG73ntBG/LmScUAtXnzwadkAZfJBxRc1pYuSHyh9gpAehYhAeyScbSF+7REoysHHHvKiY8Bebu0ADGIk2LZPCYwL5yKDD3X2rHIPyy9QimiCEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sry4ClfUQYAHqy70Fa5D4BueLaP1MOK9geOxGarhCVs=;
 b=EEZyS5VQaiIigHJumF+56UHqd1QqbAZUd1/uTWqV+EP7igcWNXUjweQvFH/1MebJnAwiG++RcVTPvZesMv0ouO/nxsqfnihp86tOxRuWb2xEouHZepy1e5IMjOjD4VfXenmE/33ReFoHTT8LZKe83MiegvdX4qVFwandyCoHZLGEe/EvOLX21kmndPZ8bPgNxHfNC0QWoexN+/O1chnDUPST8EX5uIh+W9zJnhfvJImJfzIghaBLGANUULCK9nbtMg8zvQa5Dq7QWrm2OWINjexVU1LpBfw80AYg9X1Xs0b06sTXWe1GKoDGos+sqOhIw/WRX87gbLGhJjeH/R7Pnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:37:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 15/21] mptcp: add use_id parameter for addresses_equal
Date: Tue, 14 Nov 2023 14:35:12 +0800
Message-Id: <19cbfab89516e16625cc4929c05609ae51030066.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fd733a-fcb8-437f-0317-08dbe4dc23ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6CngGOlOzwg0TykZtt7ZBWb0luaymEDhIWkFTiTgHOUU/zIqh01Ng80UObwP+t/dwLBClfBdBk5YkggduExkDX4Cq/bXAC/+4kfGlZfRLtYL/T/9uEDCxwlbdQDwzfuoHM930FBuFaeoKdcb3FbmSmgR21BhCDpMKXiRCXYxjsmZ0Ex8b5J86dWGUbCo2KKkDg6Wh7oxM1Aq4110lJ6Ks/dox/BSEeoGyJhCURsVYAvM0ARpv0qlHjG9ZH8P/xW1OhzXinppEUwevRSREMHuA1wIbNWLmUoi0IkcCpQru5QTgZSdVLNpoWGXICf4Wub5I0ultWsj10IUBKMIF7OpsWHZbeBtwoSvthy3UJ5Xzvro1FhYwpDGs33ufytJiALo9Vigmkuv0bzEI3vP1zOjK9ddbaOT9bZ+8sYGlkAEFU3rEEwKAI4p8P3mOo0URPTmGtxoL13Ak+ykB4o2I4sKlhyVKv5v+CcKPGauOLbShcaewrFaecqlaYBPkG635/BZ1sIRDc9EWOsZ4wEiB97+sRmoqqhvSz1XYCCWU89vC6bxvM+goNy9l4XJTDjArWe/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tJtLMGT8t8ODym2xBqlV4qUp3I08ji6QL7MKLNmYnsAGR5m3psWqX6JOWBpB?=
 =?us-ascii?Q?JhZb5epDThs8xE0gslkZoZn6W7Q2/wSchnaMjCScXdKdc2ag0Dr82/A5/EWv?=
 =?us-ascii?Q?WqoOBh9rniWkqm20XOzLdWqy2RIOfAv6nDf6hp+TTxJTRFNOtGtb+E9D+f0E?=
 =?us-ascii?Q?o2ikVg78wTYsRFhuxAWienzH95dXeZFrGGSSEq3Kbccff46GOl8PFsccdPAQ?=
 =?us-ascii?Q?KG67rDpeJhk3PyqIi12qJacJ/PnMQy0rfvR9WcfmXLPdngkHQ0hmLOCnQMQI?=
 =?us-ascii?Q?9HxwrU42KhWr8hLcIbgAWUAC2vV+0V+4/+lyBOm4C1+Ei8e/VTi/zgPWm46Q?=
 =?us-ascii?Q?IaAbnWkXPY5fBb6V3V+66oVOE6x7RVnO9W4jkDZ1KA2zsdvx6zZSpBEfAimJ?=
 =?us-ascii?Q?8xfcjOH9YeR2qKQkQIKTdz35LMNbMrQSznMuQNXmJuxt3sGP2W9oyV5qapSn?=
 =?us-ascii?Q?JpAHLYUugS3hkdn7YJcWS1RoFuZL5bjJKfYu5z1UoM7/oz4wZXZgG2QY0c6z?=
 =?us-ascii?Q?8pUi35ltr2XS6W10aq9hoDReU1u+fAekJPRBgHCpSsH1N6F27pRSRJrc5Q6i?=
 =?us-ascii?Q?kFykAOFzUvXyWAmOvme6NPZLK9DA8HTwzVJhjuywUqBpHEM9P+aUNEVhLdMJ?=
 =?us-ascii?Q?gRyB1hJ0/iomkp/bWk35AzwIHNKNLInPOiW93t8pq7c6OUrsaY5kqmeQZNUW?=
 =?us-ascii?Q?7A3/QM1lLYmu8WoZ23+ct1PAkM6pP7zsgMYZdIhvMtA9TmVTgk8bd/8eK0SZ?=
 =?us-ascii?Q?Bh68sQmQeMtWD5NwGMv2im68fxQo4hSMXuKZl5GT53PTCm8hiiedGVpoc8iI?=
 =?us-ascii?Q?DQR0tK2bR4xKVDvm0xz0adyo7c3gpevPqvUIvXPNhMtKK+FpfjNQQ5veFfRW?=
 =?us-ascii?Q?e/HvPSMc20Mf5ea8RCMS820HiGpdo6FFmHewABSiuKHGZr4uWK+kgz42wE9s?=
 =?us-ascii?Q?hNXsJcUub3NT4wMIbuvxbvXSiAmfrdZLca21vYUHRmRt7ffPZAGk4sQKvJLn?=
 =?us-ascii?Q?PkpyfDrQLReIIChwZwaYlN9FdauPQQMSZWU2X4OqNXx3P4BHgYtlkHPaIg6n?=
 =?us-ascii?Q?xgbWG/WXZoK1imSDWSGK+K27p7EKTspF6gu3ldqaNvhK89diJ8N+e1hH3G28?=
 =?us-ascii?Q?OBIJQPFzRW4YLGDly1k2qqSaDLmt58d04CvT8Zy7DRX+C5Yo7+tVmnqpzcJg?=
 =?us-ascii?Q?giiW/HPmbMM8mLpGPsCjs3IUFn4zmUpNBbeiZfSqYry0/NLvWrD8LvU2RAfo?=
 =?us-ascii?Q?ayTKP0IffuoNq6+r9YVGZtI23Ei86cgZqJIlSB4vJbKFEpWXqw+WVQbgvCVb?=
 =?us-ascii?Q?rtVo/CR+6VUu2PzEQlpG63MhBnARaXk1CYYrKqk7pSgMwBZBnSoPA68Oy3Ad?=
 =?us-ascii?Q?Rr8qhQT69oXNEZynOa03vEO+qlYmHxpFxL9HWowTTZGK6y6zvbYr7PzK+Hor?=
 =?us-ascii?Q?25DWeC8kki+aRbCtBQNZAc3yNf9vB+AomjWOzM35u99fKeKzKyXRrYWOmNGI?=
 =?us-ascii?Q?1G62kokFS4wDD2EVWPadx3A6vXIJ2lzTujHSidqqiQdLCcyVqOOyA74Xi3rk?=
 =?us-ascii?Q?ZyYgbi5VAKH03gzbbfJPT5wubEaB5xiZB6gR1P+IoF6QRcKKfKBOTwIMY22C?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fd733a-fcb8-437f-0317-08dbe4dc23ac
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:14.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WUlv5C2Mp6T424tBEWRVYc37LfjqOuxOQcWPEvkZkrtXF4pKx8do1lJV/s9ZRhDSXn6kfhQmHWNkuhHov+Arg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

This patch adds a new parameter use_id for mptcp_addresses_equal() to
test the address ids, as well as the address. This can be used to test
if the two given addresses are identically equal, they have both the
same address and the same address id.

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


Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FC584FB
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GAuIDd1C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9oK9Oon8VmDG+wYRccYvgmOmjHEdRCRMHPN1IVAHmJ5rExgYdfySgQ18Cusfx7+nITd95lHFJJJ/DD8p+u0htSMK04BubTQVA8Rszpz31qzadG/wxqexwn9d8F6T0OcUaNZUakuFrdPd6+31fK9/JEZpBRPvUbplIvIdNlx66yK0Y/VejbaxYYgXdEHbLpighfGsfRs2Vf7gJ7MCkvS9L/3kqpDa6/yqiE0sGGoAaR2KnS8tQ4LhZ1C18YyOc55Sylmisy7RTxleBB1gIjOZVEXeq85OPdgLk6UjTuamBTYFLXi0y+iKGs38ln/T+/L2hDk4mO70VopNXl0gXXyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pniVddLH6ts6xok3y2xfxjPsHWnK8WegizqVMsEvsI=;
 b=YrrR7JSgmYJ2YBqGFVTTLCCeqsfa+SZdeRnBZ4a7qhmSGY7TAhgP4SzxXWR4hSS18hWvgmicShPkfwNkEzK9jpUgDgzLDU3n90mtICqOAjLo4tUB3RiCSDOxYmrIE2Q4uPcINXrB3ZenrFU/TW2zLdH9/OjC3bHsneMi6/Lb+FrXPLAZXvGcCzY/I9aThNw9eC+3SmECka/9iwn+/P8p99X2az+5uNsQwNel+qiiH/HZjWstDWGPIboPw0xCbwmpeLtdgoqPj0ZC2qMQ3heK/RHrSabJ8+Z9dY6WIK55FbYU1RKbBsFSg0tRtkNvdTlBjeUsW2RKswOgEE06OyZr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pniVddLH6ts6xok3y2xfxjPsHWnK8WegizqVMsEvsI=;
 b=GAuIDd1C2zRJb/WDy12GDrsh1TGPqwCe0/jS8PoWKPetqVAJFVSWhB3hO7xnYeyFzAGRKvS63EAB35KcIGyfumc21FqwmZJxkUsGlTwPGIDAmzqhJjxKwGojfjnn4ma4ILJUPOXpfTNJeV4SwIrKRaQHrDucCX2WcEEeXx1C76LINLMRHhOvAfZZ1ynlXFHh9MA10C8DXl1Mf5DK4XV56iSlfiih+jr+2UwzaePnhs2fC4BgZXe19MCRSVy48HB+EYoCwyosQnuaWgW2DKa+gIdFeWPqXwYMLwheCc1IXvQhbNpMzQZ5NPUW0Ktxi1DBwwvYTRp5QWA797bj+IxtUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:24:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:24:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 24/32] mptcp: add use_id parameter for addresses_equal
Date: Tue, 28 Nov 2023 22:22:17 +0800
Message-Id: <e8e55285a0ee98b0afd34ed9a510985d97056b82.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c02f5fd-7dc4-4a5b-8818-08dbf01dc57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aHQN135lEO7FtLCges5ksCPawGUJ/6WtvD0XJUTGVQ9CDTMZyrru4baeK9V+jMvvVIWLqU/rVGyBL/rOJUP/rOGZQANS1BBSyRqkEzftrNypUyPlbozPrqa/OjfIti9zgUOK7I7AU4gTGP/CmgD6D8kqAbpoMIm2bx4dx/fGBNEiLMwv5XIkFI+sPPRR0GIEkffDCazrDqKyKWXgddTTNU35pZ9VseGRO7OgF4BBbun1KKwld9ukvZYgA8C7uuz0jUB+4ryWF0BUyUkqqfSbKiF6HxuCel7PBANEQVdHjX6x7C4NQBZ85KkFaoZX3vpL6Av4/BNsJy39o4wUcYSOFaUVGxxiUd5wKVkmlZxSrVHW+IJLmf73UAGzn2y77o7C4jX67pS8lCt+x9+35f2kgJWcFx5vbEZWYEigSKRs5UxCHB+Z50rH/sV1pSOVC6sRL4lpbYKRdltdHJ7uw77gl3xefS+pFSb4YCAH+B7Y1727+RwCI2o95FcAJfc9yJQuRlB8LP/70tCsQza5jfKVNAmeYZuZZJFS+IldgQw2w6NIATSCkBLus5yfTHx6X0bm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?666EpNEBMvJ1oQAFqm/dstg0QNfknr36BS9AVhnOPEAIpBkJmz0a5qY6a6x+?=
 =?us-ascii?Q?0IZTGai0GWzUAwMDrnTXKoCsPAdtx7IPEg1tsFhPyLnkgLxPxNFFD01Zsp46?=
 =?us-ascii?Q?2zOlZTtLY68xbAQelCJq4BiZR5vjHEQST+SxB6cwivV4WSrRIuGHWbMqR5HW?=
 =?us-ascii?Q?hI4TQ6Up5fS/oVPYCHa9eZDxQywa8hc/0KCYwfNnon8eUUUvbUBBZLnneo9k?=
 =?us-ascii?Q?9mpKNYnOxJxQYPHVc7ENhnZla3oJzuR68BPz2wqOlTzbpoX58ilmyO/LWehC?=
 =?us-ascii?Q?R3a3D4DYOrUCZcLL7ntruE5LO0hU6C1ciJNALCrTeIQ/8Mz64VnZADMuc5y+?=
 =?us-ascii?Q?clZARgmsCDSkt+W9Vu7Fakz3bFMNgAey1tQEPL3IRT0iiD0J/Z1zc2MJlX+/?=
 =?us-ascii?Q?4TZxq2hpRBxg4wXAEtcrDVdketXbwb62B9b9qsnrgLKE9uqvrdKLlKoa/4PE?=
 =?us-ascii?Q?34GXnS27jhnX8REduVWzv3HZPr1XyGXGRWR6ml9eYgI4EMzVDnKc7OcYhdvn?=
 =?us-ascii?Q?B2t5yLZl+9Cq9291OYmKIMtMLEoD1ZBdHD/ZXnPG5ex/KB3chfyeFCzI0joz?=
 =?us-ascii?Q?caCl2T8Zxjx5OyHLptFDOFDiGAx7hukrLO3/B+BSSR1hsTMiqA7elSwbj7AL?=
 =?us-ascii?Q?f02G530Z4BWhhFPYe7QDV9jNycOu4Uqce2MORue+eTAnJH2GzQSM0wNS+ox2?=
 =?us-ascii?Q?b7giMs2CRLtuuFFFwGOrY21TW3iWZEfGi4Lu7/0UAYPZGarrOvlut8zucaPi?=
 =?us-ascii?Q?Rdo/xXgzZbKrBCLgPnR9psg8WHt9NulPwkvh1Vsp5twnZS9em6Lk8tkcGN5Z?=
 =?us-ascii?Q?Ifyp5SIseeRc5knxswaYJFvGutVuPCN5SGwMep16NRbAp+V09A//KP9Vr6F4?=
 =?us-ascii?Q?rt3PQrf1qOJVZbz4Oe8RvzwH2DyRihCnSd0l0iuuFjrlsfsyEwnN6WELKYv2?=
 =?us-ascii?Q?eRdr2Lapb4ZpePgoshY7fODs7PJofKRy9CtzvBlJd56CSLUenmDCJZPnQudY?=
 =?us-ascii?Q?CmWBEzQlG3CzTCv5KTuJemJkohtehOJGgvj20NmxzPO/zvkoF/Ab+RfyTb+v?=
 =?us-ascii?Q?uDCtAC06nChM7xE6sWfllgl+nr+CicYeL/TgcsWaQon5CoKTcA6+yg8Q38JG?=
 =?us-ascii?Q?wasnLOCIFNGCWU0Xk2Uy8CL78ToMvAjNVWRn7OY3a0WpI7x7f2RrY1zoV7bB?=
 =?us-ascii?Q?zuluwFtYJrytFzYPiDk6kLpH+eOIDWfgutLBFq1PMFjhykKKCxM6GrhCa2//?=
 =?us-ascii?Q?OK2z4sYP47dLt5FCTPyxURTaw+3RFZLbtdusqafv5VfR7RqsFvy5ITRgF0Vp?=
 =?us-ascii?Q?Q8vwrJuk9u2vbPT0wZXOD6YMYZPufBACmJWIetPkQcm5suCANhCYQ81Cn9Jk?=
 =?us-ascii?Q?+Uh9k+do/AAGnbwMCNDsfI2OUumV9ZBpgmKK587W9rYp54+CDLxwZRflJh0p?=
 =?us-ascii?Q?fS01NYI9aj9Jbay03RP/bUOG91bz3wawlp/c+0ti7JVgXQZ0TDma0FCT4PRW?=
 =?us-ascii?Q?VmcyC/cgo2UJ6Zs9UpMjtFrTtqgvcynZSB4wLPm5osFDF7nkWWUcPL9zyDTG?=
 =?us-ascii?Q?+QvGohMifS2D/x7BEs4uvaFwsQ34LOgt7z+vZYuZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c02f5fd-7dc4-4a5b-8818-08dbf01dc57c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:24:46.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tFydtgc8Txbt+nbUGqpNU1DRuo2eWHojZQZRBRcBrxGlOhuSf6uWo52GD2SyWasOtcWT21+oTq6gLZyk1WU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

This patch adds a new parameter use_id for mptcp_addresses_equal() to
test the address ids, as well as the address. This can be used to test
if the two given addresses are identically equal, they have both the
same address and the same address id.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           |  2 +-
 net/mptcp/pm_netlink.c   | 32 +++++++++++++++++++-------------
 net/mptcp/pm_userspace.c |  6 +++---
 net/mptcp/protocol.h     |  3 ++-
 4 files changed, 25 insertions(+), 18 deletions(-)

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
index 6bc1a6b5b4f0..6ad8bb2f32e9 100644
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
 
@@ -884,7 +889,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		entry->addr.port = 0;
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
-					  cur->addr.port || entry->addr.port)) {
+					  cur->addr.port || entry->addr.port,
+					  false)) {
 			/* allow replacing the exiting endpoint only if such
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
@@ -1022,7 +1028,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port, false)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -1404,7 +1410,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
-		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
+		if (!mptcp_addresses_equal(&msk_local, addr, addr->port, false))
 			goto next;
 
 		lock_sock(sk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8494d6df866a..06fe6c65b4f9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -54,7 +54,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
 		if (addr_match && entry->addr.id == 0 && !set_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
@@ -105,7 +105,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry, *tmp;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
@@ -145,7 +145,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+		if (mptcp_addresses_equal(&e->addr, skc, false, false)) {
 			entry = e;
 			break;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7441e3b9443d..d132a8d91d10 100644
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


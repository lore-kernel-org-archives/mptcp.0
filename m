Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9811FD28E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DIlxekmB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfzBJW8w2X9/IoR1GyUAlYkLuFdJATo4mJ5RCzm9Rj6ZhhT1m7Fs1aYbTX+AOoBPXjo8r/9ajZFoQPn+SXytST5pC3KpbicNg/WfKrCxPSDaz4UUMYlKO6gUZ6DAKt1Z4e7GzIT8lNrz0YK3teZZ6bFlZLAiEvMJSLaVAT+piKPiXRdb++H1LOZK78q6/I6yH9M9DufQneH1Ca6+/V8sgH2ccgOgCGwwT+F02gvZKs1zmgShXQdLKfcq0AayrbjDzbwSOCrVS8fUPLi0rjLFCqatpBvpblhQ4ZPvn8bVDkszMkuvZsXEb39ZA6bvlgxS45qc/qfbK+h49crPaSe4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNze+fgrggI1w2WWOg46gAtgltvA3IZiwMCDLH7IA2s=;
 b=Z1qI7mwuBxm5nQOTZYg3trIYkR0INhic38Ilg7/xSaJzdD5QyWnqTLm6UwlXNXfBeEFrsPpCHeZiXWShSemgIxA0i9ZQJfX4o9jTy0C4NUUyjxKkYm9oJD1FAZ39K0NY7x7lD5QPkgteeDptF0kEFaTZZavK6N8l8D5bzlVt7vzbnTFeqUTDrhuCIlscTZTv13FuHBoxidR+eYIg6AGsketc35zMqAZ2UqeF4LoS/O4gIGJiLoHOb+5BDNWUjoChdoKPy+2wuX50XV5qBV+dvWEkoPiODTDXiFOKV2x/hRNy5TpgDM3EysQBBkEqfTRs6LnLFBf0Gv9lfoNrLKWSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNze+fgrggI1w2WWOg46gAtgltvA3IZiwMCDLH7IA2s=;
 b=DIlxekmBO9lJysoE2SmZIthtp5ztNq6A7y2xP0TdtILaX33Z8gBvdPZjX7soW+kCzHBu4HFkWscaxZVzdZK/OrQ8gthLKn8LaCwtrhmKiCU+17byPJbUSxs9ysvZ2kc46afXPYQUju6eckhcSjeP1T0x2QvAsiTjh5UIidCC//1auf3Rg/5ODo2Cn8nC3+boQ5xI08So61ljpCqTJExEcgoqMuMcQAkHxPwT0FyW+MW4gGA7X8TFY6aZf3uGAaicDH/StCNFafINgs76Iaee7qYH0qi8ZqSVE7b0aEb89EGeMWeh/zZMPC+j3qMyM9WxkOyKF2KveYPLF1rNKylScQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:58:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:58:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 20/26] mptcp: add use_id parameter for addresses_equal
Date: Fri, 17 Nov 2023 16:56:13 +0800
Message-Id: <b304125f419adc4333dccddb0c765c60d45770f7.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd4a159-4a4f-4abb-ef06-08dbe74b5acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oxWoPlXABN7GCRcj8j+p4J4hiAPRJvKJBLTZuHJQJgbKDHOETlzCimjN/ssrtW3FBRM8vbdRQccoXDaGhi0raRDtLkD0acd9G10R33gxgUmJN1zLiuKwUtsD0Jvx9Gb7zw6xsIJFqEQVSjp+QOiVPZJlWkFpS4uz71eLzvLSCjUP/qlTd1vSJnbVd8KhqiFTg7iRUaENFspZ0BoQX6qxom49+q9TAZ3I1C0wQuzfzF0va61nhIHt9z2Xasbv0BxjqGqpsESeruAnhFABIOYegCX+5hXZhG+UEhBDdd+OaO90OrVikpAxtck/XE7PQPY3fPZ5Va32RCxDFhxWLkwKRHrJ3PFcdMAoKBt7Rd3W0MiMwJKmIT99nlU5DmuTzBLnpBZDc1H3W5ZWAvzAem2612girSiq15OdLR/SmOfAr8jVZCuNItvAPF59jvcNsMypr9sQbwa/S6RMlsepI0/vWcMcW/95jWqTp2osAq/XRQ7mD941ZWZslK6aRwNeYkFreMsdBu6Bji/cfKHt8X5ehrL56GonUxpmmn6/Y597NIVNewdlZUIGj3gheyAODLDw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtOcjA/ejvIrD1ZUVFww0WsTeABD4DgU1/1GzX2QqbmzoYMSY83e+F7suohL?=
 =?us-ascii?Q?214M4oNPOPL+cleyKt5VZWol/Apobs5QLodYo9r9DJSp4f+UWDky77tHhPoG?=
 =?us-ascii?Q?TtAkLEChXUt+bT2vk2nddiQMhaFx4TDzTBQhOK+dbXVn8RULm4W4Agkh0fbq?=
 =?us-ascii?Q?StJZRVU+BQndmkbmYj0PfAtdsIWL9+BuyJMkgbRMX/fyv8aw/T1Qji/MzE3L?=
 =?us-ascii?Q?kkuAZpeBVbkbUy+/C5t95LIqeGw/ZeeDXxdTgmSmKOpYvDHav1p4t5piCNxW?=
 =?us-ascii?Q?w/kGdE47UCjLmeDONMkEoo+cHkPBH0YYHSnBLe9WndJnCFRWIegP1ZQmWVJ4?=
 =?us-ascii?Q?jW8lq6uH2poDIcnvref+Sm++YjnyIRvOsbekbPlTFFrdlW+XfC208wsa4zTq?=
 =?us-ascii?Q?VKkdk5bH3BDVQa0OF1TcyRHCrslGdGDkwjAZZ8HioXngSOMzjiN9JrVxG8+x?=
 =?us-ascii?Q?uPBV0+UduaSf6TNcaH/tXDxmkLIH3h1r6nmjk/DShWuyZDI0UWnaPlzZsSZq?=
 =?us-ascii?Q?u8Y4UQLno8eaMvkESMMNNRmj5SrOIo6Yy4sEUPe7RLueQ1hdprixxjN2qLu4?=
 =?us-ascii?Q?ny2/6BL7rQlB+bLev617jhyt8TLKsjbTBVbXc0YxdTmqdvkwcz1vniAHZVNT?=
 =?us-ascii?Q?uRVFJ/fYHgPPYoOrqoddckWFQzV2NPPKOeiCK6rjFvK0DkaqK5MeY2ZNBl+D?=
 =?us-ascii?Q?TwYFYhDrdYSehr/PH5jT13TF94AFSmZK4RLaI5EoJJAcqFO5LfzHIvc+ZEUD?=
 =?us-ascii?Q?YSL1b4Oxge5GeHXAfb/kP8Zk9pr9H+yJIAJJ39EKInVw1PWmsPYIr5So1YSC?=
 =?us-ascii?Q?F69npyMlCSPWMrSVcMdomMClZLN6CEPpH7B1N94vEBgUygNi1Qpem+m2Hg8l?=
 =?us-ascii?Q?yfqGl60zONvgLah4NgKOKjCtBfiOBveIZzYsFnKrNoTysTaIPmCOFhwVNodx?=
 =?us-ascii?Q?I9DN60s/JFgo5Q7xcQ7EILoA4CHnGoVi8r1KPNwoZXrf8G7VSv9mvW5yjlyT?=
 =?us-ascii?Q?IqCgwC+8zYHGwz952H+xA21vIIHqMelIUoz1cqrQLdjBcARtMLWVnlGVgJVo?=
 =?us-ascii?Q?5RfwTr8M94hdttAhSJkGlUCfR3zsnQMfBx5L39Ex+Kk051ken/Stfa9xJRDi?=
 =?us-ascii?Q?W7rL2rsbY+mgmiuv73+YSh5GmMCezD3hgBfRxj6Zedb/nKIQr4lPCMZWNGX9?=
 =?us-ascii?Q?QiXb8MD9IDiRhWF6D5a120DrFH1TSGeCUc00q3nc4rG8lwBVYtAF23mN7fBw?=
 =?us-ascii?Q?vQ8uNesIHrXT7RxgFVn6QIdns/YTm/ooYf2pDMnpklaq8LjkMjzqe8ZM67TW?=
 =?us-ascii?Q?dM0IeKBLDPHhU0Z0kWnFGOUggIwkOCfVs0w6OHjZL+7sQK1wDQAgvaXxGtEn?=
 =?us-ascii?Q?CdTERlbrHIxD2DC3K47IeEi6/2FJLiasuOG6xVR1SZVfEgFToAdrwgYNiW7t?=
 =?us-ascii?Q?w1p0dib0pOqburiZ25uITYDaaJ+zrMVcSnIEbzbB0zczoU9Ur2BOYSG4I3gN?=
 =?us-ascii?Q?AAdCp21CiMh/vI22+8PujpDnghsDuH98zq7unmCZYxt9/LXj433Fr1/bWJsn?=
 =?us-ascii?Q?yydw4/JWZi04B43uHzV1sNgj+lXYTGDyKUleNcVW6QITYAfeF00WgwCiPu8H?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd4a159-4a4f-4abb-ef06-08dbe74b5acc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:58:23.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCSh5DiPIt9iPyXh496ZEb+QQXZZVxnuJjIo2j2gM8v5Nj1TkDIJ7ovN7z9rM9Yd0xTuZqsnmP4zL9iudshD2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

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
index e571d6cb3a4c..d82e9456a772 100644
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
index aef8cf3d208c..9eb6c447f18f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -53,7 +53,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
 		if (addr_match && entry->addr.id == 0 && !set_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
@@ -104,7 +104,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry, *tmp;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
@@ -144,7 +144,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+		if (mptcp_addresses_equal(&e->addr, skc, false, false)) {
 			entry = e;
 			break;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 139332f48a66..4a004eea9c38 100644
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


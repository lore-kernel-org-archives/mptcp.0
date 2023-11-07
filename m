Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976BB2595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P5TxP4hh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aABigJI96dh5ppYJdhZ4Y+kA5BRD9j53rI656S2ZpqgBRIGptjBItg46ypZ0F/EjpspAr0NizUT39StGo6EKnqqhI9f7pEcgNhMwoJmM1cDTpnGvMMZvmo6IF71I4/4IuIpC0PkEZYJDgLMoKmf+94qk9879xFxOFLsin3t0935ht4FAMErSefLCVeh2ThMw7esg1WHvD6L8CRdpeiJCepLzXF0Ma06Ug1AvDCG6BfNdSBInNSsKT3zsFXACvaxE36IAdxzGG3XI+zJ7PXWVivAmx5ASIaogIOafnAig4xuvGdeX/ifmbdd1UGVn2XWCh26/DJ0LNTAezSVjiC8x9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fL1Gh7xKLxrsLugeoSj6PkpTiuDaochtp5xFXF6b1w=;
 b=CFPP+1L1jHNG7mwPFOtl0nVMMjPk91/cKVvZvOEBBH0Ztco11b2Abj2okbPsRPsoPRn2iB7XUjxcbSYIKcm1G4MXZMRrfL+aObhsRkU0ORDEUyXWXYP/IDngSb3eSVkEAGCOaqEudBFkJyrzYNuIrYP4Dw3VMUKPJ3S1HE13Tp8mO+MsHkIPRBcF9zyJR/GKlLsNPr9OgPpWWtlm3JYpYiM2qq/UQqLPBxTw37C7QM5rNExDnabfC3DZlr0huW863Sev0Tn3OUdX4+s1amvInK8YcuzxVEDQqj/YeahZQ4zJFxiWDbZ1gimEKGbFeR3ZfdyIRYCEbXmTPHxZwwltUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fL1Gh7xKLxrsLugeoSj6PkpTiuDaochtp5xFXF6b1w=;
 b=P5TxP4hhleCfKnCOfV+2uKrYgIKTbiSEnm/fsnMDDUAPb+Pu0npTpaUQsK5itCi7cjNmXIdrp2D53NrTK9SxfJi7H9yo+PBS7xN9CTmKcV8wnyYSZqMyHhPJKu3TpgjxloP4KQs9P/Q9S11TSFIEDQdpatP7T29KGmlm+DYSQ+wNXGNUcrb+EY8Lx+hLOS8u/4ctzuTOmSylXmwNx/Njee1nFcyxnX4NtPzOy1qojQ0nEWkw+ZwaO8Nmnvu4XCTw/0WKdkuMC1lLAwdFd2fK/gD2Q/SkutjlQMANdbJtC1PgoIDYw2efjN36YV2+b5TGCE8vwwBGtl9E8VXW1UKlVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:15:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:15:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 13/20] mptcp: add use_id parameter for addresses_equal
Date: Tue,  7 Nov 2023 16:14:19 +0800
Message-Id: <e7b0541dbb43abebfd38278c019bab807969eefa.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b0c790-50e0-4eff-b597-08dbdf69c21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IzXqzS3agX0QpTsgKV6r02k+tHoGPLsLAhkfwiczGZoPfz9ija0OT2QC5r1CSoiG/yTiHfIPMvzsU4Gz1cdg3UzHDliTFyQ89x3/hnfPOdWgFKG/0A7rEU1//hNAShztiWy0V1l5fmlzJqDBWJicI//AXImqlEYHu/6dPsoMbNDWkhqesG3Vxknj2fdlAhsm5FH/SvG4QZvsJBq6wZoq+GvB1gnYS5Xs4Fy2HyomF5JsnU3K0PstXMaCzVUVT4vUITbzSRoUlpq35oOfZ/RgzqqVjZo+2LL1O9KtfrHMLMaLgOqleB0Uercp1fYOdQuxqYD1kja/GJEIjhdMIGaLQdkIpjW/8VUg6WdJjkR6I7vjGGRucWcad4oAW6BVaYHh/65mcFt9j5b4kg62jJF15QyQVPJSZqbc0SdmupicuaEVL4h2pmCtAtoEvX++4WKycsVfy5upmAmI4CPrfRQGQhIaSp5JnovjCsf4pXzTETXV/UngpnFWZSgBvNKxPPg0pQxtCj7GkRc1ZoXwsWZWPueqZ2M9127i43ST6gNWUMjAx25VnSXGP34eelxROX5r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N7knVB/VSkSARIvdNJgKlbw1nWvzG0LG4YcJDHteD+5iaUKVhX83udFGxh/2?=
 =?us-ascii?Q?1wqjfW6GvDjKdm9mBoBVov6mWwb9NzSJLPUv5s6PaRNpBryguERZ2/w3q2iJ?=
 =?us-ascii?Q?CDgGwxJA8sE0fpXZDZZSQkwvw8gV22A+zEbq0Dqh4AFkTjZRaWIYsE08R8jk?=
 =?us-ascii?Q?vXIi4tLpMpqxl02m4XZEwAps3dpo0iwlIhvkiFbryrf8cngK8DswCkd4NBNv?=
 =?us-ascii?Q?wcNwZcswnDjJbgXv1ryeZW4A7tPpDiZQ5R0qMWbChC1qRmRwIwWt9oPqz9a3?=
 =?us-ascii?Q?sBomvC2Sq8FS0D5Fk6OwDVgiZVZxMOml/KwqK4f8AV6qqgGuDdeFTmQs8hHz?=
 =?us-ascii?Q?QIf+e10E/FDjtq+HHBPoRC7PKyzlEWkvc0UwTuO5/qg6ZT9e+rSWuvd/GvA2?=
 =?us-ascii?Q?pBnW+FHC9L4ToIiOVeD71964T9/1T7Id99mBwlDt/6HM0KSXfmXolXvvHZse?=
 =?us-ascii?Q?x45b+jVWsELSosT/GK9nrs8ekJHsEP6wPGO4BozIhT8ELivjpWL1Otqv3mt0?=
 =?us-ascii?Q?hKQPptL6m590LhXo/uMoLpSFoyMamd2oMsZJUyTzV4RbU+I/8eZUb6FuIGc2?=
 =?us-ascii?Q?OlAOTD/HmkO5mAGD3XU03KItxEoyqnk2L5P69aooFzMu657IE7YMvWUzspRp?=
 =?us-ascii?Q?ECqj5uqGWUyKcs4uLXlEOB6pT+1SZAvOQvB07mQpLHAqPpU1VEokXNlv2pL2?=
 =?us-ascii?Q?/8ivi6LLfL79Zot/cNI+myP9h8HJZUC69Zy3lLk1kfoBpMINWHcZRprnmCox?=
 =?us-ascii?Q?9Ybssx5DkpmBh3ea/XkoAuJtBhSLeoY5LuVggGn37Hr0lMEuck4cAb1RBcwf?=
 =?us-ascii?Q?nujpMUi7O/ENH37u1/PQdnm9GgS5EhOIqaYa581jnOuFnECZz2dy1qs/4/p/?=
 =?us-ascii?Q?dEQRxfLlA+xLaYrpynScm4fEn+h5jSpudCQEnnb0RaowWX8BRTcAks9w8cbG?=
 =?us-ascii?Q?K/dNfS1T8RMa1zauaC8+nSxyzhX3SpKvyVtWrVd1uM1wraZDlp5Rl8F3qWqI?=
 =?us-ascii?Q?KHi4w213QqMg0UCFHT/Q0XcgBpJWjwcrJY6OyAtu+G7A6Ovr8519v/MUcQSW?=
 =?us-ascii?Q?YxmEDI5Mx2O2l/VOxj42Jri4/PNlmmNWLnP8CwrBXdVzKRp75m1c0fn2NXn7?=
 =?us-ascii?Q?PKFk49QzQZgQ24vLqNxIh68hj9F4odzEmWzyUWE0h1IdXxUjHLDbsyaTDOPX?=
 =?us-ascii?Q?94JvNofhx+r4f/riQ+KlE8aKrpFRjhz4hqnxxEWCuLeyK9I55MEy02uSnSKF?=
 =?us-ascii?Q?dWCDaS6yaWNjU71jFmJv/FeqFhoxhWoT+wgjqbz2djMKGcjQO2XE1t2gKpKj?=
 =?us-ascii?Q?cVAv+YSi6nOpEkAAW1Ze/WOXbylG5URNjJvCXFVFggJ7+dTPzwkkzyabEFXk?=
 =?us-ascii?Q?SF3JrRusZzXGuD4sTIdIPsbfFbH+UOArnQVx33xtmDqnv5HGYQ9cYQxlyULy?=
 =?us-ascii?Q?mNqeQ2jacVzCvY5T+g0xGOjHexl7EfC5plHYvQRr+z33RHJre0MaJebYa0NM?=
 =?us-ascii?Q?IQd0oSKoNxT1cjas4w+4hBMfxRruqrqcyrqENm6sMeWp6euYEzN+7XHAv01G?=
 =?us-ascii?Q?YaNWpYXBuSdAXOFGw3uc7w1HEdYb/3+dM69CqEnq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b0c790-50e0-4eff-b597-08dbdf69c21f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:15:54.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwIl5oBqxb3ejbwPNVT2eway/nj4OMc8TpGoOmQZ9OhOGCUyZY0QBTtXvTH4MJBqEWTf/KR1KucURICnp5wNQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

Similar to addresses_equal() helper, this patch adds a new helper
mptcp_addresses_identically_equal() to test if the two given
addresses have both the same address and the same address id.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           |  2 +-
 net/mptcp/pm_netlink.c   | 30 +++++++++++++++++-------------
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     |  3 ++-
 4 files changed, 22 insertions(+), 17 deletions(-)

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
index b7e4c8d21078..cd16535d444f 100644
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
 
@@ -68,10 +69,12 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 
 	if (!addr_equals)
 		return false;
-	if (!use_port)
+	if (!use_port && !use_id)
 		return true;
 
-	return a->port == b->port;
+	if (use_port)
+		return a->port == b->port;
+	return a->id == b->id;
 }
 
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
@@ -110,7 +113,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		mptcp_local_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
+		if (mptcp_addresses_equal(&cur, saddr, saddr->port, false))
 			return true;
 	}
 
@@ -128,7 +131,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		remote_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
+		if (mptcp_addresses_equal(&cur, daddr, daddr->port, false))
 			return true;
 	}
 
@@ -205,7 +208,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
 			return entry;
 	}
 
@@ -222,7 +225,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
+		if (mptcp_addresses_equal(&entry->addr, &saddr, true, false)) {
 			ret = true;
 			goto out;
 		}
@@ -463,7 +466,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port, false))
 			return entry;
 	}
 	return NULL;
@@ -704,12 +707,12 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
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
 
@@ -883,7 +886,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		entry->addr.port = 0;
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
-					  cur->addr.port || entry->addr.port)) {
+					  cur->addr.port || entry->addr.port,
+					  false)) {
 			/* allow replacing the exiting endpoint only if such
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
@@ -1021,7 +1025,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port, false)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -1397,7 +1401,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
-		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
+		if (!mptcp_addresses_equal(&msk_local, addr, addr->port, false))
 			goto next;
 
 		lock_sock(sk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 75ab4d7b9f3d..08620b3ca8e6 100644
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


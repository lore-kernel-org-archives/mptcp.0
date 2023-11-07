Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562EF1FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EIgh9hcc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkuQyNXeJyy476vmFQ4cnYvrjaVqUlnarqgw1nBWIT21DBP9fePr6yO6yrnm36QG5o1uo/SW5reyNSkiCQrqj6bLeRGJqUmrLfOt1Fz4MAkOLjfPREF0at+ikbWLC8B5gFux781zoGO+FNaKhnpCaGrIn2wMnH6jIiu1PntNI2KJprV0fXgCJbg7CeehjQfwdMpwtYDcks+LYubly7gSLC8KwTjj0rYP5jonQrJEV0kFxn7rwk+RU0M7cOWrw1ebM8q4iwFN/M/Pb+nTJuzCglh1V8RNn5dKELsab+cYIgOs/7MRWpXsugIS4a1IGuO3bHJSwVoVCRAOQHKD+/PEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fL1Gh7xKLxrsLugeoSj6PkpTiuDaochtp5xFXF6b1w=;
 b=kcTSPUwrhsTtkjs5IBprZt26OmJKh6xmP6tmM9oeAyZtQd4b04gvclxupshUcZJArNHzbP74H9EyHsohFSPsVlE5kf+aBPBab69v5ZSH/jgck+EC752EgGv8eix6W1/UZYBnXCewB+siTH32yXYVE2G/PvjU65YWeomfDlN+9gemS0TRGw2HII2n4+v9+5aRMkcpST4IEjV9Wg24lc7gKXUkv7chBDioEtB7Hm6VjQXlZnK3NVwWwmCvj+WSMcR/7P9j5UajEGIqBOgzU6nCdPSnMA/OS3J2RzHFMsJIDtIHkqAl2L6eaDC0coSWikUrFjzVlM7YklH/kFw998PcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fL1Gh7xKLxrsLugeoSj6PkpTiuDaochtp5xFXF6b1w=;
 b=EIgh9hccEn9jSWiO9+D23pxwqM6L7+90R4Y11dJh35v8g30G0/wb0Sf5Dgz680+nVgmXYY6G/KO8S6/LBePF+kTHaO9gg4+JkrNPPhiCUSzHL8kpzrZE7DxnU6Lz389onzQqzZsmF69H3shYw3yWhu90fkEYouB3Ivw9oM2KV/NhaZVR9DwdXqPJaC4Wlf8zUSHWbiTsCqTGR5xvp7+5qekFB9P+QBUitqbULi3weKkQxeFzwXo5g6sar4f4vStRbyJkhllBXIbWYetu05s9O5w86cZ1TFK2EXI0nRoub1gdouBcjNqoeEj/xHUCYCpo+GsL6mgfDU0M9Q0clt7mUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:03:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:03:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 13/21] mptcp: add use_id parameter for addresses_equal
Date: Tue,  7 Nov 2023 14:01:57 +0800
Message-Id: <2dedbc8b229bf65cd52b33e17c642851f262e70f.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 908e55bc-ec7a-462e-2f88-08dbdf5743d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ceDHFOo2vm98iEthzlvBa/KyTNpJJKxF7I5P0YyoVU4D08DW9z79faB9xZASn1v2hQPmV0uhhvVErHASB5XZm49LYSBOJVog9eOqttmi7ABXoW5Oihx/B0e43XOH2hV6x9N7CQ43vF6087EwsPnGXxsUuSpQMbg5Yih6d1TY/zGmYCk+ahXHE4iGL3qodzm0/q2yw2AZzST2oz6lKWV8eXsBdnsVqnJXdagma34Wib8NfEWBFaticdXAiloMBCl3zYRnD4mw/OAoxqK4aJqB2miLRpEIo23XtAMofh307gQvE5XmBtpkUDbxDikndiFEDJl0K4k7+CFQd/gL0cDnCMMMT8nyLZjDXKa9ov3rvakkwULqKGtrxGbOmNdge+Cc+ge8pGHNvGKuOeB7uqXHeSlUmyb2UN8Uk4qSmoSTRntcFaHZvmSygTHfGaqbyUPpnrMTv3oqLi9xjDpCExbv05B2g1SB8fOTlw0B5kVD45o27LqDVIbpEEDcT+YgcDwQLeq3u1v9RHJrj4uMbmnP9hJmOA2+/UGZJvwXs0JcwIl2gZznzJgl5uOeHQXDICK2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Czh7csUoyGujE/mKKSw9MBkBhDH+zfUJ6p0rdOLN1osTZar/iUsg+nYsXtbh?=
 =?us-ascii?Q?KvumjfnDKbf1AIueGj8b3YSWq7Jhyzs4pw/XnJp/5Yxw24WaAfdXbxPuXDIB?=
 =?us-ascii?Q?iLdewVZrrFPc0z9Q6cpKdBGkjc8ME250dJ8CozeW6vUZk+oGZPc+IHS9BbkG?=
 =?us-ascii?Q?fprwmw3du+wN1j2wNdHC1Rpp909+Aeb8XISz5lvbrJVsOu/O/H+/rQxfk5MZ?=
 =?us-ascii?Q?/1iOnccK3piGawcmrs4BXUVP+b6iMJJQVpncAR0gX+phYb8dZO+NX6VafAqk?=
 =?us-ascii?Q?KcZmG/xz6RHskS+dCqG9kstQCfLL73BZvvr7yGUV0FYbzSVdZvbhzWdqiHSB?=
 =?us-ascii?Q?vyt5YrfH6isWKtEawu351R4tRI0FrWQYmgXOlezJdTQNrXy24jQqpSJK7JLu?=
 =?us-ascii?Q?jn/dsR5ZGY2U7dNLmrfmD99Nzd7KBgAFsUx/D/XC2Si1YWzvNFbnYu2R6E1B?=
 =?us-ascii?Q?8PNgSAODYb/CAzWx34a3apFduWWObp3gl+lI6t0cUbO/C25HcgMuxjL7V1nv?=
 =?us-ascii?Q?cG0j3epktfABLzcXN/FRyO7+emcmD6C1vRZTOKjyXeIDhZ9ww+TN92ESi7GN?=
 =?us-ascii?Q?fnY/jDevHyrRol9uiIKiz7nT3CUzDzGrPSL9x4aSyZjr0wSg6FN9sT7B0VKu?=
 =?us-ascii?Q?2snpG9Dft5Il8T5DX52joziDNo2xTTHjYKaaPFaua1CwVQAgS9mC1itFAuzf?=
 =?us-ascii?Q?I1DszJKTvuSV51ph9rpwUM9IK8s0QkthMXxthrEptFm2o87PORom2GMMlaib?=
 =?us-ascii?Q?r6oyRNr2YT5O7Pqqq76s6zBfuPBpZYt/rR2ou/dgj/iuJU9UxA9Q/+5tt1kK?=
 =?us-ascii?Q?8Gud0Rv01xnYktgyvSdal6LZdYEnYkSNzA0adOpj37bJZkV54xBQ1wPab1dp?=
 =?us-ascii?Q?mWwMXvbN5TinCmpEgsGFw7wKh7a/ihn4EhbHwncnfBZNgY1KD4hjj+cGaHQq?=
 =?us-ascii?Q?au8NTd2BEwLrK9eWhPc5zmAmRG+X0XbcVpawd/vhf5NNsce4ydmn25/IxCCS?=
 =?us-ascii?Q?yI9iuTKVBlKxIYvvKZIGzBR2aBDCKaHA5OJn3UAFRFAi1GuvsRhLsUgE7qCs?=
 =?us-ascii?Q?fDMRQT0kzsNCOPn8tP1HcjBl5uLHfiFdj/TjqUgcGOwG1aAU3qqFcpee0U7m?=
 =?us-ascii?Q?auirBOYglqt+k4FJPV7925EYIlYinheTEd1Nrkc6qNYwrL4AqlrtanHQ4Yhj?=
 =?us-ascii?Q?f8yeApNhUgztT19hs8oinF5uLsRxPmzeYcMC8IziwFZd2qjUk9EWJqCwEf9K?=
 =?us-ascii?Q?zYL8NEuLlDrVX1hKEcZX5rnEUxTB/ye7ayTkonWNVPAKMYKnEZhQRDsHucwp?=
 =?us-ascii?Q?NGWa4ZxRfcMoRe4wIwao9SKXjT8er6KNdr77sqihnk/b/v+uyF2Jflu1YKm8?=
 =?us-ascii?Q?8rNMY5S4+jyGFTVh93AiB8OlxGbxmIgws9VoKP9BecTZ1nTmtix3FPWARVHM?=
 =?us-ascii?Q?qQuJbl2yNAsXY5dAX0Yj765pHA67fjf8/wt218zUVT/etR/YJ74HAOqaoKdI?=
 =?us-ascii?Q?vlqHVq8qv2XtgYoFU69jJ+o+OMOXjtO42ccwzlhQAkbjDvVDfZyqwDqBx1im?=
 =?us-ascii?Q?h8TVbTgNQdG+TkJXijgNfrS8/nK4fh6sP3p3iRgG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908e55bc-ec7a-462e-2f88-08dbdf5743d3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:03:30.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCDTiEWSd1E9wsAv5U5wGI04o8sMdy1St4jSRBnppiqBKj0sDJ+LNv4jcYSMaqHyZKfP8V8jm7/lc5QSWCZV3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

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


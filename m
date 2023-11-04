Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0115486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="nxh15VXJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C36pCKuSXwBbCl2YxUTLeJIBYm5hc1v0njPtpFnOoMNaVfi14PsHfl902RkBRVBRalOIH2XD/BG9GM2sz5VUZDm9cjSYp9H4iMtIH0ZhPK3SP8r77NFoSpdcX07uZK95msB8TEDAf3p3PhkBQZ5+9EjV/8sB4K2+G37itbFD/dh/3jexYlQzLYs5In7o91yJKOr6x7RIhTOssIWgjTgfZECV4igiBv8YzAIJUFY/SKOQcvjeGAdXmwpIwYFSSPrx5Ogn6PM34QBYfZ8F8zy2EHmpVLnB4/AaczFljd9wcpZhd2xIlhh5WZMyZO2j/yW8uZCQ6RSchXc3QAR7F3fbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZrboBR95ZBgo76lZHz8SZ95/sPc5w/QF9MbFXExDSs=;
 b=nwOaDrzyTkcaKnCMheFGX7UeVx+LItvaiwBv8uUCVvOHDXTUbZHwvA9iRlNfo1C5Hnp5ZxDibHmrO2+TmKce5cDcv+O1Qo5XiNx0r1JgxFv17+vUc2M2Cxm4e3ue8wJsVARUqdS4ieo/pW6ZWHoSiYMs3WEP5RBDiGuK4sXtuQupArP1fP/S0EDsOITTYNoHOt9OlXfTnePfHPKBTYwz9i/g34rSYGeZdXJx+jv2rgSVeiTQQd+qWVS1e93Hcuy8CiD0n4Bf7hy4Tm07wTGLSFDv7ifX88i+i6pD/SImLKMcDp6kYgFRJLwb4IkGtl3AVZ9a3yetTSH4zO08g03YHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZrboBR95ZBgo76lZHz8SZ95/sPc5w/QF9MbFXExDSs=;
 b=nxh15VXJwOqgZCT+B8LCB4DjqZkHQgddPmGqt77amgbhnjWNSKUE/4FKnPrWzpr6M3H8UV/uqpm60CnnQiv2GiQ2T5KM34LjTRvWoYa386IAiJNoYap4a0E1bR5F/dkUa856YjbNRizGpji0YF26FTUYpdRr4LN23HNGdBX9sn04sx8emUfWx4MjgO4GNjN29B6Rrq+cqaTX2YMobrUlAU39x6KbvU4AAyKXRhkzrUMhvfcmqct1xqvTT7baDCtqI4BA7jmznKhlsQa/Ms5Z2bvPL8kDm08YjycsX6M8H8P9d7RIFzIPLqCDWW+TwcdE51FyaDxtUVUspa2m2NNNRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:17:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:17:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 10/12] mptcp: drop mptcp_pm_get_* helpers
Date: Sat,  4 Nov 2023 22:16:24 +0800
Message-Id: <063cf2a539af3f43520e3040cca09cee25bbaa5b.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: e331b2fd-ec9e-461a-75c5-08dbdd40c9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gl21H3r3okxywZvhk3LMzKEhz6ea1Z6i3Z4yrum/rY76D1EaFm9RInzHNzVvYSZ0ZgnH3USncjs6HN0jqkSUEK2FuoCAoWN/efuBgUOlWmBWyo33CFBZzrHb6SvPysgTcUUs0wb2xM7YJVHm2vRNx2CqwBEWNn2Yup/Oh8xsH/JIZXZqRwmikzOZPKsDPryjplH+7nN03yIoJDMEzaXRhPiCdNq5QUSvioRY83hMnabbZ/hWyqf4mG9aIYu2oBm3sAux7d4HdPQ9ZYRRuZsn4RDRWhSemD303Z0vmllDnwPS0XqHOtDI/OlX4/Cs4E+0wWViLonjTFFBEsZGRNYZnejQBAdYoXCbIM5wcGz9EViQJ5/LhkKlMVx2WBnT+L2x1z5da5liS8HuT0dygmu7LhMrZfdg9O0jI7J/mv+LyLHMGIX6MUeUqBx3EHEeABETocUXowL6YyuAkKO2TCDH50eq+vEYhJjqbWlMmAG/2BsGSqVPEgzYbZDHXHpOoiXcK2Eze6acaKkcaW6I37HuXHyUXrAMeDhSsN0qZvaNZemYVQiSNKv7vPgWR6v4m7akeMwPUDg9D+CG7g9rcqFAP8ComsFeR4IXgzmFoJr9fMVpT1SFcM45u1JeyPAknwrHlbchOwLzKqkPfpsiOrDP+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EfsBsNNafxFKDWACPS+Slv1Zkcy4+MNVTTxg+E2X+gZnQvNoKg4/Tn+G8oKo?=
 =?us-ascii?Q?7Sa+m/EOq/VldV+eADQRNk8lZbSMTgOgHaEqfIYNMbcoxUn/qVXG7EOyuwGD?=
 =?us-ascii?Q?xyg9Ao6l8LPyw/siHXV33bH8V/TrYejIdHciH5rS8Bt1TGO4q8eqlFfg0HXN?=
 =?us-ascii?Q?OwPmLtHo0Sb86xVzI32e9kXO2zJwV7EZj1BTybLy1qnls4oHITTocL8EWB0k?=
 =?us-ascii?Q?KX4iOIxRac5fIZNp9q9tUYSB9xl5BDs4G7F91VS2BSWnHnFO/UpU4MbOxcm0?=
 =?us-ascii?Q?Gdg1uybgOYovlptScaCzQWNLmVu4tltnYL3brS/GSEV0HICGRrJxmCm5t/8y?=
 =?us-ascii?Q?rTl9F6o3crLMAsbxxB2VD9CKioy4cJ3ZI6yEszaUYMAFs0KZ5GyosfcAD6v6?=
 =?us-ascii?Q?3NJlT31u2e8l1kSyO9XeuBeh7+WXvMGT+weR2eWXDuEH081l0EIV9JDIXZln?=
 =?us-ascii?Q?/oHU01cz7olQ6PkwdYvlvGN7zA0IkRc5oUuHte4kTLZesv2b2ITbts1DdIfM?=
 =?us-ascii?Q?eYz2infrSMEERLB+hObEVGuEkZCSXTBCQXSSRQAmXR+a4duePbbkYXz/5q6J?=
 =?us-ascii?Q?JR3dglCUOrJp6Wd5edZ/u3r34G/OIJWddqnsOK7yMFhn4wm/x+xcJYK1dgqU?=
 =?us-ascii?Q?Bv4ZLi/sz3mla6aqzodKI/QAoZuOMQ7i+grUFYjCe3aLxhwhpIQO8Ybz8n9m?=
 =?us-ascii?Q?WiHi8n7IpPHx+7gDojnoY64gFxZcy3K3ZU1ywdqkTZzlU0U1K0d+IHT4rlhE?=
 =?us-ascii?Q?BwcZ+ggfxu9JJqXzksSK/pGAtqlHVPps15SGrP4pzSVcGqwkFLtcvZN5pogW?=
 =?us-ascii?Q?QS7wqM97/gzXN2wsWnQGO/uvYR+E50WGeF29v4yOkC6Q6nmEX/BJcPlVXH6U?=
 =?us-ascii?Q?bIfTVk1e5j2IjR7xyhmWPDugN/GRTcy4vS0lwbC6eImKtdJoOSCgvaLaTn5Y?=
 =?us-ascii?Q?eD/L4TAZu8rWz1xobgeYqEBU6m/NkU9IrJDwwyQ97i7bUy6Kv+7N2kkpmmle?=
 =?us-ascii?Q?SUonY0vGXtE2Lfbqwp1NCtOA8xarBLPQW4wWIUcvuX4EorXL3PS17ZvIYYVx?=
 =?us-ascii?Q?nUJP360t1B3MzD84jlEcgmrNsn3fPbZQk1vnHNNagolQnUK9g/29JGfIqIau?=
 =?us-ascii?Q?2cdMac4GTm7g4wX8ukumzLWvoYAUnYwcHX5d/zIwGqPV4X/N2E+p9Rk/Abxs?=
 =?us-ascii?Q?La5qoCcFo/nw/bC/OrvdeYHAvT/khBGZkzGaj3cNOBVs1nm+FO7J3/jZ0fSj?=
 =?us-ascii?Q?82LJrzTdslLFFvIWRJ5S/hhteuqS8PbFw0XtjwYtD+Kf9W7y7HJt0++2huDI?=
 =?us-ascii?Q?YQb2uneIWTY21XJnrRn2gym6ZqwxAN8oHUXu73DWNlFkkYvVWKNynR0zgaZS?=
 =?us-ascii?Q?XVSzPnp1w2qZ0kUAq+Ch+M5VjYy5X1iVzx3/6+K3ixaoM+6tpvbQ1kcGndtZ?=
 =?us-ascii?Q?XqYNfHDdkwwdF+Z4zx3SD3omiRbzcKmtH+2+/3ErTva7kNsF7VD2DD4KwsmC?=
 =?us-ascii?Q?WKW2Dfw0RoY31hMgMzGxybeN/8pc9YbC+luC6I2ILO2QsE0613HSGoXb5tsp?=
 =?us-ascii?Q?vHF9GaChdJ8AUooFT5DbJ5Ag+71pv1rZfwJoOnqkh4dD4Ba80A/+NjIPRcEy?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e331b2fd-ec9e-461a-75c5-08dbdd40c9da
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:17:34.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsD36mxqtfE8rEOJ6XBhE00KTVb+PGeZ0ZhLAT3yk04hOYKgRg1UcRmujjLsGOcyfi4AB96fUUKPovvD9utOHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

Drop four mptcp_pm_get_* helpers:

	mptcp_pm_get_add_addr_signal_max();
	mptcp_pm_get_add_addr_accept_max();
	mptcp_pm_get_subflows_max();
	mptcp_pm_get_local_addr_max();

The helper pm_nl_get_pernet_from_msk() now can be used instead of using
each of them.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         | 12 +++++-----
 net/mptcp/pm_netlink.c | 50 +++++++++---------------------------------
 net/mptcp/protocol.h   |  8 +++----
 net/mptcp/sockopt.c    |  9 ++++----
 4 files changed, 25 insertions(+), 54 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ae19113b8eb..48ff7ce20890 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -85,6 +85,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_data *pm = &msk->pm;
 	unsigned int subflows_max;
 	int ret = 0;
@@ -99,7 +100,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 		return false;
 	}
 
-	subflows_max = mptcp_pm_get_subflows_max(msk);
+	subflows_max = READ_ONCE(pernet->subflows_max);
 
 	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
 		 subflows_max, READ_ONCE(pm->accept_subflow));
@@ -496,6 +497,7 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
 
@@ -508,17 +510,17 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->pm_type, pm_type);
 
 	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
-		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+		bool subflows_allowed = !!READ_ONCE(pernet->subflows_max);
 
 		/* pm->work_pending must be only be set to 'true' when
 		 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
 		 */
 		WRITE_ONCE(pm->work_pending,
-			   (!!mptcp_pm_get_local_addr_max(msk) &&
+			   (!!READ_ONCE(pernet->local_addr_max) &&
 			    subflows_allowed) ||
-			   !!mptcp_pm_get_add_addr_signal_max(msk));
+			   !!READ_ONCE(pernet->add_addr_signal_max));
 		WRITE_ONCE(pm->accept_addr,
-			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
+			   !!READ_ONCE(pernet->add_addr_accept_max) &&
 			   subflows_allowed);
 		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
 	} else {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c2c51fed4e43..6199908cc26d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -183,43 +183,11 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
 	return ret;
 }
 
-unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
-{
-	const struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->add_addr_signal_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
-
-unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->add_addr_accept_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
-
-unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->subflows_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
-
-unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->local_addr_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
-
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
+	if (msk->pm.subflows == READ_ONCE(pernet->subflows_max) ||
 	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
 			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1)) {
 		WRITE_ONCE(msk->pm.work_pending, false);
@@ -404,6 +372,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 					      bool fullmesh,
 					      struct mptcp_addr_info *addrs)
 {
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
@@ -411,7 +380,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 	unsigned int subflows_max;
 	int i = 0;
 
-	subflows_max = mptcp_pm_get_subflows_max(msk);
+	subflows_max = READ_ONCE(pernet->subflows_max);
 	remote_address((struct sock_common *)sk, &remote);
 
 	/* Non-fullmesh endpoint, fill in the single entry
@@ -514,9 +483,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
 
-	add_addr_signal_max = mptcp_pm_get_add_addr_signal_max(msk);
-	local_addr_max = mptcp_pm_get_local_addr_max(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
+	add_addr_signal_max = READ_ONCE(pernet->add_addr_signal_max);
+	local_addr_max = READ_ONCE(pernet->local_addr_max);
+	subflows_max = READ_ONCE(pernet->subflows_max);
 
 	/* do lazy endpoint usage accounting for the MPC subflows */
 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
@@ -621,7 +590,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
+	subflows_max = READ_ONCE(pernet->subflows_max);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -664,6 +633,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
@@ -671,8 +641,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int i, nr;
 
-	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
+	add_addr_accept_max = READ_ONCE(pernet->add_addr_accept_max);
+	subflows_max = READ_ONCE(pernet->subflows_max);
 
 	pr_debug("accepted %d:%d remote family %d",
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8bfa9bb0552d..089fbebd21d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1046,15 +1046,13 @@ struct pm_nl_pernet {
 
 struct pm_nl_pernet *
 pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
 {
-	if (--msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	if (--msk->pm.subflows < READ_ONCE(pernet->subflows_max))
 		WRITE_ONCE(msk->pm.accept_subflow, true);
 }
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8d485c40585a..98f39c2a377a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -890,6 +890,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct sock *sk = (struct sock *)msk;
 	u32 flags = 0;
 	bool slow;
@@ -907,13 +908,13 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	/* The following limits only make sense for the in-kernel PM */
 	if (mptcp_pm_is_kernel(msk)) {
 		info->mptcpi_subflows_max =
-			mptcp_pm_get_subflows_max(msk);
+			READ_ONCE(pernet->subflows_max);
 		info->mptcpi_add_addr_signal_max =
-			mptcp_pm_get_add_addr_signal_max(msk);
+			READ_ONCE(pernet->add_addr_signal_max);
 		info->mptcpi_add_addr_accepted_max =
-			mptcp_pm_get_add_addr_accept_max(msk);
+			READ_ONCE(pernet->add_addr_accept_max);
 		info->mptcpi_local_addr_max =
-			mptcp_pm_get_local_addr_max(msk);
+			READ_ONCE(pernet->local_addr_max);
 	}
 
 	if (__mptcp_check_fallback(msk))
-- 
2.35.3


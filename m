Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB77472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pp70VJP6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLJKD6R9s3y5bRPvVK+cFjS56vJzu14GWppcauxB+IBwrfyd9PvKY9j+bAxh53owg6TLYKwpyIPOuE1y2w2BRqjXAJd2Z9KIiof0kxI1AmoxqbcL+djKLZ+zr9bphAhWgl1hDVvItb3dkyj2coK8lUBZBYR+nv3wnCiBFUfuCjScR9pyEDQWI8fvV56WJ1wTPu+swOI+YU0WJP1CZX/DOzYnnBg8pX099hYwapegl5nXfkrICx2hCbCZoBUVGzzjDlTE32497K6D4Kkkq2JTow09wFbQ3GqHhfh03w3xmK3K2ZTVAiIWTkrzN25Y2QX4CLXfLa6sVx1qhRXc0YJAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qjlxfh/pOPBcGzSu6yZlTXjeUIIUlCMyCMvAB6NJvY=;
 b=j+V1/zBueg8Ye4J97vjOWwdLPV2WgRja8NeJLNi54VNoePSIeSCB9QYYpENmMD+WxCEHYwZYpJGbDNKVJgBSmhmhOjvvmMM2G69U0y6L71MB5u5yMwPeodYUn8rtAVjewV30eNnR50oxrOIrD2Wxu6//1ZSy9Vgpp6vexaR2eoRwIXaybFpbE7kneoC+VdCkDT7wfr9xYRzcE8bXt8ARxT0gbGb1h+HMM/CdZx/wSqbrVUrKsb6hMhDdR5RWPGYrfwHT3B0s6srh54CDGawb7uDSOixY2XHjtnWhJ4p3sECbjOoF9npBYYnJ6PsVA9Cw4m4JF00n+Da/R6GvP09f8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Qjlxfh/pOPBcGzSu6yZlTXjeUIIUlCMyCMvAB6NJvY=;
 b=Pp70VJP6qkvIvuZ6MO1sUyqjVjV0EzdcNimJOzL/LwZiJAeQz4tU6nmjReBBWxer0aCQ7yR8bOYE4MsQN4saP5Zc2Lb9H8OOUNLTdl/SUsBbMMO/flmsBZHEvNwmR3wL3i5NUghsnzztF/7AqkhjzpuWQiPJCv63/RibJJ0hTk1j/6/yVPsl/M14uxOWJd7UgwZ1NwE2A7UayNwFXWUBrhtsmf8BAnLvBHurb6BJHmYFGj0sA+Ej4EObYpCOfmMKc3si51iGr+pFwDAC1tZW0OeHHf47OGlyBQnk4aHpkU2sTvarlzDPl90SJgMlG/9zZ41a9GSgB/DtWPzGBUhRrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 10/12] mptcp: drop mptcp_pm_get_* helpers
Date: Sat,  4 Nov 2023 16:35:45 +0800
Message-Id: <1a25ddde32dcd4bf35895c5fc9205c4a84024133.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c36745-711c-4bcd-9c11-08dbdd112fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3As5zqyqlCOwYaOzjYxhuJu8H5c04acE51V/VTGNOrvMHxW6vkOe/2SyoLEVQImrIfpcbrms4vS/lxg53XHqQG51NuQX+Fni7PMtHj1KU7knoPfTNyAK/ECMMMuhPZTHmUuSJY2BxTHIgaiUrCFfhVjhBE0PgH2MzUjMaDsWpy6OtWeBBaME8ol8TlN9hJ4LqlcoX3lhMa4OpAci0nEeh0EgZki8cbWXga0WZlm4Loq3AfL7212UHfQu9eFc3sg8LUuNCdI+/0sZq1sh+Qj3m6MmsDtcn3U00Kfnkc0Z6pmaCj/eCWYIrwNS/I9GB3UkdAx5GedNwwxPWfgHvoQrRFinrwEZ42S7XRip3Y30bFCPNZKgtMtAg6RmkPcOobaRr8Kpi+KCHdog392ecmBC1wL0gI6IFGfKviQuBCXOXvaTkQnty1eApqC1WvmBfsM+3sEIUkHkRlu8wkOpcr2qF9r0qbRksfIe/Z14wngqzeFFXFlPrE5ugb40W5tSGa/7BJWK/e/Obqpce52CxWHKROTcMsi1qE64cyIElqolO8raWX06wNb413a6DGv/WUYwHNOhblZjKUzaWCSSno3BItvDL68jWTaHFFl5K3iptQCETPfN7XHM3IQ8B+u+Ee2y+66NjqP4K46t2aDT8UnMzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+w626M4etlNLB2kEzCXfQzpRrj7AR92q4mfAHeTLJ7lGUu9O27Rvrm6hTVZ2?=
 =?us-ascii?Q?ng+3cg8sloTZd7MRlQoouQXk9rb5c+raX6egwPGIBjD7/yGtY9HtRmOhHnct?=
 =?us-ascii?Q?Y0papFza6pdKku5KMS8fC9eaSl+muk4rWkmy4nuvsz6/+iXwe95/1EyfKBiH?=
 =?us-ascii?Q?KUeS4DhDAK1k2QDKsln5RaXpjaxoZ4vbjcEz6Lz1XSiUCyoN/LeJaCdnwzdU?=
 =?us-ascii?Q?D3igCfbZH8aT9GYTgD0lFXZoLTYbTbajN9ylGngP7hdpAVlsp2gbOydc0NuN?=
 =?us-ascii?Q?D5cxA1JGnOQPKbraPliRdueNE38UParTSExfazemFnXO4iMBq5d7FJURWzoT?=
 =?us-ascii?Q?DiI40Ziee5dlCWPrmQJwTv3HdZdtILFfQK4zMCG3Mtz17s2dP9RWmjlFLoKy?=
 =?us-ascii?Q?P3QpaBdbUw4wigmtAZGwNYAGXYPXtLchi1ZogJGXImj/W5vjAknd8otzSS/z?=
 =?us-ascii?Q?a0Xl1F7HEmvFuSx85zgnLUHHlKNR7+kINXTixynCTxQevWwiYL09aGocZzA5?=
 =?us-ascii?Q?0btG1CdW0ED28lfP1xwriUIx2XhaJod0nOlpFiblUDCZNykJLmme/MzBWqeQ?=
 =?us-ascii?Q?XwenFWvZUA9JJuGTt19AISM4mFR30ntrdu119c9zl9/FngNnNuRdw9wGAEmQ?=
 =?us-ascii?Q?IqbSSyYuIXOHHQZDke99xVEBA/jNMP2VQZSQ/MhcADr9gt4DFil67MsJYGe2?=
 =?us-ascii?Q?2fXpDgP1TNH1aWJaBUIt8uQo9/R8VbqTglp7VtvkPRTrUWkVGH+GSZTYWpPS?=
 =?us-ascii?Q?0XoVBL06WP7KG4HUsS4k/pUUC6gqj9J2pJfaVEboMPYPmI2e9icCOFkmScfL?=
 =?us-ascii?Q?sS6bVrRnEf0G7rxw08YWAHz18hhp2XB/L3eYcQeNbM/fhW1LZPjhOvdcF8E9?=
 =?us-ascii?Q?WxIqjz8BaQSpW6wFcCDMRxDgdiLvzydEqiO3C+GSLss4vZnb8/+gln/uDlM3?=
 =?us-ascii?Q?y61JiDnW50j0dq1QK/HoOyIBSZtpB62C4FKnp1pZeyjsvOfTqI7g9xksPWOd?=
 =?us-ascii?Q?KyBml4XyG/pkiQisEpaDXNPdZ56u5/Ms/1J5VSBD7/xzyTpuflxfaBvFCAhL?=
 =?us-ascii?Q?1C4zQQf5h+5zfCrAkTVmxuByihhYBFTCv2zU6h38Y44M2tfRRMP6/88Hgui0?=
 =?us-ascii?Q?ZGvNuO4YBQKRAk3TaCzHr63Jd8Y5ZqQBJyGDIcdeU3iZdTjyiirV6aEFXMaH?=
 =?us-ascii?Q?ilLTPa0ExSyYvqbU7Iy0Sp22pV/o/7/56WRN5BlW3LKiu4w1dwt8ifUbgl66?=
 =?us-ascii?Q?Gy4P8euNUGv5C/SzXHz3ydKiQcN2xoeP7q9HACdcbesO9aDNBjnLuFCppvIu?=
 =?us-ascii?Q?5Zop+Y42q90K9YqdvyK+rbeEhedlyPA2vCmnJtolm6IdaVp5djkZS4NZ0rep?=
 =?us-ascii?Q?slGv+YwtdpzSysjn7bYzapFA4OosHSrxQMQA89Z0XdSq8NLzSz2HSeQiJybK?=
 =?us-ascii?Q?+Mj13WNDAX6I2E4+mDaOf8hhMn18Qmz+M0Jc7wvfAZwqEchwhvBFH14g3VWT?=
 =?us-ascii?Q?P9+hrjl7YiTc8a+q/IIwcQNkV0IqSIjQ84hZNhhVTRKtm25yA+h1R5JfUckN?=
 =?us-ascii?Q?lg98Vd4xnjm1p6uqZZjmppZg8j4K9ugl0cKs4mCU2JIiA7VXSwP1TlX4m+67?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c36745-711c-4bcd-9c11-08dbdd112fab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:48.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKG/rJQmiK+K0FFVDze7emeApq5m6KF9la5rQiyTaP5nSCrwaSjTpBK5pnpuQVcf5YGTrgJGk8SU2zg1XmDASQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

Drop four mptcp_pm_get_* helpers:

 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);

The helper pm_nl_get_pernet_from_msk() can be used instead of each of
them.

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
index e21ef13b5ed9..52f54d57aca3 100644
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


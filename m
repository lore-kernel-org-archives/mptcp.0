Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BA79D8
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FxYuFdKJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0d60Pg6lhrFR8kXRaJ0t5iYu+w1nRxZcpRpV06U1i55CCPcjb4vqc3uEvktEsALB8J2caOPldo0xdb09hUjd8mAgl4OsuGNkL/IsNBABDYcZPmddlA7xsjm2AY3X+ZU+saDVdXalebu2XRch2lNJUp+zulikS2UZAwZk7Vu7HATUULuQhSgcIk+vdreq6o5QinNLrMdPrtQuB9N23ygCaFF59twliCO7g/hU2hcEfLY5LmBOV2/5cC1zCW77KvTRnb86eJg6zHAA/eNduXZgqFaHwlZ4HJ5xC2iKGSb0cQ8f0oRPNDySoP7LHDrXkjgFPGUcsFgpYSjqReqe4AJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=ADIoEvc+8OTmT1h4mZ8xnET04mlMrd8eY6yhpTdqI/Iqs/A/JsyGshnw1SpzkAVzi66jf8/drX9XA+zhEcj/pngx3dg7hghJZ08iT9zhLrLQQ2kxZrufg7Kbdc8zTkbW0iPo489tL55LVL5mqCqVAmoS1bUGnTu5TsrXQy9goP34TvOw00DPZ0ZClPTeB4th9dwEjymQ96xYgOAAgOK+ZAv3uzlGW+JV3wIyODO9FQp1jxVvUcXT66R7GvfMaUVUGfRlzXHYugReR04XCJPCVVNNTboNdefciAwF0fsfCKWmUaxSatrpOuFhTSPT6sFjKg+JHRrM2ezE8zNVJhFATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=FxYuFdKJbWfmipOnvyPc3GD+K2Uo0fFSkj5pr7rlCVq9wnsG8h1xX4HKUO3zYzujkNXdLzcqFwXXtZ85KX4bZS/uHFDGjlv/XgTsi4WyKpt+jYMZ3S2riU47p6DCy00qFteLvD0UtE4GLl46myAAgC2Ev5S2TBi3UiNYE6cUlnJSSqxbYmgqc3Jx3Cx6q1Z4mKwIOlFvS0XM1FrWbyQhmkNG9En2Rckzq1U6B5Q5uYbcJ/qHW6EHZwK1/mpBuTOGs5VFtRUtD3l/jKsRaMZaBmHkR1Ux8AFH6HbQOz95MsFls8Xo2wniTc3sn+y/bg+hEocnoBieoaxwZToRd3xI/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 02/22] mptcp: drop mptcp_pm_get_* helpers
Date: Mon, 13 Nov 2023 10:48:46 +0800
Message-Id: <1a60ab6883e572b274c91ca2d0c3775c1917da41.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 51287eaf-32aa-438f-c2a4-08dbe3f31d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CYGhzOwo5OoCzZDvtwz0Hmeg5BUnoGuS1rX7oPbh6VprsfhWUqkU5YZjFkbk+ktW0oqvf/TjMKCx0LeJP+rfCdFKw0Am0ILrRgx7LJVf2ipZrfxGbqjdqTB0/tQfhjRX7kO+WZptT0+Z/lN2TanHetNLLq57aEAhPlL2u1wZUBfCn7quMhKOOidVwA8tM/zMaV3q92e2lGi4OyKXkHB9mTi9OV+SHjccLy98OFw1jRatE/qPgK5ihnsE1WPdb4hwhEtd5CboFzNk22TWtrGd7qsiWz0A3AgReQTY4n/yuSq/XH2DQScpMC6Pd7iXj2omnaCbGAcR6a2Fu/kob0g6C3wdPU/DK3+ePmtDwjio1eDDGfKn1txFSHWX/pLYcthKppzBDJ3nJ/+hH1P2yLYHXT+WW8NNjTJcHeMJYewKvngvYPoG71exe+uHcWHcXp59OPR2v/+pSHh1+tgU10ArwPtxgHr+9XAYiACcUaWXc7bZi7Iy5LCye5ULtiHHjFG5h+jSOMm5EaHjInvsWBjPANg3KWWR/AOE7jAvAPSfSJ65yKjueNQcUlMDk6HTb2yKP0nhpCOn8drXG36Hjh70eBg17wWtUnlEGjzVGuJXjrWqOzIYGbXxHTR0sur/yMK+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjcCHVej/ph+V9tA/mFqf592YpK6iquJtKfW0qBgnDj6Ydo+2P1iOaC2Nldd?=
 =?us-ascii?Q?IDVnT6y5yL2WhJGxh4fYH5LCXI/Ls5luTlhuYMC8HUCOW2Mn+41Bh1Zis6k6?=
 =?us-ascii?Q?Y1U7evo94Q6H+VDjgqsnKnSqY+AEwdL/BvnIJ7LBpVhectIezDdi68ArQZHZ?=
 =?us-ascii?Q?oeM31xqiHdl6BC4UNSpc3cD9kX7Nz7n5Gt3GVxd5WvviFwe8Y9ZxxlimwCXg?=
 =?us-ascii?Q?N+EDA1KbYnDB937H1+abZhfrroVSZbBUiiypmRV+hQ7kytaJtgCXcIVeB4fJ?=
 =?us-ascii?Q?6/IOvdkJ2dremdDJ2U8OHpoIRQx7xlS3e7DkPniF8TqymecNygbkzzHbd/gq?=
 =?us-ascii?Q?+7ATDWAgGNofPT2VpQkL/WHXtzWR+Ddbr8jYXnLdNfIGZgj6vwr4AsDQQ9GQ?=
 =?us-ascii?Q?n94bY7ipeOQC8+YrE/RcqlymihmUXRKXgE2H/huZaXUjf33DRbLafYWb0Aqs?=
 =?us-ascii?Q?PtftqK/0Dn28LZIJX4qVSr2kqmbNQvmxnCZCFKmEb5NqYCSR3e+qhAOFVD3V?=
 =?us-ascii?Q?QQyNnwOv85KiB52BM9cYvV1dGvbFv13H28A3lRW95nrXf4bYqyIBTqjt2BpJ?=
 =?us-ascii?Q?P3gPcalsZGHkFIkl3FF67g00f1LSmS34JV5rBTQZw3SNZggdsGNStndZkQad?=
 =?us-ascii?Q?HKLP8uhOENWE3voEMVKxyjoSoioN4hm5xI6kpYWBDXouFKcCagaA4KZMpOnw?=
 =?us-ascii?Q?m6rDf+A4cNaYbVXLT1IiDArei/8xfaVSktddUpaiEgoRdqM1xYV6aBn/a2zg?=
 =?us-ascii?Q?ol+8rNBhIoLx1dyp9CNc1oDvO6KF9/U7OpypxdMOw8aaqD48sLNlPhx4HPs8?=
 =?us-ascii?Q?1M864gMjv0KnzaPqDvV8uV8g4OgeVBQ2rvF5DoOeAXVs7dmpVt2YyyLM2zIX?=
 =?us-ascii?Q?d/KqG3zmqfdSZMCq0HSJrzJGbIKdDd2K3ISsGTM97KiHZxPnENm0CXgUudu/?=
 =?us-ascii?Q?AhE7Hxuv3CEGdA4ExA6KRqfmJgWx/p+U0W93eYNV3tmr4QhsuQMeOZtlilzJ?=
 =?us-ascii?Q?bp//Q2xf9oizLrAUcbcejARgMlgxgLLlqVawwwKFCHy32bN0DbVIWhnwFN5f?=
 =?us-ascii?Q?SUyDtUnmgjbr6OREBVo4jz4HbaOlNHLbS6MwhPtuA2xWX7m/vTI6K0f7WKW0?=
 =?us-ascii?Q?PUKNnXFATcVWK+NGNAZvrbaUXzgsCf4cihKKq4QiPEnt4XtHnWEu67ZU5zDr?=
 =?us-ascii?Q?jeqmjbrFI5zAvEcgdSQfc7mdjJRCsR7vvW+ijfalEqbLeO722HfqUNTgRUwv?=
 =?us-ascii?Q?YwsHft8C7u6NZywO5vw0FSeBFs0KX5vFqErDVMQcWYSoF73nGkaD0M72gOaU?=
 =?us-ascii?Q?rZzKUzhaqGSn9sY3vMnU3cE0YJWp0kV+PTEjYbzEm/+W/G53JCqKQOley959?=
 =?us-ascii?Q?Z5OX1TDilsjAts1BDhsxD+xB0+Beyl9p1hWaCM14T7+GAbwhdh1fHULqYgDG?=
 =?us-ascii?Q?//6XZFXcXldGtFM57HXEYexZPxHbnEJOkhT9Bd7s6ky08EvrJJlODpUDh0k8?=
 =?us-ascii?Q?Tz2+Xroa7vkIntyq3rrAx81FF2OEYUtE8m71N8gVR4ixpqtLbiWaAMz08Ybj?=
 =?us-ascii?Q?mepq85r5RdirMRer9Q75kwokXycRonQcCJOSUIp2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51287eaf-32aa-438f-c2a4-08dbe3f31d91
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:11.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnB5hh8+wVj8sMWXEekFnRVHGqvK4qdcWrQJLfS/4vB/peLhfgL2pg3/tv35vru6Xast8XP3ib2q+Z1PC0LQ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

Drop four mptcp_pm_get_* helpers:

	mptcp_pm_get_add_addr_signal_max();
	mptcp_pm_get_add_addr_accept_max();
	mptcp_pm_get_subflows_max();
	mptcp_pm_get_local_addr_max();

The helper pm_nl_get_pernet_from_msk() now can be used to replace each of
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
index 1dcf104d7a01..dbf040e39af4 100644
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
index c38a2126071b..88f5b422f941 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1043,15 +1043,13 @@ struct pm_nl_pernet {
 
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
index cabe856b2a45..8d63df5ded50 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -893,6 +893,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct sock *sk = (struct sock *)msk;
 	u32 flags = 0;
 	bool slow;
@@ -910,13 +911,13 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
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


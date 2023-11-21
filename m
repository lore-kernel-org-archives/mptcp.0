Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6F171AF
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="qdEJseed"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4quf4ezYG+AnfL+z52bosISdbuKXoBH+wsWdGz6eGckl/JMmPlkbrnFCzX0AKrgY9H/2o5piYkLJkbUQ70lJvhiHDTz8eRdzSeH8+xKVW/i3Zg5cuZ7TL8HROtm4RGwvwu2mU7j5R99vgyrtpc/hTb4UZV5ofKlgCVgRfN5Dibj96SrdI7oDQG85pCxHSc9ixw6TpjMLY0FVVy/y9rnZSk0zjgyvTeGjzoAESvF3fv40o41eRQH5v0Cp920JRrB3gJTd7zsHZW2Dk2CM1kDMKJ5kKnrp+iFSl15LKKZPiVq4057xp+mBav6dKrmtC32ssC8DOTI0nH/Hs5hhkR4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=VLfCH8PoOLZY2RcW7Bd0dFDRf6J3AgJ3+I+fZ1egM9YUElBboiDb8hNirfByDD4Pj3oGMihV1PLsc2begyXoyDuACj2ztC1Igjc0nhfgiycc1ogz9c86KELMKQWsNevyiIwXH6Gy1/H/K/qreEfgWGgoFaqu4fnzVam7GSYQHvS6/95p2+FvLzTg3iEgMYyIEf4JbBFQeH2kltFm//DA2TKlc9WXKB/9B7Ik3YpVzSxCyoJv+Z/QhutiTlfZuh6WqA/ZGRj7v8R1fXiCcoJALAG4McDL4mzLJQOiC6BzAj4jDTDwxZMHR4nzAuBVqif73SlHF8P32e12mAwgofe9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=qdEJseedZJyVo90kUgt0+kOm2pdT6BUEndDNi1bFbCoTG+uYr1E/FMD3KSYnbDFbB07hhxh3X0xBMxHLkmPtbBWZeUhVxoxAYk8CZWdkW5OK/ai+fPWRxo2SH8C88ff7Bn5AQcM9qcgKnJM5EmvgpOGDinUBBF2fxOx4F7ZAakFgCs/3DjRApR+yBwGPIgs6Dips8OC/UbD1uRP4BKKl+dRTDLjIXWlQcBz5S47gvF7st3nkDPzb0V/xOCX4iCrEeikqSzkXQMUnZjF9dFNsAutmBsk1W7Q8HMt9c8/wLlkDuTHYnKFxNbg5G872vKGztJMQmX1q9VO7mLT4zKnFAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:53:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:53:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 02/28] mptcp: drop mptcp_pm_get_* helpers
Date: Tue, 21 Nov 2023 17:52:25 +0800
Message-Id: <72cc0b30f8d1a3d78042aba5f903698035021f7b.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 5057ef51-9c45-4d5b-8ec4-08dbea77bc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nscv+osnVaseKBb1lkwwSj59Nw9ZYziFWXK9L/nhPO4U7ij/sI9XKfb8CkAoRDBmDhtGr+O/Gr1ssf8IKef2THXJERFJwfBEQOXJ7HD6M3z8ncE/myIz9HeLHEpvp1CmWW0N9z6pLUt9IUdKYtYbhStXXUTsl83+E681ZgtirF/3W1cdfW60dp2TRK4kZSq7aG1WfGsoKpEDE7+NcHvc+c7z7Sfd1eRIQtFTY4ONpQTMaJaLPAvI/RY1t+mDLCEwU5Cgyu+FhGMNa9fHzCE61iEB8zX09icFviQih7qj04fp7JxixGXz3NwvMg+PnPG1VZKCyd0dUwzc8dsMvBFyBUlwJdTJCK5UcaDU/GFE7I3ikfyrsCwihm0A4WXZXZa3OKTncAkjTl7DbZweI6F4iFiOaFaylDFNw44p8VaXSGdSgt7aNbSUZP6P2kd3khsw5EE2KphQGJ6G2T+vVJw0X/p+eAHN0Y6tRkbdmY/dq8wYiFLqRxSlGkFYc+wySTvtPyO9ZtI2C+X5XDpKKxhi/J51d5ZC9H/aBiqsAP0ntVZ3nlCjNPXZfQkeIGSUVLihzDZZgrYpX54WSukAADPp49L+Z3FxQyv6AJXZreNWFuMmIk/V1bcYQIKvQ4HoDSGH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(478600001)(6506007)(26005)(6486002)(6512007)(6666004)(316002)(66476007)(66556008)(66946007)(6916009)(2616005)(107886003)(8936002)(38100700002)(4326008)(8676002)(2906002)(44832011)(5660300002)(41300700001)(86362001)(36756003)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mKyhlB8CNM1AV8c2TWmdd64WjW40qMbb9KSPH5Astr9XeHaDthdBElSTJnrL?=
 =?us-ascii?Q?6i7MwT3eIGfeubuvzYZG5oup4/mFzERkwRz0QdG8geoFylEOQ2qdRdW0/04e?=
 =?us-ascii?Q?GlAqINgmBlkW6myYvgJb5x3xW1B/hkwo9LG6QCsXpMSkMtNvTzFK2wbwS3wH?=
 =?us-ascii?Q?jh4w/P1O3AkS5QCBbMXAqIbjIYlaVgfgClerznlXdRd+L3WePIVjBAckTWQT?=
 =?us-ascii?Q?QnR4uAHtSm6OfjrM59y5uHKhppAv2yvHKRZpGoTdpIsL86clZrokjRGqm2k3?=
 =?us-ascii?Q?SIhum7v856Uw31p1S651l0srBiXso9hUtTE6m8/CoJIKZHnMdySOa5mezWot?=
 =?us-ascii?Q?us/82tDrXb73JSP2eMZLKAb/DurG2xJcbPXCyx973DrVcyRo4ljJHaSOqwI5?=
 =?us-ascii?Q?sNjZpq+niNQbRW8KMScsJmQVfbusNS0S9qBvcazfwe3E02CTnoLVDh55g6D7?=
 =?us-ascii?Q?wBm6A07qYSIn6Skg73ovZ+K36JwV2GpJXZJ+3NQMyBEo7avOCYNuHzoYQUJ3?=
 =?us-ascii?Q?eo+a1dYPrA8c5Wt5HMD84ARgriTGCRvPCfma8Qd3/1TyyMomnwD6gjrQ2HDL?=
 =?us-ascii?Q?E9UX2pXBetIPJ1rDCs6HYmRPFQkE4g9DgRnmtXmKcl4SUvnJvxzt4SyFra1S?=
 =?us-ascii?Q?SNglqyEo9ADpozzZgOzslipde0bPgqFVA7OUL5NIQRx3fNCVW/9PyZOJBska?=
 =?us-ascii?Q?p9x9enfDWD29dz2t0y+o+DmdNTbTP0mtYWP4s546B0ULjDkDP6tEJ+FVoo8V?=
 =?us-ascii?Q?i57UR/jtxcyMCE551XmXDrZfRtLWPlRQnixnkfrPftVmoa2Etp/QgPDGQ3P0?=
 =?us-ascii?Q?9rv5FXqEcIxP73qAr7YTFzF35CgpVTaB2dllC1oqThjQFGjiIsur6bgy7XY1?=
 =?us-ascii?Q?DBvJ3v/wBgyLWZZlf0mt7n06A8z8hiRohQUZmz5EuscpsIgV47Ib749B/KHq?=
 =?us-ascii?Q?YXsRt7OPWi8QqB9zzVgubaUolIihpCto1LoXaxHlDZQ1K25aUaTy6LDkzdgH?=
 =?us-ascii?Q?Ml/miKcdp2ag7eXAiSpl8rrlxBlfXB36kfpUEQafcnb+SrAprGMKKCgOy4dE?=
 =?us-ascii?Q?g199pLwRA+7ros+wHuVt4dAgZHomzfccT4IAcjlDsGNqzFbbpO8NCjkposbi?=
 =?us-ascii?Q?teEQSaJb3NZHEpMLKgd1ptp8onKUwcVB0PUwImsU+9D0zyJwENeQ8/7+YBd+?=
 =?us-ascii?Q?2YmqyE+dPmXgrcIy3LNjA/8i76/RADs3fMro/0E3m1WXov1vlviFBk6DMZBh?=
 =?us-ascii?Q?hkFNj9ZtNmIT0LVzF5tMJC7sQWXl83oSUbqxASI6RMCq3XhyEuOf+5UBQAhW?=
 =?us-ascii?Q?3LYzwIT1lfmvp9CM+Aix5hpC55HWQ3vtl4C22932oDnulq9dFSoBMrP9G4LO?=
 =?us-ascii?Q?gMRNcHNEHnJoQ0h7HWz4dR6xanMye2HjM1CdljMfkE2JekbOgmmICdhpTJ/B?=
 =?us-ascii?Q?gQZeoK4tlQbOg470DSs1CDxVvkjmb6uiPUmUJx08nfx7cbYPATQwQVUpFGD/?=
 =?us-ascii?Q?ZIQqCl+dADGfxupcMj3XUyEJUEKV6WBN2e4eNPlobFfR/Hgj66dPkM83fQc/?=
 =?us-ascii?Q?Q7L/V7/IU1srguOVBt7giFHpb6udx2dQa6zDgeW0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5057ef51-9c45-4d5b-8ec4-08dbea77bc62
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:53:39.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/KPfsB2eyi8akuxIAweJ4oRqmMeBtG8yKjcB2OwQYCc2wvNAOUoLDDaT9S1I9ehS+DmhG0lV+ch5a3Yn+6lmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387

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


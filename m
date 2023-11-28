Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86175AB92
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GCT/zOgR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly1VmSR718vCGOg8+Uzfpzt5dRObhvzuiFbk3dt3t/dECsxAe64mSjOtTWuQ8HJBHUC8p/FS/x8KrPVQ7GuVwcWtgQWmIUNsSaquqnOhcuCf4fqr+nOp28X2veAt8q4aI3JtUJ5P+g1HhONOy6VESu+4FU/V6Ygvq8k5isSGo+fsjsxyxQ/7ixBdL1KTxBoZ8Z1ZkMEu65pKo/vGc+XGEiTiD0Sn9kEcbvkyPjOThcLJn9FtI0BhTV/aPbLdmwjsV5lADvoEWQsEKFqILF8I/I7Xx3euvPIOkH7Ge3rqGOegrHFXIZlitz4qzdW/TLctr6P2P3vXeMLWm0N80cBy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=XtnhdOPvXueG58U/HFE2Fh2pQpuvejfXxY20zgy3x7RCqRSy9dF31pAOvpHrzLPO1rvbI0xXSQgh5JJxV4YRsBFpe2shZKDO4OGJMs/pZ4486DMT76B2ziiGJGgLXs2fNJ6rqSYxeFfzxMV4o+HEOHmvNDFwJkkv+eBRjcgh7WPJwmeISsqgeYnbHtoLZSvTG3Ny4NRWUZ0YFD/gxlMbAeun/Gg+ZaVnG/UEx7OsuGMKR1tCdnljJhQUOjy2CJ6Fv+caV0iIa8C8VmC7HCRIB2ZE3u+G/aGnFb6wDrSvRmwnr59xuUSm9eQJDFF7xj8hHUdbuRFHovcKMxI9PlfVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=GCT/zOgRA5GYM1cwPxEBAPl/rZ6B2Nsvvhw53TtJJixroG2FcOabR7V7TSMmR7AKDvrZd44Q6FiHrsqh9Vb4Cju+MP77Y9tYDmYlVNmyCmyOM/1icVM0zoBJcN90xv+1JGe27enyWCOPMwe+ScMNTryWDCe5Ph9xEVwHooPczmK9oqivHUzaOh7xD6So9gcuX67kIsmWJa6dYNXTaAadRvfIDTnzv7RqgFQQxUKrDvTpNPANg+AUNPOMVgCiy0mbGslvAmXkxGW59glBJfwsIoh49lowzn5PpbLycEGoVaZUMjc4pLLGDGcWN9NWoS1Fr+MC6IyfFtoqtJeXejKilg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:22:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:22:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 02/32] mptcp: drop mptcp_pm_get_* helpers
Date: Tue, 28 Nov 2023 22:21:55 +0800
Message-Id: <da2dc80167b4d215df0353954781d6b463757ed0.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e698855-24d4-4df3-6aa0-08dbf01d6674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IlcWTp5lCddnO/t1Fil35KGkKc7JdWL3gtR71nb7ie57xIZdmkUWfQC0Wld7mACIA9bbEUYMUEULp9yTcsRy6XWZ47EFFRxkA5CxrHk6lWEYdbU8xlsUd7pF7dxsDcq9LPp2gm2kCVLYONPV33UpilgQDQEYb78DTdkoloenaYskcNZL862WAcezu2YRPqf/nI66lCZZjWmEzcWqWZazQi9U2M72WwmkfphflFTjP0poBXC1E86WH54+MDBRCra5vouvjOF8rdd67NUFpdmkYyrFLGTmXBPSmNFD9e71g8TT1oFnQY9JtXMR25dCqpXbEY/Xn92uQMSkfeGoiyG2s0MHBZv4pjeQTl/os3E1dPH5M4DF8RbQk4vEBrGhouf6R55tNjlvEbgYyC+4Ij6kcWmD/ruVy+j6VgVnDMwdYPM8veDLB7xz6++b2TxS67V6aqbNbvTF8TSLlF6j/QJRchGIlpKuXtvQJ20nD62HtfFakuFt9cmCGfAfxWL2ojUTlyi6t+V2Fa3CzTskGLNZW8vX02FvtYSvSWrvIvOAIHu6flo2mpxLQnnQIpwmlEYRmyYB8P9z3IPly6fw6Z18ZuH7BF4/sxrFjqNtaLqcXG7/Mm/XjNqA2azLZCrRiltk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6666004)(6512007)(83380400001)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?70lYGNdC0OrKsmdjlFdEr14GycM4J7mXTIv59IipjZ7dq8ftwNshs0DlSF09?=
 =?us-ascii?Q?m7oaA/Vq/SnTb3MGdSkDrWCoymdra7DQQWvBhx2YRzFK5s/glNc13e0zJR18?=
 =?us-ascii?Q?H+Tq+XMfOPxDrfW/vmLRqTBGeKn748A4iXbVI5ImETmxR14yE33oQWKCo6Zn?=
 =?us-ascii?Q?fK85nyHrLPGpxjvlW/wtrTDq4cu3yi4jkVcMgaIufXME3h/Uaq2B/VoMvI43?=
 =?us-ascii?Q?KR1d/+nCmUm97nSMkVTxgOT6MCDEUtg828VRktZ1b1CaTHMPooIslsCZ2UnE?=
 =?us-ascii?Q?7DJSJfnKqD4VKE/7do91FNeTOPofRdUP4b6epZxBBxiTZUK0UIUj9wcUXpY+?=
 =?us-ascii?Q?RB9+nZ9IbLrdMKAAimegjVFvSzAcgIaAr3OoRVaoJxQF+xJu7uaaoZIGnR3G?=
 =?us-ascii?Q?IPfT+CqzPczuXRCIPFPy+vaWC47Mb6zXzjf5XmlXLJoO6ZR4pr0Nh76cAGzd?=
 =?us-ascii?Q?cJZMf9U1qxSvm2IBxbNTPM1b0NrBuhbAuZe7FuzEozMoOWm9sLWrXcviZAZo?=
 =?us-ascii?Q?WqfM+hf3bzi0NDHt307jFL8QIu1Jrki4Oaa2M1P/flnWfjiz9TUOhmPoqpxd?=
 =?us-ascii?Q?XXcgfZ/Cqzw0SMuKkICJRAqX0IpbKPJA8OD3PUQrsaHPim/n3UKlye3kvsU6?=
 =?us-ascii?Q?I27gz02F6lhogZYsI6HRQepDtMH+a1mZr/seni7e8bnb2hBC5QP/OpANkRaJ?=
 =?us-ascii?Q?lyBLfLQ+UAyx9dXO5+lp1A5z9m1Qyk0otYRB6vj593Lquqo02cGibIX4eeRZ?=
 =?us-ascii?Q?mLXBBr8OU91G9xyq5L22cviumrdRtD7DokOp6HjoTuvUpIhSaHDAkff9L4dp?=
 =?us-ascii?Q?Q9cDmq2aQg0O+c6EGDPZqlLREqD5V8YLlNlPrtdWub2EJXGFzrrEoaNH7AR2?=
 =?us-ascii?Q?Q9oelO+ERJE+3MsyjnxwxA7/J2EE+w3obf8J2QJ37fdtAk7+upI6E4VLK++J?=
 =?us-ascii?Q?Vog9WlPKvPpunZoU80h1pk6cdQOpOOMrYamSwSDYzaS3pXsb+BEvjTeComyO?=
 =?us-ascii?Q?T6we1EaoVGmj5lNZ3w6ul7U2PjPWihA4GKQOO9IUvfhIktmCQtdnzCkyI2sS?=
 =?us-ascii?Q?8//4KguMmOg0Y9QjWB4RTylc+GyNbiYqHCKlfBy2hytHk1FRAondpxcJJb19?=
 =?us-ascii?Q?L7nZ2yYhqhjdtout89U0QX9w1P+j68UWreOG6GkkmidBFOIAfeLgaAqVVsjv?=
 =?us-ascii?Q?niBEaurpRujQU0On2hIpfvTowKwGxS5NtizBKsYdLht776EcQ0NzLm5XOlbL?=
 =?us-ascii?Q?wYZn3ZZOiJaKnsdCR1Waqgs2lplgyrLknSfBWIU49+1T2WHB669NFMw/SGhl?=
 =?us-ascii?Q?/HUqKRCanGqDsZxrw7l9mHSbuCeF4JdFEwVhzya805uRYnYOAgHXuOm8H0vO?=
 =?us-ascii?Q?fQhDYDOF/X/VvLEVaQVy2R3Uc9rizMsyypvsfrHNjYR8j4nGmSbvwBzXvRdF?=
 =?us-ascii?Q?WsOi1kt3ymIubUpM+GogRMWbjauBc7PGJ2liy8mOlZckq5HT/POM1tuW4K1N?=
 =?us-ascii?Q?YtYfIKf9icZQzAkEaU1/7W2xKFiJU67hk1fseNsOKOIhDFWa12wNrMAhUHAt?=
 =?us-ascii?Q?2ZjqRafxlBQ7A+77NMBb776WvMhReXD0iCT8fdxL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e698855-24d4-4df3-6aa0-08dbf01d6674
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:22:06.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctqzk8xpFRx60l9J3Jze2OuLaeob1eLT0lP2uMgBuU4IUm2XDo9PJ4OpSqLV8e/jHddGYQ25bQ5QsHP5/C1hcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

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


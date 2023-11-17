Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA3D263
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5ErHc+86"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS5hmAslFH/LmJ0M+zVOu/fixLzFaSV00z0IfRIvNAVyDosEs39BHBYxLCxbVJAixaDtHAicki+/SZLYjzmtyClUQC0tA9+P5niGdggdQYWJ2M5vXlcCPC1r3ljQkM9HRdTslrnIuRkV+BSLIycwefm8QY1NsYuafayanohsOKsCCsGgNr+T/kIfehvFKRzfm+4fleYWh54+wnGBh8u+G1paUkaUy2pOm5LvCjFg659Jkmb0igrQ8WSP6Dx7vTv36GAiOebXf2r8n4GN/DBYj9U698U3zMsjV7isZuQCY4kIIim6blHXV2boSmUpGRUcnhN1aI2dC9dxojp0eAnLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=WitH059Z3q3Y7k8dRKonekippIb02tZ9rk2hzuCYbiTAI9OS0ZNil4JhtAjRKED6GTDwrWt/p7VZghAgH2DBfZHR8qWLx1IuTrN53y64Ym7yrDW//9CY7D0Twvze3KAENgphR2JRcfN24pocaaAS7VlLIA38ZLOO/yqRi6rey981reBikykobEhkHqmoFpR+d19YoAK3ASwWMhETV9+buI31BIVGnZ9/HJ/kVU0xmqc6cUwvLWrhs0Skb3YCbEXQPipCXjR21R+s8npMetNwUyfd8p/NqyAE6cY1RRF1X8jBQgbdNUxjFd0QwEIXIxnFXAWJ9pKB3uNggfUJHoGIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=5ErHc+86kj27UUmgWk1dKrAO/tiaUIsXMlR6iHRjiTn0IDV1Nlvs63sOxkagf8zYn+qZseLdpjIqf+6YMYQtqmJWcB7+CE6etFQpS9Vl4dMGtLP+1k/JXfZxZbiSrlXsa7m2uJRqlv0nXDOp0xD/4vXweuOp7+IzotZw9QwhjEciaEl1pgw25cWpvxj3JGs6pjw7j5PGrELItDkQh/3WDLtU+bUmhxu33HAxDf79cCoGfOhbzPCJ3TDE7i1WstVLzAjNYu+3VZSEKjMHmn8hn/1tvKK+jbT8Poe8RDMqp4/Lpt1Gkp4bKYoIEL8dMzeqCzlEOO0uPHyYK42NUUUmEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 08:56:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:56:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 02/26] mptcp: drop mptcp_pm_get_* helpers
Date: Fri, 17 Nov 2023 16:55:55 +0800
Message-Id: <0ba0d869a503945f0ffb020f839da8a49d8794ed.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0020.apcprd06.prod.outlook.com
 (2603:1096:404:42::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f7ec50-cfac-4aa7-a62a-08dbe74b1156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HWd/OpTSXliEjFo7LAUUeCStaADKu8b0Vzim2dGcbSEw6WKlfX6d0FzEn2kXlM02kzttWQFbspo5g4F8H9AFJ1zjNcFFdBAMGQ2JaesMVVvH4BlJ5tTVWKtk1Lh3uVPyEsWWhlM91bdeQ7+YPXMLLyVfFoN9ythe9F3dqbPQ6Y3dMtahyf+r7xmHbc9fi9l8+FHpStJVE/8WxaYkt102lbwhVBbwOFHt7BijMMyyAadpxGAgFuK7LotdGcWWxSa+KlWQWCGwkepQYK9fMm6CqysS+0dLmr3McWjvRNEoRPqlF3F6CJpWhXRj3BH3vlGgUgm1mXILWfsNuKP1k6VxwiJPC579NbyVhPniUZK/w1jr4KjlT1qrAmqSmg285Ep59+j38N8a8Cu7hOZx0ywwV47X/tHpQv0F06d/KrnE1W2LRiImdb0P6TrBvthGzmmok8Ag88v+cBHUTBlCTAr2ZITpCtmAqJMSKlOup9gzx/HBvZDFnl/Kv6LQqyGJQlFz/pbY7ll2shnVooYXmsp2/G5sYQoO+TXh5XQs4q5NhS8uKstSjG3O0kSZOh+FUmRvZSH/PESl/aEKfA8ZDcBPEOw9zvR4zjj1wy/IS+kbHUU8WHmJG9gmOeC1Alrv++mF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(107886003)(2616005)(6512007)(6486002)(478600001)(6506007)(6666004)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(41300700001)(83380400001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/JmKVudCBdqVjQBAGKGx3LX5ETt3o3iBcF19/92ql3rRv+nJRrjsDviZTJA?=
 =?us-ascii?Q?6+Wtvepp/PEgv+EriprRVqh3pM4lQ9M6ajZSJUxYrptdyuY0PaWPvihPHUnx?=
 =?us-ascii?Q?va+tMrfnA6yo2NvyhJh/4YZOGF2vawKjA5PoroO6ZR1dui4gw0edsuG5oj4u?=
 =?us-ascii?Q?yg/72FpcZo0IIDx8qyv7Z0zl6X9j//pLML9Qy36Sdb3mihrY46u7FH9ClHoq?=
 =?us-ascii?Q?vNWzwZPRemCWJw7jzfNdREa5bY6Jw7GpBt8la69rxhl4MU8rTd87OmGSTCEr?=
 =?us-ascii?Q?Tyw7PHM5PJb+IxaCNymWlNOWi9XutzLmzrw03IywBVFYfJq1lCZ7RoWRz/+F?=
 =?us-ascii?Q?m6ci39/SQb1IdiG4ffq8M+bdxmcQBUOrYHkSV5h0FsEvFQpQSWZvXBT3A/fv?=
 =?us-ascii?Q?u6GCD/tgrWiHXZPubZfzbdnD+aRHS899xlAI40IGpddc3pI6GKRB59sBigvY?=
 =?us-ascii?Q?Ceyl1Awa/49N1Uf5O+zV5hZeZ1Fjt8BksY5OGOFkni5zml9A8tRf0hzfBRRI?=
 =?us-ascii?Q?VA9G7YCWupfstSyXXVCzi0KTtzold6j3LPFZUXkRTnkbo35xUMpWDrOL1X9m?=
 =?us-ascii?Q?xtAo7L6+zWuuuD+UEAinpcxcF8p3Q3JsN9r49NUkr5xdLL2iMFa6yn8GXLgi?=
 =?us-ascii?Q?6lt19bZcDfhlpMLsMFTDdgOSPWDXl6Aj7pYOa0xao0+FXh7rnrp9YLNVHcC7?=
 =?us-ascii?Q?Otw7HosKUefTJscaO5NQUsUEyqp6y3c4wooNJvkolNMDwQ+pJdrKCcbkJ8T2?=
 =?us-ascii?Q?tbOA62JMeogkHOgHOKtRWFq+DWf2Ri1ote3E9YIBtQIHbFnUkd7dbYL+7NMJ?=
 =?us-ascii?Q?i15Zv+mQsftsCGA2QvEIij0dw0miaz2P7GE1+4u9OP7fipP0vh0wSfC39bLf?=
 =?us-ascii?Q?BNGlfoI6gvsy9+gBJsAwHmM3zdCLGtrnWLQob/hREpxBi3t5JFEDoSQ/2G15?=
 =?us-ascii?Q?NEzp1KjlEwNcN2tf/IsLvDQW/lMJtIR2rjR7G15lthC8s6yOYRdoJ6DZCiW9?=
 =?us-ascii?Q?ke20BUGWoDHxK4pxmSqfKoHMqg6BUDZKBBSlCohueb0iFABQlMnmeFhlts9S?=
 =?us-ascii?Q?nU90GZF4O7hmGyXd4sEfNo1XKHlDset25LH48BcfnHNfDjJXhhoJigh6bvcc?=
 =?us-ascii?Q?p979Vcsc6Au9XuSNu4FSv9suUO8C+mm1T+cvDRRp16UEQQOAD9njlwVzxK1u?=
 =?us-ascii?Q?X5H9tOOKOJBFPRRdAjQcPIA4ojRVR9owaYzfgGfqNuXLBFr4HV8OJMpry3Zs?=
 =?us-ascii?Q?KejjkWLU+oMY58KaHevjLfK+8pDhNRmtvIQyvzQBjZPAcdzpiH8gUxPVEKEJ?=
 =?us-ascii?Q?JEJS8QE8X7YTvVAqSWtF6tJlNIdfrBV9FoGFBGhf0WdH1mKdyApW7NWGh20L?=
 =?us-ascii?Q?hrZM3ND+6kI6hF47FNbBu9yqPwtmhyeXSa9EPFs2aJ7YnHv9EViE574jNa+h?=
 =?us-ascii?Q?xcJhmUJTZGdXdN5ArOkBJ6RkCroZJ3vvUa4xVtwWHy3gIiXQCMhR6WgUmlbt?=
 =?us-ascii?Q?2DZgVmp/CInwCyDAg4RlYzo42cc/JCXDEAq9kPGXjl8dM6UJGpKMYzCi9JEd?=
 =?us-ascii?Q?Adz7/+7NTUrW37hOEL4kyAYp8X1Ug9fzx6FXk+8z?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f7ec50-cfac-4aa7-a62a-08dbe74b1156
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:56:21.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DEmJmFCJvPY91LjrWOA31HnxagP3MtsH1Y1kUrhl5YnLXYHQ3ydUe3Hj3EjtcndFKJ1pse/pzbXn4/P+danYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

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


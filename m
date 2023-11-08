Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259E1FBA
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PWQwV6Zo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ9Wyx4LbdxrRFAyHh8aTBzLeO+LExkzRts5oqkZizX/643ynQxQ2GVi4N5kLnRi/AThMnwpw5gO27zwfGXvY1JBYgoJNIr1hFo1vVw4MBNe/xRY4Xh0EhhXMDHLTkbS3S3Sq6H8e3YwnxsNIzBvnXjio1gQFiN3le7NIPdnClNb2C/HL6LkBQ8H4AXq7AE3p2r+osL81PhkDIZdz/uVn8ODksEqqZ738xBV/3v0nmYcZNRCK4XvIu91pbC1ah8RYehY8qnHzb+d2jkWeoG6pu2R9rnUhu3yJWBGoE9cK65Ky+JsDJy9vIaEKWPmV1LUm2Tl1kxiEfAFVNfbWAA8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw9ZkQ7Xck8HEfDIVhXW7Ml25h8Yy4lGHfnF8ES+7io=;
 b=WmL1mxW6MpNcmQW29VoFmuU2lHTTlkUNSxmrB9YGs4WacTTt6SyYNbIVGz271BplxidIjncsEBUs8lYiuJ3zy81qlDRF3BJHS0BqElFJj2/nuzuXsvb5uG+7lBpU8d9cPclSkbODc0H2x8uvUk7OqmJ88nGL6Pl8fLYhEghwcMN2QwaYASLKeYjLtwasSfcK9pRj6WPb5CY/DEjNYnW3sjmLWkrIA71pEWHOjmc+Klz/lj36gJHDepi5oApNl5t+03vRe2yaXh+moZWpvLCQuGQ69jTGgdbrk+PdRgtDIAYml0jcbAwddFM4q6n0IrU1mmtL6w8PLul9LkDJUEnm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw9ZkQ7Xck8HEfDIVhXW7Ml25h8Yy4lGHfnF8ES+7io=;
 b=PWQwV6Zo5kNTl5h6hl3ybwdSsZHbnf5WmD1bkaGC6mNwsM5ymbH/6nnqLRg4LwB8A8FaEPNQDw/gnsjMoqXcJNUBYTwz5tSGhFj1fQKgjGIJi2J46DtbovSkWVHFpYVlm6Ra1GnIypV/SBiX7vgEwuvcWzkvQz4B6nIkRuDKXH5Hqvnhskl7fdoAy908YYo3CEjiE8zH2RTaxWw3GfCLtiL8E58Hpq4nZistm7mCQNQwGXdt3ieXRA+x7pR9P3qua/gPNT8//r0RcQFHJ+TUTJ20HqDIRDQs7pRvwA0rCODhNJFOvs4jyyrhjEurjQidg3ltKsn/VmOWZSMGOn1M8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 02/22] mptcp: drop mptcp_pm_get_* helpers
Date: Wed,  8 Nov 2023 14:49:32 +0800
Message-Id: <b618572e1ca8bf050a63f053fdb6e12b87497d4b.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: be1910d0-7a81-4003-0eba-08dbe026f217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mBhK2/03/EdE+laV+YcuFlBXelXHKxxdoyfXRRkF7yYmUPMoDzQeqIj2VYc0PeQGEFI5bfhXx6yBM1UMcNP70YrB4jKczhH0s/PP2JLE5zRKPsZrHMonglnjg/zKYwzuEo/kaqWxp9linZ6F/3aUH340edFXaNjaNO/i9Xvd9/La5dbSAdR3SC+hFBLvSxxtylXTjHk+27c4kFDkwBjgJJsxPspXFRdiwaEFjcTD3auV3kKCHv4YvAKsNWL7tf6OleGmDwQ+w7MYmBvm0wbzcLpbWmG4AF7/eu2FW1AryRuqiNPyB+RwX7VWUP0SCJaUTxhrgXsU9gxOICylEiYnT7CFZc4CJ4gtjE3/fl4nVXNoMC2tuONAN8liMgwEmn32S3bVq6PbD8H1DbQcv6BntTALYoKucBduZKI30Umr0FVRcbiSHSWwwQ0IWeJXfyyG2MqARZ30cjGvlp6uUZiFMI6jgRtbH0MwCtGmNpsQA782Tflr2iGgxRBL+7Qz/LiyPh2J3azPKbQzMoJbFTp/ESn8PRqcqhDuy1xat80/+BZAaWHvMuVO+X/U6g0I44ieP433n9RE6H7GU6xcPbYkKl/C02LlAUB8npbV1Cp968VCYPG/18VLX2xLJcbEpG2bb1FSUDTZWFftEM+U6KsuUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0k5RlH2SFaw+Gwg0IXnC6V5qKLSCWaL69vys+QTrcSm+EOPiA2vucgc8La9m?=
 =?us-ascii?Q?aA6flYJr8MkMnQmuqo6DyJqao9AFdtfG4YaQvY6AqHbkQ0gQm2uD8AKyUS/K?=
 =?us-ascii?Q?J9Knb02Eq3/Z/wuxGJlGJsSzb+F8pQAI5PBlsoN9GVzPtGY5WZ9SkfbvOzlI?=
 =?us-ascii?Q?1/IXry59DSmQzrjZX/eI8Y5DDtBkIPZkJ4CAj8LQZI80v4Gm3MjQV54fkCu8?=
 =?us-ascii?Q?MMuTfJer2ZFsMwswlEYJMxROPR0h3//XiWEHbJUSmQoQDAQBAWBJ7wZ7H2vb?=
 =?us-ascii?Q?cBNb56JRuynxNuur9853Amg13w9Sh5ADbV3/+OZ2I7eWj1w8+9tlml1k3Bg5?=
 =?us-ascii?Q?AZ/9iuV507sxz1zawzo7JO5DNLlGGO7PwPzEuJeKoWbqoZ1zm2lLdbutHrsu?=
 =?us-ascii?Q?Oi1oUxa0gbxplheRntWBJQXeraHikY7BtY3fR61PNe5gGN1u7Rh05wIDBC7S?=
 =?us-ascii?Q?p2X6el8I9AFinhxoN10EvfPUKsXCYgWih646eW85igw2WHLXkzb9WqSvuVOM?=
 =?us-ascii?Q?KTwBtsNGG2torvj3lL/0Ti02XUWLHqx7MkNEAavVPVPTx82A3+v77TbsZwhm?=
 =?us-ascii?Q?O/huaaEXrUv5yqgGhAoNB3lSxFAmI0jb0bkLD/8//n/EnFrnd34Itxr3JMc2?=
 =?us-ascii?Q?jOhR4DjyOE12b+Ua5j5gS3fpDZgAmL6z9dI5PjwmYKIEy6wOBII8VaTtpAM7?=
 =?us-ascii?Q?MrRXD+/esOYc7EEGm7OnNGgvEdNcTrzeIC25VSlooXAjqyR1HBVd4Ht0fFvH?=
 =?us-ascii?Q?pDF1nSuM1Xyz7f+sYuYIXZcjly5eRvcHLxzulDDjVwZ5uQHQbtjji39PDHO4?=
 =?us-ascii?Q?fUuXOU13UWeKqnd5TNXLJZGk4XQuPdIK7sLYSzUivEYSAu9PlUFyUkt6T9Fc?=
 =?us-ascii?Q?tTdrwOHaqezJIjCO2px0p+s5zHykH/HjvO/xrU7jiUzZkhPMFo3tsALiKGek?=
 =?us-ascii?Q?ypbUE/o1Qge4Rplx8P5wzz4+3WxVHdUp2A0F9ohOwL5GB61m6WzUa2SH6/Xp?=
 =?us-ascii?Q?a4T0aYcrTBBBEle5uAKVYSLFO3eylPhGvo4Pj9pggeNac9WenvrruCeKWLdT?=
 =?us-ascii?Q?fHQwQaRLqJGh6nb0CQsOiwneW4xgphyBLJNHzqepxqnEIxh+HnlYoPTs+r6m?=
 =?us-ascii?Q?YLLPzKHCTCCcPuqnpmHobcYgss9DO8vJYiZO9ZqBdZKZqcL72yKXpX9Z5XTx?=
 =?us-ascii?Q?79qWdauj9KjnNmocRlt6NFlr6sLTGKgZB7jb1QAnSNkqQG7lBc73K9iwDUFu?=
 =?us-ascii?Q?+F19Pwjxlmz73KinoiTte8j7c59vdr8VRPrtdYe+SUm3DycMuQU6b+/IPw18?=
 =?us-ascii?Q?YI5dbq31eiD9vjPkOB2QkypkdgysyKK+8xfDgDntF1PD/Hae1XOoEDbb6KiH?=
 =?us-ascii?Q?60fdpW7T4nArWcrHJMp+1VbDUcg1DWRXJLY8fygxRE7KogVRiJH+LPEQM3hj?=
 =?us-ascii?Q?0YwButAndOHUA/lJzlSKGgHtNP/BVGJwBCPhE05EQ3GYhe0X2iJ48DWixued?=
 =?us-ascii?Q?DU6Og4RB1Z8nsVFW7cGM8Yv5yQeO+5t20/ADm7WSbd4fcL0XjR6hmwiWCvak?=
 =?us-ascii?Q?1lwacceQkA3/SXmCs3mwGmwDtLxPnyt1poxVBd88TqiRx9Ux13PwcnM4AMJ1?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1910d0-7a81-4003-0eba-08dbe026f217
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:08.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDYaQhl34GL+8M4Jly4kAhHOrxq4sE2z5wiNknCn2A9o45M+NBq3ZImibrok/qzmh/j+NF89MYD2CE6rnKBdeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

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


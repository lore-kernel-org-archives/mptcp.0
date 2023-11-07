Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE681FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EEA6K0od"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yfz6mo7qIUGAZyguElW2MSWJWkcutM9IuThV1mlUEKxKQrzJ7adguMVPWcVR/ZkQB9xp6bAlVdPZ7KIwejxsbIDWPMqq6sx/ydpE0DbZ7NZqy+MHI4Ds6I/GkgePfOJhN5ZBtGIIooadk1ohGuXoT9SMV0Gmy7WHjVyMYr82msWRtN3A4bRb1565rP8dzj6Iy81Eo7aDaGjLWVJ/YcitHPrNut/LBTfNd1TmDpOfomswHbjecgWaUDWpL1Nj5hFTiEIYyoBxWOjwV/0DK4UAB9Wi1Zzyqu2zB44P8IFtu7cWl/TGi7CcUocCIaFB8X0fCVipU43f/qEC9m8nXjHnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw9ZkQ7Xck8HEfDIVhXW7Ml25h8Yy4lGHfnF8ES+7io=;
 b=XTGw61/cK5MTy2xWkGqMoqKK+izRBGe20Nw7eWicdfBXb/Zj1W0MRV6VzHWWPEdl3eLuk4ipMflVVfEX2ymOrEfKK7jTNYRr10gS4xVRW7q020mkbwGR19DNsJw0r76wc6ipX+Et+dL5UkCocwhIPdEX8+jVoYzfT9OMlNDVf4SIJVVxjjAagkT2J5JrIgXajA+3yprlYyjml2P4vQkiDgkhgPp+KlMWgNyg5XoBc7lPZmo8QNzSOQ8mvics8c1XgQENnFkZXDv6wdkrylgSsH+M6W81pkvnDs7o1IzNqHS1iACB8RMcld9s65yfGrShGd03TxJamD+6+OC+VzDROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw9ZkQ7Xck8HEfDIVhXW7Ml25h8Yy4lGHfnF8ES+7io=;
 b=EEA6K0od777mhcPxj9KW9V7wVDcomcfc5nYs7DiRm1pD8kAjaRlHWhSxdnBKyvfPN5bVJ2BkSc/4zCKtdsct6jiYfZH7sgymoYVxOrDP43InAM5O6eqDSvwk3GIRsyAXqaUiqCzBZ22YlKqVMc5hIfnZIEKTJO6PI8yI6Fk2qSqUZGbYYrlPB/1wOIpTa2za8OwECa6TM0GDTOJR1QZe2WbF8cmvn4HWfXCXKWnYTf/lNTBAQOZkq3IsUCA3I4sBDcJ0bHB0BQASy7LUIsFhsGHksmH9sNoB0tS7CgVxJl8a6OCgA+6BVj5x/3auXqWCH6bJL26+VK0tJiSG69U/2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:02:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:02:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 02/21] mptcp: drop mptcp_pm_get_* helpers
Date: Tue,  7 Nov 2023 14:01:46 +0800
Message-Id: <bf80430f81c30e7a541f8563f0a0e8bc0fbbe3de.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0165.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: cd038dc6-f086-4369-1a88-08dbdf57196c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e3tvykgkR59KKLY5XukCCwv92IPfRZ0HHbHQ+eDN8hjbwKLY9n5JNOGZUpQIJL2YN5tXQqTo+VfkyH2dVyExj1lW9ANkppH1IUaTHPAHsi492L0vDG4ka6JOC7Nt7PRwqd6jlbLyHCq2ogPV1SoC4QOids1Pc8lmxRCiA9Z1Lgq03M2o94d9huU+kKC38LMC7CrwIBTxW0Hb6eHF9GA/U65VZaUAk94QSNzJdM6eZynkCCXI0sCEQLwVthceVYWeJ1jhi6xzHp8idC1mJs7YBk+DavkZRlsCGngSRSAYYsywlxVAZlD2zTrCXElenZZ4NxQa+437GmlV4F/eP4LAtR6d3cl23B5jh/vmjhxGP2JoaML/4V7jR0ocG3+dBVjtIC0hIA75LJv2L9va+Utcqon40INtie0Ba1fWV1Mj9l8q46uWRNSsDRFQIHvAcu4G1y8uIrkARqhCgiVE1jdlCAGuDvuNY04IiAo089OV4ZIVr8+7I8Xi8n2HuC7jkW237Yyqhzj3Zea2kFHaw7oN2zeEsr7RL5Q0e62joVidGrAkc4/2mMMkBfEN4XfX4vJ5ij8e/BEi1H7E2LnYC2qgvc9qO+RNsqT/aTU/JDqYJha6wlz8kb4zbxloyH0yTiUy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wqUDCRDwVSo0FfYuJuFtwwXEv2YCM8EEkq3OZTjZxhKmOj2UoSs8Tqzqw2A?=
 =?us-ascii?Q?7lph2Jt9H1hElnx0T7l8tRm8fZbh45Kr0wvMjkSUR/KUHR41pBHPBIuC3/+J?=
 =?us-ascii?Q?5D3oHwhgwCXnOU3gP2PKmdTCgOA2XblszTXyki2qutG/na2ntCX4zCVZbdCU?=
 =?us-ascii?Q?eP5Krt0Fdv556i/JWTqWNEKbqLt9nY2LVzEPHtBwam49rHEuE8lf7xT2P4Dr?=
 =?us-ascii?Q?N2MosbIW19RDUba4DdbeMSa9jf9FOY/NWqBwDTK2X8jjEGJkLFBXc1txqGH0?=
 =?us-ascii?Q?zUbY4geJ7IkdXCsaJKGTJydC88zcUAFDEftwE7Le97kWYR8eFXdrexFNJryF?=
 =?us-ascii?Q?wyqxk0XfeNgRk40m3KrXws2n7BTaBMuzCeAgI6SOofpVPryLy8CbdMtU/6q8?=
 =?us-ascii?Q?jHnB3HHQAUxsXOoHIk8nZvfuZdql3TmYMxOMUOH0dQcFpwSHtVFH2LJPLJtc?=
 =?us-ascii?Q?AV/mizM6i7lFJBkU5oGESBtv+dEnIiMUlPVcIpKFLE5k5//w/8UNaV4TSVRL?=
 =?us-ascii?Q?fhrJv7gjrZJ3EK1tkqjwwBbCsJ+usnRPliyeYBRmSbkKu6ZX0z5XJ4ZfiINq?=
 =?us-ascii?Q?gvZJjig3eYSG0H+Y1DkXYbKpuKO++cfnNUHwA8V30uDbT9ZaLZkoKwwsHckY?=
 =?us-ascii?Q?C24C+2iM7dHBoOESD/jdoZZD5a6aW+zAEGOhGi+3lpIbN4TN/FOxnRG0Pdns?=
 =?us-ascii?Q?t5OAVuJjvxMRYizUBNN1mGDNyityn4oGgnJha00EkhZrLWfGuaRL9GGFntaa?=
 =?us-ascii?Q?ry1cLxAvHe5QB5dlZwyldi3JdbAlXQ/jdpkoyLUYTKb/gGcMUSXhngX70Z63?=
 =?us-ascii?Q?difm8/FIIbD61UtQWAsjk+++Gd9YLL4qAvLWL4036g8gLPNgMOX7d92li5Wr?=
 =?us-ascii?Q?BRyml/zRCxv5F5Dh3ow/PDmFEl106YKaK7mDNRSZrwMvLgYpk4F/horRhtPh?=
 =?us-ascii?Q?FIn3bypXRnabiisIE4c1tDNnA73yFYcLNvKtst3zYKnKZEkpgppiluxIAz8z?=
 =?us-ascii?Q?1xWY9W91acxV/+8MzlRlwpAXhjC+Zd4t/MTD/gMK6aWw9jB10yg5bIxzHBTk?=
 =?us-ascii?Q?syAtNXbn8tvtCi5qgmleFrCjl8kBh4hLS2atWqJ1zOI6bpwHVwc+0a/KlSxH?=
 =?us-ascii?Q?J6aTbwmGfEKSHp6imChTX1TTeQiqvHHrjq92s/7PZyJI8xmyXN0uqqEVGGeH?=
 =?us-ascii?Q?+LMzB02NFw3AJN+mornC8AiLbB9wSalpJK3D82EBd8MU6Ba97F4WUwONGSP/?=
 =?us-ascii?Q?a56sskVYu8cGTwUGlANEfPuL/rTvjIf+NGU1JMySp6otqJl0Uma0bIZWMFIn?=
 =?us-ascii?Q?+hbuqUMEy4Y9n4qg2sxPsepdYZR3F9YaIDpVMnSYp8ty2WtBDaE7IUNli2tf?=
 =?us-ascii?Q?u7YCyUeSQeQaI0djHa/66Wj1SUQFFZ2h8tg3BwKyoMCnp2pSdrko6UFSEgm4?=
 =?us-ascii?Q?2r9esa1ER5DCY/NIQy3zElzIbFAwg9/PGTSlyLVwK3mVSdySCGvzIaA2y4Dr?=
 =?us-ascii?Q?UvcxAQVvs73RM3m/AZJcSLMjRdEaOMNLxnRxuRkB7IDYBG4y0hTlAd7i5Urj?=
 =?us-ascii?Q?nwTQ0TdZBZb4Dok3jFlGwpQT4H4A1jEi8ODd2glR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd038dc6-f086-4369-1a88-08dbdf57196c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:02:18.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AflzHtFLSWYP031r+Bkqq5bUmekH3NGQoM/F+AtBV+VLDXhpD6d/6xNjZvWjnRMMzkbTWW2GEqhCmSgI5zICrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

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


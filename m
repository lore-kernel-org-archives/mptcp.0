Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC87F51D
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="byO047YE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXQZghKWlfTQhy0cVbGRfSrzOm9usUkW7LQoYzuMd6+Yp22A7XlldoMTUoSlKEWMzjwY9ZwiYvT+2EuVLSEEplsbbJFlCVy0PlF58cVgt6W3VYu6eEEl/nv2rXTL8VbQFcyhdZFNKQtC0sy5x7aHsTFktzmWK3ofbYUjbbDEGDb8P8dNfyQ/9gWitm6Hh3L3mI/XbG/Og6RaMbj64bp1KKmi+MlD9ZdVDZMbuOdDtfeye73ol/bnS3/dSexrxK7PY43BFX3PuJ6MJkha6/M1Rb3pjxXkylRVR3kXUSRCCGwzLD1HQb66ZkjkSfIw/z689UfNmW3LSNzbzGChXpFMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=A4OJ+xw6djmFM0iAe0aidkaAe2BvXkz1OZ6HVxxCdTqB5jiVFirAsqOZCRJeEx+pV8OYtbQJ9FTzArMns3GHZcAJ9KAhvYt15YSJuyVmJzfUjZqkG+/mvmhO32rhBDc8VuvhxWCEOOuxTLRkS9o4WGuesXUWNzLMaH3p63QPtKhX6zXWh1ENNryQ+5YsQyQUWghbocen1qIOjCZKL/T88yXBwM0ISvHTUZ7V0GgJYL2admbwRhVWpqFXr6HouFuxwbaQcPCQYmTs9Z2YNstpQiCIplVlyxg22lCOuDlFfVAttJTkTa9Rlf4N7p4Ucb2Byvpt3w3QK4ZAs7yN+/PU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=byO047YEotX5oeh+XDchBPKy8oQPrae9DBOU688Z100Fjd3ViiCutSGy6M2t6AkW3/ROA8ydVwlUQSAfQ2ian0K9anpr6m8QFEpOeGC2mqzsS97L/1sNtUXZLcMQhnmG00i/yPIkdYTYfVRY73pZ3bMei7HFfDfxhr5C++ECMTCAJPASU1+zHQF7R0RilV9yFxmIOAMy1Ir0AjDbJZr6beragkRGi1/CjaLLkiYS7EX+th6KjdIegcDA3JDY2Qm7Mj462dGXKc5lPt+PZVMglNxsPOp8MWDbHziAoQ8YrWzyF6THKVLEVf0za5nHI7780eWB4IJ5U9PU1VlSMd5knQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:28:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:28:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 02/27] mptcp: drop mptcp_pm_get_* helpers
Date: Sat, 18 Nov 2023 22:28:17 +0800
Message-Id: <6678242df78c082a02667e24b8be813bdee28906.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:404:a6::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae2b585-48a3-45c1-3a24-08dbe842b295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CtjYNwt8o752ifGCBK0obQa8IYNBARujXwrRR6DXQpThYc2nXKXmxbd/CF4XMmDqH8X4NJHzCUEV1zMBAwDGf5qU/r7kg96jNJmHwcdE2vWdYfMuMValpU92ag0ahH4mOU8uUWMW1RIM5cDuNfBad4U8QRZOCPAoH79lSU+NUv7Zp53SDxUuf+mLBtDJ7RJk2JgjTOgybDv5l2alghHA8tq1WjOQ3IoeZPifjqXB45dOH3JjdeQlh9HN11V5XKDw8Bt8ZdmRZUwtCl8R7w8htRadXcgHTQ4sRrWR7clQe1nEY62Dl6aEGviphIQz+CVlsXjAfQ/A+i3uvV3qUWFgiEeaBmLP1VKPQMOJzn4VsdhnTGe2HHuToUHZjyZonvpEUW1sjWBkSoGb0K4VAtBpr6XaEFF/hTDrciXU1hyFj0ylIYduhlqzXRG3gB/j0Cb4pxf3HSWClCgzViucHDL2INH1FuhrNsPEN71QXwjVLKBBGD7XEHN52eJmxu3bSfvBnqZeO/TFMIetYFmIxkuPAp3tsm6P7SOdf9QoDRfuJqUHMa/Pc/eZ5EzYc5NaU0fV/ySK6aGGP7hNRNZcDq15z9qY0RyRt7JI2REYkAswP/3+kzu4LDcqv5rVHw520MPyPQu0Jq3ZM3gN1RWYGx8AQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvH+M92NHknuT2EM+SwPK3F7EMOs5r7ZynsRlzpRdwpye+Fi4tHtVibSaJZl?=
 =?us-ascii?Q?3gEUQsdb2rrlpvdNzooKF8D0esny+p/63h7hcX1RtX21BOhhYe2bGnDAwE3b?=
 =?us-ascii?Q?TVPcA4nx0oJgFc3xIW2RAla8S0xIkWNpPEyQjkGaFOYNbugwcRWxu7T1WANQ?=
 =?us-ascii?Q?rx+OTomzPuLlasRVIAEFNtoSVgfasGSqSFP8jW7sDMMI6Au2vhNWICWhPYE5?=
 =?us-ascii?Q?imPtvomv//E1O+zuwkMlpSHhcyn2OQqX4BbbR3ETre7/gOon02O3fDNisfSe?=
 =?us-ascii?Q?WrYGrOfZNLLTiiEVht5qn24t8k0EB7JF7lPdveoJHXeiwzByzk9BABByAbjb?=
 =?us-ascii?Q?Tsuwz/ivbU+Iq4gLFvKsHiIwaw6AhPKouX5xouM+Pq6CEnJJEXtMVcFZqFo4?=
 =?us-ascii?Q?8JXCq6OerJOwLz1SbCXff5+3wCb4xYyv3DVbVocAxmxvBt7dNyLPdr92YZ9U?=
 =?us-ascii?Q?5WL2B2bvz8jGGa+iT67Hv09m+ynjlMvBsgLKsF1828RvaUrLls3IbNnmu48i?=
 =?us-ascii?Q?dLYqOEWHpnuYF+E9CieRqEpsuzn99rnsJtcoKS1diyk/NVMojMYiOrZX60gL?=
 =?us-ascii?Q?jv43iqLq33kO9gvlJ3BOdsGJSdhW+diTli/a0uiUHKUyrQ1tCVxbVKxLaPMM?=
 =?us-ascii?Q?43wLT2rtDHsQXXq0aZ6XN0rvE5U7dme9Z6nuhnSHv/aGO1Q4qJ7farbiWxE6?=
 =?us-ascii?Q?vLuavZLquiGamwZFBvBrsOIv3c9R7NOq+xat5cZ+XglxDEu9ukel/SWsl86w?=
 =?us-ascii?Q?0SdKUrXF2JFYGszDfo7ZOmQebNH0zI/vsH++F2Rxuxog3fiEj+IQUUt4SEHq?=
 =?us-ascii?Q?3lglgSthbxJLyfxUFqbZiB5lPl72RHAPnN4fV8nKOoMPK85KKYJMenDm0zWw?=
 =?us-ascii?Q?LC3pX0AjseRgZNNrrDpkWGni6TKPK6aV0mr/hDy6D0a+8ZdSx9b6eBSHDixy?=
 =?us-ascii?Q?Hx7xOkE4JimPzCkt1OIkxb9YGLTTe1HzlU30z/UUc6b8yTqMZoSENHlSTZWK?=
 =?us-ascii?Q?qSh4q70qJD5DCFNiVh1dY+E4aCcabjmUICSd6S4o/H8/Q4TOcgJv0mV+MDg/?=
 =?us-ascii?Q?pBcRx+tq3XYiwcjfHbYLVbCra76u0Qh7f126n4FiBjjAEUENo4f6pAAdmGjm?=
 =?us-ascii?Q?OtJNzxcuR0vtbcdj4tTGJ//wfjiAkmN+Ggp5GiKDOIGHA7bzLMrzHPdzo0Rk?=
 =?us-ascii?Q?d4ZZsFn1/OYZxSxs/NGYwIF5cTlytpFHD3DtH9Ezu/HVfIf/sA8QxqcPbDQs?=
 =?us-ascii?Q?mmsEGPBCzjcXyjEeMs5ZJs54ZucdMLdhZouW5teDP0hhx/QJh7U7d9+VUshS?=
 =?us-ascii?Q?iUWMpp6Nkkg2SjtNxbf8HkabEQjZUO52YLr0DVO1Q/y4NdHaYqwU2UNnngoQ?=
 =?us-ascii?Q?n8mMuya77SY1HCZFwM/18c3YYIlITjkNdJigV4eDoFf+uKT5ziI+IX3nAJPR?=
 =?us-ascii?Q?hGnjqicp6hcmheYd3tMLt+orCjb3rHUsciPMoCOxk4DQhC3iJDkTUVRtcIDo?=
 =?us-ascii?Q?/QuBxlYghIa+XDeeH3wj+lRI49Ij/c8VVBZTCGbGER/hcUi7M90hCsqMPI/X?=
 =?us-ascii?Q?hPCliGVSLRvJhlhsFqixdJssUWcFoHRj8/ubco0D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae2b585-48a3-45c1-3a24-08dbe842b295
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:28:56.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkSwMNhmNiQiQvWUXcyKXrh659BTfzCjjhTgmFoyjMV5sOIss/6U/pwlN3S0N8fbAlV61vl7au/8lCsLUP+iIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

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


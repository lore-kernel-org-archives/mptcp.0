Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CB2F29
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yykwo1Ek"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGRIo8PO7Z0NDKpD3FqTNmYKPF3YV/3wQoyLA3TMnG/y8ikRh2k+qzA2HmhQcG/kpW+b7+cBxe7If/r3GKI9B+2bLgogxopYlMyTEpFVIs9W36EVO6+gWlPdX5195UZauxHaYM88eHKWyk4QO1cA0kauIXFAt3sRPDO66Fw/06GnIWHjGPU7tlmvQ2fYHzi7iOsVItOHrYllVLrHzeF82UTdcK/65+8zQeGvkaA0XAIwfVzolaYb5rTPP+GPxwPzcFhFGW/Z/bOdT44jXgjmBsuqrfjmximwXvOWO4bGDtvp2c9Z3CkuJJ6+N82o3gsZGcAJzhH/s3zdRnFnTjsWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=mlkeuiM1cRcCODt8JLNGGYmwuOUl0YNMH4tgOZD9zF7B4/Z6Y2rWn18i+3gqaMgnDetErsSmO/K75DfEiaTFklAuMgDKuZEb/IF+en9xW/lIkd/tRFClpYMGWU6GU+lSECdZQIdOBX4Ih+WPrpAWQKKaCQsOdZueuKQvq7iYJH72dUHD8HNsURicDqE/XLIwZ7FYxpE3hUPrPdYiiKkIJRKa7O1D1Qc0Yy4xmYGMUx89lq7i8PVA/jzWVDwY1XWP2p4XR6AyXa3ZjA+BGuvp4XkElcZg7I7f+uawbhy2Jd/XIMYtFc1pxkewQZHI1RPATr7bkuaOpNM3NfiigsCrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWWUSY9xk98fgltOIrmPyL+RfYmmMYbkdDqwVfSOL28=;
 b=yykwo1Ek3ABz6UZhJxTR+F5uAFhTnGHNid0LpgkTBWfXZj2agf2fxC68ODBEJnVGgj8gpEPADj7mlIyXVVKLjgOpARfo4cXSZ3v5aXjJcARHpKC+hXnz+ilm5Dl6h+xYMoydtDZ17CHL6idTPEMOErXv/P0IOZdNiLtBt6eqCQKI/Rr/bDqPC3F9vnKycdpz0bfEtc1x9YWymB6cQU7JX4Ryc4KSVIH4md/Q/MiwQ3geWyA1sd43GU90FqLpF0U3J5vVS31Cq7fvS1bmBojrti9FBknw9rIEKQWiCbYqxZPjgbln/dgA89FKMuQKGmnc1jewk11sJ75cVO8kY4fE/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:35:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:35:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 02/21] mptcp: drop mptcp_pm_get_* helpers
Date: Tue, 14 Nov 2023 14:34:59 +0800
Message-Id: <32ef11db1583aa7f2bd8ca9b58255979d2ad427e.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e1553f-5037-4603-2fc1-08dbe4dbf2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XV7ZPNMEqBNgM7koHATRqGIgGQTtgowrbTMIyZR6+zU32pfgTlKHpjtaq6Z3ltAyDiqHBwqZvQwTIt48vv4d+qY7EDCE7ZJpVaBoT6SpvfzOHhx+Yoi042w5+wBRzpI2tlBOWDSCLfM5fdkb2xjy3T4sITzqePPvn2cp6aDO4YHZOEU3HoJthV5gOptzNNyzAV308t6EnuWW2C2AF1qEqyAspeSH7c9um9cdljKOyxmWWyufZmLOPy1Qj3salpsMBzuI+9MlBvTfsvHXW7NJW/DVpY5AHkuj240fy0PxHjMS5kaNF7Uyt/LRTetdKRnqrmeVzIk9WTDTtskzClDNVXy+3KfHxyOtPOUOX4DqKFrT4+jHNKw3V7ARwVAEa1MpQRv2/vHDO03HKW+PHjJvhuzq4jZAMcNHNZ7lWlsUKTeCsk6TbF8PMdJ64nc8etJnzv6J3yg9fxlgYvqUMdaQKxQD9KHuTgFhVxusf7JivctKhxL9Q3dqpTu5IGAQc2dYInz7ZNBjX88lby9GJKHNRYZtdWWRyn2Rwgwx+m2jK0FRDIl66+PWezDZmYDoRglCN9AXA67xrwEiuzQ/kkX37ldaoEK5inERqBhj3qI4H7Cmosqv1kIJx4h3eGyZ1RZZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+wHBxvioOyPkL/IFRgs09dbCCmM8YsY7gW3rJUOKepBEBKNgTiO0wfvDFVk?=
 =?us-ascii?Q?/8z2bWGUXzFeawCrGhUMjmy/9DFN2iA7zkT7UzyAhhfcf639otcjg1tPwlye?=
 =?us-ascii?Q?DQ+uUGMtHmPYjLyz5Di2SU1O8exID8GwGsqt8XCX2EBd3u8+1D2AlU+tUOee?=
 =?us-ascii?Q?NiLeTkn/2x5vpU3U7os9C6W2Jx6CcmNAXdj5Kq0h67dSnTUks2gjXijnLc8W?=
 =?us-ascii?Q?RBS0fsCnvW/Jw0l9yqSEJuESnX9tenOId6lbeEU8fpS3b72TE6OiBr/0eGPs?=
 =?us-ascii?Q?qfzehBgU+BckyjcLVJN8hswOeKmyepxpaoPygD7vQTO3h7Hl5a8ALmq4a6+j?=
 =?us-ascii?Q?wjZAnRauHTXtjJehOcHnKaHdKH3hGRnXNSuCfK7DLR+8wKBodz3PuKO2UElw?=
 =?us-ascii?Q?U1b3L6lxs59SlHlLb2JjUEOfG1p7DNPWeIX7zHbT2Z83xJ6Wj4M0iyrW4ZAl?=
 =?us-ascii?Q?QuN9dpkmRjv7G8xJIthEou9+vFoO7y1NFZChkNvbUWlKdYlPTZmXgGRE6Vdk?=
 =?us-ascii?Q?7Pi2IG4sJCGE69sPkfyjnK1fsK3gm3ZNW5CFeFwPkclcIfR45WbeXn8pJJpY?=
 =?us-ascii?Q?khAVNftOMekpMPHeCN2z/cS1nVaInhzB6CDOm1RUPl6vEMP5FhmGciGOLSWh?=
 =?us-ascii?Q?dej9etKNZVJYLyPU9BrlDi9ZicU39wJ3dpJykzRgEZcACLe9iPV6vEdMJQ9q?=
 =?us-ascii?Q?Q5UdlR6wcj7IKIluhOef5nP7fyFEp54tiWrUk8g7fkDDfadHbBDuy9gGT6nA?=
 =?us-ascii?Q?ewJNYspNRFco7CVvCHVvsK4yd3z2swodl2k6DYYjcltZN1idY8NDZjX6J35i?=
 =?us-ascii?Q?7yteyhb2Gs/7XBmkJ+o2tPBjqvNcZVhnMb3dCjnG8wo9+Qo1c/0/rbRXM3wE?=
 =?us-ascii?Q?TlgY1+y5kTcJvBElw2ljaaO4oU529VgL0KgNO6OdtwVGwEvcgxh/7Z5hFZwV?=
 =?us-ascii?Q?zOw89VVQhYAS53aIpTpB6MYUhoElpzkxE18LYS81hqzGxOYVaSi4SA1Afpfv?=
 =?us-ascii?Q?xpZDeJ5LLuAOAlIjIcTjaxHm/I0CHH98OU5qW0Lx5i+klghsYTqb2CgXMjSj?=
 =?us-ascii?Q?wFVoT/6C3vRxZod/YmC7/MbG4mQoqc0Gj9Vra6nlW+5lzIVyvdfN0ERZOr1t?=
 =?us-ascii?Q?c237tT8pUOCjhdOw6CQCXRKui+BzDhbEcSSn0T+WlA0onCar91FgxEle9q06?=
 =?us-ascii?Q?i3FbCY9MV7Rc138JNEGZT4D1/yzjz320LfUUxSK8TFmeN1QyViil4NLtPZAf?=
 =?us-ascii?Q?3D52ZfY7aD0thCLczNxp4Y52g4FpnRL3YHD90hFJSeXQrQDKNIxoSbtyJqnR?=
 =?us-ascii?Q?H89jHUPw1gXb0hg1zmJ+lyYY3io1erFPUEW+S/USWjP2pqCpv7oNAuLQZa3+?=
 =?us-ascii?Q?UVh2nvqgBhlkg/3x7gCbH7pWDoZphx4tcOEHjVDXqQ0YsSJBr0ZF/sok33vv?=
 =?us-ascii?Q?f7FMbYsXoPt+5FdUq+2AZgJY4jZTw15kQRPaKpWbf0HnBdzfdjKMBlwkfvVR?=
 =?us-ascii?Q?7+ACVrrJi/paoYdaJ/aH2ZJVeQJH3/GGm1ZCWVkDhCiTYYtRuSLBB0x/5NoJ?=
 =?us-ascii?Q?2RvF2jbyRPgKMs3oi5cd7SBB0lKnZzFwdmbUPDwj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e1553f-5037-4603-2fc1-08dbe4dbf2c7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:35:52.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRk0cU6Cnt4Pg/wTXt35DN6CWGFfSy+1V8jjw9Elxbaq/ngvT+TJwJCIyJtbOBD/yxyDFADcigji8PauADDnPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

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


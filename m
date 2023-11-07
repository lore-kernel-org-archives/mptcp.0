Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF58D527
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ROnnRZIq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUjG5nU0MUItnDL1E/QbbRbxIp8/y5QP1ci+b/NWPZrts9c5JVz1xAB1V5U7nqEWitnB96CGJnK9W5zKYSlgjFxSUSWdMXZu6VLxVv+/RigRpqapgmGVFY3UJ7RJvd8XvyourMwpgVESLd2oX3faMGIaNxUHDxRI54UXBNwoKVL+t6knOvwmgJca0VU+iYQxsvCmi6fCuP5dwic7uxMR7goksAUmC77EbfCUhJvp+KyGzki1HZyWwA032QRjEiCgFVp7OVSucVULoo2QjEwSU3OCRX2JQdMS8dXzOit2CCSn8GsvjY0zQzFprSUnjPSyqVGJ8/IatN7F/Dw5iIZ1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw9ZkQ7Xck8HEfDIVhXW7Ml25h8Yy4lGHfnF8ES+7io=;
 b=XP/o2bsVUABCUpI2s4WRHbvUGjUaXmspCSLfdaxjRBOgHJoqaKQDzPbP6aLqDkg0sz32RDVHR265gFqTolFFOEx1/UBetOkB/lyIC0Fih2PAOnUYjvkm8rMBvl4VqExMLmW+Du0q69x10W6BFK8RdifOJkwT013zc0/8EvdMiwFUSCI09dyLtC0qFbRdcSjW8YBsqMRjNeO45apNJVkH7AcG7rU4PyOGimgWvVkT9exXxFGRC/ttfqrjwS3Q/yFmHSecPtbVNkNh4wcWPhhufnklD9h5+vFI6gnmP7rCTGh0qgL5If3jHY51NvZxMR6gmtl5TGsJKLxJ1FYeQt5yVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw9ZkQ7Xck8HEfDIVhXW7Ml25h8Yy4lGHfnF8ES+7io=;
 b=ROnnRZIqwPKxGt7cSLftJmNoddMDBGV7FZ0J10j5ghI6mhAIh88Dz7vxsDFMiN8xIAN/PYjSt1vxnlMjDRE1qxdZ6Q7my3E6/zmeTBozQ6rSFAKO1Xb+6a+hpSnnmPPy/lNaQgBiZJHN/mYKZG1RpCxmNhRvlnGBPwdXgLjcDul+tkCLhRKxLNUwG33/gVpRR5re8gSrRY8D0X2cevc+gQawbajh5dj2XzTOFKZGsqqk6lPCP9azRv6WlOqdJcafA0R9JqCDSp0RpUGhEtJVE4b/omsrINIdYDVBqpmrCnxpHnERn1PF9rS6QCwc90+c5f59akYzQGLUX1FCCMNUxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:14:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:14:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 02/20] mptcp: drop mptcp_pm_get_* helpers
Date: Tue,  7 Nov 2023 16:14:08 +0800
Message-Id: <39ec6f7e8576eabf633b871e860bc61b344fe9bb.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: e62a86b4-8643-469d-c25e-08dbdf699387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AaciCoi8ytCHapL2iWI6gEqoRsvMaAKuvDoB0kBToEg7FtxBni00q0PZ5pw6Yjd1dB6jC/oY/sdxgX7LtT17tUwMbAikNT8DGQgwGf14qRPyPmmQJIXb2o3YKc6LxbtYf9lhvT0fBSift7DCIKQxAvEp1XZbCR1p9UpXUHvDpNRnjNAr16Auu8Oi/6KK+6P+Un7KnjYDlw9SeAnso40ECK1C+d5y3Msr+YDuoMAUKegCjOzeAFHL7/1QKk4Qh1gDdfTUlQoq/6ulCMK373o5n4JjY/3TBHt9p9m6kyOcztTUgEpHo9x0GQfbS0lMYM7Dv64gNTiaHipvnRcBbYMJ/W/arMLoFd96kiDhSQ7mjZlV/betzuV915ErEDVgMT5HcHvyRjSCxyW4K0qeGpqN7TR3zTKVppbJjsmHyYINyy4qyCfENScp49bEkfmUNsaa++Q3izifBtfc0Dgffh2eRuYN6Fmham1rTCqH2naEsPRHaW7Yn29o+LVk49AUKveEUJm6u0M38f3z3hDdjwzCImXKF1uqRroZBPNaSZw5SHPUP6WRzALBja2J/KjFcMMW8efeUOc2UlC7cMe2VmiwiFAr10c4lNm6e/chaEGqOBdSUWUyMNa79j1Opc59JT7A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kmWOK9PjAdxmd9Ol4hVMijB67TBaGTMGbUQf3e0z/+5ehMw1UUmZbay7Xfbw?=
 =?us-ascii?Q?X77kI7L2CY3cpAzhhBXBXVJ67ZidUbfGmuUPs29jWkXvj3FAgRwEiX2XnHuq?=
 =?us-ascii?Q?EMeT3y9Ri4+IsBUBowqW6/VJeYjVc3FCFPckbNA9DMn4FEqw9wnmmRBnjVAc?=
 =?us-ascii?Q?Zu7UNdrgI29ZvU2N3ZFYdSfbSjG09lgK9vrIKB8wNQn1luTsh8OshWeqdiWg?=
 =?us-ascii?Q?VEK6kLnknFANLoIolgq06D1CaIYhcsDR2uxQrdlvwSr4+XdPlmsF9Os3cxYV?=
 =?us-ascii?Q?kqEeTqGx7z1MLKcPEojuou/zRlUdFWBXjyZ3UoJFt9xL9GXybiF24QkfwFow?=
 =?us-ascii?Q?6o0RQwGUYlpespGIY6FRWFSZrd9YuASyZe5waHaLZwNnW1dwCsMdpyi8JiTj?=
 =?us-ascii?Q?br7c+OXX4vnqh/jKyWnbUzZpNoC59+rrcbaETarWMV26K5eZ0lQTc/gauU3f?=
 =?us-ascii?Q?ebVqofd42Px3rnUag2T/w2YRXpBQ1n/mj1++cdIYzF6jY30jiTI534Ch7JMP?=
 =?us-ascii?Q?Y/depw/oCpUp63PpJxTI2NWh7ubo0KqlE8ccrnzsPpRvsl9BIr0C3PFSK0Gp?=
 =?us-ascii?Q?s09jo3QQtqmbHCoAtJGzMdRoFUl4Zts0s2ZZUa6cryTg+oF3utLYa9pEikX2?=
 =?us-ascii?Q?ycwNBfgAsGZRhL/DDNywALnLK/otMRPfkGtbbjteztjwCXHCHOMKIeWGzfdw?=
 =?us-ascii?Q?VfGQgRwVOdLQmo5NNCvAnK+rfqTok2ca0t+gZWfDAqZEQ/M/IEAU2zXLK4na?=
 =?us-ascii?Q?6SQa09da70KTQ5eVTA1e2AonRBhXdhS5PHQ3kQQCq1/myM4Slyh7GF1mkT5u?=
 =?us-ascii?Q?7bUx8MyVWpl/3J2lgoJlMsUOOn4OJLFCjrvkj40o1Of0CLGsj6A+XbPU69Dq?=
 =?us-ascii?Q?EEVrbNE045Nx5h0zMl4Vi/Pas3eV8g4626yokq6mXjD68tOAOelvc/ltPyPG?=
 =?us-ascii?Q?VncsuMSmrrK8DRpiRpOxWlKkoDMGex8U6aCiZQFZDtexQWI69rtsxsB/mko/?=
 =?us-ascii?Q?mNMyyQTxG7feaJY7gmpjvTEBVK5z9uYoTd1HPJUjKzeYJMjoQvOiS9jpMOis?=
 =?us-ascii?Q?sJDh3dv8s4ax2e1EPnzDmelTNOfch9iGlr8PLBntL21QMtNhErxAG24prakJ?=
 =?us-ascii?Q?OD/oBpPIi7boyj5JMPXO5aJz+lVkvVJenJCQcxPeLOlonwaQpnyO5t2xKgkc?=
 =?us-ascii?Q?ECjkKg0DvDONeyg3y54SMGz6XuBc0QIRFy8i+dhWF+Vakf6fIf5D24xr7zdM?=
 =?us-ascii?Q?xBSKUkxzSbj+iVhbo81+wTG5YNyg0WGx4Zh0GW1yJICbL+fuV1+RMTLA2vb+?=
 =?us-ascii?Q?ClaWKVR5FLQlyJ0kYXoUCxBz98zpaElU9cWH+IGx3wStvRO4SFvhQuVZ+vAe?=
 =?us-ascii?Q?d++yn0Vp2eqfhlz1Y0zOUetyosnyi2WFqj1qDdNhcYfot3FRLrdYT+YxeYrM?=
 =?us-ascii?Q?rYVGrN/tery1vWyt0eA+AkOgJ7gnX3E1bCusXkh/p7tDpXukg57f4SJ9Wz7X?=
 =?us-ascii?Q?44axNnjmGgh3wKX+hrSv54mH9qQgo+9p9yMQ2eS6tfPciOeU3QaA3L3ivry8?=
 =?us-ascii?Q?pNODXeSu6YhNB02JcyuLdrOn+OiSf/JKU+oJ/JKl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62a86b4-8643-469d-c25e-08dbdf699387
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:14:34.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWyyenqUS35GitCrSo/ep4qx7zN9s/361hwMHHLIWeAP3BG7ow0go0rFDj6BWlEZGW6HLcX6oI3fT+B4xIGT3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

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


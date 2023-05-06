Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D61105
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoVkjffAtMVcpAvYCEyUp7snVsry6eciviZYWl6cQ3ZH/BKzuUdXCEHNV2d3gGBcGpJ7T3ubTbEKjnxoORLSiMj0wu0GJDED6OshkXa2KCpP0CFQapT5+pXn9dSrhZwOXRpqox62VDsSSVyH4BZXd+lwS8QpZdwVmn8dT7OS063byYlSkVzD/0pboupPMsr5c9nWK+kG8o9xQHQtP39jlLILM24ft1+hm9F6wsFtjctAocQ7hmngaoXrTKoIl94RsYnSm2H0yO4dHiXvQpHBNFqVQbB3Vx5oxmOjku0KNvrZKV3hGWABIg8JQXhPBn/HWvMKNjoPMQTCQTSTtUnZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgE4i/oT63e4MN7NM03/m7FvYKG1xRhKX2fYpQCuV3Q=;
 b=iTBSCFclPrrD+j+lZjGhjqY2E3OUmVqRtifl9K13ZcqJNcX15HKgzKP0Aa+q/C1qsu4VNR+0PEhO2C9tcFHbgIhB+JG8qd1sUNbE9XhR+7km9SbuB45G2EB8BI966/SMCZ/DvStL8XlaDvdlIJFOEKP2e4Lh/Zvp2usD7hr/NwX1gdVB6SMfx7GtKgP18FQscmL7i0prb/v4ufdDTcDGNxPumFf60hNgtLCuL9xjWV/I7DwEpsxRz4XePRfgmIM9ye2/BiHqp1EnHwCe+kkDB2FgCn2Rai9Q6Z7wjG/5ySrilwSve9I4202z949Or6WoealyMmdKohOYzNqcu6egtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgE4i/oT63e4MN7NM03/m7FvYKG1xRhKX2fYpQCuV3Q=;
 b=ujAmKfzAs0Izn5kzFJxf/taWeochE7DkOy91Ef+BuF2w23QIqSKeQDgYCemYHzTcQ1KzQ7Io/RmUw74MIzhvJawkvLa88zckicTCNp0ahqto6IwNE+9lX7/jspo3XkVCOVsk5oxjba/i2eyacR9E97ffakM5YZfbxM4NmxL2CgIdLl/Pe4pcKRvtVYrD26ZzKIMpYzRUS6BdfFSCVA24E6y/r8yX5okkFFTtvkV94hQ8kJluEbPgdo06qOOjwrV7B7h+1cNAdz/LA8eMRPoWvzUWjnMRbn7S0mHeWbE0JEzTVDFaCS2OnGMcfB1JMsrkIDZfsNGS2VRzh6USbcBeMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:09:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:09:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 06/12] mptcp: update userspace pm infos
Date: Sat,  6 May 2023 13:08:54 +0800
Message-Id: <06dc3c592157dac567c8a115d60faaae261a8ebb.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5409ae-cf6b-4711-46f5-08db4df01783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4UDPc3cHp0hA+bu0/x8K8C9i88Gy7dEPQXBlwf7J26pwojgecY9JxxTjoqK14NifwIS9Y0TS5OlZ768mdc7bgA+euJ5RjdfTuN/t8unNaMEPzmWVGNgxWHUNTKm1nk1vbq2/0HBZwRp6dXE1CRQxh0cSWNBND/l+niwY3mA0oMiJqPyMX+fibnZZJxLhfoHRR13kFOIjw4Uke2VFVbWNvXXVvYX4DYWMxd+K416IA1yUYho4wnCRXWGyFMFC8MnMbtAE5X3srzsthai7BQAiWrHblo/KBlpPd7so7mG8p5+Oa51b4+VGfagMZCRCWNHNEGHyvb8MMVL730p0f/9qUZqgWwELz4VpvQw0U4KGoE7Zc9gOQQveWfV/oMKwH6E/w8xjxKyNExBtaeDeEc+KcA56CE6KdFIMQyAUodKQczdCYaviUBngQvM/SqhDLzc0tU2AeKc5r6fKIIVB9vEb01tm3bstAKJVomdzF2rV34QMkGROod72Xoif9Ako0Bvl7W/2kSEa4jOmYqeEm1xGvB5wXWw7h72wCtwNsZPlup8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(15650500001)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(966005)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f5E3BeUYEEYvHZx6A3koNSd1NwbQ+OnVT6H2ippaGK2ddDzMSxFoYG55Dses?=
 =?us-ascii?Q?tOgBtkM/Nn73VT73eCoqCl3VPvTu6/mmdCFDaL0p9+KRoVW0DuNpdPEXMx4V?=
 =?us-ascii?Q?C8FzFAqNbDMN32/25PC5y6ni5mQjmheOvLXz0z+HMY/ij49ckiQAF3EGCFYh?=
 =?us-ascii?Q?8bq4dVkbvs3/9vaH5ijkWVEVfvHoTyBDbE6uY7NvJaI45ezfjhoAOy3+kT1G?=
 =?us-ascii?Q?b+jO9ybiXXVCd9f8AP5xNMHksIXWDUCaFkS7dVIAT2iFhj1+bcy57mIKzih6?=
 =?us-ascii?Q?yjBuInGnnMitxh/GYuUYvonTbImPZVpiuOooYYQLx1B1ccugFyE3xfWuirvV?=
 =?us-ascii?Q?lBLICbG6WH0JevGtAyE+OsuE+suv6udHOY+MSC1e2bLLdNm9LFGnE+8ylmgN?=
 =?us-ascii?Q?X823fLTsbNyIXQ5GlNF9khhnUbJzyGH06ppIeU9i5/+0Qq4rjo6S/q5ZtE5e?=
 =?us-ascii?Q?PzjHosYwQydNZO9mHEONEbIGJHYjRSBrfZEEYf0pP4v8jrNDuW2NgCSXzFyL?=
 =?us-ascii?Q?A8lXuEaJHTZyn2IDZ6uLo1s+jjQ6412CngP8AcBmREaNPT5PwKhvXBwRvLNa?=
 =?us-ascii?Q?yts9gwsiHk8uqibNMG5yfMgLiHOAOu0SoUjmf8BwfWBX5aeG1yec9xZT2vp/?=
 =?us-ascii?Q?hMKgcdxjEsUGUU87HQ/uHFZJimgN8Ujl3SaM6k+N+Ag1Kpp/JwW7k2mepDyR?=
 =?us-ascii?Q?w78f/hFK9uZS/BRT0DGxZRBDN5oNjHLD1PQHYHYuE7+AemenKYToWsTYNx6w?=
 =?us-ascii?Q?T+qMITiqUV3AGa43aB0uqukJt/9T6BJgO23V4E3rW62j5lZtSW42lLIpX6mJ?=
 =?us-ascii?Q?843ZqwZPz0UzS1UWQBgVJCEpP0+8UiLLoY+lC8A9ilOsg3N/CNbwQresoFC9?=
 =?us-ascii?Q?iCU0jsGMApj3utZYdaUtevuCutXN08kUSh9CddIUi5exC3xE0MunIWAqWi4I?=
 =?us-ascii?Q?dZVRIzYyjgnr5G/Dmge139ZdZ/uGKDh1dx6AnTImAqm4SK1LpjnjUyWgk72n?=
 =?us-ascii?Q?ISSZ4md9dmS0qw97E9gl+xqP100FntDLpDzH7uE8ZaxKl4oBBTjXA4nM2+MB?=
 =?us-ascii?Q?9OWAhNKizWg7IKmnxXwxSCX+uekt6fb6X+XEMlYMH94S0qp0RnLdvnWLuK4v?=
 =?us-ascii?Q?eSldJ89jpXXywbQOkHyL13UvQgDhyMUM/qh2eiL+0I1a+XPN1U1KMEin+mzK?=
 =?us-ascii?Q?QqpxckJkw2p7CvEGPy+VZnda18PNOMovT2FO/9Y5ubAHY6II2wO6uBH1M6UR?=
 =?us-ascii?Q?F+ERYuOH0EBdVdZ7xsoDbFXWtyKY18s8YiX4XOpoEirpHNCk59wNgzSNT30t?=
 =?us-ascii?Q?ksXZ3A17RpB76H22BnjhSKM79W2IGzyVqBMFe2e6Rft8pYzWaXqCjTXjup6T?=
 =?us-ascii?Q?Yifoy2G3sskz7jQQ7HtIxNAfWJPxlIng1IFndXvMIrUa4LvCuKBJ6EGFX3Bo?=
 =?us-ascii?Q?6ux69VZIJnq9ukBjpEOkxX+aGcHCSjGihGcuflwisGOa0TRmcC/h+j/JM+2L?=
 =?us-ascii?Q?NmqaIHsEUASaWrUlDBov2Qycu8GgUM05o+wm3x4rXKJExNtHaswg05nkrcOg?=
 =?us-ascii?Q?onQnU32j2PvkMR2as/yFtM/as718RBmpPSzhntYL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5409ae-cf6b-4711-46f5-08db4df01783
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:09:39.1972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCwERi5U+Vv41EHBA461Uljv7heQ5Vih6MFiisFxXQSZscynxT/ZFiIsmmgJmBPpL5jouhF4WeTvtk1AoQG3+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

Increase pm subflows counter on both server side and client side when
userspace pm creates a new subflow, and decrease the counter when it
closes a subflow.

Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
address is announced by userspace PM.

This modification is similar to how the in-kernel PM is updating the
counter: when additional subflows are created/removed.

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/329
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           | 23 +++++++++++++++++++----
 net/mptcp/pm_userspace.c |  9 ++++++++-
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7539137719ef..e7f944d09fcd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -89,8 +89,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_active(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		if (mptcp_userspace_pm_active(msk)) {
+			spin_lock_bh(&pm->lock);
+			pm->subflows++;
+			spin_unlock_bh(&pm->lock);
+			return true;
+		}
+		return false;
+	}
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
@@ -183,8 +190,16 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
-	update_subflows = (subflow->request_join || subflow->mp_join) &&
-			  mptcp_pm_is_kernel(msk);
+	update_subflows = subflow->request_join || subflow->mp_join;
+	if (mptcp_pm_is_userspace(msk)) {
+		if (update_subflows) {
+			spin_lock_bh(&pm->lock);
+			pm->subflows--;
+			spin_unlock_bh(&pm->lock);
+		}
+		return;
+	}
+
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ec26a3f0bc64..df09ebcc7a35 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -69,6 +69,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
+		msk->pm.local_addr_used++;
 		ret = e->addr.id;
 	} else if (match) {
 		ret = entry->addr.id;
@@ -89,6 +90,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
+			msk->pm.local_addr_used--;
 			list_del_rcu(&entry->list);
 			kfree(entry);
 			return 0;
@@ -190,6 +192,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
@@ -348,7 +351,11 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 
 	release_sock(sk);
 
-	if (err) {
+	if (!err) {
+		spin_lock_bh(&msk->pm.lock);
+		msk->pm.subflows++;
+		spin_unlock_bh(&msk->pm.lock);
+	} else {
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
 anno_list_err:
-- 
2.35.3


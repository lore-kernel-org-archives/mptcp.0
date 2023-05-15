Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97F1381
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 02:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8L6T3rBXe4X14NU3wquicMsK3SWdE7x72oec4mKv2wq3TPdFMGhNDgGgGnzNVEN0Dvur/AoNVxJ/K/TKNp2OO6J5ZwdFDiql71sLzDCFeDqheDI1k30XDTNp2GpE8YapTUnS1MS9sazt8x5DjmMHHyEAC4Z5JLBg3/Pmo84HXWv3de+gWjm7B3piJvpvwfnWV1el3BOkV5t2vBnwPrFbhb41ydTr8SDETH/XLhZQmZ0zg+8WiDn5BDDqtBpL4s9mY2HUGHVw561cBS+0MvSQvdQj0QgWFZecFK4qgg90nfxCPtnGGXq1Q9dr21eMubD+gOu+UirVKeOn39sukHkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh2E5GPAGV51T8E4YYty/7VIxbGUziYfDQb52rJRl3M=;
 b=iCWHix25DMdMtGc5pleGu3s0CMQO5HvSmH744/JvT3DFQuEHsWvUSQgnQz8ymafjNrXuL0c1fwG0gOq7tiByc27iZP1TCvSHm2L9RuVSV+4hSqxlbBgcZLdQD+LlMFJxqZik7Y4lXrj5hMSMMST/h8ZVUjb73Dq9vZB6jeF6ZefIHTzzSm4REy/OtW48zVlw+IiOHeRG7LzcrYlUTN4I0oBQBVamCR5GR+tBz6pjny4HHUfF9/VFyfDcfaKUNTzGXirgvQmFn6KEDt6Fdqf2xAt1HDSj/cZBVsnnu9BeiVummyPL2k2p8FkU4orcg9ncjG+zUvcfrYscYNps/TvvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh2E5GPAGV51T8E4YYty/7VIxbGUziYfDQb52rJRl3M=;
 b=PxO82+RIa10fbIWwWnlokAOhuQ2jJ+/0dLvnsp6xB6w/z+DQzs5TpS4msDdHYR+fhQU27liVsFi145igiRcNUf1XsEdj9EWiouOFrBQAE2GqU2Tssj2lbJ54z8fwJAaCxoq4PygotxfHQansRiTNBrbRBkD/n17+4KpRePBEqalPoqt6lcsZ8InjanJI31vioK6x0KpuYKcu4aWOED6Y5MRtpqRpLx0QEQ9EEoKOgpknJ5pa3vD9Cnvvo5STxgQcYtWaOx6PgNBJX1rm5fjyd3w97BLxq0wH5XtjlLy358gFsYYghdKTQHaF8gXBaNQ97r0fv2vsERoMt6r31uMOwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:11:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Mon, 15 May 2023
 02:11:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 1/7] mptcp: update userspace pm infos
Date: Mon, 15 May 2023 10:10:52 +0800
Message-Id: <6f3fe80ded90e36d08b395333071b2cf55bb4258.1684116357.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684116357.git.geliang.tang@suse.com>
References: <cover.1684116357.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:404:15::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a8245a-efca-4ae7-8b8b-08db54e9b112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zp7Ua0VAX7aUlU6v15qojI78/h38eJZO1KWXbsDxTHDObE351d18nofTfIPLSBg1cpOlmka5byTHrgTgOO2cUYl5XRHjRhHnGevm15Xgonx+bPfbDy94l6+AHYyMNjBuA6X4Y4Kq8xoAn4qgZjh2z6JxouOMJcGR7GzakeGxGawQqJs9n6ASZDksig75dS8GbLMVi1s+2okhoEOiMzWojaRgA395LqpJNu6R5Bg92lWTMjNk2B2H0Ma0Ua6fxq2WagTDfUQpULkJM44AtpIBrnFMCBNbemldTkRwr51RaP4quTc6+trNRoqWFBuNP0/cD7YA8wz9Am/Rfu6ERgoD22NKZVavy+8xRaCzQdFSRseaxAN31F5yskk1xmLJmEhSTjgHVuCACccubwIY4bR6XzFqP4s2hGPafCK2J0beLumK+zL1YdU3f+k5FkAMwKPlaNS4K51o4TO34ubdx0wu2mctH6Jg0VvCfWxsnCqXCpiEphiwVON4RAUVin/K7Jd8/v15J0YaS8GTOHW5bn9ZYBZyxpVvw0KGB63dmwk11GA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(26005)(6486002)(6512007)(6506007)(107886003)(966005)(478600001)(6666004)(186003)(5660300002)(44832011)(15650500001)(86362001)(8676002)(8936002)(2906002)(36756003)(41300700001)(4326008)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kdb1Ta45Ppeej2Vq55yJfmAiezsNmL5z08JBSe5wPlVjfvlapn8TwGzq1Bn6?=
 =?us-ascii?Q?ZXSu02Q/Cu7ez5qIghyzQQdz7Vod/6qjYr46H5J7csgXCdqzax0xOAr6x/L8?=
 =?us-ascii?Q?bO5JeNOHVPnd2bLWBq7+aSGnS3ODh2/EafLfqxsaNLv+j0usY8TCVFQzLSya?=
 =?us-ascii?Q?obdlbi1tqJB43j+6GcYKiSm/w5/8cWRLYUpkmsC50ZNRilQT8MDCgzFpy1xs?=
 =?us-ascii?Q?0G1C7L+ltWmYm/F4j4xDLvP03Qvv5cZNMQgRotCgSEvJc39klN9q3sLRbERd?=
 =?us-ascii?Q?FdrxTo58KKgHKBYqjRq9TzqNGsxq+UyMTTlEwiCVYsFTzt0c+a8oilh00WcK?=
 =?us-ascii?Q?jSzRZqDukqH9DrG5kQAMLoWebMiathdj4lEgSW3VQUYUpYxJcIz49mwpYKZ6?=
 =?us-ascii?Q?HJYs+PtC1D09xsWYmSLu3K7sSaTl+vQ67xTWaq6DiFoHPstlKWVFkPHThnlE?=
 =?us-ascii?Q?rJQ4todAiu6cv+1cCT2UG0BV7xfJat38jXkRZcFZAX4lWGO8HrpxY4A8z86G?=
 =?us-ascii?Q?EoPdNfTwa71Kkr2WKY82/GqWy/dNDKaAYw/goRnkXXHml6GEtGVqxkiWHpsi?=
 =?us-ascii?Q?Y3DEIceXbUhRIcHpq3A4coD1iNt1/PYgYJhK7h6zu1FB2FlBZyNZ9MZX/m9U?=
 =?us-ascii?Q?d5bVRbKNKvkDdTLKP/5dXWQmPfv7jV1++KeiwrxvzfbvGubSAPtNgC43jfp7?=
 =?us-ascii?Q?E8z52mfCuVaYE6G/L23y2OxQwYTPAD9pqECL5nKxY4FjAaKZLLJo5TzgVtCe?=
 =?us-ascii?Q?e85xW/3fJnhdxZfb/Vt6Zc/z45fIUyJ1YLYjggrntBjOCBpk+LCz8bJYemkl?=
 =?us-ascii?Q?iORwnqYR8zhotOYCZAvoKV43g1WEsU+GMnEjPPJJ/eLbZeLiCX7lo1JK+VhO?=
 =?us-ascii?Q?5s0b2Xr+mSBttJiGI4ZbjRhRfrx/iVpE6rbjETs3K4EB6W+g0ByokIbm565g?=
 =?us-ascii?Q?VB1bv+UA1fNGtUbhWnSjjyNDAdyfi5LnSmJvYL8dnTGH7J7VynZepc9sNfFZ?=
 =?us-ascii?Q?fYsnCiTshB8A+kq6dOeKYXrtg6DlBaXYmLXDfxBy00oiCcB5I6d0yvUcypa6?=
 =?us-ascii?Q?czegUALgWJ5TkNzy4vbL2WkexTcMLSTzkXboLJNtIx+cbMcqNPeTR3bc04sB?=
 =?us-ascii?Q?hIJ2xsttQKLZiLOQinGCpjFvOxtLYgYaXNH0aTNnbzBZ3FbAxx2ggHanRCRB?=
 =?us-ascii?Q?AToLK3jLhqiStclcx3IZJCGKfeFY6VNRwVz7Cjg/zN2PX0D9tLrZco6lzTWb?=
 =?us-ascii?Q?B1EWSREf7NLcA2uXVoWsozJ0V9JnZZaCQydUO+LhxsxfUUp+DWMUK9h1lJ20?=
 =?us-ascii?Q?5uWO0m+2IUf+Dg7dqTsb2cDtQ91I2iu2XlMJybo7QFjNjC4nLT9jGvpZ+5Se?=
 =?us-ascii?Q?WVc/933yt7I+ltX2w43G43lYr1qrgPYscLvoU1kgf7CKE2eJV2ZyElj8uwwu?=
 =?us-ascii?Q?b8QcafsI6h7fBIRO73v+M5aRfiajuApDF5CCkrTXXlnrB224OBEy/1Z8ReS3?=
 =?us-ascii?Q?kh3GK9Y6s0eFbajXHV1IuD95yIvzh2KMM3fa/ggZFAWYIljNxRErO+IUiTJG?=
 =?us-ascii?Q?JV9TLanPRwh6OoP16jSQQzFkbPyl9EZWjEkXLymo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a8245a-efca-4ae7-8b8b-08db54e9b112
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:11:28.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3o4yzA8ekdCkgyBFgGcJeF3GGzx98QuuAIYs9u3cWOxhRvHLHPNS2+DQmy+AK6Zc/3bdjOHZvlUkN0WbhxjpFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361

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
index 016df47d7d6a..febf3cf0e935 100644
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


Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C633CC
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 09:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwCAnFh8RaQXoe4sYcG+rUSKTOXMe1yuDrpPgg2Ncl1v9N2PDHVXJDN+1UCiukR5k3VtB1pnV24+DNyeKiG5WtZ7cMdn0AzWmeRPrdg+rTH8uEGCBb6W28ohl48twXVx6KJbs2TrM01Q2hL/qz+zqX28n8Y0Qt1u7dzCDy/VxJsN2MwfDbSfj5ReGOkju9AhGWRqFeoEWcImnWBCWaT+Sje/RSTiTwm+flFEcrEZb3KcyFz6ESQpyJcf73YNCEdk0D4DYLRsaPPBh4V/AFrTd+mCaHdAqHXCsrWRyhkI4q96TqsEVFC8dazmInRM8Qcuki9A/ZJZzG5pDBRgXw1STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lVcVblqNuIDWKRsCZqhY148D5MACt9HxE613t2RKO4=;
 b=V+KBtAP1AyBcdTfwhptI5SLtG/jWi2wSoxJvr1EVWWCSUSyDoAKqD1u1Ee75Gahcu3Purf+7nr08cBzPpgHSkri9sY1NUjE++xqvx29YWeRr1xM3xWvaGA+Qf3BCzfwx5Z4m68q6qKAj1jHSGgmTYbM1QF8QurHUXMq/Nf113gVqa+0B7Fg1THL0aL5JxH3Ly2Mu5uL4ifHjOUnAgKqRVhs+moHYwjjZdmBG/vWbSlNyYGXR+QxFXwpTilPAgiomDXi4vqpy5mTntuUqi6wWHUQqNjXCBYQ2RcM0G6FaNhXxaTweSru9rrXeNQz2JmWZ10ivCci2HzLcHZad70TFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lVcVblqNuIDWKRsCZqhY148D5MACt9HxE613t2RKO4=;
 b=KPXsEBHXcvBD+QuadMk2rDpefHyLBk0ExA7HLW+N3rBYk0OGU+EYBEOjg1PpXKrdYWmqhDf78+Hk7hGc1HuS7cMo+EDYCkojmUF8TfYqUcIvqsDNP306+cMQGpDYJr2/RKin6ziZHzqlNcSbtOVE75xEHMV37uTYS/YtpJtK5G2vC1nTct+dIUvuivdYZTAGHK0L/eKM0uwNt8RI0s9nLoh99oMJuDtBcRf8Nd4qFULF7rFfPBuQ4Du3epg6XVdGZVKfigbGmYWaM5kTmdiIaYjWsUPsD7TfgQ0D1eIW8t4zarDvYpJGSC9xgkR7xA5KKZB6WjaQoeOw+rvSHWBJGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:13:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:13:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 6/7] mptcp: update userspace pm subflows
Date: Thu, 13 Apr 2023 17:12:41 +0800
Message-Id: <4002840f35e2c1577ce323921be3505dfc4bf16e.1681376983.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681376983.git.geliang.tang@suse.com>
References: <cover.1681376983.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7ad93c-da0a-470d-3dd2-08db3bff5926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CHQ9H/ROvVV/9NO9slFTKak9T4nmiEcUqls7VmunTSgd0ZM6JEqnZGFpu5IvyYKuUxAguA+SFDdgWM5SLZNZay/FARI3N5AMlQ7VLSqik2ZCqqyYFlDKfM47QK0FAm34tnQCI7o5w7pW6SExH3iWhvEaYqXlqpEtBjy9gzcQo+4C3TguoFqR3/GJGkBaV9sLsWj8VzvPRhvqbTcxrA0Mil0H/0kuz65AbfA4I2Z/Ai6eHtTgmYzzGBo1v8JRjXQoIHi8rzGl+3QJ7TP0+l1EwIWRZ0251WQ58NyoB4CYr/y68ro0T1j9o1LGBm3meeMsq5yfBV24A7GY0Hl+Vv7p4jevirgvrniza33qJoHFCPZXH0DUFJvU0iWcOUWyUv0hLKu4O6zusyHRkPtU40SDJRdquO9mD4vmSqDeOuLeUSAJuH6SppX995AJIO2EX6sQKfkrBmbhFrJwjp3F9J5UxDNPg+05eEBE5QfuorpBgmyZ+N2Lr28J3OHUubBVAfvGIxYahupseXQlX5FYewAI+Xq4739apXwpEWPyghohqHvNSYEw0LC+zL47X4K9vqqK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(86362001)(478600001)(6486002)(36756003)(2616005)(83380400001)(26005)(107886003)(186003)(6512007)(6506007)(38100700002)(6666004)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(2906002)(8676002)(8936002)(15650500001)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?692kuv+MU8B5GfyGw+m0fF4vqRoViylJz6D9iTFZNWCbpzYCqE77c5hrSu0E?=
 =?us-ascii?Q?ULKA9jZOWI/Z+R1aIPc4Sp8074t0hTjQxwJvuUB2HvSiFpTn/NOp2wxL1bzy?=
 =?us-ascii?Q?o+hKvbi9ZM9h0sDA9+rsbDYyJNXbhjMAv4eYjA1KpI+HvJUiewvwvaTneIMi?=
 =?us-ascii?Q?wsP+8J8J3A3XN8EgiOPq9irOElWZazUUz26IoVaMeIowV0n6Sqnj32Zy/1lC?=
 =?us-ascii?Q?qo/QI4sJxeYa2pUBkWi424/IZNlD4rab5VNL8ZWir6MC4AGCX5jXK2AlVMOj?=
 =?us-ascii?Q?OmBlK0tac0DAGCMvJIBV7WlK/C1lIv1FU/gmH1HkKJfVqsTe2Y8+kWTvJ6c+?=
 =?us-ascii?Q?FvK4vz1zNLmGhwxMdBChH/rfrjVqI3iCQuwwQQraqg51MV/6EDkTcEnk15ev?=
 =?us-ascii?Q?KKqGbf9A2ZDyw7MvFIzT5zHUXLwmMkEJgf6/3zSJM6rZACuYtAZOWii0Z7qj?=
 =?us-ascii?Q?krhOUWFWzGDxwaUtGdgnAxpxqxTDca6/XXOuzqx5mvNhgAqx3yGs+r4ILYq4?=
 =?us-ascii?Q?jNvlPa+eC1Gq+XncRc/Ycjgk8Gk6AGsCCLqxl3L029ttaG5wj8BPS8jyfrJX?=
 =?us-ascii?Q?BJHxDtEnS9d31D+mTBBPrt4czv4xGst23Xxl5iYPNBO0s/ES90OXsYAN9A/W?=
 =?us-ascii?Q?lD2AAec5ZSW0Mbmms51pqwb6hP/P0+bLtpFbvC8fIFZv+iiC/yCcP7y6EKvm?=
 =?us-ascii?Q?R6NpJRrV7Ms5nDEZAGU1ZDg7jTc9VLHQrqu5CSOav7Oc1tBBVc/ZqKyOdGkF?=
 =?us-ascii?Q?Crf7mfOb/oHvJ8F2eawg920NCriUOspzpY7Gx918xqQqXRvi8i1Dr3RtsMr0?=
 =?us-ascii?Q?1BlddGUw8LSCWfb8WOeMPa+2DTZFP8UXjWcVVD9SGS/xSwxPm5lwBEMfv4jl?=
 =?us-ascii?Q?8Z/YM8bUUJlGdFLMTzt3JcPf/McIA2arptrJjjwPOuVwKzHN3AOXfu3nId2l?=
 =?us-ascii?Q?jOamYDf7Dd93ZDzDc7VhyIzVcRIvuIXd4aItIX9FOQh170G+pvT/Eq4IvFZw?=
 =?us-ascii?Q?eaNNi5APD4xoM4mC9amUEbOH1Z54+b4R6b5x8mWCoGndkWROC5SgxXM6CcjR?=
 =?us-ascii?Q?aPZowf5sfEYbTGPSdPRetEUaIwJzDzQDppeCFCNExe2c9Pjh5S+RWDGTgH9w?=
 =?us-ascii?Q?aTwCWEHEGqUn2SVxXSGHlS/W5cBk0BGW81zYMYiwxgjgKZdasiUnjsOhPp/Y?=
 =?us-ascii?Q?rgH9SKSykVY2lmeYTEBSjIVRGU87nF4ydw6Kte3H01UqORSQK2wD8m/tLO3o?=
 =?us-ascii?Q?CoIiu3uACOWhLRdowjl32d4qCfnsSY+NxbxQzVnBURzO7TwxPuepkJbOkQVj?=
 =?us-ascii?Q?FL/4ILV29yoorVYsaJ9hL8ndpa0/0qzpdE9yAiE7Mgob2VEtxr0Zjj+5PCrG?=
 =?us-ascii?Q?BkpwOWEUi5ugTgK7haHaVU+XVSkj50dckmeoNF5uRGXhJKsTcPEhxCSZUPvL?=
 =?us-ascii?Q?RheX7RGOEV7ZJuiaKdInXl54zZRr5d7X5d/LmTs6E35P6Yc/g/LXYM7MMyAM?=
 =?us-ascii?Q?iw9ttElFecQg1vwGgSqay+6zbUL0AeUuREvnd+7Th/RQQjADCcViAeUuLbgS?=
 =?us-ascii?Q?Q93q+AfWuKnCUew52Qrr3U1+EtSRtnVXH2bISgQ5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7ad93c-da0a-470d-3dd2-08db3bff5926
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:13:30.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceijLG6/No8WvtvSd70X3Fq5YnUCBkqIVm3ty8YEsv8M3mqBWlLK/1kKVi0hPZiSRqBL7LCYdFH+L5D5eLa4xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339

Increase pm subflows counter on both server side and client side when
userspace pm creates a new subflow, and decrease the counter when it
closes a subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           | 21 +++++++++++++++++----
 net/mptcp/pm_userspace.c |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ed4d29d9c11..bb01f15d8e0a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,8 +87,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
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
 
@@ -181,8 +188,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
-	update_subflows = (subflow->request_join || subflow->mp_join) &&
-			  mptcp_pm_is_kernel(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		spin_lock_bh(&pm->lock);
+		pm->subflows--;
+		spin_unlock_bh(&pm->lock);
+		return;
+	}
+
+	update_subflows = (subflow->request_join || subflow->mp_join);
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 817b6f1eb013..db063a6956bc 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -311,6 +311,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_alloc_anno_list(msk, &addr_l);
 	msk->pm.local_addr_used++;
+	msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-- 
2.35.3


Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C4BE7A
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBEyQ4yiWfccjtB8G6hVviCDvZPjqE3xwH3C30QrXvdsOZN/GSDz9gZ8FVRV7s/MOFCayNj5P/cmJDzzSXt9apH94ZgKdPwPBpGswq7vvh8WhvPNemRm23vqHLpFiSRXCke1qrOk2Hcu1QzT9b3f9nqqNxZwGoZdQaP4QXjTf3TuyDemXmgsYN0fDG3rDMFtGlTiEIW6znOYHSKR22MEPnEtpTe2C8yi8knUinSodgNnGmy2emKtzGYZFH7FfgM4SZO1wJHw9KhoxfdHi/UFbXrrIwEtqTHGu6NoMXTFXQYNBenKJHxsbg2WcqcAegXqMn6KGO+HykkMC5HZdXQ+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNJbjISTuZalS2v1QmnO1FpiWON0lLzO6YKl2gn1/Vs=;
 b=aeKkB89Ydgievls/KQYhnK1n7knySeFcvy7jn0zLloG7rW7sVhVnYK+YlrMijuluJjLdi+SbXpqrCLj8Xy0qEkvoxHMAU3L46xQGtqXEpblVcYOKuxPULmOnzV0p8M2lrfBRAoJEmjPAmy4Dkccfjx308Vah6uqlkySr++7ZawAvLp5sqFXKHT4pn2FbqIuZOtGZ6QOuP/Izij2LM2XbH208f9D4BknVPrDb0ZXW2/SDAIsU/eP5Cv1fDxlJAvfTU/sU7HdwnXSdCQK/iSlftKYwTyOyusB/G2adL1RcN3B5nkNFIp9V5sM0TWwqdykAb2uaqGXngwabAYm0baHQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNJbjISTuZalS2v1QmnO1FpiWON0lLzO6YKl2gn1/Vs=;
 b=y4s82LhF1cICQD6LCLTVkVHavHmwnvO4qMSqqZbaRGIoLp3Gn6ihnVGS6Ccksdua3WUj2Y2Lg40EiElEe4q3c1MnDVNAYDoGhZCi/OGeTxag8x7o7uFFDsggrcQrw5UVExdvERI/f+DkPiFj+LtC7WyU+ySqCFnjDnSUIb/xRagVKudu56rgUvlyiX/biTY4eVqoymQPfFeMNfs25n/CRsq3ic2YZZF4XgLTTMT9EA51Q3NYb/2vM/E8WgoxD3qLGEdR7tMwEL1CHTC4r1ujSpmB10tt28q8NjFgZ2sXr903ERxhXVh0E4T+nuQHp68J65lUrWi7Hsazn9MeWf2xGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8591.eurprd04.prod.outlook.com (2603:10a6:102:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:03:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:03:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 5/5] mptcp: update userspace pm infos
Date: Wed, 24 May 2023 16:02:48 +0800
Message-Id: <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684915182.git.geliang.tang@suse.com>
References: <cover.1684915182.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:405::36)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 96687c02-94f6-4283-dd8f-08db5c2d68cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x8SGA33QkOqPrBpAyCH7eD3Jdy26fx3Ew0GWFMgQvrovxXT/e6X5tckMinMQ3VHzZqxrkIPzCAn+MrRNePXk5ApKfh5pRmedcfOl6w9SO0bfb3CNScYTNKLDGG41TzpAgwM7U7J45tw4r5hHsRvtz6vlctmCz7ok8VNcCY6m9N9Pl7zy6MFAVKsFJHBHrfAlw+D156DQjpH9sPBMQ6eRCic3VcsTaKrOm7SNzpMeUciCVQQMhuIhm2caehc/1+aTR79brXJdBcZYtVrMdXmup8Vo5mUHAl8YN+995FmZs/zNeV3IbvbPMvWXPG+CeAYkqextY/XaRUQM3ToYbWhuNcahOAeodv66CsUKSxBtIGatZob+KYMRHktgaX9dUD22wCGXq1QqDg35Y18rrJIMpIhPK62Y/3qjy3otjbrnm+iScb+nT2aziOb2+iyamsVm99BLNBPjnmpYzskveSL/P8kQSyYYIBG+PTgDCE9Xq/1Fw0DyUNmjND1ayfUkmsXxfS0ak8oGesT6y2En+aI6KmFoLbro6j9sONKX70+DTO8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(6486002)(966005)(38100700002)(186003)(6512007)(6506007)(107886003)(26005)(2616005)(83380400001)(36756003)(66556008)(66946007)(66476007)(2906002)(6916009)(4326008)(316002)(8936002)(86362001)(44832011)(8676002)(5660300002)(41300700001)(15650500001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KTj6yYbcTXJqE8CIP7CW3PK7SJRAxjmdxygwxBocWTQo/uI+vDPPBJAAem0d?=
 =?us-ascii?Q?bEYZ2BrBEDjhmDD4yBuYSFu5B67CJjQwe/xPSgZ8PpJ6RuCdePCZYrl+Rhw7?=
 =?us-ascii?Q?XaPtlNcGbk8JEL1WC13FhcdnesFCfuJqhZdIYZGghYeI7fZRmI6SWPu4t5xN?=
 =?us-ascii?Q?TjSKbgMz/ywxDelAKRj6lMzbLlex1BF/1LQ5w5SOeOrGaWeOzBfrnztv97pS?=
 =?us-ascii?Q?ynttxbOc4l2+as2WqTW4QdApUgZ128l+2JV9l00c3cvEkCrgC86aI1u10pDH?=
 =?us-ascii?Q?xT8VRqPKgWx7OE/g3gJzdLmM4u2xTwJFHkS4XJXXmNxBQwrDJde5u7hCvLuo?=
 =?us-ascii?Q?gj+hsUbNtcOEXXKX46iSMdED3yre9NwwZnRQQ5f1P8wVi5ZnPBOLh6nanRUJ?=
 =?us-ascii?Q?UA6/wYKpDsXzqidYC9poLXLMeARdChxtm6w7uvtY9l73noeL45TKfNQVOK0r?=
 =?us-ascii?Q?AGz1pIPAaGz8HLw9M8KZMzChhG6KW1eYm8mA/a4BI44U1I9/yhfriqum3RMq?=
 =?us-ascii?Q?6XgJyRi/2s8EhsOfr2I4y/Y5u6Z4GVPLBETP+lggkrnV/J9Me6uiostNImjo?=
 =?us-ascii?Q?hUpnckqGsc3snOsebcTkDOnTKvdC0+fWtTqALj5pjcYSEeb+G+9g9cpwXhYY?=
 =?us-ascii?Q?IiK6+8rsJ0YzbaQrJ7A0i2lOPdvy+rPEPRu4J4UDo7RrrGwCsCBwu+K3Ym+W?=
 =?us-ascii?Q?flGiR3mnlFQ+Wa/ThA1Uw3xyqzLiJmrVBocOmFxm56KGPg7U/nKwo9wCe7qb?=
 =?us-ascii?Q?dZKTLiIiCVSU+0sRbC0UMl8Mrk1RvWZJJc/rpPeromwNaSzTKtw9o3Ru7PmT?=
 =?us-ascii?Q?/l1jwLDDeR4yxiZ7IcWOqKu5cL53z+EwWu63FFWq4jjSKekqj7aftuaxj1Zx?=
 =?us-ascii?Q?YCHzSX1SQgOEtEAHAitJgdA0w1GHmXmgG8H2IrboyD6CGDvpokbTkVRvDsmG?=
 =?us-ascii?Q?HxI4m0B79Q5YRFSPSyXm1j6WdAC3045Ajy9Li8rZqukghRmQzsScya2Y/Fxv?=
 =?us-ascii?Q?4D4PCroEEff3E4eZpL95MswuR68yUqTZuiP0f6KgZFU5ZMTYyoR2YLr++enn?=
 =?us-ascii?Q?PyulfjVOXLdT9xpDO5J/qmTVmZfRaLJo49zBBhGVYkimmWXkAoKxhmenRG35?=
 =?us-ascii?Q?fZGueJhMYi3lxY9hSw0QnEboVmWVGTLSrHwfZQWFopCphJMINWw1Esj9kxzg?=
 =?us-ascii?Q?RcRO8aYxAT1UZm5lvF+3We7PZ6jh5NZxBO+m7aEK2RrdGU7mCzCUx5AnR579?=
 =?us-ascii?Q?iJmDOfqHCu5+yOUxguZEIzZzGqEa+0nQVLZH41cgCVVxCf7fZ4hUjmRlTrSO?=
 =?us-ascii?Q?wFRa1I5doHM1o2P9kdSZo13fbKT/18FvOkehsVLLXVOnYCcXm/20cYtiZWKk?=
 =?us-ascii?Q?XolbTCCORm5mDJxy9DjfDjQYBBBEiNfohk6OyQ9H3tSyBju1dKzOVvCVS9cw?=
 =?us-ascii?Q?M5QIjtFwIvG/6/qDmr5aOpJO7CeAKdMLKqY9E+loGRpQdgjxBbOugKI6v66I?=
 =?us-ascii?Q?xwYydd3T4uXFSQk1TzgaWwY1pO+pcJMdAUOnkBQauMRI1T+hseIM0ZiF1/Gw?=
 =?us-ascii?Q?DD8+KjekIBLcZHQnFb4Cs+9NVJaDl2wkuLY2HTLp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96687c02-94f6-4283-dd8f-08db5c2d68cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:03:50.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzYqaR7WGyHJrD6mySJx/L3aStUE/QIedRT01Izy+FDSlJ+D+teG5ZHXu0Gj6h3kStQXBTNrRIlaHSVWHyqvNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8591

Increase pm subflows counter on both server side and client side when
userspace pm creates a new subflow, and decrease the counter when it
closes a subflow.

Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
address is announced by userspace PM.

This modification is similar to how the in-kernel PM is updating the
counter: when additional subflows are created/removed.

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           | 23 +++++++++++++++++++----
 net/mptcp/pm_userspace.c |  5 +++++
 2 files changed, 24 insertions(+), 4 deletions(-)

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
index 114548b09f47..7ada9cf81c14 100644
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
@@ -91,6 +92,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+			msk->pm.local_addr_used--;
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
@@ -195,6 +197,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
@@ -343,6 +346,8 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
+	else
+		msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
-- 
2.35.3


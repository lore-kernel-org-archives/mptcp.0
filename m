Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B01FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="xk2QZFQ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afCOzqiXDdacHdHCqRwRsZ9ZP13KRGbmepr3I1k+qL1W7AkHMfa6B/+gSCCMtAVSMtyvFAEOuw3Bm9+Ufh2DpRB/1eZQgllnspOPAr4R/v8AoeF8TYYZkyY/TE/EB571zwNYXJxjgq1FDptzPui5tdxFDFLyVmWDPK29FlxCFaV69gn20EX9NZKrmIQ92Z3LCCLtQubkf5/odv0Dmt/yUeWAcmKVzqVCbOsisch+mjf1aP0I+ADwHcpNNRyU0QIliRw1tiIAkr8AUShBcXXJkRXa+wf7VHpGNKeOyROfXjWlnuqT7CFdEUyUbhgXgL2vUQkFHzsDKsAa8/eRRxPkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivgYKh/6bg1mBc2+zmVKNxG7nYrY1EtEgxg+84W9o3g=;
 b=m9yXqXOoJHnimbLIqf1aLddJUMMot1inzeJQOb74O8Z5g0R2+CvUIhIOBPsHDb6ROcxWNwrDPpFInRRVXB8rlYRoZy/nCMc30KeWvl+00IavvO8OFRl1tgCUXC6tMeqaBJAaHjvJzm6wVl0YT/g8TkFdcvg9geQ4eHSLned7SsiWhfI/J3KrJY4KObdJ3RB9WfwNt+rmmvMkCfvWe0tNUVtDvYnyDZ48GevhZ0RzU79Z4P/hNmK8yZd31em5tkcLJadjv5IZfbrltAGJBB4SdjFVirGuM0bOP5pVC6PnWiQESn4sIyuP/+x+nkOx11kOD5tBfQvyErzt9D9PWpZbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivgYKh/6bg1mBc2+zmVKNxG7nYrY1EtEgxg+84W9o3g=;
 b=xk2QZFQ0fxjtSFDR3GzUVmd8X00a5NLNaZVyToQew6R3BnNCsgvmvzn9Yuz4JwgY1kALaBf1gPKGTMpZw27GPG9KBexjLM4GFCs6heBwI/L5SykBDrC3h7Lktndw9j+M5bt3sQU9STAYUDO7V79/zxX4+C9Ik5N6hVQ46lOvbcbAPx7h1ntYvJxIHR4crCuu4l2ZhGue6H0mYQyl39PKA/S1TmpHU4HfTbjhYyjppRFt6tVu+n4ECBfY2aBcHoWDPsaLo/VsuSbp13O21iMX4qG3KmUZNccfaGZhbYJ+G6pAJa7wftgMm1kvZ31wWH7HVYI/BfCUTQL/tx6i/NkUJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 7 Nov
 2023 06:04:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:04:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 19/21] mptcp: add netlink pm addr entry refcount
Date: Tue,  7 Nov 2023 14:02:03 +0800
Message-Id: <8e41010b981607d15aaab56c897f0baaf198d753.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:15::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 90dbfd1f-e441-4482-7845-08dbdf575f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TkYp4jk2wN9BHnefbCrgn1XVFXwdc2USU0zqkHwm8QHKiwtd2SJ8gHFJSyhms7tk3tCVOK5trvaioGLzVg0/jR08D9peCQJ5Y83gEmuH8Gvw9gDtXnOnn+isp5Dzan+W6DXzEhJUfhYzSAFRNg52f/REVTeSDdsacWiwp4kdoYMQTZZwGjc611RvmypdpB+RFvsMvSaDLa/YRSKQIzMvKAuWeySJNgui7VCMmd2J8ayxJ2KPqxlLi2GRtxkEqQkQD+I50dbHhSBDf+vU4Hu/EWtiwt1zFxcJDhoIGRaOcmQxTcL8hOcpjLO1HussReLo/1ABf4bKsv7PJom/mVvlXoWsl5bj1cGn4ZBSfn24JojXTZ04CJSR8ekKKYbwHiRpdUyzLedKSdry1wngZnS/0y6fQCd5e7qt4wX4qYJ6C+JqhLSKxRZDN/KO/ol9f+98cGIQXEifmQY35jWFJ1uLhHOoPxJRy37Ryiju/Kzykn6Y9SNuWXoA8eZ9j6zGOc1WViJqDDZgk6LaBAKI+TIJVivlO8D5yjmaq+IY9Nt8dVE8bwiqeie1+JOXSuEKvyrk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(44832011)(41300700001)(86362001)(2906002)(5660300002)(8676002)(4326008)(8936002)(36756003)(6916009)(6512007)(26005)(107886003)(2616005)(83380400001)(6666004)(38100700002)(66476007)(316002)(66556008)(478600001)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5xQZQKLieuK77TZ1HbZ7Y0Vbz7xcvB7qSo/wV8MFyYnkcHqWqlOw5VlN/H14?=
 =?us-ascii?Q?oURjxubg73qatyt79AbfpLxl+CH5c+j+tBSAm9bNbIDh5+ZRvg8cL5UDzwJg?=
 =?us-ascii?Q?QF/cZMqSJzj0qm9o/iCdQk2+FJWNSceUX0E0ZbdyjbgubrBSjdYhBmv83SxI?=
 =?us-ascii?Q?GGKttBeH57s4KOXZNFWYJhv/hRoZJzwTrmEPV6VXe/Cq5CqC0SBlV5PUbs13?=
 =?us-ascii?Q?RchpJ3AupeocL1dG/DED43xn6aa+dZCQoDKut/ZVxFCfxh12rj4a9NqnyX4C?=
 =?us-ascii?Q?BbMBAbl4aClCXvo2YL4fvkbb8KtmixFAFzpaAig+2ggUeZOMbqE7o0SV9oJo?=
 =?us-ascii?Q?nfT22QhDWFuMtgbCBez+NUqiYzB4E7kSBiIXMLksqEr8EoQ39fP8uVqTzj1g?=
 =?us-ascii?Q?B8Z8beqIAgbJpsfEChgu+NaflPIx+6xFG7+1C+Lrp6WOhLrlMeMLNtIaVFcw?=
 =?us-ascii?Q?pd3wcWIBtg61fLDOh61zNJtdPDhSZqBvxzfkRiFaA53kKIOua/bRQbD6efwp?=
 =?us-ascii?Q?fxtnIkvyzYpFcnb9WLRWTOB0CwP2qBsASGJywqQEnaNCHd9QfSown6p0V6gT?=
 =?us-ascii?Q?8xmiOijdO8Yd5hdz3c06SlZUxyqqcVoMqlCCqTb05zC4kx9ALU6Ly92WX96Y?=
 =?us-ascii?Q?b4ao5lHq1+HquAfaPHu3sZW/mxwRkO9AqRcWaTAm3a+gFTdp+os6a+31w+Ks?=
 =?us-ascii?Q?CT7TS5NMMCLlDbIsgjVgvzOW3Uyb779PQZMsvxOrHHixwg8ANDw3vzp2zen0?=
 =?us-ascii?Q?9qfFTkkGn2DKPNqM2Z4HC5aEWzKb9PgSFyevKWwzA3cpDd3oPt9LjX+JBfli?=
 =?us-ascii?Q?zHK/sP1C+Djc/F5MZKpDtFP/YFhdzmBLQNbI9q0Ydiv6uHVOLDjeHvaRGxBd?=
 =?us-ascii?Q?05CLlPqO+dYIcryud4aAzkQpOavPZcskJZlC1Hiuhmm0k0vxhFtWlKRF/mqA?=
 =?us-ascii?Q?Fx10UdnoClMSMGEr5dOwK+cMbBF+W0Ngha3ijHUXhcxI3LqPKiPxpY5AxBem?=
 =?us-ascii?Q?X/0BpmyhNVlulEppvI4cg1rxGiZKsGwwOaea5boivTdyjE8+Ql9YdCULPnbj?=
 =?us-ascii?Q?K5E6zWJInyoRxVJv9LIy3Peu/AO+3WS94Kca336h5LDMzwWHh88fLSECTrtY?=
 =?us-ascii?Q?jz3IWgnqsI4HQpkCgYYN3Or8ycLBx7yhpaxk/MzcAKxI0YfBa4eHVtWn7GuK?=
 =?us-ascii?Q?fJ/OjT5Q2FR+IKLWQ9Qwc9/ZbxyfnZPqt2KIgYDwoh3YR/CAmFtlhQ8G8HkJ?=
 =?us-ascii?Q?6WAlz7KOTt38D0kcIB2aOlfErtc52LRspMnDYS/OWYHf8+LCnWc1P5MBl8oH?=
 =?us-ascii?Q?MFSc04BQNBnN1dzhxbh/D7Qm8AvmlMra9Qm/BZgTA+sqdmLagmZXQxQLHCb9?=
 =?us-ascii?Q?KPUiSQ5P8F7PgJ3MSLEfqZJxSzrcoWSsVcb/HHP+xd0g28jFtNvDmXa4NelM?=
 =?us-ascii?Q?+1WBU85VAmFgU9glcdbyy2ydjATdaUePhGAeNFhp4Pcu2y0Tx/Y+4YFrTYxq?=
 =?us-ascii?Q?FWxm5Q7BY7cxkUwNAgrBNBNPRKtSJ1ks/gnBmLGEoNpi1I7MlRIrpobHXEVh?=
 =?us-ascii?Q?9Gkc4s3Jpn2ldvSnm1BihglXkOH+H/1ljIpAcu6u?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dbfd1f-e441-4482-7845-08dbdf575f0e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:04:15.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0acCwi/G1P319ju8GaNzasF8bp13f4oIUh6O4S5jISQEF+vMOOhe0VzCKLVipTHM3llXccbeeBfvT4HaOFtYWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

This patch adds netlink PM address entry refcount. Init 'refcont' of
every address entry to 1.

Increase this refcount counter when a subflow connecting or an address
signaling in mptcp_pm_create_subflow_or_signal_addr() and
fill_local_addresses_vec().

Decrease it in __mptcp_pm_release_addr_entry(). When the counter reaches
1, then free this entry.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7955b86c6b8d..95d99927b144 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -560,8 +560,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
-		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		for (i = 0; i < nr; i++) {
+			if (refcount_inc_not_zero(&local->refcnt))
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		}
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -601,7 +603,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
+		if (msk->pm.subflows < subflows_max &&
+		    refcount_inc_not_zero(&entry->refcnt)) {
 			msk->pm.subflows++;
 			addrs[i++] = entry->addr;
 		}
@@ -853,9 +856,11 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 /* caller must ensure the RCU grace period is already elapsed */
 static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 {
-	if (entry->lsk)
-		sock_release(entry->lsk);
-	kfree(entry);
+	if (!refcount_dec_not_one(&entry->refcnt)) {
+		if (entry->lsk)
+			sock_release(entry->lsk);
+		kfree(entry);
+	}
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
@@ -1046,6 +1051,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
+	refcount_set(&entry->refcnt, 1);
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1273,6 +1279,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
+	refcount_set(&entry->refcnt, 1);
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
-- 
2.35.3


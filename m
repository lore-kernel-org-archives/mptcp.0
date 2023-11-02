Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237611CB9
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="leo1FUCk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg0FHtdMYvDtRn9R3X3lozQZRFmyB+OSjJ1nuRC7ShwWcgcMcdohUxLzVyZ8TSjTl5wYHWjQJNXYpif5ppvvGou0hGx5gXiKhcpNGpyT43QNv0suZOe/hDcoDflpv7/WiW4Y6iGY/Y+ciYppDK4qB84gQX1K/24xVc3n744LVl3vKJK7zX/c39NCxFxapd/d+gTG1OkNWNttVR1WXw3FPHwmLdVsgKOa65vomF6d42Y+WlZ6Sxez/nn/dpJZwok+GP6iLUQtd9OAhGuS4RQOL7GeDKR8JkzVf66K9iZBMbKZQRe/mVkVh/JbytrVt9qHnFWpx/InDoIR0CO0FdvQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HciY6qmEyTpF8yQ84/ytQ4N2GP2VnQtU96TA0JiniQ=;
 b=FqO/XcPQxydMqiNp1L59pxn0fN87p9/IPpU7HrFg5tCHPsaIJTa/4j4jpLo8t3BmnLYor6SdztQbAKJaWsFd19BrPuHIlYdyCktlQSA0Nf9HSFjQqUSlblBT01pZoAt8A71/zBUEYbfypSOzDfGguuYFpJE0mCk8TT5kdzxedJT6Znd5Zp5vjpZ+gL2aNlw4sMeAKb9n+Pwiv7GkxqfUNIm5Z8bNVMr2KpOG+/wM+Gd0EqAg3c+b4FWiAX1vslhPNzJegQQCVgS1B7j/JDXJytP2V0N3bD3Trc+laBhHy4qmoxHs66YTTuAfvx0kJTdwyMJ61WdEuqkYCUJ70FN8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HciY6qmEyTpF8yQ84/ytQ4N2GP2VnQtU96TA0JiniQ=;
 b=leo1FUCk+3GrO+dpcRN+uLUry6cEpT2ooaF62nv0h0aYHcY+MxeJDTzZ4bk7ECXbyXPap9vqr2K3YqMU0gv7hm6Jd7vG4RGfyOa5FzF8OfNblQNQlmEY3NGly2EPIyRL/eniwmz0q7BEZrgeELMHuRpdePVQtnpL2JOb3tmZKEMVOSlpnYyLbuISsKeci/GcdwVPOMEHK+sWGa7Zk+LBJn5H7vHlWJq1L/9AYPCDl/9aeJaUHmPXME9dTZKjGa1t1fdJoe8SXhTWx6Ha8Gx6g5qmSU3qWIUiPY+YP/uOonNkHvPr2Ze93ZWsJps775tIxstsM0PmjfwFjLiGaOk8eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:51:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:51:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 07/10] mptcp: dump userspace pm addrs
Date: Thu,  2 Nov 2023 17:50:50 +0800
Message-Id: <8567c7a17a8cf7474b022dc656aa43b5509cf485.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0180.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: cad448e3-df95-4cda-912a-08dbdb895496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gpvY8kGK98luSS7dxJZcE1j8gDqchiuJnI7luy4B8dry5U9HPsZ8e7Q2HxgSBzv4avoyqOZly0O4jF0XT6RdIGbN3/BV3Ki85y0u/RC5H9+N5n3PLyg6KDRDb0Pvl4ldIfl3QBfKzcWlrj7dkN4+gOxbgpLbwWzPMQ/1cnAHgS4ndXbKHIjU7upEtfX+eRiWNTYmu0za4pUA02GxL03g2AQwuXjeZuQOrU+FnSubjScz3PABO5j8R1MN7APpcEM1YCxgZt7ti7q40lC06jSVJq5ZtkUrbiJl1ASmDCVna660oyEBSoKaPrxUZPdV2meUw8ikohQrfiHOTcDqXiuZ1MgxlIThFuudKe+SLESbJ85DWnvNpIQwEUATO7BIzrlSMQNoLQl5XJ6/I0Uj1DU3+x7EAuV1wbnYw6mf4MHGPRXN0mRWBiQaOzb7HAoxtRbyAlcVql4uMoc2kDTwwxd1WR3SQOnUFX538p1P+6LO2a2Sc9moPJHQ87scsL4vScIVveURTxj3yLKDw/bbjaiuL1kKfH3jL6/vRyPRBW8/jsvK9aD8w8Fvo3we0L1Fq9b441u1Gm2OWexc1o0cUqpOvEuwX3+ysswqFzwi5k4hkSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(83380400001)(6512007)(26005)(6506007)(478600001)(2616005)(44832011)(6486002)(107886003)(6666004)(41300700001)(66556008)(4326008)(316002)(2906002)(5660300002)(38100700002)(86362001)(6916009)(66476007)(8936002)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmXMWTzU+e7NTLlm+Rot/l/9MPZjPR8/e/1U7FW2LsEKrCZ2feZyoVp19BRp?=
 =?us-ascii?Q?Hb+WCZUCxCd5sOGvx2sBWhdQYc2ZMh43qeLI3unBHtJYCraYdTO8eqTt/Sdf?=
 =?us-ascii?Q?SRYgVZJRkAewjB+OvZbsf851lPj/oNVHm9JTr279SVfmRUE7YdqbTS3etvf1?=
 =?us-ascii?Q?aU7pRzjYE10sAdHRe/4vmBJVoE6JfRyLpPFTr908UERhVnM+ZZ43dsYqFM/y?=
 =?us-ascii?Q?AISpMbbWQ7dwd9h+9rPGTu1r0gvOaY9zdPC6GBau2OtYlaRPJGpS1XVDqaqC?=
 =?us-ascii?Q?NkvjLgrPSNM3XZOvMwbF8lNvCvBeOYRxpROeW1GIggr/bf0rtXjCOzv5ADdA?=
 =?us-ascii?Q?FHT1wGwBj8HOBkRuoX23awoEBUpC2hsw6f/BGtwpYaUJ6eTl+CdsUPCyy9jZ?=
 =?us-ascii?Q?E6w5wHXKp0vMujGvK9x+mUYBVUAZSAaVs/MUKRBwOpxj6P0Fpk9/kHh1wn+J?=
 =?us-ascii?Q?0FYzdsz3K4cf5D+N3bEMijPd0p42PEwPG0K8NjH8njK5XBIE6DEPnP39wkzN?=
 =?us-ascii?Q?1/RiK/CC9EvF7Va5xPSfz4+vBTDl57TDC/HXBPmAcPReInn9MrKDOp+95vqZ?=
 =?us-ascii?Q?SrBnk60SzdGE6uO3+Flp5GmFRYuFx2S8FeK1nWEQhjApCQdiYTbZW3A9AzNr?=
 =?us-ascii?Q?FsuryqkpD6gHIm99R7hDrJFYOGno05ZqU+S23tD7VN9xSLxKEZc/0MYNNhii?=
 =?us-ascii?Q?BfqqbdglogMrjU65tmXlkBTYdkWCcv9HpaBobJkRRCNCiPZOIDk/JSdiObUw?=
 =?us-ascii?Q?Wzp2kLGHcpgEWTHZa0vlunJnSNOnth9Hvec/L6Zqi59zVnYzKEvWji6r46zt?=
 =?us-ascii?Q?TYlCL5yIUZxgj7sR7NAuBFYYf975TBFFoBb+2TxKY97w3T0g4nVuvv+M/k9k?=
 =?us-ascii?Q?OEH15pDOGuy8kHiFPLiCK8ZCEslgkPfxEDgDyhCEcXYtfbDpMOHWGbOp3TH5?=
 =?us-ascii?Q?C+BSCAS42dhCGOwjg2uLRoy78BBQx4JSuz6Y4c4Y0dHveUHJib8aFurR+klB?=
 =?us-ascii?Q?HY0wpgfGtHZXD2mVZmfCVDLuWdyH4wgHpM1LJWtn+ObH1iRIIgFuCH1G6oMm?=
 =?us-ascii?Q?lRkGJ00XqsG4BnEjnrgIGoUx4baj/p2Ju24VI9IYlrcHE7RM9Aq6YX3s1yzl?=
 =?us-ascii?Q?l4fEFrPiXwdlWU8jTRWKg3tGGfR7YQjLK0O3jCqGigf/RQ1PTMTjo1dhHg50?=
 =?us-ascii?Q?m0nmEl6XSMr6XQBimPGnQb7kbx2rFMVNyVD28ShL9uSpFYCiJNPU4KGoqdBI?=
 =?us-ascii?Q?s6UaIFP479y9eayzuTOxYd5SgkihkH4BZU1FJICzTWDWa4CtTt4L4B+IyjDS?=
 =?us-ascii?Q?sb/mLcpu7kMmQ3B8zsQp28AEfhQSzjw/ww+VgN10aVyjI53eXgKCBjcKy4B2?=
 =?us-ascii?Q?iyBSm4WFHXokVnRCjx2rYit+jsmSbxZiNfNhzISu6qgkQDuMyxx5gf9INMvT?=
 =?us-ascii?Q?HKzoQSzikmnikLN6jud0UELEEaLVK0pSPpIw/D7RtJD2ulfyiTWWY5wags2M?=
 =?us-ascii?Q?0trYotVBGd7y1scWwKFeCo2bZzGbjO3rfiABQjZWRADyK81h99rLwP4adIHI?=
 =?us-ascii?Q?L0aUzp1IyaNeUc89W+TCX6EmhAA8arRfoa3fIydj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad448e3-df95-4cda-912a-08dbdb895496
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:51:48.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvNqmS6MEa2iHtJ4XtZ+hbSxsBwPgx6MsvzDcETXESYMEOK2d85Lc8humicl9EchsqHtj9lBtDJSjwEOE662bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345

This patch adds a new function __userspace_lookup_addr_by_id() to lookup
the address entry by the given id in the userspace local addresses list.
Invoke it when dumping addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  7 +++++--
 net/mptcp/pm_userspace.c | 26 ++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index de2026f10cd3..657db778a084 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1744,8 +1744,11 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
+			if (!entry) {
+				entry = __userspace_lookup_addr_by_id(net, i);
+				if (!entry)
+					break;
+			}
 
 			if (entry->addr.id <= id)
 				continue;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f5676fd3eb55..8166d733569f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -582,3 +582,29 @@ void mptcp_userspace_pm_flush_addrs_list(struct net *net)
 		cond_resched();
 	}
 }
+
+struct mptcp_pm_addr_entry *
+__userspace_lookup_addr_by_id(struct net *net, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry = NULL;
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+			pr_debug("%s tgl id=%d entry=%p", __func__, id, entry);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return entry;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9b00eb38b2c8..b503f8192341 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1022,6 +1022,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3


Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F1196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I9CLStVL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We1NOqV8WBD1Qqm5Uw+L6WESOUYaLQwELmsxjprEDbaDd8PAuS8Lr4XfC5BE3ORZ/9JVgDjlCXBYQv8h3u24x2XuE7UzlMxPDjJ+0OJc/6zWtxE8gwBkNm4uzHFi52btmr4AJTE1PPhxYBvKQVRIw7F/rpxGHDpFSp9hP5jNnIZ23VsKHH+p/Yn4rU5Uaw25wxBKZJW4ZKkff9FXb0aMBchzSTJ5OdUzBuMu4Uw6h52RzWqmVTpf7wwsSS9g01DLL5CREhglOKf7+f/2292XPvwcg1R2DGzvCB6qpPtwzSVJYQ3fGZ/JmHFSAvG7CkdVUMEmRcdZLFnIcEmla+4XxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yejkG8egd9KI3YkAYdBh6SM8V27GVst1ji69busJRM=;
 b=BvfEkpva7sny0efrebSlUln2PJSI/9WyyWii1jiIOJoiiiDIl5bLJQbYWZhZsMUqh1itolxayR1330K00hv5MpJkJsbr+P5Qoxv/RTGuUk2FecV6gnza4oYqf2q0CN7SGMpLTfer1BYf3hs+Fhg3D6TDAVBRkcv4vs6OMpUKdEz2cgnJVJYZNuc1OLCbs9BsuPCY63yUNTnOOKNXIyr+vCJ7HB4D2W8py5Y4/GOKsdHGwx8pAvbdWru1twehx8I3dovAU15dVCrKMK70W5qHIF4aP1Z6x2Vc0k4TdwW2ULqVjgerEDiItCDfKfAJcI56vCwOjlF8o98pJ8peSAx+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yejkG8egd9KI3YkAYdBh6SM8V27GVst1ji69busJRM=;
 b=I9CLStVLhpWbztbIiTwTJDF5SlVw5FGmGAm35x/Qv1Tul8ZgJFnr6AbhSrgDng3E8TjGQOwzTaG7uHeQ6t+kUAHuM1Hl3sPk1PgoZRYB3gOt0gkgtLOCn8KPeFFDbGclEgwrS9svY7dNMosCaB6r2CatRJgqI9DRrENZAAhtROrXa6wQfPJKTxdEYDBjgv0iNFPfEVJrtCx3WFkfEzXPR1fK2Tghq9ZkeMAi2KW0b4OCk3HoeTxNSJBFHiG9E4wRHzwsZVUpVccC8EW9yT4BCtTR1CzGGylcmYzY5Mv4xzfsRhgdYM4gpqWtrwM0TH9B4A1bgoPweHzfr3Ak7sMvgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9174.eurprd04.prod.outlook.com (2603:10a6:20b:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:29:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:29:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 10/10] mptcp: add netlink pm addr entry refcount
Date: Sat,  4 Nov 2023 08:26:34 +0800
Message-Id: <eeba32c03f10982df26bbbf28bced00cdab8182f.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7ae6ea-0a54-4c61-8696-08dbdccd0e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4XA9znktcveI46+JLXv+L5dj9V2+lz3nnfQlAhFQan0Hhrt8aEK64csLfgHvUMwwQTk77FUZ/N+Yb19HZRT7RIS5t+Zu+qwjD9007xCJ/UoEiVZCimMS5CTEk03JcHWaSCtJT++ZIBbOysz0+/4uiBqVPLKDgsFNdYXLkxaT6xD4gcVgEiS76M9GIgI9CkCcFDWEX8ErRkSuhIbQGINqToV362hBgQT2dm+K3/0CVHhxaGzhhwXdW1gOFv+EWXqtduGc9dSXeFScpaGEV2v21O8sLhybAy6Zlov6HVTDyPfSkc70twjd7zjWAN8lMVJpuPFOZizhedlq9jclYvNFHJvsGmOmbVSBQ3dHic7KGzE2VGVXyDRdqoD0aVx9fbVfghGA8HIXiVCfG9Zq3sTKwvIz5N1piiM6IIypbsKGUOHrBxRGkwql7OizuHACNTx59tleGnkVzUVm5hfb+UEHAL7fmq4ljK2Wzce99E0jlv8PzOJt6TMJDXSo+PWYsflqxphBHF51p0iwVIBvaArjG3uBxASCdxoeuhR31zGRHU83yQnXuOup1PcGWdkb1KeK4snUbkNvgCf3TiIIh0ObKOj7uVH2J2AcD+pm56SwhMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(107886003)(6506007)(26005)(2616005)(6512007)(86362001)(36756003)(38100700002)(83380400001)(8676002)(316002)(8936002)(6916009)(478600001)(4326008)(5660300002)(2906002)(66476007)(6486002)(66556008)(66946007)(6666004)(44832011)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vyBcOr4Pva0sKpfm3jdwrNThcgcXSlfmj7ofr25cXbJlIM09YZzvmRbfNBNq?=
 =?us-ascii?Q?B4nYh9wRlGT7z+uClB7ppAFxZ4vd5ZKLM0NlNH2RoVEBbNpHw/djqGeOBrCj?=
 =?us-ascii?Q?fUK0MNJz8pCOadxRao5BL+K+LFG0PTf7x/OIWD2/X1SJs4MPhqL9J/B2xdCP?=
 =?us-ascii?Q?6k/O1DFhZmDjWr7RxckXJ5RR2n5tNc1RPjgCyTtqQAGuaaQRNdj2iNnn+RXm?=
 =?us-ascii?Q?1jNvK8+R143E4lQuJuktO1ZwGNQTw1TlfZbazFOhY8r/U9Hqmf9RPNWKnccZ?=
 =?us-ascii?Q?B4+n8KcGLuXgPjtKQS6FuA+m4G96Wfv8W3RUnQ4oGSGAas2rK+LQ5vmikRVk?=
 =?us-ascii?Q?WPHudg/X7+4lAnKt7IRVIsOeBPkO8tk822shtZQ3nJdRtDacS8ccpJcZrUIY?=
 =?us-ascii?Q?shWYp6MNGWqUp8EZi7/a7uqgdfSaGz6N7F7P/xlI7u5zwc23X2+Cy04oplYA?=
 =?us-ascii?Q?lMJzx5V20n60CyKYptPEm+/OcEjsmxH7xbM+HY8QXG53gRzejgwHwmJBO+O7?=
 =?us-ascii?Q?U2k/iL8VMZukymVk86seKIgxFcUmdsyvAuq3zIa/JM0v9PRbr9B7PMlglFIH?=
 =?us-ascii?Q?25lfMfQpAekThSmrlP2ZV9LIsXYumFlGNNJhOx7Sq0J4a8iqnf8iANef5HI/?=
 =?us-ascii?Q?snpCt2VhOUKBpk4xMf0nanJA4Q0UklWrGuUzFCCcTTx2IVGz/FGfMO0NPWUq?=
 =?us-ascii?Q?ZuDnt2+VcEdhg3x7+qasHBvCRCYsfcj9XjcDjESK28eMghnBh+izUuaJEZZs?=
 =?us-ascii?Q?jz+aSc1G5KDcXM7u0JEGjEPUvJ0s1B0C9zgLSRJVqOlCnr3p2gXJzn2CYl0f?=
 =?us-ascii?Q?mGyxWjtaIYE1zdq9JNVhsWehbSycRrj1ZQ9K6tuMt3nCvWAlr/MWlebelDgG?=
 =?us-ascii?Q?SBKRahHevBy9CcTcxFom76PtmLOPs8C6Y039AObUhiLm48/DC5q0CbrosE8R?=
 =?us-ascii?Q?B55GDXWRYc0t/zJHiSk9ezNKWImKNkM9sAwNoaTZyZaVHd1xfRqBMpxbVdlR?=
 =?us-ascii?Q?rLgMBM0bCltwiN/EvjBmwc1mizq+kgfrV1jlWnmJhV8C/FUZhHp63NRV8Ud1?=
 =?us-ascii?Q?FCC1Xi2VavL4RQBxmGUKTR1vV0myLMcQxVUEXqGiAbZk5ouMT7ORsTBoJj5c?=
 =?us-ascii?Q?RfCMs3wYaiVzvrlLdklmQ0EMv9fHA+6DPvB6oKrYeAoyCNo0cPNSmG/kIwR1?=
 =?us-ascii?Q?EA+H3d8D1mU+wtUelP+by1uSGWOfLG6L2JBKqr01j/VMvhLxaWbewhA6VtMK?=
 =?us-ascii?Q?zOyXDTxeURQf5Vql8BkO8krJ9LYl6ScBZEmVvIvMBfFln46WcE8CeNZedC90?=
 =?us-ascii?Q?nztpxuL1O/2HdAo3ckkypecdhBysS1CTU1zjkU41qu5+eIZSiKkXhZIX4Jq/?=
 =?us-ascii?Q?m7+EVIA9bFu4uygJAUOQmrncyGrYtQDCuGZ+SzloVjRTOL5aCCA5c3DxP1EH?=
 =?us-ascii?Q?PrdsRxgSdjFUZQu3BWU05c5lGe7eb8UAn0gfdFgNvXPH/GBR1P476IomI5Yb?=
 =?us-ascii?Q?E+HpBSSNGh0zK5oxq6nVII2b+5ClWtmHVQJIVkhuJ139rHeDQ57oibr9SGzd?=
 =?us-ascii?Q?zunegK2ZzVH0+rtvtc7N47B+tyONwod5YzdACJU/6oWcNzcId8Xi4x7w+qZU?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7ae6ea-0a54-4c61-8696-08dbdccd0e09
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:29:06.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw/EdxYTnqfr9mfVReaZXntIJCOgxK51ahkL5fcztEPzShvPvyEvOD4cK6DikSVKAdUOjDuFyZJmK7y1yD0puw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9174

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
index 1a66de9127e2..a482faad567d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -637,8 +637,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
@@ -678,7 +680,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
+		if (msk->pm.subflows < subflows_max &&
+		    refcount_inc_not_zero(&entry->refcnt)) {
 			msk->pm.subflows++;
 			addrs[i++] = entry->addr;
 		}
@@ -929,9 +932,11 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
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
@@ -1121,6 +1126,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
+	refcount_set(&entry->refcnt, 1);
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1348,6 +1354,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
+	refcount_set(&entry->refcnt, 1);
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
-- 
2.35.3


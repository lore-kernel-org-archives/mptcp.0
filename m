Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F542595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M1/HnftM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/PnCNInnr1taV1tR9fJczAS+jYU6Vg/hF9dpDhyRDuQtZuiN7kuti3MJZJf0N43jfhoKKXmGhBz8CPE0IZtFA9WaXpz+AN4/Yv5zGj6lKYHPzr/Qi4Z3iFiobQOTeAONBFZSlZZDoJ/lCe1Gq405ykLydADGpxhZpOMT8P/k9V31IXgQ/Xi5wFlycucLeE+61/5j4gNt6juqYk01Ol1azutsAoExwLSnwe/yVSUt+qrwDHSpZJDlcz+843b3r77BsUO6+sns5ya2+zhNxxWQkvqnhHix6vYm2SduECRYxAs4sdYpZwPd1npovlGx7AgLsYQpYZFUst7FSdN9ricZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=498iDJROq6xiw1hcV4dV0i/TuAPng2bf0YJz9XaBf5Q=;
 b=NToSnJxYoraXFXLkZVESreefH0iow0LdSVXXvjyZ1zOInCNl3gBdiME6GpeEQmPct2dHl6/nxGGgCipiGemmQHhBgoYVcgb8JTP71Pscu6eK/TiIRJc1ynvB0u+WrueS+1hZaYxOs05MEHdJC08bz7CDzIXhcL2R9Ote2tbRj+JOuaEuCbsoMf5roOXCW/Zd9mhHLKt1xiBvMjaXYmd0TknOs7rVfe+7pX3VctviOlcJXsan4PFSQlF6uEDLf88rgt+fa1YpFxNe/PBjE3NwVpxr7cV05EtWhdUUTZKxmi0Kuhl3+ANnmBXCA5u0CM4+13x19kK3J+XinonTEm+sFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=498iDJROq6xiw1hcV4dV0i/TuAPng2bf0YJz9XaBf5Q=;
 b=M1/HnftMycm4FF91RXG9iF8uWpxF5D7Okqf0qAPUBVbSuNWtpQGRFV/7g+9/j2Ibs19HzArTt6484dvsoOpvoRD25htpaR4p1kwLBYA4VTm43/HdeYmq9qGLMS7O1OLxR97ZLX1STfWUhtnt11AYlmuobeJtEYOd6dz96io7ZB3iNGMmZmksAc2VBG0z26B0Xm6sQbK8zHat3WLSCgB7skzU8lgwlGWnRN3RA17N0kaLorH1kTpAoWvR11doHHJ8x9/XS1lcVa0W92QAtexeiks5MKu7LGJQRmTz8pt5gn8Av8yZTawnwxTdnGndgND5pbJbJnaNXPgcUrqq12zN3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:16:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:16:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 14/20] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Tue,  7 Nov 2023 16:14:20 +0800
Message-Id: <586878ab90e021c347c85a2bca423667d6993274.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da392e0-96fd-47e0-6dec-08dbdf69c649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GknejAwdqksOT7L8d9HQPCqB9+N1eqxF9wkYpdm4EM1uEcgE2WKLUEvFZB36fUxMFNUWpp2O5QJGmiqrxg+cTfGBSSaHbgY1iOp9gBDVfPKk6KCubv9Dvz2ANVunIaPcj5JRreFO9Ozut/4rpF2J6YrxyrGGrLZBrxeRVXefHBfGxW6H3wxYKCEO68s2yIrHiKwWwzbz4wSC81/JXq8rFruvesSQ+SnmSu9SasW8PDjCnyAPLTdAOQLfxYad5Me3JsW5RCiVN405Xq96xq6WJPT8hZ0BQiCpHRfYbkAXnNaDywIFEP/HOin8ZMeoV9kIJT0QQqzvfcKL6TkyivIts1Sf7H1HQPCFRBIcUcQEHcO7hMx/+XYs/2xQp9/HzrLr6qXW5I3m9UxL2ZNKSiD/XueMWSgEQVPfTuOkt+b5tLG+QR1wcVBt7C5F/DQpbmOJgqpNwUfp6jepfulnR+vvN0eaN5jp6ucbXFSVdc5lJnrkP8GhUUE0nTVBSnjMgAqLzQaG6lIl7sRVFEWeCI2b81zWGx4ppMhVR6HU9h/W1CCj2pHrgaLC7VvPSL/m1QG/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wpry0zkIiaOy5fvM74SNQE2FoMn8w08E3lG/IfqQGgatmvUAML1PW30jofbp?=
 =?us-ascii?Q?mERf/a+WNceYAhK/qC3K6+Pglgg6PQzNGCz0XFxXT8BqWO8JqcNOyUum7GKw?=
 =?us-ascii?Q?xCwR7/ub4z5lGDamN+0rUd0P+P/11NMZSMdGNw1mUeMyb110zDovTYWXco8t?=
 =?us-ascii?Q?ELZlr53PEo3o8jWot3dAf/pGqyqaW4IAjAL4EmHDrngd2I54ItOg0JdhaP2t?=
 =?us-ascii?Q?7D+xxfak2L1siuuab3+oRM2M1frmQOLt81SIMh57JQobAO8bY3iTVG0/iwnH?=
 =?us-ascii?Q?NvdWILzIpU2+AIEyapYjVsSERabxXyx+qr2EzFEB4uJyh5YyVXWYwdfxFHkt?=
 =?us-ascii?Q?BOjJQovuIky+EafTqCQTw5Moyp63v8ekPlMH8o6WcTFENXDwOkfIGQaDhYzp?=
 =?us-ascii?Q?AmrqGrUW1glnkM7PJ1A1fPwXw2svLNOnNLmrXskSC/FDhDEK7nXiX2D294bT?=
 =?us-ascii?Q?K2TCya/Ese++v9wwugWnINpqI+7qjkzeuiaHA8NLZsSkv7W1T+fApAOb4CXX?=
 =?us-ascii?Q?UCoYmXTUd+/hej3k5Vf4EQuJ4zYTilswblAnQ1g52bD/5k7vtNQptDFnEqyV?=
 =?us-ascii?Q?XV395muc7ZuUNpck5frZrP9NLaDOgyOfs33ul5MslJOEwqdRHqSHtvs0ew/a?=
 =?us-ascii?Q?oF3lfhvUU6LLFYMHqZWiAbDBgzmSYnDpt21/l6JVgIyliTbjjOQortrjnc9R?=
 =?us-ascii?Q?nLrHe8/7WTo7ZyAPtZQwBNYMY/GdzMK7kIONkNtEzHMY3or6ws8pMdQDIpJn?=
 =?us-ascii?Q?FtiLuylPYSUlyOnlc7mj/oBVJmPDYLHCd+dr/Z/xerLwwBY4E5nYv9WJ01dm?=
 =?us-ascii?Q?k1uHAH47s5S81heS7z7ZGeG1yXWiYQDTwiifU0ocVZBHRPr6oGMRiwOlcpbD?=
 =?us-ascii?Q?QhvvJbPbX6fkhyh92XYzbOU1GMvEH74oNp4ykevjeq9yh0/F/aiuMZA9Dd26?=
 =?us-ascii?Q?4vUxz+Mj08onqr9gsIaStLK2X9+RoRj+G95xy2tPgc4uudilG14lTytoyF3W?=
 =?us-ascii?Q?OKMa5wdguzJghXKzg1e0PsqxadFTp6Cf9DDaDj0YyO/VyjOlFxzZHkLGJ4rW?=
 =?us-ascii?Q?Kdh47Cm5fQTO5eQAhRX70Jf2ZRE/0No5Nno1MsIlNvYC5qUVDDXDQ3mdYrW0?=
 =?us-ascii?Q?2Sski0lJjyv9LPxxOI7oawhM+RIN1aN9Je8bS+t0CIIUY0c7ctVs0dEtRWDd?=
 =?us-ascii?Q?3z/gprhMG4LKZ2VxZ2kIhOb2kbuGqgv92g0rv/z00GC8f25wtvpKF2qaDZFy?=
 =?us-ascii?Q?fD6WQ6jkc3x+rOd+xA+l1Y0ADOArGXI3z/lU6+TJ5dceYSNS7k43VAAwoUtJ?=
 =?us-ascii?Q?8+vd9bCkvvpkknXFQqaj29AOgex0N6LLm+8h0r1p71pTDypHbddAJxk3za8P?=
 =?us-ascii?Q?Bzi3diCObVIVE+24tbTjkvanK/1KN2IqvNWKe6OJxZrGy3mWp94PFFxOjYkL?=
 =?us-ascii?Q?Xan03f3Wj7dVJrsHuDSAvomyf0HuRF2SAn7C6PZBHFN5FMdgMu2kJplHdP21?=
 =?us-ascii?Q?KarURoIr1VVCobRIDoDttPFIHqMmQd1L62zSkYgHpAmBDg5wuis3IbukKDH6?=
 =?us-ascii?Q?IS6j22h6vD/mofWgIIq7mQye7WpRhNjt7TrN6cgf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da392e0-96fd-47e0-6dec-08dbdf69c649
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:16:00.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bi/oMaFfXi9+hvZeT4v2vTQa088C2kUKX0PiknZea8z4hHlCn99qcgeTXGVDl90aFfPiOTmNH04V9Xbtqi/0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), and
use the newly added helper mptcp_addresses_identically_equal() instead
of mptcp_addresses_equal() in it.

In mptcp_pm_del_add_timer(), check_id can be passed as the new parameter
into mptcp_lookup_anno_list_by_saddr().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 13 +++++++------
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 77a0e859076c..d5ae2e775059 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,7 +259,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cd16535d444f..7955b86c6b8d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -201,14 +201,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -288,12 +289,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr, check_id);
+	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry)
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -308,7 +309,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e66b1fb7b522..d0eb7b84a262 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -919,7 +919,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+				const struct mptcp_addr_info *addr,
+				bool check_id);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3


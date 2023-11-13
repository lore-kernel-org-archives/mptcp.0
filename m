Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F96848A
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IAs+VSWe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hffrteulvtdBj0FgA+zYyRGjv8CK2OZ79LRk5hUrfHi261J8yyeIO0Hjhk4w55QhY9tO5pfBJyoTYxmmjgEL7UpiM6CqbhZYmLzNfymTvo8GDcLp9+r04IoA6LN6r6SueyJaojVdP2Iof6NizLrl+WqtTFw+04+rcw27ytTb8fNTc74Zp/tKxSawmnX+KCfEGOwkY8Ws4C1GG36O6iPEs5tOn5T7jiW9mISSyz86ypXKn6pRFknwhMeirM2RM2fRHvnTW9uU4vylQFYFlNKU6y6GIHzJq2ofg7t7fq3eQykF1irzZ4NZJ05YJn7tPe03eBXDoasP4ov2IODBLf3SrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=L3myPhPHnlaiA9ucEaKcbdYH4d1SXUSua6u+I0glYEZ3CvqfLpZYH133nj3uq4vIDzN0KzR+Qs40KkEusJIfPK3WDRDcviSzjihEFvKKY/iVhZ5/AVIYw/TxWElBClgifz0yjTOFVUJRJcheNaBmmSiDrgxkB5PxAqs4YiST7zL+xI0LkCO9AYok1S8/23f76G+mKBJ5jPcBB41cqyh+eK8NcF55Yo9RmVbWd8WnFMdcMbIO14g+5J1/aE1geXDKdOVsKCW24wKVI2L4gfn0V/2KHI2bOfqGCPuzmJItWm/O+wKIRqJNDGDUHnDU1mnnDrXdG0qXQohg92duTOvMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=IAs+VSWe80to+B8ftkFdnETQz11+MrMk+oY3TFpbxPAtscDM0rauLxfLc+4OmgFl0yqUCWnB+b7uLeOxdVuqv2Ry9GS1Z5PuJHXdqpyWkIk3Lhiglno11wrNiGXJ0F8+rIssEXjdpiMTus2k8HLWTiO+ots8lvi1Kyd5y1zL8VRYfzXXq08xuXpu0HyX4T35Yyp03l2nYJkdyZHOkYpXUFeC0UC8JnLCIOqSm8GCjHLDe/cJNflDtsd3inaWbDVIlQel2IWjHlQ5k8sPk/ozCs5MANWldiI6inQxLT7cJh0AumXaBg6mYAZ9HAzvRzeO/gs0FUe60wIibUbE3/FZWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 05/22] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Mon, 13 Nov 2023 10:48:49 +0800
Message-Id: <43520f8214c70ec442c5f9b9cb9e56b90b75ba31.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d1d83f-393d-4a0e-2d30-08dbe3f327e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qjr2drlAVLuCLWRLWHPpEqBV8PZ04u5ZgPDOb05ys38M7qiZ9peCWuicrT2pDa5L6p7p5vWMnHjbe3oZ4n+oMwIHCld1Zmg9DosVyMOALICiBZiJ9AIKOEiU4F+aG3N4FHlqY+503JPrZHFe6iH3b/TkpFBQYNRlIhEu57xBk0uGzja3mAekDFP73gQnapNWVAH46+FtoZokgT5s2GBcSO3I0t2IAYFXodOe8afntRSZCg7WbiArhZKZ6vIv713a94rclaGjWESiKHI0zpfPo0E/B56hFjPqfsU6Hzg7/NFndHOgGhtvnfHoaoskgO/Ny5asHNyrldYTVsql1YJTwt4+K7COIVvyYyhjy5mQrKIPnhK2PbaunZY8NC1C4e7xW5O8HTqZgdwkaOc6IgZ3BgMAFPQXRTcC6dsO30NKy8Uxxi5HYwG6vVKockenHLLoSUhAx8E74npW3Ex2zA0uuWsR1ufXgtG84/zMpsZAGCFjTzBYvFJXB/gT9UO85TLNyIsRv3POaluwjWm0i5V6ii1qBCnYqUw1JrI7Yzln6qV/QCtW9ISABHXGjWVqU+ko
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3SL3AEEjL5mSiFgA6sJGUptlEnJAV5bAAaIkryGnwbEt/qT7/oOBB199tWHA?=
 =?us-ascii?Q?g2VsaS7BeNw4FUjBsseVUlZxDkQo3iOxTmLsDixvedw7BOkg8sq0Uk78C0l7?=
 =?us-ascii?Q?SXY2UVu9yCXQE5S0y+LKMTOGOktg805jrO1UG+UlVUL14GCkD1cCfaqcweG6?=
 =?us-ascii?Q?CgxQxqsEECVUoH6VQGedD7SXk938IIi0iooGjB3hlaho0813+5RBZ1hO/uC7?=
 =?us-ascii?Q?a6G7Eke165OqwgTwjQbFZrn3Nhi8skjXc69T/hIEhkxvS61ZvwQewGMpu/TP?=
 =?us-ascii?Q?0N6nVL7uRSXdGn+Z1qRMVniic6aiJvHDh1gsSPfvLr/0LTf8sxcanB/1Wt0r?=
 =?us-ascii?Q?OGWr0ke4/Di1HnGSl4tJC9w+OBjcmLtjDcqcs55SoqmagIdRj945bElBrE7j?=
 =?us-ascii?Q?gzOhEdGo+t90Wfv1Z991hOTKNB+ai3YQlgXzoAb1Zj5kCPcp9b8hRQg8Rkuw?=
 =?us-ascii?Q?AgBh0oUyC0K81Cyvr80w7XO+FjKDOrJFVaYLUeBF0jz5Xz8aNbm/OcWzBYKU?=
 =?us-ascii?Q?mZlmmhfKqkvuUZpHP93uBJKE4qu5/HYso7wK1PIX6RzxHoXAwsaZ0g6apyTK?=
 =?us-ascii?Q?mRwFyFYsnHFeQ5MeN6YuKwBBRiM5gjKDaBoTkF2lULT9Ho55TGykRKovIqas?=
 =?us-ascii?Q?mLxWGW8N9GoLX0WvX0Cx0H7aavSslJWyfBTZpBAqD5d361HUObn55tOhKuoT?=
 =?us-ascii?Q?yFMzjKAci0r74cZKf5y8jBQZjhaViSGM7w8rPFT6UlrwcXf0ZT85nH0jMc+J?=
 =?us-ascii?Q?7k32nAd5zPoBERTnvP/D/MvY2EZ+s3EklEm9xzPT1KGazF8Xc2hGCtY9hDFv?=
 =?us-ascii?Q?SZieYSs47YLdZPQ4bDH5cIBoNfE73NjOyS0998jmRtULe1FUV6pao0gPy7Hb?=
 =?us-ascii?Q?/1u1EcpruQjDk6XUpVVAOOSMheB38Yb65gdJn8DycTyFWplubFRf4WwyARYS?=
 =?us-ascii?Q?Bg+R1bhAEbNjWujdqOCYWXdhJJjXPQ2xxI5UXI8Kw5Q8FIqVTCv0QitYc1wP?=
 =?us-ascii?Q?9/35172hyE7Ttd9icu9q7IxUqz0UNWWFmKphzFA8yCzoCmud26nZ13PcUhfw?=
 =?us-ascii?Q?1GoInhGNNaQQlYvoQdeIBs/AWQApNKHnbtlTZSdu+LQKLN1ahw/5zoOcKt1V?=
 =?us-ascii?Q?aR/fpM8lw53w90vEbKR146uPc+oRtYtelnT8yTMuvSKOke2FVGNl31N/SUmz?=
 =?us-ascii?Q?PvFs+h7EXdN3TNIZHU2mkbLAbhm6ap+tRoOxQHIE2JKF20T8jmJ3eqjoej4V?=
 =?us-ascii?Q?D4p4QeoNU0OeoRZmwpA2DmGkaOo4kR6Zqsf4OAT+uBuqYdppsElV3mSGHYIB?=
 =?us-ascii?Q?Df/yAf4f4h/LKhIcWGh28YggOjIrLgy0e5qHua+0Bs+8YFiv/lg46A48MR1K?=
 =?us-ascii?Q?jNBT9cNrhjd9FAI6hd74lfgA9k3D1rzmo/wU2KPk6XsDFGUnHwCBBG4nW9uN?=
 =?us-ascii?Q?U+QZtPWfevb5vxbwJfactXTr0l4EQ+zbfdM62id1dkGblZM96lneYIhjfuZd?=
 =?us-ascii?Q?S/ctRPKQn35cUOwz/d6NN3AJVBAaJmC1+K2v2DMLuGpr55BQUyXlX+MYreQT?=
 =?us-ascii?Q?RyZLCnS+fUQQbp+6TTRoZGM2aPox9OoI3lhoQ9+1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d1d83f-393d-4a0e-2d30-08dbe3f327e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:29.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pXp6jDVPZPcWUFeozw/4RSB2nNiIdozpX0ZdkPjTFWXw1WfMe0lKC6MQD6OSvbI6ezQRrrlf/Xg2UKBDv+FJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dbf040e39af4..4cb52df57ba5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -458,15 +458,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -496,7 +493,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1832,7 +1829,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.35.3


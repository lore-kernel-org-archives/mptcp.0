Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC57F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4i10iJnwj0aagBZYrCIEK/JFHa0Tp7SVKBaptirxB0Qwytefgs2LxCy0LNG6z5+Sn3wQ8p3oMLjuHTxCsg/w4jk3lLwogKDzjMaBfYoP4uzaE/C9ChjWq5+ApvO5GJCsi/aIgETktLxSvKiJ+8WgyhQXlah5dQ9sAA0UB/v4IxmcCByNPgcstdV7O4t0Y73QRQaL8nzVKDs8rp4Nh8wVbkQl9W9ysrrBFKdpTygydu3QJzct23RBgFkPVUQhsOT4xQpvLJJSrWCx2JSMXJ85aJ7Uk5U4lr/0gosXQ/FiBaf/z4wszBVu7Ved1wjG5DJVePEexWSWDzSC+ONsgEnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD6ca4JBxRdxsfrWPFl+C1SLth72Ol8E8Hgs3k2PtLI=;
 b=ZLSkwQg8PA97uefe0k4fs1SKzAWKopMsmIz1mve7G0/9OhnGr/fkmSZunB+SEekcqG9o/Pj9TeQRF42b/YQEwoErrIrSe3806YiyY3dhg8ZUldcp/hlByrqDicSlDhm22X6BDedHr9emXOOkegDgmDU8PfZW3XGf1SfFA0c7rShMDgYPdzgjpaDeX7IJ8YLm5tQOKCa3SAHkbL+xsSW6YREmsee6de1etg/upQnBMGuCtNA9b3MVCNcUVGyL28yCiZC3rnh+HClhJ4SR2e7aS2HUj5D0qGfa5tLl4G8RU//DT659+HGvJx6hJjB+sFpe2NZihbasEY424ddsRrFoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD6ca4JBxRdxsfrWPFl+C1SLth72Ol8E8Hgs3k2PtLI=;
 b=wsdvyEOrF1V5NO+d9H3B0rnBabqPpPayIM1j+j/7nRfS60vC/Ny4TF8uGFn9msCVodo36926ugtBnAvXoiOX1kkz5doJ6MSqA50eFFTfagHIvzPZG4obsbMSWPARj365cNu6Aq0dNOQZW9WBG6a2AuT3IrtTCdmfXnzc1W7022EI3pDNYCZ7zEGGIOUMol+A0vBFDDfkwRAKOI2F1/P6jDK+sIOB+qoyVAV40DK2VbwiDHNzgVVfP80nClveg4SfJvLisAjhefySzxowO5bk7iIAxAPsQ8BEZ/zqSXL3e6hq67nnciciGfm49euXcu6fqzITXpZWq9l58JitcDjYoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:22:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:22:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 02/23] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Wed, 14 Jun 2023 10:20:49 +0800
Message-Id: <acf44f823f27bcfa7ae5540b27af8343c3c0d6ba.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ca3ca4-17d7-444d-cd5d-08db6c7e2320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Wj/YFcUH7yirA7TIyhJv85PMQxrZnNeTYu7UC2IXfacm49vw2Dfr75TeSJf4DfkvZt+btJuDzxfTib+P4Q9Q+qIhMfddLhVpeAdq3NCDVhFSO0l8fMY+o/53oSIpiwgo+hg2YtpoagYEzjw3tKVOc/yicEf4QrGBzt8B2tNlcic7WIj4NCdaziOq8llOO9H67zs8Wb/fYQbnRrF/y+lIlscJSntJPE0/CrlhV6vdAhLceYabgwXlKyNXRQ0A4Xh38CHHzALg5dyrz9iX3fBC1cWkCuuMcF5sqTdn944Di49i7qTsr2wRqKETJBBVOFjJGGjwvPoQ3X0UOQ+MgLWkvflew2hkLV1tKq9AwtVvF+5BtZ1PwBylnGCsgiXiMXElGCA+eBuWzzxccfjv9r1I5474C1tTOm7h0IvhvbW5JOrzpm7msjKDn+Gd33ejtAgISRZNf+acCe0OV0hqyJRo9aYhoU5EesLjUDP05WiiqRRtGO2k3q28sdMMtiug0/JXzGONdaiduv6ucxadsfZoIMV6KaUo/e9QSJA0F6evzghTdEs3X2YWy17ExY+nho9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(4744005)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ubs/UCth0ivWUj0sPBA3VKdWeh7woucub0kBGS4XCbHfNYKYJS3agXbunn8x?=
 =?us-ascii?Q?1+oI+t3ItYy9du3+J3XjHoEWtKd6NU623nxPfTikSOyWUCe9vaq3DT/GOQdx?=
 =?us-ascii?Q?Ku4/v8v2L/nhQOzm/W2k7PodKel8hK9OdlZN7b+ehdInc4uzoOTlSmV4KZbc?=
 =?us-ascii?Q?VRxb+nMCuEdLpp5dZk58H3ZejzorYqfStjQ92uPb0Pt02liunMzp7OLH3fhX?=
 =?us-ascii?Q?Ft6MMX8mk/r/LCd42zW9Z5qI1841CH+rWaeT5sgYsY6IaIf3D3ST4q0Oa1i+?=
 =?us-ascii?Q?wCQeVpt00vrSowPkUmftT1q2Msyq3AHHBHGI0G+EJ26bJwtOn9gd9FPj33aG?=
 =?us-ascii?Q?901wQa/VbVkzVjzVi2iyG04KZ67sikpNZBhk03y+KTitm8FyRsHv/lqEKWt/?=
 =?us-ascii?Q?0A5czG6hEs8NxLFK/NiD0K1ApFSN/C3zdasOaSxlQ8ybkpD+LEvTRVtoetH0?=
 =?us-ascii?Q?mNS5jgTrmFEGBd3LHHpRF3WNwvm91w3fn0BFcO4K4VcCGNVyzW+yUosTeAH4?=
 =?us-ascii?Q?cIG+zsVV4xmqCpYpR0HamgiU/cFxODIEMeqgyX60A2NWCdZ+VuUIRQHipcb1?=
 =?us-ascii?Q?bdTAfDTIRllXE2pHznbIe2FE0pkmUKIfqLEUoI+D99Cj6ENxcMewLNrhx4Bg?=
 =?us-ascii?Q?+OhWP7bWs6V04fj39Tq6vRMhI9UP08kE12SyWCJE6ZkBlbxQAzzF3GVVbgut?=
 =?us-ascii?Q?FENYhZ5aUoQQvhEuDtRK6txTQZxcFrw2sh5Ke6srTsJEmPrXtd5UVKXRnagk?=
 =?us-ascii?Q?14Op9R7ONoABYLSBhnpf01h/qcKjn4MYoS2rdR/TWeOzSsJfIUdiiBqyMg9/?=
 =?us-ascii?Q?L8KbYxFQ82eyvHw3UwNO4d3rkRNjOiqDWUOLKgOBWbeiWMT4V6OkWoIYkaJf?=
 =?us-ascii?Q?cAX8IINBqvFDGbwyTaMKnpsNZp9ZxXqCBfgnBlbJ6dxNq9daIkAfb6WRyiHW?=
 =?us-ascii?Q?1mM8rg9g57cyp1wv9wgz7B0m2Mu6HR5LkK2dCEhYOZOC+s+PGgmYy4TVNtx5?=
 =?us-ascii?Q?srH8a6cj276bwz5JhvHjQTxGz8Jf9f97Lvs9jBF3bcvHLbiuiANtrrmoaPSE?=
 =?us-ascii?Q?vpTCwAAqM0JTxOf694yVVKHJP9aMEUaJWkxQ8n+J0KChPtCscHE+z41xunzq?=
 =?us-ascii?Q?fP1BgFbnyyff024KX+1t4b2TRBnsyVn/W4xVNlCgtbZcpy3z/jV/c4qHj7fY?=
 =?us-ascii?Q?zkBPrLWAncXZgGr30cNUq+XMzJNBIM7vB4nFqhP1SCq6sOiXdtj6okzTkB2P?=
 =?us-ascii?Q?o2lb/zb2nntXpve0mSydcH29S66lUufzdF4Mi0C8dH5RBa86uhJHC1u07+NC?=
 =?us-ascii?Q?BacPQMhmN67M1tDZoKSERUswukj+njyol02nqRuFWktyuZ20NgzUxdsaJX1M?=
 =?us-ascii?Q?MY+p2WteUT4Zhoj3IfzXPBeYK7ixhoacGtSSBb6GXInszEjc6KHm11SbzbFS?=
 =?us-ascii?Q?lCmU7ud1D1WGebF8ADM4yv5/XZaQ9GDGScSWRurlx6sKKUfeE+afLgKNCu6y?=
 =?us-ascii?Q?fGzdWv6XcxI9Z6HFF/t9ZyI62O2QUWS3q7LXlToRvAEqPrc0Txzu3od6xdbH?=
 =?us-ascii?Q?GipCsnWY24ww5I9QDRVnkYgFrtDYlQoXphFXCji0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ca3ca4-17d7-444d-cd5d-08db6c7e2320
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:22:01.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckfbr1Q+HwQXZ4Lumg546GzUI5A7f1LyRjT2a3Sk4soI8UKZMbi7tXHWlC+AVD8z2sxUgxu800Fe6gmnv3ePjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Use two tabs before reinject.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 828b10ddabee..f5cd43cff66b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,7 +100,8 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
+	u8		subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
-- 
2.35.3


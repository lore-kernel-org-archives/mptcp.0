Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D4D263
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="o4vsqW5l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+lIpVUUFUf08IfoKOZxAKXxfrVPvOUhjEoawjJ5UVsVddRouN+QJpOKsyzG7p53hXQ3GtLoDZAyEHDJMoa5ZZ4dKgSAiMP+m8kEHdjmeOIoaLVD8dOStn/ysR+tbcKWP+zamlSbJKo5oTWVPxObkwWky0ykj9uKEEzM30F33mUmVJBD0Ke69afc9Av/38RNTLBh0FszilCYfWI99kDzWo56W6ZIgWrXdQURupPQ6t8XbeuY5USpUmdNvXW3YaHonfDgDAHuROFHEiqrrhwFhGuEcUg7nNoJEBxVKh21v5/M27QKQ7ASq4CfA+Id4k7FK+mbBsI3WsAQyXkAiNMAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=TUoyiodpoAeRcDPeVaZIc/PocSjfzDZXn1afIcknKxT8jNk/PFtvWaxwtiwtauo33oU74gOFSZ00Y9AU0EfPdyk0EzdWU1Tw0JxoTo4hfjY8wznCrhshsPRULmXcJ2zFht0wJ++ES1d/fSv4+NEUXIOLTjeJy6r84OwX3/WJ3Y2d8N4nxmUcvWkSJEFrcPLoCrdQ4f715ws6CHG0E+/QS8RNi1Pucr4s2LHUAfsIK06U0QrFIEKK7GoJuQbtCwH0+xFrFgpr1skoDRLM8oFYUmCU016Z50YLzeHcN2d5WbDmvT5d2G1W57+4LwCRcNjAvZCroFeZnEaJSFvV3J2W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=o4vsqW5lzCJ3LakYbBajl3UIyy/10qcIoqP2Cp/e8GGGdNdBr3zidaDXKT29itlkYpp7kEQiIO9fOEsGidfpXZvbBMVI7rr/ax5U0g50A7/PX8Z305KsvaGjhf+0HLMFF8C/+L2JBg6tFDlMywyECKVsE0TBK8slVULZ4cH7HczYda26U9FucHEvO1lsL805T2BhU8CTduNiN3nBurZy9Dtb0MBb8uQj9oesqKpqHazj6jtSrVft917946NlI7ZDPBiGBxvFXEGIM2n+022rkypfDRj70H3T8vQujKY4xw5LfIqiO9ZzMJnp88YX6QME/4v2vqAK/5IeGkGpqwFdLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 08:56:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:56:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 01/26] mptcp: export pm_nl_get_pernet_from_msk
Date: Fri, 17 Nov 2023 16:55:54 +0800
Message-Id: <2c5f59628723e543c7ea1ad2e9d2102bc01d118c.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:404:42::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: acfe6b14-336e-4ab4-a3ea-08dbe74b0cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i74MvUf1BtqNUKvZTSQFuXnI+wCO4TilPJMG3YutKxj6v5qyadDRhrKRTifJ9mDdcKIMWNAzs3x80kH16YhefgX2+OV3VjmUwYv4s5oHps7wk9Un3ycoTitKzR+sU++XbOMqkdH37D3JfSEsKxitKJdUJnTn0gINdHfD+iagDnaw2saDIV199rAtbl3DBsEBzSa8jaURFzYDPWYxm6TuIrEBi6Ni3KG1SQvv+9xu+fRZFTUgkIjiGyEjAmDbFMKNTW6h90U2xRYimS6w0m+Ni/KLT6rwI8Okm9Qixa5OmClYS/pBHcpVXGwArYMDGjUw4BmnSa9kfc7VPqS5z+CASR4gjk1rEovwgzg9SkwcUCTY0iail9zeIrqXuKnL0Fp8mp2HGjrER+Z0m0XbHoxR3skhnxE9nVlonm3tznxIaxLEcbVu/G6YCN71G1h+ZIUQ2eXcGS1Y2+vN/IZRhjUF0OhEqaMQai2ETkcHBgVxvbBXi1rvkHykaHMoDP1LRH7KRSc3qOCA+RZ3L/bU/zWjq5QtBvep2aZJfvZRKy++tHBF0VubrfgWYUm5l1o7gNBV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(107886003)(2616005)(6512007)(6486002)(478600001)(6506007)(6666004)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TqDXYm7GFiuvcII5vK7H7i9s9CNwKUQ+b3WvPeNf1WXDtRveAVkkecHBZMcV?=
 =?us-ascii?Q?qlYQzvZv8ku9fM4YaJ2HruuPQ+xxlGVYFk4RPx0EdVhuBH2igHUCyyzTT3WU?=
 =?us-ascii?Q?gP+GFuCu4VNSuS4vUmxP9BJKd5OYKn3nejCb5h2mr2PjZYpJq2DyXsLLh6Tw?=
 =?us-ascii?Q?WNh9Ly6f9/9RFDcftBvSilqtB5/7DLCbg8ZukFZsidTztkC6p4p0lHUfCmUD?=
 =?us-ascii?Q?DX1sjDPbyD0vYttzVVNXTAhNK2oBO8zhAM0pvSPDvxl0UVC3ChwJimcnViVi?=
 =?us-ascii?Q?d2OuMmH39ITPTsIwjXTIChhfqdel4DP715gOqh8W9Cihr9d6EHT9F3xlJQ1L?=
 =?us-ascii?Q?j1wV84a8KaDm4bjTjqvc7ZAYkT00uVi7aMJ0PZL23FH/+HaXi45bArDUc4My?=
 =?us-ascii?Q?q6aTwchik02J0u2WQGgH2Nk3NhvZJI2p/IQ1u+88MpDGiOYW+5MNL65W0+sT?=
 =?us-ascii?Q?rp/LoOwe/v4mmBxc2zO1ChWGWFg7wPgSWmiJrRC+DSdhq3jAIJH2MoFdZM2R?=
 =?us-ascii?Q?YkKiVwpoJlrQxWYZfA/B0phJwmXgPIoKZlsA+OMa1JFPQaoKz5vT4JxSV9Op?=
 =?us-ascii?Q?uOPD6MtpMY1J1SiGWwPTa4SXR2s+BjJCO2dW0sjh6/qXYfQNVmTDWB2yM5WY?=
 =?us-ascii?Q?LjxKZY66+RuCRpoiFI5AaloJ8FRWyCznxSel5HNsnSSFSDuHhM+TpkWlo0Iv?=
 =?us-ascii?Q?Pb4OfpRkMk34LCqowNgQAVNVOYeuyApvMZVKY9owKuB4KhxbrsBCob51KixL?=
 =?us-ascii?Q?s5sDXCGz/iinmT30iKR/ig0/OCNkAs5oxUcGpmfpyNoYjBHuvdjvsBHvtpmh?=
 =?us-ascii?Q?1Dh03S8XOmtMrcX9TKZAedKAxPJUMiV2RBvHcfINYELcA9+B+a8ZyH7Mrnqp?=
 =?us-ascii?Q?SWpnIICIg4c2qnKKa3vaMR6KfCJnpNJDPa/X+dg69ixBrBHMlnJZaZ+Spdoy?=
 =?us-ascii?Q?prQ5FK+XuA0895fRwJ0a788RkR3az7oVeFtP2vS9moIix2XZTABbr8uUPqjN?=
 =?us-ascii?Q?VfbkV6XzJDSBuV11kHOq2Sbs6f6Yb7cjB1Xq21cGssaroeYQoeIN4q2qmg2p?=
 =?us-ascii?Q?Wf0JhePc6vx6ECD85PJa4mtPdY5OjpKqQNWCTG9GFJdoAreaITKtcfVLuVyW?=
 =?us-ascii?Q?EwuNIqekoEg2zzKRx5DK/yJmR79AK0BHl8jU75kVhiyAkBRpBXkDNXCV0TV6?=
 =?us-ascii?Q?wb/nufm1+tFHPTc35UWkmU9lpnLq0TUWTlf8T9fYyUp2pKLRukwd764zY9MT?=
 =?us-ascii?Q?AzzFPoUrJ0J40Ljwu/VH/rEsSdQ1DBNcdufwCG/uYR0TOe4r0FvVr3FUG62y?=
 =?us-ascii?Q?sO4WG3FPcrN6EUg/4GeUOAanW8iRzxn8CJX77TDlATmICjlyIW8qclnOtD6f?=
 =?us-ascii?Q?kqpEgY89TS+BRo2hdlW7kSmTgCZfrZY5iIZ5ECtGBnerDRA681Ly1Zd4Io9U?=
 =?us-ascii?Q?cgRVgi+lBRbIZj/fC38QBRvFJk+TUvYvaQDXbVEsZ1d20E35RlpEFTBwyrZj?=
 =?us-ascii?Q?FN/9lYBS2VK6D5ZDBNwnagJCvjzqY3Jz3XzGod9kU0zR/1+gu8YXEuJlyXu+?=
 =?us-ascii?Q?xlr7v07S7SdFKDJbRqbJRiGiRYWNRkBHMpFHvD7j?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfe6b14-336e-4ab4-a3ea-08dbe74b0cc1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:56:12.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67Tb5FnGic2QTm2oUOGkb/KOUjnNl2EFQ1x1YVlDnCy4Gv3FOEIEP/GLuEElg5ldNAtgNixgooERD10iMRZ71A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

This patch moves struct pm_nl_pernet from pm_netlink.c to protocol.h,
and export pm_nl_get_pernet_from_msk() helper.

Then every fields of struct pm_nl_pernet can be accessed everywhere,
not only being limited in pm_netlink.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 17 ++---------------
 net/mptcp/protocol.h   | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..1dcf104d7a01 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -31,20 +31,6 @@ struct mptcp_pm_add_entry {
 	struct mptcp_sock	*sock;
 };
 
-struct pm_nl_pernet {
-	/* protects pernet updates */
-	spinlock_t		lock;
-	struct list_head	local_addr_list;
-	unsigned int		addrs;
-	unsigned int		stale_loss_cnt;
-	unsigned int		add_addr_signal_max;
-	unsigned int		add_addr_accept_max;
-	unsigned int		local_addr_max;
-	unsigned int		subflows_max;
-	unsigned int		next_id;
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-};
-
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
@@ -53,11 +39,12 @@ static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 	return net_generic(net, pm_nl_pernet_id);
 }
 
-static struct pm_nl_pernet *
+struct pm_nl_pernet *
 pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 {
 	return pm_nl_get_pernet(sock_net((struct sock *)msk));
 }
+EXPORT_SYMBOL_GPL(pm_nl_get_pernet_from_msk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8529b3ae55e9..c38a2126071b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1026,6 +1026,23 @@ void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
+
+struct pm_nl_pernet {
+	/* protects pernet updates */
+	spinlock_t		lock;
+	struct list_head	local_addr_list;
+	unsigned int		addrs;
+	unsigned int		stale_loss_cnt;
+	unsigned int		add_addr_signal_max;
+	unsigned int		add_addr_accept_max;
+	unsigned int		local_addr_max;
+	unsigned int		subflows_max;
+	unsigned int		next_id;
+	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+};
+
+struct pm_nl_pernet *
+pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.35.3


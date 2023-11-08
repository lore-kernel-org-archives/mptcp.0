Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E9107BD
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q6G87csF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARLjYnelGYjtmCPaMGg6QmhuZHMnY+RWDb0T2sB65GXha4A4AI8e0hkrvouqRHjS7EBQThdVz7O0Y0vZy9D+9luEnqnLs/h+Ns/JIXlUsSJqwIooZsZII8A2oeiBAZpNv/VgDipOnNUDX6OhFLU+9GDptYZZzn+wYCZ58VQNY53zXb+bYZrXrFv9evwgkFEvVXEk4tWfe0nGXkQIugEz7i8CjL8gLFKOb5eo/5Pduc8A8KtAhIjPsJEh+1222wOg49xPEpjgS9QGMlQ7aC1vJFnQD6kXXbXlL4oHXWXnsFUNNYWlB0nXQxgb8J2jJjMmH8M/yW06SALMoqJLA2jROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAZl4qv+VvEpAVv5iEFa6I1nD+rmJ5wyL3eEFKNH3bQ=;
 b=I7QKx32lWiUNzTJOgNDz/UKUHatAU5vF1cpyvktlUZPQ4Z8LkY8kC/EyJH3pZMlDpu9aHLR8f4x87w5ycuMeQ2xQQo1q6doiVGblDNZFLcSfsKt6j+8jzzlytaMU2NsJSIpZjKYdcp8Z6YLAmJGdQ7P3kd5BonRp0BmB8o1xHi8kNoFxmNdTrqJKjSis/dcT5NtxPfzs0tJt1xf2smxX0TIIJGytDy56VGX239RpB3FvOxDtGzeIxrMYJURCSnGQLzvPs4Z3al8rPb1YmUHqICRU8BD0D/kTO03z1pSbbiHBMA20PCryeUoxZmqnkZJTlqXM9Uo17FnCyFkDCFlCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAZl4qv+VvEpAVv5iEFa6I1nD+rmJ5wyL3eEFKNH3bQ=;
 b=Q6G87csFMoxDHcZ5UYfX6O8kVOD7xOVzc2C38f4RTETkvAYeDGbkztP31+0JLsU1+4Z80G4/A/vLcAk/30EdzXrfWdGfz+T5nCkhTWt7q0jH7JF5pZE5I6xZrLnscqUTJeCP+xImWXzsGbttLVtc4kMXCp8YPTxyCmPM3R8qGlAZDRorBgGX2Zb84fGa7eDTW96JkkFPTFY2SC6AsE+hRpqbj5XbA6EKnSag9KY8hvnnhnlQ54mNi2fAfgZUMxDWln72Wr7MExO+IPFetOMcgdg4olViUxSTHi6Lg7fhCeWXxC58xSXBmqcLjhpw+Gijjofij+n/VoJSKJKovH+FTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 10:05:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 10:05:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add netlink pm addr entry refcount, v7"
Date: Wed,  8 Nov 2023 18:05:13 +0800
Message-Id: <6f0b31e09a2129aad69c0e7d5ed11c4f4c095a6f.1699437907.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7ce8ea-50ed-44ec-1b34-08dbe0422f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9guVHNeUfCglINHONojSA/Nu7G83CvboIP7YHr4cc3k/L3UDYZwXeZcx2w6SUKlQsVPTnU3hr1tsRbWmA15CdPMOU4AxYKYz2yW6Cv9eh0+CDqGtyPotfEBaLayxNwVxTrN07h2ngouxC1wHDX1YyXQtXheYwnaFoUbPedb3eNzHrZXGOmByiP9rjpL7T06E3fGIzPSJcJfkhd6Awfzq/PTRSOE11976mD3crXUMSIFXfm159sU0Crh0HL2fVGszqLqec3S62jtrBv508/I64qkJZH8BGSGVS+1fjrB/RynZJsboP5vd0vspTI+5mOZH0LAUbh4K1kvtvugSDMbROCfYHUuWfflBcL3/tUHhsEvH9rEZGLKNA4vNh4qtMvSJkjtHWOIq9ENThSNiMQBEsTZyIkJRIyLHVf5UAtP63fInv09LaXiOUmNh2DtrCBhyDguqraDVrmahXpFzZYH0cn22tpS/KM8WVcPQY+n3orKkAO+GeatJ9e0USkVM/1rvsAG7BHoFW9BawugN9kNiQMADcorjKi779llz1j5TbTZTvSJLRPwVgvui3mNmUzgr08DAwh7lszSSDGT/e8QYPf+bUY0nVN3vvavaH25ST9s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(2616005)(6512007)(6666004)(6486002)(107886003)(478600001)(83380400001)(26005)(2906002)(44832011)(5660300002)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(6916009)(38100700002)(36756003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsJb15BuZ3sEnUAjp99YaXGO2Mvyy1hGPD57Q+GxmjY5XvkKJW2E6nf4odU2?=
 =?us-ascii?Q?gO6C3roKi9g1xlCODPrTwwvUNzstkBes+LuB2r6+PXCfL6BIK4p3+PS2hnEL?=
 =?us-ascii?Q?YfBnO8vqUvq/mxB+XeteZcssvS2Ufwi5SEW/fk+qKkX4FYXs8xXKzQLjjbXd?=
 =?us-ascii?Q?ptqAmlzXGvp13kRMzGlCDceMF91RSlLJyiHt7vgoM2H1xDa5bDAD/CoWweGr?=
 =?us-ascii?Q?Ja0VJDpWE+0zsQkcVTRksPNv1wGZcXHD7kZlhTXQ5AKTcM1PRQ4106fWGIKq?=
 =?us-ascii?Q?ah3vzdQ2UxS6oYdXRFUQmSE9sI7XCn7BYBJyiik1gimCxMkJwlPUOPVCU/uz?=
 =?us-ascii?Q?P/OiA9yUmLHdZsDz9iZPIyZDQNWxEkcMlHSxGNP73JdDVDfmLpLJcgQY1TLS?=
 =?us-ascii?Q?mE2TcbXvMNUmMOAVZ0eC/x/C3CVPsoA/VoZZkP/DWg/XQbYR+4jIrntV3ibF?=
 =?us-ascii?Q?vJX7yNAv5ENeUR7HGZ9H9M1wHvLe8+Ki0tuNubmB9mDm6DCFUhRk/PnlqUCI?=
 =?us-ascii?Q?afs2eRPTd2YYvDXrd7o2CT77F5O/3WpIgEogBt4zvWMtqcMZdUfbfewaCEhG?=
 =?us-ascii?Q?+Ct6TAeht5h5MoGQ2eyGIGSh7NpyJFvk6J3RM4pXTvtKcLIfxBYhPaRINTFN?=
 =?us-ascii?Q?97Tfb1FjZseow2kon9ki8kOxl7c2noSZc2XzjnmwwKFBPMCkyVTuogOFC9jK?=
 =?us-ascii?Q?tNMqClikEmwFyXWpitOTAyrnvdq5eU63aIBQEte/fGEhnJno841qem9pX5dV?=
 =?us-ascii?Q?XWYxkp991KD6nXLTzx2B8kbSo/fbeUBh1UxOwscGbFZmFEd9Tu3XI8r+IxOw?=
 =?us-ascii?Q?Bz7P7O6ldP09aykXw9yUcnXazrcAnmNAncE9kixbQSMEh0alCJTiff0GHKj9?=
 =?us-ascii?Q?xsSD3CMBlMrio9fAhua19ydNnhsPCKdyaeoUDpaNwTu/2cboIMYqPh4jZxqq?=
 =?us-ascii?Q?Y6Pv5svgJbZxnAE8X5qo67Xk0KwRwEND9e39IQpBifYCGQN2BVcRGn5UAJ+r?=
 =?us-ascii?Q?gwuad5GYnWSocTePaMi05ruGWI/SKTSYl9kh5mEHtTHXoHV0eB/1HpaShHV6?=
 =?us-ascii?Q?Vwutle79zQBdiYCFdEg/ieczp45bu/ECVy8ZntPY/wA3LGmPijUpj+kZKuEZ?=
 =?us-ascii?Q?elPlsLlrcleKAg3Nc1/ishJ1uGe27424DU9711expZEpZGr1Wa6i7eIdvwxO?=
 =?us-ascii?Q?KTn8iTvVKJj3qBA4Tzd/xec1RVUvSfI6TKSouf9bChngRFfQf6k+w1dDt+4v?=
 =?us-ascii?Q?rv6LLqDTrug+1x/wWm1Ctwzjxz4xL9VK51fbJYw3nkxKtkaFsF4vc70fSKMK?=
 =?us-ascii?Q?swT7+mMo7Zfoj/XB8gFs2pge8BOpphCcDGAuIFcKME48TGtrjrhABmGBU9/p?=
 =?us-ascii?Q?IUL5Hbpiemlfrw87Ex96eGn3ZnenFWWTycgbE0xPGPI40Hyv7v1vWnbfIOZa?=
 =?us-ascii?Q?DETszxeZhoGLDASCIB52Obsk0JljZgf826ckSzHEwMrWtU20gLDFMP70MfZe?=
 =?us-ascii?Q?ehPaO2+f9H3LIcXnv96ixfwaG5FztYFPlWcw3/04BIFB5TZpqlGt/6Melnap?=
 =?us-ascii?Q?rxldIAclSe1qaQRkLuk9eZDvFDdm8FE7a3s6vuAOfS5i67wlPPkMpfqudHMC?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7ce8ea-50ed-44ec-1b34-08dbe0422f4f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:05:07.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNW0OxcRFoXWg5GIR8/zcYb1MSg/+XZs/UA5DX//OxJnQXi7ErU533xIxBPtKrWZQs+QMhzNMuqtwCfK/OgZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113

Squash to:
[mptcp-next,v7,20/22] mptcp: add netlink pm addr entry refcount

Fix pm_netlink errors reported by CI:

Unstable: 1 failed test(s): selftest_pm_netlink

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 636fc822a257..06b67e6b80a4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -533,8 +533,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, &local->addr) &&
-			    refcount_inc_not_zero(&local->refcnt)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
@@ -1294,7 +1293,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out_free;
 	}
 
-	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk));
+	if (refcount_inc_not_zero(&entry->refcnt))
+		mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk));
 	return 0;
 
 out_free:
-- 
2.35.3


Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668511C8B
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="2eZw/Egc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdmq/Ssfz3vm1WFa9DANxTZ/BKNoET5pt+qH+VtnzPst1JxjSYrBJFFxqhBwnrb/rVru8ZbYQWufr/cks89xms5x9VV34j51jDcNde9Ilr7o5KQXixbIRx/dlKwyxXbm5Et3vYamkD4hLBFlWjA1i1UWzVnQWYTcx16YL7t1JbvIT7uD5MA82hSkUBbBNwQS+qu2W0rLVmlua6bf3LG6FweD4a+kIzDF6zk+6YL1p3lJ6MRnOJSgUnOZxhhGYHK4er5jB96/92W1Ohkmqw2OrozPM/s/DpNNXsR238rU0YmKkx5bDH9DILljvJOeqpV7jG27x8qsJDgMZItah0elPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=g5OL2nt1ANekaGlGkmOLk2czRh6W8vrU5eO/1p1hg1Kt3Lo/7gRlwF+3dLQGs+Tcf+yZdcPDcCsgH098Xg9bFepxDzuh69stimri+msxXqDHMT15+kwLds78MT+c9jE2HCsjTaXHE6WDxzytVqyHfbGoMRr1RO+egjFXjoDIQlQnkuqrgznHcJ2LxxXRVnbCVFDe/y2wOOJBVTne0Y4c6ea9O4FuYInI/8wLRNywuIfhy5M8DH+k7HCNCRRidp+NpuRflaM7VnBgjJKQgHKbsFjn2dwyZYXDPntr2n+AxAaMfJIh4egoxPyhgU36fhun9ydvl7ihxAjE03uhFg/GoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=2eZw/EgcN6Mz7hPJWyp7SEAEVj3QH25SGIm1Su2GvGcIFe48yzztVtV/xMSVeEiLrkHhAl9fOCOEw7zbcDwh5CUhDHoqXnQ04EFKvw36NrbrIjnHi60SMr+YboZbrrD+yJSC5ySVM+QIsE59Fr0U56uoweI72WNkF6BWKNbjl+M7xk0QVf5vmTS83YQB/laVAaOe6voFPJhuRwZduVLOWHJVZxXgWqN4hfeoe6SGSdz+HinyTZmWDAwvoFf/Wewg2uhifJ2KCqy8aWfywm5qpm5hNCWVItoVFBBO38+bOgLjz8BKQqXAXACydZx15m3Q1hz4pdpZ5uQLPHIm32rtaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:29:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:29:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 03/27] mptcp: use pernet id_bitmap in userspace pm
Date: Sat, 18 Nov 2023 22:28:18 +0800
Message-Id: <548179891a73205d13a0df3b0ebebd1b15a0a74d.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0103.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: d3685be3-ca65-48ac-8550-08dbe842b795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5XprdOXilHpghLiuqqjZUlwkYhN3eWxtMH4ZuvkCn6P3ptyps+KPWMVuu5Z8DP2y3Aa2gQUhrXIh4r2XNDa6TxBknPx7/GXPGczfTzREJgDxhB2dnJkuCTVxyFibsU3g7fj4urr2zc5iGrcmTM7+8TsqBoOSSrhiMzvhaXrHXq9l9d7XNxE596Ghg7g+dPIXlHsu0eY3d5RdJcMyasdEXZ2wCzT4tc07NFl9BT0dQWVV5LmB/qNFq1l2YoYZhw/Wz1uD9ScZ+18SP38fG/+J2/CAxadMw5fueV42JXkualEZNQ6dH7/oSidnZJktwMowB+qkb8f62XhXqmNvuuejsOy8szhhRiqkuAC6xOkkgOnrskk1/p9izka/zLz0vUMHrFUhhIe8AjWYali1bLRHDBopsP272TQNNirZyg3GAg2eD12ELyLzdSW3WlQXqUQNac+daqrTmSelKhbWjXg+859oVnwmQxiGnhjxUwMxQOEgpmExxxE222fPYobDy2XDYcl7Uhf1Rkyfws363+O/3/UHVbJvSfiHWzNa74CsMAfjPIDtnLQO5hs8+HDG1Ob0C76Jxs2MVAxVdCk4PKlxnH59XpFFhMXhogk6Z2TnQV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AwHC2nahPPIguYi3Qj+cKLdutmjXotiH27jwArOxUCrR3Tw+C1jerZ51L4wu?=
 =?us-ascii?Q?DPw+eA6fbnL77f0BmDeVYzC4se18CRM4NlyYAT5eMS0HJ55p+oFNZ8lnALFT?=
 =?us-ascii?Q?Rw6DrVERtOqOUuMKM4fzhBzwxrblbvtRyIWeiI91TkphVAiOGLNfWPcqhs6M?=
 =?us-ascii?Q?HCBYTNg7Pa8dhZ7PdNJX+5vpKE9NySeYP0HbP0o3hnFAdowguLPbUkhSUuU3?=
 =?us-ascii?Q?WOuArvVUNN+IwmDngo7wjp3+i/WoA52+DYWMcBE90iOiKQ/HDJRaLkKpCEZX?=
 =?us-ascii?Q?DKcYe37UWu78DsKU5B7OZySdeRIMrf7+ufOFljcGkBE4Hzt0MzXn0Di7Vmpv?=
 =?us-ascii?Q?Qu9+EaKpG5JZdKcmVmVEKVAkA3Q2nY9DMnAuTCW8LLCg0QzhTbttfbvJorNE?=
 =?us-ascii?Q?TpqLPMhuS3A9crWH5Md8YwLrxNHDqaNgLchfYRy6Pd3Y0ZT2lwi1o368oV+I?=
 =?us-ascii?Q?h2LH9SGUnvT10mfqq8ohrwfca4Xn9TPYTsB3+4kOhEHG5yQYA6S87IodIDW1?=
 =?us-ascii?Q?XEmaS9DXmu9yQ85Sq+5IwDcMRbFyaLP7ujO/tiwgoGUmidi6dnNA1D540W3P?=
 =?us-ascii?Q?foUAGFgxRurtLbznPtK4AbRS5/dPNlblYhbPaBuUwBjxJC93cdJsOZ1MaSVX?=
 =?us-ascii?Q?KSqhQnRGfXg7toRdM+IFlcHwSuioTv7kVJs1NwbO5Mtr2odjxQqV+MG+SoRz?=
 =?us-ascii?Q?ofFrkszNnMMbA0CoJRBHtDDWTAm3ap78cuPfDvCeJrDl3tRcqXAIpQum6Acn?=
 =?us-ascii?Q?rObW3DdekeeooNTMWpQ5LTp4/gK8Ne5GSiZXBdYliiIQcOTngty91tFLkyNj?=
 =?us-ascii?Q?kATAUfFTkDZctX261PjSMKlCNHSU2gBO2sFLX+fRPqeVgrUi66oS8QOndC25?=
 =?us-ascii?Q?KTQOAOxudzCC8fyNmDteqDKuHBxlAXfIeHgksSgSoU7LmjLhWynRFVccsocr?=
 =?us-ascii?Q?OQSAAJSYj3/G5eKoQIS0Zg2EOggKRNXYNaPGTt1/m87AzTnRGMR3ZOOyURGi?=
 =?us-ascii?Q?SgyTzbWtucObAGnDPRiOf+yNsRRPsITBmfYe2v2MvJ2bKEX9ov886PA8x0eQ?=
 =?us-ascii?Q?H7IM2/82ihS755UeCy5/pomPwbbvxabvJDMkY0HO4/Vvdlq8QpJy01gsj0Pg?=
 =?us-ascii?Q?4L/ZYOOlX+8QFWEFYiB1gfiyZ/fhN6cVV/v7KB5bPZmsQBdlOaEMOfIeI0Z2?=
 =?us-ascii?Q?vNh3ofJPucT8vpDUD0BGtRTSLK1u3SQpPJ3iHooUcwOrkndXt880pt5hjlQW?=
 =?us-ascii?Q?3uF5X+OGqvVE0xUfq/Q3zpyZ9hzKTe5KWHQX7oJtv3Ktce+RXcfaskvk/K/3?=
 =?us-ascii?Q?teg8i0Gz+vF2gMR7xyHbS5IRgMZ8pFfKAC4XsWLffv8Xq+CQ4q/7nMRPkgr0?=
 =?us-ascii?Q?Po1EJs2+FderhsNN0uGRgKBY7YvuERK8OEaqSUiQcIX9uzNNXNVp/GjxKh6E?=
 =?us-ascii?Q?/E4VVf/YkmMIrvK9jTZALEX3DlWgXzCMdcTUQ9RxHXGB3YZVOWr5TkKQgufm?=
 =?us-ascii?Q?zmKkdNYJjutIm10PKg5E+3TbmNqwkX17j52WW4/n05rXcigvra0fd6r8estm?=
 =?us-ascii?Q?g/f73bQwDIZ9mPiMMJCbFWrSaKd//YgVWuSXq0sQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3685be3-ca65-48ac-8550-08dbe842b795
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:29:05.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjfIe+NeqE60I5Exb/vcVE/PkJ+sE/c0UJuIg6A1X5uZ+nrHx1OpUOEgkIePZIKC5kl3A45FhHi5sjXkGnlMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

This patch uses pm_nl_get_pernet_from_msk() to get the pernet id_bitmap
instead of using a local bitmap when appending a new local address into
the userspace PM local address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..b3a606a5e182 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -28,7 +28,7 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
@@ -36,8 +36,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
@@ -50,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -65,9 +62,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 		*e = *entry;
 		if (!e->addr.id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
+			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.35.3


Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371891FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y5KL22hU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQSY58RWinw4XN1P7aSrE40Pq5vWOVFcRKG2vpC8RnWT18kBFdWVDjBRRWJJdV32enjhJN4EJlP7FTC4rgLqUi6Qp7k3Po8el1xED/WUgbjbl39KhBa/t2mqrkr1vzZGtl7bVnpL94XgC74fTetNHEI5tLgCgL8GgKBqvgqL9Q37QWR/GWnpVI6EGPUKY+zl1ob+gKP3dMHDoEzh+2PfMJbaGPgB29i+ijIyS6NMTiKegPmvxxxScQYkVggVDa0HpIY6iBXLfaYm/AJYA0hg9aYP3tTkgBzc6hA0XtldLzxhzbLxUHCp9QOY77pwiA29rp3aaPqTsZZ1GG1+K89axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaOiJpN8/A10of1uj1J4n4Tyw9AEpH9fjhLnvT8bhEM=;
 b=egQAR30e5hA98o2vXGH8hZpcFAHSvsM6g43GGuv538LdibnSX93+ywI6erjXRFOixxNPZFVgMnI69iy9PLQSO/WYR9Lk9w633ZxAMYLqF3R/67GE6Seb0UkvtiITBGC0TauF83pdtnJxjHzfPvwX1bZbkl3u1K6Qibp0WZs3COLp+L7rZdQIWgTslTgXFBOVGu/DKIzxwmPZ8i0iJ11kuJ1BYrzw6mcZ9KlLUzITXi11bqLzNbc25Kn1oD2O2lv3KNYHE3tvzTHRGbbhaZRPDLNj+SSi5GQizcpg1sLaL/cnkr21dPknGhg/u59+UHaXWpQzPiIUlXTGMOqS1oRz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaOiJpN8/A10of1uj1J4n4Tyw9AEpH9fjhLnvT8bhEM=;
 b=Y5KL22hUueW0E2eZ/aamN5HLw0/pSINjcXL33xSPaNnVpC9Ju6478i28eBiBtyjAN4w60AigehmMaKrzV5ZT0WrlIcQMjhpWcL8rZkmo2apoTY5zhOn/YGu2lTpMUK+WvMTRUiBrNKR5xD+rxIn7XCYiYUU6ELevAi9297xEZznJwEPXAfkxaRqQFtA2PV5So6JXJuI8msiiAm1ocxKDeOrgfLzWUOmbKcW3o+PU11l0k2OGos900dflOeitIc148KgmFqHqWT16gOTOlnxzMV7GtuHsw4fGa2RzXFQEOCPTeHyMYJaa1CXJPE736T3aSnSEVIfK5Zi03YXEMPbT5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:03:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:03:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 09/21] mptcp: check userspace pm subflow flag
Date: Tue,  7 Nov 2023 14:01:53 +0800
Message-Id: <3736f9eee92d128b042c21f515e436376bef4d51.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c104ff6-7565-45a7-e838-08dbdf57350d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oDC65Tel1LxW97fOZ0Lq/EUOCHQrcnrHOt4EVJizn5ebfQru6T32sYi74+l1UftJMv6a1wIYx1AfT8XMiWAB58gMtRT8ezocy5a4oFGjvNK7Evf+Ic3Z3RNgS8C+qcfvlNwOvpF3U9BceI7NeHqxv5JibrRL3YMAFs4ni+myvNbrLwhlDEBzVQdIJ5gKX3R2Zd4U9HdSdHKJ8oR9HY50fwXiuPa77nCMnbSsT8TAqLbG9Smv1goIs+eRnVun2+7if/9IibpghWvLkxAyRIzwaKLZF4vd3mC/9/tOmSLVZF2pdimmcavlfQceNtg7dgXv1ryJula5vbewNDe+rpEtWF/WnfD5xJXG+0/hg1e3eGtW7ZM67qQ2LRHkCjPzOgo6FNRQ/eR0b96SZjmM/4L57tR6NG7OngtoITssqpKjSdRe/hItgX01NBBS6gkfW8o313nZ5P3rcSZZCyWFhmvzTrmL55oBAljYN6URMSYV5H1g+ehy51e/KJ0JFJJKU7/xpXHEfQXmFJvq5XyKktBoFZQWAPhFV1IODAbNpi+gUcQr3Ssjg2sMkeb15B0PiCjN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UZrw5Fc5OkkAg/2lekfRQm6Jw3fyJvBkSAnFZzILiOpliu01juTdiRuj0R9q?=
 =?us-ascii?Q?STPRZd04NJV6T57eeuJmlX+ul1tOmJocVnj5VnVpVC+4wto1+nFeC3ySYOrM?=
 =?us-ascii?Q?z0Tci4ddd6t7N/Ei/SNgC+ih4Y8W3Jcno+H+1hre3l/U6zWyeAYQHA+UVOck?=
 =?us-ascii?Q?+vc96UAIrXVrP75YlOdabX/tgGylyndyq1YFbQmxmc1orvxe0jbjXEEhGr+N?=
 =?us-ascii?Q?8DIkN6F59voPnb7bp2IENo7tv2KQqIi/XWU516RnhVNDdgDbq93lF0VHDN77?=
 =?us-ascii?Q?2tmpRS5aUJYAGYSRkw0xQRXcjLf8piaVBYEiXn+u5LyVm5Bj9ROd00DsgpHh?=
 =?us-ascii?Q?eEQ1ibLbFodyxJPfFOf0JuCmssgQP814x4N9cEkgDfAp19fnAm5voKLwande?=
 =?us-ascii?Q?cHt0WOerpmOAyodwQ48yz1tNSyrc29msuwhenadYL18qqTuFbc0nLX7nCRGp?=
 =?us-ascii?Q?kjMI/s2wClNV3ydUgmttGDvkVzT7MhgfWjIuR7oaShpokxDF/FW/NaZX92DF?=
 =?us-ascii?Q?2octP5DTubkJPxC7F/z94lXGVuGs470U+mHC+ZtyXjanMbEF5JRHjJawDP8a?=
 =?us-ascii?Q?FTBIJJWibqDw0HmzcX9CZSNMt/WuYB9jFIJUqoo9GllKGbPpKPezxDy3N4yk?=
 =?us-ascii?Q?nowb0tPytUahpRDsMkhylL3PRocUKBuu9n8NfmzdtltM+eukW0L5Q2p84eQJ?=
 =?us-ascii?Q?0z6DBv3+796T6nVv2UqaqfnFYfbrFn3GAyuTSrZFjQHTtHOVCeY7nIH0c/PJ?=
 =?us-ascii?Q?wtZrsanZlzVe+c0lcychVhPzX6HBNPgveymaUkylClTLMONv8fxLzSgfcGPt?=
 =?us-ascii?Q?vpVVDBnvdqkJiFt5f7vmMfbwuy7Ik0SEQ165A88jnq342hJ7C4DCsmijrNwD?=
 =?us-ascii?Q?6pkx33M0Z3Fx4BMV3obsnj9q9rxaFdrW7sEhjDMxIVpKWiPEBHIRqzhGBbIO?=
 =?us-ascii?Q?dbU1K7PACfKf1y4TFECT/uUuqDo0UpQbB+DN55dxB1fpvb0eCLVlSEmWA/AB?=
 =?us-ascii?Q?SGCsj2iQQM7IWYsfWK7fKcHH7qDATBnCSY9rfWoegFIunIsugsLffBpL6fOh?=
 =?us-ascii?Q?A07TOYM5EjTr/gR/SakeLbVRhunw3lYhMHEm130I2dEhgR6tuU7LuS8A1cas?=
 =?us-ascii?Q?CU3u/wRDxmxfdsIhI680u1FPWIJ8qNkxwLfkE2vELMGaMxh4EU00gU+XNeh4?=
 =?us-ascii?Q?Atvi51UjmSzDdOwaa/BlUq+dixYQqzFqLIbBkJ9QHrXKuXNf3AciTV7CNIj/?=
 =?us-ascii?Q?dtWRyONvOli1Jd6cf+xWzCTk9rOF1OW4huGQRtUbWmyWrZYwb5kiS/0DYIDm?=
 =?us-ascii?Q?ro/xzkHzPFHqyz5djrORc/gWIlhracA1sq91xsyYPuZSJ+/Vq3OQJ5pYQLzE?=
 =?us-ascii?Q?ZHPV45k0HMqKMFN8FOT3seSBUx6u756EzIMUj5tzSV31njCN0e11TM3NDnye?=
 =?us-ascii?Q?hhnp9quOLJRNOGqs2Tcs1DoqyJGz4VA1VKoBeX0NRnj4QGROJsw6HeDSK8w1?=
 =?us-ascii?Q?5k9GXc/hQWNDfcUc5fpPwHHTkghCqtd6Eh9CPvE6CDul/mNF7e30tWsb/gfF?=
 =?us-ascii?Q?1WBpcqFLzTkszbEFIQVVrnw4YLcDlIMaJLOrnS1p?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c104ff6-7565-45a7-e838-08dbdf57350d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:03:04.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDKch49gBZ2cbBNVqC43oEDxfKWCf1VMfPSfLJ/G3jZdTrip9l4Vime5cvJhoZMxkAwwbj9NAqBKkn4AaUEmvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bd491b78171c..75ab4d7b9f3d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -349,12 +349,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	addr_l = local.addr;
+
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -367,7 +374,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3


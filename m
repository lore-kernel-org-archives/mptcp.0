Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B43C089
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VYSGlFBS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5eExSjUnHfbaRmj62fr7nZlOeuOe1jnirr1YkKwe6VuOPX+G56d9uEbORoCwzcalRyybNAtqimGrKH2JOq4vgZ5wbT5j7w2550BrGVOU+0phOUEQ3KZ75szqXeKs3xQb3ecm6wqZMDxdswQqbPUfY8TNoisCBoUvxUFuLn20xy2jKwia9SjOl8yoUi4Jc7SdZ1WGHnp7NLENHkzdwe5rIaMgAWCW0dasoHXxIj2//tb4iJ8M00P+IT9mDxwPde0RHmtuEQHqgdF+x/GjZq7dxndXJh3LJD5A/hShRuk4NHyTc21eJL7AlqIGY8c21Hmn4IXEuwYB5DYCIehKqlI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=T4V8s1YsOJfDv3dP/obkFp841tiXi1W3LOyj/klnHwOAKnQFKBfmfpBUUghHJrBte20YMI7BRk/MNsjUc+1lfqv+Z0aY8xaIgG98U7jTTe6WF7pajVslnNpsx02tRn/dOi7n0444WLHppHpneltDw39ca1365dCJlX7ZDC3qKlKS5jb4ibrKgNOB8TrPNYojIgZRp9GO+A5doeOuoZ1TOnpYTemqI91hGxKRWjJHxhrym208aPWwWWOGaWUNWui43ucOXvQ4Y2+l7xlUGj/NG+qWyFB81II89twJqveWAhxIwtTjGvHqe9Kz8KqF2g+BSRuyFZ8fdxJvUsWX4Y4oMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=VYSGlFBSVvJeco0uEUt/buVO5UB0vAf4SpvHdDbJwjVZQbW3u5gNk6dfkiIEOTGvzRDQsc9Nj7BI5STkQA6T/CSA0k2K+89zcqKZtOI6/NSWJZ+THPO7LwqihbdkQ2yhZM362gG4roKZwESwDB+ToNw0WMToYqNqCGBqIhdLlgoAHskP+PyBYHOUBdf0zFrx/6Iv2kesGmEvr7k3z/DbDnasJn3S3IeO+1i8IenDqcwZTtOrXkOx/LvG0R4Vn3wBCf8PrIGCoVCMK8l13RZajapP2cFRhneLyCyiHXxImq2ORlAerdj/7b25zAx0+qwC7u0yYLNTm4BG3iGseUj0Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:54:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:54:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 07/28] mptcp: check userspace pm subflow flag
Date: Tue, 21 Nov 2023 17:52:30 +0800
Message-Id: <662671ad849b15c44967221623090db6ed52e1a4.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6824e6-2bbd-4ffe-8d95-08dbea77d0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YQdF7FTdNJAUxkdhMudQkQkqFIVv+FHnGpkHOVI+RpsRoQ6N1XlmRe1blfDjC57ulcOTEW2ofXW6ugnPgc0GSfUCncKAASiC3r9lKHJEKyNxckaShi+qKGh7R3a3l9FZfiY78QvDN+1HVKo737FDdtWIST7SEaOZMfIu708puViKHvQH4WodAUyO6OSZ+HjQBHwfc4rS3GiDfVc7/5POCI4/nBwKFc1H3lFjVoSqh7pdiiJys3k9b4axog+RXpH7bfEjnqjA73BoE2xGFw/RgbHMILPmtXwq4caItCsq1i9sXzTHtb+i8ovZ9zONTvR9o4EAgNY2ROiC5JXbJOYeOVTCzWMP/m/6E2UNYvbcZWoCmC6QQo8VyD6XMr6spQFDC809pUVfeYQuh81RMq3k8gszcjcPVqQYpOd02CRGPmixRkMtopi7fNSG7TfK+dzDPjyedc5B69Vha3fxRcAJNy6avpIr8Uj1bc+b/HRa9R4f+z8hRsYizwuEG6iDC2dztHLlwasCn0knL82rk9g+FR8rJY2dgUAJRXhqoa/wVyplsSywZJTyH1gLsEYdlfEJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ghahx1JW1tRPCG6GWmCAqY+PAnjssDXGVPit1rJ1ZNafkmD2Jhjqnr0tICrj?=
 =?us-ascii?Q?9elut5s1ckdrs3BUYPlFE5RIunkh/FdeCl8M4tQB4VVbnRVcsMjQx3SFb+xa?=
 =?us-ascii?Q?IpnV5oLg5fCIaNqFqA7+f7J2AsUza4rXgNP3COV4e6t9T9bsVC6v3aXS71b7?=
 =?us-ascii?Q?EZA6Jq7m8jWYsMQHxwzW7INz9+beyrja1csu6b1dk1YuuMBAP36wN1Kitb77?=
 =?us-ascii?Q?kVG4dm97oQCOB3G/2YTM/nCVvgttZaqyFO34FuU3Mj3hhCy1VnWdoCHTgpXk?=
 =?us-ascii?Q?avws8FoUhv7/bOVqMTOgSzt/U+NGkD6q6IQ29fbTS7lgIuNjqTCC5PdaZYHT?=
 =?us-ascii?Q?QNJ0e5HTnja3NOti3gsgyH85Gszh8qYbaKRCscJJHaCUC3Mp80OZAOOmPZDD?=
 =?us-ascii?Q?coJtWPofgrGRHtwgximGiy/FnAn/rVzLjcl6Z7OxMAJSejomEve5Mxor5bsB?=
 =?us-ascii?Q?oEDqe+Wce7Ye0IWr10XoDXmKvvEWEyl/qpWwVuRKT7he8lOhT5hpxvgfo9d7?=
 =?us-ascii?Q?q7Veh0SN7GOft3sQVTIpVGxh0QhJnBXpTLvw2EOtQ8GizVVtuguigYvRXptH?=
 =?us-ascii?Q?l5KjQs3eDE48xywe0xe4u9evfVjGmuO1Np3mCuRlBeG1wZCGVwAdNGfZWVn+?=
 =?us-ascii?Q?sKUzJmVVjlBusqSeBSvdUXOsq0SVRCg/ns+k3b9rshfXTWeOxF/4xgGMEQA6?=
 =?us-ascii?Q?HNTNt5YHBNDXJMAzFO64y/HasOwA61wdPQWDSHJTIZm+Y0qZ/Txrcm8yMT+h?=
 =?us-ascii?Q?NM1TSmHNpc9P0L09iKCTSxWDv+6+7dp7Iwq52hPpHNKITrv3DJ20hCk2FyzN?=
 =?us-ascii?Q?vzuRoT3mXV1jgeqo74WYohSvS1oMPNdyyjQgfFh7OyghIaP3n+UNCpJnJdsS?=
 =?us-ascii?Q?2idGycj68FYnzJpMYxpnGD5p0u+2oaS/gKcwZmIJ8VzpVNq9wJXXIIc9PIiy?=
 =?us-ascii?Q?9pClu5Em0FjV0rJ+LZ8PseI/Yo+3XRI9JgKf7tFQXJlvTt+eSBONWV8FsEhw?=
 =?us-ascii?Q?fFsyE0AZ3A7qP9gj6Xk0rgVErM+Uj1p1fsv1Lxr+YZrr6TQBYNklucth84/L?=
 =?us-ascii?Q?y4Le4J6xhc3rEjzd5PjGEyed1t57au7m++pvfi7OK5krAcapP3QiDg3HUnTX?=
 =?us-ascii?Q?HK2G3+Aucbj1I/av4LBM5ruJBpddo8x2zyHduDMBRRZtqGzT/zXvs+HBaQ/I?=
 =?us-ascii?Q?/GyWfW1cwwCnMHFxDkNt47a3sIrGA9mFfbnU8jjGZdCQUdzplwG9mkqNAP50?=
 =?us-ascii?Q?QXmrNlRKETT4oS5HO7Be2QOERuYWkX2V99o6UiI43U8/K1d8lxt54pQ/I7rK?=
 =?us-ascii?Q?N+fppZuPZxHOhnJnlpdy/YO0zL9g9hao8+SvAiw03wfnZkm5ukbiT7U5k5cG?=
 =?us-ascii?Q?MivwoYnpgMHGkNYXDkuOGDcf1QKPpiIGvPQ5kCRNVb2/lSVLpGIYoWONjCul?=
 =?us-ascii?Q?TuftMGi6KsKqqy0SW1eFtcqDcuYho3npSlh7a+DgEoxDPS6NI5uAO5rhon6F?=
 =?us-ascii?Q?nh6aaAOqupyDjqo0wTe4ICT1E/xwu0/SFOIF+hQY/vgHsjHxszZepilXyrmL?=
 =?us-ascii?Q?Z7OssCdWjpv1bbhlgjMtTEdHD2Kh88wP7B1dpTdG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6824e6-2bbd-4ffe-8d95-08dbea77d0d8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:54:13.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRkBvsIKmwYtOXCj9G1TgMEX0sC0PIm1hmEC1h7KMTrpPnJNYBGItmfR5cV7zo7T2iPVF5mRfrkYLr89W/X1aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5e45e36ce1d3..de10be21bf26 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -347,12 +347,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -365,7 +372,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3


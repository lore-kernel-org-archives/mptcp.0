Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DE19A
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CQ8ZF4no"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cW9osiTZhB5jrVxrUGUKscyyalfuE0zHLMTZezrpoKhsMFC1w6JIC+dly/A6MRESKxpUJHOieFQQI8B+5wCuMiVSa9ulj/MkaVfdjYj+9PEoTkjkOzOb2TyhYSj3OFWfXqzOGSoXdNs13aKx85ir6/2+zgS8jOvS3Tc41AXchyl6Wzcqcue0tHsqtx4gGx7GzIDFF5mEwFzBAJlj3+tuQen/C7vxCeyNbecMlA55oSruy5WlgwmJv98rfutWZKLD/Jdj4HUJngGrFt3Y4BO3m6gLZG0Z2dYPwIvL7DFwmeJ8PeKy04H+apGLS0WvJL5YOqVvooRu77Ib7FZs/pLGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FdSO0iJpFcc4PaA6xa8Ml/9pNke5vvRL2midkpJe7U=;
 b=SpqQ1kBkOtgAqJf1mQu20Ekuu9JpT/XLL71BjpuRLy2cVNvT0RGENOWWG3zX54VFyQJzOkNK/Ke6HqqtF282tWtj6j88/pEWKnuFnxLJCw6L21FmNpdvQFfPSIs/Im9/mSXSNpNc5wjSJvML3h4rbARf01KHp4DNGjidxWBsXnt0UFz1o2tvIjzI3wP1cE302WgISQe4VK8bBGeWaFs1eCDOdZCRa6Cq9GtpYNsIluDwdiVu7nTOOtL4mP5Av477PhMrgjYfu260cxKnoyt6Lz2izjBeKB0OQCTaiosXCesfpAAVcIyPkfpIlEn4bw74ZqRdEUSstUHNW6U6XqWOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FdSO0iJpFcc4PaA6xa8Ml/9pNke5vvRL2midkpJe7U=;
 b=CQ8ZF4nora4KbhTTP6A05PgYlT89CMRbYiXOYJmrE82DV6l2GOXiXR8P3IuVS2gzehAeoKPndO20rW3ns1OnrChsiki1ycnST8QrNsqNcNeUSs5ttbX5vRtjtCVHhJdHPoWxQ0wSBVxKRb8Zvg44DmIQAmT+bUAWhuvL0D836D64h6a3Xq0tA866Qz4fz5c9a80ksyZc5d/P7rs8JvuptI5Z3nZ9UUvI0DgBJ+hwrQIRq4EBeaaYYduQCl/OB2LKDx7SeHlIWYwcUEquGYVHBfcw3CUpCz2FF/avBskaJ7GFyBN98CaXPRAuqyK2iL2K9TyYDsJ8kAYd7Ov3HEyHgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 08/12] mptcp: check userspace pm subflow flag
Date: Sat,  4 Nov 2023 08:26:19 +0800
Message-Id: <e2a9f208289de92fa605c5ba433bc4c78acc223d.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a785d1a-fe06-4117-9ff1-08dbdcccd4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sHXZn58iC3JRRBZR1gkMZ3zsQU1EUl/RVmVNS8XvurCVAPeHQ+mik+L/D6l8skkzdJBUSE3hf1Un2PZ9Sfst3swrs4LSZXGA1hR+qlmTd0OR9sL+aigAZI63DMmA5jMZdqN/BR27SePydXwLQDkyITocnpsS5oLiwa0ilKppvUNr/L2ZBmZ7geDONUmq/+JxfquZK52wjxSJfshCNTTVxU70fzRatG+lRA4xmPAl7MaVQtWLq4ZurJp/+1FsZfj4NF4W7bjxXbqQi/SqzJ4TzseXbnYuZpYg1CD90Dyd6PRJ/4qFeq85ZFQgPErRmThSDXTOC1ysVH5PsBHjOjWo4ZXkVukoiNW9bf0WlG/9WVlENwmLv4ORf5SUfkPa4JEMiUapMrKxKIBSc6KNoPgfAnUGevnfmRL9L0Bj7+C36yOi5ATPciKCENZRK8dSF2IM+ayXvnQ7PUZ4bv3+07ht3w25/MoPVGGZmQQHJtRykv4EW/IOrbhvN6Ykr5vJCV02fUQFPZWp8eq+VfzJ7bNSH6PYoVNAmyfwrke29LX31kHLX7BzUPsn5tAgfMTAUzcRNy8erxxxkD4ApQzJ8KpYwOhVkY4sy5L99HTzKL1yVUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?25vZDwXWmXA1E+rzqfZepq9B1vu+zdgw30/MsmLlsi6Bfc1yyK8qXmJV3dr/?=
 =?us-ascii?Q?wmI8+urjFeBVmXEvDDKFe9+KUIMvHznD3YKTvY4HVIe6eS11Tp1l27ko5e8U?=
 =?us-ascii?Q?vUwScAMLNEQnC3LNzn/DL3lz6Hy/pJ91r/tnSWpHxDW46KyyoZ2/Mx09vhwt?=
 =?us-ascii?Q?yMaMt3rQRuzcmhWy0QKhiNPu/cxpvz7wM3bF/CF8UN16IjQYUbL7rzvwwSYB?=
 =?us-ascii?Q?ywnnb7o3Up/efrFphzw8tFWIL5hUgHQfGl/QaJq3h0o2gfypfAsp02p8i4ZM?=
 =?us-ascii?Q?KewD37uiBgudL1GWI1ofVJitX10hQXoBIUALx81Aeoa3fkt3xTQvaIVQxAJL?=
 =?us-ascii?Q?d08kdaOWqgYAah5ylZaazzXhhTbLjkn5A9WQIYJwaVQH9zSqYmtNN9+TlKA9?=
 =?us-ascii?Q?XDZ06qT9zj56xfTUUZRcWh///O4Rr+g2tumseKpoYKMAZzqhFqKIk/4FZIH+?=
 =?us-ascii?Q?KdoDk9w01JsiNX1CWAqw7BqqPDTwsNeueZL6zLCSHCzxlxzKP8mB3HQRBRVE?=
 =?us-ascii?Q?DoOqEKMMJYYjGkSqGayVfuCCrd7/zMk0lOathSoxrlZkyAPyFvVVHhVxqYAR?=
 =?us-ascii?Q?UHznJrGEq/8edl8r5KN7ZJVruwVjO48P58gRAEDZ5LxJtpMvw5UYr0RhOdrE?=
 =?us-ascii?Q?f/X5CE9FC5ZNDDts5YSUur5Uvd74PlyRvFEe/2El91THZkicluu3uNsZ6Cwb?=
 =?us-ascii?Q?v+C8ts/nwcdFupnCyszkw89E6h1YftUvtix1VUt/0502j1Y4FItRn8h0guhq?=
 =?us-ascii?Q?9wnjsbuwQvqOfyVUsqk7Uz8qVlIduJ9H3BIxWRjgjUKHIltCvqhbejrfK1qt?=
 =?us-ascii?Q?Ku8NJZBRYNkW1cMhOND8ZqS9XvV44Uje/VUBZnqTSMyuWnrsKDd/S6dkf6V9?=
 =?us-ascii?Q?tfdI6p2AJXRcuciRhL8wdARxTisQ14azh2812lo1H+tJxTupGgCJqMuYY2JL?=
 =?us-ascii?Q?zpfO1kCjh1FoUvtfVnfkqveGMwt5ealA/SMOKLGma5yILPMmXwRtIxV1QMq+?=
 =?us-ascii?Q?mX0J8TJzUHsprmoO0bEWsmn/iTxnaFPfdXNSAD0I2pHuBM403j4mlyBoQPkE?=
 =?us-ascii?Q?AwmKVHT6TNMpgdmbVBAmWms5oaK28nXsYgARUe6R6ZeBP3fxAS1Fs5qBNuE5?=
 =?us-ascii?Q?9PAlKRlr675lMScnGQFb9xt0VpUoMnTEnJaWnybVF52DOVly5wwcevIi8MO7?=
 =?us-ascii?Q?ZTsalXVOKhXRRKYFVooNRESlZmJpgLMJntAWnFVUzYlX+B7iHItjHI9mBsuM?=
 =?us-ascii?Q?yuZfp2F2DpKQEhmisIjU94a7Ca6vmseECfTGGiEAFhEg1LYDRnNrNHHrt/0V?=
 =?us-ascii?Q?adSO3eQDl2d/UwoQHWGybOOPOcpfihpaFh4LZjLDgj+lqUyGrT9Tww2sH2+s?=
 =?us-ascii?Q?hQWuyV+qSq1x0tfsKt7WDNqp4pOqTddYUHjxNo7cIdDKkCVjfphQUj7yHCMV?=
 =?us-ascii?Q?KezxOXaHOGRVjjdmMgF4kBCFFXGJ4oU7nLKby5LoR5ikeMavfWZwuJTZjjEX?=
 =?us-ascii?Q?qzcPXOqWJ3emzsSGuhmWLAhjPY84LOoYxvfZPFsBk8ELF/HYx/m3Q6iBxFZE?=
 =?us-ascii?Q?uQYPg5PGE7FIXOTO4MHF6I4moUP58EVuitKK/aYD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a785d1a-fe06-4117-9ff1-08dbdcccd4b4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:30.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74Z3vYYG54t6F4UrnieV7yQp7rJiOMPYeq9gNo93bi/VZw+Vl7jvr3Zq2DRv1Ck2Q3fMmnuXc30xbLtIa26W4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 644162928f16..c27cd4336fef 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -358,12 +358,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -376,7 +383,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3


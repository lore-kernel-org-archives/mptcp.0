Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA111107
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARo5yjm+a8ihK4hFPX0HlYDl44yD5TWCsbe21XtWD2LhDwr4Zm/oHjimhWDu5xCEBQP0NoIX3KqXBLTe5LmSEP5ld7zALZmvtVX/c7Avv5Gw+4a0Cdh9SYqCTATOPq1BSzZ6e0nYnMoh/bGUaGwBG4MUViTmNmm8pk4JHlpJLhxGrkMl1l6rUw9hcuYkzhG2VuAYjWcQcZdIktnBLYBUnXQ8IzTpYtp4ghWKWXr1gFIHUDFIFwv9sajIzeGKK1/l8Sh5zCFfh8RS7g41nVurXwC8VSgkpy2wm4iYqX8u/T5pVAJ+MqW51WVE8bwxVfOYEGU8Itr4zk5OCcbkiM/foQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dInZIUajdHuxJUDgJG14Kc+DE02JYSEOr7Mb77Eg9HQ=;
 b=hCFWMHRuZ0igxYSg+nlVS74BhMpIQDAZ+/aff0VyI+eL/oM/fVZIowhm6uPN+GxXYxKcSbxQFouNt/4wCPtlpG8sW+WC1G6onVNeYrzaklEn9HhlZLo/1vGFimbdepVlE9L5LFsLb/Wd2ZytozQMA7PhpAualFJpzUhBQ8216k0W3+wXEDFz6vPf4dJjBC5Q5sjdGvM8TkVsSH9qmnCk4+H9NzZl9Z30WIXc7chWj2XcN+yoUfHByfoJa+cwe46GdJEQA9U9UN7C5ksrOhBUS17XUxNganzFaCPGBcfm6F2zopEs4j37JbL4SKeGPGT0p0KZXtHK+12m+tCBtoCWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dInZIUajdHuxJUDgJG14Kc+DE02JYSEOr7Mb77Eg9HQ=;
 b=QH2WB7gWXqiM5jHixHd33F97faZ/2TtM3dadfaU+il85IIsxeiWnZmQ3G9XUwNqvSJfxHHpg6oWkG3aMUCRGqpVQQ1sEMDzOjbunDFeIzb0DpRc9S/pCcMxeOBRpXB61pTXd86JvBTrIgP/sUD0U15kFgPtg92brYc1o3nds0kwYcG2CqipHKl3um7vDXM3p99gqf2P7qMxikO6qToc4bSULsN6i66pewfixV4Tj2YnH/Ttj5Xd9yMk5VNJbT/62xvtVbAl6kM6lOwenO/7Jy9e2NvnSzaQUv74DC8rosG57uYnU1nhBrMQG2Kcc13QrwZi85gHa3KXbMxhvYz9whg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Sat, 16 Sep
 2023 11:38:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 11:38:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 6/7] selftests: mptcp: sockopt: drop mptcp_connect var
Date: Sat, 16 Sep 2023 19:38:40 +0800
Message-Id: <24aca2da0236cc55fe3d771964f5bb2aa6fe7dcf.1694864093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694864093.git.geliang.tang@suse.com>
References: <cover.1694864093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f941e6c-e403-4cb8-6217-08dbb6a97c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yb3gnnw0RcmnFQCbnY/C6fVWisfdxn3qQKLfGUs3pbHcjhIelbuTyEeeZMICAFptP0tGtu4zJK2fUiVVu6f3w+KcxbCiipvSfvq9RtlGZ0zdhkZq9z1TIZhb4HQj0Q6BjZSA2HQgrUbpjdTEOe2iT3u3M64AjO89dkwjafZ8JhCGroywoPc2RiwGjV3dk37ctmuo+ovyuYbS3SDRFCMaGbUATRF4XcdHcad9mEwcY+ap4lSH4t/+NAAtvLdt61TC6UOc5JjFY+Gt1AkMncqdfYLSc4spSPwp29ReDYz+oT+YwJYtos386NZxDvTn/3dtCgEnVL5/WAs47QnVCv87B0qU4QUNib1julsAwljXPtr7Y/6DaVNZRm4T31IWjB3gWkyJ3PUgrh+XjzGf2y2Zef4cMN4VgxueDDeI/Pju9Sj4LEkEg8C9dEGcAUO0cd6aVfZGw160zgfsQ+2TIY1dH+ubfDd6spoViyG/Mg1zxigeNbwZI9HkYriq3vCiTRa6JXA/FJ3/6d7ClJzoEdFX59xX75Fcm3Mtuwpk3RfKMnv6t9KFkYw3ialLtSjP+bv94rKgISAS53xJh1QgHrnVaDpSzgyt31tljppdHYpQeWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(36756003)(41300700001)(38100700002)(6486002)(6666004)(86362001)(2906002)(2616005)(478600001)(83380400001)(107886003)(6506007)(6512007)(26005)(66476007)(4744005)(66556008)(6916009)(316002)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dOh9+vd/MEBzX/bqq8qcZji+hBBHefos/Cs5OK0NSxjm1BMYW5pc4wMrhqgu?=
 =?us-ascii?Q?PcM471kBK9JoNpt1NuuDbGFEXDFByAW6G7yQA5eTPjfQz30YjMlENEdLdnFl?=
 =?us-ascii?Q?qzaWKyOfNU4Dvpi0ufZII1VDb+88icpLOFNz4ObJByzYp2m0ko3ly/LaRp4N?=
 =?us-ascii?Q?EKisYkJOWzkj1PPVK6bPpYVYkh8DYIL+tj1LDQcRclInj5wiB3rbU7MMoXk9?=
 =?us-ascii?Q?uTIvb1w58h6JoQEQkUU3GAgg7dIji9FwXrDBgAaNyu33RfJ5JD4msmesHHpW?=
 =?us-ascii?Q?44TZ5vInvt4C/8Rvk6bmRw2tUbmb8SDJlP/NYLfRwQ9lYvcZMwyBgLc5jsNt?=
 =?us-ascii?Q?8byOHjeo29ODQKWEdjzndTyiPRf4dd9gahrTPEaGwPRSU9vH9rP8Nd5Jzqfv?=
 =?us-ascii?Q?uCziyvXAZKrinV6vI5Z2FDQCbstY0UzUTL5D5sIxNWksvSDpNVUf3RgrAWTP?=
 =?us-ascii?Q?/g5XavHPoy9P+XDCs5KhhZWgMC3EzgBz8AnNCrJyG+KhuFPO03sIom+xoIaD?=
 =?us-ascii?Q?kfQBeNx/qQT0JWzCwMBIG+nDQLDZEvnvEue1+3IXTLvCF9KFvIFn2cDwCZAn?=
 =?us-ascii?Q?4liItuFAPoLrNxZ20txLf3t18oi2KaU0SA6TRstMZqzG50rkbX6NfjLpezPC?=
 =?us-ascii?Q?z5/zzj6GIQGnJ7yAwos24D2Xc49uvZAO5bYvKq45NDCoeABU0Z0Kr042D0e2?=
 =?us-ascii?Q?njXNOjZbDzX6mHiCCGQFHHGfpWC6TTmRFNOpGDOohCEAyD/vDUCW3iRMAk5Z?=
 =?us-ascii?Q?TJw48Gb0j9B8qaaGshmcLSm11AA+vR7MT0qKwSaCCTUJ7m0ckv3qkAvlMOp0?=
 =?us-ascii?Q?TD5XD8fP1Ovk171vm4eh6ExzCgI6+70sYHbjLxHfHYH6luCrvCguJB5WGFLm?=
 =?us-ascii?Q?elBBshbYdACN3HT2dIha77YKPMz6KbNnbqOXTRHAg1xgI/J0MGwBQU6RmMGc?=
 =?us-ascii?Q?RQzpq9cMdASJKlfbCFq8vRptOz+oYK68KWVD3MOTKbZUIS9lk4BnTSIN65di?=
 =?us-ascii?Q?p6BJryh+tOMdelT+tyv7hEq/9zloZfdPTEPfqv30bfjpXAlYXJPu3KJ0Fkum?=
 =?us-ascii?Q?7ctQu8TQMRk/HpFlXLDqdkaK+i9I5OOPA2kJVnUNC/Fw+Mau7FQdyCRAYOkl?=
 =?us-ascii?Q?LAUGU4O3EyG/mdOFRncu5JPvHhLqQeAbfK8j2XXK68Ps2MQ9PPZe624hbjfz?=
 =?us-ascii?Q?d2KBaJCbLjyMRLipSRwWMbqHY+IzczrNhKD0rxTXdZRdTflTWbJtiv1SovWw?=
 =?us-ascii?Q?kQrseQINxyog++fXdkU6Uy2+xwNdLhzjCV24GgI4knskWupptZG4sT4NQj7m?=
 =?us-ascii?Q?s50LnpmuOTVXAnjfaTlxJX3fDPaAe3C65wnfLWkQRGNTdXMXkl0qNDNwV0rs?=
 =?us-ascii?Q?mZKIlHVbWTdXCwjTf1F+Vhu/pEXkDsDw/eAyWprn6obEfFtLSgb0EcINX8g4?=
 =?us-ascii?Q?NCQY5MkDVL5nZ95zjGaYNE2VDRMnttnnDhhP3fltzJi9bm2kSbZv3pJG9UQm?=
 =?us-ascii?Q?02UuACFbHAZeqPHl0dA+N4dTEOIF6kGJB7P+sEC7HYWj+tP48Jc7Cj+KI126?=
 =?us-ascii?Q?I+hw/RN3ptbclZcbenEOxx3iVfoS2WivcWPiS83Y?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f941e6c-e403-4cb8-6217-08dbb6a97c94
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 11:38:46.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vif18hBaWrvAbjraQiPt2kBlUzHYGVEKfGzWOKJxWRrI96UU0TFk0BHFgtiO3ZsRWtZHN0kgtWhpX8uhytcE6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

Global var mptcp_connect defined at the front of mptcp_sockopt.sh is
duplicate with local var mptcp_connect defined in do_transfer(), drop
this useless global one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 8c8694f21e7d..a817af6616ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -11,7 +11,6 @@ cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-mptcp_connect=""
 iptables="iptables"
 ip6tables="ip6tables"
 
-- 
2.35.3


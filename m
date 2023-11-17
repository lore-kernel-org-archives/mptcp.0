Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC77D52C
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KnCZUV+M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvilsktuEYE7fm0r5ddaR9+djCJGVzo+dTXeywz4fpHCsuLFh0CY/9dyiNlwzH+1iojJBQUWBdBmQIs1e0vwcDMmFHPqAl1hErTy/Y4K9dXJaCXuC8bmpblwbxSivWHvUUEurUTOLyiLvvykJ5Z+89tGYpRMb2RqlXvQcWolYxBA88ztKhAnIxOsDUU5XPZMq1tN15+rEWRLEj+vQg5OPDg9fZQYwzXqjT/7Pyzt7ZVFwMT0WcTkw7k+OiEulXMMWgBbaHHOjJQ5f6nRdbAZIoFEW0xiFbxxlAjI47Hn1FSqXUj3XTQfo6TxiP6rTZoBSy3a3YGRw7MGahLFsQzQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4To8AeNV5J3rzl5nBJs/OnFzfrlHMpzjkw4kDsjiu8=;
 b=hEkNohtPT2dnZ77HYRxUzuxF5NUsxyWn2EwEdPC99oCzZji49yYX7LENZnNsip1qjBNApmXoR+F7LO0ReMneeeiSW1xzUr3Z09+9ZTZZnayaWJvc2aK79hCCrO4Hhau7qiptc+XWhEniknDHJQJoZ3klRPOvnMCNlbYNThvARMOCW8WDuzgsPgD1YMssl4K5X6BBuvbOHHiTC0VQM+ekQ9wjFqqkiMmhRGKh0keWRQkHKFZHh5lcMEv9hxDdX1NDpw7NQoAOe2zS/E3i+52E0fiD5xCoTutv6u8dOROD7T6MSNCuo3tN8cM4NNT+daDDhAoUuepb3OMYevPu0gSUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4To8AeNV5J3rzl5nBJs/OnFzfrlHMpzjkw4kDsjiu8=;
 b=KnCZUV+MX5jI1fYboBveiINF2gyJnEZVLol9jEmFS704Jk7lBMiDrchDMvPvV9caqTIvPRbK9zdxzW2B4FcPLpiND7TYVKsRKXoCTNPRs1MvZWDQ7laDDseF3LUX0M0S8XWPkuKosY/SkClF7jALv2LZUsNdgnTXzeFO7wlY0pvv2PGcbe6OWGS4qg68pdhdjlC2rmPZtoV4VQYeQb5QudfkHRW7EETbgK46IzT0s+af6NFTtmIV0lPXykVm82zihVUJ5F4zvs1lnDSSaHAiM42vbAXMwLcLnHsI2uN1L37q6MoX0xkTjSeSJHbJTL5K41PvJdyStycx9+qADuYPAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB10047.eurprd04.prod.outlook.com (2603:10a6:150:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:59:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:59:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 26/26] selftests: mptcp: rm userspace addr with random order
Date: Fri, 17 Nov 2023 16:56:19 +0800
Message-Id: <54dade305d600cb3fa7796ee98e4b930f6c6506b.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB10047:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8121b3-ea56-4a7b-989f-08dbe74b733a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	770HcRNvDwHVMyV+tmDAfYGjTpoo4foXVVm0ATFKcTZclT8Cpv3LzRgUJeNaWaAMt0Tci9/CdlAXFUZbmNo4cuPwej5lg+dpwFLjq38JGpAyhP1rT1MMuMrX4bsiOmptAn6idcP/GhDfeQzt4qySzCHh69jn19PoLlf9Vh/cVq39uIOY75dwUalAt1Vr7B+S3nYiabUESwxGElUgHm/J4mNPHRTbbinQQSRUA2AwZiiQAgU18O+92FA79ZSLjqM6Cz23575oyoF2NMvmmwbUX2buf0UsP+635m+fmfgbMxGR2iHJ6OzWeR9jF8QFd1+PPdVN4iYVsYn/rEzPSc533cTG9T7xJwE5BNuywwyE0MNuSEihkxrbMc5nSzX1QPsi0esP6H2dAPEkUycjlGU1vMHm6reo5V/e0Ol0OJy8lIs7kRNVHKGlz9XE9i7GF3f67FEqhACm1YFoCXyw3HOW2viI5VlzFtHkLE1FAm6vd+JhaiRliC9xQ8NcO3nDYKCIoucVIfkteMFbdwQxtZzdJ6wNrH+3Q6olACVve3xkvknsYgzrnZ5M9gtFW8UhtiuB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66556008)(107886003)(66476007)(6506007)(6666004)(6486002)(2616005)(6512007)(4326008)(8936002)(44832011)(5660300002)(8676002)(2906002)(26005)(83380400001)(41300700001)(316002)(478600001)(6916009)(66946007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RsUPsoXHJHKMgdy9Z5TuaUpcfNGgIqyJiS5qarfwXAxNC57BL8GPm4mPUCOP?=
 =?us-ascii?Q?P72MaAFexPKqesPpVrJubyokN/zOqvyaYeZDpB2iQPFvIAzaCJ9t9Hj/PV9w?=
 =?us-ascii?Q?6CWyPpJq8NdfW0pz06hXTLkgp34ueLxPiCKFBaZhi6iS/zUI9ZqEdji2xjyL?=
 =?us-ascii?Q?vzNyvL/ga8iDYp1uUPVaAwRCjPvc/3dfpwXgBpASmdd2Oq+4aGiBZ/aENTCl?=
 =?us-ascii?Q?Qe8oD8lDw46/GHC1x0u3pPCvEGp5FkquoAubz5dN0M+X3tHx/QmywGEB+ybp?=
 =?us-ascii?Q?vlDILRnAhn/08x6ZPRnNNHvmVvfdaGQ7vE1bh8gmQbSaMOBEcQpSLe9L4r1c?=
 =?us-ascii?Q?kQyYsszYcSQm6lCzZ1Ac+ACMEsXMREMeai0SujBYAoKFTVFghwLUXA8yCUMP?=
 =?us-ascii?Q?upA417dhUSJRbPl61rrJOx6F00z9otG44AWkPTR8uXyzqoiDI578eqopL5uW?=
 =?us-ascii?Q?YT8CfiCu4iTqGno9loq/VyAbYxSCcdzvEaSWkgI3N2jYky/A/skRM0afeW3+?=
 =?us-ascii?Q?DxaiO4sHhE7rJ/xo7JPZJ6qwDePh2kLT7reDxQZdwMxBzICevH2PhtZJSiH9?=
 =?us-ascii?Q?e0HYQMxKGwzJ+Nv9PAMvso0eYhKBi0gvKsJ5O8tksnSW2najmZQL8aByaHpH?=
 =?us-ascii?Q?pCGnSWAIDP33NC5SroqrAdXXYr+zjxyvdvVG4J5cJtGUJc9QYI+wWCuBqxfo?=
 =?us-ascii?Q?0fyuiYDa+STdx+xkob4vligUUYQWsyLUwOBcRoDF6zUcLtFs7Bp49a15X/yP?=
 =?us-ascii?Q?meoBwAdAcE8p2aQRXdHXCa3ZZXgJXqgVv3zyU8aI3UZQGJ6r2vFbTK8wH0pk?=
 =?us-ascii?Q?xx6jetiQ/rVgg8MqB4PTbtpQHEkMzb73ta55SwyzAhQUAtx6pH5n6xpc4HgU?=
 =?us-ascii?Q?w3cVyoLpA9Dff+kJkZZ7x+WOwYm6p7BGkFgfjztBSH2P0ORAu43nSQ0CwWdZ?=
 =?us-ascii?Q?OezSgvszsQr6SdPdYrpQG2JgMA4xiqbqY9lAspiof7z5woYctQADCEx9djIW?=
 =?us-ascii?Q?DEME78+SdjVvt9VMasWlikOC0XpmoYN7jetlBTbvu42fKp6TFSVkaCHzcncV?=
 =?us-ascii?Q?th44xSnWZW92qdiMxNChZSX2znvZWnOx07AOcshMCxDNqfYC4gmZDvA44dQF?=
 =?us-ascii?Q?RiE/H21381dHEpwvncigSPOom++uTa8bI7UPoOEBVsmEmfuFeaqRojIdNw/q?=
 =?us-ascii?Q?fZB4L2wj0hQPguhwXQGHgWMW9UUQ+14wm+p1JLMNkew2RJH/ysjZVYZayPFf?=
 =?us-ascii?Q?FwxhWUn9uI3pO+6TT3IoUhxyujukUkwk/8HqsqZqmIjxBEgTfYRqnfjDEQBU?=
 =?us-ascii?Q?ElI0vo8m8hfmv0SNY7pPxPFYbgNS62wW7toz3SmfP5e3ghe5lb8XGWFrkQi1?=
 =?us-ascii?Q?Ebe5YZUH/qSbRelQp20QuMZI7bAQPhRjpOpQI8aEaJ68351k7lng5R8mCjDm?=
 =?us-ascii?Q?qKI+O4Q6F9d+tHmefohqWaRGL06UulCxdLqCo+HjQ9zyz1xsIa1Zl25paqi+?=
 =?us-ascii?Q?X6eKSJrorlfY9g0jPP1/E0Y92Swj1u+GuqlTA/jZ/o3yCa49GAROQFZvEKGA?=
 =?us-ascii?Q?OTJiYQ9NWtfselwc9vpH6mYLdS6K67yAJh042hO+iPog9JaHcwmrSsOC6YL3?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8121b3-ea56-4a7b-989f-08dbe74b733a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:59:04.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIeOTdgFnhQESp9nPtMR2zJdLH6xUPKOcMA0iopTDN/daQfFScr3Ud4E2+76THNhhxj0V+PKy8bLT62nRKsL6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10047

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 372c2d83b4d0..ae89e0eb6230 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3411,8 +3411,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		local rm_addr="userspace_pm_rm_addr $ns1 10"
+		local rm_sf="userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED"
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			$($rm_addr); $($rm_sf)
+		else
+			$($rm_sf); $($rm_addr)
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3


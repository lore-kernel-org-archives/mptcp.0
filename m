Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A223DE
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJbey8TmhsBX0fZWdeTecRjzNdWRpanoDXc2aJbGtHa7+/pGRCR+ZGO6/GwhQC2gyBS35umDrOTRoVUG5XLeVeoC8oyRQ0g0DvKtUb3r5nccEDyevA88P+6lnpVf7Vv4OZDim7zhcs1p+9ZM8Us277nqIa9HvqsavQcW2Loe7S3VDuOhKunMpR3BCvZBLSZ2Tn5CA0IfePRCrOVJnimf5B3EpBMbp5D2KWnrTimG6IghZDve0BXaR9rXEXLgIV8dwObzjDKemCK+UMPF46nKh/mQZickVhNe3Z6AbPVsEGqpqOO7IQJBjZoKDHT0evQovZWWJmY5zoLQm8mF/gr9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8IE9+Yb/KlZqXRe1/n0wrGCSBQ4I3RW701csMxBtR8=;
 b=KScJW7vfglV0IIU9C51EcA3yMIPS9w0EcwxLDDqtLgXshbZuW+1OxtppEK4zjWeBRhojxE+vZlEoc9cpLmHa8/+p4IH+bDWP5/kHwdOQpkIAragRRSz5MvrOWi3aDFCYv447lX1CZguMShw51m5G9tdnHr1bBuq2YeS85TjlsL6IPy8iZvbxF2vqZqotb0OudhNFNKYFbfEZEYwBHBQPXdlYWzfW8yS6wJqFAVd9GQdcG7JTHSAg+7XqVrmAQG+RDRKz5cbFIyDOG28tFADU8GOQrUsn7AX3LsiOs1qDdsmkLI0NE1idLhv2XviWjaP2Fdmv5U6VmyJ86om008o38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8IE9+Yb/KlZqXRe1/n0wrGCSBQ4I3RW701csMxBtR8=;
 b=WaSUFKdzKjyOHdrL/reX+/aUvRNzYCakSljtIHE7FBfnnQMwlDZYpwOc6Eh4AVZCR59X/cUcKOv2B7ufskC5ZGdKP7c/Dyj0Bv+oQYVBppLjZ+viQYLO5YcuEXx7+n1UhiSUrVhamXS62LF9kCHsj5P1lVMkc3HEvzam5esxNtrOMbAfSxgtZyK36Q5h/G0/rAOFZUOZL/yKmsYTqRj1HERfOUAL5v6ch1wl7IxV8eoAC3rl2G7qtoLOqEGhk0OipSwC859TAtQhThXOHoCeIWSBFkbw9KIXBav6YWcGksWTX2yEpTgyLAt/c3NQMV+mEu/hPOofcmfz6Njp52sBtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:06:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:06:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/9] userspace pm remove id 0 subflow & address
Date: Sun, 20 Aug 2023 20:06:31 +0800
Message-Id: <cover.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 132e56ea-0662-4d26-011d-08dba175ddca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fc2meRl/Gxy4d5HxF6DhoprTi5+WZ0o/BNFNK4WaAocJKN0aImFozIuvNF8+NMKjxQO0k6ucu95IZkVltmEddTIfQBouWshEA8QRpSp9x4u1dEYhIoN0F2sMDjn8xkdJDEENNZm7FK9abeu+LUjd1w0p2qFk+35os44HobEgZv7NnrwzU1EPFxGg9cf/H9iHteQ8PrriPmtcU4UtJCeQJ41oqGm8KtMhtb/bV15QGO9YqLC3+IzubvlRK2jmlLtlwBNlVQpxpH7iuyXiaywBG8E7t7gxgikJ421Ss0tABl9qmUENTuZ/yTwb87TrHbEn6oA+EQvDbKLjogUKmFJpZI9NfWqwVjAtGmSvhf1a/QgD1i1ohmekdFIdGA9sf5DFxt/L81LgSEN0UOIPJfoacKEbqokoGzOdbE0NJ+X5enhNvWMQG6VaMXtY6vzYmDbeayOorDeEmoCxRUJIOFSUI2f8pcwEAczjM/F0bhGq22zo1ywvCI/zZ+urXYwMxkrB/Js7j8/f9VeTR7s1s78lFKtmrOgbeb8ig5LnmA9uMCVcV1HQ841PER+ZbzrwyjHJKzzkN4sRvAZDLLpZF86B+0OVrLcMBWD5R94Xrx+u8Y4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(966005)(41300700001)(38100700002)(6486002)(6506007)(26005)(6666004)(6512007)(107886003)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrSYyyekXJisyjeP3O1uUg0lN1R4C269YO+rUe9mMCUWmHhiTfT3Jpiptb9x?=
 =?us-ascii?Q?4MV0SuEOWkVS89cGIFH7sl/01yiqxxVkls640G9nhsB8Ko67H1q++8KEaTpm?=
 =?us-ascii?Q?FrF9bzLtUqVXztht0JY1o+UqQDD7fcsevwn2l+fEeZDAIxkczrNBxaRVbpqO?=
 =?us-ascii?Q?4KzIjhP4tElzDzX5IBGqFnbD9tRLJ1mJMdMvnh28gZij989mWUp6e4VvnR3I?=
 =?us-ascii?Q?pgN1In77QtL58Q+Ern4oStJL6ZadvgBXqCtyoNO/KwgAMQfwdG/cy5Lyeb0Q?=
 =?us-ascii?Q?gacIS+sEzk2DNyvPWI23nNetzmbjHdnCcZvCJszdxpDNGqm9qXAh32CUeSVs?=
 =?us-ascii?Q?g2HxUiJfp7l3GqlXyPsv5Nq9U9Imlfk2kyjs167U9VgQ1pu7spRZ+Nd8UVki?=
 =?us-ascii?Q?nPDzCQpl6ua93HC3ljVImq8espT2m+TMQamhuGr04guZcI0gYjiuBPC/0NHW?=
 =?us-ascii?Q?TiE+Znnul3JozFOqf8ErK8xL7dr5qOrum9VHPgS46Q3i593JIhcT2BlaYMQk?=
 =?us-ascii?Q?wHyAXorghOaWQT4qd/FmB0YkoEgji4ByxHOSVCSSVViGBnA+wz3+8mG+syc7?=
 =?us-ascii?Q?DWe45xHj2qfVTLB/PUd5cCon3mljfhcI+vcOrKZHk/bZjc2S3fys+AkkmXE9?=
 =?us-ascii?Q?svHydHWhr1IqNKQ+ESuWFVhSZLjCdt5dSJQfE9026K1qcYFp6FoUONvJdS8V?=
 =?us-ascii?Q?XxIXg8bAkpnDFDmdn34jW4yTCw3bKVMlQuIvhtosggPRqSIs/HTPxeQv12kz?=
 =?us-ascii?Q?7RdG2C+CSAJmxTrzc5MW5hpYhmOiA25PGdV0+wAInu3ZxJqSTniMQaOhPuls?=
 =?us-ascii?Q?0RE2f277leYTm9skehbZ2q4L2tJRuhGum1EWnmA6C5QYI2angbH4ISRn0Kgs?=
 =?us-ascii?Q?fW/ZCrQPu2+mitQcBxdM61Ix+2x3Dk9zw5y8QRtBMvS6Ff8be6fJe57agcYW?=
 =?us-ascii?Q?fLi9+5IAzF6hiyuxOfEmnIsbppVpEnOc9ZnVlJbnmQyPjItOjkW/y5wlEqki?=
 =?us-ascii?Q?Jxii9IKj0SPvsLURV7sfkTZmGNruuqHqG0fvG2EVX1lqMH4cNOT/hHghoZyR?=
 =?us-ascii?Q?jmuBy5cQD+MVRVbBHXakKDb1afz10jpjRH5DsXIwNlbVB0Glw+fm0n1yeOhD?=
 =?us-ascii?Q?e32I08cGRYRFJM5rp17/ja2ckxqBFVn98DZdfKRJv3vjELx2KOjOwX+pDeDY?=
 =?us-ascii?Q?x0WKl8PDSi/QYKBXiRu05k7ZpIZIr6ixNp1WZ4SdrUbetLa+ppC2sxyI3i1X?=
 =?us-ascii?Q?Nqek66vihIhHwrhapruoYu1yLKNQwZbpC/yvMcbyvXXoztlFk4nbmGoC+mUy?=
 =?us-ascii?Q?aLh9wQjUhNaWefJ2NmQjcQRXvckdsuTnOknrW89BJnCFnN+xsZu/YTaBLGzI?=
 =?us-ascii?Q?w6K/0SwgmyvD/UBynuwAjq19IDawLhEK4amklm94MA3E5LgZ5Wx8FnuyGJ8R?=
 =?us-ascii?Q?jwT0fgH+bTvi9lgqavmiiSCVgFXbqA9fEdGyFiL3g5d5s/A9MBj4GlRxOnEg?=
 =?us-ascii?Q?On48HP43fTlBs1TiQj4y0YQCrWIqWJrwiWIFmL3Hu4W5Q94TsVh32hDpbewt?=
 =?us-ascii?Q?sHdAF+cup1IG/OccLcgJL1enQZ5CF9/QXdayvPyt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132e56ea-0662-4d26-011d-08dba175ddca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:06:21.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUiwqlZxlE8ZRW4HEL7Z9S1k6b5XBDGkAXNAGSEHgdQN1l5Z0dh6wzhA1QQpupmo43AM3UIQOrZvRI9Cbold/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

v5:
 - update userspace_pm_add_addr/sf helpers.
 - add userspace_pm_rm_addr/sf helpers.
 - remove id 0 subflow or address will send MP_RST, add chk_rst_nr for
   them.
 - add two selftests cleanups using for-loop.

v4:
 - add evts_get_info and chk_subflows helpers.
 - split the selftests patch into three.

v3:
 - address Matt's comments in v2.

v2:
 - fix CI errors.

This patchset addresses #379 and #391, add the abilities to remove id 0
subflow and address for userspace PM. And a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391

Geliang Tang (9):
  selftests: mptcp: update userspace pm add helpers
  selftests: mptcp: update userspace pm rm helpers
  selftests: mptcp: userspace pm remove id 0 subflow
  mptcp: userspace pm allow creating id 0 subflow
  selftests: mptcp: userspace pm create id 0 subflow
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address
  selftests: mptcp: simplify checksum_tests
  selftests: mptcp: simplify deny_join_id0_tests

 net/mptcp/pm_userspace.c                      |  40 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 329 +++++++++++-------
 2 files changed, 230 insertions(+), 139 deletions(-)

-- 
2.35.3


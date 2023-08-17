Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F81097B
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 14:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hesUlZr2UP2tIFcqZQldYpCSHDfX3MMx0ny657lChuHBWjAFT7nGuidQtHQpNr1tzrqJQO7NMdZ/H07rWFADKoIs8utXU5ZVcXM0DiiO0gyQuUyOQK7BlJW3RXpBq05+5PAMJe6PYbd8+nbD1XW4maI1RHDmTNjNOq82BaN9TEKd0uGCVdHQgNZLeuaXLE3fK4qp8j53TTzdxDDkFR/WDdcWGZuE6k+A4ZokEdCjQ1zKOWpM+MD9fotc8VVoey79AW+C0xSde299czD5g+Pg/HdP4rB0NU/exmZa2SZXeWGdKo316yT9M3K5a/WvckOomsN+Ur/fV8easQTawfp+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjBlDzqRYUYs11hWUXdYbAOjlac+SpaCTmPU5QtrUL0=;
 b=ZqsAHmMBAKJPGK+hs26Rm29TOfzPf6csRMJatOZReBZ8s8RKMIf03+OOWhehMOM46GlpR38wAWAZqxxUNBk4y/XzdY3zQWbnW+qnz2PR4SyB39fUBVsYz7hMts65w27FBabVvX8DfGwavG1CfYGUVOdi3J52nExWZQ3pHtaU59pAnrHObmnRhM1yXNDS+uao9kh2ZBziOxnjlGl24HQK3GZLOjg/Ov/sR7FPYKp7i4+vMsTBo6w0XiXOduACp1qP9gFIo6VHqGVHQfkPsuxGFm8a12nKlb530LeE+8e2DV2ZVpt+xh3N8MoVPVWHjUISRREDl02ACt2udUDjZIkfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjBlDzqRYUYs11hWUXdYbAOjlac+SpaCTmPU5QtrUL0=;
 b=s21KpRgsGDX+k7ce99VaY68G8sZlDe41jbjv8EqXd1wi6t3yeRRBu1DGhZk5FernJVWBzkNd8U8wn/56gT66wMX7JS2AV63j7EplVikgprDrCXo5y/g6c35G4FnvCyfMb/EMeD0nS5rOSRRuSpWCqZCrKR7zcVPUU8wQmHeIUo+0BcXbF5nIRoo0QL4C6WUkx8Eac4bQtu1cmwQT+PL+N77OZEVcJT8Zyd+vi+386LvqdFLE1ozI6gMtn4HNULHvDu9mfEItu7djN4gTnPnLmWMR/a5m7RHTYkaLOg6qmxih9Kfn5Hh4QG+b8AnllbAGU3vBJsG8it3ES1gUQ+3cZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9057.eurprd04.prod.outlook.com (2603:10a6:102:230::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 14:10:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:10:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/3] userspace pm remove id 0 subflow & address
Date: Thu, 17 Aug 2023 22:10:46 +0800
Message-Id: <cover.1692281317.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0218.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 314f8097-8aab-426b-e799-08db9f2bb5ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gC8HCoiwLAfgMuTT7chHKIeJwtDjlb3Uunlv68Nn4S9tg9ihVPx098g5iiSJiii3fhM1WcHSuTwKFobovXnZAOwubN29AoABSoM7iYmRe0ZTMC13mB3o73nxFI1XZjrOAr1TrCUPQ3mHH0K3IcpPnt6EHCAGxLeFtRHSE0fpI0V/UnLbJCBULbCKX+BIYnWt0wpzNBophd2RCa3cq4X9dRL5AIOcc1n4E30ju+Fy3FUYaWj4mr/0eOI3PLi33/4eDAuHOfsqIBY4lsXIfhn3rZAocQ/Ts6vTaQdQomKUOKJxJie3MZlUD/DGtQB2Cgo1M7jLupvLiq2myRU1dTmnwFa2WNBlK2SxOjOhiEzpXz6Rcdvig95Nbfn0XRbE6gB4A82DwEdruJ16wWVJfUKxxSXyIzjuI3WFl3GhtH8PNjWoiz2G+FLKxDqtzoloBn5bljUMmCke9bpFtpJlDPmmAdzczl3Vg9xqFCe5YJAbgGCxKcVNS0R5awkGPu8zdzKmtui6FUMlRHmrLjomIzbxjLRJJdkd0Ob2sJao3nGDGGv2iTwt10xFFF3C8ajxrGeUz01UWqnW/MO6CD4SyCK0VCmIR5bG6ffjGdamSVeIgfc86G3xJtMwIvzV04j5vwMJTv+7z8tw3faALCbAG7I8Lw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(4744005)(26005)(86362001)(478600001)(6506007)(36756003)(107886003)(6666004)(2616005)(6486002)(6512007)(966005)(44832011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+jEYfucCSdyoyd3YaxolZg8LtdN6KpFVfvs/qV3RCZC+UOG95YR+fhuuDMR0?=
 =?us-ascii?Q?nPQz8H2mlyWURLWJ7Qc2tS7X+VD5XxHIRli91LvHmABErtBZtOU9ZKs2xMp/?=
 =?us-ascii?Q?sq9BVr7VA/ASg0gcMdtp8Ab+MEs6u3MvLGk2Jvs3ODy+gqwje1qiUnFusNSE?=
 =?us-ascii?Q?/h1Ib13MIpIYklhrP4h+whx7Bggg3557FTYXR1Pm2g5vR3+3FIZRhLK5nhtY?=
 =?us-ascii?Q?lgL4v2lYDm3zsBlGkAXzPgjEHj3aF8YFL4PGtHiZPawZa07mhLgP7ATPmfM1?=
 =?us-ascii?Q?vR8zXn5hbcdyjLqx/6xCvOU+tzSMFy9p5fYF1L6P0bJ2ljv3ykJcw6azFXnk?=
 =?us-ascii?Q?jTgc26PgjciiYW5XAhO3G/FoWfXGLwaV0x3QDLv5m28Xpywhzz0gule2LKf3?=
 =?us-ascii?Q?RXj8vFf1ysSfmlstQrMeUrQjrJnRAVuM8tzVr7BhfnAsaI23JFQJagG/X2pH?=
 =?us-ascii?Q?sB/ioudVTLu4sVhm6h4lEOeC0AMoiRvPP6kxPzfD1W9yQrXXK6V/ZZuwQDpK?=
 =?us-ascii?Q?Ho83xafHW2nWcJfvA69SwfrdSMoItNr8lNG5kll60wjaT/Ghd8oCkTx3K47g?=
 =?us-ascii?Q?DFIzIfW0aNcNFPxwEefw2i4KHiFASAX/ZDwhOYv2bTMFPfA8YpiiRz/1q/yp?=
 =?us-ascii?Q?nKvib0Hh/lu8xx5Bvc0QRAI+cxwY4bJWSq9jqkOtWaAeMGR20jgU/KoqrzdV?=
 =?us-ascii?Q?QFRuyZodgezBBSNcjcdEQHxob3T7pIK+tw73kDRuumrNryc+wHiUo/Rp/R89?=
 =?us-ascii?Q?pCOX4rG/foYW70USFUOYdxesNDZ5Y/py8URR5JNOByTJa0kCQCVFXEcFw4If?=
 =?us-ascii?Q?qK7iPjuBl6IqAjej5bZ0F0j8wcW3Qlz/Y+C2+VR3n649uzocRRXIxQEvA8E/?=
 =?us-ascii?Q?38RjOSWnMh8GY87o6btSSIZkWis7n5COK0vokOQONCGju3izSQuDLnxxExdr?=
 =?us-ascii?Q?1erxsm77u0XnS3Xu4jcwRFIPVJZvatOXwJ3vD8g2umMja1y4emtVBmxbrAAk?=
 =?us-ascii?Q?LrvIt7nerYUpEB3Si+5JnwbQUddAxvzZyypSjJjjPJXbNDKud/lo1QldU4mh?=
 =?us-ascii?Q?I//q8Yhj6361nV/0tvnObKwY02m+lejx379VfQCeZxpTLGEr69kFkHuhYBZ4?=
 =?us-ascii?Q?osdf46QxyAVkvN4dYULGrmOqy4cf/3hKD0+Eig/oIaJglpvZOEx9mBnH9dzu?=
 =?us-ascii?Q?Fi3IkZNZ3cUNgnwCXQ5332WlublX4MhmDzxkZd6UqZk+efoAS8GIEbMEXuP+?=
 =?us-ascii?Q?yncSOdFvYuV6hqlRykLyWCBIqEUOpuYOlh8XyCjC3QwYKvVFk2CoajbPvzvh?=
 =?us-ascii?Q?VrmhANuQdFTAkVtU3XdOHFINZAwnc46YKV1n6DO8nKp1KihtFu3Bl/IfFLQx?=
 =?us-ascii?Q?ouLs/aUsr5UnaleDGv32RvwxHe5i/zRaxUxZVHcwH/HGD+w6BR3WCnkNHycK?=
 =?us-ascii?Q?9I3K6wK9SDSyZ2PiLzjEpd4m7Q61HfWAJb1fWXCMxG1MjfpfKrAlKdGzwjV5?=
 =?us-ascii?Q?HR8xhkk+hjy8XMUfhX7HpHRzDR9gVmwRb6MYOLPtSFrybbPVcOsSSyrlQ+Xx?=
 =?us-ascii?Q?v5lciYHbU2RxFP420psaVCV45y5hR4/3bHvruM0r?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314f8097-8aab-426b-e799-08db9f2bb5ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:10:29.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iyCaZYKFcBAYoOamZ6bbtb6U322bkbVRN8/IgndB6qakpd4d74zSGJ7i3JxPdrxkhJb1IfxnhHfA/EZvx/56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9057

v3:
 - address Matt's comments in v2.

v2:
 - fix CI errors.

This patchset addresses #379 and #391, add the abilities to remove id 0
subflow and address for userspace PM. And a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391

Geliang Tang (3):
  mptcp: allow creating id 0 subflow
  mptcp: remove id 0 address
  selftests: mptcp: remove id 0 subflow & address

 net/mptcp/pm.c                                |  2 +-
 net/mptcp/pm_userspace.c                      | 36 +++++++++++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++++
 3 files changed, 74 insertions(+), 10 deletions(-)

-- 
2.35.3


Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3911C2B
	for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 08:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okt7QnZFGv2dAlQYhpYdWna6PC6y12zC6q+2MzbrFx07Ug9bY7WFBkVYsr18++4NikwKH9XlIcnpR2iu/oBQ685RK2u7XojfQ949Zwe4jw5RbD4WR8hxr5ldvfheAQ7rT9n5FreljFn4EGZOciHEA/1asWncyjDiq1JqMilONEjgIEcofgbE+O7XIy1H+NK6+2/9kizVcJVDOb/SD7BKJNFapj70j4dY42QjFrOjs8Wlp5kK/52F4l7iZY0JaxRj1URKZVbQRnEd4MgwY9yV1XtmlDwVfUQFxnSKo9sDOuXH2cd04TTiL7aZ1dlDdX+pIzStukLORG1Yc6B/cTjSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dS1LPm4+2GVn6X7cpKnsF5BkVZr4Pc6ATuTahhZXIk=;
 b=T5yoJAT2x/F3iC/S8LtZ8xtKti3iEwKm0T/YqjkJlEwu/Tq2EscApBTuE0q/NYdcfb7VESXwU6J+cDk9NRblUPhFQUVhLboUAPJCVkUo0dLkDFkvHeKF5pliGLVM5B4rNdzcBCs9iWVOBOPiwW+ml8LRef8+h6zin9c5xCUDdVOByUhARkmxHbt5ElkGgoSKGqlOUAAs5CuU+W5+vJ/b8c6NH/JpVCkRMr+QWWHAgD0vpqt5J5J0jUsCYFkjuXed06y9/ZzDiDh5Jx7SN+ppfy5eU4DFRjnD3A1ZCYle4T7AoM6wmESMpgLabIm954zTC3Ia35cLp/aaCZcoZRDJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dS1LPm4+2GVn6X7cpKnsF5BkVZr4Pc6ATuTahhZXIk=;
 b=gEXykyApitwGVW8Iz8cDJfAfPh27rhu9rmw7/Fa6VbJPjBZIwde7Wt38XuqXgZeDkedYQB78NUhsQ05VqkY6/Y98kR4wqr6mPOjFxnQKBzOr36B43QRPX7Gf/STtQkB5fVx7rtJ26OM4asbL1ZmTf67r++V9OuHEmbLkVBKcq/MHTuq57cnjj17H+nlai2GlSLbw1cE1ull4O/FfQZaUFNsttTcLY680lY8AXZax38ZZJWWpwbw2uXSuxspFx/aWrGS4Imn4Spo3mhKR6qspKCTDw/WrRQKqtusuVfYv7v+7Vdih/7vGeeQWrhYYaB5LU1K96BMm5fknf/LI3MolQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 08:56:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 08:56:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 0/6] update userspace pm mptcp_info fields, pt 1
Date: Wed, 26 Apr 2023 16:56:21 +0800
Message-Id: <cover.1682499136.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::31)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: e05af2f0-39e9-4543-6dac-08db463424c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YhXM0kNI+c+lvB1K0/hFNJ7dXOcAcbOvkQ71RHD1CC54sGkbUitZ8sl1o39PtdXmVspozXeoFc8x6F7b5rT3J6sO+Ai9B85ddZkhh0aUFg3IPOOnHq9PUCzxyPkAA/5CvTvJxWZyuRYh6Zv127GTWX6s7a1u0wRd3VAQhuE4c5vLBcHQ5T53jUR3EhcUkkTjrhf6+DPwLX4svlxz78yCh4Bu0EXGDTHGEmVS5y3p/7uYaLUdRenbQApfcHqbrsVqHl8mKBb6FUpS+2xa2OHCHwSKsSCav77gW2pOOwkBTygeLZzrsdvpmxifHgtBL6BVOhM4AaI9U9SyrTirXUfRzev0ZhFcQkM5xMx8lA+gSEH4EoCh3FH6HybjezCU+5s2peUKrWWdzTCu6fgx8tJ+/nwCBKIKR940eNHW6C4m1KovNiuDR6TIZ7j0qG2OhMFGr+LP+uE1QDRG0/1MxgbLq/nXco0y2YLbCy0Uj0aEKzl+unfV/3gFOXEsiK+YFloFDwGoMFvoEGIrvjkLjMVLWlJ8/+BxzTwyGqNuvXxwPtZVfbd7I/37Ohy061/IE8c1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(5660300002)(6916009)(316002)(4326008)(83380400001)(186003)(36756003)(2906002)(478600001)(6512007)(26005)(6506007)(107886003)(15650500001)(6486002)(6666004)(41300700001)(2616005)(8676002)(8936002)(38100700002)(86362001)(44832011)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/1tzj5lbTnrFR3J75wG0YjzdEyO5oMY+NslKF9fcKpPsXOBluV09kgP5l2Lh?=
 =?us-ascii?Q?MR1u1vjlzPU0WNUipnLvGKGC+DqSK7hb8iX5IOsbXqR9hMu3bel3MJfPpWf3?=
 =?us-ascii?Q?8GfuKDPHsu5jnRMllh2TPRpZ5JWMm6EMzR4mGfBcXTp9RkIgV4+sbUeNQJs8?=
 =?us-ascii?Q?GGdsefg08YA10RBPj976z4usOwHtJiQAdPHfPz240LZ/8lzLBgMXWdIRX8am?=
 =?us-ascii?Q?y2+n/HBDrp9FA2rhMsNpV77obvEJiautsNAMlc3jMQzspjQmkU7owpYfvKym?=
 =?us-ascii?Q?U9U/mqIyJxj4/9K1QcNGzm7lyldTvrsBhz5noRSeAQDu1+Htfx2qx7lwUw81?=
 =?us-ascii?Q?1XuyWdmR4ofZY+JgTEVbcT+2JlhE+Zm/zbERpiOvyZ2CZAvHaT0Fq5uaHYuU?=
 =?us-ascii?Q?irTL7p67DR5mCG1Ed8rjDmByWaEMucjr8ENGr0duVHi17TL4sLObumIwKZ1d?=
 =?us-ascii?Q?k5SvCs2pIXxn6t9EWBycU/hDdDpJUyz20kM+rxAPypwcZvU0yNg1S/X4eKDe?=
 =?us-ascii?Q?m3JjgL4R1sM1U1uEVdjq1njOqCEDFOyhmZhbqS1y6sfV7+lxKrR63yFGJlp2?=
 =?us-ascii?Q?SdPhKvO4HYnFUxWBflxKZxyjmiKP1dQDxnCtHMfkAVjM9QeZrMwRFmkaqSPV?=
 =?us-ascii?Q?YeaPkk3X/d9Gqa/cUNB6HNf3xY21kE0ZXe7thLFMqMSeHaiIqv9yx9XDupWc?=
 =?us-ascii?Q?KmREc3929vJxv39YWlpzqNV/2ErqXhHrnkSlRrwXHiHnwOX+woR4sLG1/6tB?=
 =?us-ascii?Q?4vuljmU8u+JqUiuD89sY9kkStJu6AiwSPbCGnOYtIEZTG7wJsqMXonIOigNw?=
 =?us-ascii?Q?9dl9o5I/lrtnr6XZRCm/aWFbw9Wso5djWHHunPuMMRKIdci3VhM3NdPApCMc?=
 =?us-ascii?Q?YZHUsq8CJmQwvndHvyolgCbF1VUMAFVgZdsfook/umEFlc77uyHU0PlsdFsP?=
 =?us-ascii?Q?+VS7nM+FWqbMvHIGQpefD0WUvtzStZrRX+MttzKmfwO5rNoBJHrla52hy9iP?=
 =?us-ascii?Q?ttssGYjH1u4Ul6ntv1KSvHEOy3IVosePAYz/s4no2htr291jSG9T/JlTHvhY?=
 =?us-ascii?Q?4lSDK7Us01XgDKq0JqevmYisD9qQ6rrD0ikl1ALcFX33gnOtNllhGCJTWddl?=
 =?us-ascii?Q?T3MTURqSnFMtGlhyeMK6utU2YhQbtvKZoVV/3yQpEcSIb/qRop2Eg53uaIGV?=
 =?us-ascii?Q?cIi8+fS3MMa6kSrPqYdJFLh9dXSpftZsBedEstI7CXUC67nTEGTLsO+/+kfc?=
 =?us-ascii?Q?xWzE9uRv73d95rzLq8AvJykAZK24wUOtV+rt9s+u5h6mCv1AvLfXjoVUN7IQ?=
 =?us-ascii?Q?DY6YJAF2aI03cvsU7bG4X2JXPL47TLFVc08FgHzOamLaUfnOQpeucL/rX11G?=
 =?us-ascii?Q?Ks7yt+F50q61IHW1kuJmIFKVmR1dP2zDzx4BsFbwkoQjAKGvScOO68aUJp6/?=
 =?us-ascii?Q?HDkocuAf5q5OUjyCH8NCYwR2ZAXl790tnEOrki3c8FNbqd5j53UNtksqiFfj?=
 =?us-ascii?Q?ofsWs9EI3ABxeSBzeR/SgNWme4Inp3dPCPCoV2fR2c3u3QrB8VqpEwl/h7NU?=
 =?us-ascii?Q?wgZ8KWY/t2/dEPoBSFafwzaZQhpIB8Tl73q4wHFq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05af2f0-39e9-4543-6dac-08db463424c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:56:37.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJP6+N2uBHwTVmjEFiAgrewL0Bd+C67uQzg6izJLOBge0yvzDmtnc59fJMtuS3W0cj3e3GxiLB1TNAh27VqE5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7500

v10:
 - fix userspace_pm.sh errors reported by CI.
 - fix the bug in mptcp_pm_remove_addrs in patch 1.
 - drop msk->pm.subflow == 1 in mptcp_userspace_pm_delete_local_addr in
   patch 3.
 - exchange the order of "pm_nl_ctl rem" and "pm_nl_ctl dsf" in patch 2
   and 6.
 - update the commit logs.

v9:
 - address Matt's commets in v8.

v8:
 - address Matt's comments.
 - split into two series, pt 2 will send later.

v7:
 - fix userspace_pm.sh errors reported by CI.
 - only remove addrs in mptcp_nl_cmd_remove().

v6:
 - send a RM ADDR from userspace.

v5:
 - fix a memleak error reported by CI.
 - add more delay for userspace pm tests.

v4:
 - add more patches
 - add selftests

v3:
 - update local_addr_used and add_addr_signaled

v2:
 - hold pm locks

Geliang Tang (6):
  mptcp: only send RM_ADDR in nl_cmd_remove
  selftests: mptcp: update userspace pm addr tests
  mptcp: add addr into userspace pm list
  mptcp: export remove_anno_list_by_saddr
  mptcp: add addr into pm anno_list
  selftests: mptcp: update userspace pm subflow tests

 net/mptcp/pm_netlink.c                        | 26 +++++++++--
 net/mptcp/pm_userspace.c                      | 45 ++++++++++++++++++-
 net/mptcp/protocol.h                          |  3 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++-
 4 files changed, 79 insertions(+), 6 deletions(-)

-- 
2.35.3


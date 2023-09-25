Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1211CA9
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPGgTQdF8JdQbuv2RAmrjqry/CvmJz3KQme+MHqZgcwlgVswvIuaFLjznzQH0CCMprigK1G+Cz8CogNoJuHW2ysMGQs5lAlaJk/IMpww/DWEdhVuqnAgci4Rmim45pdyM2Z2vuDjElChde6mzAttHWp1ycNh2URz7uUINENDqxC3U8UNhizVkC6kE34/HbaKAvUCPSjV8quVMj5U3dzTEV2YrClzlv32u0lfnSrNP+mfLtQK8XeIRgNYP19a6goEC1Htdv3xEOQWHpYVRUikkIBuDtYZq6bSDyScHXZ7OSGgp938dbGLzfl9gyQKMugSmApi2mRiSKjY6RoqfiQHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vOSP53lU7hiQk1NVaQtbEgiBzXi3MnlMK2029deCKo=;
 b=NhW+euRaXyrYl5BvFgM3h2PvIei7xuqEruXNvk3duvMg7SDm8gUwvFqXpcMLQerE+22xUJ7UCHKSDJVNgmedlP5bF27CGO0kvgTa/j8pGWZLaRQldQFKH/jT5GUY38y0yz3lIV+9G2b2A2o6992Dt9MfDXRUv1nnPFDfgTiJ/L7wm0FTpLeEWY7kI58jTNOk1aYSqjpRlCiYra7zEmF+xTOeQPC7ZiMNhuAPAGnvu0dP01BpaukcM+E1lx428lfvn4xRNusCtQLpXLtc+jaLOvCFKdBW0YTOXJKmQf6TWnaaqks5p9M2NNUXCR1lg7J98Xhv2X6bMHJVy6LpVekXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vOSP53lU7hiQk1NVaQtbEgiBzXi3MnlMK2029deCKo=;
 b=LRATaZWih/lFTHteyDoAeZ/3kP2c7Gu6RgK97zMqyqQAsDmS9pbKPz7WuqU4FGfVdMWCkbApUnFsfnK7CjbvrlRop2DvKV+6+COlEMk2ne2XPDvRUIxSliWHE3+IrSzKlwI3rwm+F55sbIrc+EFD2ghYIX4y+HDJb0u2S64bpkol/G9x6XZMXHVt2A277HC4ScJ22NnpyLzuxosTgmzd8uzUWX/JVHHsWXxF2EDAT2tg65QOIHIe+rvqM5i2R7vR4PxQO2mNkwi70menqdOwqpd3zKRVSNO5tARTt1Qr1Z0cnT/GivzDAy/3xpg9MhC5VMsSSTZj1b6pvlspml4kKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:41:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:41:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 00/29] userspace pm enhancements
Date: Mon, 25 Sep 2023 16:41:39 +0800
Message-Id: <cover.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6a4dde-602b-4036-d682-08dbbda3296e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FDL0gBRAHwq56EwuiQptG9cUJeXJdTTWJGVAtyhrYpV5iZdS4hJHFFjfkPlmHe4vOogwJZJ5XAOzwfJlQX38HCj4IA72f/NYy3OqdfnaygnimNmcG+kXv/G+RBL4btl62x1qVuGMt6QUfXkIaUdo8ApNvSOCMHqyV9MCDc7miKnLKVry+y6TzBK7SN6+SCIJheeepA5Q4k7PFS5CtnP/uE4ykr4FKWsy3WclF5vvjGwGo/fUnb/Yjw0pF/y7HLOGNADeP8B3e1SwC0goKZQ2GFu6wochoavMV08bmb4/cCZ5AzW6YXy4Gq781tNRQ+5MaapD8mPpI6YRAFGaFijaFXFm+iPjj6Xa/IJ+pxKgtE9xUYZzHDmk4R8OCyPC7qX7ExYbZcm80qf7Vx5Ot4mvSbpjR/M5Lai7n6apmW3tTs1Rr+5+KEUT9Zhjq4QczZ4ESBKwPTAFpaziGXCVS+vYqRZYCn3JbdWUM04R7vRxZY1L/UjbRU638AoZ53Cy5pstFpyLbM5YdCi5FZO1ejgOobukywBU8Gcb0Gs3MDhuRL9JnI+eYEFytFFgXTdv11Wu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39850400004)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(6506007)(6486002)(6666004)(6512007)(107886003)(26005)(2616005)(66946007)(66556008)(66476007)(86362001)(478600001)(38100700002)(83380400001)(2906002)(8936002)(8676002)(4326008)(36756003)(5660300002)(6916009)(316002)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VzzCG7Vrf06GXfX1lqVQcz3RppepSnsKmP/jKkPAcPjJP18gxdiB7ngJagMk?=
 =?us-ascii?Q?lqNzhRZJuGytMFjHzarSN2iICMJHWTJJfpHGqH9bmJWBT6VuqSQhsInlwyde?=
 =?us-ascii?Q?XDOIMg+nXa89tJ64q1ZPmaepXoh8UIqi2wvEfXTFTo2JNWR/z9OQ2kyZ1PGS?=
 =?us-ascii?Q?c9ey0FN7XwpVSov0sfgYV6NbQeoUpCwE8Y+dZQM0tS6s/RAiSWKhG6tWl1eo?=
 =?us-ascii?Q?NHDUfn3+uUkk4X09tSwJlFbutNJUaOiuA4prn9S+D/nGG4qSb/j1ASNl9rd3?=
 =?us-ascii?Q?d0QUuDd6cebGrmczRS72+mDh0TIGsKT8aDeCf9vYd6eKbFcgg+Dc0wMESz12?=
 =?us-ascii?Q?I5a1KiFFuw0ArM45sl+ASYuAL/3I9eHrJ2Lb5OHZwy6kSe4tD390+5HqvPUm?=
 =?us-ascii?Q?vP+nWiuO310mCI0J4uEShBX7P3CEyujMNSHuT4dghTolVCYLpxtcarSHZssD?=
 =?us-ascii?Q?uoNWUnML+DqwRDIJD1hc/FTCL48eFONx1e/FLO762C7VogtTIxU18iuDWYo5?=
 =?us-ascii?Q?cxqyJFKFnAsCEUAuwVb+l7JA1OlGoiGnv38heJk32xkwIp85SXooxaBvciAn?=
 =?us-ascii?Q?+GINTLYpGAQqDAuIzF20Z2DuHQGT6PjRAI4O2BSP3r1vwqGPLnTodlzgsfFU?=
 =?us-ascii?Q?GRtDlwJ696giiTzmd7Clynic2HT4JknkDFnOusSm6r9gd37ANqRJ4w/Kcv1N?=
 =?us-ascii?Q?NkgpyjeSy42Dc8U2QuNtoCAlzPqHf2kihFfChw22lKwp+LoJvSkdn2EBsHhP?=
 =?us-ascii?Q?T/jpflbasFNXjaSBUKAaAy3Hoxai2nIssDnMirsm4aU3V+iFAkXqwX8xwSzw?=
 =?us-ascii?Q?7ATQCOOKZMFXI7FFOKNNu+eT3h94qqki9F8egXgEQ84Z2IgLTbLbr9ffsoQ+?=
 =?us-ascii?Q?0iZkg/TjUeKm5rZz9IPX8yv8X9DE2w0R8Z+HfFc13cWSSI3RpRDiccxp2JRy?=
 =?us-ascii?Q?o7pMmNuoUXWBuu4LIsOgTKDzVLvNGNxQ3SDdwiVB6M+C0mLM+PIm+1WMJ/wU?=
 =?us-ascii?Q?BsHUQnR2JUnOYzoo1TvzzcYjYOZn9c5vSvcd50szoxymFHpwJOI+LjOkByPh?=
 =?us-ascii?Q?gFjLu7HlbE6WKEhB3TQOrmPVYSvcDNesyamoxNfXPT09D8vjbbHf0jgDI3Re?=
 =?us-ascii?Q?bR9FEGJBblVy2m7pEtsUsKt+Eoi4NwF1aRPXidRHqd5SOk74RS6J4JGSXUk0?=
 =?us-ascii?Q?PjdTYYsO1jgJl8ZwWOzQ+56T3h0eA+BLIjodHN5S6+AGek0wgOqbPxMB44G5?=
 =?us-ascii?Q?bLRv1crpQBOupwc840MdErS6fKp4kIMItM9JHRg4/77XVYUUeUBrSndkj3fZ?=
 =?us-ascii?Q?VRJpnTH8xksj1ca6xFQUSVQqSTRMCsCbLz2lbW9Ga9r6iDRq5Hx2QJePrETy?=
 =?us-ascii?Q?zjSnXgcqO3q5hKMclxFGnUVajYdZqzwEav8CWU7Pns+G08zv/avnKJnFY3Pm?=
 =?us-ascii?Q?OsSYpGYq4cJNsJVx4Jo13k5gKzbUDvjSfBv5+dgydig9qrTlfNcbsmDobBuu?=
 =?us-ascii?Q?h9RBlzHBiYML+les4rRvIIOpPe67DbKQnua32Ja3EbY0E3jSK9+A8+3j6hVA?=
 =?us-ascii?Q?6fbAkhD2bd/nVDSZ/Xxz76nCSIbMyEOL7qZpGfy5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6a4dde-602b-4036-d682-08dbbda3296e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:41:07.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LrqTUzC5k8M2XMbHRO2+uztv292RDk0GK2ChBWPwhtL1jb+QRF+jgyL/SkE8NbxPAdiCIC954Jb1XH+laZR/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

v3:
 - drop patch 4 in v2
 - invert patch 10 and 11 in v2
 - rebased

1-7: some small cleanups, v3
8-9: address #428, add mptcpi_subflows_total
10-16: address #379, #391, userspace pm remove id 0 subflow & address, v11
17-19: address #403, add refcont for address entry
20: add userspace fullmesh tests
21-29: seltests cleanups

Geliang Tang (29):
  mptcp: drop useless ssk in pm_subflow_check_next
  mptcp: use mptcp_check_fallback helper
  mptcp: use mptcp_get_ext helper
  mptcp: move sk assignment statement ahead
  mptcp: define more local variables sk
  selftests: mptcp: sockopt: drop mptcp_connect var
  selftests: mptcp: display simult in extra_msg
  mptcp: add mptcpi_subflows_total counter
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: add chk_subflows_total helper
  selftests: mptcp: update userspace pm test helpers
  selftests: mptcp: userspace pm remove id 0 subflow
  mptcp: userspace pm allow creating id 0 subflow
  selftests: mptcp: userspace pm create id 0 subflow
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address
  mptcp: add userspace_pm_get_entry helper
  mptcp: add userspace pm addr entry refcount
  mptcp: add netlink pm addr entry refcount
  selftests: mptcp: add userspace pm fullmesh tests
  selftests: mptcp: add mptcp_lib_kill_wait
  selftests: mptcp: add mptcp_lib_evts_*
  selftests: mptcp: userspace: print colored results
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_is_v6
  selftests: mptcp: add mptcp_lib_get_counter
  selftests: mptcp: add mptcp_lib_make_file
  selftests: mptcp: add mptcp_lib_check_transfer
  selftests: mptcp: add mptcp_lib_wait_local_port_listen

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm.c                                |   2 +-
 net/mptcp/pm_netlink.c                        |  25 +-
 net/mptcp/pm_userspace.c                      | 139 ++++--
 net/mptcp/protocol.c                          |   6 +-
 net/mptcp/protocol.h                          |  14 +-
 net/mptcp/sockopt.c                           |   4 +-
 tools/testing/selftests/net/mptcp/diag.sh     |  23 +-
 .../selftests/net/mptcp/mptcp_connect.sh      | 108 +---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 460 +++++++++---------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 188 +++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  55 +--
 .../selftests/net/mptcp/simult_flows.sh       |  19 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 199 +++-----
 14 files changed, 661 insertions(+), 582 deletions(-)

-- 
2.35.3


Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ECF813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5rmmI3gVEKlYXG0o7DXcVB3akUYmRSBx4SDqflz+rBRSs225BNuEIKcnvDmN/BI/a/UoMLLzW4N2BaVswupRoPn+LKLRBGDGTlcuVLismMo0V4sAuUF/r4kdpTiuxa7FKtbVpYaI/OVDFlAt1SYS+qXbtmhAnfbLIN69gvf6NHD6KrRk3LprfwPokzSoyDssw2SovuCL5o+FsciZTjD4DfGoEdGZgCIngNZwvA1At635FERIQMaaavqxdewGLv2DCfDJI4YdOm7FQMQN4dh0cQN1b7y46cTENDLHHkrDQpjN1IUzA2eDHmaU1ArYLLvcL2dGDR4q9Kd/tEVvldHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZQN1EPMfD346J5V+xqpfaDJ2QiUXQAKXkZK1B0hYrk=;
 b=R+M+24ZLA2jBokBh/VZ9kEHAl6dQhtYabtbngchxftHvgJ64aCakbLbSz0F0r/kfjmCw9KUQW8dkiT7av38ctEimj7+ZrDEGfgdZO8hKio/jSKY/gHvMqNKZ7M8k516SoOlSlLd38eXw/MYW37KKxN7qyx3/uj2Wqjk51Ue8NawYeXm+jaAnVEP42NVBjd1+9BRG++W78DViRLftyf7f23y5nPR80NJAT9tXuRdw4x4R2mBeY2HdIGw/mI8hj05GOxsi4GfztiU8H6rRSi+mUxt1tXyCiaLSvk8w4ZbP1ZMuyw8ftUuqi5+a63Ea6dt2M2AiFPDFdqypm/UWt39kvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZQN1EPMfD346J5V+xqpfaDJ2QiUXQAKXkZK1B0hYrk=;
 b=auoc275iyAwvRtx8PuPzwPm8MMV7M5jGrwfu+LelAXnE86Yt07Jf9cK9kL6e0TzTeyEmsFZ0jNE/0oAmxtt5SnjQ2Hoe3+JeMKfJzQYLqr/5HAAbQ+MoqfUs/kEwPPYM7GMVnY2cLuwTjW3rS7iJvbP6WeV3WVsNPoNRiXqvPdwVtHvMhEeUeHcVzX3qB27egUTg9sWAy+L3C88Er9CRM5/AP1JQXSK/BtzmLQf7ylk0kOJbFazfGCvMFSZqVjOovuS7kNDsyTIagoUH1kdRAYWsugacrl5BQoLRFYT5rA8E7oZc26eMcWPDEUk7fzVj1YaeGCkOlWshav+ml9qlTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8330.eurprd04.prod.outlook.com (2603:10a6:10:241::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:45:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:45:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 00/18] save sched_data at mptcp_sock
Date: Tue,  6 Jun 2023 14:44:59 +0800
Message-Id: <cover.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d0ae05-2925-4f3f-2c8d-08db66599286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QHPnR+MXjlP6Znu3hznO+Rs/r/YMUZRqJn8BCz5ULZ05P3lyRDeF4UUOD70fhYlTAMT94wR8DVlbNmdzkTv463O5aTm+Dj9oQzYXj22L2Nj51pidHszgcU6131asXU45xi9JLEREV7kAlEOQN+tM73YKrWbJSSzgPuaCUHDYBtHwKsvZrzdgaT/u6W9z0QDI/twp7FDVpCOgjH9+QFgPCYO4w5oXby8GzdPvBL+UVxaiX77iMfvLJ4XsT2hJv6tcHJYeGGK0wcx80x/UMU9mol7LLiV7cGdjUDcUlqika+3MNDdr4ZMOdJLyf9QcI8YxzPSkc+AgAiKCLScb5W7ytjpbSU3rtDr2WDm3eWNyAA+HV4FabQqGT4VeBf/FaUMrZU+HsWrzNJZHDP30+db7f6+zqMFOs/D2uQ0W/EOTPXi6q/NFsyUxMzlGKlj8gwY1NT35UktKbfLeUSkdeW9yBiT17bydfKN7aTa8bf/9+JyYSoVZTkSXe3yx5CerGBsVo19R7WmnneOnzQHxp2dJbcpnz742xoGHHztyug/8zsIFJ0urAoJFaFI3VKue2z+cv1jOgVfh96Z0AZ35E2zdhg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(478600001)(6916009)(38100700002)(66946007)(4326008)(36756003)(66476007)(66556008)(8936002)(8676002)(44832011)(5660300002)(86362001)(2906002)(41300700001)(316002)(83380400001)(2616005)(966005)(26005)(6512007)(6506007)(107886003)(186003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3w9PuqOJeKv4nhCQpWHRvmJ052Z8T3KQCB2wkAIA+QSPc4M8ctiY5If+0Jfg?=
 =?us-ascii?Q?CbffWWn59Dh+r31EVc8GUHXwbthSyAYzTxfqzPKJbRgpl6RAApDqx8SkeJuZ?=
 =?us-ascii?Q?Qcs9bq7znQ7ft5kS6fS7TIzR6kJbTmlKE22J+PSkusWMMg6xMNOMy+5CRx8b?=
 =?us-ascii?Q?QPSe8bzm4FU5AixEyLgovO7/UAN2MD8Md4fmIge1ins5yalE4WK9UjX6psRO?=
 =?us-ascii?Q?m7iO1mgJUj3GJRupowbCVaj5jszaOo+JKs+QQgHXXsJHVbGz3jbgSnfYnQL9?=
 =?us-ascii?Q?RhLXZvYLM+awLRuNkKKFvIiIi28p10BeuhLqC3/SErQ5JIdmXN9peWyQ2mnb?=
 =?us-ascii?Q?C8lwkBecXA8p2LxknI4Db68L80K3qhJSGtkdRsz+ak7Hf4ZrnG10DGfF8b1D?=
 =?us-ascii?Q?D9xTL5UxUoicCMzIS3qq8AgyOw89Fb8UqDHzRypO+q0YlVS/ij096XSnSECJ?=
 =?us-ascii?Q?asWZz4wdYoB4zT35MUTIBhNjT4hmHVdNFnwRUd66v0lWscFLpeJrAB2b54J/?=
 =?us-ascii?Q?P8aOOyG0na+G1HZIdU0GTB/+SSbd7GDJVkNltKH9fKsu4EBPpKHf74GBLVcx?=
 =?us-ascii?Q?vYfahT+vHBJtISxqL3Y7mcOWDmybpykz70tkNT732Wu4y57kjIGEsSFGHUJd?=
 =?us-ascii?Q?TZeOqHJ2gpUF3DtDVA2HyNbySLIXqyDo7y0w/o2slZrrG3lbixQNj9AnEtB6?=
 =?us-ascii?Q?948RUOs/g5xz3N76IQYidjEJ4PDg5j0JUclEk1I2cL2I1nZGl7bc8Y45KYIs?=
 =?us-ascii?Q?8Z7X7CNRWcgSt9w/ra3ZKtzpH1nluV7qyT9DgGZ0olsWwM1bZdaiI9QBCWD3?=
 =?us-ascii?Q?ezO+BE96WthaaJn96Ol1ZFf/b+I//qYzCSXnhwW5XA7VX53rTsKX6BOurgiy?=
 =?us-ascii?Q?zjrl7ElzHDKATBjYOpXS8ckwdVCaKkDScEc+4SU0Canlp6fSxyAxgRBTL1Rz?=
 =?us-ascii?Q?ps+qsLoYOTKqpPOE0zlgt1ZP/YZjOWweMz5NfLDNn0ZWo295gYbsG5PROuay?=
 =?us-ascii?Q?4AzQzUoy0K8jZIIFRoq3/d65o2FhZooXeED1OJlOlNUwqWLydLsujYnPKqXb?=
 =?us-ascii?Q?xRJ+RUmgReGZ2Oh2OwV97yAfQ0PMi8+J1Nkl4rM3mIjIbqwz5Awc6LT9TDiP?=
 =?us-ascii?Q?Y0RVGFoU7kUplwAgHWf0jaNZooZj1KcX4Ogj+4Se6cZ3baAfpEKrRgOmsPQv?=
 =?us-ascii?Q?C6FFDxjDANBZrNIMcwgXPpNcjZh1v/WnQJJYwYDC5EXtIQBQaeKV+sbTTy3e?=
 =?us-ascii?Q?v4JTNTVm92RfD9/mslOEy6rCFVIMVd4QTLzIt4gcKiV8kTczrPWQYzeREWln?=
 =?us-ascii?Q?yipenTr4nQhMMOjmMAZ8ORED17CCAEIUow8Hsc4oNRZg0cK1GvXPlip55wXQ?=
 =?us-ascii?Q?zNJ8Jnhog9cgjWulW+p8BHPCGKBrpd/Y9mdkO2KAZfq7gCYBQwOI3CFzGUgG?=
 =?us-ascii?Q?n+lo2nR3tigjlJopnoGpFXTg+u5najtGiKhiY0GX4Y/FktxR+eFIgchAZbDQ?=
 =?us-ascii?Q?4L+4ssdR5NGrz0QYfNv22Sb9DLsm/nbO9O9/LzqZnSNbkcjx/vuaCSv3H5N3?=
 =?us-ascii?Q?+aZ2eqjxUb9NkWIwg+XZdxmMMONFJfAQEGi1TGR8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d0ae05-2925-4f3f-2c8d-08db66599286
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:45:10.2735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imBTsK0BLdn9uxtd0HU2uKpmLh7ZUeW5tMl21yWyUADLnOWslRcudBqv0P1Ijte6pdjRyNQY5ELJKzHg255Szg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8330

v5:
 - 1-9: save sched_data at mptcp_sock, for issues #342
 - 10-15: add bpf_burst scheduler
 - 16-18: add bpf_stale scheduler, for issues #349

v4:
 - drop "mptcp: add three helpers for bpf_burst", implement the helpers
   in the bpf context directly.

v3:
 - address Florian's comments in v2.
 - split into three more patches.

v2:
 - fix this error reported by CI:
KASAN: slab-use-after-free in __mptcp_close_ssk (net/mptcp/protocol.c:2461)
 - add bpf burst scheduler.

This patchset adds sched_data pointer into mptcp_sock to to save some
data at MPTCP and subflows levels.

With these changes, the old patch "mptcp: register default scheduler" in
[1] now works.

https://patchwork.kernel.org/project/mptcp/cover/cover.1665753926.git.geliang.tang@suse.com/ [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/342
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Geliang Tang (18):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add scheduler wrappers"
  mptcp: add last_snd in sched_data
  mptcp: add snd_burst in sched_data
  mptcp: register default scheduler
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  mptcp: rename __mptcp_set_timeout
  mptcp: add two wrappers needed by bpf_burst
  bpf: Add bpf_burst write accesses
  bpf: Export more bpf_burst related functions
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test
  bpf: Add subflow flags write access
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test

 include/net/mptcp.h                           |   4 +-
 net/mptcp/bpf.c                               |  55 ++++-
 net/mptcp/protocol.c                          |  43 ++--
 net/mptcp/protocol.h                          |  14 +-
 net/mptcp/sched.c                             |  67 +++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  76 +++++++
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 213 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   4 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     |  59 +++++
 10 files changed, 495 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3


Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D91171AF
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WqQCj/cC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeMjJqHQy8FCmBCMHO2263fA12rzVsmOoOVIXyNCyBJNZAkP2Y04FvVAM4ynw3EFy3RrnEW/DIPS9Qu43CS6LkfsPSwsdUXoS0HxCJJFvXaoi9U5vCI6lIlFqtl6eddrEvv2kVNf4mYTeneYOG0XIxu1KhJBajVSWgwzmUe2jNA/nTQDrmA96WsNNO++qd9liaSn37vlv71LmF5AxA2Rd5ToCo/8DHwgVQRwzYG8vuEn52t5zHLra8MPj6rMj2BqBssTbE/5PTDxp4NTD1pbVV8LTmaHZrjaqSk0Z7mf/lQuRIscbi3rrO+ZN5pd5xgRtqXucYkl8M7re9+gM/AebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba4LjzuL1zo3hh3GlkmVASHfJIfOm+SDyDrlVAhkbBA=;
 b=cwqygJJjSSSwOAKKffJ1Yz+t0omQfX8XWX7UBmmLXmc8f7EH/phjj0NY4DPJ82AoqyWVWUsDcsR+TU0Bp1SknAbzyuWogJ1o6J3OLjJFhJE8iUs5VFNUhSDssBKEiAf7jWxeDCIMpvCW5+Ongd5O7FqtUEw7me/JDz8jBOQL6LlkZM9uCaxGwpooDca2eWInB86RZ5xCHcr7eLqvrs5A3prNqxVXmBAQ5VXOB8X7/MtfW0ocGBSGgU+0cN4GM3ucC66byR68I0Ho8dGJCdlOn33Otf9zvRAc4D6KHkY7f84LtNxySkYF9B2Cw6LDArkBKs+/bWn967bsMYy8wNPbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba4LjzuL1zo3hh3GlkmVASHfJIfOm+SDyDrlVAhkbBA=;
 b=WqQCj/cCXB74ZIqn/uS3geivfUXXKsw5cpSTPsNyu4EAt1OFzUvr522g/WpWGrCmWOTDnCNZc+vkRhHK+kVK7j6MgQFtfnAZJ24wseP4vHamm9dE6j7qoXpSN3DgMAAJm7ugcQlKqqe3rMbKO8dnippIYAo7gZ2JNEIJ3OL4x+qLmBLjldlu/MUnYVxnlZz7yqJqSpEuCV3OHmAW0T+oupK63et46jj3rInQ6sYSy3Y8dIMiDe8FbBOor9o5rN3v+JCed7qumEO79Mo4dmqVsnnKr0H/6IJam0Ml5M3vmEQ+iHJIIxsWJjIhP8UqDZE3jxq1wqxQJu4LdzDT5T8T7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:53:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:53:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 00/28] userspace pm enhancements
Date: Tue, 21 Nov 2023 17:52:23 +0800
Message-Id: <cover.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf2b1ac-665a-4b9c-e9bd-08dbea77b51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2AYa7zUvOyVx+KixC0terlx2h3hoNbqHgIIC4qDEevyIFMHQRR7cZ+uiGoY0kq/CVg1b/M5BcdGCzqR6Q1QOb9u/TsOD5DOwp8Rki2x1wOlN4V7u9+Kdn6opu2Cryz/gLwrfwjhx0emixlCh+iIp7Hvd6qLAzaQUbm09aJGMZK0GWKsq4e7t1FRCYi+mz9sq47V9pO6SwMcv9ZTKhf/JaYcaSatQiYI90x+yJS3w7X2yBR7pNSAsQudjaYxyn4fp23LAjDc8lP99vcHSJhbuIPsmMFPVldBfJOrke18cKYBLJyGcMlryAm9JGCA+0oZ0kBWK9h+kYejMLPcUCxE8i/tVXFQZ0T0pWY8DnOmPVh1fZoy3SZuBTc5QnrN/gunbkicLM1kgkonEEaDmj+CqBO2fTQl5sJ/ZtKu1fQNRxakkqWgMmb0xoG0SWjKvSF7EOz64V4tVtGfMd9FuwQkWXFXUlDx00yJ9yUmeCJIapv8lFinnVLjyE4WkoyErNdOHnCCV1oqkouk0uPi39UIggkVJ5uxdy8vVe0WveLRm6Sv6kSUoX1v/lc1NX3sqBodxgQ5s3qvRdv1mq9VLW+/wTar+fPXpZNqJDxmqmVSKLsUX428aYFUsOomxLOzwfbXX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(478600001)(6506007)(26005)(6486002)(6512007)(6666004)(316002)(66476007)(66556008)(66946007)(6916009)(2616005)(107886003)(8936002)(38100700002)(4326008)(8676002)(2906002)(44832011)(5660300002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fO1LT2zrvz98tjClkGKpM1f5pQ7ULXvNgGpa3RCqhJy4Ixrgg9GWzDbnP+RD?=
 =?us-ascii?Q?HNq2qbbyI+3ziOa3Eg6Hqdoec3VPjUKhzI4SmMd7xha/yUgFPtrzZRiMwZLJ?=
 =?us-ascii?Q?xGCGJxPlDqBlAYHZX3sT0lvE4lNs/ivewxLAkAV3k0EVzI41hJ3eYWxfrX6k?=
 =?us-ascii?Q?agdaWAPPCrOIipWhV0MJVodZ4R4bcgGlZSmIpylKfGauMXgRpElR6FkOT8OX?=
 =?us-ascii?Q?nZFHaEiK3rjTaOCXrHzWSwVGR1tbCNUR5T2BF5GVysZOQxEAoO8aZHMiyRpz?=
 =?us-ascii?Q?EMySafbDz4ygOLystSlnY5D05F+wUpzOtJwEYsO4qtBbUWB7YYsULVdUavPc?=
 =?us-ascii?Q?MZDVFaT3E3sWB4oWfMKd2cCQ5aL2oc1Shaixc7e5nqP7L2Ao7yXV1vAacT0y?=
 =?us-ascii?Q?kBjujNTs1zLjg+FRmeJtjz99UmpjzoyWkhbkh1IJaU3kYKTDBXW494s7XgIP?=
 =?us-ascii?Q?OPdJ3G3AvgTJdNpuLK6abhhVR14/+rd4FAJrMspeyIImLCms0NQnPgeM9q4j?=
 =?us-ascii?Q?fhYPNZCPG5ADJmpeAXmtRKNheWSE86w4tncIYxIC4lJlZB6F1K7lIuxvEBr8?=
 =?us-ascii?Q?mLxj6NZYqWKfl8d2MCD3vTwhzvk9803pQIG9rl+HkQEqNIfqoglVu6NjlvGg?=
 =?us-ascii?Q?8hHMqjMfQipZeap4UlSLE+M+Ch5KGQEh0dcvCqRnaK4t+VEIP8hF4rDL893z?=
 =?us-ascii?Q?zy9rGaV+m1PMfzJmckGSYbsSeqx2dl2OqTAssCbJjA0Brw925M6qld8xfjFF?=
 =?us-ascii?Q?gimZVLHXKpxzNM8RoJ2+LZS0UhAIibkSqzV2wh/HybCsrKD8ikONBkYeJwJE?=
 =?us-ascii?Q?0MwSD0h9gt2oEFs7QugZg615WVFGVXP1CNwgUnKQsPZ0eBZx32qcLNPoXfHq?=
 =?us-ascii?Q?MDJtV2sr0P0+NKcv6G59DeS+QBm93Ly0gRASPYYZo5GJHzPL0SaEsL4YXH8m?=
 =?us-ascii?Q?yzVOZCJNtaq7sl+IvzSLBJV2kDn2brvhuNkNiae66PrGVtCWFRwP84c8WiJg?=
 =?us-ascii?Q?wbe4nTfnuRj6qfuPRF/Sl/KROHjW/vyaD46FLq7sew/62gcPx5wyzZY86z+s?=
 =?us-ascii?Q?oo680GO5fs201iVMA9WGItznXFX9hYO94sFiSSalpnZ0fcgOH7yDQixJJQs6?=
 =?us-ascii?Q?S0YEJp5bjtV6PM4g0MBm6Z/RQempaOkuJ3B88AYfY0cp580dMoHfy7I5duXQ?=
 =?us-ascii?Q?EroSvs7BWuFzfNgo4Zg1QLIjW2TWtut2Vc6zQhYRpnq11fdN89OfPXNE/YL6?=
 =?us-ascii?Q?YzQf58h7506vNJBdlkRdUT0jUybtZCrX6TAf4RfMBhPctSkFalBJuPPlcAQk?=
 =?us-ascii?Q?ZuZa/vTYDk/YGC4Dcz0Fka9GHDnVPWG4/97MGFecCJalx01xa62AnsB8PKEU?=
 =?us-ascii?Q?7hey2WD+vJ3ET3Ml0UO/hgkmOP8POVF+kolSIDeAckl2/0z/IhlIBZvcv53s?=
 =?us-ascii?Q?6e/ocSPja78QCuk1787Ge71GerJNpB1B9kl7jY+iYmZES5SmeSZFdH4x3Xt7?=
 =?us-ascii?Q?rWo4vMHmYdPkpeEvrhOpAcNAq1sNS9+sYrMR7PKjOiH461z0CWY4kdxMq1SE?=
 =?us-ascii?Q?01GwQh6Socm+bDwuKqmrHe/3RnZOVBP7FUKo/yhF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf2b1ac-665a-4b9c-e9bd-08dbea77b51e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:53:26.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx7ebs8dxoq6knf5n8B1id+X4QeghkFbGnXGX7Ed084JJEjTKfgm2E2eaUzm001xSzbuWQT33zlMQjFAp2PuhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387

v12:
 - add pm_remove_subflows, instead of changing
   pm_remove_addrs_and_subflows.

 - Now this series includes four parts:

Part 1: dump for userspace pm (patches 1-11)
Part 2: fixes for creating id 0 subflow (patches 12-15)
Part 3: flush for userspace pm (patches 16-21)
Part 4: address entry refcount for userspace pm (patches 22-28)

v11:
 - add a patch "mptcp: userspace pm send RM_ADDR for conn_list addr" to
   fix selftests failures reported by CI.

v10:

 - add "fixes for creating id 0 subflow" part.

v9:
 - Fix typos reported by CI.
 - Squash two patches
        "selftests: mptcp: pm_netlink: print colored output"
        "selftests: mptcp: add mptcp_lib_check helper"
   into one:
        "selftests: mptcp: add mptcp_lib_check helper"

v8:
 - add mptcp_lib_check helper

v7:
 - merge 'Squash to "mptcp: add use_id parameter for addresses_equal
   v6"', fix packetdrill_add_addr error.
 - fix memleak error in "mptcp: add netlink pm addr entry refcount".
 - split "selftests: mptcp: flush and dump userspace addrs list" into
   two patches.

v6:
 - fix kmemleak errors reported by CI.
 - drop a patch "mptcp: add netlink pm addr entry refcount".

v5:
- Put the two series "add flush and dump for userspace" and
 "add refcount for address entry" together for better CI testing.

Patches 1-12: add flush and dump for userspace

v4:
 - fix the deadlock issue in v3 reported by CI.

v3:
 - fix warnings reported by CI.
 - get id_bitmap using pm_nl_get_pernet_from_msk.

v2:
 - add two patches: "mptcp: check userspace pm subflow flag"
                    "selftests: mptcp: add userspace pm subflow flag"

This series adds flush and dump commands support for userspace pm.

Patches 13-21: add refcount for address entry

v4:
 - move two patches here from "add flush and dump for userspace pm":
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match

v3:
 - add four selftests patches:
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_init_ns

v2:
 - rebased with "add flush and dump for userspace pm" series.

Add refcount for address entry.

Geliang Tang (28):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: drop lookup_by_id parameter in lookup_addr
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add mptcp_lib_cleanup
  selftests: mptcp: add mptcp_lib_check helper
  selftests: mptcp: dump userspace addrs list
  mptcp: set set_id flag when parsing addr
  mptcp: use set_id flag when appending addr
  mptcp: check addrs list in userspace_pm_get_local_id
  selftests: mptcp: dump after creating id 0 subflow
  mptcp: make pm_remove_addrs_and_subflows static
  mptcp: add a prefix for free_local_addr_list
  mptcp: add mptcp_pm_remove_subflows helper
  mptcp: rm addrs and subflows before free local list
  mptcp: flush userspace pm addrs list
  selftests: mptcp: flush userspace addrs list
  mptcp: add use_id parameter for addresses_equal
  mptcp: add check_id for lookup_anno_list_by_saddr
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match
  mptcp: dup an entry when removing it
  mptcp: add userspace pm addr entry refcount
  selftests: mptcp: rm userspace addr with random order

 net/mptcp/pm.c                                |  16 +-
 net/mptcp/pm_netlink.c                        | 187 ++++++++--------
 net/mptcp/pm_userspace.c                      | 205 +++++++++++++-----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  44 +++-
 net/mptcp/sockopt.c                           |   9 +-
 tools/testing/selftests/net/mptcp/diag.sh     |   1 +
 .../selftests/net/mptcp/mptcp_connect.sh      |   1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  68 +++++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  32 +++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   1 +
 .../testing/selftests/net/mptcp/pm_netlink.sh |  30 +--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 .../selftests/net/mptcp/simult_flows.sh       |   1 +
 .../selftests/net/mptcp/userspace_pm.sh       |   1 +
 15 files changed, 404 insertions(+), 202 deletions(-)

-- 
2.35.3


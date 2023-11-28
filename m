Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710755ABBC
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LpW3RRkS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cea3WG9FJ3QOYtWaZAtTOCKMyogC9seRJRYztExehJR7K3C83GYmm4/SkvZoCqqErh8c+KZS8Xi5CIfrvZfRi4gvbcWbvr6KVCZtaMqSAWw3hEitm7oJbTSp3jAeSiH2wT7CnW0mTHcAYjVlqxB6P/+COoVlJn5Dywl2rADL/JV7YTV2PR8VuQeYOKCA6GBRgyNccYPBCJTpqU24K5DwmqgCkFmDQzSQyghY0zXgKylZOE0x7U1/oS/PD2SVw4x0LPWn3VvIL2Obr1tV+jJ1Ez6TXM00Taaxm1oA66wJ+m/MmV0PeOgSlooSQCqIF0p+N9wp9whxZn1oilaTg7Z/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r73iYNdlQa2QmgrrCI6MlsIiKbSPj9RqVHzrDY81rY=;
 b=J7OyIiRh8FMV42LmzjrIbiK5KmOSS70R0Fjz0WIUmO2GFbUq2mOPQADp8EGU9haOG/LUzINpnb8xAEiL4oaSt7RNryg2uX2wIsG6N4imVLttLW+BGNBXpKWnegrdb9WZAWYsO7Jw4Eo2FeGpXohxAYvcNuNLhotlknZxtULo6xpEFcBpdX4m4teVtqaFWHv0k+D/UKgznDriCrbJISIyAoFaccN9YjWkU0lFnYCSC6OCUSkeAvsI0GXeieFq6FqaF+edHNb2lTR5EfVqexPt4I8WzIPZYL0DYUxTbu740fW9gev92X9Knd0tk/HmsFJjCaAXUDkTGBHkEMHlGbskEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r73iYNdlQa2QmgrrCI6MlsIiKbSPj9RqVHzrDY81rY=;
 b=LpW3RRkS/oTF/ySBZ6KY77Q5+/OzppBZzDmFEmPxtCKDdvNkrSnqIApMmPFz9dwg5ut1PLabvHOzq+uDLgOtfi6+C1vYXgh8nck+T82aiIhDcqbxRPSua2BQsNS6f+w5PRU+SXSHHnm9Z89JBi29egavDVmij+A1vaFNzEHQ9Hf6qykVuZA3zRZbbFrKIHoq0A029Pefy8TlBm6KBeL+9paSyFIwV9NnjuPTo4lFJBupemHFNyk/35ydic2WVZyRJUOphCRM+qr7JNDr/UoR6Cj7o6rEiAcPOn6s6SlHpvO/TC5nl/9LBKkbkEMudZH8faq0FxFJvB5XCerXWz8fpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:21:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:21:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 00/32] userspace pm enhancements
Date: Tue, 28 Nov 2023 22:21:53 +0800
Message-Id: <cover.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3b52c8-8c2b-4c1d-85a0-08dbf01d5f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TBbBWnUl3JzJSp7DqZqGWBNMeWPufjzIAZGRPD2fh9k5ceLQ8XZHZ3HiLGAZt5x+bdj2rqGXa/4LfBUNeiwbFtwiSy47ccdgaYlZHDtDR8ShW4TCC04ajzJozTfEzM5XEWATiuG0RcU9UVQdIQRnSlhLe6LGsofjZ5bLDEeSC8TwDZiJ77SD7dSOBtNqAY9r2rwz3/xcyaGqmYBhb7KD/SuZ0mhN3XOHM3IeHnFm6JBbx+uCCSzSfi1xrfd8wNt7/fxBz8y9KjOEXbC5uMB+O4v2rlHJvrfcKyZO8jCDHYTM+aV8M/aZf4inYl3z8jKfZMYd8oLG8juks/mDosmpPVXZMxm1GaDxi1MFZZGPAfbh7t8RZPI5X9pXcS3fgcs/bex+UBS0W/t2Z6avLKXEdNCWW+bf1unjwjxy0HIytMDhsw6qzmvBD35SKAIhWqIpnZR6KMZqt1bA/gVweI496WDzCaplY4Qg8PxSoHdYh5SEJfKq0j94O6LydvjKdcbN2od6MTCUqlvUAKjIQjY/SkLp1kvg2KdPH9zJBWsdFs4rck5/v3L11mPHlxQ6XTK1R4FyGLhks9JlVECdsJ1RL2qJCwbC8oViSwDoDrcvJHZQdJeZWv58VCQs0cfUMjJE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6512007)(83380400001)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qFo6+H84L+UM4MFjVVZYAGM/edIy+HKAJBEbKXp6xbQHWnL6GcIzNfGX/dVg?=
 =?us-ascii?Q?iCXifKi5Q5rJWDG7iQJPdVC2P8ordnEnnA6aWzD7SZvRXuGJ6aa2ngIytiU0?=
 =?us-ascii?Q?BdE+a/tIZL19rYl7x9HhbrBS7kkZ4qQejqmw66lkFcTMBfdrg7l4cHybJug6?=
 =?us-ascii?Q?ic85F4wFOwfGFzWYoIyqPIptdsp2uEul1ATGmbZ7mGIEIKJ+PnYHe8P30pvR?=
 =?us-ascii?Q?mxWPR3VTOY7OJRAPc8ERO9Dnv9ldHXr1gu80R7jvRFxxJ2+NGLnx/DWDzuQJ?=
 =?us-ascii?Q?ZgvKro6qkcNkQyKcGWO78z0ydfX0LZlssZoQKmRFifam5OIQWzW/bGt/WOLF?=
 =?us-ascii?Q?v3VF11nmLXtnUz5dCFc/wm7raS8SeuSXRBJZ7AinvD4MgYyzobelXlSoqXs/?=
 =?us-ascii?Q?ulq+1+38bmm4DQadkwytu61PzKaXb7Xrfink6+c/8Z2q61ByDEQK1xYvuVJ5?=
 =?us-ascii?Q?zTq4XYRCFF3/0kl1ZnIimofJ6mfiL8p/Mo6T9vezjTJEmnJ7XL8qYX+dTQCP?=
 =?us-ascii?Q?JZvFZpd4BKICDKrs++0hXexhDYnKZX4qY22Exc5wMyl9apsFejCLYNuLt3dS?=
 =?us-ascii?Q?EV6yycKF/1qLdTJdTp9bpR3JzlJkNh2tqM06FkPnpsS15i2KOaxQlCaVg8bc?=
 =?us-ascii?Q?iGJHBBpf4i5Zda7XUiA8olZCOyezYdXj8frBRq08DxSG6dkwkLsY7SRAmxhP?=
 =?us-ascii?Q?FLoVlg0qS+fsbFO1SKyhcMnEZVw4eBaqN5XKtTjj1V7cVy9OF3/vWhUHVL+T?=
 =?us-ascii?Q?pM+R1gWrCymYt2tFGsp7hyPtLHYevktmCGM2w7yASVpjPUIOSnMeS05ZQgZz?=
 =?us-ascii?Q?6mYNXbQp2gLnVbRjsDAz0ZiN22iGXtxDRDt2sSSWLSOtDEXUM71SZldKC5HN?=
 =?us-ascii?Q?bWp+dtXRN8Hx4SBBFgtFa2EQPJxR2jFRMHnYM9M5i21N31ADnkihBO7gs7yb?=
 =?us-ascii?Q?+2tbzOjAHOmDY9LieLj60f8rmONBSXPTvAP3vB1SQ2AIsDZ1GSQI5Xm1DgDQ?=
 =?us-ascii?Q?2uhNyhgnuz8rdtfWudhOj1yhD18rxl1lZjoDaiktFxjTr9Ou9pL6Zh4mxNQ7?=
 =?us-ascii?Q?6O+/B0pGRcLAZpTuY8TK+IcLzALjVa/cYGHyg6wLT3BEaY8N4l0jOZDUltNU?=
 =?us-ascii?Q?gVoITojPi856sCrZCcoEytrvNsGCGeW5kL+ppQIAEW+rQPhrk3Jz55kajfnJ?=
 =?us-ascii?Q?XrFiyXGaHEWB/EpK6CZYlHxQZ0mp0FJ6ZHl2VkxVSBCrsEhmZ24kdIUS5K6C?=
 =?us-ascii?Q?rF7BpKGM9j4YwrY+PedCdU6IGIjYcfWbUw8mR5EyCbNFQB2KZMZ/+KzAE97/?=
 =?us-ascii?Q?Y1M+oItFpEAJe5e/FxlelwriBE1xKYo+98TvNq6q+rKXZbvVMJsBDPTV++Wv?=
 =?us-ascii?Q?7n06ndySGIEg9xHGLdPcIrl0ypOEHKx3HUjbprPuxXFw1lsNm7/WP0ZWLk7v?=
 =?us-ascii?Q?YNJ+M8OQME88J//Zx/ZbJE18kbUfo3LL55iMa4cKn30GG6GfWX3hXWx/Lbdt?=
 =?us-ascii?Q?B/Fk1M5jGwGPnOWQACgdw5T5JWlO5fB/F/ndeqbwRtVbkgkwkVzQundPyrFt?=
 =?us-ascii?Q?CTdQRCL/zVhsQ0txLb6EavP/akIdAm0rd6nFoevM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3b52c8-8c2b-4c1d-85a0-08dbf01d5f11
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:21:54.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrmT6BTUaAtJhnqCY2bsUSqOmNvKSAEnh1mrY2NKIQCRwtVJygBvb3v9Vq1P0SIj1aQrExvt1uMUZabR71KJhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

v13:
 - add 4 patches: 10, 11, 31, 32.
 - update selftests.
 - Now this series includes four parts:

Part 1: dump for userspace pm (patches 1-13)
Part 2: fixes for creating id 0 subflow (patches 14-17)
Part 3: flush for userspace pm (patches 18-23)
Part 4: address entry refcount for userspace pm (patches 24-30)
Part 5: v4-mapped addr support (patches 31-32)

v12:
 - add pm_remove_subflows, instead of changing
   pm_remove_addrs_and_subflows.

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

Geliang Tang (32):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: drop lookup_by_id parameter in lookup_addr
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add mptcp_lib_cleanup helper
  selftests: mptcp: netlink: drop duplicate var ret
  selftests: mptcp: export ret into mptcp_lib
  selftests: mptcp: add mptcp_lib_check_output
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
  mptcp: map v4 address to v6 when destroying subflow
  selftests: mptcp: rm subflow with v4/v4mapped addr

 net/mptcp/pm.c                                |  16 +-
 net/mptcp/pm_netlink.c                        | 187 ++++++++-------
 net/mptcp/pm_userspace.c                      | 215 +++++++++++++-----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  44 +++-
 net/mptcp/sockopt.c                           |   9 +-
 tools/testing/selftests/net/mptcp/diag.sh     |   2 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  76 ++++++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  39 ++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   2 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  32 +--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 .../selftests/net/mptcp/simult_flows.sh       |   2 +-
 .../selftests/net/mptcp/userspace_pm.sh       |   2 +-
 15 files changed, 426 insertions(+), 212 deletions(-)

-- 
2.35.3


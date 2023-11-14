Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F67612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bD36Aq6U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+DesCtFKOhBgDw8SZ3OkUXh3GGSrLV+fdwe99sXRJHR5lgISASjiLUI2wCFzN7kfyyzAwl6S/N9RVa/mqIOmxmYedFR7JVFDPzQj+tDZWuq0TvDuKrej7FUHy1dpaPlwZis+6i20NcT5w0Kat77teqiDjSY/D9OKrZbaWEXxsUoHafFl6NyMbTzgDbNmBp4Xy+FTZboc2odG64GPojKZ356ciyLwDhB7+eJGRMPDd4dQjE+vrxL+zOkP6zFfivgQQB/1mwuh3k14l53/ZH8i+ohICCqjxAhmzV/DeX5F3W5bySCgj/rn4z0PHSqlc1pFlc8BBBMD78ZD1aSwr4KAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqA+D6+5S99gKIBUrBDnbBJ+kUWoDir/V2lhmZeUOgc=;
 b=HXbiLhr3hSZcalEid+amedwrwaqhSL1AduNrVZIF8weL9HMEf+Dgz87vbrxCbRoQ9kzQGf3HwvaIZ2hx9rnXn03UDuEtc5hvzUxxkOqtLaY+o5U5Lsp3lJDn9rk21Epx7MmQApTlnwH/q3fdRdENVHeSIBWJdKZep+6xlF6m9YVkNoD3kYlkXRttty2VpfXQp7euhwz1nxaKXDVTfOitHAMRRb2gnkNkx1Fw/uUG38zHlLew2SErgaWhPrkY5nVfEeyCRMFGtJogvWNVBs6XKrDu+CEp/DSKmiwWUtr551nZybBFQ4he9e5vRXCaTM9giD3VzFGQ3dkprj0jw+odLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqA+D6+5S99gKIBUrBDnbBJ+kUWoDir/V2lhmZeUOgc=;
 b=bD36Aq6UjJOVrM5UPZoTX1xiZH0bUyL00iKIxR0nXMSKOTfuB/rrrN0jNYZOvgK19glw0uvPrN8W5wABObQR0Ph8jWqJIjPg0cccxPvDTe8uClYWRWbxI5AKhw3l1Y/lwgBC/e+h87wt7rpeX1SpO1A3YQuI/iJyEtvMai+BeQA8AyDO+Pox3Uy651bwk/fbfUITXa/erSZwwjCG3CW+lXZxVUMkNT3rbTwOS6idcSJv2eUQ6C8N/PHq1F4+7Eq5W46GBDyEtOg+f1V+GhCymQmgpf94zD5ad9KQ3tTXBvKJO7EyzMQeUvkKm91856ck0XEKvP/+ZDljw2GM+oIekA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:35:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:35:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 00/21] userspace pm enhancements
Date: Tue, 14 Nov 2023 14:34:57 +0800
Message-Id: <cover.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b19340f-f6b1-4f1c-86b7-08dbe4dbebe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NZVp/X0+vNlhIvYRlr4+8XuAGWxDvYNKQa/g1U57wLAgppvjre0liXhp26L7ILbDYyHCVVZvIjjm9IGAVp0jM0flkIQ7PnErqSeOZJwqPfPOImyVq7DJ1nTxF9UTPDyH608in67k5xcfb5OYAZf1HV1LB9/hfeLMFyA1I4xuSi4SzPWNpR5eyxR5Ul/cprO5d/MXk018kaiy1hS3wJegau+QiHPBxIRD98+yIdes1UDPLuLL6Zs+JMkzpTdCF2JQk74ACBWxg3wCZrVfDjCyeDQRaMZbPewG+et6SPaF+lMu181cbefVO9MIt6OqyxRpZSlg8LHtT6p7MmXDWPOAncg3OSffC7mZQ4T4XtsLN8AHvuAsoUD7bbKlNosJbRbEj8PxSXkSaQ0vb36rPDWZqqPaueKg/woFe4o6MKwP2d77QEvdPXgtMldTnwSeC6tA7FnJeevxAgH3qCSdNtfsICGJcxpm5B/Q2HV/KC9vrrhdauzCx1kIbiO02b5ROcPv8jPsTXA03DbiAuPq7dkUTsbczFZgruWqEUgWrl8GiCrQToefxlDJNzm6FB4pFSnBu106EOrJoROYDDUyBVlaDidUeinXdFonWSexTqUATqGyuEN4Wh9ojtpciUZlfsgJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rY3BwP2RemLi8Npt5YjDIZsveN4lAuk62DCq1K81QziS2LEJP/uni/Nw/UlE?=
 =?us-ascii?Q?lVt/oxqTq11aKFMEQIYlq4KoNrwKn2m1LcXgHHet70Xz9ovsHWVj+GIreinl?=
 =?us-ascii?Q?aGiw7vkEpzjUuPODOZhInLcYmt0raVGpXhYoW1uTQs1zo0zu0wqUeo/nawyC?=
 =?us-ascii?Q?T2JIA2xQi1j5SWmqPV/dhN44Ll8me8pgZZfMu2bjBH/8KpuDP3eqT2uvbtyR?=
 =?us-ascii?Q?Yd6v/9+K6T/ZlOSYCJ+abK0aA2hMO/act8p3gX+Fu+Vmhjyk9wJ651+54bBv?=
 =?us-ascii?Q?LnompxojrL0c7G0UmCyLYi+dIMNwiXnFUx/qHEDQaugoaFqifj6lvCCAMMNS?=
 =?us-ascii?Q?CBK1jb/IN/DMIF7g1Qe0l186L6QgcCJ22mDlWEcC6nseSCK0MgAvf3IGEgXc?=
 =?us-ascii?Q?Yt+nTGe0D/xuO8q4zOvd1ssn7Ruh7M5/WSQkx1S14gfQtJYSv2wH3t31qHR1?=
 =?us-ascii?Q?66VvPPF7Cwb7zedvaC3849kWdYdpveHUm4i7Sr6E0R/TdpK30jtde+W0BjIg?=
 =?us-ascii?Q?zsYoYSqfZZhaERiT2b9eh4c7b+TZcKmobP3DLf7IltaVpxhDo0xEfpPSqi6q?=
 =?us-ascii?Q?4nc5cR8ccwFnpkuWtqAgaLTC9Cuq3qVjNO6+eXWtbZCCf8AKLWrAkiJwIOB9?=
 =?us-ascii?Q?U29X2iqIULQedS5W+3v356NL7G6GHOHfdb116SiROdiRAA2C16+lUmZ0d6lg?=
 =?us-ascii?Q?v6MJ7aBCqnTw22ZfXJL1u4XPZWjh1zKOSA4OMPKfkOVkgFgjhNMv9u6kNVse?=
 =?us-ascii?Q?joaxLx0RC1VnTBJTO9SEj+p2cAzx4SC2tklB32QS2+X3+FzI4xoTg3hTukst?=
 =?us-ascii?Q?Ygmxjs5VMeFqE039ZAmuSfYtzvfXB3TqWGTD9F4hNtOYYtzhKj6yCADTFNDH?=
 =?us-ascii?Q?Q0JAy44pGvV8SI3nvTfI/OAkU15aHIcdyqpsGJfzj93x+x8P7Rz50pj4t6xE?=
 =?us-ascii?Q?ZVyWIuCtVYDtZX+MDzgFBM0YBMFn8mDzGXBXxkctJiFMZOBe9qWjqogSCHWA?=
 =?us-ascii?Q?kwygp6YZgGa3jpoC1ovq3IYvY/RcBqyVJCW1P6tybHb6X53r/hO2HoLjw+2W?=
 =?us-ascii?Q?7DJxkzCjEEVOT6nTl9p+9VYUcEPyjsJiRo0BRx+mxVkyzQSM5JHS0jWa73eN?=
 =?us-ascii?Q?rNTi7YoX8aFRJW4lkLV6Cn3wxSGLsOAGoH9kHqc8cYGnODnZJ5o+DfRubLu+?=
 =?us-ascii?Q?OarkmVmcKou0UiMHR/gIaY425mjk55tr4wCIdNVwgidiVjktv8XHaKpq5y0o?=
 =?us-ascii?Q?Eo0xnw54cIxY6ye7CldjvN3REG45oUbJLeTxXOusNUSLrZPJAxSQ1s1aprYB?=
 =?us-ascii?Q?qM8pHfoEVMm/DtIz1UmGYb2FSFzI3ep4U+YV4lMFvz8OU03xnrWeYztD5Xoq?=
 =?us-ascii?Q?dn247MEkaSOBmrukTvtMIo/FXs18HcXjMWaU2UiT2GDQBm5v6NUPvIE1hsTw?=
 =?us-ascii?Q?EaKQl9CqSlRY4koqv90kSzTtXnbPAmD/nAZOpdi1XMAE2yq5C0+PMfSjm0ZU?=
 =?us-ascii?Q?dlv39pz+cgXovRzt/oLUydWeM8vStkj/Ca15leZCdy34SvBKsZWnEu8JeK11?=
 =?us-ascii?Q?7eEmsL0LZwZoX9NKxqhfOmFrD95WU4xVA6XEs0n8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b19340f-f6b1-4f1c-86b7-08dbe4dbebe0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:35:41.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7rD7Of1wKkU4j/9cvXMe6eJIJ9xMHv4NW039fU8m7LLc/vAFOq6Fkx14oNZnIxsUmr2p8nT8ItJA/K3QCYLGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

This series includes three parts:

Part 1: dump for userspace pm (patches 1-11)

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

Part 2: flush for userspace pm (patches 12-14)

  mptcp: add a prefix for free_local_addr_list
  mptcp: flush userspace pm addrs list
  selftests: mptcp: flush userspace addrs list

Part 3: address entry refcount for userspace pm (patches 15-21)

  mptcp: add use_id parameter for addresses_equal
  mptcp: add check_id for lookup_anno_list_by_saddr
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match
  mptcp: dup an entry when removing it
  mptcp: add userspace pm addr entry refcount
  selftests: mptcp: rm userspace addr with random order

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

Geliang Tang (21):
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
  mptcp: add a prefix for free_local_addr_list
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
 net/mptcp/pm_netlink.c                        | 131 +++++--------
 net/mptcp/pm_userspace.c                      | 181 +++++++++++++-----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  38 +++-
 net/mptcp/sockopt.c                           |   9 +-
 tools/testing/selftests/net/mptcp/diag.sh     |   1 +
 .../selftests/net/mptcp/mptcp_connect.sh      |   1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  18 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  32 ++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   1 +
 .../testing/selftests/net/mptcp/pm_netlink.sh |  30 +--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 .../selftests/net/mptcp/simult_flows.sh       |   1 +
 .../selftests/net/mptcp/userspace_pm.sh       |   1 +
 15 files changed, 295 insertions(+), 175 deletions(-)

-- 
2.35.3


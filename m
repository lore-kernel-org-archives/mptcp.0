Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D810A2E
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CbwFS3Md"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD2fqylrB/8V4fVjpOaj1UlS7PHWOGEdRTc9j8DlrZOu+GRroZJZKHJaQJQoC9DLRm005my471RG5LhwEHqO/rjCT87LPh8g76G8uL5qUA9QGjsQstvBXmpTaniWrq07CWhErn49oCuwUGiqiyjx9ThamXnJo0y/CPmbv5Y1zNIW7gP0+BKHsbeGJBTQp8spZT1omQ809t186RBJ4o9+t11oGDaRiqoa6w93LC6u4agpj2cr27hGyj6ikJP6d7vbsAAd3JUWv/L42GNqRs/wkhwrs9YLapOIhZ+2Pl78z6VC2QH0AUjD0bh/yyE61qxsgtlbWykbK4P12gMgkR8Oig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGwoZRv4Qyf+H84cS5GiH4gigicP5IZhlZhHeaPpPBI=;
 b=Va0lLhWDcGtXmWgFAB1MnQLmNNOYfDiEBipZT/lyX+FiEjFEW4IwjRFH2UTE0GzkOxlNmJ/NQQ3hndt7jERr1UW2jD0c5ohTxljVWfcBYfNFmfHsZ0+FJTklyj2PKWZ487TP9nd69qqACkUE3Eie09ciu8SvTmnixz0oZQ+SQJZbCu2I9IRLFX1oo4hXWLrVxrDnwP1aCCLhgU+QlfW73PdDNcku2CnceJWiFrW++S7bMZ4Y/FnD1PPyrf1Q63YpmAugwrkQxvxzFVJ9nVBTbQKbCpibDxbCOFPGVcG6STM7HjzvdNGUikdWngk1XUzY56y1EPcu9+xSnx/gXp/7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGwoZRv4Qyf+H84cS5GiH4gigicP5IZhlZhHeaPpPBI=;
 b=CbwFS3MdF5CG7hXxGUMbG23RY1XgYcYAdF/nvmcgw6BzM8S6JGf16ZXya/UwA1VveWSra6gzEJ3AyxEANq2MA/+H0K1Konlto67E1dHD9eZ+C42HIGuNbKupxqktNKSWBuyzB9Es24QtWWBP1M2ILJi8lmmTEq9HhIttByvjGg7k0BuyTw/S2RNVjVqTSwuArQf+Tx0DRuMIp+7bS8mixsi2lfOPMYw3FxZhfdgkMozOX30wS9njXYVDqQI4j5rN+CgGptXzcf+fkl1lfsGGmGrEngXHSpCSanUX+aR8w5UaRHUIrqxbqCOYlb4OS4PpNoDdCHYYoD8MaKqzWnoHlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7014.eurprd04.prod.outlook.com (2603:10a6:20b:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:28:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:28:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 00/27] userspace pm enhancements
Date: Sat, 18 Nov 2023 22:28:15 +0800
Message-Id: <cover.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 691f51f3-239c-42a0-4d89-08dbe842a79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IfhB1l8fFYGv3QoM+ZgjD0K0zOwwq8BjS0HLwpuLB1uHii+JHood3nvcC+uRLBMHD1MiWT57v4g9hz1eXuEqGh2hf1xzVKZHmD8BH8phhB6smfUaU+zSlkK5rY6zpI7P+C1RHN8kB3g6zr8HexMJxEh5e9OJo+CenExOYMoP3I/qstmAGO1OityZcIbwFvq1nMkD+3Pg5tsWStSe0935o7+LHARVlxhNKR2kfbNpYpHAI48QuOBUd8Eb73ND9vjMdlEkHTlxnBkJdngWH6xpZrA61OYQLQ0liUuOpbtCP1R2p3nfqmusix0bohWNibDCe2WOy4iPQWllbvVGNaH8RYUzijcBIE1dffPpocLum7g0pPAdyPlkTzpAhqmBksis/mc9hXiOiCmtEWtZRIQE00scEBqhSVoOpQKTCRa124rQE4oyg2b3cst/omvClTWNDkWLtdYXMuXcyou25O4O3zRJ9u4xVrl5H3WV4SkEVtJTBtJENTQzPuh4MUr5KDd06fiiwOgDioeYkCBWNeMoyw1E2rBfek2svdwjeUa9BiRv7kJHWuqwJymb7FHGAUogS915ajl8gwq/OxA+G8K0Z2C0tptREZLwQjTnjtSPasQlWy0W8Ww8Yw42HGhPD8Gq5GmyF5VARgWjSKWUgZd68g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(26005)(36756003)(2616005)(6506007)(38100700002)(107886003)(83380400001)(6512007)(6666004)(6486002)(2906002)(86362001)(316002)(44832011)(5660300002)(66476007)(66556008)(66946007)(6916009)(478600001)(4326008)(8676002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbCGFZZONfwIqbgapkwmJXCnvD1LYDf/fkaHNCxbq4nvbYP7Gggpi01O+K2a?=
 =?us-ascii?Q?l49t//yNw2Ob6Dan/0CFdfXL08wRBXw8Fr/HjboywsB3UiKYhqfvVShQYYMn?=
 =?us-ascii?Q?pKWfcUsUjd4JILjUAcWTwAjPS/iuyzckVYkbHEEbqIb8HhBY3WflyAoLDdZy?=
 =?us-ascii?Q?jmdruUH9DzJt0hT1B4R1XUFKAZRQ7CC+9XCrLHDR/3vlA17iBx5q1uM1RSM6?=
 =?us-ascii?Q?U5oBCpXa8tIQ0gCGB2tNwC81C5vCmck37evjdwHp0Lwsuc30jJrDczrVcWio?=
 =?us-ascii?Q?oq12AD0vMnj44a21AtSoIaJ49UPa58ulMEDnnH2lJFy5/Sbz/VBusNVWPaBq?=
 =?us-ascii?Q?X17dq91fVOwvSTKBtqoDCJ3xFY6m+n9Jxtuu7f9bLiDnGXS0sfnxpBrzs9mc?=
 =?us-ascii?Q?iR0ca7R9aNNpanfcQ1tqDYMAIHqrpJ0rEnza8uWEfc/0InQidOVvuIjx5i+F?=
 =?us-ascii?Q?6orMpwfSbm/RwlrY2ymMsafETZr2/4oGcmIVqz9oCLluym/yOJxXfMBGSazg?=
 =?us-ascii?Q?gRzri1rnyKkclEn5MDilS8so7TUJOCYd54l2UX7dNQSN9yxgH05/wvSWaaw/?=
 =?us-ascii?Q?l8oIVortUWMuRVRU//KNAi79+CwwNCVhicYgqfzU/g7VhIqE1VmisR06NzWA?=
 =?us-ascii?Q?zoOEKN4hVZfj8JQ+BzQLdlx9QKHjP+GrF6kw5B4Oe8iaUJfyKsT3RJ5OEfU/?=
 =?us-ascii?Q?kIrljst7hovaoSJ71Qu3IbcxrsjTkEeWiv6gS2F3a7u7zUTelB0zPy3nvhjW?=
 =?us-ascii?Q?2Oid61tsGD+1CROXOmt3kG1DFzBkyi5RgufIgrDG1b8MOzqAEmcqn70XDwfF?=
 =?us-ascii?Q?W4ht5+LQWgn3hzTC6Us6d8hQDuHVXxqdXOWA6eHYA9FGfyyT6jJk1SW0Tume?=
 =?us-ascii?Q?s6OrwKiriZt6aQWx6A2bNVP0jsEeNW2kkxE8YuCWsESrTbgG63xhc6YDp7DK?=
 =?us-ascii?Q?X7/zDVsg0rvJq/3huhj9SCcWFbouF3y+4pqUIAFhaGijz16GTFFFfB8l93js?=
 =?us-ascii?Q?YoJTV04DJ2IaxB2fwSLfNHNsnKpMtH+vA9nRy8Pbjdd0ozJYAKJPCzE4u3Qn?=
 =?us-ascii?Q?rXy5zSYGPkoH7q4qHvNqdAUt88sLootFU757zMhoJWw6VrEqRx7WYLTQ2iM9?=
 =?us-ascii?Q?5qfSD3ZBVtlfGHk3hU3RJuj/lVEtsks72LNFt+wIYKKeVl23QfTokwz7ZEbh?=
 =?us-ascii?Q?EQTDabiwmj37tYJZH9pttuigjah+ngoNMV45asZXHHWPnEZkxOL42TDFu4/e?=
 =?us-ascii?Q?md9iryfC2Q4A+7SXhs3iufFphM5ySV4jrdY09WUlDtmSPpYTfaBl0R60zERb?=
 =?us-ascii?Q?6ImXZQzcfdUhJr2jNjO1VJ0wzUIHJWrLb4YzRiJxKQvX9aPdGmbKTkwtj2//?=
 =?us-ascii?Q?f7EjhIRRCFxGfoBT08SZDtG3qt8Yy4jBuHEA9Vb+Yl9rgfhAioMNTSXjY2Xl?=
 =?us-ascii?Q?Yp2Qvk5M5FOqcVjTae69wkm+VecKtBKRezNSIEo7yu0axI+rBFUV2N58V85t?=
 =?us-ascii?Q?On/KDSH+7/2ojJPzdbpaKJXgGBxI8j1Z9eWWc4wM7NCywa9Xl7SsIt/AfgsX?=
 =?us-ascii?Q?uuXoBLKmZvUpqCgKPtFx/q5KuYnf/wGrpnBA9BUH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691f51f3-239c-42a0-4d89-08dbe842a79a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:28:38.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTnLDFMfpSqv4+yh14GL7D/hDFIMcXIKiA6anvDv/GdUs4U1cnxRKQWygVZHLEuygRLso2DbNe1QtkGKO6YhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7014

v11:
 - add a patch "mptcp: userspace pm send RM_ADDR for conn_list addr" to
   fix selftests failures reported by CI.

Now this series includes four parts:

Part 1: dump for userspace pm (patches 1-11)
Part 2: fixes for creating id 0 subflow (patches 12-15)
Part 3: flush for userspace pm (patches 16-20)
Part 4: address entry refcount for userspace pm (patches 21-27)

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

Geliang Tang (27):
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
  mptcp: add a prefix for free_local_addr_list
  mptcp: userspace pm send RM_ADDR for conn_list addr
  mptcp: remove addrs when freeing userspace pm list
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
 net/mptcp/pm_netlink.c                        | 172 +++++++--------
 net/mptcp/pm_userspace.c                      | 204 +++++++++++++-----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  41 +++-
 net/mptcp/sockopt.c                           |   9 +-
 tools/testing/selftests/net/mptcp/diag.sh     |   1 +
 .../selftests/net/mptcp/mptcp_connect.sh      |   1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  67 +++++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  32 +++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   1 +
 .../testing/selftests/net/mptcp/pm_netlink.sh |  30 +--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 .../selftests/net/mptcp/simult_flows.sh       |   1 +
 .../selftests/net/mptcp/userspace_pm.sh       |   1 +
 15 files changed, 387 insertions(+), 199 deletions(-)

-- 
2.35.3


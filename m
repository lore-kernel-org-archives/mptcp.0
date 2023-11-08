Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBDBBA44
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SSDm/9Uo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9VLKPFMsVKM6o48GlZyZwxa3sLUeB6UnhNtUBSswSnQpVRkR8sN9LAWN9FgSjNDFrYlGqqWDY+VWnxnGIHW7UvuarDfgrUavIkAzLRO9TtCeEJjCfcNe3JHnKvT9sC7cNQRIyVKG1F1kRoAqfIb+6jmkWiwysI96QzIq7e8pL11sgNfWPUySRd8DOSB3BBvv/YCrYW20konKr8M/4GxfE+6Isv8Pc5EI1c8dbl6l8thCskLXkbnWKQaQ48bzFffr1p2AE71z5VNgSdEVUwQZQZOi7whbkta9hxOfmmoVTkb5khaLfhCOT0VlmkPWtFBe1Tz5MPAb7OaZy6RektysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrbA8yfKG9Qyu+cmyd+YRh+3fc5HrIProoQ7NvEuaMA=;
 b=GcYhxR/2i8WPNrGQClnCDhES5viHPK5Tf03lBqwlOM5v9OBIJmmAPwzHLpYXMj9DV+5pCQAzzfHvhq2YBvgF2dfzIBJ0nEak+B3BZMhZXa05L7iNloVvniKX692ndbnlDz28QLQ9AN4NLZp5S7NSOgfD4LFm77nR/Z8g3gvJbu2aJrCPE3HFTEenqfjLbVbu2EbymP/ZenT4E53xlEg/JvYNmzq+Sw0tVTWl2ZWyCUIyz0AEPA8K4nfhOZwr2usY33713nGo8h0levMF1pB202e0qjWQ1qqwod0jf4a+q/fyNBiZH30Om1mhdPXSuuoK9xCSAEEsRE+WUPthsPBTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrbA8yfKG9Qyu+cmyd+YRh+3fc5HrIProoQ7NvEuaMA=;
 b=SSDm/9Uo7RwU9wIh56OJfRB9Mzy2Cu40xB2171mq1UlWbLXJTY9cnEB64T+unNVEvMTtP3HzAG2BnC6Hm3mBmyYrvlvIMtVtJUdFJMfrwts89+b3efJ7cA5R5FJeQTqGEBcIWsw9OZGA1JzzjnxWzAsXSPz5qwVML148E5a3e9d8ePlJDwXj/2Btf4jU45IVxVdcGHWykZTBIqFvNOIDFzIzjYMznwLm3ddpwcyhjRF1fG/kOHzdEdGV4YvNCy1HHkAwElj3RYjnG8wAwa2PNxDu9YStSkGMfBAYYOwOpV8ukzqRr3DmAQPkAYAjbm1hWJa/PITCQEpFXRPS67UZLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:49:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:49:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 00/22] userspace pm enhancements
Date: Wed,  8 Nov 2023 14:49:30 +0800
Message-Id: <cover.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec26930-1b31-43b7-1bd2-08dbe026eac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OIiaJvATbm8KEhDx8+F32bAkq8VQI8peZG3WHtUCp5oXSEutHsCp8UOYaPpowyOflCtR99NN/6NUQBVpz8sobJuYDbTqtRHFsJS9i8IBzYEGl+kqSbwnkmMD87Iyhxo1wECStXl94xaTXaMqYC8qSKgKrBbY5N5jOGCnv9XOB6cxFqbjIdB3WRf3XAJn8RDjJU0AtJMctZ7FCsqaJWmElS3XBffLfrryaUZEMxBCC4AAnxBhYkIiTVmBjhinUu+KJw1RfNlK1NN/F46+SxIl1l4JS8WuXonOG2cK9E4J8P5+iT13+3w96MYdRxh7U5gg6bfi7dhWSDQLpcS5oYX4Xo836QBhHuIPdLFdroP0kMaPKuezArcAaTGzEdusSEqf8lfoF53E/4wKJANLE/uZ3nlZxefUBxpZjuZgZaOZ4OUF5CGqkhljEghmGbMA6nh84IRJwDGcti0oVaO42pODK7p1HejrpAwKeAi9prutMfMRMbNVY4o5b0yq7d3jYtMCt6juKa25sBpj9cs75/pzZImiY7WuwaUW0rP1JbD55Pb15gN9NNsuHUOuEhb8WPxojwikYevpkKUkwY2jlnFs+QMNeKpFiQzfKBzK64ZDRhBYkvhbdFfnWgw88kgQrkHmnuSl/3BhbUfet4WzhVv6ZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9fH2E2mdKNOqZ2nejszcHwMWUfrjoCQKEqe2RUkMkzTz0Y1DmjpHPPat2uT?=
 =?us-ascii?Q?NxPlHjcGdzls9T5zom5OqmVdiHWZI4e6iL+UlWMdGeyqPcpsyIZuDEao4iSq?=
 =?us-ascii?Q?Wb/dcgpem7jr52zhonQCLLzSxj9+fWlKqBZQk0TP1ynsPwDKf6rgPEreiemg?=
 =?us-ascii?Q?I7a6N5Teifp3/zsWCI+zOUNr9+LA2tCEAw4IaRVlhZFWHxxF5QWdEDO3i76z?=
 =?us-ascii?Q?LMeR9aUc1cqAAQKxEDvct0w7e0itytROr3E1419JX5enCETiCcJaIDFrij8X?=
 =?us-ascii?Q?nD8lY/78TlC9EhsfKEpVGxjRhMFh7j00n7Brn3gl/KjcUQoZ6eTgC65rmSwW?=
 =?us-ascii?Q?tdFwbR+YmLzYx5Xb6f74B/eGs066y7v8CmUaU9liGsc5DhToGlzdOYoUOpOd?=
 =?us-ascii?Q?aRSDu52aI09Iu8g2Xb1vSBHJQ24mDtzEgdv2kuBdKY/J2eJn6ooqNDVp2iVv?=
 =?us-ascii?Q?6tjS4KbKgrIIl0L/FEEweVC9UPQHw+iHzNEcR5K18pwia8rzOffdueJoNJA1?=
 =?us-ascii?Q?zxge1yx+gkyA8dkuJqwWrSYsAoPIGt+GFq3nkXWNdEdyNxwodk09rTTConyT?=
 =?us-ascii?Q?/fr+uLXICIvtHUvMIR80/46b/0img8WnwbtGnuW+OGE6gOV9ava2VwyoBJKE?=
 =?us-ascii?Q?AtXsjr8ZtfgdBTMRsD+jji8dJNnf1QyKPcjpuF6VQN69UIREDbGHjk6qAtdJ?=
 =?us-ascii?Q?AuV1llXEI8LeUwJcdAob+cDc5Z+iV406V4wD+KxPTCPO2q0GgAv7tWgpFg/P?=
 =?us-ascii?Q?hWBcNqfWfJAJraJtlECQNWxDIKKmv/PbPIzVWwOci1ewdc2gOsIuL1MXYzbo?=
 =?us-ascii?Q?3sxdQ6Oxh37B8dcLSw0f16Rwj6EWa+cWCqYmqkX7aOdWQk/J/9bXjQTwrkVE?=
 =?us-ascii?Q?Ckm1dCApv0Md2hHm879RNfY5pcGeS69zjoVZqMPCLaEUFDhLTr6plwvkVRRW?=
 =?us-ascii?Q?4w6jIckdD5Esbb3cF3NBYeF+DoAlXOZkSrMaXY6zr4gzTDS6WYmUFJ1ZRB1Y?=
 =?us-ascii?Q?Y6At7iQ57QfMdycZOig3P0R+Y8+CotSn1jcL0kDqXdvdLF5zmbPk1QRiujs3?=
 =?us-ascii?Q?QKfHS2D4hmr39Nsw5PCNRGMx6DK11xmKSxINPj4O7T5W+eF0hR/Cq0dLOVxQ?=
 =?us-ascii?Q?y8Ph7Fl1LsES9L0QVtMkmRIDkNgyNogoPu23NlYNR0cp5VuBgWJdUlHLu88w?=
 =?us-ascii?Q?J2W1yBsZa6jh3CkWVjQ0nHlUld2p1XhYIrUVipUBnMzBI2Tj3ofDyIXK4YNy?=
 =?us-ascii?Q?k8t4gUcMRVNF1KzCqKsQ3WjFqLn22Za1w/sn2gULOXkClEvI70XhoOfAshsa?=
 =?us-ascii?Q?LOceaC7GJOoXUE6ArI5uKQyzpbvEpOGQWu1M6kwvOEbfILv9MNwyePURAzYD?=
 =?us-ascii?Q?XIJ5M+k1gmmgqGkpGVVYrGk3DIH6yo3KIUp6bUhyf9/pcdzGuvJbudyI/Yyc?=
 =?us-ascii?Q?KljI0oS2TUKSDQyLbxPfz1AiTwBogHpi4dBlUaHBlnPAXrvV2HpzmFPJ5qqR?=
 =?us-ascii?Q?MqwE5+H9DVcqBvzc3rrm2QK27qamsWtF3TejK6oJ9vuaPK0Kh3bKu74300O7?=
 =?us-ascii?Q?aECnWqfHdDlnKy4AMXuqrJPD/kz2ypDhMqL8Ln+qhtKwVVSgPirFBjYPElX7?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec26930-1b31-43b7-1bd2-08dbe026eac5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:49:56.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NC4uR+TboeXMVe5OFja5Bi7cmdZy4kpA8sfzLx7ULvCjBGHkSOntB1gO+BF94PwXUuq/zxGXmxYj2QTHXF6VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

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

Geliang Tang (22):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: drop lookup_by_id parameter in lookup_addr
  mptcp: dump userspace pm addrs
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add mptcp_lib_evts_* helpers
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
  mptcp: add netlink pm addr entry refcount
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: rm userspace addr with random order

 net/mptcp/pm.c                                |  16 +-
 net/mptcp/pm_netlink.c                        | 159 +++++++--------
 net/mptcp/pm_userspace.c                      | 181 +++++++++++++-----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  38 +++-
 net/mptcp/sockopt.c                           |   9 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  83 ++++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  70 +++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 .../selftests/net/mptcp/userspace_pm.sh       |  91 ++++-----
 10 files changed, 394 insertions(+), 263 deletions(-)

-- 
2.35.3


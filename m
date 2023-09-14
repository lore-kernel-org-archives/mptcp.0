Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232A428E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrpO4FSJIOHK+6+0KtxZDPApUOs7cfkFOASMSY9eRGOsUt+zP3b3WT0xX+AqZo5ZMNEIDYHSDlzChIfnYrm4CoLiRAKmCPFXy7R5+nLCtvTC68iiZRloSSeiA/tXEJ+5FXV2nh03UX6rLk7oqjpfI/7cdg3lD1hAU3y9Oa0XPn6YpDs7k/o+BgL7RXZaaQ2T/1phnaSAc422QmAOf2wwWSmRGeiTA1tn387t/yGwOW+oQhxD9PyKVFbIoKd5A9uqN//Wp+IkHGCcYPAaCiF5JhAzfql35y/87KVLIqB9NThBPxbkSCQ/9to+xTGkt9GPXbByjQqywPF1PDNK4DFBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFlw+CIprQz+h8ohkp2AWL3GRbsDxN/Yzb3r9kAKvUw=;
 b=dgs/WBTe0lXTb6o+DRdMkAc3S6ZxQgPzEMlCtgmGib19yf7lgQfDazFiFxVf2u2pdxirBjFBGFKR77/gfC/7B0yxFqqRMv1fyUkNAcFp/K2NKcHjlwsgihv7aPZXUzrByBbin45lJAw6+TZW3IoNXJ88iGpAuyyFqwdoGFXKnWZp/DyEIt/9tmB5ZZJYwhhoTkLycSxGBMx7FUvGy1XjtkzN75i2EWgm8bpdDnFv2Z/nRiTCiq8oV4tWJAlfvh9JEwyFRERsZHVNqU26Xs8YnPGYm69X1625VXexjCN1xVQg4caxApR/dmBX+FGFc7dVgEo+xws6UoVexflj0BIzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFlw+CIprQz+h8ohkp2AWL3GRbsDxN/Yzb3r9kAKvUw=;
 b=VIh7kqPYQ7CXfC4OTyfInl3ZHCBp7IlY6Es7t1Yr3awkuabudiAlzTyJRMSsnBQPGv7rejsdLB4OfqPLom3Caaago8QIKQn+8nD7PIg3vWVpt3Eu1Y96jYg8RqJ77acUMP/2WNLLEED46lR6y0g/wnCKIhBOZMFqHr4ZwjshKlaJ0lZREeF6vEhEEPAjGyD+GDMjwH3sb2Su76pahY97GfY4BhxpF+je7nmhNdOSwtnJJlIo0VWG/tp2q9M2QDgS0fx/cURvnv4UNOyV6aAMA9j8poazzJln378td6JgXusSVfyBxXCSfY9IG1AEfAsrt7e4snXHp+Li3lJtD7xmAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8046.eurprd04.prod.outlook.com (2603:10a6:102:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 14:49:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:49:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 0/9] userspace pm remove id 0 subflow & address
Date: Thu, 14 Sep 2023 22:50:15 +0800
Message-Id: <cover.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbf41b2-4839-4d02-4f5f-08dbb531d531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BoVKwDWbE2SfyLcEjadmgm3pp6z67yhkVwq2R0MGs/L+dZvN8gyKQ0m20B+xxeFWoKuYN+VtrF4sZMIna8w/jV8GTs9CqDJKq4p5yMVMyq1jt5fvubP3GwRplmpM8NlHJ5sCDPZfmHLhP8IXuDKkhg6IhMK400QA7AwMPJI7PqgyMYc9a7jDf899N5OFSkMIy+MhFpw0q6CxdXsjw1MUMEqTjLZYfIJDKROy0XXM323fAY/7LK/HM/IClAbGKaSGInGHfTpW681ZtcK8gIfh1NnumNImyXVk213PvbycBMZiQ41NvPi6ehts2R+gWKZBAz6ucMzKenUV0GIwMRLikiWEJufST3le179qg/xN2y3v4iVP7ibBGVf0fvEvSTxVTdD4TPuijlMj1WTKmTp2l7YTE8QaYUYH1qcdstjK7L2Yhy4AwAlClb220CpqaUQOgtL1zrOcM/ucrdhC0UucSJ2V9/0xgljOT7apuNZxNAQwNh2KvBUBD4XW4NPg+zW2/qWC6D3/vVfbS799p9AWsT8e/6sjBri4BkD91yp4Qt64Z4uUEC2oUgbnBpyoWNRUoJLQ5BuFVTro+QTkH/1dqVl06bcaont2O0IVucwZGos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199024)(186009)(1800799009)(478600001)(6666004)(6506007)(6486002)(6512007)(107886003)(26005)(83380400001)(2906002)(6916009)(66556008)(66476007)(66946007)(2616005)(316002)(5660300002)(41300700001)(4326008)(44832011)(8676002)(8936002)(38100700002)(86362001)(36756003)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3cr+7+f/ApcdVxRRNZQdujrA331azp3QN6OOWXZp+gkHpSyd61DqqpNWJwQe?=
 =?us-ascii?Q?KEe8260sIffSW0BaHpBpELO3q5CnaucgZZY6Fo6em7VBWsPER2k4dcCiOY6+?=
 =?us-ascii?Q?5aJYLNzEgD0NDCIGYJxpWQ4/th2IiwjdgWyjcoyEUcf4wMCz5JF6rP2NBHaT?=
 =?us-ascii?Q?2cZt4uLxcvmbidRgbLfcL4CLpRNrWhSTP9aZykXtDvH/DmC2VPO2T3rJZgGq?=
 =?us-ascii?Q?DL1ywiMWltj5pinYOg0YutO58+EP2EIo77VrhqesiLyHVQtT/jPL0WGsXbmX?=
 =?us-ascii?Q?zaU825GXtMlTYbTBf6j1iR6galixAFbMXJtyOdjJzVxePPS5z3fjJM7MUd13?=
 =?us-ascii?Q?c27MKR2dAVXoeKhIPn/n7DPBUL69ntt8Tqd0wvLcVSWwY8KRmK4sGRU+DC3Q?=
 =?us-ascii?Q?VnUoGTCgrytNiZWgr57W0L/oQbcxqudJ5vIFBO6PDBHop/pz5avPj5ibfpjU?=
 =?us-ascii?Q?e082mcBvlUcgrvfEPu9vmVBrfSUeiUKTa5YQX/iFRfX27kdHhapKbqRN9vg+?=
 =?us-ascii?Q?b0tnF2nUS7f6l/1JNWUJW4pu4R0v3Ll3TqQcUdDYk/DqpW7XiFNDuaEaD1vq?=
 =?us-ascii?Q?Xtl61Mgh9e5wBtstphtrUpY9reMUL0dcjNjiOb8GCE1eQhpfFTxgIenTypPF?=
 =?us-ascii?Q?FmPdipVoCY9uxCjGBYpLjL9WBAhcoGGPn5ZhFWnWp/6H2rPCVZHxaeMdU0Q2?=
 =?us-ascii?Q?GIBH7TPNxLufYD4Bk4altIUUhGizqP/QxcPNUrLh7Sl0uZ7o2pGC8nzQ9+La?=
 =?us-ascii?Q?GfavPxzCygz1OK2qd409z2U/qs65nVc5LKXro3xo4NTOOir3nHITH5T5UHFI?=
 =?us-ascii?Q?jrJJuIUU8UyY+SCmVY6Lv6iDskzMrCB7SFj0CkVliuvGH9jkZGXqs5JrEE7N?=
 =?us-ascii?Q?IKrvWsBfaznNPhNn7Jg6ZMdWhtupbtreyizAamrjiANwAhJhsM2gcXdFnzSp?=
 =?us-ascii?Q?wmaaNy8BYYwFBzrCwI1etsO0uIR+8a37DOvFF9w+guwPKvUII9AQww+POIu7?=
 =?us-ascii?Q?M3y1vtvU4cjwS6564uSpviGQD1TD9BFaVws6zSJ+77I6KbyeRPFgCy9mZLfD?=
 =?us-ascii?Q?eqwA3ftUJ0JNJ1MqXy8U2giwTUtcJbVuwB05dg1qvd66q5GEMAyxWT7OuwWB?=
 =?us-ascii?Q?nnuBkcJzh2fe+5aMkrvz3eUG3/Ku5HOt0pMwONJ8267fS2LlEvmRUX1zu9hp?=
 =?us-ascii?Q?Ul8QI+R4lvNAITiPQreAmJ0Avy9FHOdPNaP7o8bNbA2AJDD9IeMBjoj5Lf0/?=
 =?us-ascii?Q?kSaAlJlDJsTkXH1yOO7QjjxrA1PLCRuqBPohdQTs/VZ6Ie9119ulnhDAfnqm?=
 =?us-ascii?Q?CaPaqUKrYrOUbByOaf7DanKklZmd8N4MPtZq0ZjAc7lPJE8gql9+9gbuez9H?=
 =?us-ascii?Q?QskIhHtCosSoUe1XmxORhzxKFEz2Rc7GujrqD30laac6jNLnFq/QOpokzMS2?=
 =?us-ascii?Q?qyJEHpQmLq8Z+k/L8MZwsrTQCeu1XvNzUMnTvBatjR6TnMsG4WLcObnZM3uI?=
 =?us-ascii?Q?RUeaCIrgHHsngJWOoG3U7o7IfafiucabXAIE/m/Sya/XDcJeZ8BRLRiV//Qo?=
 =?us-ascii?Q?nqpBDb1y8TczV/wfCBcgQFsFEDiac1OYZ6t2dgIJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbf41b2-4839-4d02-4f5f-08dbb531d531
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:49:45.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Mz4g1qWeZPsXcNrVT90lZruhi9rlCSZwQlm1QEr2m+s8OMDKFdeS12BGsJsi0pfSBsKC5GjZcsZBVWXKuUcAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8046

v9:
 - update __mptcp_check_initial_subflow().
 - split the code that relies on the 'ss' modification into patch 9.

v8:
 - merge two squash-to patches for v7.
 - address to #428 too.

v7:
 - move evts_get_info into mptcp_lib.sh, update userspace_pm.sh with
   this helper too.
 - drop the last two cleanup patches, they'll be sent in another series.

v6:
 - add a new helper get_info_value, update chk_mptcp_info(),
   verify_listener_events() and pedit_action_pkts() too.
 - only patch 1, 2, 4 are changed, other patches are the same as v5.

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
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428

Geliang Tang (9):
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: update userspace pm test helpers
  selftests: mptcp: userspace pm remove id 0 subflow
  mptcp: userspace pm allow creating id 0 subflow
  selftests: mptcp: userspace pm create id 0 subflow
  mptcp: add no_initial_subflow mptcpi_flags
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address
  selftests: mptcp: check no_initial_subflow flag

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_netlink.c                        |   3 +-
 net/mptcp/pm_userspace.c                      |  33 ++-
 net/mptcp/protocol.h                          |   5 +
 net/mptcp/sockopt.c                           |   2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 221 +++++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../selftests/net/mptcp/userspace_pm.sh       |  87 ++++---
 8 files changed, 252 insertions(+), 112 deletions(-)

-- 
2.35.3


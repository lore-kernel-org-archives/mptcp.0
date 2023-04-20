Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B564317ED
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1bI+9aU7EF1ePNKaMjWIY4ulTibe13zLz+GHNhuhXczvFbshDRHu14dxDC/mduCHnN2vq1Tcg7JwegNldT/RMWuPxueT1m5veFhGw91C7CORiE6UTDWfOOWnXKIyR6NFdi+sZsFPLmg2tjb0L1VTpIIa4rCGmM0/1DYPmuW6NE7pvqzC7b5Z2t0iTTsq0Q4Jmd2KYOMdPcWMc+22VKGjh4OYBT0wMlBQhoJKgAG31WlOwtmvtSN1Z7Pbau644EiNP7lA962MXzp2IwmCLFq2bJxXHFVNHikxwMOv+dDO+L50LxWduFTi85FCsSm3gp8NTqABXbkydoQa0n0bP1iGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XA2HOkdu7bfc6KL40z8/2sjnpraYQz59YZyKN1DEKgM=;
 b=WnTvaV5PcNq0HL421uuhl8skWnxDkc6pMC14kJ3vwEjvHBy6yWhXLK7RtemKWR8qtUU1iSvN0UUw8+SVvmSULNuQ4Qb2GOXkbVJKAOSDSI0s1QvKJVcos93m6pnNPgcQ2+BF4uFQSAmymt9AVLnIGcaYBpLlmQPe+IgBAwdjAFb5XUcR/zQfa+ru6Sbz+97zWeuGZs9dLIfstX5XYQ5lJaiV/qGiVkladdd8FNAYJidRIphxsSCdbNT+KYbrmKBc2ys55muv0sxl0Z7NSkBMEUbLaNWT8Xqvzb9VL84eFI4PCZ2GpJ8RUkfZN63fzSkwp5O8QX0jiyZ7zI1J18UT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA2HOkdu7bfc6KL40z8/2sjnpraYQz59YZyKN1DEKgM=;
 b=b1UZNYnWYjx+iA8qQeGHsHxNvttPuoi9/7oRHOpWCw7uMFvPpzxpdX61iwuxNSsIk0OXlwuZzuM91rDQCMwMpSoc6k9hOpyUbYib0BlCGvegqBLznok1kHK98ErbO2cQWzGMxHuLgFFtbEa7DxOBkLqbUF5m2C+h04HgNw7jZ6EgqGrM5PNGubDcO0+DflnJQSaXzH/aB4AerNCC0RLV+y7zuOz6g6e6bcSPAWcPsx1It053wtbKPeSUhi6uypwAuMAE4vhMPQ+hAwcl5YAf7DirM7vSpn4iWcnC25MM+zx903a92LfzjOT+QT2eg7u+/W3ofBNY18E6T6Bu6wvR2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Thu, 20 Apr
 2023 03:11:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 03:11:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 0/5] update userspace pm mptcp_info fields, pt 1
Date: Thu, 20 Apr 2023 11:11:34 +0800
Message-Id: <cover.1681960259.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fccc493-af97-493c-689b-08db414cf163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r7SGLIMBRbBuIhCW2oyumRir7NGfDD4q/xy7xcpya+g8dT4/RvV1XXyH1wR3fqfCseOQrQSzSh5AqedXyskEGtPlayHh09nffjOaK0isajgtrqgB+lUICLGbAipAWIY9YImhDduq+/yrq5ZUiT23bmxHP7XD4Nrs1Zj1tTJ2hjh4Uqp30q1EuuYwnAkD4rnFZkZNtR4u/FnfGCORlKmhhfJLynKE5XN+Cwf9q3YrIcUv3TZkE376mrLadRA/kdLMIXTTWtFS084EHdm93YY+pJeg5EojdaZrjh6zfj1A6N6TZbu0Ao6pJrAnjO8iswhdjSH5LhXJMBwhiUR8bf3D0J5sPyUTUoS93uxKkg89t9iKEdrYScO2oHejjKdz8G+b988Ssw9DDGSOdNE2M/k8gGEe9pm6hTfFE6aaw4HrgEGzTtshQwVjQmzw9hzWRnms2OQ/HYBbEOB4qsRsLNp8Z/AycW2YyP2CYa7igZj215uiOFIJcvChgdut+ZMfB9eAI1ZQM5vQpAYpr6bhPQPHH/G/GOrmRA6nGcLYIeutjdnHiVGyQQEb6p6dP5Ys2CqA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(4326008)(6916009)(316002)(66556008)(66476007)(66946007)(6506007)(186003)(6512007)(107886003)(26005)(38100700002)(2616005)(83380400001)(8676002)(8936002)(5660300002)(41300700001)(478600001)(6486002)(86362001)(36756003)(15650500001)(4744005)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rKfNtzeUcg2mcxsm03WD24cukyGjMa81UaecdRuEucWoA6U0rEUrtg+Uqny7?=
 =?us-ascii?Q?XflpU9bn5nXX19ybAWo1Bd0JBOzmH7xEAMCVuE8bSGHEzWHbDSJ41tirS9sY?=
 =?us-ascii?Q?2/pgzC15tw8JBKDJgXuvc5Jcn6tdOY/ZkL+UPjAmqEzo2Vh+4DM32Qvf5FGz?=
 =?us-ascii?Q?yMNo4lE567390gkpktUJhk70YUWOFGxTwuuI7Zz+P8Rb5+k3/zZQbZGzHMAc?=
 =?us-ascii?Q?35LGi2xfDhPq1hiO4qH9GAhltItcCIFIhwYlocz54v9SSJKSj8n61BWPciqf?=
 =?us-ascii?Q?bbNrSSNjnMEuZhLhSwt//hhH2zicGKnI6Yj51LJKD4unk4ubNcK5ObbwUoL0?=
 =?us-ascii?Q?0CNo7I+tW957lTnOMPz8LZ4TpVp8JShbnd6qI9+Qr3n6D5EHZp+2DRHXZycZ?=
 =?us-ascii?Q?/4BftmOyr2LVps77WSovbj1LlgeTgl2NCLXjReSOEBubmiMsvRmtuLBbOFWO?=
 =?us-ascii?Q?qqgmKhiAMvBt5eTLC1VbSiQ8CvH610kN5wbV8Bn0fnwbHvyOaIujooLD/M+s?=
 =?us-ascii?Q?GXVX0JoOzp9aKxktD54ZOAiYf+qmTno1shBfco2e5cAkcUY4umGwayYfGPSk?=
 =?us-ascii?Q?qKUEW6z6IenMeysBA+JiOuM1bgIruNs9x0RW6Ugpd6ckyIasv0SKyBg8T/S0?=
 =?us-ascii?Q?QhL4oqoBbZYzCLhOdzL4HeZSZA83q80WzxyWJBiVwPQ4WPKO2JWXwsWiiMX9?=
 =?us-ascii?Q?0dph70e9/8TLvZ2tms3QEygAdrlZ7sMxSyRmL8Cc62FYDeLctJJJm1E6+G9s?=
 =?us-ascii?Q?bQ/v/VETs3Y7tBWJEaA7Ajdz8FnaLSRYy9/eCHT1T5/kHzfNRG81G2yKcfR3?=
 =?us-ascii?Q?8LECW/LB7Apx5L/sPp0AkDGlXCgslLplkpbJxT3JXrpstYwUDTXksz/fDGko?=
 =?us-ascii?Q?EYC2RWYzEMa8Se+7L02SGVVRvtxMqUOKlEF7lOIAQhMIqFTD9TsyZwgpw0aO?=
 =?us-ascii?Q?Z/ISIY2YWtUWNUc4enI5oETN3lKDuCdeARS7KASj+0RNcs3RdrQczsCL9Lk/?=
 =?us-ascii?Q?zzQps+ie7Bkn9aS/A5gyjsZYvq3oq4+zBU9onVzA9X1Og7CaJteEBrJSDd12?=
 =?us-ascii?Q?pVdCwK/iXk38P0nJAu/bTV5PhlbDwWvA8Jeo8eU2/Z1LKe1Vae5VdVf7Bcyp?=
 =?us-ascii?Q?iJ2bHbE3m8kYy4oirylYkpGitVRGcCJtyPzVfavmBs+CiIFbm2DVB1QMAm9H?=
 =?us-ascii?Q?ZNjOxBXJpQFhIM648MFHnx+YqXm741uQ3VzjXnIJVDHMDLKkH+2picl5hupg?=
 =?us-ascii?Q?m49Cu8Zodm13Pl62EUbX7vkcgkyDCj2uTK465BxKVxT1Q8EtCM6/mk3oML9r?=
 =?us-ascii?Q?3bwKdO5hpHqoGHgoIZyGiHMhnwKalYT0fe3RDkl87LehkuzSj7e704LeeLVT?=
 =?us-ascii?Q?HEnxUfO0yV3ZL5/Vs7KF2nFU3INBGNeRXXNwqC0+dWNZSxw1VVtsznM2GVgv?=
 =?us-ascii?Q?8gqlRyR9kKvH7WmLK5ZD2P2CU5ylTCWcY1LSpWZVEX0JieiP2TC+3d2DNYQ3?=
 =?us-ascii?Q?CychGKCYBWB1G7g99KIY4d2tGdyMwJaE2hGOHXhlhzcbhKKPh6+kW0DMtvoh?=
 =?us-ascii?Q?9bFs01P66J8rjnwMiGyvhTgZygNjyLCwOrJCLg0V?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fccc493-af97-493c-689b-08db414cf163
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 03:11:32.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHAMQU9jmTlxNfJN2HLe+NSg269nnG+9S8tfTzpQBG4h5Nwzyx6gB17vQuHftpjqhHlr308sdOYrw5qK2ti/0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

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

Geliang Tang (5):
  mptcp: only remove addrs in nl_cmd_remove
  selftests: mptcp: update userspace pm addr tests
  mptcp: add addr into userspace pm list
  mptcp: add addr into pm anno_list
  selftests: mptcp: update userspace pm subflow tests

 net/mptcp/pm_netlink.c                        | 30 ++++++++++++----
 net/mptcp/pm_userspace.c                      | 36 +++++++++++++++++--
 net/mptcp/protocol.h                          |  5 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++-
 4 files changed, 70 insertions(+), 12 deletions(-)

-- 
2.35.3


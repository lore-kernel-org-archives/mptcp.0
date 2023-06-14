Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A997F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/dTv/c/sdzbdvlhAc3eBLgjUP9QAOl7usmW7DJhxjOuiJrrqyhFK3kyh1+LDOSCwa1cMfJl/e9PK+lEUNUoGeR83bmgOxhnjEiu6vN1a5UvLrnRC/kkL/aS0X+bWhT1SbKvCZKUzZoy3mW9eO3wQ6gUGXlllO0Ncaot/W6R1AMkm/Zm0s0hGLyFca8YyzSVsYGVwnF4QOW0X8qXMWe3o4fCSa0BzMylngHby9YRuj0fjMwonT5pbxx0HwiHh/VpmQ4T0tXGrNnnhdgFouQ8CHWaQbApc4Ydv6YlLLdNPOq8BAYyOPHb0PuJE9COtF7kVVciqlz45DRYNmbOSe0IYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9GrObyIMyO1wca4b2ge1Fx16TYKc9ByHHmAvk3q6w4=;
 b=XEoxxc9DJ8uZI7CnGoxLVv5RI/RkIwEkBHaxunf/Wjj2+Efi921FsuLY+oZQItkb/uCW9vL3vOB3UDqLhWV28P6YCr1GpoztsgTNVX+DRcjv3oiVXOHpclydboE3D2aCDymDMikZxJw5kikMRNGAIXM2p53PsBbbi4BA9BBetltqEpblvkwR9SzDi2Hd6RpyZ9Lggxc1VhtYLQSntOcp8EsRi0vtmdMQpsSWCz0+RHxCF0eUZzI13geWKvYinegsXG2XuEvgxIxeRJo6NMwDBAPQvWgwMB+K1Plzty0/7EjKW099brL15A0d3qktoCTY6zWPcn4T20POmw6hG+B3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9GrObyIMyO1wca4b2ge1Fx16TYKc9ByHHmAvk3q6w4=;
 b=QnhYIAB03YkWUNx+QK3HkTf7gaMvASkJAYHCEUDQM1W5URE8ouWJrdtRmLQ2Z1I3A3lP4j2As8akDf1P8j1XauJLyqd6cWNIDqf0kC9CtnQpVV/tgV2qHc84fRyUwF167+T7CMkDnOIh5RDPBQvLsPfj25OM3t6C8wN5M+UcSqJqoamfl/Ec+RzyJumahxLQr0OPSwfysLedmMX24XYNDRZKvoO+67L8Fk5MqetMt/W/JqjVQmOcRksmSOlT9pOraoIxID+WW+STpJwSa56RCSGpMlxiJNfwIuXa8EtwYUarWuNkRZ2ThmOzHeQnXOYaFXLpE/kAflN8Ykx3TJ42qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:21:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:21:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 00/23] BPF packet scheduler updates
Date: Wed, 14 Jun 2023 10:20:47 +0800
Message-Id: <cover.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c6042c-9e9a-4340-b311-08db6c7e135c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qZU7M/I1fxgHgCc1cw4JLNTBxCm9GHG2wV96EPmYcG/PhRYHfeutCM0Bl8BKpkWjVq0MR+VvMIIBKwUmSroFxND/1qV74ag59v8DQN2h/FDZWG1JYKzJe/7b8GziQzcfEBR4AvhYWl1emG0RR3mHpn8U7aNJo7d8n4Yv+sgSsddhBoDvhnsIuEF5/wU/e/CJ/spZ8LGfe6eBIJk+HVgJHDLKBN/swJvq2rBKTKjJl0QkLap6S+9iUo7QRxOSmI90u590554WF0MdwEo8QFyiJ9TgJb1Rr095JGWIFwSDL6/r8+ralbUHZe3OZLaQGTWwGzj5n20v9OHAhBY4oq0Qxvr2zNe0ywL048HsDmUwZqAU6jSZQBgZydnIx3/6yUQpbDpwXsvATeixJ14+cK53F/r2pVH8SBCtdyWoOqrUafBb5gEDLBh72EZ1M/8xzTIvRiiYSOCcfpe3aWGh80IewbugjcT9bPndDBz9eoff9wzuYeG/8BRyV81xfAXwwtFVOUqHKj5sfMq1hMlCZhUjCWhrh55/ENGxF6NxRQ1GllWU4YsKu0aspPUPsHCalbauFlqXo/84c8uM5oGO2P8Bsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(15650500001)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(966005)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S6/clOhSwGvOa/khLaHHmK5sE18jCYaWNy9d0P2pMZ8wrK8mUlAGBeLRJKKo?=
 =?us-ascii?Q?msY748GjGwQ+NKmY9OAdIh5G/UZSNj5qyxLa87rs6ZngHXLtKcbKzvuagSWb?=
 =?us-ascii?Q?ZQ/5tv5etOunxqCWvrOI01H86C83PZSKP0h0bWcczF6dDoz4uAuiB9WGR2Us?=
 =?us-ascii?Q?eFUClA92N2HQrqNVFlJOmvk86KwDMKuAhRpOEnMBXbzP95VkfkXKxOrTjgAm?=
 =?us-ascii?Q?OjofeIOEtyxwkjixr/uUIM0NrY0mggvzEvYxa5TBQ5cNz6Roq6lRIVfs0hbI?=
 =?us-ascii?Q?NcpL/mioFbXbNzTgShoF14UfrNUY+LSmzVBB6LSTnkyZ6BOeszfBddqADYwk?=
 =?us-ascii?Q?sEZm4RD2BoNjeGtYpaz54aOQ8MJcvXRdz7reDfWCNqfq7PovE9oSjHPY+aGZ?=
 =?us-ascii?Q?AtccO5dqrOZMiRaoZ5fokuuNCglKdHPHTHVJQVKkch3KMar5dkFETE+OuTfD?=
 =?us-ascii?Q?g5247OvM5I2V7SuLKLTK4WG4gLN8W2xZyRdSzrAuzG5dRQI4SWlmvXKxOcJ4?=
 =?us-ascii?Q?puLz+KEFwOmTNOw2IcVcWDOpDzL7Q92Cj79ukeiliCu4+FbQ024vEW3CWRC7?=
 =?us-ascii?Q?G8hlyjydTqMnvPE0/bzez2lxHokHdrrJlokIalHOYXueKwTRmYvPVWnr7Tqb?=
 =?us-ascii?Q?kk6TsY3ItdfNJBAhgj/jxf0smCfql/5Z6p6jOJ3gVhm6sVD+SgA/xSEirA3h?=
 =?us-ascii?Q?BLreaBz8qoKLAl5U+jHXxHXHr8BP8UWlZKSWFEsAQZFSrlAvCZxEBVs8LMGA?=
 =?us-ascii?Q?tQvZeBiS/15MqxQ2HniQqwwQrjOgx2RoUgxSlBsgu6yItgcm9sV+K4kgM+E5?=
 =?us-ascii?Q?F/Fki4feoohW1E3W5iuwJJeXachpme+K8qMnx90hGrbvfnwJvXY+K8wCZ+29?=
 =?us-ascii?Q?V73CGd3l0XYwcL+4bh60fKb1Kyw3PuZ03NgBGJ61xWAUqlxpmLpevBXtnLFe?=
 =?us-ascii?Q?cKid9FyG0lb1KxLrV0gx+RbNBK7DPRyWeJ7INWT59LvLAf34n8brSTesEdV7?=
 =?us-ascii?Q?TPa372OGV54KItSB9YIfQZqGsOPR89xuNVWQQKHhWAEm9nFe36xo8kF+EeJQ?=
 =?us-ascii?Q?7rH/OdeLtsPWjw/bEbaji8Ql7ongPYIMl6JYNsCU1MB6zly8Zbgnl6AllR2J?=
 =?us-ascii?Q?Yp2FPZ0Vd428G84YWUXWgWrSq7LHZckMmSJ+ajT9BQBYoLRwQE4GSLeq5Uv5?=
 =?us-ascii?Q?pzwsc8tnxtKhN1QmTa2sghtNP7aRPE0TVMV0LbS4W9tUTY7PqK0dFmWQ8+pg?=
 =?us-ascii?Q?tXca65IIn00KKEDDcjzsmoFF4hMlxmo/8ifsxJ2R/w1q0pc6X81q4b7T5Wbf?=
 =?us-ascii?Q?IGFx1ummd9aS7RYF7kDgEzgEDRNv0EBQezF7iNQiiNYoz844x2t2zR+70VFJ?=
 =?us-ascii?Q?907cFWG4OpWyXEMy1QwhBjbG7PAAtTkyOr7N2Wv6Fkrw1l9sDouleIspqtp4?=
 =?us-ascii?Q?1NYGsQOyiekuGX+jPXOP7mEYkftCi1FYK4dfrRIR8kz69qKEAfnAqOTGRY0o?=
 =?us-ascii?Q?I0MRO3Xhs1KBH5+gBDO2cImGB2kv2+72bHskOXDIRAOwF3Xl9TnRubkTK6OT?=
 =?us-ascii?Q?Klt41W2j59UOl/WywsCeh5B3AYwGR9/1CuejEwCw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c6042c-9e9a-4340-b311-08db6c7e135c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:21:35.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sr1+FbhpFEQPnVfmkLRXMM89IfnCONlwphlSi9dayymyotq/vyHO2giz0l7DtquMm69KguUwBSQ19r+H579eWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

v9:
 - merge 'Squash to "BPF packet scheduler updates v8"' and 'mptcp:
 make the contexts array of sched_data invisible in BPF'

v8:
 address Paolo's comments in v7:
 - add sched_data into mptcp_sock as new field, not an pointer.
 - drop rename __mptcp_set_timeout, export mptcp_set_timeout into BPF
   context instead.
 - add a comment in bpf_burst to explan why not use
   "ssk = send_info[SSK_MODE_ACTIVE].ssk;" directly.
 - move mptcp_subflow_tcp_sock into bpf_tcp_helpers.h.

v7:
 - drop more last_snd, only set it in bpf_rr.
 - 1-10: save sched_data at mptcp_sock, for issues #342
 - 11-16: add bpf_burst scheduler
 - 17-19: add bpf_stale scheduler, for issues #349

v6:
 - Only update patches 14, 15. Add a helper bpf_mptcp_subflow_ctx, fix
   bug in bpf_burst_get_retrans().

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

Geliang Tang (23):
  Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched_data_set_contexts helper"
  mptcp: add mptcp_subflow_ctx_by_pos helper
  Squash to "mptcp: add scheduler wrappers"
  mptcp: add last_snd in sched_data
  mptcp: add snd_burst in sched_data
  mptcp: register default scheduler
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  Squash to "selftests/bpf: Add bpf_red scheduler"
  mptcp: add two wrappers needed by bpf_burst
  bpf: Add bpf_burst write accesses
  bpf: Export more bpf_burst related functions
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test
  bpf: Add subflow bit flags write accesses
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test

 include/net/mptcp.h                           |   5 +-
 net/mptcp/bpf.c                               |  56 +++++-
 net/mptcp/protocol.c                          |  27 +--
 net/mptcp/protocol.h                          |  15 +-
 net/mptcp/sched.c                             |  65 +++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  22 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  76 +++++++
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  11 +-
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 189 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |   2 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |   6 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  14 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     |  65 ++++++
 13 files changed, 494 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3


Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5F46B6
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ycil7ioCk8r6vG231D0jUTQHgpVzr1265p17hIvNc9oLcH3pUqN6jltzctUgIWko5VCIfechemm/DsWnQjsimSBbTtQ2Ey5BUlu8S4/0y0ugj1N0AfAhdhlB/zBysAbs/KxcRwgH+PyfTkXFbD3SMZPARHddBWWf/PLuo5rWvXA7Bt9MITINbLQY4Hg9vLdmV1Ec6gbZ4N25smB1NufLVLMRu7e1J02e4sxU9UduWiBnX0e8PATe2vwD3898BFAauuSBNBRCvipq+XMMVXxM0DTXjqN3sw14/AopGhUpv9o0JMhO62O0gbyaUEGKY/UCYwSHo2pxEPuBTpnf/Tcv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60qQ2RuvpirS2nzQq4kojOv+w4cBjHbceoDTwVuNs/c=;
 b=BDEiEomfznsagzO/CuXGd4ZVqcFUd8jzkEyMnnsDW2rKgfX+MaKIhU7Dw+1t8p0sy9tnUz/4T/uImUB92kX+2GGr1Xa5xAVoqA+rbk88pe1bmoHclPk8COW70jHgcBLzRyjDTYH2ebRI7rqYW/gMZhEdljQhOgp0v0NbFdAcvkDp3aOfBnfxM2/GBOhw0WqTBf91k4Q/YuobYgN5QFiS5BSt33b5cnh5YhXZPfO2DgDVhk/drNt437l43KmVjVWrdv3tFvhaM9IzG2FJf3tIR8HZm2ALb1OwFTBSVsAiy/5om3SiaYMTwGba6P/Z6lk8YaUjo2Yzv8pAQ3U9RE2njg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60qQ2RuvpirS2nzQq4kojOv+w4cBjHbceoDTwVuNs/c=;
 b=gH2v3Af6p9+ZXUmxOE9ySZ+cfQHNeHK4Y5fxgOzwdKXujzG+aUc8EfJvfPqZUS6a1JOaBXAHJ1UclwDYemqU2O/XWelpAqctkyIT8G0SUSxFB0QITfPSRBglna6CvUB4e6Oejl3RA9SeG4dNYKokDNjOZ7LKyQkdCMwlYp4fgLV4XC11rACI0nuDryRe3jL/Id3knYeTEyw94+gs3eTPtu+PA2PBoSDGoQu2xbs/m+TGROBuFHVhuqt4APio2AvFxlAEhue0V3SqeYJIIljEo3Kh3SDvZvGqLrhmgfsvfgz8x4iJI6lK6rxFZFHGWHTNXbwh2+xaQtX2fw7ztHkorA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 05:47:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:47:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 00/17] BPF packet scheduler updates
Date: Thu,  8 Jun 2023 13:46:38 +0800
Message-Id: <cover.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0133.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: daeb4b34-6ac1-4fb9-6e9a-08db67e3dc0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LWcl4LkpNyCIh92Z42UUBwiWyb1mNmWUbC5lszQKwdmGyQh36KeARjjnKvB8GS8+4v4QjjMj/EpZV21NbLUjQZMR3Uobck43z6D1+YEblcNqn95qbzW5SLsuXZeGV4vqWso5rbwhCEpnkhFNFNHgDPgLmHD/vikx18Kiuv5AZjUWvghTdo4eC3fj1LksTjOaoIbacLD6L8P4Bx0KKs19ehE/WzoUvMYzR4DJdWOtDsMBxZ5rvdoXxuy4RIi2CJqL4SfxnHJOaMRdKhe72MQMYHoIwgFdlZi23UzeCrrxroB/u4UDCGDyeLBC6HJb4X3vCKUCdfsdTraDJBGHruaAl4K+CKj2GtwK6PDxhyfiYXFykmFtmg2vnYJdbWW5fIaWmSuqa7LZ/DQO5nr9NF+8ImueQQzhJfBvDVzhq8LSXvapXASSGv3eH3Sei6wMoZJjCtQAlO7ovGLhBetcsBZPlWV+RgcR16nQx682P+V6VnbGVZySmwBkO4YsVl42kvIT5Jjc5eFixTbQfngjRC0iwUpuMkc5u7QktNitSZTzrPrqFYivvSSb3Mvwl8Zt1iE861x1zwJ16KW9KNHDbKg4Rw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(4326008)(6916009)(478600001)(41300700001)(966005)(316002)(6486002)(38100700002)(186003)(26005)(44832011)(107886003)(6512007)(6506007)(83380400001)(2616005)(86362001)(15650500001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xZ9Lh/uoh+w3KicFfhK+QfTLak6ERtde9zTl9u9NNGR7nF0PNrZAIZ0dBP0?=
 =?us-ascii?Q?+DuM0YizBJ1E4rV8M/mbwKztDASsLCDQpx38Ypk9sjHJEczndmiOxm01DMOZ?=
 =?us-ascii?Q?CtrcFrNd55ZZavqczvvlfT9SAiH3N4dyNblv5WjpPO0IeZL3dmd77um3HAyi?=
 =?us-ascii?Q?4XluGPYixrI3sLVy2F1HqPtuzWhhYBovmmiV2Wcw+iEWuL2iRIsLhDSzn9fe?=
 =?us-ascii?Q?y7gJL1U4wVfeC4yTtFI6s1OaxgA4eNMDslt+gDlrOPygEQnmtW4XfAV1gUr1?=
 =?us-ascii?Q?1TdAzxoLAJZOcIWxLclJqNp2NleX7fqoHAdlkPPfVAZgz0BOqILHbGPG+Jg2?=
 =?us-ascii?Q?w1TbhK03AD6EpssM+kjUDYXI8w3WyJfHz7hjtTelYU1FzKihvQ86o8rRGFxo?=
 =?us-ascii?Q?4WzS4rt47hLnQcSokeC9FoxxEjARfoR81qcX9GqwJU7vVuK9rFELZ1uiaYo7?=
 =?us-ascii?Q?fX7hZTco6A9iAiV9XMzwfgIluM+bmjzwFrM1sczT/SFFKyjrQPwfPJlOJokC?=
 =?us-ascii?Q?D++WDjLlZAulYmAkPKz4mqg9iLS0TcABIIRp4aQienWWlpCiGjFSsZ/JSjbH?=
 =?us-ascii?Q?LVNab00+xCkZkFVmMl0i7kUTOXoBVLL8mgaAhXgurqDRfhitAtmYdi/J6gIl?=
 =?us-ascii?Q?cCf1L47FfwFOAIcqPnBZZwJaP41Hk8n/PRwt9rpSngiSH9rjO69/gen6m5lE?=
 =?us-ascii?Q?GajMEAaIV1eZlodp1NmB+F6dzTDD8jGSBQfV8t/jGwSlDz4t/AeKRW8xaKzY?=
 =?us-ascii?Q?/SZMqCHNeYjv6anfhpLQYigkdBsjifYcOrhplodXsJLdojVbDobQrPqiB3VM?=
 =?us-ascii?Q?TQeZy+bW54+setH4kqbmXYwlrX7ZAtu41jNNORYQ2lqpxVa8Lm1N8V/plWQH?=
 =?us-ascii?Q?z8xpnq8ps6P/kn2D70/y8jXByRsDfTn/7WMQ+euP/vfQu4gsYvMpsA8CKgLW?=
 =?us-ascii?Q?x3k2bYsRC+xoPYfjy/54NOfy71mKJuKcylgVBKYJvtBDRy6Hc9VBeKDZY654?=
 =?us-ascii?Q?84YL8YQ8jbO6p5o6VaTp0neqvfnxwIyrjA0bcEE5jQzp5OEchxllYMS8wsUU?=
 =?us-ascii?Q?+SFpYkHma4UG09S4CI4bnIJVduoY6FoyMCgZ+0DCu9uL/LVwP3vWd21KfBMw?=
 =?us-ascii?Q?pw374XCwQk/Jg8lly5DlewkMoOAIc39VB64MxIMBUSqbL00haWh6H8OsCNAK?=
 =?us-ascii?Q?gMcipgOhUKuoUsd89vemHa3TTu65ilGjTOWNcF0lrIFc7B8nvJeccsALpObu?=
 =?us-ascii?Q?j7OVOy9hCxmVVmum0/7ow2H5A16RA5jaT3GYLQg5Sw5fvJdBuK3MCwRRnv1O?=
 =?us-ascii?Q?xVvet9PSE3uwEnXAPpKNvnAZI9ZOvE+E2xAHwKmp8Bo9rthYg3dMAumx/CaX?=
 =?us-ascii?Q?MuOWYbg4sVayLh4s/zQFGAZLabNDbu9AP9XsinFw3dGn4+IKUqXCpcjJ9yHJ?=
 =?us-ascii?Q?Dm+MA7TKZ+KOv7IEr6BXMYjKK2UxVgBerZCpT+3mAJ4MlNBzwoHLgP2SgZk0?=
 =?us-ascii?Q?SxZy0Ig7Wwr/w4WdP+DQelU2DbrY33kbcyWmQF/ZBtYfU/2VHT1C+FX/zSgK?=
 =?us-ascii?Q?ljEToYcibSC9JMb8xHV9ukH7UfKy3kL1Go0FGXKa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daeb4b34-6ac1-4fb9-6e9a-08db67e3dc0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:47:35.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8wZGVWa4GSN2HvIv0L1mZrXl/EHLkBCh+DX1N3ItgAiU8Ip3cmDfGE99dhe7Iiu3hz2M3rgsYOq78RyNS9ftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

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

Geliang Tang (17):
  Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add scheduler wrappers"
  mptcp: add last_snd in sched_data
  mptcp: add snd_burst in sched_data
  mptcp: register default scheduler
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  mptcp: add two wrappers needed by bpf_burst
  bpf: Add bpf_burst write accesses
  bpf: Export more bpf_burst related functions
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test
  bpf: Add subflow bit flags write accesses
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test

 include/net/mptcp.h                           |   4 +-
 net/mptcp/bpf.c                               |  55 ++++-
 net/mptcp/protocol.c                          |  27 +--
 net/mptcp/protocol.h                          |  11 +-
 net/mptcp/sched.c                             |  56 ++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  17 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  76 +++++++
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 208 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   5 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     |  59 +++++
 10 files changed, 471 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3


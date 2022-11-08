Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABFA6ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMalu0oBFWgINv4eVaanUt9+89ZYjN7MjPzPinFuQv+fMn5oreoRo7qaRluNVmoBlVjQJApdNeUwea8ojA3j7z9+g16gXH7dw31Dsig1BGTRL0xapZm23NLMT9hLkf02vYsgwKbHTkIjw50fYMrQrLJ/dMrDeW28b2gp4c/XFlbpnrhI08y+tbTuJtyGeS1pPe482v7khGOHChYME0dFpMwkhMyVOBuPigqOZQO3TO8TfnBzz8JCrNGuUPPKIkWUHPXUpuqGekaDwSS1P1pZ6A/yXIZ4CzylTpwvFMd1Bf1EPEboW+QXcIPNghZQJkwCIP63J9qrYPuN3EW7jNj0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QFNLFm54dfl8hfj6rT3vR2vArqX5S4CQaKszflDK/M=;
 b=Bgq9ralzNjGeXXlN6qXhHgetCw9hvt+nZF+U/YloIp+pryeZKYIIgX738r1klzJuT1GSNWm8nry9fOVV2JypUFh38Glr8NGD5lJzcFWAVsoGh9MsibFRjErSshAqgIdnyglfy8Fu0xwk8ykEMnuNaZyArBL+LixqamA0aXCk6utmg8KpiJJ1dZdfA1wqIE6UDlWEhYfOS0hXOZgu+oOmk3U44kqBbXoP72Y+wtQyODgR7s8pTyaZSos9TsFVCLNCRSiXIl9KTTXC+tnPVAjslU4t6+JXkNzQbMSpz8EeyildqMX0+uFLmNVgb8yVcy6QCrf+DHJFixLVVme2Vp/9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QFNLFm54dfl8hfj6rT3vR2vArqX5S4CQaKszflDK/M=;
 b=SGYrG+QhL5WU19KY6T7Mn+6J+RxFD+yaWzwgxkJHU1/eKBwU69s58UiE4C1rLkXBfsq+fFomyHhV/KLfSJPWtxj2gehYO9LuM04jBZ0PnZ9i07+jZPY2wJOg4bsqRtWDw3H0AG3RHWSVVixe0mY+/Rk3wCmmqJ04zcqNk3B/2nrMc9B7QiQcmWMVLC2a+J8aLcyAILaxP48uDIQq/sP6lF/DUQUpS0lTReBm9jnbHXs6MwNEVVpQsyT8dWqpxmbL1Qb0bfWFDUfLdeGs1jIRBpDcPYiBCqt2zL9VUwGSwS6FP87M3MAJZFkMbY29rJWQAs79Dxk7HFnEISmiLA8wfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7453.eurprd04.prod.outlook.com (2603:10a6:800:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:08:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:08:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 00/15] BPF redundant scheduler
Date: Tue,  8 Nov 2022 17:08:22 +0800
Message-Id: <cover.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VE1PR04MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 1175c297-856b-402a-0e83-08dac168cf21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	930jVVhlBmt2tN0w052jc/78aizHGyj8+5FrYkq81ksVzzziF9YikIntQgVC9dNJzWcl8/gwYtVemmhN2Ex7sfbEwxFGRUEdM0p+SfdlXU1T19Ott45lO+2NOlD84pklwe1XuEdVnvwq+avkr2jl2/7XsEsVJpYpY/iK3/YCXXhBedQoi5nn1h+bBZ2l8I0FroXEVA/8qoBRJW3sDeFfbk4N//YDcgUuHaZK+3lh6Ika4gjjaUGgIyeQKN0VclzNw1VJ7PoMtTDaLWgO7ZjWKhY2n3pzMi3DO6IxXXlZLNn+XjR7Rur2smOg47Ve1bw2q3RZnjkMOZ3zkbx3Ub3xjWnNK0GG6KL3hN/t+fWPV/5W3uCBZCtVRyAccfDcVuEVpgsNxu1OltrZX6AaQCA7tkVL9YP0yQ7cVkpppslVjdBEjWEu6YWJw9lJKTKewHyaL7e39qjuDFAIU6LalVbms20de6mEHqQlDMM3hrvENNeo+4vG2lblsW9qATZpnOmNxz2fcUYDowDrafMh4sY5jBXQh45LUiG8zAET2MQiZegveGju4vuzAnqZhTm8mFs3fgshlDVggS6yr+gtgpNmCo6qh9X3SyRkn8GjLt9AFn7/Vdv2Lj9jqO6O8TxQyTLceUmCMNpzDXPNeakNh4qN/INLHnAqrKUjHI6vbdK85gwjao0fLQ4/hsEEz7BfyI9rrOPbfAVmbyaoxcZs0NvXGpayq8w9As/TPUz1Gd+Qod2mKLOF+ZcwhSiqhtjL2lwIzI5jiimykTJ2IpkCEqVnAW5Zm5UtnC/1phWL+m9/BS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(66556008)(66946007)(8676002)(4326008)(66476007)(316002)(6916009)(2616005)(8936002)(186003)(86362001)(38100700002)(6486002)(5660300002)(41300700001)(6666004)(26005)(107886003)(6512007)(6506007)(2906002)(83380400001)(478600001)(44832011)(66899015)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rJqI2eEVL/XG5pPwVaDy4gG+2Vljfj247UQP8Eqd9mQxFT5ZW47MaIolr3dL?=
 =?us-ascii?Q?irCcFmDJ+yG8K78ojnaOQ3fO6+ZR72UwgfQ5nnfZgrsxsXUEtPZZKPKHQVkh?=
 =?us-ascii?Q?5beSDJqO/4LJJLKXpbrfn5cfQluUaaBC36sXhknj+kOyTHJ+UFxmuWCm+VJP?=
 =?us-ascii?Q?IWJotAXqIxf6KnHYlR2cOoN7qnoB9W1HO7IWMe01LJUdljeA0TSgMCk7UhGN?=
 =?us-ascii?Q?dFju/4cBHkG9u5VPkr0EkD+I12VIiR9u8rD4E4jlVnvz+NgXjY6bLueMVsET?=
 =?us-ascii?Q?tfetputR3jO/2G5bcPwMarDxXl0fNfljFq4C1TQKEmlAWRM2wtRK2GqSjdsA?=
 =?us-ascii?Q?b9wIQdU79CAMPFjDhWS4TMT0rAedqGs9PThr7PVrcHcU0qoBDYxG26vWtYji?=
 =?us-ascii?Q?I4gbrscljO4aTpvC17x6wq8MH9pO6jmCsntA4DTQNSjl/DYtaA4rfdb0Vfld?=
 =?us-ascii?Q?f8M58e1TONlZ+ht8qpber11GkQiS1KsWPthiie5QYktl9cZ3uJkjbg29CokO?=
 =?us-ascii?Q?aE25QOs71k2j2kF+sYTM+A2owXSpoPy/5sXkpsAd99HNX+GlPTZjI62e6dBu?=
 =?us-ascii?Q?3TgPNLfdw3cka3UdE8aWtM6njEDsMgUblwXn8rmvHtlQDrJYDcyA5bzrv0h9?=
 =?us-ascii?Q?roBT3R0r6WX4Z5BqaY3nqZwE32gECfFt6hgm/Nz37GPdc5XMEbfWGDOkzUTf?=
 =?us-ascii?Q?Uvs1ca3SgzWIyFfpDkY5TE1pzFwbdxApi7IC+dDw7UjohJxbwo4OFH5C2i+7?=
 =?us-ascii?Q?zTQCimPS4q/DI5N8yqkQjcx6O1v5lmz+eEvcyK+L385ZtsNCeNAi1BKNuEDN?=
 =?us-ascii?Q?9bxP7RcCKRUtk2ytEL0Rq40tYSQ0GML53fsx9fZ14kt7NTWJqjhyMyunTApF?=
 =?us-ascii?Q?J2uvIrbWY6aOg/RHcHFiW2UBUWoTtO9pm8f0jn8quYDNczjd6xFBhMNe5prt?=
 =?us-ascii?Q?1j8USCl5MZjyUvq3genpUYZ7rIoXXRZ1QmBsk6xHr7nEqbgNpNHleAMZ8fvy?=
 =?us-ascii?Q?im15a2jLFLEfSSny91zJYYu+3MwjVWZhvinM0QKTU18qm1qOoQHCrzo4tLh8?=
 =?us-ascii?Q?PtkzOaghIzHwnLD/KyWmkCPQE2+2vyzYNb0LXja6Y0L9d+c1+0tin2rJ0Qwp?=
 =?us-ascii?Q?NwJnZR8EgLHmlHdkYBFGrZDxfAGzUBW6cXBqIpcyG7+XNZLi4S9RxCe8fYGq?=
 =?us-ascii?Q?RLQj0KF/ErlkTthgfvtS/V6uwDgUzGM8jXDv3OXxpnQ/3AyeGcBDHEnicHRx?=
 =?us-ascii?Q?akRf57GkRfhMfmMS4KyRu9fQaPJ5LMKchVeNjLuc6y1Ns2eZ+suD+sfMlMvk?=
 =?us-ascii?Q?jHuOu4W2aBocrC0F8mzbcsLFq3KT2YGwd/ClzW+Qd6bqQTdhBBtN0X5CeLDz?=
 =?us-ascii?Q?Zjyk/TFWQLgj12lGMuPZA9/SWZXkcAuYV2kbP6gIM2smQJ5IVgIQElxYuyu+?=
 =?us-ascii?Q?UD45ezeQE4+ZEKinDhOLaocwKaeu5gN2yxt6CSYuQrGdUXWcqysbjL5uR4n5?=
 =?us-ascii?Q?wnFrqnYShldulr1HSbm+QaBpXUSdTE9/to2HlXyezBIp2WE+Qmmv5Ba8Dho5?=
 =?us-ascii?Q?A6G4dLJOPW+W9s72/gP5/gN6kO8vfHSHY5gnQcor?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1175c297-856b-402a-0e83-08dac168cf21
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:08:32.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Sm7ZQDSmyrfFNxqrLbKOP2Xy/G2j3gMu0euyK1Ylud4yGWoR7jE2mSjYAqQzui6PdSHRTA2cpiQFAPg7BH7oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453

v18:
 - some cleanups
 - update commit logs.

v17:
 - address to Mat's comments in v16
 - rebase to export/20221108T055508.

v16:
- keep last_snd and snd_burst in struct mptcp_sock.
- drop "mptcp: register default scheduler".
- drop "mptcp: add scheduler wrappers", move it into "mptcp: use
get_send wrapper" and "mptcp: use get_retrans wrapper".
- depends on 'v2, Revert "mptcp: add get_subflow wrappers" - fix
divide error in mptcp_subflow_get_send'

v15:
 1: "refactor push pending" v10
 2-11: "register default scheduler" v3
  - move last_snd and snd_burst into struct mptcp_sched_ops
 12-19: "BPF redundant scheduler" v15
  - split "use get_send wrapper" into two patches
 - rebase to export/20221021T061837.

v14:
- add "mptcp: refactor push_pending logic" v10 as patch 1
- drop update_first_pending in patch 4
- drop update_already_sent in patch 5

v13:
- deponds on "refactor push pending" v9.
- Simply 'goto out' after invoking mptcp_subflow_delegate in patch 1.
- All selftests (mptcp_connect.sh, mptcp_join.sh and simult_flows.sh) passed.

v12:
 - fix WARN_ON_ONCE(reuse_skb) and WARN_ON_ONCE(!msk->recovery) errors
   in kernel logs.

v11:
 - address to Mat's comments in v10.
 - rebase to export/20220908T063452

v10:
 - send multiple dfrags in __mptcp_push_pending().

v9:
 - drop the extra *err paramenter of mptcp_sched_get_send() as Florian
   suggested.

v8:
 - update __mptcp_push_pending(), send the same data on each subflow.
 - update __mptcp_retrans, track the max sent data.
 = add a new patch.

v7:
 - drop redundant flag in v6
 - drop __mptcp_subflows_push_pending in v6
 - update redundant subflows support in __mptcp_push_pending
 - update redundant subflows support in __mptcp_retrans

v6:
 - Add redundant flag for struct mptcp_sched_ops.
 - add a dedicated function __mptcp_subflows_push_pending() to deal with
   redundat subflows push pending.

v5:
 - address to Paolo's comment, keep the optimization to
mptcp_subflow_get_send() for the non eBPF case.
 - merge mptcp_sched_get_send() and __mptcp_sched_get_send() in v4 into one.
 - depends on "cleanups for bpf sched selftests".

v4:
 - small cleanups in patch 1, 2.
 - add TODO in patch 3.
 - rebase patch 5 on 'cleanups for bpf sched selftests'.

v3:
 - use new API.
 - fix the link failure tests issue mentioned in ("https://patchwork.kernel.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").

v2:
 - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
   scheduler always sets call_again to true.
 - track the largest copied amount.
 - deal with __mptcp_subflow_push_pending() and the retransmit loop.
 - depends on "BPF round-robin scheduler" v14.

v1:

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

Geliang Tang (15):
  mptcp: refactor push_pending logic
  mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
  mptcp: add sched_data_set_contexts helper
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  mptcp: delay updating first_pending
  mptcp: delay updating already_sent
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 include/net/mptcp.h                           |   6 +-
 net/mptcp/bpf.c                               |   1 +
 net/mptcp/pm.c                                |   9 +-
 net/mptcp/pm_netlink.c                        |   3 -
 net/mptcp/protocol.c                          | 335 +++++++++++-------
 net/mptcp/protocol.h                          |  19 +-
 net/mptcp/sched.c                             |  88 ++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   8 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 +++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  10 +-
 13 files changed, 435 insertions(+), 143 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3


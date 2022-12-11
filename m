Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BA10E5
	for <mptcp@lists.linux.dev>; Sun, 11 Dec 2022 02:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpN2gG9MYRxT9DFX25a8WTz2Nd1OgNEpngGlVQkp11A84IzS76UnUzYxhhGRj3+KCWZcIHBpu+x4lsZ2PQXgj9vh5UO8/Ej/4ZKwXNns8C4mdouaMKn96rS1sgZEKl3S+6cFXD4JWF0QpFVlj+Z2H11gEtj73x11mJvNNiK19tDDsqb3jl/n9hMbmNUQdO18as+NKZwDBtKHjezQYJVVCT1qCKBUVQ6+YyJqn08HrWxvhg6UzQD3hufAotMLIMRaSELUCtqIClrXfwEG3SYPOyvtJuwCEEbYlyx8UNVV2xg2RdbeSHzNbsZLLvDNpaALH3q8gDLRQlR4vBtDTkqgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaRxAFyff5xCWP6pgntT5YAOimPKzXePiIwD6EL6Xco=;
 b=kHJjkuxWZ5xVFG0O/WZDzbCnf16uJs+rG8PqWHcc0IAaDK5KBP5yjjN0NlHAni/M9K9IrlvOREhjEAI8BpNwNqXfdJo5jy6HopnltLIhIEZFlrfcUPuyCai9EMnxDuuqo29K3GWq2RaDW2f0ovkJ04JtzAqUcw1dojzB8Svi1ZSW5+v5vhyHXspzQiE9RBndKLCVnbUKFOBYjn5CnZKIqkbfZm1lfUWcmiUqwr08HqvcUsnUwwHbGP4BkGOP7WFxRp9HubLzyjcbjOSZ80HGgA4G1RuH+/xi4tN1QvihJYzw3ceToDKept0KJ2+DIJOymGtN/fJbaKW4sr4UJYYySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaRxAFyff5xCWP6pgntT5YAOimPKzXePiIwD6EL6Xco=;
 b=SUCj+8ktA4DWUsX0wbHBPEqIVBKRYdW3FXbNOxJkgg8ltoGSJOoCT1zJ9eASJEHkMDQLOOHrpHeQ+nDHznUHV2d3pgWk4sGYlLeTXife+hM78573S3XYNwBR0IHoDG0lHnXxpNNyQzHTSm1zRyTbE+IEfWYyxtKEIcdgUPlzp4rT0YQWp7OXGjLD6oW/+W+Pmstgw5SvhpZMsth9ow/GRiIBeTyDoDt6HVvqNbxOWYGGwfMPoAtg2MYckhXZl/eSk0KrfLtj8wQvtRvEPD0f0pchJXhqF71Q8NiZ84gAObNioas6HZteQsT3tw4qw/CFWIk00cNYrKxhlVVraU4LnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 11 Dec
 2022 02:00:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 02:00:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v24 0/5] BPF redundant scheduler, part 2
Date: Sun, 11 Dec 2022 10:00:51 +0800
Message-Id: <cover.1670723836.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: cb495031-fdc7-4c1a-09b4-08dadb1b8907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	llr4nXALj/JV1EuHjKFkfPRzgZ3EyZfJdDb9C266tl45w4hHLe6SnDIC9Gq2RyKj73qszkFLkCAbdGRPdr+pXCD2hudV4Qwfs3baItGYbQztcykFh97Qeq9DWTJOSINuQe0c05Q5LYPcOmzF4gcXz3CuoC7rNFkaSwK0rulxK4fll5v75/UWSYZA67BgZHl1e9P3zQEluG9C005IZ4oLpuJdGE2SSU8um1B3hM5SaP9UnATyw/PRs5rWkBl9Wv2dsI/h4w0QXfPNFnQSF3QB5slPUIKdxSEH6TUkAYdUe2uLhzyQZ/JkwArYEnQn3/UP1h95S3BcosZ6UYJgFMn5XMWrReUjOV/DRX0y21Q1OziXqfkNw4RWlNRMl7VjU34vdExgknXNX4niVKTVxhH3ff1fXPYvJZlggvaImqqs+Ef8vRMkDTYg/5HzM2BKGIjR6yVp2w7Nd2YXKKWAKfPmpEJGoHWEwxZNc9lakIEaYoP+KbBTP/wCMfTCpEoLChwq2np0eSpe0H/CEKzuxFMk6FdsCB3eEWKuDdoEmmF3zglW0IIVtUQhtwzgwGdPWTiwLLLllnjmQfPwaFzKkgLBYVQw1SGCpXBCcMSCX8WU6YNA4o1Ic2vNNw2iiBwLf6AT2H8ycpfZMGTECLbpzYRhlwe3W0zclc/+cSlkqx6Yc3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(8936002)(36756003)(66556008)(66476007)(66946007)(6512007)(26005)(6486002)(2906002)(186003)(2616005)(38100700002)(83380400001)(44832011)(5660300002)(6916009)(316002)(478600001)(8676002)(66899015)(6506007)(4326008)(41300700001)(6666004)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xeq4ZNEirxLC2wpGLERfBtjTrhrcca/UC9SJ4awNIQct2JOFiLUbC46GWac1?=
 =?us-ascii?Q?y/0+zR4t07FO6c+casDc+2blg7Awql8DF/kHU2nFLUl5CI7j/HPN4BuiV73J?=
 =?us-ascii?Q?QyF0os3j40xfiuZps3/11bLcAxO07yIuE0s2+xlozKkNa3KKfYIdto2xp3tY?=
 =?us-ascii?Q?c75FwzNWd0/Jqry7TKDNK9Izz86//TN8xBTNuval8KSKeh9wX5ZDlUo6MpVa?=
 =?us-ascii?Q?GBNYhHGiXhGEiKzemUkDQ5/JZ/JH+/8EZdWFPxmVwvQH+LegiSdapAyUb4R1?=
 =?us-ascii?Q?zUb4rx+r12lqPe51WjKYeuQaEGTNJfypjDaUYi3kUUxPcF9X9petiPbBahnA?=
 =?us-ascii?Q?Iu2JJcctOirajlcFoghylv0yQEzTTtfnNz7mAol0I6kJYncCdxj6tBYfbcr7?=
 =?us-ascii?Q?TLA/9gG+dNvsn6Uj1elybgY2YbI9Qvo2B2wtfFRF8+/f70iiQqSGHWF4/rQx?=
 =?us-ascii?Q?ljnOKtgaJ81ZnuqvcaUeUSYjt/Qi3/FFWAJrYcYMaWLBt38dzAspft+njvFj?=
 =?us-ascii?Q?aYGzRSzywIhJONw0fM1+JnDk0R1xG1ZOwedCrAegLroEuv1ZtO9NjwWKJr57?=
 =?us-ascii?Q?t2T9BOqmJCMBf7pimhc73C598GnEAu3xHMmUtiX9gDKQkCgD2sdq560UEptL?=
 =?us-ascii?Q?2oC+FRrKLeGajcKYd5SB1IZEuxolUNSIGT1phb64lVGc11Oy7VVlMOBuEv0+?=
 =?us-ascii?Q?wkdzJJHVv5Rz7GBi9YB6XXTuLCpVckaAnJ0HzGnZjvUkB+VuGZ3e/UpnmMS4?=
 =?us-ascii?Q?REsDRAskuNyHCXHfSjqWIEgdpRIcWo6qMDNU55VvC2czo/G28xDiKxOgjvg7?=
 =?us-ascii?Q?pHvN8sRvlk5ZIQio1QEuv5CISlZDQ8A1SR3WvQ3I98zFEWFoc7YG8DMSKdek?=
 =?us-ascii?Q?OMtHu4mOHfoMtna2KZCt1LWOMxpkO4tv/wBvlPJdl98YzegHzRIDhqmXXlvI?=
 =?us-ascii?Q?xKfUAdTXWiNmusDjGyCk/RXX2HbUBaRR6nRmqmeLFTZAlUjfJeeRwvlmjyg0?=
 =?us-ascii?Q?b3H37lRdX+sFP3j4r4wtwjZUY8jO1ew2zLff4ESIISeqC4TdWh9SkEpIjnlF?=
 =?us-ascii?Q?TbtJshzq7sxu8VOceOXWHcRSqDXrFNqy6HnRpdycGrXr95E74TQPeXdgVG8v?=
 =?us-ascii?Q?FX+CyVwllgpesqnHKqDkB0aFKOuqPtOJsMI3/V2/Ol67RALfwjFYjU2XLQnl?=
 =?us-ascii?Q?75OewnT4CGdJl9Bz52+mhDW9qojXUkgGGxxgFFCVKNfXM0kiI1q+yfrTHZIr?=
 =?us-ascii?Q?8HH8+rvCwoRVZpqWMqs9tN4l3vtoNxSlR3S80b1ePW7VpnFqDl6Yl2c7TfiR?=
 =?us-ascii?Q?CN+kW60yuo2ez3UvloNxuQfk+/AvsbZyXvGfOACqVQPyuDXqII4aiTrKT1KU?=
 =?us-ascii?Q?FLN2/80eE8chaA92UpNrIiHjOAF8Zho8MVMfH2ymZZ2+yo2LlhKCBIDN1o6f?=
 =?us-ascii?Q?WRju5AES7i8ZGr5CQEPAZnXhfEqMCIh8DZt8NPrITQu9kWLFxXsMo62b9Q5/?=
 =?us-ascii?Q?3TwGb7LmXoamciovVnoRY0o2I+97slcbLsY0Ly0m0XowZGF9GVrnAPMGe5WV?=
 =?us-ascii?Q?/J+MEizdQ3MhzcVnLFJMRrBuOK1IqEqHQEspclIN7rxICkfOZZ6rd3sRM1Ap?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb495031-fdc7-4c1a-09b4-08dadb1b8907
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 02:00:54.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtLRAouBG2FNg4bSwkl6hmjjCh1DTVxRC4NGDzwqn1pOiZwqV03xHWYA/nGSJzNjk7BSvoQ/SDh1OKTFoyfFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

v24:
- rename push to keep_pushing
- check the scheduled bit on ssk first
- drop delegate flag 
- depends on "mptcp: use msk_owned_by_me helper"

v23:
- patch 2 and 3: clear subflow->scheduled flag on the error paths.

v22:
- update patch 2 as Mat suggested.
- patch 4 and 5 in v21 will send later.

v21:
- address Mat's comments in v20.
- redundant sends on retransmit code path.

v20:
- rebased on "Squash to "mptcp: refactor push_pending logic" v19"

v19:
- patch 1, use 'continue' instead of 'goto again'.

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

Geliang Tang (5):
  mptcp: add scheduler wrappers
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 190 +++++++++++-------
 net/mptcp/protocol.h                          |   4 +
 net/mptcp/sched.c                             |  69 +++++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 +++++
 5 files changed, 267 insertions(+), 75 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3


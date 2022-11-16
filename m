Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB057C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MY+yk2JJPoc9PCSG8PlnoQHYxY9lmiYOlAKy4zzUHFa7g0PybvOajKb3mDqpP+rLcpXutLeDE8rWkzizDtJw6pYgjZ2Bmhknwzq+KE7YPMoky7SB3HLl/E/aWblGpJf3EEP37HwaY+WcmKH+yUZRlkT1UpydCzCx0RJOdw3WwdshzPEgPnb6VfVALO46/Q5FpzAdmdH8ojzBlfiyTcYyZ5VecTTWEaGajtrxJj3yN8fzLvZG2fREALZiAelVABkBCEn+8V/3dKY4+p9maOERC3Dm8wBRGxNLexW4W534QK1BJ0J2iveXeGmucDDkZlE6EvEaGHbxcighmiGI51WepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwY3o0FTkVP5xB1aChZKexUeTjiEYHuWBWGW8AkOfFM=;
 b=LDvfMVL1O+0nQvXdWfqwTSl8l+VjmyIZn0TncenrLRTP8aQ4jneCsLW/TTTZPQ6uvrypW4LxamZ8xmdq40of6+gSNLQBzIVEk/hF20viz9O7wp1BpgIprak0u9mhwom6uQwZQj4bIGLSepjWjDXBGBBlGBT4yfYd64jyniuAIEarz7tO4bv3IYL3rZ1yb29G3DSbhA9+ZLo5zeUAXFL7UlqJaxxRAPKKh6k07lZjAzYBga5DDJy54en4bzxrri9Wtc+KcJGLp9OlqGtddoR+NDlLzmCUoiXkY3ttpzkgUbw0f4XjKYRlUaflJSMRmmVPWa+mtWecoItxImIv1I+OXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwY3o0FTkVP5xB1aChZKexUeTjiEYHuWBWGW8AkOfFM=;
 b=db7srPE8Cblshk03T4ZI+OIFz4PRhkC5T2tCItF5eJNf2QCRXRcDmgYymCoQHUD5a36pF+ttssS6r7ZwQ04qspZEywTcTndCSI4fpKuSHvoKaeE+j9wmMNEPdCDM1VQh9KAfh2b/RXNjDdYD8iXvFhFuGQ5q2HbEGFAxIQ+DFmFQxxYiJIIVbOXVQRipou+/mIOQv1tjZdLjj0VSKfMoWoBV61JkQro3CO0iUtyFqZM5F23hReW9TnDDiRNPaBUwLOm0/gpb7fbe1gZllMJNdgtlalWMvo1r582KL8ogGjjgWvt79m5XvbjnNfM7lW5GaUvtbpVVyRDdCoYawMBcGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Wed, 16 Nov
 2022 11:42:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:42:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 0/7] BPF redundant scheduler, part 2
Date: Wed, 16 Nov 2022 19:43:01 +0800
Message-Id: <cover.1668598782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e99b9aa-c67b-4f17-d2bb-08dac7c7b1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BTejKNFYKS+aIh5SEOfRmRihoKjJ+YnIXMCeQvrD/a5mvd2iynk+K/R3gQ5+WXCntsaazo2fXHRAOnriH6tBY+YsXs71u/c66Nn6MYg141phFaFPlDRF4v8WbQVwE/Hq+JDzqoaYeSdyvey+f3jZVl6tMhzG06jRAIJw5tMAQaOCu+lohfx8BEAtYj3FSstbZxusxbh5LFt0aMS4sbQCMlOnG8RCkb7EJpn652rK4Cx83ug3a/NJYd/b700BTwrVTaR3/8W5laYSmGIQ6plgYsPYc+YPwtFnXcuFNWBz42UJcdwQVAjHTSCOKjkSTE33DVkGXVm0Eayly/x16mYvYIC+XWK+hxJLPgAQBrZotYgoNUJgRccvboipECy/RQEPPn7mVyt//jR0JU4VKKxDXSZ3FTBVyS6y3eclDnS9mzMIZf2cMHEL/u9q2PUiA87iUnXSWGZjWGyfnnomEJkhVXIEAxAzA/nqSBlDaPEn9+Lu2hObmZ69pwNg9W3kxlaZFemQYEC8yx4BsC8nP1IFZ6tVS1CW5n7Hkh6hTtHao87lS757DoCTeF0rAF6l8E8DHmIyaINeTxrOb+ag84b5Pb66FMpjQ6XsaYfxa2RrDDHT4+gzNElghD7L+jowSgR8vyf7tfcYzy6+5WREMTuJvfFyE9bpWE2Hjfr19JjglLo2fXg3jkbCM1vlXoA6KL1y0PS8Rwh/PfgrW3rsT+0g0kCAmgrNjeyWusyjpyn7T2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199015)(186003)(6486002)(86362001)(478600001)(83380400001)(2906002)(8936002)(6512007)(6666004)(5660300002)(107886003)(44832011)(26005)(6506007)(66899015)(36756003)(2616005)(316002)(66476007)(6916009)(4326008)(66946007)(66556008)(8676002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Df44paNRzwDYNxVAIKXjShr5ZCJ/8gvVmj5WX7yo5VdYHYJvBixScgJnDfnN?=
 =?us-ascii?Q?0NgWw4sl1pCv8UwgGyBWJnu4aD93jNtMrLcoqlzl9XqEFbcFKugb8aDXGqDg?=
 =?us-ascii?Q?mjP2AJgyQ57SvzX50B+nB69nVyYAXEnE0wICX+I7LIeaTZvAHjAtpWpjpAG0?=
 =?us-ascii?Q?A848VOGOZA64vQaoFfeLxitngGFatjyHT0bY2F1jvLS08nMg/endi/mhM9U4?=
 =?us-ascii?Q?/gkpEgmH50w8rdaSMJgG1P+Rh7rchIeElpKFZUNmWNbRWfsdTJjtLCQ8Glg1?=
 =?us-ascii?Q?kU4hDuaBNWaXVvZUplh3k2JtTTdwLkQIVu2afVBg3yw8b4OkuLsj7N63sGAe?=
 =?us-ascii?Q?9GRe4DttW4SjFyH8uHAE4EEGP+qqc+ZpgLjmEFpXE6rAW6whHAOWjL1iyM5o?=
 =?us-ascii?Q?2otymEjvVuBJ3H3XbKSvHnzuX1tZ4Wn+c4h/ENnJg417TiL3nIugD1oXJ0SA?=
 =?us-ascii?Q?f1MQQtX4RFEOWpbMp6wF4hVESyWP4bt37Hok2yHdlNkAVxkKRmb18xCkYPSM?=
 =?us-ascii?Q?4YmasiydSAknlVoSrtR2aTkWt4l8yB9b63bDOa/bno9c+jX2g6v+q1/xetEy?=
 =?us-ascii?Q?xOTgCa6SLbObq4p2VK9A9Jw+ghCTBst65XbCbm7tOmdYF50q3/W1nQptkhAs?=
 =?us-ascii?Q?XVaPdBK60G4tNFH2usgwZ0oLnabmAtxYX55e1jKS9lhAR1RlpEBgyJfXc9Sd?=
 =?us-ascii?Q?3vehuILFsdbA4ulpAlknpv9DdL2gIw+54VJ93XGzHQB66IG257ezwbSKB47O?=
 =?us-ascii?Q?lgcEFBN2KajjL4CoHiMxBdQLgxhce32xHyBGAPy7p65A9c6x3Co9C+vH0oMn?=
 =?us-ascii?Q?ufo/L/E0WxBpxaFIHqAqS6we6UZsl1KJtmkZdsrWlZMldq1vQWEiHynVpihf?=
 =?us-ascii?Q?Yl9BaZyHzPK6s38bIx4RyeX4SF4MtMlvkX+qRJ9jDbrDavbfarv5rWfz8yHf?=
 =?us-ascii?Q?SNhu+i3YR8WK8AN2eet8/bhrhE9tbvRgE4FjgCU9DNJptRKWd2yVnme/Kx+i?=
 =?us-ascii?Q?OvIp79wZZ1SfglTVne6nk3v8zhQtCFhlUD8Ez3WTr04ZfkUH00083j/Zu/7j?=
 =?us-ascii?Q?1IhDhdvsUpwGEPXITLOlJQoXF82UOWrqRt2BG/hLawvxDv8VfwbXpHkIDYPN?=
 =?us-ascii?Q?FR8hYJ77N4c4LhLXqdEo4/u+I5G4rke6gSwR9cp4P4SLG9tPs/uDpik/8J/Q?=
 =?us-ascii?Q?sNzb9WCtRJRz4i7WKEN/7Ku1CPAw+KO/u37j2vkdTvB2YtDmVnulwtCj/GGx?=
 =?us-ascii?Q?K+wNjqTjgsysFiFMd9Ofpomkr3dPnNkvKl3bPvoqCpAvrZryMuI9K+aQ01eO?=
 =?us-ascii?Q?cbc2ojE/m5lXQoF1EZ/C3UzGYmj5NurZcWD86SKvSg+AWLDHyO2+wnaVch7b?=
 =?us-ascii?Q?t7bQOwf/P6sneiamLGVK9L7gHcuggqg00LsnucOlbwjfX4UodX/oFWHpyyNr?=
 =?us-ascii?Q?OiemAK17DVenOEN48ftDAFs8LdCd38NXO5wVcToK+FTi0PRQ3OTNY5kCAVVx?=
 =?us-ascii?Q?iSt1TWvRzxd0KlktHa/P1jdGRwZdSAdhxN80beLHC1P+T4ZspU/Dg21doPqi?=
 =?us-ascii?Q?+FGAHc3IjkykCDaaedYWyv1v19nES7mOVa3MMtmXYZPwD3OFXUpSUXvCk4ff?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e99b9aa-c67b-4f17-d2bb-08dac7c7b1fa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:42:52.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9KtqJivhIvZBFN8+pttfWHJjjfwOECkyTvRm3dsAjsM5u4w19842fqOGD75IcB7YLt3FtnF1rmrw12IIFW1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434

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

Geliang Tang (7):
  mptcp: add scheduler wrappers
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  mptcp: delay updating first_pending
  mptcp: delay updating already_sent
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 242 ++++++++++++------
 net/mptcp/protocol.h                          |  18 +-
 net/mptcp/sched.c                             |  67 +++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 ++++
 5 files changed, 320 insertions(+), 86 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3


Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C595257A
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 13:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8xgEVAd5xu0vnlPghPuymwK77qcQFcr9/hhhA9iWb9KG4qLVnjyLpQdDdZpnVv0T+npYNp1HPUI7sLUhHAe8JF6bW1AKCnn24fY0oEpqqCJx+HIfBM5IavPoZCco1qL5r1BqgCDk0OH2SyxKgo4chUzYu7F7ki7y/tHVVONW39enJO2xwaae2Ovkxs7Gt35mmS+gE2p8ml1nCRvwYBOYPGCAHZ+Fj3+Di6BgDwmiKBTgmovMHciPXiBWMeZt39mnsT0t2yhT338vkw+RcVhXlYgNEXKwvHGGSNjszz6rZ3Zhqcj8T6C8qiYeUyslqZvdFRgTGRRwjs3ls3DRDml4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4uvWhES1S6E9n1gOI3oXVWGT6Wrb6o+wt3Ugwffdmg=;
 b=MxYnY9/W3onRCrZCrncZvNtN6j0NsSW9taUb+JIhM6xHlmpuXUfzLTmI5DGid+J/UKEYONg6iQI25NjClfIDdwyF0Yl/cbBV0kZ12CprYYKBRQ/MUL8NHusKwyfw+yB6fn6xDIPUVBYJZru+BAsT7CHaLd6mLJLB0g1xk+AH/A8s6mXbBOJ8O46w+0lta/ubNl9m+u+4YhghJJeC68156E+Pj0Ec2BGMHPCVhPYceWZf8NQf1bPB6Xkg8ISkzbHj4G4QI8u+oA2leX51jIqbcFH5CS2dxV/RakzbWUDzyhnQ6B5em9ezMdwH4hknCcd16WSKNRaLCxgRzVWuZc1S8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4uvWhES1S6E9n1gOI3oXVWGT6Wrb6o+wt3Ugwffdmg=;
 b=UiUxvsaPgZFL91q0+tCRIYqYOqr1+Y0iO5Fn8vHWmCK0E4cr/dkHFqc7E+Vcvu1BXThevELppkMQwvFtuGV33nSjl8fH1VhHxWpwFADJ8Q4TEQU0LRCWhB0KJw8jFMhCsN6lR04xp+LgEr2zqFG5+dllWj1DMMMmwdyYevLNyii4qtWSNVEi0yALUCDwpN5pYYuRiZtQNudsGED54FtuNTwM3HfKlm5wgpRHlCsqwD48JhdlPhr9QtsciCEJMTK84Y80CnetLRneHgquIP8voLIhL5j5dFa93QKshwhYHBUEbt5+CDtx/gI+J+EsifmKnyw+WKHIDD3VQ+MNu+5O4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7509.eurprd04.prod.outlook.com (2603:10a6:20b:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 2 Dec
 2022 13:30:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 13:30:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v22 0/5] BPF redundant scheduler, part 2
Date: Fri,  2 Dec 2022 21:30:12 +0800
Message-Id: <cover.1669987293.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 5935cb00-2fbe-4c47-382f-08dad4695fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x0EZwh5GzW9CO6UwivQmxhOa75cO2fZ4VpY1FOotFGty8mHkeSxim4ixw0wkmT1NA1vmrNBP+SXYFfeI3RwQKSX5P3VBGhIg00P05HA/dTaI7i6eWc8kPJMFcQg/1x9B/DDayg2jDAu10kaqk6bH8yiDNtfxzRGL9t7/J1aFFSPOmjxPoN5BCG8CbIk1guzS60nNyEledTDnrOU+NAynXQyeE894TaQ4junaezt2jwucqE4GqpRjzLM2Q0uUh7x66Iqo29LAWnu9OhrT/qkGjkMHNBP8zFnTjHEAdtFi3tPhLfQ/tUR6CzAVF4KSjUi2HBeX9ez9Kubpw7xO+5snUi6UFhiRTruEBWlgF9SN4o1GWX5yZpk6wRpbGC+VSGw+VTQl7hl3h7vTpKKsc7shevG5UtTT5K32XZz95yNlhyun9gdCP7W7PHVBvdbvxUP0PXxUUL/SgrBzq0sePO7yZNg8PbmO9JcGaoiCjlbV4N7/HiybhykyYmcfLfGuZGEWtACaXuzFg6YswLp8TO5cK22gYd3HR+zaTcGRr6Mo7mDEPwiEZXtWLbx7TlELB/JstzzrqCODxRgZ67DvmbJ1CYbg41UCSpxJYDe3r2IJgvl8ce3tviRaI3wgwSYyEDmQtX+RX/PlbsN01UYBcqq1hSTTL2cTMSr425qjOBcXiBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(44832011)(2906002)(36756003)(316002)(83380400001)(6916009)(6486002)(8936002)(478600001)(6666004)(107886003)(66476007)(66946007)(5660300002)(2616005)(4326008)(41300700001)(8676002)(66556008)(6506007)(86362001)(66899015)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWnG2VTXe1DGNjBCwSTFFA9Erm8wt+0FNxLQ6IUX+Gjsf3mwvz3v79YtGf7w?=
 =?us-ascii?Q?C+B9HMWaurqFfdmFCuDP3rhuHMzL0Wu8EBJsUx+eqkMm0CQp04fT54OUCfke?=
 =?us-ascii?Q?Qm+uB81nrIDcQqUBN5oBLp+XXBUpEhTDzJquQ2RKcb+0ymi8rWr9olRFTYa3?=
 =?us-ascii?Q?TokYl5qW6fbzw0KojiMqvmI7Rcs3/hfOtTgP3mjVwkwR6bwqbVjZS+dfVZ3z?=
 =?us-ascii?Q?CbYUO1/orTE+GTfHu6UqA6X239LWfEJ5QWSVXj/IfgSdHXqDBWtOR+wb3q7v?=
 =?us-ascii?Q?hvKkO332l9IY23kjvtqxiCfyDwFvLOe3dejAsJIpp+gYzt33uUyHQDn7XKUz?=
 =?us-ascii?Q?cR9xuCw0KMSAyKSN2p88M2EC723aVb0V8WkAnW+yjFxVUlrx8XUfNrNYs+5+?=
 =?us-ascii?Q?/YfMdInetTDqH5IbFDEzxwNClJ9NiS3L1z/c6IqOpBI7nnoPqQldusKdJdSc?=
 =?us-ascii?Q?KRFp7sfD56NjJBicB1WkT0az6+RsGjiAjmL0RjEVm55ValO4wgEuiOo36aRW?=
 =?us-ascii?Q?TFnDM16eFVz903PRaOmaYZ+AH3f0BXOSGwRmudu6m1R5YhHpItATyTOY9Xsm?=
 =?us-ascii?Q?I6CXP4o3Jn3lDMkKfPRKK+16Q4m92NbpaIqn7dsfP6AhOQ+2YOQSO6U+YNiX?=
 =?us-ascii?Q?ICRc/tacQvdnuA94V74oR7mTFDp9khtdWholMP4sjc/3kfUFF7oFjWwylHbA?=
 =?us-ascii?Q?WI7kS8Bbhw4Dz9e4aptL+ktpZ31xBSsPByJp52AlemWpdS5jN6/E6ZxsFA+p?=
 =?us-ascii?Q?XOwcwxg0AZ+0xMzw2JTlh7O9ZnQxrbr/qE5S9d4SfilrLULHuqMgUTx3DYI3?=
 =?us-ascii?Q?QwOnDXwjLczVqN2CAxsVDR4RDWXn8lgyW8qf7S24z/cNwMTRgjWnIWrVKyyW?=
 =?us-ascii?Q?PCIQRLXGDpcnHm7n4eABaCC96Fte3OSvYbZf/rHtyWwD4r4HcnKlkJVchwdV?=
 =?us-ascii?Q?4Tk1k1XCcd8r0OV+xAuqm0/owQke1oweSseTsT0WvX2HU9hgheLxev60zfh+?=
 =?us-ascii?Q?qvz7+COQe73BxfW9MCXxKzTn36kVhoaUYIXekWvShv230fMj8QDD1aYQflYk?=
 =?us-ascii?Q?aGnQAvqSZX8a6FOisu95HlmYVzzNayVmMfmWLa+vfdCxBXoZ/iCOD8hS2Usk?=
 =?us-ascii?Q?U/9jZkPt9fkb0eL/El56q3t+YGJVQL8mooFhJ52K9f99a9KoDB4iAfbReE7r?=
 =?us-ascii?Q?JyCD8Bi82xa0Zs+aCMIFyTAs15JNXOH2J3UF6mmKwP3KYU4zW2y7BzJ6Fg3K?=
 =?us-ascii?Q?pF55imSYscbtpyYOHq5i6tf7ld6TrnLBXnkEDKaP9WB2nCMZu8wvlMCtoR4d?=
 =?us-ascii?Q?hJpjvkSOFLSGohWQC4yHVkOh4aq02c2Ks9xKt/oqlMA8bfCEOSC/vIsyKgW/?=
 =?us-ascii?Q?Kl/fK0ZFEKWUkQq+HkBXhAiULFHwD7yAr7tPu4TvbPoHeBCcoV0wtPJ7BYWb?=
 =?us-ascii?Q?3NiFdDjCT6ncyf9OCXe6rbf0dHOxrWd4QS9ppMvkPnT+6iiaWGD67iMugjQL?=
 =?us-ascii?Q?LinEL7+dxwxKzUyoVBd1V5EgdhtJgXt37NpOevJ73NlpgPJ4dJCDU45S9Bm6?=
 =?us-ascii?Q?KGu/Ar3iJKTC11trpcKhQk+om5IuOO7dMXpqqrUDsCtDbOnv3WHHxbDNdcis?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5935cb00-2fbe-4c47-382f-08dad4695fb2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 13:30:27.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn+Pb88XwuW9JwDMJfNoA8DpmcTjcScEFypcDEEkH+c1SH0RL7beFf0Y1Z6g6B4a7EKg9MROWB4VmUq6y2ttvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7509

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

 net/mptcp/protocol.c                          | 200 +++++++++++-------
 net/mptcp/protocol.h                          |   4 +
 net/mptcp/sched.c                             |  69 ++++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 ++++
 5 files changed, 275 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3


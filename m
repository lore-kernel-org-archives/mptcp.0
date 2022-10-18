Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20040.outbound.protection.outlook.com [40.107.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD54A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlZVeFK8il4nedTHbFlho71awEVedHlIOYYcGOiRNOzHTf9x7ccnXAEdoAPRxGKNI1r+yc9kxpm1RTDxxpVcNU7HcOshNU8cxzV8L/qiTDVerat0CntP88FMRkYdSJt+w5IMEQ65TtvESS6X129SUA58CVqF26boWPjfEJ8bdwBq2sGFnr7HcX/7QJK7F9+/sJokUB8Y9fmbOR9K9mB2UTpaE1g44ho/uti+nRZ80En/MtbCyX2zara6gmkDjVXEX5rKt4lNblXF5akhJxkBrgRqcouGRFDNY5y+qWcCUEu863UJhNJT4gnnXxiwe3+dHzuhE8AqZJ5T0iHSpB39sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpF1JJZmIuNZ0yod4As3es9VhFasX2Ra2VFPELQyWx8=;
 b=NfCZTNXJciXnGYgYJjqRhoZQ/yEP6XfL5qAivOelGQGeP9HHqk/J/uOL5JGvn12oGXO45dKsNvv29TWmIbaQcwCxRWLhcITE2VO+sHOTZ4lfWJbsJqM5z42QL8HOncrHVJAJPmCMCU8VWNn/NY9MFDWPl+gVURn6GYydHvxQARYCTNb35Bbh9CjwsOLt9hiaWd5oxWli+NCmvVts3BScDl+7FuGsEX0Urv1JvkiJugmxsJgdmHK6cnwE49SegIc9+q36jykjdFtnjKTvInBCsyO6bxZdTN9dQx3e6iWrQtAQbGF27xIZapKr7nGB2HWSqiJUczhQ+swrq09zLQzLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpF1JJZmIuNZ0yod4As3es9VhFasX2Ra2VFPELQyWx8=;
 b=L4Bx8SZ5qr7GB/hFwRANXRajSgfxTRea2+YWXQo2KhbCbh9Ex1NoYOM2LuQoRgyteuQ1jEiBgDD2y3VzSydZs+cjnXOBQNtxRxP0hoouRe2mlVt4joFT9QZLl6g5oKrUzXhXLFQtozfTxyNPi+ewoRMpsaD3zWmF9HNBTIXxEV+AStiFhhPLxTmPN/m1ssA09G07dpjR940H5xz2GSf+axvgYjhkSX9D1+e1mFAqszMViwM36cSKjaJfvEvMOzhnyHIDjvsAxtl95y3iRxKKNVetcxiYPrY+nzNztjW4AakfTi5mv0IDmRQtAlgL0UalfxRWA00tZcZDPIJm/oC6Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6919.eurprd04.prod.outlook.com (2603:10a6:20b:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 11:43:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:43:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 0/6] BPF redundant scheduler
Date: Tue, 18 Oct 2022 19:43:12 +0800
Message-Id: <20221018114318.23627-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:404:56::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a85e3a0-7043-48db-8eb3-08dab0fdf735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	85xlV6ng3NTdA6HFWTd1Yq2BL6fZvNopKOINVJC7nApIhwLnCpJJ648MLiJLAt5NRI7GDiGpVu7M1mFBht8eXrEIM1KZROBC5dZr0xtHCYaKQzpr4c5WgupGb/rzsUcIfE2bTzdI4Q1NN2Hl+B+Q3KoTA4l7AFT2WjT54AG1kGlwTIH9PRY4BDodpwq7cxLvl4tkNBMvRo9i7Z5mtEEEmo9uTqqGgul/9+Yi8g97kyewnzMIL9npkjonN/U1j4rRaxdDl7AHZ8gIjZe8/H21vU4PJIqdIVbBrF1gcQeaX8KmybvxGm5eicEGWzhBDzXDu/L1HyPW9f5RJplLNBTCyJSdIyt40Ytyoah73mWM/eU+HamMft8V3FTKUlTm1f/ginVXLphzCopf3/nUjvydMc/EHKLbX1fjCMrU94djBcYpvEdrhYt/U/NCB8vmxGaWqPvJof7//3KO5OhMtlYvV3pRlJVO2YXhMCSRyYGUHKbES306cmV/drtHJliRB5aNxadqLocMqjgbdZgTg97XFUqhQFDDKc7lgYAKiV6qYHUTDTTeti420w/cZrBDkrl9l9XyJxYK8cnKHt8kV3z4uGu3FneGJBE1QmcEvEZLAMCVaayGOSbi5M/rOg8rLYyJsq3ht9WpzA7wb2nCfqh3qPGn1H6A9ctwMhetMlDtmldMzXaAPl++fTS2lZ+frxPHbV7nnUxYkY7SmPqSGbe8X5B58OYjgVTKxJCsxfAhDD7PhMJo6UhuhaA3bXV+88KOjkK6+nJZ+BzHqhw5Ia5Kfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(6916009)(6486002)(83380400001)(2616005)(186003)(1076003)(86362001)(38100700002)(2906002)(5660300002)(44832011)(4326008)(41300700001)(107886003)(8676002)(8936002)(6666004)(6512007)(478600001)(6506007)(26005)(316002)(66476007)(66946007)(66556008)(36756003)(66899015)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1hv4Oo3d7lhQZi2wzztfRl66J5N6CuNUm02yhVDknQA6Gr15D4xNe65NLuu?=
 =?us-ascii?Q?XSt7+QR/guptLmpwslJ4Z6MrdCQFYG5ekNp9YOiF7c8eNOPdFnSt7N4UWXP4?=
 =?us-ascii?Q?GVTpFApDcBja6CP49p9fyUUKQF5GBEcvqU7eajvckqVpVAXwHpEwRDDS/U5W?=
 =?us-ascii?Q?hIvkoew7EW85L43O5pPmbnykcuggFtdgBPc4ReBXSRlGjoatuA7KiFw1EklB?=
 =?us-ascii?Q?SJ1cBXUWADv1JI3M5+II0H0p2lhHlQdh2DzcAZpcxtQPjGCQdbVFdQ4124kr?=
 =?us-ascii?Q?ynRM7MNcQVcZJILpZy8Mk32qMT6sSI3ttp+dy+E6z4dxnhcDj8LxR5gIdx0q?=
 =?us-ascii?Q?5yGWRcJdUE018jcqXVShOUkGAsfA0NSZcjitHQIiGfdYoJt9aTW9yM/PHRib?=
 =?us-ascii?Q?Ce5B6I7CmYAJ6eycauCEs031P9jrfv11UsTM3+RToYryVDUBG04RTV59BgC+?=
 =?us-ascii?Q?QYgLpajAJKfjKLaIZnXN0tGBHydlVFgFT8dGkE9ygnCEynIW5Kjlr3sqiDMh?=
 =?us-ascii?Q?UL6nNzi49oJu5l3zQdQyg+qnQlaTEB8FVwnYWn4r0EyUNpaDo7TdwaPSAhQ7?=
 =?us-ascii?Q?n3+5GCh7OfVt6HwTqK3KeXG9SAXzHLY/p2yXA3bobktfoPrjfulftQIte1o3?=
 =?us-ascii?Q?ZzNJYQT3XbyLlaF/h1czq+lRORVCGGqetQAss0HkUEg9b3il+Qb+6CIB8dbH?=
 =?us-ascii?Q?oSz4P/LjFmD2GTJVOln2fS13+PZxP7yuRrH/J9I+dj6nX9SKzZJuJUU7M/wl?=
 =?us-ascii?Q?y2tXcCx4ENbXv5G1X1ekbaM0GCfTmjhtRjbJxtEX2aHLiFiV2LFjfJ/YjJSh?=
 =?us-ascii?Q?GpvxAYTla21e6zV4eRgLaIht1XowHacTUBnQJtKh2JWOv0uFveJlVNKAxfx3?=
 =?us-ascii?Q?SW9dYlfEFKWQhwG6vmsL91ml28KGE5l77Ywqi3lOf9CM4D2AjRO67T2mqrLB?=
 =?us-ascii?Q?TtxjKW7+02Ltqaejert8+4CONUwjbxmSnhGu84V8zZS6RZeACVQWLTMuJ+U1?=
 =?us-ascii?Q?IkUiJF2De4iK9Ts4IgnPhYSH7pgBoOWnB+0UxJVYZuAZuH/6PYcBEJlrDx4A?=
 =?us-ascii?Q?SMf9+PhTH3kg1U2OaR1mkW1UftOhmV700zhWfg4741YzyKb24f5mKtrxiBeX?=
 =?us-ascii?Q?n59nELV8z5ZCRawniTe3lvFVFL825Jfgp+37EoMvPY3gCYZw50qdsRC/Xo9q?=
 =?us-ascii?Q?nLnjVQOb3dThorEFt4X0NPj6cYa25CuHbpOpT3PQvQi9M6khz9ZmEZm5I6bD?=
 =?us-ascii?Q?ZeLzmm7l7mjITMbyLRKbrpJpUTTEtmeZ6oKbhiFfhPtdqqMbPG9xqIwPmsXH?=
 =?us-ascii?Q?BIwXPZxd3wczzgxlb89auFgwYpO0qs48SFYAJhU2ea5wiGkw9eBWs+67WqEY?=
 =?us-ascii?Q?zMC7wmbaPABbgjp9x32gKBrPUpaeAeCNpJOy88zpURYs8CG3HpAzW0lVWM6Z?=
 =?us-ascii?Q?u6sLkSMVdQlwPGt19n+mhcPwRvo7Khf165KE/2hfTeRiFaWJYshnnBrP9fqa?=
 =?us-ascii?Q?x8BX6Ou0G/rgL7G3mRIaM7OrxKC2fidt6ieRbiN5Z6hbPxAp5RH/qHliCfcr?=
 =?us-ascii?Q?Vn3GpsoL47UMCykZyt6ZszVEtqpXv1iKo1J2h+L0T9i2omR8mm/TcHFIkdwf?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a85e3a0-7043-48db-8eb3-08dab0fdf735
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:43:25.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84m6vYA5kh6p2oL4E27KXdgozv0c4fpoOPHDqEBkc0lx7jKTdS46mEnuR+80CMg7MFrvQjh4nBFe2nenUo2yGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6919

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

Geliang Tang (6):
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  mptcp: delay updating first_pending
  mptcp: delay updating already_sent
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 198 ++++++++++++------
 net/mptcp/protocol.h                          |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  37 ++++
 4 files changed, 222 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3


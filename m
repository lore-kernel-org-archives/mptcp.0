Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150049.outbound.protection.outlook.com [40.107.15.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6A1FB1
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 14:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af97+z3GdZtMdmimNnyktrq9hGzHYfMw4TBweenXUM7eS42LGtFWGAXlfMb5RxcrcGdMy0KZwgOdO3rCZabZMtjQE71M8BkPVAoDZkPdk8Muf2cxBnUNbeIXaCNvmqqPpytf00Yl5/W1dLIlWZviweVHv3BIABX3RQAOGEEAYyb4kzfpn1sqGWz0BVX/mmIf4BR4COZ/30sRKZB4YLQmDP1MORl6PtN1JB4DVk5Ep8FoRWnf1MSStBG2PhCADze3V2dKYaHj84nFoVe6Hq2fuJhqyz20TcjNIj1F/ikLDD8hSdlMeYA2Ly5g0EIZMkr+1wrkdheDvLFQXOlEYOKFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3QWDXvFTXz47BefU9Ab0X5AsUr57PIrsChiG+HgDws=;
 b=J3Jlmyq/RPKkIL5h9yjvd0nqBEc2cxGA5vVyW5kdMEr0XQderpfmnoMl0hfNojz5q9fbh+FGVQw4oQy9gaisRhgxPbgelSpIDi516rRo99Kt4a4i/+7iYz1BUs/rsUAQVa+t0v83FBwiKJnwgck4YP5kUBLxWOYerGsUdsXjiM+AZF987rhs4QOdGs1Y4T82Kydflddro/gSlzwxU9cixoQs6Yq8HLu1j08/5nnP6PJuFkuj8hyRVVk8TAQXFj7VTw88SzYTH+Dc7fm6RLoIgJJ+kMIuCmx58lfAEN4vwjKah4ptpoCT0/MhJeuIZOeQfFK93pxBkZO6JSgEiu+cjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3QWDXvFTXz47BefU9Ab0X5AsUr57PIrsChiG+HgDws=;
 b=5Syk06zql0m3x+dyl/uYsBWRA52LsJbUubd7kvc1VwU5+5cAKxhWNyeXWANOsvyJ+K/af+b4uZ/msRUlPMvXv87vI1YM+iW0vSdRazPqcZZufL7lLJEuSVgod34nYKJ536HIUzw3du3fwXkfLaXZFZo+irYP8+Mjglt719Ve58HQkqNFGI52LGvJIIskZ0tNle7+ymW19zfWk36Vbedc3oyHKBf88C90PZPg9SE51SBKcHzYEufAH2lhV9HFlknG/VB8jWJFQ4JoYTS5lJofOoI645WDSi2i8edBu6tY+uTIcsYT48dasLd6lVPsDs8CHbB05OK5rakL1nrIxUhP8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8299.eurprd04.prod.outlook.com (2603:10a6:10:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 14:54:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 14:54:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 0/6] BPF redundant scheduler
Date: Thu, 23 Jun 2022 22:54:16 +0800
Message-Id: <cover.1655995770.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e812c70c-0518-4698-b19f-08da5528428b
X-MS-TrafficTypeDiagnostic: DB9PR04MB8299:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB8299EF7E428A22416BF2BDCFF8B59@DB9PR04MB8299.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	smeY94Z89gho+RhNkcmpfjV9U2xwldRQ1GRDpXcmwT5Cqxa01OX4XimCa5bJVHEbtbL74PvYmYO2id2O4N1GMjkQFlcBd0PYytmNjVgSSeTNOpYVL2Z/eaoabQw9wEXI/EFVO58Txnkj7gCOQdt4UZBms7JUpQ0A/FsTd8gvdDLuSL5PKHKMCGyLluHnMxToGtW3O18P8M7rfc2KWI6P5JkHmCopoQGfrdokk7ZFamJvb26DUAyHnZumKd0P7CuvAC2QeN0aEHjebTT4+U9WNUcZ3AZWaRT5vvbL/TK6GQQzIEWhb4JVLgC48FLdTlIfBVwRjVtPmJqoITYJbFlq5x+PwrNt7GqV2bpkYdU9y+shsVdevshvxRHLqkaiOkdYupcbbkSy76pPk8cB0qP+ywtwyP2Z3eqXMDPHD3NddHJufxIhJs8QzZZk5tTHOwbf3PWifvUixIbFJBoKu2S3bzPvM+NkLAtGddZ1K0wjABs+/I0z1Kbxh1VS9N1bnel2R8uQUjaM7fckXbh22+ymhAZyKH37e0c+BRR558mNyYMFip5+ZoUEyy3H9WHW10eHonaueNZOh7tMf803OwWy1haRs5mxeeQrlohZZ7EoUMW/dLidODVS77YAL8OljFh1lq4YcU+jfULXhVITNFPAnYiHQqDRg/58XJGg5m+13YpFrsCdjuHIQKckGhl6nd+if8ywox2Pd0rpk+MELCg+p8sfLtBQ42p4/q5QS+haaeJysWH0nHya0r527YRq174tTmeSEUdq5m96DZT+OC6hSQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(66946007)(66476007)(83380400001)(4326008)(8936002)(8676002)(5660300002)(316002)(66556008)(2906002)(6916009)(6486002)(478600001)(36756003)(44832011)(41300700001)(6666004)(86362001)(6512007)(26005)(186003)(2616005)(38100700002)(6506007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iSsWU319aA/smVoEXjJMIkBtQFDoK3lziKoe5jX4GgA9cdlDv1B13mspafw4?=
 =?us-ascii?Q?nW57xPnMa27kNNUbdtvA9is24kimeHJfAP8eZ5WiHXHxMVo/t/Bp+ANc4Izh?=
 =?us-ascii?Q?0VaicUgad+u9wV55TOwRFZn9DtaNa7QlK+OHLNPRkkCvXHbBq74PQtoJpiHn?=
 =?us-ascii?Q?b5vPQO+jdzTRk7uk2NiTaR/yrs+PqeT0qoaMVEcodwNVl8xF8tFI3nktnuqo?=
 =?us-ascii?Q?mzRv2yV8AdnJX7fiHb3v7lkSwlO3wzDKnQYuOJvHzcT065eAvwETLCI4ohep?=
 =?us-ascii?Q?GAPAvJRhedKKCtdCr0Kc87AZsYlGpnv+7345fnWM7RvcL2fVrbh53PqWNwKZ?=
 =?us-ascii?Q?p8HkpY3UFJ7EX0KXt8pjXgdqnZbCewzc5y2w3/EfXoyfJErILi47YDGyKeQl?=
 =?us-ascii?Q?VaAfvjihf+F5GsmwT5c5GjbM0cJoHTOKhPmz4ojCSaaviWVL5hUs+2iDskXQ?=
 =?us-ascii?Q?37Md3evOodNXF2JM92LZdaabYi5MH+4XJLEnJmIr4MjAFhjRiuGdFuzW1J5u?=
 =?us-ascii?Q?XL0qePl50liOKS6EBFuTeu5ZKcGjutem+TLwYG/xwukQvaNhb6Ur0GUAVNCy?=
 =?us-ascii?Q?x0KrNS/om2S1nlNIbv3TXKg1bVLQzMOsMh+r6QxPl90jhEf0al3JVLOma1XE?=
 =?us-ascii?Q?u1xmJpi9HQ2yDZLW9s1pMFqBoIFsqjKnxAsTNQc8v3nGmBm2MzrunkFdikKF?=
 =?us-ascii?Q?TAqUd5onRkjmJR5mxl7qpogLUY7AvfagSJYfEfXmJkkWiNAiIfI41sUiP2oL?=
 =?us-ascii?Q?FgzsV2L2oOj9b5sK3K9ZK2kbKilxW0Z+tU2AAUBCyVCbyaAzyDugNRDUneD6?=
 =?us-ascii?Q?5UZYGbC4nNYMHKk+hJ8zTwHkrZ5l6folOscuqTCTIlsaz8OKNswlADS0Ho0O?=
 =?us-ascii?Q?GP1ZHbGcgG/KrzaKKbvQNUHR63Lvts8X2jZ6+6y+rYrH66q3cGFjfwsN85p4?=
 =?us-ascii?Q?qCBtp10zdFwP5wf6eeCusDYhBJQMxcPHt5bJBMj/XQUiK78+hgSdSuwVMw++?=
 =?us-ascii?Q?WdrK8hu1NvX2DEqz75AkpsWeM1CDMlc3Uu5tWfQ1wvRBUWWZe/DzpEQgNO+a?=
 =?us-ascii?Q?obdFQE93HBPtL49K02pTLrQOCcc1QHSZjw8yEOLwCsTsctqGkhq0vBLY3vHh?=
 =?us-ascii?Q?SaIZl9WMCngpU/4FKW2cASSLD/uSmQXcDNuHQGjSqWqv5fl72iw9+fgm8A6l?=
 =?us-ascii?Q?dRAydy/CsT6081KHZ7IlJZtl5z9IioQFc8qxiddFv5XC2VBAJzYDmXo/pSWO?=
 =?us-ascii?Q?d3VvdACcdv7zn8q1rMEOyDReC6yWMeypATk7AE5ZF0EF/RIdKM9AaDpa9hLm?=
 =?us-ascii?Q?bQRnqgwGCo7bmxRSaCDfgQoEathyhNpUd/XvvdMIZSPWrKl4DoQD5F7hOYRI?=
 =?us-ascii?Q?gEevrTJBMVz1nt9HZ2+ZxqAvIzlXQ+2oEwhIiVtQ5KmhfXtc0mBzWrlMoal8?=
 =?us-ascii?Q?8uPWER+4IgDRYmP0X742LEd90PKYVuBNsaDCLOTq/DccmomOGSAXVWdZc6PD?=
 =?us-ascii?Q?9ra2F1m9t9AmyLI1Mros4Lp3EO/4sn0XcTa25NSF1WBIBoVhaU6PXL6YAzYT?=
 =?us-ascii?Q?XYw9OmhzdaXKFgo+1ZHJGjpDKGE9PDYIUFe6H57lv6uwyTzlBaR1rMI6k+PL?=
 =?us-ascii?Q?Np2+KD1q1vAU/03rPW1uj6LcJ01klIthAJEDYT/Aed7aHJzcHV/0EqXP1nmP?=
 =?us-ascii?Q?Xp+pm8mZAP5If9HZ+pNp0RWumN9cCVbwKiyqHcMnBX7Etm1csgo2gWHnflk+?=
 =?us-ascii?Q?oSBVkw+AMK2q5nUgqMYCDSw8Hg8mrCQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e812c70c-0518-4698-b19f-08da5528428b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 14:54:23.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrUiZ7uiHmMrlcDOcTvQmoJox9Lasq1EtZ2LKBHsApX8AXMt9PhaUvaTwh9U6JUEdLqba4NfcI9VDBbfa5X5vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8299

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
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: accept right edge of mapping validating
  mptcp: redundant subflows push pending
  mptcp: redundant subflows retrans support
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 160 +++++++++++-------
 net/mptcp/protocol.h                          |   2 +-
 net/mptcp/sched.c                             |  56 +++---
 net/mptcp/subflow.c                           |   4 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++
 6 files changed, 201 insertions(+), 91 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3


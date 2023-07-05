Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8510FE
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 06:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g160Nk9wVEYucdN//mgm6uciq82j/mrlM/PB5JMyGHfidrQ0dbxqnEEYFJjeKraNsVenX9Y1lzPw3Ols5NyyVfdwgsXljVcMhk7dL3MplYwqpc5r2ucAVZWHEXsDj3OucSjOO3E6PNiVzU0/k5zoALD2/afzLsgvMrEnO6LXOj6vTSOIpuSlxRvOTvWs/XnyMa2rQ+Sn39gxtn19Icz+meqb8NY8F6fhq6UG/TLjyNl5iypu+tW8+HLL8qnTzeRGxtUvux/pPRRSQRDjIvPbNlW0Yxej8oIFlsxfvA3SDuD0eLMX9Kbl/jhQOFger9Q2GHUIEgBk1PZPgj9125PK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkdalGk5ZkDoy+pwHxtOqS1QSQPITpJcZ05ahmAs9PU=;
 b=I7vobX/ZSSjAKl4x4px63yf1H68m6IwkP+AaJQmYLMt7B4Espv4SmstXbNSn4tyJ08tExWz9/yPY+fCcmmg8hGnwsJFRjmUkZsm1etIolRxFxWQN+qWF0Zls6DffwdVD/Rz+yPMwILN3+nLNdO+ugDRSCb1g5TVi6D9a+OMjtPkiUW38YgqpLU+gVS+jjV1GR5aKLVGfD+HDl11GqZoB+syEaT1Xi9EeY9gHx50egI7zObWLvOIQwSaKuXaJdw+VUK23rsA4qDu+ffTiC+DEkRoqrCXCTnJzbzxsU8e1jG/iv0accIAQyAwRFyX6mQ5au1tjDIpt8ucwGX4slvLnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkdalGk5ZkDoy+pwHxtOqS1QSQPITpJcZ05ahmAs9PU=;
 b=eJb9DVmwztkSYREY3oR2QLiK2l+4KFcK1ydmGvGf/kIG5mIGD+PCkEGCoNAuY7s5PJhOFj7bgT9ULlYje2GPOkUmYCdSyGOwh/tivBvIuGgGy2SeiQVd4etFsCNJP+Q/S27gc+olkq8LRHhJVFyNWXn8skLENx8O45IZ0kMYYeuzdGtlKRdzVGiG4SXQX1j0AhqbtPDBqpNr7zyj4mDWewo2s+WRWjlC3CGpmyPcxCOjA54873LL6KG5RrxtB6eArvR+Um/Er+hehT+Ratr9IFckd+/7lElYHrDiPCsu2yw9Dw/LfwVxDIgGrbNGskCEva4RYP5hyIwD/OGkMFjaQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7187.eurprd04.prod.outlook.com (2603:10a6:208:196::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:56:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:56:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/7] BPF 'force to MPTCP'
Date: Wed,  5 Jul 2023 14:56:34 +0800
Message-Id: <cover.1688540074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 895e6e20-4077-4203-57d0-08db7d24fd9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y2Wy8mGzMEnlYDkPbupLO1p2NdNlUP/SM3FPZabw0QDonHOl4wXt3H6yAn0G3GmhBAZngXIe45isMwsSkB4ufHUreciIqV3dNl/Zg+hIB4L9Yh9CNYUy6fTJdhJ1mpJ41kgn0M1NpZQuWiPZbUuL+GL2M6WbqOxLYxqHGixxBov/XookE6xFDXKUpXaaNgR9AA8tMlZcyEZVpUkNeRD3zQeZK/OLwVHEIu29kJDOhgd8xAaPn2+5GfqF9YBMdGzPtFWG0grqqayfk5nJ2avHjhYJ9vGWBhpa3XcbCitR0vo8me/rDUYbOKLtS88MmiLDyeucrTPY1j4qp1E8+M2AqqzFaHTUFxHKnjJSiLXT+3oWvreShh/Gw4oGPulumZLuktsMmsaE4BNEUyDtclV8MiN4dUutxSs5jKllo9A4H6IvxU79QySeQxpR1uS67sG1L32mSkr3r1Req+nBTcW9Z+YQfCHVLohQRulumBkZPtzn4GRXUZNgIpGC8e3vUunO5vWFvuSaP7ctUO2otvD2eK0jNTIuJAZ0j8xTKgNHemD2SZmdRXpv0GRJ2KMO5cn/XgUk1lXPjKAZVDJIAA4vssRNqW+D6Nh8KIPMBx5A54c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(44832011)(5660300002)(8676002)(8936002)(41300700001)(316002)(2906002)(83380400001)(2616005)(4326008)(6916009)(38100700002)(66946007)(66476007)(66556008)(86362001)(186003)(6506007)(26005)(107886003)(478600001)(6486002)(36756003)(6512007)(6666004)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dvsdPlx3ZwNUflIc8vpyNFoU63gZflSnnObcjT4rQ/KsnXCFetIzv9bRCTVR?=
 =?us-ascii?Q?Pzzabv6LHQKc5FKstISYEeFgYXkbxtbymN5sXr0VdMjRx+whUUlTTuxWVSxf?=
 =?us-ascii?Q?R3WnsS9VEZDrxkPSCpjaH5GuPw7ZvihUhTneLT5qMLzt9DSEEDqEeQcWpz6B?=
 =?us-ascii?Q?rpyKSSOntseY7zo0PHp6cZb9NPkEp0fs4bIS3sL9t9kTY8s0kCKC75GAAdDA?=
 =?us-ascii?Q?xi2lqYkMdq7LaSbSbaM5vgFa7QPzrzSTDu31UE1JdiWO/Pviu6Ih6N+vncoA?=
 =?us-ascii?Q?/yemCDsLk4RLHjy8wSPiYSK0tI7eUbGHvAbDg9B1b1s9O7KZBquvRu7/aEHu?=
 =?us-ascii?Q?cQC7S1LDpv8OGJ/0fig4wvpyjUwDcVAc5auxG3PnolWhTCXTEYh9PYpRrRDr?=
 =?us-ascii?Q?DCi47sU4zlE759XYC5aww6qzSg4sWjrE3Hwb/sqapxlqDyig7UOshFYGM1p0?=
 =?us-ascii?Q?EAyy0ySKuRyo/jpW8qaPedrLUdAZyPXYacCA6lOFVKsoIvvu788dDEzSAoW1?=
 =?us-ascii?Q?DggYNqhNdB89p2jCtsf3RgVYt4W+mJxYJj9iOuyU7axW05bdcfLXh8Qp/avB?=
 =?us-ascii?Q?LhCfnUxmA1lPRWUau7m+d2n8S6LMn13F8AeU5ekMeIb9naoaXCUbd1PIx8Yz?=
 =?us-ascii?Q?fZuG/KV0eZcOaATMUdQgratGimB86gMwP7qgAbMpXdTvgZEWxj1FnxtATz1p?=
 =?us-ascii?Q?eStXOhVCJwf1Jmz3L30O7B8UaHCY2lu8LNmMeg+tZNj8q0avQQsghqL+XtIz?=
 =?us-ascii?Q?ZY+giLD65vbdcQvUWFZGBWAjoIjfEMWAdvd++4OJaDdLXYr6e41Y5jaPPkfl?=
 =?us-ascii?Q?/r8RDQltvRCVwQDbxAGSuE5RXH75ZiAinn00wCHTkHZiWk1Mfl26VfvVkeIn?=
 =?us-ascii?Q?ns4yAcTt9yH7V0ErE52GLf6vIc3c3MwyKnzGLkL10Cj+GRV7E7uB0Q371ka9?=
 =?us-ascii?Q?il7iUMYefPMjrg34S8PtGki6zaCOGK5ElH6Pwkald1B7l4QztveCFaYbBRhx?=
 =?us-ascii?Q?s11TeBBmGVPVtxR7XrIgVjRSau5sDMYQHvdKZj7x/M8V4aXU0X1WlwD+/qkJ?=
 =?us-ascii?Q?tf5y18DMKql2gEYFzPI7G14OsaR/u2v6UT7dp7BiFgvRzt7ylTZT+Vn0ngcL?=
 =?us-ascii?Q?WZHY6PRFOKY7BDkNopxJAGd2MIdvWzP3peODVB4I3ctFg5tJ8bQWCSEEHWFS?=
 =?us-ascii?Q?5Rbxj24ixMUcLcHbuHATebIERo/lChyyBO2hb4FW2k8xOvQ/5KmriXiL4Uu5?=
 =?us-ascii?Q?xQvP1PezLAEU3iF8t9aVcondf1RO8k45ZYZxU7CwtGM8v7ZNSSAGh6rnBUfv?=
 =?us-ascii?Q?fOApGh07hQZsRittiX/2Rt1sLSXwNZXxDesyne9X9GF+HvlwOkGXzuW42DKV?=
 =?us-ascii?Q?1R73N7CW/keZNULKrEkz6DV4sPWpeBiv8k4l4LoMwOwtZTaih7Hhr3JJpiSp?=
 =?us-ascii?Q?23J6sgXAzrAWXY09LTl5potOdFOXf6p20xUIeAnxDc/2Am5uD8B+kBwvj8kP?=
 =?us-ascii?Q?mxIJ3c2g8LScHNzz4m9B0NFNmgT1F743F9QwZ/6zbJk/P3hrIaBjNiDzOpyk?=
 =?us-ascii?Q?L292ZwPS3o/91h8HV9eSa8GuX1fByyosJxH3dcQr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895e6e20-4077-4203-57d0-08db7d24fd9e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:56:43.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEI8HUeG9FQE/M4eagHhg8DOAvxWyM8oHM+VIvZf/lICM4SfswdwISGuPeuhjzLAl2qVYi7/ywEodJXgV82FyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7187

v4:
 - add hooks in __sock_create().

v3:
 - add a wrapper socket_create(), the bpf hooks will added in this
   wrapper.

v2:
 - Address issue #79 "allow 'force to MPTCP' mode: BPF".
 - Define the prog in patch 3 in SEC "cgroup/sock_create" instead of
  "sockops".
 - Update other patches correspondingly.

v1:

This series depends on the two netns patches, should be inserted before
the BPF scheduler series:
  selftests/bpf: use random netns name for mptcp
  selftests/bpf: add two mptcp netns helpers
  bpf: Add bpf_mptcpify helper
  selftests/bpf: Test bpf_mptcpify helper
  selftests/bpf: Add mptcpify selftest
  mptcp: refactor push_pending logic

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79

Geliang Tang (7):
  bpf: Add new prog type sockinit
  bpf: Run a sockinit program
  net: socket: run sockinit hooks
  libbpf: Support sockinit hook
  selftests/bpf: Add mptcpify program
  Squash to "selftests/bpf: add two mptcp netns helpers"
  selftests/bpf: Add mptcpify selftest

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/linux/bpf-cgroup.h                    |  14 ++
 include/linux/bpf_types.h                     |   2 +
 include/uapi/linux/bpf.h                      |   8 ++
 kernel/bpf/cgroup.c                           |  90 +++++++++++++
 kernel/bpf/syscall.c                          |   7 +
 kernel/bpf/verifier.c                         |   1 +
 net/socket.c                                  |   6 +
 tools/include/uapi/linux/bpf.h                |   8 ++
 tools/lib/bpf/libbpf.c                        |   3 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../bpf/cgroup_getset_retval_hooks.h          |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 124 +++++++++++++++---
 .../selftests/bpf/prog_tests/section_names.c  |   5 +
 tools/testing/selftests/bpf/progs/mptcpify.c  |  26 ++++
 15 files changed, 277 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3


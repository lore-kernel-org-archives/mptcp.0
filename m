Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664BB7FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4/fnbZUJXjwBpFPmm/inZkNEbNaXIO7kTIoUBp1sOSt9yEY9KTPUo/y73rwTQ2XrNfsu9W8fPB8FZQ6roaNAZuN4i/eB+Tbt0ltefgzAq9Jhb/DLtnCAwKv+Uurg+QXafElejRLFlgtF42GsHeZtfuCSZzoeBdmWMwi7BCbRDo69tbkbejuUrgqoglNfGiz4zHaZxn6lDWt4jPDUlQgTxzq3TmP2mJJsQfgllCTL+1Xdz6QKRSHpM3+teRhKSH8QuJsHPLP4zuhD+jXoVzX3xAPKKlbBkcDcnGeukTvPo+9ARaxyhv3u0Im+ffKc1ajb1gpBJUyZiM6E8/H1nCMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlrFODeaQQClKwwCprecgIm0eV8ncB5YW1nQh4jKeYo=;
 b=PRtu8x6Eof72xsfmIGPmrPhreGfQyqr0lGem6gVHWWkxHcc3KPL+GM8cW+mFr0CP+H1uOOgwUlQOUwkDmj/GvC1+OCRpZLOHxfmZyNa6Xh5eT9DhmGw4bAXMpTdJPciXgHWu1MSrwtEnjKppf8R7aZhPT59t77Z4hEUEySYHGArxMe6SwDKLGoF1j1pzb3LAcZsh1PlxON1eRraxQjOe9uPV1a1M7BoClfOywBVncVns2lAch91LOuCJtrWVpFcHcEqEmkcPe6E9cBujlJIoGyadcWtaW1sYt9iPUiiAGFgsWg6bNk03YZ/k3OtovgWforGmlHhsZCP4aNGJJuCC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlrFODeaQQClKwwCprecgIm0eV8ncB5YW1nQh4jKeYo=;
 b=0ArH/mXyua1vUILdIONXOg1LkGYOBY6HvK8rGomm0GffvmjiufY1kXred/epXHiD8UEALFv/60wqm0VF+eVl4iUIasi5zQrQpKjiI3RTLleAQGHHdQ4s315eZlpZN0bSI5ndQ14XUu+j8ZRTH7xxiIDrwL0Hif6KmbARmwC2ZPv4KYqSj2yVnmbiYUoZftdiqNlliLQuaNp1b2pPWz1f1DSTwG9JDUmLFH6mKK1awR4uWJiFH3HPZWSf95+8cNySeSOqhrg5h94i1G7vaRcF1P1YOxhEJNhXBJi0gUjvtlOAoOniIAMautxtp2S1Ppdt4wlRw5dvB84IAOujeG9ltg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:23:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:23:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 00/13] BPF packet scheduler updates part 1
Date: Mon, 26 Jun 2023 10:23:01 +0800
Message-Id: <cover.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: e49903cd-a101-49ca-586b-08db75ec4c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m4FkhZNEhbSnO4BkKChGtCKMnM0efkCGPUpimRnsljPx+bUvRrWVg9unGsQSO+5DONHeDvKTkES00qVG4QJqSYsRNGyjSZlxoKEVsEYW2rPIfdDdeSfmujjmpSJ0yOhw8xNNdCwBIgD9oo7ov+xMobhzSwI/RAF5p4QLKweLJaro5PBI+gLanboypBfCZKs7sX5YlaSv3TXpsFcmrVKn1DtmlSgLeBoIEWhI1e3u1HVR9ZCdWGiJMR0JN3J8O5ybgfSbRwjR9jh1GCscOkkm4BanSpcZRTREb/4e/nJMSlhHIE2euhCOAz3PxLGZdFhu5mhZYDo9lgKGoRWFxmc1ZyqoMirtGKEpBFe9I6tkyYmNCHTh4T5CzPKyJV1LnBQuo6pC5irPqb2xOb11WV4MlrnJeLxoBCEhe0xVaFWGuWFuwWFVJxBgkCtA35VpBB65arM9J3geO251DUcaQ0QDfCaaF1g57rQrbN0yzw9aqM4bspeNijUqkRxPyuhV1LxEwtWhN9lxeZYXHo2qOznm4/jPRZ/prZQi76SEpUUcXW9YnI+DpBprwDGD0zFIjhbJ8f2kjkz87cNiM0UmLrcHNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(966005)(478600001)(83380400001)(2616005)(86362001)(15650500001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4H5ChRI/Q0GGwO0/5AOIIqjd2BfT+Dx+1v2ShZvpHfL8tXh0z2k+Zc7mJabt?=
 =?us-ascii?Q?WPwyqpiK9m57gpt5MuDqXCRDWUnLPi5NGEhShFro/8n8Rrl0EiA8Sqq1TFsd?=
 =?us-ascii?Q?XCUnQgWo4jFMiGNEGez6cvVh91uv+Jo8bG334YD5Oj9zFuen0jC2FY1byHgF?=
 =?us-ascii?Q?WhYkhfTExQFfUm1VbG1SWxlIGTiDAtHnm6djpjSNar3lH5JGdPsrG96G5DUj?=
 =?us-ascii?Q?MQMgYtIme0y3DNnI6rqaXot40k1L3a+Q/f+sCSxd0u8EDR0lDDdjl83doI6Z?=
 =?us-ascii?Q?ZkfRHBCMQm7Dk5BBl+w942XKHEFc7+G2aWCGo8GOCxsAIhxJFOLcuLZ1Aykk?=
 =?us-ascii?Q?UvRgq+Rh0ypKL5R3zQHNcOCh3Oq0xa1GMu+QgArKsCYqb9hwu1SS+RmwNhrx?=
 =?us-ascii?Q?YLGldtcuNr1YSDYj05q73OGGndPeAmxj6v8tkg8v9uEqHV5Sx+BQL2CKAnJ/?=
 =?us-ascii?Q?WD/eVRpKNXvpAw3wIl7gxC2v7kN4KcJxMv3i0SegzBnpmeOhVUcI22tdHmDy?=
 =?us-ascii?Q?jBVgbqCMONjpkkGRnN8rN0kY8dwdeotJcQt1Jhl7D2djwkpYPw0HR87OGSaX?=
 =?us-ascii?Q?Qg8HXQEUREB9bYLQTFk3QVsnjweIyr4cbPX28tsRxpJIXN8t5iO8UiCP+MKT?=
 =?us-ascii?Q?1lznneHFr2Ofm5Mbom+Td5wIvawmWtB2T+O6R5NUnmae7qPBCZl2V6T7+SFi?=
 =?us-ascii?Q?MaZQNwiR0tvsInVowmjMihf926pE5N5E7bt70ZQ2Az666g7RkKzaXZarpH5Z?=
 =?us-ascii?Q?14JQGiWCxg/mY8C+e5g3IIhG/3lG0lxJnGWde8NtQpgoejwXR53bJkXdvw+P?=
 =?us-ascii?Q?dlfoaalSs3DWLrmJfxGvpU3bT891dVGQVf5F64BK4Fhrlkfv7LRFeZkB+T24?=
 =?us-ascii?Q?6UfNHYTCSdFqW2iU+Q86USz0SKPkaRiWf7PAb/9kUV2XPUSr95aHe+S6JLKl?=
 =?us-ascii?Q?6vgJH2QGTz9xrLvz1ZkGOyHofrGXJXKt3IG3KOaobHH/U7cf5+a0t7mOaGNF?=
 =?us-ascii?Q?nRaeH3XCCwzcSuKBt6Unb/zeGwDyKi7LBTe3bK/HDxULJgU8icAQOZar0AwH?=
 =?us-ascii?Q?2PA10Hd9b5mKweSgr7YELK5DNhNazzUx44hI7vjEPOHCvn9ey+zAoBjj1Mov?=
 =?us-ascii?Q?+2S1Ubw+aXOFLiQ4tLVgzrAvJIZpQwVyxeWqQtq31jdWFxhA0AL2SmLH+Snd?=
 =?us-ascii?Q?KNgwmCQxT/55Gw3zoizt82ENwtOqBtM5/CsSM78rFM01XacNfpq6Zhhx9NDP?=
 =?us-ascii?Q?ORRcq9PR44l/fpYelPnlyWWqIiCwZ167BoEdg068GWDEvEmXtFGkHceytubh?=
 =?us-ascii?Q?ncn7ZvlK5kMJAx28uu6h0ugWfM6w4EcIEuXwZ9CWrkq5USTBzfxa6hQslMOh?=
 =?us-ascii?Q?v7OyXiRVNSqanO0ODC3oKHSsZnR9AmaePXzROS1rjQCeWaYIN73e/rn8vUZR?=
 =?us-ascii?Q?0zKwwRzSL0uVq2Z5eh+3zC3aduMSd26h09YfRzSpItHtF6zIq2tGYFxrpUsj?=
 =?us-ascii?Q?od9mEBP9lHg3gCDWQP2V85QlrCY9C2bZE/JAskJ5FTiKUOHZXiRTkXoNFGkt?=
 =?us-ascii?Q?dohK9FCiyUsY9EtY2AuLf7tuaUhrTILLfNfE8D9H?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49903cd-a101-49ca-586b-08db75ec4c26
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:23:15.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAk5+8cZpUUXnkPTQpwTN8vjZz+fbU2mvLGAoABc5bX/JHE5SsjIeysl+vS21T0OSGRdhNi/dzz5ur2hjR60oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

v10:
 - add mptcp_storage map type.
 - update scheduler API.

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

Geliang Tang (13):
  Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched_data_set_contexts helper"
  mptcp: register default scheduler
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  bpf: Add mptcp_storage map type
  bpf: Add mptcp_storage helpers
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  Squash to "selftests/bpf: Add bpf_red scheduler"

 include/linux/bpf.h                           |   2 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/btf_ids.h                       |   1 +
 include/net/mptcp.h                           |  11 +-
 include/uapi/linux/bpf.h                      |  40 +++
 kernel/bpf/helpers.c                          |   4 +
 kernel/bpf/syscall.c                          |   6 +-
 kernel/bpf/verifier.c                         |  14 +-
 net/mptcp/bpf.c                               | 245 ++++++++++++++++++
 net/mptcp/protocol.c                          |  10 +-
 net/mptcp/protocol.h                          |   7 +-
 net/mptcp/sched.c                             |  46 +++-
 tools/include/uapi/linux/bpf.h                |  40 +++
 tools/lib/bpf/libbpf.c                        |   1 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  20 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  17 +-
 .../selftests/bpf/progs/mptcp_bpf_first.c     |   8 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  12 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  43 ++-
 20 files changed, 475 insertions(+), 54 deletions(-)

-- 
2.35.3


Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155715B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/ikMihpVTZFHlobb184gH+h4eflTYWYWzDfETXod6Sg=;
	b=UhQQxFx/UPYJ9t3FX83yss59MKvTrgzj4TnB3OxdEKp8WShWtvaaEhjiJFirZZP9gDWx9u
	JxtgBOSSACkOhTI0/1gT+MtepDiWHi3hTczSDJt5OzHPh2HB2Rl7bE8nsonlNt3leqeS+s
	1GgDB6C51tum+1LYcFNmsLxf90DETHo=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-8kcQcePNOD2k2EnxhRc56A-1; Wed, 11 May 2022 09:56:26 +0200
X-MC-Unique: 8kcQcePNOD2k2EnxhRc56A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn1s4gI9ySm2d+q2FzDCAbWyBRNK7D7oy0LG4xF7aGNLJYMXaH2LHgueoO6ApVxS/gGWud2BvpEKa6TDRKSTX1Mj4DMpRvStoaKAQ0qZMkkg2e8MczqNNio09Uz4mbEtouCzZsh7rrYwh1ydnz8bvQgCmovkrQ8bmdAt1hsqF8+HXV+jCfoip6Ou1JFqtZVa83QlhWhKmtNDZ/gV7Wnbi2FW7ktb1oMI1Yaa3eVo2gi+kEWcLFb+EXlrQNB/10DDKX80unryeWa4mlvC5XwnFEzSZ26wZ1j20Mmm/VyWa+tyuM519RxaMWSWSHfOpkQCj9ogkY8nVTcsR0F1HgdaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlTNgtLljqG72JsvyD7UoKL09PKJgzfzs5SilKsB5Xw=;
 b=LRHIQSqqjhqX0g2RJg7ez0r8nyW1pPm+ZXcduwCVc9VlJ3junBEnd/GaXp5pSspHauXs/7iV1W7epjdIVT+yhZHTSO6rs8xCGHMbFFNcZ8HT5Ymf2hG9+aRZlz/KK7gY6EYpyYP9rYXgpbUbzy4ChdqzrGS4WNrSpa2VeMns3mJ8hwRN30IwwTvUspzdE62E6DCy4qrPiEqIYgUyYzQLHsYzsK+OoC5kW7dh43W8NGfafKYRucuenTZD3PFitXZ9IBnC/7HBHi0UqNiEbO4PbZ7S+Xs2p5zKnF/Nrh9XpZ6w8SlL9MLlM6elK3Oce/MJ67Ouk/8E8QwX17rT9iXbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4461.eurprd04.prod.outlook.com (2603:10a6:803:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 07:56:25 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:56:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 00/14] update bpf patches on export branch
Date: Wed, 11 May 2022 15:56:06 +0800
Message-ID: <cover.1652255615.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7512bc60-16a5-43c6-fe29-08da3323bedb
X-MS-TrafficTypeDiagnostic: VI1PR04MB4461:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB44614E796C9D73C7EF57A71DF8C89@VI1PR04MB4461.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	85TImkisu+EijVbehDoxrQBXpxNJfr6kIsZOt9dQmhFdWivAI93i9t5vuqKWIQeN0qiQfxcmyeouHtkPXM4fvY0muhlDi4VzETNRm3KaGoEkg1plwW2Ca5jtvfSp286QS1kVGfGGTOsuJmtvRBDYWUllB4iworRkgRGPlA9zbdA+Wt2yuRxm44shvWjYsBuq+wdGi6/R3aZ9UCzHm057mrFW7okeq3XDV8Ivk6MoIcYdcmx3Hw/9OJ5gYm3dQSECKw8+PCBbnLJ9cJnTl7WYHvBFKvmlRp9lnp10x7ZMeYpLdcBbK2GWRnno7PCgusboBR0KAIWPYf/Ktf/geE0z6WkDqVzcPfqRORqUuKZf0Kq6Pxgrg7fe7DpG5UADQdNPIaZcPTby9YVya9um32swU13qVpbeGOFJlKBNT015uAh3Elcy7/poefLLX3BybIUSgr93a6d/wv48NHyobhbnNTSCeD5ANOZlolDM7gnRo4EIkZgKH1VsO+LucN2ewK0FTZFvwayWInWmhQEesk/haQ7Xp7MEzjl637WJoFYaCZzXFDPu6gS9T/PpH3fmkCziuhhpqk9nBGNIwnaHuLZfpMpk41N1pkF9hWVqVBCAN4X1AQxZn67E41F+5NbQFucwD6uxHRphzJXAqFaT8E033NofwogX0rpeLjW9/qkVKKnuccKL2w0Cs1STILHwG/5wYYNEPSRPHoqKT4w3mwdvNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(5660300002)(8936002)(316002)(107886003)(66476007)(66556008)(36756003)(186003)(66946007)(6916009)(6512007)(86362001)(2616005)(4326008)(15650500001)(8676002)(26005)(6666004)(83380400001)(6486002)(6506007)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ri721uCRSqle4F67ZlBotckQ9DZ166B7mR384QqO7zL4l4Ju5JCGv3N1gwZU?=
 =?us-ascii?Q?l4dpYAoV6QWrK1mvlIN2q6XHWHAPs4wRcv6ZGndGRxWWySiUX5BTVN+3na3F?=
 =?us-ascii?Q?hwqRQy/EuILOgCZwlFTKPBkVd8ogQ77HlR/4+hsctoC4rMuWdJdFbOmxDTIC?=
 =?us-ascii?Q?2gBQDtUWWNJD5FjoPii+Wo4GTT6VGcxJQTlqh4T3sAn30XU1GpIniNOv/ISL?=
 =?us-ascii?Q?URd3blte+X+t5Np0uaJdii3W/C86+DRUgdBh+I3xyW2Y4qAxQd1+14arMEYm?=
 =?us-ascii?Q?jLf9H4n+yedPI/fpnrtMw9AP1+4Pc8FV+kgYeG7heQnVKeaLyF1+26axSBuG?=
 =?us-ascii?Q?BBhsMoSPEY/znBGlv2FBMoeAXxrxCvzxSOpXOTs9fVpANetpryPic2+1Y073?=
 =?us-ascii?Q?1eK8GmRxe/zpNy8jzyMDL8PjylpT7pPj3d6M+kkGWu3rS2H6RA1hlp12wbiK?=
 =?us-ascii?Q?SP5dvNDxVktbBOi3oPy55S2AD9fNi/kdsGQZmM1MuHuIouGiMgyJskr6l3A2?=
 =?us-ascii?Q?hA2ZbYP7O32obgtfgJyNh74ltgX8PcB0awRLlB5ErmwVrvt/NBJhthvvBB4T?=
 =?us-ascii?Q?VtHsz4fFZ85lreRF8+Pv8mtYAJCUKeIdkE/w7WERiz9jooOfKzZ+IAzsQsfs?=
 =?us-ascii?Q?W6jM5xlnhRp6aPLYBpEA+zL31iUNMgBSkVficOcWqZsLFC8rLoodi+8FV094?=
 =?us-ascii?Q?N5LPo00BeVykd4lgPcpj/IUDnmsY7kUH6pQ2Pi9A1WSP33m3yRU3M+zmswEt?=
 =?us-ascii?Q?QAxdRgFnOrzArH+V5+vDK52ycCLipbrX3gnj3evGKacoXe1OSZv7THv2YAFr?=
 =?us-ascii?Q?ppZIMqwsXrjFrfPv1w9KkgWD6r5gi7cFcgcuRbuARigpTNBvibd9EifaMBLe?=
 =?us-ascii?Q?KQveCz9A1xCwOifQAzWxBSL2Xkho/Fr5SF0GmPvMWaiV9ZaLGb96H8MkxnHq?=
 =?us-ascii?Q?Miolv8uWfZUs5F3ZZQj4YCdaiAw2HNk4KducmBbRHyswzSoPB8fr71US8oj9?=
 =?us-ascii?Q?4zFQBqcZdEAMYaRwwOQeeKvfq8GPca5gTyD2dQITt04eGYOabTeIWKvIgsgQ?=
 =?us-ascii?Q?YXXMhrJR9+luw2DuB+Y/8gBSM+aYMgHjFhpu94OJRp6XjDDWGJGNB5HdEGAV?=
 =?us-ascii?Q?HBR+H4Dcji0tB3hMJjJWaDJDQSympE1KZ+tnX2C2foOVLtHl1/1grDkyHlfk?=
 =?us-ascii?Q?wkF2kGRSfZuVhT30/ESpnhGPsuwjHk74/u+llUmMIVdee9Htq4QZ8n9kV+Mw?=
 =?us-ascii?Q?yfZ6cLRnfwnQwDPGwjOxCeWX5OxmcFZyxT3Ivlx/Vi8gGQ6xwj8k8OVcn0Hw?=
 =?us-ascii?Q?dAsaBoq5LAzaagq3N0Z4+7PXWLkgNx4qJjhERrYOgJkcRlhX5JZfXMV/6FE1?=
 =?us-ascii?Q?0VCYFoiwE5WroGo7WSLTn0w3rskiCXDB9+mHgiKh9gAOKNxJ+RKSntZZIouF?=
 =?us-ascii?Q?XDXsoIypTeWyz6nnHHkPIlTXoc4Ao07CTXXCJ8NN7FKOSjFAo9cWSaedoc6A?=
 =?us-ascii?Q?Am5XnKgQDxMZ3AA2R19NjEiBJzfqPKVGaCi/83pL7kp5GdWkMgyquH0oJrlI?=
 =?us-ascii?Q?mv9cPROClZPb+T/P4CtfN9OXdLRrM1j5YoSUMJB8s9WAMlJH57GQcBc0FWWM?=
 =?us-ascii?Q?aYw3/KzjsPmkSoRhbNIJAKmnBOfSa4LoBlJWEbLsWt/XSBJFzcg/juGqoULM?=
 =?us-ascii?Q?xHcfsk00nidDCfsEX8xx63UQrtci2J7QUPwAU26mXsaq5/oxk9YPfsKQMPSu?=
 =?us-ascii?Q?j/lo4REQCghJiha5d0Gt4zeqbc3grBk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7512bc60-16a5-43c6-fe29-08da3323bedb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:56:24.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uGqNPREQ+uP5aIxW8+zu8YNnYdgi3RNrV8xVvvLB68QCMGxrK+3G0yxrkKUKC35LU89BPSomyttRrGIguVoNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4461

v2:
 - drop "bpf: expose is_mptcp flag to bpf_tcp_sock" (Martin & Andrii)
 - patch 3, use is_mptcp in tcp_sock, instead of bpf_tcp_sock (Martin & And=
rii)

base-commit: bcf89bc9c28e ("DO-NOT-MERGE: git markup: features
net-next-next") on export/20220510T054929

v1:
 - drop bpf_mptcp_helpers.h (Andrii)
 - patch 6, skip the test if 'ip mptcp monitor' is not supported (Mat)

Geliang Tang (13):
  bpf: add bpf_skc_to_mptcp_sock_proto
  selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
  selftests/bpf: test bpf_skc_to_mptcp_sock
  selftests/bpf: verify token of struct mptcp_sock
  selftests/bpf: verify ca_name of struct mptcp_sock
  selftests/bpf: verify first of struct mptcp_sock
  mptcp: add struct mptcp_sched_ops
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrappers
  mptcp: add bpf_mptcp_sched_ops
  selftests/bpf: add bpf_first scheduler
  selftests/bpf: add bpf_first test

Nicolas Rybowski (1):
  selftests/bpf: add MPTCP test base

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 MAINTAINERS                                   |   1 +
 include/linux/bpf.h                           |   1 +
 include/linux/btf_ids.h                       |   3 +-
 include/net/mptcp.h                           |  25 ++
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 kernel/bpf/verifier.c                         |   1 +
 kernel/trace/bpf_trace.c                      |   2 +
 net/core/filter.c                             |  18 +
 net/mptcp/Makefile                            |   4 +-
 net/mptcp/bpf.c                               | 175 ++++++++
 net/mptcp/ctrl.c                              |  14 +
 net/mptcp/protocol.c                          |  32 +-
 net/mptcp/protocol.h                          |  12 +
 net/mptcp/sched.c                             | 141 +++++++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  32 ++
 tools/testing/selftests/bpf/config            |   3 +
 tools/testing/selftests/bpf/network_helpers.c |  43 +-
 tools/testing/selftests/bpf/network_helpers.h |   4 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 378 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  32 ++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  82 ++++
 25 files changed, 1002 insertions(+), 29 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c

--=20
2.34.1


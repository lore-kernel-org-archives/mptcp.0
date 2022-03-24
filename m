Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E51FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648128512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CAEf5+Q2iqZqBlIBVDilcwNMFm2Dt7hTYVZY2J1D39Q=;
	b=gl8G/Br7BNvZa/Q7ExjqkHlOUmJuT2ccCwl19S0rbJK4rbkENQ8zHkp4WzoprXjsleUlPa
	W649+1NMSKvxHXipX3jXM0n8o+voDiiThaRH6AfOB3tdeFCxd+4wLWm35cGENG3dwqjk81
	22noG7iS0GtIDyMRpglUVAg9Y0at0zA=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-kV9s7ukqMOKW54O0q1eyLw-1; Thu, 24 Mar 2022 14:28:31 +0100
X-MC-Unique: kV9s7ukqMOKW54O0q1eyLw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUlAlawjrmmG9m+TDUt4DfLajznSdjw4PcsYeaecZsE0pcaCZRUT2kxUfY8M5nbdOsRMK37u+GwAkY7DZ3n2+/XN4m39xsXCMoi20u1oTmOKweM1vHCm1+mm+X5ZTmKYmg4IAFQD4/FYdRqMo8fuoD2j7UYlAfDPTL9VWlgHyHtva9C8EfAl+krNzR47ITWPtkTP611N2j4wuBOuZFIQWza8OwK5U/WkmHz+4oyu7NWkW4AiO67F5SkO7tdgRATaSVm8tPjxhEAQHe23Y0vMUIBHM0SKQlTewghInu++7du0ok+Mdc295shJZZhHq9d5Pg6+KjoxGTv2SblkrzLHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjuIZsjIJtcinxhrU20r/e59aDT7c7pqRa3FP3+d5SA=;
 b=bBPJ542L/nrOQaCzRsmwPJP6cLlE285oq+0pDFJ+m1TJRxonTVUOwPb3YCZpSH7iMGoR+fhuKJUc33FD5Gl+F/6PRd3z85nb45aAXld69PznosrIOfNyLj1F7EsGEsG7OboxNQyHrS3AlJaudv9VP41L+ZwdxOUu5SOm2Ub7QjEKPSrDb/PCzYNlDxOzhtH+XAWz82t/5LJ9aMqpNXX/FxfrrvFZj+yI6aMOeQvM8u288O31PcbkJ2c7lXbh6kSkTI7hq5XGY87xDi6ytsLEAakG/+wLukP/SL4EizOqxnxInm4DErawktCuER5mlc01y3l4LhgPV9haX4f4UdDXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7754.eurprd04.prod.outlook.com (2603:10a6:10:1ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 13:28:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 13:28:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 0/5] add skc_to_mptcp_sock
Date: Thu, 24 Mar 2022 21:28:27 +0800
Message-ID: <cover.1648128255.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61d2e225-6cc5-4f0d-9e27-08da0d9a2ed0
X-MS-TrafficTypeDiagnostic: DBBPR04MB7754:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB775473A190B15631391A3393F8199@DBBPR04MB7754.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xrHxvzV6A4+c4TwL+C+yOHJgFroyQowAo5HM7T/otJgpogkHaNFUJvpx6Dptfu2IZSuO/e042Z+iPvvAftxi+rjzLyInBBW7R8/lFVkTiVjtfpV/9ydhW4fuzjKZv5iT6LI0djHEyZblwdgSRi2UePqn08VCjocbLMKVNZ6jNYz/QJdQCm1vbkm63kbRA8WXmbIjEOsErWuoH/eIuBnNtiu8MYd5rOsFJ6zASrPOVbrRKf5lR/PsQK46OIZJX7vOmbI7XQ/af1i1MuaEUNdVEa7Of9q+FJlRvqC1OySRBld5RJJEWI0yd5gZoFZPSdXTuO44L2z79/M+cPumy3SADGW6AHR4qTO0r+qQQ4UwMN7Vc3YYgkhUXkmMJt0z9xC1TZpBgI1cFPA+JJII2LHFsSGxexjHCYVsui3QzYeNLvIwgUC++69WdLhADk+cIsnLVw+DAC0kTo66esO8tvXPvmSSOVHBcjj+Htp34WGDCxQ2DBtAegU6UzeXkPtSDWsbivTUmbaH7HHWsniFx2iQeVqvTdG+FkTOqR7viWizpdE/cnZPIHNz6IqJdjAy+PeI/b1z5ii72IRNFDMABGoMFDCRTLt+EETGAMDbtYYqH/SGOrezYKQmhZEyarCOe9XuQM4mEL8m6KU47m9NNOuvHtyzyTEwUnwLHY0hr+Pi9Y94iLwBCVgGFds1ZvqMJKRP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8676002)(508600001)(4326008)(66946007)(6486002)(6506007)(6512007)(8936002)(6916009)(107886003)(316002)(5660300002)(26005)(186003)(66476007)(66556008)(2616005)(83380400001)(38100700002)(44832011)(36756003)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UbUnMiu9FIIqCZbyJ39mFb4L2bAbJ+KCbSvK7dBILcwmM7f/P63CeVHMM6+U?=
 =?us-ascii?Q?TMqAWIjzvqVjoEzq39qskdOVoifDX5rK8YgK5HsIdCDxhoz0Q+NWkkZdGLaq?=
 =?us-ascii?Q?5llei2zkTxx0xqfeIj6w6ECWKX10+QLlZuUkZHBYDaknkRcW8smhRnfVo88M?=
 =?us-ascii?Q?QeCvEv6FL6u0cw6WIEAzyuWbj7usqfGdlk8kK181giuDjQU6WacC7yNw+3HR?=
 =?us-ascii?Q?wtMIfrM+AczpuG2bkmVLPS5wk2RWvGAAJLKPoOG/Lbpd1i8uynWkw6UtuMfV?=
 =?us-ascii?Q?HUWZjwD0Ab5wfQB0/yNDgbxeKFmGjHiJ1vei4nqXLqNZlXw2mkdr5AANou81?=
 =?us-ascii?Q?8gRORWAGWM+1MhsWBCsLoiNc5OxvY28Wr/UGKLbQmReffAt2EZ26SsoSVy1z?=
 =?us-ascii?Q?Y/RL1KUVankzJ3VG3R8fJVUxR8DHp4PNp5k20case0E8N4g2Ap6nnqO8i6yM?=
 =?us-ascii?Q?7ZPxoB3a2VC9mUdcvfWCr6p/87opUATcWMPPvp1NwdMZNDc+jgMiOsTakAEo?=
 =?us-ascii?Q?YAB/sK53Xu1qZkJVT5ZpQ+SxMfj6rQFsvEUpAY/7wHcOaHOXRUPVCD94ymWs?=
 =?us-ascii?Q?PjYpg1GOavJgn5nVYmSIV22lKWW4333JzaludLvEWlikzA3Drbf+jtV+ON4b?=
 =?us-ascii?Q?FSYeLi/dPmRRXe00kdRbKCqdsqtXsOolqrK8wKmQf1FA+krNbNemu9mWQdxf?=
 =?us-ascii?Q?Y0iLeJodp+9stwohB+GJjhCAJHPNNL0VmzcFhtJNv3IplMBa+zknArIEuxs+?=
 =?us-ascii?Q?Ik0IJa7uAp1Le8IgHOCBo1Usvd2sxeYvtg5qFjtkVWnpjUUMUC5namvb/971?=
 =?us-ascii?Q?qZ7rGLWttlkAc6rYAn3U5bGGxns9/ouHcSfbT/3E500MqELuQWpCADPB8xZa?=
 =?us-ascii?Q?qyHJDG03yukoZ8hWCMRLfBOZNd/ikh3tTZ3WxV8ig24aOqI4bf4qyebnBx3i?=
 =?us-ascii?Q?/y7/S0/A204HSojXHXJ7AapHrTKdXNITAff8ojsrEsGyGa8K7ocaLNOLAoml?=
 =?us-ascii?Q?EvgUum4a98hlxRPpaniAAX2CvSHZ5CGTCThdeJNH4gypW74Qfm3BPgRMIgOF?=
 =?us-ascii?Q?gqXXVX/qB9hIr4Yiqh7k0CKWjT0PP/MBL0puL5h7rJv3cNv9NQTMoxCHXbvw?=
 =?us-ascii?Q?Vn4pfShqgAsCRUadRgLqVIfqXRzcMpDbGKrz+aHKbtGEwlvU6S4iZDPb81s5?=
 =?us-ascii?Q?qIG8Uw7kcEx1IMAMGwtqstLW3heNr/hkJJnS05yejC0XjMtBuXRKWqJjk/VQ?=
 =?us-ascii?Q?Xj+/8J9JougO465XG3f2jC5zFDou6lfeJg9II3niRlS30H2YJhNuCqPb5VlK?=
 =?us-ascii?Q?0DNmAMBvRV0xRpL0bQsE2XQbVm2nvLFhkvxNJRzMpvR8NK6sGluRo9u+k9Ae?=
 =?us-ascii?Q?j5Gwr3JI84uzhWWPUOSWfb9lQS3a1m+Hpx/bv+MRdtoPBCHWfQ36UcJhtFzt?=
 =?us-ascii?Q?F4VjlnMUZ07cvVSzWiw6uB7k+9lItljHlSaAeZS32jyJl1q4z/DOmg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d2e225-6cc5-4f0d-9e27-08da0d9a2ed0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 13:28:29.2738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz7TVMoiCpIfkSi4UsMri2bJxTOXaOyyHt/MpsKUxEFoDl5B8+2ztK8er7h85DT8YEDcxPstUXXpn9iOSTEgPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7754

v12:
 patch 1:
  - merged the squash-to patch for v11.
  - rebased to export/20220324T054815.
 patch 2:
  - fix the libbpf 0.8 build error.
 patch 4:
  - use fgets instead of fread to get null terminated string.

v11:
 - merge "check more values from mptcp_sock" series into this series.
 - patch 2:
   - rebased.
 - patch 3:
   - rebased.
   - add 'Copyright' entry as Matt suggested in v9.
 - patch 4:
   - add test__start_subtest.
   - add some 'Copyright' entries.
 - patch 5:
   - change monitor_log_path to static
   - drop bpf_trace_printk()
 - patch 6:
   - use TCP_CA_NAME_MAX instead of strlen(val.ca_name) in strncmp().
   - use 'sysctl -b net.ipv4.tcp_congestion_control' to get ca_name.

v10:
 - merge the squash-to patch.
 - update patch 3 as Matt suggested.
 - add sync() in get_msk_token() before read().
 - add a comment for get_msk_token().
 - update subjects and commit logs.

v9:
 - update progs/mptcp.c in patch 4 and 5

v8:
 - update as Matt suggested.

v7:
 - parse msk token from the output of 'ip mptcp monitor'.
 - add Nicolas and Matt's SoB tags.

v6:
 - add skc_to_mptcp_sock helper and test

RESEND:
 - fix the CI Build Failure.
v5:
 - fix incorrect token value
 - verify the token in selftest

v4:
 - define bpf_mptcp_sock_proto as a static function, no longer export
   it in linux/bpf.h

v3:
 - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
 - add a new bpf_id BTF_SOCK_TYPE_MPTCP

v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.

Geliang Tang (5):
  bpf: add bpf_skc_to_mptcp_sock_proto
  Squash to "selftests: bpf: add MPTCP test base"
  selftests: bpf: test bpf_skc_to_mptcp_sock
  selftests: bpf: verify ca_name of struct mptcp_sock
  selftests: bpf: verify first subflow of mptcp_sock

 include/linux/bpf.h                           |   9 +
 include/linux/btf_ids.h                       |   3 +-
 include/uapi/linux/bpf.h                      |   7 +
 net/core/filter.c                             |  18 ++
 net/mptcp/Makefile                            |   2 +
 net/mptcp/bpf.c                               |  22 ++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 192 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcp.c     |  44 +++-
 11 files changed, 284 insertions(+), 34 deletions(-)
 create mode 100644 net/mptcp/bpf.c

--=20
2.34.1


Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445BA3D
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648026581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=69ZUHgi1LnasktaE0k+jGxSW8chsNIWBsXuX4i2CFHw=;
	b=SbvDjE2wOerczXdTa/m9nX6bQuhPrc9cwPUaNDY1xOjLgdwaY8Luxaf2eHtMiK2PNDS0YH
	JyIbnLqgE020r3Zh99H7m4dKY3oWsx/hHPXuIZz61+VyH2DaR4U3e/clWGeyHwg0gU9PMY
	dA9HCznOxurhbvb+lw+lvZMA+NNZ42c=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-v4CGgBS6OuWoEmRzYpIwjw-1; Wed, 23 Mar 2022 10:09:40 +0100
X-MC-Unique: v4CGgBS6OuWoEmRzYpIwjw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RN10XJo93KykCvjEYmVFbUJrSdmU2Os4Gdt9gZ87eX4XRbpA/f5yusITATezOFGE5G1F7polYNzjL42BSE2DuBllqHOxFOKgFE5ZLcS/e4424EVRwvyeVeanxoYJQPresIICXC1S/+WehI3mdn8S5hbxdRzeeAhnyBFSvuXIUolh4zoQdQVv+jX8Zdj6HL5F+xycmFspZPSxlapWpCcK8WCrNkdZkdbNjYY9kmAIGDqZ9CsmJPW2WW/LD+j1rseS9D9P+DtBEcbcKGEcdFgpoebgrBha4J0wtcANxcbjva4zXNOsO8U46bF+oz8dLeEaKG2H354Q57t/tB/HlJ7KjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amZYEwLRfLpr+8xJyAT5hplnCbsvddkTokxydl4VemQ=;
 b=BuW7jbhcASravoMUlUoNW7HaT66eneEgVH5ZC4dXHGZM06TKCRMSVJn/XRkv/7RAwb01o0d1NDsmC7gFbIu/498ZeN2qBcpADco9MJyahYTXeYpx21i5HsPrbkNj62VKrlNL2wfZk3J4WIv54BYIRN+SpH11tE3najp1SSGNoLQl5ARFH+aHbum5X5u4XP9sgbYksHn/bl37h88Io6jCamYhkRIZq/pGszQKAZT/Q89eoNKmkXRi0r/BkCAsN6FNiTPCZzWJKoxBU7ZW7vczZNtJQh9OhcKt27lqiheqLLvPwqntHWvunpKjCz/i3cg9TAYRamIcLkVYiquKYHegXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 09:09:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:09:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 0/7] add skc_to_mptcp_sock
Date: Wed, 23 Mar 2022 17:09:29 +0800
Message-ID: <cover.1648025307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20c3b8b0-c5cb-4a08-c7cf-08da0cacdb5f
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB77405EEDF8392B985BB45E87F8189@DBBPR04MB7740.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D/t9ECU9c3hWPpvAFTCtAFequSg46WfRrCglYTfh62O19O3jcy4MWtakYqaUNJdkI1own07fjUgxzhUGPqarPWn5WBsB8RIy9FYjDv8KYMAeLB025dbJmCGWnKWqTf16HbGZ87nliZ/arUiMhKpYXQdq6k8EDFWWnyHuc1D+AHQmloQ3X9CAsiN8n9El/ZaSEurezzgzIM2Hpgb8pPjGwZrR6YO+tUQ4GlWC7vG5HCeLZvz/rfOkaFGsmggOLU0/6HBfKboK2csNf4xbHL8b9jzIGVdmnQeDTga4Yc6D7uOdpUwDd5omJ0QdrIN62XK+bSNRhzdZ89bnRGiDzrm3KgzYpO2wOunRCciRmvHUQ/iYQ0ZunFXqgeQZNqJqBlTXnlfc/WGK5WevfUMsAcHgy+wNxzEPB6WA4Y8L8DbXJzanbCNk2V8NMvGU7bCmGSsTy5griK8l3f2a8WlW1+51d9YvhzyvYQUjeyVfuPaVZE8h2LjPdWw1mIxypjHsAlzILKqQSQXdpEudSezkBujAQla+dLc/xryduXbcMIF4p2FJl0Rnv2mr8YGkl2CQwNRP+NpxFWnLxx/o/bXMMNpRG/jx0YiS+AdqM8MiS6vR8YsD0tZjzoujRFrqFTgTlUFSiZEP6BwMxM0W5x2MmrsuIJzd0Hz2blvBQIytFIadGGT6pKQLWdPTcOSRQZJmuUQyxsH0bq+T3gPwgH95znZ50ZOQGLExKREOTERotJ7aV8HY/a6NhH27KWw5VXpsepnLRIwhRFZDAs5KmgWIRL58JA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6506007)(8676002)(66476007)(4326008)(66946007)(26005)(186003)(107886003)(44832011)(2616005)(8936002)(6512007)(5660300002)(66556008)(38100700002)(86362001)(83380400001)(6486002)(36756003)(508600001)(966005)(6666004)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4c5Y4OZ3pTdLCmDvpEBSwQPITGAxKdoCzxZU74L78Wf1i1G2EhDn/e/M0G6/?=
 =?us-ascii?Q?olcE0UUwNRWRu3PjtwaAt6IXFkgMohWFfikn/QrjzApEGZomASdLM+Pkye2F?=
 =?us-ascii?Q?881StMtSxNQgQcd2Apahz1kJkJN+GR3RrBXVWNel8yGU3XgL0OLnx05Y1y/P?=
 =?us-ascii?Q?bUvI0IBdtNJYlWasHAOPe/1b4tf1uiFBe8vKKtuA/Q8nkdFsVswMa6zYgfLY?=
 =?us-ascii?Q?Tgfi4BdFVJqHToh3gg/CtdFuNpx2U0uruwwyDLFaAlb/YqLNWhJMsOALtqZK?=
 =?us-ascii?Q?M/9bQU0XUGboHEFckFiBCiuViXAZMqQpRPVF/TU3bwYn0JH95CWqZ8POfu08?=
 =?us-ascii?Q?klP4ElankP81UXwQBBhSsM15ykwevY6/9x7o74NT/7aCv3s+8RnmN/NgqJr6?=
 =?us-ascii?Q?gv2IKlyhScGnJ4XvR/IuUuc6deWr7d7Rz3aVBOyX0gzYKFHDMNW6Ox6fIDOF?=
 =?us-ascii?Q?nTGQ/DYqvtX11SW1QTZW2ahV/OgQIh1xdzbrxSOKqNdauIsfQVAMDgyLYby3?=
 =?us-ascii?Q?vNlpBaVAww2xD/UlsHmpekwwVtGQm2cK7l/7fyli4j6G+vb+tMT6/8TKyTiE?=
 =?us-ascii?Q?B7mS5wV/yyWAltV1BiTrC3TkxzqV0PAZA/ycbsHSGB8K6GeVVT1unynFDsbr?=
 =?us-ascii?Q?QV5AJSFydK+XOlxO3jDft/XFaigPHLgc/yv1u3nXEAJ+6HsmC7T8eurD16tB?=
 =?us-ascii?Q?g4YqLFuyYoPVziGShSZVgtiG159VrN+XCxlC0kgBU1DcKE2SZiqnDYx3SDAJ?=
 =?us-ascii?Q?+ze/ZADjILlEPDoL1KCc6fB25LQ2QcJj2oEfA42OaebckyqWSPVVKNhMi0xr?=
 =?us-ascii?Q?krovGFA6UPgmWIuUi3B35TLMBLNZuiYXOfMRDROcsmJ5ZCmRF1S/zySbQswz?=
 =?us-ascii?Q?cIdMVeNOl7aHW+5hG/HoWJMcqlpXZwdT5yN1tosSecuzm56NMj6iubWAkwH3?=
 =?us-ascii?Q?cTRuseeiA735M8ttGB4doYzTtGqRKjMnYjvWaOoUym7KYfQuVuWIS1jyLX4b?=
 =?us-ascii?Q?HAJpYKWmilamVZHE9tp00H99hQDl97mfNIO3w3O/YHtjzTmGsUOfNXoltL5+?=
 =?us-ascii?Q?YsWl/w4iFmC/kxMzUyodheVHmFkkOozL+BHZazNa4g38hPh7C2+EReuCLZei?=
 =?us-ascii?Q?oO99ne1eNErYsbjWGbX5OUCL661EoVQhcjUOTGz1pHfaePdCZ1JVxOhGLCnx?=
 =?us-ascii?Q?2yd5AZ/Lyy6oOtLYKkFgOvX21+eqrzjgcnW5xiy1O+cbCLn/6EoDF+xl9YgR?=
 =?us-ascii?Q?A9pbRPb35yCGKU9gq99hzaEJh4jzRP+oe6GUXVmJTD4y7J2lRdphw/Abj9gr?=
 =?us-ascii?Q?qa0fGYEF0Vkv0bCKtKO9A4CL1tQa8mwSDgDxZQeBWbp4UurMlpQSlWJptG6Z?=
 =?us-ascii?Q?J8VqbSi6zVVbkTqKiKr44HiXYysmpIp9CI5PWk2SoVCBgdra0elHxjm61PV3?=
 =?us-ascii?Q?GwVpeXpse2FFzjQ1a/XHvUECVrBhNs3g5XeezfvTj5zuOjNd2l1GZw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c3b8b0-c5cb-4a08-c7cf-08da0cacdb5f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:09:38.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GY9Qr9DCKDlWSJmtxTpJGcj/74ZU/0iG5ZSQmei11xB2SeUCd5sdV9pl5TvKO3wEDPP8b7MyNkP3qw1LP+DJQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7740

v11:
 - merge "check more values from mptcp_sock" series into this series.
 - patch 2:
   - rebased.
 - patch 3:
   - rebased.
   - add 'Copyright' entry as Matt suggested in v9:
   https://patchwork.kernel.org/project/mptcp/patch/d6d33be9899118c5f542a6c=
e43f868d4e9e2766b.1646745228.git.geliang.tang@suse.com/
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

Geliang Tang (7):
  Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
  Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
  bpf: add bpf_skc_to_mptcp_sock_proto
  Squash to "selftests: bpf: add MPTCP test base"
  selftests: bpf: test bpf_skc_to_mptcp_sock
  selftests: bpf: verify ca_name of struct mptcp_sock
  selftests: bpf: verify first subflow of mptcp_sock

 include/linux/bpf.h                           |  31 +---
 include/linux/btf_ids.h                       |   3 +-
 include/uapi/linux/bpf.h                      |  14 +-
 kernel/bpf/verifier.c                         |  20 ---
 net/core/filter.c                             |  22 ++-
 net/mptcp/bpf.c                               |  64 +------
 scripts/bpf_doc.py                            |   4 +-
 tools/include/uapi/linux/bpf.h                |  14 +-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 159 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcp.c     |  44 ++++-
 tools/testing/selftests/bpf/verifier/sock.c   |  63 -------
 12 files changed, 229 insertions(+), 221 deletions(-)

--=20
2.34.1

